<script lang="ts">
	import { onMount } from 'svelte';
	import { setOptions, importLibrary } from '@googlemaps/js-api-loader';
	import { PUBLIC_GOOGLE_MAPS_API_KEY } from '$env/static/public';

	let mapEl: HTMLDivElement;

	onMount(async () => {
		setOptions({ key: PUBLIC_GOOGLE_MAPS_API_KEY });

		const { Map } = await importLibrary('maps');

		new Map(mapEl, {
			center: { lat: 39.5, lng: -98.35 },
			zoom: 4,
			mapId: 'sc-map',
			mapTypeControl: false,
			streetViewControl: false,
			fullscreenControl: false
		});
	});
</script>

<div bind:this={mapEl} style="width: 100%; height: 100vh;"></div>
