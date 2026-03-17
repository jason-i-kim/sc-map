import { redirect } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { PUBLIC_DISCORD_CLIENT_ID } from '$env/static/public';
import { DISCORD_CLIENT_SECRET, DISCORD_REDIRECT_URI, SESSION_SECRET } from '$env/static/private';
import { sql } from '$lib/db';
import { UsersDao } from '$lib/dao/users';
import { z } from 'zod';

const TokenResponseSchema = z.object({
	access_token: z.string(),
	token_type: z.string(),
	scope: z.string()
});

const DiscordUserSchema = z.object({
	id: z.string(),
	username: z.string(),
	discriminator: z.string()
});

const usersDao = new UsersDao(sql);

async function createSessionCookie(userId: bigint): Promise<string> {
	const payload = String(userId);
	const encoder = new TextEncoder();
	const key = await crypto.subtle.importKey(
		'raw',
		encoder.encode(SESSION_SECRET),
		{ name: 'HMAC', hash: 'SHA-256' },
		false,
		['sign']
	);
	const signature = await crypto.subtle.sign('HMAC', key, encoder.encode(payload));
	const sigB64 = Buffer.from(signature).toString('base64');
	return `${payload}.${sigB64}`;
}

export const GET: RequestHandler = async ({ url, cookies }) => {
	const code = url.searchParams.get('code');
	if (!code) redirect(303, '/');

	const tokenRes = await fetch('https://discord.com/api/oauth2/token', {
		method: 'POST',
		headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
		body: new URLSearchParams({
			client_id: PUBLIC_DISCORD_CLIENT_ID,
			client_secret: DISCORD_CLIENT_SECRET,
			grant_type: 'authorization_code',
			code,
			redirect_uri: DISCORD_REDIRECT_URI
		})
	});
	if (!tokenRes.ok) {
		redirect(303, '/?error=token_exchange_failed');
	}

	const token = TokenResponseSchema.parse(await tokenRes.json());

	const meRes = await fetch('https://discord.com/api/users/@me', {
		headers: { Authorization: `${token.token_type} ${token.access_token}` }
	});
	if (!meRes.ok) redirect(303, '/?error=user_fetch_failed');

	const discordUser = DiscordUserSchema.parse(await meRes.json());
	const handle =
		discordUser.discriminator === '0'
			? discordUser.username
			: `${discordUser.username}#${discordUser.discriminator}`;

	let user = await usersDao.findByDiscordId(discordUser.id);
	if (!user) {
		user = await usersDao.insertUser({
			discord_id: discordUser.id,
			discord_handle: handle,
			google_id: null,
			has_lifetime_access: false,
			is_current_server_member: false
		});
		console.log('user created', user);
	} else if (user.discord_handle !== handle) {
		user = await usersDao.updateUser(user.id, { discord_handle: handle });
		console.log('user updated', user);
	}

	const sessionToken = await createSessionCookie(user.id);
	cookies.set('session', sessionToken, {
		path: '/',
		httpOnly: true,
		sameSite: 'lax',
		maxAge: 60 * 60 * 24 * 30
	});

	redirect(303, '/');
};
