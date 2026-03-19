<script lang="ts">
	import type { Component } from 'svelte';

	type Props = {
		label: string;
		icon: Component;
		active?: boolean;
		onclick?: () => void;
	};

	let { label, icon: Icon, active = false, onclick }: Props = $props();
</script>

<button class="chip" class:active aria-pressed={active} {onclick}>
	<span class="chip-icon" aria-hidden="true">
		<Icon />
	</span>
	<span class="chip-label">{label}</span>
</button>

<style>
	.chip {
		display: inline-flex;
		align-items: center;
		gap: var(--space-1);
		padding: 0 var(--space-2);
		height: 34px;
		border: 1px solid var(--color-outline-chip);
		border-radius: var(--radius-pill);
		background: var(--color-surface);
		cursor: pointer;
		font-family: var(--font-family);
		font-size: var(--text-sm);
		font-weight: 500;
		color: var(--color-on-surface-chip);
		white-space: nowrap;
		box-shadow: var(--shadow-material);
		transition:
			background-color var(--duration-base),
			box-shadow var(--duration-base),
			border-color var(--duration-base);
	}

	.chip:hover {
		background: var(--color-surface-alt);
	}

	.chip:focus-visible {
		outline: 2px solid var(--color-primary);
		outline-offset: 2px;
	}

	.chip.active {
		background: var(--color-primary-container);
		border-color: var(--color-primary-container-border);
		color: var(--color-primary-active);
	}

	.chip.active .chip-icon {
		color: var(--color-primary-active);
	}

	.chip-icon {
		display: flex;
		align-items: center;
		justify-content: center;
		color: var(--color-on-surface-variant);
		transition: color var(--duration-base);
	}

	.chip-label {
		line-height: 1;
	}
</style>
