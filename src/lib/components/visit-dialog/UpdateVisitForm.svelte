<script lang="ts">
	import { enhance } from '$app/forms';
	import { VisitSchema, type Visit } from '$lib/schemas/visit';
	import type { ActionResult } from '@sveltejs/kit';
	import { untrack } from 'svelte';
	import StarRating from '../ui/star-rating/StarRating.svelte';
	import { TextField } from '../ui/text-field';

	type Props = {
		action: '/map?/updateVisit';
		defaults: Pick<Visit, 'id' | 'rating' | 'summary' | 'visited_at'>;
		onsubmit?: () => void;
	};

	let { action, defaults, onsubmit: onsuccess }: Props = $props();

	let formEl: HTMLFormElement;

	const enhanceVisit = () => {
		return async ({ result, update }: { result: ActionResult; update: () => Promise<void> }) => {
			await update();
			if (result.type === 'success') {
				onsuccess?.();
			}
		};
	};

	export const submit = () => {
		formEl.requestSubmit();
	};

	const MAX_REVIEW_LENGTH = 2000;

	let rating = $state(untrack(() => defaults.rating));
	let review = $state(untrack(() => defaults.summary));
	let visitDate = $state(untrack(() => defaults.visited_at.toISOString().split('T')[0]));
	let submitted = $state(false);

	const ratingError = $derived.by(() => {
		if (!submitted) {
			return '';
		}

		const parseResult = VisitSchema.shape['rating'].safeParse(rating);

		if (parseResult.success) {
			return '';
		}

		return parseResult.error.issues[0].message;
	});

	const reviewError = $derived.by(() => {
		if (!submitted) {
			return '';
		}

		const parseResult = VisitSchema.shape['summary'].safeParse(review);

		if (parseResult.success) {
			return '';
		}

		return parseResult.error.issues[0].message;
	});
</script>

<form bind:this={formEl} use:enhance={enhanceVisit} class="visit-form" method="POST" {action}>
	<input type="hidden" name="rating" value={rating} />
	<input type="hidden" name="visitId" value={defaults.id} />

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
</form>

<style>
	@import './form.css';
</style>
