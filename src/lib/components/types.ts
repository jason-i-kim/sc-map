import type { Place } from '$lib/dao/places/types';
import type { Component } from 'svelte';

export type FocusedLocation = Omit<Place, 'id' | 'created_at' | 'submitted_by'>;

export interface CategoryConfig {
	label: string;
	color: string;
	glyphText: string;
	icon: Component;
}
