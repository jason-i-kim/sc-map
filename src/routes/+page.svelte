<script lang="ts">
  import PlaceMap from '$lib/PlaceMap.svelte';
  import PlacePanel from '$lib/PlacePanel.svelte';
  import { generatePlaces } from '$lib/places';
  import { type Place } from '$lib/types';

  const places: Place[] = generatePlaces(1000);

  let selectedPlace: Place | null = $state(null);
</script>

<PlaceMap {places} onplaceclick={(place) => selectedPlace = place} />

{#if selectedPlace}
  <PlacePanel place={selectedPlace} onclose={() => selectedPlace = null} />
{/if}
