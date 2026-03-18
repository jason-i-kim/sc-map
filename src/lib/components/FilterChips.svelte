<script lang="ts">
	import FilterChip from './FilterChip.svelte';
	import type { Place } from '$lib/dao/places/types';
	import type { CategoryConfig } from './types';

	type Props = {
		filters: Record<Place['type'], CategoryConfig>;
		activeFilter: Place['type'] | null;
		onchange?: (activeFilter: Place['type'] | null) => void;
	};

	let { filters, activeFilter = null, onchange }: Props = $props();

	function toggleFilter(id: Place['type']) {
		let newFilter: Place['type'] | null = null;
		if (activeFilter !== id) {
			newFilter = id;
		}
		onchange?.(newFilter);
	}
</script>

<div class="filter-chips" role="group" aria-label="Place filters">
	{#each Object.entries(filters) as [id, filter] (id)}
		{@const filterId = id as Place['type']}
		<FilterChip
			label={filter.label}
			icon={filter.icon}
			active={filterId === activeFilter}
			onclick={() => toggleFilter(filterId)}
		/>
	{/each}
</div>

<style>
	.filter-chips {
		display: flex;
		gap: 8px;
		padding: 10px;
		overflow-x: auto;
		scrollbar-width: none;
		-ms-overflow-style: none;
	}

	.filter-chips::-webkit-scrollbar {
		display: none;
	}
</style>
