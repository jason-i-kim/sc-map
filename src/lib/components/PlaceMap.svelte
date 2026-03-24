<script lang="ts">
	import { onMount } from 'svelte';
	import { setOptions, importLibrary } from '@googlemaps/js-api-loader';
	import type { SavedPlace } from '$lib/schemas/saved-place';
	import PlaceMarker from './PlaceMarker.svelte';
	import { PUBLIC_GOOGLE_MAPS_API_KEY } from '$env/static/public';
	import { DEFAULT_MAP_CENTER, DEFAULT_MAP_ZOOM, MAP_ID } from './map-constants';
	import type { Place } from '$lib/schemas/place';
	import type { CATEGORIES } from '$lib/categories';

	let {
		categories,
		savedPlaces,
		selectedPlace,
		onsaveplace,
		onplacechange
	}: {
		categories: typeof CATEGORIES;
		savedPlaces: SavedPlace[];
		selectedPlace: Place | null;
		onsaveplace: (placeId: string) => void;
		onplacechange: (place: Place | null) => void;
	} = $props();

	let map: google.maps.Map | null = $state(null);
	let InfoWindowClass = $state<typeof google.maps.InfoWindow | null>(null);
	let AdvancedMarkerClass = $state<typeof google.maps.marker.AdvancedMarkerElement | null>(null);
	let PlaceClass = $state<typeof google.maps.places.Place | null>(null);

	let currentInfoWindow = $state<google.maps.InfoWindow | null>(null);
	let currentMarker = $state<google.maps.marker.AdvancedMarkerElement | null>(null);

	const clearCurrentMarker = () => {
		if (currentMarker === null) {
			return;
		}

		currentMarker.map = null;
		currentMarker = null;
	};

	const clearCurrentInfoWindow = () => {
		if (currentInfoWindow === null) {
			return;
		}

		currentInfoWindow.close();
		currentInfoWindow = null;
	};

	const handleSavePlace = (googlePlaceId: string) => {
		clearCurrentInfoWindow();
		onsaveplace(googlePlaceId);
	};

	let mapEl: HTMLDivElement;

	onMount(async () => {
		setOptions({ key: PUBLIC_GOOGLE_MAPS_API_KEY });

		const [{ Map, InfoWindow }, { Place }, { AdvancedMarkerElement }] = await Promise.all([
			importLibrary('maps') as Promise<google.maps.MapsLibrary>,
			importLibrary('places') as Promise<google.maps.PlacesLibrary>,
			importLibrary('marker') as Promise<google.maps.MarkerLibrary>
		]);

		InfoWindowClass = InfoWindow;
		AdvancedMarkerClass = AdvancedMarkerElement;
		PlaceClass = Place;

		map = new Map(mapEl, {
			center: DEFAULT_MAP_CENTER,
			zoom: DEFAULT_MAP_ZOOM,
			mapId: MAP_ID,
			mapTypeControl: false,
			streetViewControl: false,
			fullscreenControl: false
		});

		map.addListener('click', async (event: google.maps.MapMouseEvent & { placeId?: string }) => {
			if (event.placeId === selectedPlace?.google_place_id) {
				return;
			}
			if (InfoWindowClass === null || AdvancedMarkerClass === null || PlaceClass === null) {
				return;
			}
			clearCurrentMarker();
			clearCurrentInfoWindow();
			if (event.placeId === undefined) {
				onplacechange(null);
				return;
			}

			event.stop();

			const place = new Place({ id: event.placeId });
			await place.fetchFields({
				fields: ['displayName', 'formattedAddress', 'location']
			});

			const latLng = event.latLng;

			if (latLng === null) {
				return;
			}

			currentMarker = new AdvancedMarkerClass({
				position: { lat: latLng.lat(), lng: latLng.lng() },
				map,
				title: place.displayName
			});

			onplacechange({
				name: place.displayName ?? '',
				lat: latLng.lat(),
				lng: latLng.lng(),
				formatted_address: place.formattedAddress ?? '',
				google_place_id: place.id
			});

			// We're dealing with a Google Place, not a saved place. We want to show the user
			// an info window so that they could save the place if desired.
			currentInfoWindow = new InfoWindowClass({
				position: { lat: latLng.lat(), lng: latLng.lng() },
				content: `
				<div style="max-width: 200px; color: #000">
					<strong>${place.displayName}</strong><br />
					${place.formattedAddress}<br />
					<button
						data-place-id="${place.id}"
						style="margin-top: 8px; padding: 6px 12px; background: #1a73e8; color: #fff; border: none; border-radius: 4px; font-size: 13px; cursor: pointer"
					>
						Save place
					</button>
				</div>
			`
			});
			// Wait for the DOM to be ready inside of the InfoWindow, then add the `onsaveplace` click handler
			currentInfoWindow.addListener('domready', () => {
				document
					.querySelector<HTMLButtonElement>(`[data-place-id="${place.id}"]`)
					?.addEventListener('click', () => handleSavePlace(place.id));
			});

			// Reset state if the user requests the window to close
			currentInfoWindow.addListener('closeclick', () => {
				clearCurrentMarker();
			});

			currentInfoWindow.open({ map, anchor: currentMarker });
		});
	});
</script>

<div bind:this={mapEl} style="width: 100%; height: 100%;"></div>

{#if map}
	{#each savedPlaces as place (place.id)}
		<PlaceMarker
			{map}
			{place}
			visible={true}
			onclick={onplacechange}
			categoryConfig={categories[place.type]}
		/>
	{/each}
{/if}
