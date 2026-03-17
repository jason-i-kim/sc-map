<script lang="ts">
	import LoginWithDiscord from '$lib/components/LoginWithDiscord.svelte';

	let { data } = $props();
</script>

<div class="container">
	<h1>Salt Cellar Map</h1>
	{#if data.user}
		<p>Welcome, {data.user.discord_handle}</p>
	{:else}
		<LoginWithDiscord />
	{/if}
</div>
