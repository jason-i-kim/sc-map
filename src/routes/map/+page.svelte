<script lang="ts">
	import FilterChips from '$lib/components/FilterChips.svelte';
	import PlaceMap from '$lib/components/PlaceMap.svelte';
	import SearchBar from '$lib/components/search/SearchBar.svelte';
	import SideDrawer from '$lib/components/SideDrawer.svelte';
	import { CATEGORIES } from '$lib/categories';
	import type { Place } from '$lib/dao/places/types.js';
	import type { Suggestion } from '$lib/schemas/search';
	// import { createMutation } from '@tanstack/svelte-query';
	// import { addPlaceOptions } from '$lib/queries';
	// import { invalidateAll } from '$app/navigation';

	let { data } = $props();

	let activeFilter = $state<Place['type'] | null>(null);
	let selectedPlace = $state<{
		lat: number;
		lng: number;
		name: string;
		placeId: string;
		address?: string;
	} | null>(null);
	let drawerOpen = $state(false);

	let filteredPlaces = $derived(
		activeFilter ? data.places.filter((place) => place.type === activeFilter) : data.places
	);

	function handleSuggestionClick(suggestion: Suggestion) {
		if (suggestion.source === 'db') {
			selectedPlace = {
				lat: suggestion.data.lat,
				lng: suggestion.data.lng,
				name: suggestion.data.name,
				placeId: suggestion.data.google_place_id,
				address: suggestion.data.formatted_address
			};
			drawerOpen = true;
		} else {
			selectedPlace = {
				lat: suggestion.data.geometry.location.lat,
				lng: suggestion.data.geometry.location.lng,
				name: suggestion.data.name,
				placeId: suggestion.data.place_id,
				address: suggestion.data.formatted_address
			};
		}
	}

	function handleAddToList() {
		drawerOpen = true;
	}
</script>

<PlaceMap
	categories={CATEGORIES}
	places={filteredPlaces}
	onplaceclick={(place) => {
		selectedPlace = {
			lat: place.lat,
			lng: place.lng,
			name: place.name,
			placeId: place.google_place_id,
			address: place.formatted_address
		};
		drawerOpen = true;
	}}
	{selectedPlace}
	onmapclick={() => {
		selectedPlace = null;
		drawerOpen = false;
	}}
	onaddtolist={handleAddToList}
/>
<SideDrawer bind:open={drawerOpen} title={selectedPlace?.name ?? ''} width="396px">
	{#if selectedPlace}
		<div class="place-details">
			<p class="place-type">
				{data.places.find((p) => p.google_place_id === selectedPlace?.placeId)?.type ?? 'Place'}
			</p>
			<p class="place-address">{selectedPlace.address}</p>
		</div>
	{/if}
</SideDrawer>
<div class="controls">
	<SearchBar placeholder="Search for something yummy" onsuggestionclick={handleSuggestionClick} />
	<FilterChips
		filters={CATEGORIES}
		{activeFilter}
		onchange={(newFilter) => (activeFilter = newFilter)}
	/>
</div>

<style>
	.controls {
		position: fixed;
		display: flex;
		flex-direction: row;
		top: 10px;
		left: 10px;
		z-index: 100;
		gap: 8px;
	}

	@media (max-width: 600px) {
		.controls {
			flex-direction: column;
			gap: 8px;
		}
	}

	.place-details {
		padding: 20px;
	}

	.place-type {
		font-size: 14px;
		font-weight: 500;
		color: var(--gm-primary, #1a73e8);
		text-transform: uppercase;
		letter-spacing: 0.5px;
		margin: 0 0 8px 0;
	}

	.place-address {
		font-size: 14px;
		color: var(--gm-on-surface-variant, #5f6368);
		margin: 0;
		line-height: 1.5;
	}
</style>
