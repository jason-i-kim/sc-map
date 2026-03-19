<script lang="ts">
	import type { Component } from 'svelte';
	import ArrowFillIcon from '$lib/icons/ArrowFillIcon.svelte';

	type PlaceGlyph = { color: string; glyphText: string };
	type Icon = Component | PlaceGlyph;

	type Props = {
		icon: Icon;
		primary: string;
		secondary: string;
		onclick?: () => void;
	};

	let { icon, primary, secondary, onclick }: Props = $props();
</script>

<button class="suggestion-item" {onclick}>
	<div class="suggestion-icon">
		{#if 'glyphText' in icon}
			<span class="place-glyph" style="background: {icon.color}">{icon.glyphText}</span>
		{:else}
			{@const SVGIcon = icon}
			<SVGIcon />
		{/if}
	</div>

	<div class="suggestion-text">
		<span class="suggestion-primary">{primary}</span>
		<span class="suggestion-secondary">{secondary}</span>
	</div>

	<div class="suggestion-fill" aria-hidden="true">
		<ArrowFillIcon />
	</div>
</button>

<style>
	.suggestion-item {
		display: flex;
		align-items: center;
		width: 100%;
		padding: 0 var(--space-5) 0 var(--space-2);
		height: 52px;
		border: none;
		background: transparent;
		cursor: pointer;
		text-align: left;
		gap: var(--space-4);
		font-family: var(--font-family);
		transition: background-color var(--duration-fast);
	}

	.suggestion-item:hover {
		background-color: var(--color-surface-alt);
	}

	.suggestion-item:hover .suggestion-fill {
		opacity: 1;
	}

	.suggestion-icon {
		flex-shrink: 0;
		width: 40px;
		height: 40px;
		border-radius: var(--radius-md);
		background: var(--color-surface-icon);
		display: flex;
		align-items: center;
		justify-content: center;
		color: var(--color-on-surface-variant);
	}

	.place-glyph {
		width: 100%;
		height: 100%;
		border-radius: var(--radius-md);
		display: flex;
		align-items: center;
		justify-content: center;
		font-size: var(--text-lg);
	}

	.suggestion-text {
		flex: 1;
		min-width: 0;
		display: flex;
		flex-direction: column;
		justify-content: center;
	}

	.suggestion-primary {
		display: block;
		font-size: var(--text-md);
		font-weight: 500;
		color: var(--color-on-surface);
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
		line-height: 20px;
	}

	.suggestion-secondary {
		display: block;
		font-size: var(--text-xs);
		color: var(--color-on-surface-subtle);
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
		line-height: 18px;
	}

	.suggestion-fill {
		flex-shrink: 0;
		color: var(--color-on-surface-subtle);
		opacity: 0;
		transition: opacity var(--duration-fast);
		display: flex;
		align-items: center;
	}
</style>
