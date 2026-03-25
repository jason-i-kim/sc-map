<script lang="ts">
	import { enhance } from '$app/forms';
	import { VisitSchema } from '$lib/schemas/visit';
	import type { ActionResult } from '@sveltejs/kit';
	import ButtonGroup from '../ui/button-group/ButtonGroup.svelte';
	import Icon from '../ui/icon/Icon.svelte';
	import StarRating from '../ui/star-rating/StarRating.svelte';
	import { TextField } from '../ui/text-field';

	type Props = {
		googlePlaceId: string;
		onsubmit?: () => void;
	};

	let { googlePlaceId, onsubmit: onsuccess }: Props = $props();

	let formEl: HTMLFormElement;

	const enhanceVisit = () => {
		return async ({ result, update }: { result: ActionResult; update: () => Promise<void> }) => {
			await update();
			if (result.type === 'success') {
				onsuccess?.();
			}
		};
	};

	const MAX_REVIEW_LENGTH = 2000;

	let rating = $state(0);
	let review = $state('');
	let visitDate = $state('');
	let selectedType = $state<'RESTAURANT' | 'BAR' | 'BAKERY'>('RESTAURANT');
	let submitted = $state(false);

	const ratingError = $derived.by(() => {
		if (!submitted) return '';
		const result = VisitSchema.shape['rating'].safeParse(rating);
		return result.success ? '' : result.error.issues[0].message;
	});

	const reviewError = $derived.by(() => {
		if (!submitted) return '';
		const result = VisitSchema.shape['summary'].safeParse(review);
		return result.success ? '' : result.error.issues[0].message;
	});

	const isValid = $derived(
		VisitSchema.shape['rating'].safeParse(rating).success &&
			VisitSchema.shape['summary'].safeParse(review).success
	);

	export function submit() {
		submitted = true;
		if (isValid) {
			formEl.requestSubmit();
		}
	}

	export function reset() {
		submitted = false;
		visitDate = '';
	}
</script>

{#snippet restaurantIcon()}<Icon name="restaurant" />{/snippet}
{#snippet barIcon()}<Icon name="bar" />{/snippet}
{#snippet bakeryIcon()}<Icon name="bakery" />{/snippet}

<form
	bind:this={formEl}
	use:enhance={enhanceVisit}
	class="visit-form"
	method="POST"
	action="/map?/addVisit"
>
	<input type="hidden" name="googlePlaceId" value={googlePlaceId} />
	<input type="hidden" name="rating" value={rating} />
	<input type="hidden" name="selectedType" value={selectedType} />

	<div class="rating-field">
		<StarRating bind:value={rating} />
		{#if ratingError}
			<p class="rating-error" role="alert">{ratingError}</p>
		{/if}
	</div>

	<div class="field-row">
		<TextField
			variant="outlined"
			type="textarea"
			name="review"
			placeholder="Tell others about your experience"
			rows={6}
			bind:value={review}
			errorText={reviewError}
			maxlength={MAX_REVIEW_LENGTH}
		/>
	</div>

	<div class="field-row">
		<TextField
			variant="outlined"
			type="date"
			name="visitDate"
			supportingText="Date visited"
			aria-label="Date visited"
			bind:value={visitDate}
		/>
	</div>

	<div class="field-row">
		<ButtonGroup
			bind:selected={selectedType}
			toggleMode="single"
			buttonVariant="filled"
			items={[
				{ value: 'RESTAURANT', label: 'Restaurant', icon: restaurantIcon },
				{ value: 'BAR', label: 'Bar', icon: barIcon },
				{ value: 'BAKERY', label: 'Bakery', icon: bakeryIcon }
			]}
			aria-label="Location type"
			class="type-toggle"
		/>
	</div>
</form>

<style>
	@import './form.css';

	:global(.type-toggle) {
		width: 100%;
	}
</style>
