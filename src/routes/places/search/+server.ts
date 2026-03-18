import { PlacesDao } from '$lib/dao/places';
import type { Place } from '$lib/dao/places/types';
import { sql } from '$lib/db';
import { searchGooglePlaces, type GooglePlaceResult } from '$lib/server/google-places';
import type { RequestHandler } from '@sveltejs/kit';

type GoogleSuggestion = {
	source: 'google';
	data: GooglePlaceResult;
};

type DBSuggestion = {
	source: 'db';
	data: Place;
};

export type Suggestion = GoogleSuggestion | DBSuggestion;

export const GET: RequestHandler = async ({ url }) => {
	const q = url.searchParams.get('q');
	if (!q) {
		return new Response(JSON.stringify([]), {
			headers: { 'Content-Type': 'application/json' }
		});
	}

	const placesDao = new PlacesDao(sql);
	const [dbResults, ...googleResultsByType] = await Promise.all([
		placesDao.searchPlaces(q),
		searchGooglePlaces(q, 'bar'),
		searchGooglePlaces(q, 'restaurant'),
		searchGooglePlaces(q, 'bakery')
	]);

	const seen = new Set<string>();
	const googleResults = googleResultsByType.flat().filter((r) => {
		if (seen.has(r.place_id)) return false;
		seen.add(r.place_id);
		return true;
	});

	const dbPlaceIds = new Set(dbResults.map((p) => p.google_place_id));
	const uniqueGoogleResults = googleResults.filter((r) => !dbPlaceIds.has(r.place_id));

	const combined: Suggestion[] = [
		...dbResults.map((p) => ({ source: 'db' as const, data: p })),
		...uniqueGoogleResults.map((r) => ({ source: 'google' as const, data: r }))
	];

	return new Response(JSON.stringify(combined), {
		headers: { 'Content-Type': 'application/json' }
	});
};
