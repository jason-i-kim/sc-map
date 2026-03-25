<script lang="ts">
	import type { Place } from '$lib/schemas/place';
	import type { SavedPlace } from '$lib/schemas/saved-place';
	import { isSavedPlace } from '$lib/schemas/place';
	import { CATEGORIES } from '$lib/categories';
	import List from './ui/list/List.svelte';
	import ListItem from './ui/list/ListItem.svelte';
	import RestaurantIcon from '$lib/icons/RestaurantIcon.svelte';
	import LocalBarIcon from '$lib/icons/LocalBarIcon.svelte';
	import BakeryIcon from '$lib/icons/BakeryIcon.svelte';
	import PinIcon from '$lib/icons/PinIcon.svelte';

	type Props = {
		places: Place[];
		onlistitemclick: (place: Place) => void;
	};

	const { onlistitemclick, places }: Props = $props();

	function getIndicator(place: Place) {
		if (!isSavedPlace(place)) {
			return { isSaved: false };
		}

		const savedPlace = place as SavedPlace;
		const category = CATEGORIES[savedPlace.type];
		const bgColor = category.color;

		const needsDarkIcon = savedPlace.type === 'BAKERY';
		const iconColor = needsDarkIcon ? '#1A1A1A' : '#FFFFFF';

		return { isSaved: true, bgColor, iconColor, type: savedPlace.type };
	}

	function getIcon(type: SavedPlace['type']) {
		switch (type) {
			case 'RESTAURANT':
				return RestaurantIcon;
			case 'BAR':
				return LocalBarIcon;
			case 'BAKERY':
				return BakeryIcon;
		}
	}
</script>

<List as="div" noPadding>
	{#each places as place (place.google_place_id)}
		{@const indicator = getIndicator(place)}
		{@const isSaved = indicator?.isSaved}
		{@const Icon = isSaved && indicator.type ? getIcon(indicator.type) : null}
		<ListItem
			type="button"
			role="option"
			aria-selected="false"
			onclick={() => onlistitemclick(place)}
		>
			{#snippet leading()}
				{#if isSaved && Icon}
					<div
						class="indicator"
						style="background-color: {indicator.bgColor}; color: {indicator.iconColor}"
					>
						<Icon size={16} />
					</div>
				{:else}
					<div class="indicator unsaved">
						<PinIcon size={20} />
					</div>
				{/if}
			{/snippet}

			{place.name}
			{#snippet supporting()}{place.formatted_address}{/snippet}
		</ListItem>
	{/each}
</List>

<style>
	.indicator {
		width: 32px;
		height: 32px;
		border-radius: 50%;
		display: flex;
		align-items: center;
		justify-content: center;
	}

	.indicator.unsaved {
		background-color: var(--md-sys-color-surface-container-high);
		color: var(--md-sys-color-on-surface-variant);
	}
</style>
