<script lang="ts">
	import { CATEGORIES } from '$lib/categories';
	import AddVisitDialog from '$lib/components/AddVisitDialog.svelte';
	import PlaceMap from '$lib/components/PlaceMap.svelte';
	import PlaceSheet from '$lib/components/PlaceSheet.svelte';
	import { isSavedPlace, type Place } from '$lib/schemas/place';
	import type { PageProps } from './$types';
	import { getVisitsForPlace } from './visits.remote';

	let { data }: PageProps = $props();

	let selectedPlace = $state<Place | null>(null);
	let dialogOpen = $state(false);
	let sheetOpen = $state(false);
</script>

<div class="map-root">
	<PlaceMap
		savedPlaces={data.savedPlaces}
		categories={CATEGORIES}
		{selectedPlace}
		onsaveplace={() => {
			dialogOpen = true;
		}}
		onplacechange={(place) => {
			selectedPlace = place;

			if (place === null || !isSavedPlace(place)) {
				return;
			}

			sheetOpen = true;
		}}
	/>
</div>

{#if selectedPlace && !isSavedPlace(selectedPlace)}
	<AddVisitDialog
		bind:open={dialogOpen}
		placeName={selectedPlace.name}
		googlePlaceId={selectedPlace.google_place_id}
	/>
{/if}

{#if selectedPlace && isSavedPlace(selectedPlace)}
	{#await getVisitsForPlace(selectedPlace.id)}
		<PlaceSheet placeName={selectedPlace.name} visits={[]} bind:open={sheetOpen} />
	{:then visits}
		<PlaceSheet placeName={selectedPlace.name} {visits} bind:open={sheetOpen} />
	{/await}
{/if}

<style>
	.map-root {
		position: absolute;
		width: 100vw;
		height: 100vh;
	}
</style>
