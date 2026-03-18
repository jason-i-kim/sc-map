<script lang="ts">
	import FilterChips from '$lib/components/FilterChips.svelte';
	import PlaceMap from '$lib/components/PlaceMap.svelte';
	import SearchBar from '$lib/components/search/SearchBar.svelte';
	import SideDrawer from '$lib/components/SideDrawer.svelte';
	import { CATEGORIES } from '$lib/categories';
	import type { Place } from '$lib/dao/places/types.js';
	import { isPlace, type SearchResult } from '$lib/schemas/search';
	// import { createMutation } from '@tanstack/svelte-SearchResultrt { addPlaceOptions } from '$lib/queries';
	// import { invalidateAll } from '$app/navigation';

	let { data } = $props();

	let activeFilter = $state<Place['type'] | null>(null);
	let selectedLocation = $state<{
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

	function handleLocationClick(searchResult: SearchResult) {
		selectedLocation = {
			lat: searchResult.lat,
			lng: searchResult.lng,
			name: searchResult.name,
			placeId: searchResult.google_place_id,
			address: searchResult.formatted_address
		};

		if (isPlace(searchResult)) {
			drawerOpen = true;
		}
	}

	function handleAddToList() {
		drawerOpen = true;
	}
</script>

<PlaceMap
	categories={CATEGORIES}
	places={filteredPlaces}
	onplaceclick={handleLocationClick}
	selectedPlace={selectedLocation}
	onmapclick={() => {
		selectedLocation = null;
		drawerOpen = false;
	}}
	onaddtolist={handleAddToList}
/>
<SideDrawer bind:open={drawerOpen} title={selectedLocation?.name ?? ''} width="396px">
	{#if selectedLocation}
		<div class="place-details">
			<p class="place-type">
				{data.places.find((p) => p.google_place_id === selectedLocation?.placeId)?.type ?? 'Place'}
			</p>
			<p class="place-address">{selectedLocation.address}</p>
		</div>
	{/if}
</SideDrawer>
<div class="controls">
	<SearchBar placeholder="Search for something yummy" onsearchresultclick={handleLocationClick} />
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
