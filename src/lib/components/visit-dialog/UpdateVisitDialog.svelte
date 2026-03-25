<script lang="ts">
	import type { Visit } from '$lib/schemas/visit';
	import { Button } from '../ui/button';
	import Dialog from '../ui/dialog/Dialog.svelte';
	import UpdateVisitForm from './UpdateVisitForm.svelte';

	type Props = {
		open: boolean;
		placeName: string;
		defaults: Pick<Visit, 'id' | 'rating' | 'summary' | 'visited_at'>;
		onclose?: () => void;
		onsuccess?: () => void;
	};

	let { open = $bindable(false), defaults, placeName, onclose, onsuccess }: Props = $props();
	let form: ReturnType<typeof UpdateVisitForm>;

	const handleClose = () => {
		open = false;
		onclose?.();
	};
</script>

<Dialog {open} onclose={handleClose}>
	{#snippet headline()}<span class="headline-centered">{placeName}</span>{/snippet}
	<UpdateVisitForm
		bind:this={form}
		action="/map?/updateVisit"
		{defaults}
		onsubmit={() => {
			onsuccess?.();
			handleClose();
		}}
	/>

	<div class="md-dialog__actions">
		<Button variant="text" onclick={handleClose}>Cancel</Button>
		<Button variant="text" onclick={() => form.submit()} type="submit">Update</Button>
	</div>
</Dialog>
