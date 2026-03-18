<script lang="ts">
	type Props = {
		icon: 'pin' | 'history';
		primary: string;
		secondary: string;
		onclick?: () => void;
	};

	let { icon, primary, secondary, onclick }: Props = $props();
</script>

<button class="suggestion-item" {onclick}>
	<div class="suggestion-icon">
		{#if icon === 'history'}
			<svg
				xmlns="http://www.w3.org/2000/svg"
				width="20"
				height="20"
				viewBox="0 0 24 24"
				fill="none"
				stroke="currentColor"
				stroke-width="2"
				stroke-linecap="round"
				stroke-linejoin="round"
			>
				<circle cx="12" cy="12" r="10" />
				<polyline points="12 6 12 12 16 14" />
			</svg>
		{:else}
			<svg
				xmlns="http://www.w3.org/2000/svg"
				width="20"
				height="20"
				viewBox="0 0 24 24"
				fill="currentColor"
			>
				<path
					d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z"
				/>
			</svg>
		{/if}
	</div>

	<div class="suggestion-text">
		<span class="suggestion-primary">{primary}</span>
		<span class="suggestion-secondary">{secondary}</span>
	</div>

	<div class="suggestion-fill" aria-hidden="true">
		<svg
			xmlns="http://www.w3.org/2000/svg"
			width="18"
			height="18"
			viewBox="0 0 24 24"
			fill="none"
			stroke="currentColor"
			stroke-width="2"
			stroke-linecap="round"
			stroke-linejoin="round"
		>
			<line x1="7" y1="17" x2="17" y2="7" />
			<polyline points="7 7 17 7 17 17" />
		</svg>
	</div>
</button>

<style>
	.suggestion-item {
		display: flex;
		align-items: center;
		width: 100%;
		padding: 0 16px 0 8px;
		height: 52px;
		border: none;
		background: transparent;
		cursor: pointer;
		text-align: left;
		gap: 12px;
		font-family: 'Google Sans', Roboto, Arial, sans-serif;
		transition: background-color 0.15s;
	}

	.suggestion-item:hover {
		background-color: #f1f3f4;
	}

	.suggestion-item:hover .suggestion-fill {
		opacity: 1;
	}

	.suggestion-icon {
		flex-shrink: 0;
		width: 40px;
		height: 40px;
		border-radius: 8px;
		background: #e8eaed;
		display: flex;
		align-items: center;
		justify-content: center;
		color: #5f6368;
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
		font-size: 14px;
		font-weight: 500;
		color: #202124;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
		line-height: 20px;
	}

	.suggestion-secondary {
		display: block;
		font-size: 12px;
		color: #70757a;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
		line-height: 18px;
	}

	.suggestion-fill {
		flex-shrink: 0;
		color: #70757a;
		opacity: 0;
		transition: opacity 0.15s;
		display: flex;
		align-items: center;
	}
</style>
