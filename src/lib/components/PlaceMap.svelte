<script lang="ts">
	import { onMount } from 'svelte';
	import { setOptions, importLibrary } from '@googlemaps/js-api-loader';
	import type { Place } from '$lib/dao/places/types';
	import PlaceMarker from './PlaceMarker.svelte';
	import SearchBar from './SearchBar.svelte';
	import type { CategoryConfig } from './types';
	import { PUBLIC_GOOGLE_MAPS_API_KEY } from '$env/static/public';

	type Category = Place['type'];

	const CATEGORIES: Record<Category, CategoryConfig> = {
		RESTAURANT: {
			label: 'Restaurants',
			color: '#E8472A',
			glyphText: '🍽️'
		},
		BAR: {
			label: 'Bars',
			color: '#6B4FBB',
			glyphText: '🍸'
		},
		BAKERY: {
			label: 'Bakeries',
			color: '#F0A500',
			glyphText: '🥐'
		}
	};

	let { places, onplaceclick }: { places: Place[]; onplaceclick: (place: Place) => void } =
		$props();

	let mapEl: HTMLDivElement;
	let map: google.maps.Map | null = $state(null);

	onMount(async () => {
		setOptions({ key: PUBLIC_GOOGLE_MAPS_API_KEY });

		const { Map } = await importLibrary('maps');

		map = new Map(mapEl, {
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
<SearchBar placeholder="Search for something yummy" />

{#if map}
	{#each places as place (place.id)}
		<PlaceMarker
			{map}
			{place}
			visible={true}
			onclick={onplaceclick}
			categoryConfig={CATEGORIES[place.type]}
		/>
	{/each}
{/if}
