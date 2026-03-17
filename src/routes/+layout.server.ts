import type { LayoutServerLoad } from './$types';
import { SESSION_SECRET } from '$env/static/private';
import { sql } from '$lib/db';
import { UsersDao, UserNotFoundError } from '$lib/dao/users';
import type { User } from '$lib/dao/users/types';

const usersDao = new UsersDao(sql);

async function verifySessionCookie(cookie: string): Promise<bigint | null> {
	const dot = cookie.lastIndexOf('.');
	if (dot === -1) return null;

	const payload = cookie.slice(0, dot);
	const sigB64 = cookie.slice(dot + 1);

	const encoder = new TextEncoder();
	const key = await crypto.subtle.importKey(
		'raw',
		encoder.encode(SESSION_SECRET),
		{ name: 'HMAC', hash: 'SHA-256' },
		false,
		['verify']
	);

	const sig = Buffer.from(sigB64, 'base64');

	const valid = await crypto.subtle.verify('HMAC', key, sig, encoder.encode(payload));
	if (!valid) return null;

	try {
		return BigInt(payload);
	} catch {
		return null;
	}
}

export const load: LayoutServerLoad = async ({ cookies }): Promise<{ user: User | null }> => {
	const cookie = cookies.get('session');
	if (!cookie) return { user: null };

	const userId = await verifySessionCookie(cookie);
	if (!userId) return { user: null };

	try {
		return { user: await usersDao.retrieveUser(userId) };
	} catch (e) {
		if (e instanceof UserNotFoundError) return { user: null };
		throw e;
	}
};
