<script lang="ts">
	import { PUBLIC_DISCORD_CLIENT_ID } from '$env/static/public';
	import { page } from '$app/state';
	import DiscordIcon from '$lib/icons/DiscordIcon.svelte';
	function discordAuthUrl(): string {
		const url = new URL('https://discord.com/oauth2/authorize');
		url.searchParams.set('client_id', PUBLIC_DISCORD_CLIENT_ID);
		url.searchParams.set('redirect_uri', `${page.url.origin}/auth/discord/callback`);
		url.searchParams.set('response_type', 'code');
		url.searchParams.set('scope', 'guilds.members.read+identify');
		return url.toString();
	}
</script>

<div class="container">
	<a href={discordAuthUrl()} rel="external" class="login-button">
		<span class="discord-icon"><DiscordIcon /></span>

		<span>Continue with Discord</span>
	</a>
</div>

<style>
	.container {
		display: flex;
		align-items: center;
		justify-content: center;
		min-height: 100vh;
		background-color: #f3f4f6;
	}

	.login-button {
		display: flex;
		align-items: center;
		background-color: #ffffff;
		border: 1px solid #d1d5db;
		border-radius: 0.5rem;
		box-shadow:
			0 4px 6px -1px rgba(0, 0, 0, 0.1),
			0 2px 4px -1px rgba(0, 0, 0, 0.06);
		padding: 0.5rem 1.5rem;
		font-size: 0.875rem;
		font-weight: 500;
		color: #1f2937;
		cursor: pointer;
		transition: background-color 0.15s;
	}

	.login-button:hover {
		background-color: #e5e7eb;
	}

	.login-button:focus {
		outline: none;
		box-shadow: 0 0 0 3px rgba(107, 114, 128, 0.5);
	}

	.discord-icon {
		display: flex;
		width: 1.5rem;
		height: 1.5rem;
		margin-right: 0.5rem;
	}
</style>
