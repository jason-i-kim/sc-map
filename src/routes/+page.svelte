<script lang="ts">
	import LoginWithDiscord from '$lib/components/LoginWithDiscord.svelte';

	import PurplePattern from '$lib/assets/Purple_Pattern_-_Full_Res_-_Fixed.png';

	let { data } = $props();
</script>

<div class="container" style:background-image="url({PurplePattern})">
	<svg width="670" height="91" viewBox="0 0 670 91" xmlns="http://www.w3.org/2000/svg">
		<title id="svg-title">Salt Cellar Map</title>
		<defs>
			<path
				id="wave"
				d="M 46.900000000000006 71.89 C 133.33 83.89, 265.856 83.89, 335 71.89 C 404.144 59.89, 536.6700000000001 59.89, 623.1 71.89"
			/>
		</defs>
		<text
			font-family="'Arial Black', Impact, sans-serif"
			font-size="72"
			font-weight="900"
			stroke="#000000"
			stroke-width="17"
			stroke-linejoin="round"
			fill="none"
			paint-order="stroke"
		>
			<textPath href="#wave" startOffset="50%" text-anchor="middle">Salt Cellar Map</textPath>
		</text>
		<text
			font-family="'Arial Black', Impact, sans-serif"
			font-size="72"
			font-weight="900"
			fill="#ffffff"
		>
			<textPath href="#wave" startOffset="50%" text-anchor="middle">Salt Cellar Map</textPath>
		</text>
	</svg>
	{#if !data.user}
		<LoginWithDiscord />
	{:else if !data.user.is_current_server_member && !data.user.has_lifetime_access}
		<p>Looks like you've left the Salt Cellar! We're sorry to see you go 😭</p>
	{/if}
</div>

<style>
	.container {
		background-size: cover;
		background-position: center;
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		height: 100vh;
		gap: 2rem;
	}
</style>
