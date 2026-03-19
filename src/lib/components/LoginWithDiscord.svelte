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
		background-color: var(--color-surface-page);
	}

	.login-button {
		display: flex;
		align-items: center;
		background-color: var(--color-surface);
		border: 1px solid var(--color-outline-login);
		border-radius: var(--radius-md);
		box-shadow: var(--shadow-button);
		padding: var(--space-2) var(--space-6);
		font-size: var(--text-md);
		font-weight: 500;
		color: var(--color-login-text);
		cursor: pointer;
		transition: background-color var(--duration-fast);
	}

	.login-button:hover {
		background-color: var(--color-login-hover);
	}

	.login-button:focus {
		outline: none;
		box-shadow: var(--shadow-focus-ring);
	}

	.discord-icon {
		display: flex;
		width: 1.5rem;
		height: 1.5rem;
		margin-right: var(--space-2);
	}
</style>
