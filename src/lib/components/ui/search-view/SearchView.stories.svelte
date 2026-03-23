<script module lang="ts">
	import { defineMeta } from '@storybook/addon-svelte-csf';
	import SearchView from './SearchView.svelte';
	import SearchBar from '../search-bar/SearchBar.svelte';

	const { Story } = defineMeta({
		tags: ['autodocs'],
		argTypes: {
			value: { control: 'text' },
			placeholder: { control: 'text' }
		}
	});
</script>

<script lang="ts">
	// Shared SVG paths for reuse across stories
	const searchPath =
		'M15.5 14h-.79l-.28-.27A6.471 6.471 0 0 0 16 9.5 6.5 6.5 0 1 0 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z';
	const clearPath =
		'M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z';

	const PLACES = [
		'Hermosa Beach Volleyball',
		'Manhattan Beach Pier',
		'Venice Beach Courts',
		'Santa Monica Beach',
		'Redondo Beach',
		'Long Beach Volleyball',
		'Huntington Beach',
		'Newport Beach'
	];

	function filterPlaces(query: string) {
		if (!query) return PLACES;
		const q = query.toLowerCase();
		return PLACES.filter((p) => p.toLowerCase().includes(q));
	}

	let searchValue = $state('');
	let lastSearch = $state('');
</script>

<!-- Default (no results) -->

<Story name="Default">
	<SearchView placeholder="Search places" bind:value={searchValue}>
		{#snippet children({ open, value })}
			<SearchBar
				{value}
				placeholder="Search places"
				aria-label="Search places"
				aria-expanded={open}
			>
				{#snippet leadingIcon()}
					<svg
						class="md-search-bar__icon"
						viewBox="0 0 24 24"
						aria-hidden="true"
						fill="currentColor"
					>
						<path d={searchPath} />
					</svg>
				{/snippet}
			</SearchBar>
		{/snippet}
	</SearchView>
</Story>

<!-- With results -->

<Story name="With Results">
	<SearchView placeholder="Search places" bind:value={searchValue} initialOpen>
		{#snippet children({ open, value })}
			<SearchBar
				{value}
				placeholder="Search places"
				aria-label="Search places"
				aria-expanded={open}
			>
				{#snippet leadingIcon()}
					<svg
						class="md-search-bar__icon"
						viewBox="0 0 24 24"
						aria-hidden="true"
						fill="currentColor"
					>
						<path d={searchPath} />
					</svg>
				{/snippet}
			</SearchBar>
		{/snippet}

		{#snippet results({ value })}
			{#each filterPlaces(value) as place (place)}
				<div role="option" aria-selected="false" style="padding: 0.75rem 1rem; cursor: pointer;">
					{place}
				</div>
			{/each}
		{/snippet}
	</SearchView>
</Story>

<!-- With results and trailing clear button -->

<Story name="With Clear Button">
	<SearchView
		placeholder="Search places"
		bind:value={searchValue}
		onsearch={(v) => {
			lastSearch = v;
		}}
	>
		{#snippet children({ open, value })}
			<SearchBar
				{value}
				placeholder="Search places"
				aria-label="Search places"
				aria-expanded={open}
			>
				{#snippet leadingIcon()}
					<svg
						class="md-search-bar__icon"
						viewBox="0 0 24 24"
						aria-hidden="true"
						fill="currentColor"
					>
						<path d={searchPath} />
					</svg>
				{/snippet}
			</SearchBar>
		{/snippet}

		{#snippet trailingIcons()}
			{#if searchValue}
				<button
					class="md-search-view__icon-btn"
					aria-label="Clear"
					type="button"
					onclick={() => {
						searchValue = '';
					}}
				>
					<svg
						class="md-search-view__icon"
						viewBox="0 0 24 24"
						aria-hidden="true"
						fill="currentColor"
					>
						<path d={clearPath} />
					</svg>
				</button>
			{/if}
		{/snippet}

		{#snippet results({ value })}
			{#each filterPlaces(value) as place (place)}
				<div role="option" aria-selected="false" style="padding: 0.75rem 1rem; cursor: pointer;">
					{place}
				</div>
			{/each}
		{/snippet}
	</SearchView>
	{#if lastSearch}
		<p style="margin-top: 1rem; font-size: 0.875rem; opacity: 0.6;">
			Last search: <strong>{lastSearch}</strong>
		</p>
	{/if}
</Story>

<!-- Empty state -->

<Story name="No Results">
	<SearchView placeholder="Search places" bind:value={searchValue}>
		{#snippet children({ open, value })}
			<SearchBar
				{value}
				placeholder="Search places"
				aria-label="Search places"
				aria-expanded={open}
			>
				{#snippet leadingIcon()}
					<svg
						class="md-search-bar__icon"
						viewBox="0 0 24 24"
						aria-hidden="true"
						fill="currentColor"
					>
						<path d={searchPath} />
					</svg>
				{/snippet}
			</SearchBar>
		{/snippet}

		{#snippet results({ value })}
			{#if value && filterPlaces(value).length === 0}
				<div
					role="option"
					aria-selected="false"
					style="padding: 1rem; text-align: center; opacity: 0.6; font-size: 0.875rem;"
				>
					No results for "{value}"
				</div>
			{:else}
				{#each filterPlaces(value) as place (place)}
					<div role="option" aria-selected="false" style="padding: 0.75rem 1rem; cursor: pointer;">
						{place}
					</div>
				{/each}
			{/if}
		{/snippet}
	</SearchView>
</Story>
