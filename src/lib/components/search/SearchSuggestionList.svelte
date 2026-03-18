<script lang="ts">
	import SearchSuggestion from './SearchSuggestion.svelte';
	import type { Suggestion } from '$lib/schemas/search';
	import { CATEGORIES } from '$lib/categories';
	import PinIcon from '$lib/icons/PinIcon.svelte';

	let { suggestions }: { suggestions: Suggestion[] } = $props();
</script>

<ul class="suggestions-list" id="map-search-listbox" role="listbox">
	<li class="divider" aria-hidden="true"></li>
	{#each suggestions as suggestion (suggestion.source === 'db' ? suggestion.data.id : suggestion.data.place_id)}
		{@const category = suggestion.source === 'db' ? CATEGORIES[suggestion.data.type] : null}
		<li role="option" aria-selected="false">
			<SearchSuggestion
				icon={category ? { color: category.color, glyph: category.glyphText } : PinIcon}
				primary={suggestion.data.name}
				secondary={suggestion.data.formatted_address}
			/>
		</li>
	{/each}
</ul>

<style>
	.suggestions-list {
		list-style: none;
		margin: 0;
		padding: 8px 0 12px;
		background: #fff;
		border-radius: 0 0 24px 24px;
		overflow: hidden;
	}

	.divider {
		height: 1px;
		background: #e8eaed;
		margin: 0 16px 8px;
	}
</style>
