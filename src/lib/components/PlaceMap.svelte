<script lang="ts">
	import { onMount } from 'svelte';
	import { setOptions, importLibrary } from '@googlemaps/js-api-loader';
	import type { Place } from '$lib/dao/places/types';
	import PlaceMarker from './PlaceMarker.svelte';
	import { PUBLIC_GOOGLE_MAPS_API_KEY } from '$env/static/public';
	import { type CategoryConfig, type SelectedLocation } from './types';
	import { DEFAULT_MAP_CENTER, DEFAULT_MAP_ZOOM, MAP_ID } from './map-constants';

	let {
		categories,
		places,
		onaddtolist,
		selectedLocation = $bindable()
	}: {
		categories: Record<Place['type'], CategoryConfig>;
		places: Place[];
		onaddtolist?: (placeId: string) => void;
		selectedLocation: SelectedLocation | null;
	} = $props();

	let map: google.maps.Map | null = $state(null);
	let InfoWindowClass: typeof google.maps.InfoWindow | null = $state(null);
	let AdvancedMarkerClass: typeof google.maps.marker.AdvancedMarkerElement | null = $state(null);
	let currentInfoWindow: google.maps.InfoWindow | null = null;
	let selectedPin: google.maps.marker.AdvancedMarkerElement | null = null;

	let mapEl: HTMLDivElement;

	function clearSelectedPin() {
		if (selectedPin) {
			selectedPin.map = null;
			selectedPin = null;
		}
	}

	$effect(() => {
		if (map === null || selectedLocation === null) {
			return;
		}

		map.panTo(selectedLocation);
		map.setZoom(15);
	});

	function buildInfoWindowContent(
		location: { name: string; formatted_address: string; google_place_id: string },
		details: {
			rating: number | null;
			userRatingCount: number | null;
			openNow: boolean | null;
			weekdayDescriptions: string[] | null;
			priceLevel: string | null;
			nationalPhoneNumber: string | null;
			websiteUri: string | null;
		} | null
	): string {
		const addButton = `<button
			data-place-id="${location.google_place_id}"
			style="margin-top: 10px; padding: 6px 14px; background: #1a73e8; color: #fff; border: none; border-radius: 4px; font-size: 13px; cursor: pointer; width: 100%"
		>Add to list</button>`;

		const header = `
			<strong style="font-size: 14px; display: block; margin-bottom: 2px">${location.name}</strong>
			<span style="font-size: 12px; color: #555">${location.formatted_address}</span>
		`;

		if (details === null) {
			return `<div style="max-width: 280px; color: #000; font-family: sans-serif; padding: 4px 0">
				${header}
				<span style="font-size: 12px; color: #888; display: block; margin-top: 6px">Loading details…</span>
				${addButton}
			</div>`;
		}

		const priceLevelMap: Record<string, string> = {
			PRICE_LEVEL_FREE: 'Free',
			PRICE_LEVEL_INEXPENSIVE: '$',
			PRICE_LEVEL_MODERATE: '$$',
			PRICE_LEVEL_EXPENSIVE: '$$$',
			PRICE_LEVEL_VERY_EXPENSIVE: '$$$$'
		};

		let rows = '';

		if (details.rating !== null) {
			const full = Math.floor(details.rating);
			const stars = '★'.repeat(full) + '☆'.repeat(5 - full);
			const count =
				details.userRatingCount !== null
					? ` · ${details.userRatingCount.toLocaleString()} reviews`
					: '';
			rows += `<div style="margin-top: 6px; font-size: 13px; color: #f5a623">${stars} <span style="color:#333">${details.rating.toFixed(1)}${count}</span></div>`;
		}

		if (details.priceLevel && priceLevelMap[details.priceLevel]) {
			rows += `<div style="font-size: 12px; color: #555; margin-top: 3px">${priceLevelMap[details.priceLevel]}</div>`;
		}

		if (details.openNow !== null) {
			const todayHours = (() => {
				if (!details.weekdayDescriptions) return '';
				// Google returns Mon–Sun (index 0=Monday); JS getDay() returns 0=Sun
				const jsDay = new Date().getDay();
				const googleIdx = jsDay === 0 ? 6 : jsDay - 1;
				const entry = details.weekdayDescriptions[googleIdx] ?? '';
				const hoursText = entry.includes(':') ? entry.split(':').slice(1).join(':').trim() : '';
				return hoursText ? ` · ${hoursText}` : '';
			})();
			const label = details.openNow ? '🟢 Open now' : '🔴 Closed';
			rows += `<div style="font-size: 12px; margin-top: 3px">${label}${todayHours}</div>`;
		}

		if (details.nationalPhoneNumber) {
			rows += `<div style="font-size: 12px; color: #555; margin-top: 3px">${details.nationalPhoneNumber}</div>`;
		}

		if (details.websiteUri) {
			const display = details.websiteUri.replace(/^https?:\/\//, '').replace(/\/$/, '');
			const truncated = display.length > 30 ? display.slice(0, 30) + '…' : display;
			rows += `<div style="font-size: 12px; margin-top: 3px"><a href="${details.websiteUri}" target="_blank" rel="noopener" style="color:#1a73e8">${truncated}</a></div>`;
		}

		return `<div style="max-width: 280px; color: #000; font-family: sans-serif; padding: 4px 0">
			${header}${rows}
			${addButton}
		</div>`;
	}

	$effect(() => {
		if (
			map === null ||
			InfoWindowClass === null ||
			AdvancedMarkerClass === null ||
			selectedLocation === null
		) {
			clearSelectedPin();
			return;
		}

		const isSavedPlace = places.some(
			(p) => p.google_place_id === selectedLocation!.google_place_id
		);
		if (isSavedPlace) {
			clearSelectedPin();
			return;
		}

		clearSelectedPin();
		selectedPin = new AdvancedMarkerClass({
			position: { lat: selectedLocation.lat, lng: selectedLocation.lng },
			map,
			title: selectedLocation.name
		});

		const loc = selectedLocation;
		const iw = new InfoWindowClass({
			position: { lat: loc.lat, lng: loc.lng },
			content: buildInfoWindowContent(loc, null)
		});

		function attachButton() {
			document
				.querySelector<HTMLButtonElement>(`[data-place-id="${loc.google_place_id}"]`)
				?.addEventListener('click', () => onaddtolist?.(loc.google_place_id));
		}

		iw.addListener('domready', attachButton);
		iw.addListener('closeclick', () => {
			clearSelectedPin();
			selectedLocation = null;
		});
		currentInfoWindow?.close();
		currentInfoWindow = iw;
		iw.open({ map, anchor: selectedPin });

		fetch(`/places/details/${encodeURIComponent(loc.google_place_id)}`)
			.then((r) => r.json())
			.then((details) => {
				iw.setContent(buildInfoWindowContent(loc, details));
				// Re-attach button listener after content update
				iw.addListener('domready', attachButton);
			})
			.catch(() => {});
	});

	onMount(async () => {
		setOptions({ key: PUBLIC_GOOGLE_MAPS_API_KEY });

		const [{ Map, InfoWindow }, { Place }, { AdvancedMarkerElement }] = await Promise.all([
			importLibrary('maps') as Promise<google.maps.MapsLibrary>,
			importLibrary('places') as Promise<google.maps.PlacesLibrary>,
			importLibrary('marker') as Promise<google.maps.MarkerLibrary>
		]);

		InfoWindowClass = InfoWindow;
		AdvancedMarkerClass = AdvancedMarkerElement;

		map = new Map(mapEl, {
			center: DEFAULT_MAP_CENTER,
			zoom: DEFAULT_MAP_ZOOM,
			mapId: MAP_ID,
			mapTypeControl: false,
			streetViewControl: false,
			fullscreenControl: false
		});

		map.addListener('click', async (event: google.maps.MapMouseEvent & { placeId?: string }) => {
			if (!event.placeId) {
				currentInfoWindow?.close();
				currentInfoWindow = null;
				clearSelectedPin();
				selectedLocation = null;
				return;
			}

			event.stop();

			const place = new Place({ id: event.placeId });
			await place.fetchFields({
				fields: ['displayName', 'formattedAddress', 'location']
			});

			selectedLocation = {
				name: place.displayName ?? '',
				lat: place.location?.lat() ?? 0,
				lng: place.location?.lng() ?? 0,
				formatted_address: place.formattedAddress ?? '',
				google_place_id: event.placeId
			};
		});
	});
</script>

<div bind:this={mapEl} style="width: 100%; height: 100vh;"></div>

{#if map}
	{#each places as place (place.id)}
		<PlaceMarker
			{map}
			{place}
			visible={true}
			onclick={(savedPlace) => (selectedLocation = savedPlace)}
			categoryConfig={categories[place.type]}
		/>
	{/each}
{/if}
