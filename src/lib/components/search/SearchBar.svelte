<script lang="ts">
	import SearchResultList from './SearchResultList.svelte';
	import SearchIcon from '$lib/icons/SearchIcon.svelte';
	import { SEARCH_BLUR_DELAY_MS } from '$lib/components/ui-constants';
	import type { SearchResult } from '$lib/schemas/search';
	import { createQuery } from '@tanstack/svelte-query';
	import { searchPlacesOptions } from '$lib/queries';
	import type { SelectedLocation } from '../types';

	let {
		placeholder = 'Search Google Maps',
		selectedLocation = $bindable()
	}: {
		placeholder?: string;
		selectedLocation: SelectedLocation | null;
	} = $props();

	let focused = $state(false);
	let query = $state('');

	$effect(() => {
		if (!selectedLocation) {
			return;
		}

		query = selectedLocation.name;
	});

	const searchQuery = createQuery(() => searchPlacesOptions(query));
	const suggestions = $derived(searchQuery.data ?? []);

	let open = $derived(focused && suggestions.length > 0);

	function handleInput(e: Event) {
		query = (e.target as HTMLInputElement).value;
	}

	function handleResultClick(searchResult: SearchResult) {
		query = searchResult.name;
		selectedLocation = searchResult;
	}
</script>

<div class="search-wrapper" role="search">
	<div class="search-container" class:open>
		<div class="search-bar" class:open>
			<form spellcheck="false">
				<label class="visually-hidden" for="map-search">{placeholder}</label>
				<input
					id="map-search"
					class="search-input"
					type="text"
					role="combobox"
					aria-controls="map-search-listbox"
					aria-expanded={open}
					aria-haspopup="listbox"
					autocomplete="off"
					{placeholder}
					onfocus={() => (focused = true)}
					onblur={() => setTimeout(() => (focused = false), SEARCH_BLUR_DELAY_MS)}
					oninput={handleInput}
					value={query}
				/>
			</form>

			<div class="search-btn-wrapper">
				<button class="search-btn" aria-label="Search" type="submit">
					<SearchIcon />
				</button>
			</div>
		</div>

		{#if open}
			<SearchResultList searchResults={suggestions} onsuggestionclick={handleResultClick} />
		{/if}
	</div>
</div>

<style>
	.search-container {
		width: 376px;
		border-radius: var(--radius-xl);
		transition: box-shadow var(--duration-slow);
		box-shadow: var(--shadow-material);
	}

	.search-container.open {
		box-shadow: var(--shadow-search-open);
		border-radius: var(--radius-xl);
	}

	.search-bar {
		position: relative;
		display: flex;
		align-items: center;
		width: 100%;
		height: 48px;
		background: var(--color-surface);
		border-radius: var(--radius-xl);
		padding: 0 56px 0 var(--space-5);
		box-sizing: border-box;
		transition: border-radius var(--duration-fast);
	}

	.search-bar.open {
		border-radius: var(--radius-xl) var(--radius-xl) 0 0;
	}

	form {
		flex: 1;
		display: flex;
		align-items: center;
		min-width: 0;
	}

	.search-input {
		width: 100%;
		border: none;
		outline: none;
		background: transparent;
		font-family: var(--font-family);
		font-size: var(--text-base);
		font-weight: 400;
		line-height: 24px;
		color: var(--color-on-surface);
		transition: color var(--duration-slow);
	}

	.search-input::placeholder {
		color: var(--color-on-surface-variant);
	}

	.search-btn-wrapper {
		position: absolute;
		right: 0;
		top: 0;
		width: 48px;
		height: 48px;
		display: flex;
		align-items: center;
		justify-content: center;
	}

	.search-btn {
		display: flex;
		align-items: center;
		justify-content: center;
		width: 40px;
		height: 40px;
		border: none;
		background: transparent;
		border-radius: var(--radius-full);
		cursor: pointer;
		color: var(--color-on-surface-variant);
		padding: var(--space-2);
		transition:
			background-color var(--duration-base),
			color var(--duration-base);
	}

	.search-btn:hover {
		background-color: rgba(95, 99, 104, 0.1);
		color: var(--color-on-surface);
	}

	.search-btn:focus-visible {
		outline: 2px solid var(--color-primary);
		outline-offset: 2px;
	}

	.visually-hidden {
		position: absolute;
		width: 1px;
		height: 1px;
		padding: 0;
		margin: -1px;
		overflow: hidden;
		clip: rect(0, 0, 0, 0);
		white-space: nowrap;
		border: 0;
	}
</style>
