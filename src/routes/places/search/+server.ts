import { PlacesDao } from '$lib/dao/places';
import { sql } from '$lib/db';
import type { RequestHandler } from '@sveltejs/kit';

export const GET: RequestHandler = async ({ url }) => {
	const q = url.searchParams.get('q');
	if (!q) {
		return new Response(JSON.stringify([]), {
			headers: { 'Content-Type': 'application/json' }
		});
	}

	const placesDao = new PlacesDao(sql);
	const places = await placesDao.searchPlaces(q);

	return new Response(JSON.stringify(places), {
		headers: { 'Content-Type': 'application/json' }
	});
};
