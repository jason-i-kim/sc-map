<script lang="ts">
	let {
		open = $bindable(false),
		title = '',
		children,
		width = '380px'
	}: {
		open?: boolean;
		title?: string;
		width?: string;
		children?: import('svelte').Snippet;
	} = $props();

	let showTooltip = $state(false);

	function toggle() {
		open = !open;
	}

	function handleKeydown(e: KeyboardEvent) {
		if (e.key === 'Escape' && open) {
			open = false;
		}
	}
</script>

<svelte:window onkeydown={handleKeydown} />

<div class="maps-drawer-wrapper" style:--drawer-width={width}>
	{#if open}
		<div class="drawer-content">
			{#if title}
				<div class="drawer-header">
					<h2 class="drawer-title">{title}</h2>
				</div>
			{/if}

			<div class="drawer-body">
				{@render children?.()}
			</div>
		</div>

		<button
			class="drawer-toggle"
			onclick={toggle}
			aria-label={open ? 'Collapse side panel' : 'Expand side panel'}
			onmouseenter={() => (showTooltip = true)}
			onmouseleave={() => (showTooltip = false)}
			onfocus={() => (showTooltip = true)}
			onblur={() => (showTooltip = false)}
		>
			<svg
				class="toggle-icon"
				viewBox="0 0 24 24"
				fill="none"
				stroke="currentColor"
				stroke-width="2"
			>
				<path d="M15 18l-6-6 6-6" />
			</svg>

			{#if showTooltip}
				<span class="toggle-tooltip" role="tooltip">
					{open ? 'Collapse side panel' : 'Expand side panel'}
				</span>
			{/if}
		</button>
	{/if}
</div>

<style>
	.maps-drawer-wrapper {
		position: fixed;
		top: 0;
		left: 0;
		bottom: 0;
		z-index: 99;
		pointer-events: none;
	}

	.maps-drawer-wrapper:has(.drawer-content) {
		pointer-events: auto;
	}

	.drawer-toggle {
		position: fixed;
		left: var(--drawer-width, 380px);
		top: 50%;
		transform: translateY(-50%);
		width: 24px;
		height: 48px;
		display: flex;
		align-items: center;
		justify-content: center;
		background: var(--color-surface);
		border: none;
		border-radius: 0 var(--radius-md) var(--radius-md) 0;
		box-shadow: var(--shadow-drawer);
		cursor: pointer;
		transition:
			background-color var(--duration-fast) ease,
			box-shadow var(--duration-fast) ease;
		z-index: 100;
	}

	.drawer-toggle:hover {
		background: var(--color-surface-hover);
	}

	.drawer-toggle:active {
		background: var(--color-surface-pressed);
	}

	.toggle-icon {
		width: 20px;
		height: 20px;
		color: var(--color-on-surface);
	}

	.toggle-tooltip {
		position: absolute;
		left: calc(100% + var(--space-2));
		top: 50%;
		transform: translateY(-50%);
		padding: var(--space-1) var(--space-4);
		background: var(--color-tooltip-bg);
		color: var(--color-tooltip-text);
		font-size: var(--text-xs);
		font-family: var(--font-family);
		white-space: nowrap;
		border-radius: var(--radius-sm);
		box-shadow: var(--shadow-tooltip);
		pointer-events: none;
		z-index: 110;
	}

	.drawer-content {
		position: fixed;
		top: 0;
		left: 0;
		bottom: 0;
		display: flex;
		flex-direction: column;
		width: var(--drawer-width);
		max-width: calc(100dvw - 60px);
		height: 100%;
		background: var(--color-surface);
		border-right: 1px solid var(--color-outline);
		box-shadow: var(--shadow-drawer);
		overflow: hidden;
	}

	.drawer-header {
		flex-shrink: 0;
		padding: var(--space-6);
		border-bottom: 1px solid var(--color-outline);
	}

	.drawer-title {
		margin: 0;
		font-size: var(--text-xl);
		font-weight: 400;
		font-family: var(--font-family);
		color: var(--color-on-surface);
		line-height: 28px;
	}

	.drawer-body {
		flex: 1;
		overflow-y: auto;
		overflow-x: hidden;
	}
</style>
