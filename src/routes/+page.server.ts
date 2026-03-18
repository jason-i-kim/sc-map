import { redirect } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';

export const load: PageServerLoad = async ({ parent }) => {
	const { user } = await parent();
	if (user && (user.has_lifetime_access || user.is_current_server_member)) {
		redirect(302, '/map');
	}
};
