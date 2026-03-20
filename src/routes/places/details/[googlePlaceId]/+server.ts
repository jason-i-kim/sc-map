import { getPlaceDetails } from '$lib/server/google-places';
import { jsonResponse } from '$lib/server/response';
import type { RequestHandler } from '@sveltejs/kit';

export const GET: RequestHandler = async ({ params }) => {
	const details = await getPlaceDetails(params.googlePlaceId!);
	return jsonResponse(details);
};
