import type { CategoryConfig } from '$lib/components/types';
import FilterBakeryIcon from '$lib/icons/FilterBakeryIcon.svelte';
import FilterBarIcon from '$lib/icons/FilterBarIcon.svelte';
import FilterRestaurantIcon from '$lib/icons/FilterRestaurantIcon.svelte';
import type { Place } from '$lib/dao/places/types';

export const CATEGORIES: Record<Place['type'], CategoryConfig> = {
	RESTAURANT: {
		label: 'Restaurants',
		color: '#E8472A',
		glyphText: '🍽️',
		icon: FilterRestaurantIcon
	},
	BAR: { label: 'Bars', color: '#6B4FBB', glyphText: '🍸', icon: FilterBarIcon },
	BAKERY: { label: 'Bakeries', color: '#F0A500', glyphText: '🥐', icon: FilterBakeryIcon }
};
