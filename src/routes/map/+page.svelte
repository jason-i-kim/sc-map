<script lang="ts">
	import FilterChips from '$lib/components/FilterChips.svelte';
	import PlaceMap from '$lib/components/PlaceMap.svelte';
	import SearchBar from '$lib/components/search/SearchBar.svelte';
	import type { CategoryConfig } from '$lib/components/types.js';
	import type { Place } from '$lib/dao/places/types.js';
	import FilterBakeryIcon from '$lib/icons/FilterBakeryIcon.svelte';
	import FilterBarIcon from '$lib/icons/FilterBarIcon.svelte';
	import FilterRestaurantIcon from '$lib/icons/FilterRestaurantIcon.svelte';

	let { data } = $props();

	let activeFilter = $state<Place['type'] | null>(null);

	let filteredPlaces = $derived(
		activeFilter ? data.places.filter((place) => place.type === activeFilter) : data.places
	);

	const CATEGORIES: Record<Place['type'], CategoryConfig> = {
		RESTAURANT: {
			label: 'Restaurants',
			color: '#E8472A',
			glyphText: '🍽️',
			icon: FilterRestaurantIcon
		},
		BAR: {
			label: 'Bars',
			color: '#6B4FBB',
			glyphText: '🍸',
			icon: FilterBarIcon
		},
		BAKERY: {
			label: 'Bakeries',
			color: '#F0A500',
			glyphText: '🥐',
			icon: FilterBakeryIcon
		}
	};
</script>

<PlaceMap categories={CATEGORIES} places={filteredPlaces} onplaceclick={() => {}} />
<div class="controls">
	<SearchBar placeholder="Search for something yummy" />
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
</style>
