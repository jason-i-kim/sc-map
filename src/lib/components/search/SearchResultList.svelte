<script lang="ts">
	import SearchResultComponent from './SearchResult.svelte';
	import { isPlace, type SearchResult } from '$lib/schemas/search';
	import { CATEGORIES } from '$lib/categories';
	import PinIcon from '$lib/icons/PinIcon.svelte';

	let {
		searchResults,
		onsuggestionclick
	}: { searchResults: SearchResult[]; onsuggestionclick?: (suggestion: SearchResult) => void } =
		$props();
</script>

<ul class="suggestions-list" id="map-search-listbox" role="listbox">
	<li class="divider" aria-hidden="true"></li>
	{#each searchResults as searchResult (searchResult.google_place_id)}
		{@const isSavedPlace = isPlace(searchResult)}
		<li role="option" aria-selected="false">
			<SearchResultComponent
				icon={isSavedPlace ? CATEGORIES[searchResult.type] : PinIcon}
				primary={searchResult.name}
				secondary={searchResult.formatted_address}
				onclick={() => onsuggestionclick?.(searchResult)}
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
