import { fail } from '@sveltejs/kit';
import { sql } from '$lib/db';
import { SavedPlacesDao } from '$lib/server/dao/saved-places';
import { VisitNotFoundError, VisitsDao } from '$lib/server/dao/visits';
import { getGooglePlaceById } from '$lib/google-places';
import { SavedPlaceSchema, type SavedPlace } from '$lib/schemas/saved-place';
import { verifySessionCookie, SESSION_COOKIE_NAME } from '$lib/server/cookie';
import { VisitInsertSchema, VisitUpdateSchema } from '$lib/server/dao/visits/types.js';

const VisitInsertWithoutPlaceSchema = VisitInsertSchema.omit({ place_id: true });
const VisitUpdateWithoutPlaceSchema = VisitUpdateSchema.omit({ place_id: true });

const savedPlacesDao = new SavedPlacesDao(sql);
const visitsDao = new VisitsDao(sql);

const isSavedPlaceType = (value: string): value is SavedPlace['type'] => {
	return value === 'RESTAURANT' || value === 'BAKERY' || value === 'BAR';
};

export const actions = {
	addVisit: async ({ request, cookies }) => {
		const cookie = cookies.get(SESSION_COOKIE_NAME);
		if (!cookie) return fail(401, { error: 'Unauthorized' });

		const userId = await verifySessionCookie(cookie);
		if (!userId) return fail(401, { error: 'Unauthorized' });

		const data = await request.formData();
		const googlePlaceId = data.get('googlePlaceId')?.toString();
		if (!googlePlaceId) return fail(400, { error: 'Missing googlePlaceId' });
		const selectedType = data.get('selectedType')?.toString();
		if (!selectedType) {
			return fail(400, { error: 'Missing selectedType' });
		}
		if (!isSavedPlaceType(selectedType)) {
			return fail(400, { error: 'Received selectedType value was invalid.' });
		}

		const parseResult = VisitInsertWithoutPlaceSchema.safeParse({
			user_id: userId,
			summary: data.get('review')?.toString(),
			rating: data.get('rating')?.toString(),
			visited_at: data.get('visitDate')?.toString() ?? new Date().toISOString().split('T')[0]
		});

		if (!parseResult.success) {
			return fail(400, { error: parseResult.error.issues[0]?.message ?? 'Invalid input' });
		}

		await sql.begin(async (tx) => {
			const [existing] = await tx`
				SELECT * FROM saved_places WHERE google_place_id = ${googlePlaceId}
			`;

			let placeId: bigint;
			if (existing) {
				placeId = SavedPlaceSchema.parse(existing).id;
			} else {
				const googlePlace = await getGooglePlaceById(googlePlaceId);
				if (!googlePlace) throw new Error(`Google place not found: ${googlePlaceId}`);

				const place = await savedPlacesDao.insertSavedPlace(
					{
						name: googlePlace.name,
						lat: googlePlace.geometry.location.lat,
						lng: googlePlace.geometry.location.lng,
						formatted_address: googlePlace.formatted_address,
						google_place_id: googlePlace.place_id,
						type: selectedType,
						submitted_by: userId
					},
					tx
				);
				placeId = place.id;
			}

			await visitsDao.insertVisit({ ...parseResult.data, place_id: placeId }, tx);
		});

		return { success: true };
	},

	updateVisit: async ({ request, cookies }) => {
		const cookie = cookies.get(SESSION_COOKIE_NAME);
		if (!cookie) return fail(401, { error: 'Unauthorized' });

		const userId = await verifySessionCookie(cookie);
		if (!userId) return fail(401, { error: 'Unauthorized' });

		const data = await request.formData();
		const visitId = data.get('visitId')?.toString();
		if (!visitId) {
			return fail(400, { error: 'A visit ID is required.' });
		}

		try {
			const oldVisit = await visitsDao.retrieveVisit(BigInt(visitId));

			if (oldVisit.user_id !== userId) {
				return fail(400, { error: 'Unauthorized' });
			}
		} catch (error) {
			if (error instanceof VisitNotFoundError) {
				return fail(404, { error: 'Visit not found.' });
			}
		}

		const parseResult = VisitUpdateWithoutPlaceSchema.safeParse({
			user_id: userId,
			summary: data.get('rating')?.toString(),
			rating: data.get('rating')?.toString(),
			visited_at: data.get('visitDate')?.toString()
		});

		if (!parseResult.success) {
			return fail(400, { error: parseResult.error.issues[0]?.message ?? 'Invalid input' });
		}

		await visitsDao.updateVisit(BigInt(visitId), parseResult.data);
	}
};
