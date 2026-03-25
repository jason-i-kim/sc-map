<script lang="ts">
	import { Button } from './ui/button';
	import Dialog from './ui/dialog/Dialog.svelte';
	import AddVisitForm from './visit-dialog/AddVisitForm.svelte';

	type Props = {
		open: boolean;
		placeName: string;
		googlePlaceId: string;
		onclose?: () => void;
		onsuccess?: () => void;
	};

	let { open = $bindable(false), placeName, googlePlaceId, onclose, onsuccess }: Props = $props();
	let form: ReturnType<typeof AddVisitForm>;

	const handleClose = () => {
		open = false;
		form?.reset();
		onclose?.();
	};

	const handleSuccess = () => {
		onsuccess?.();
		handleClose();
	};
</script>

<Dialog {open} onclose={handleClose}>
	{#snippet headline()}<span class="headline-centered">{placeName}</span>{/snippet}
	<AddVisitForm bind:this={form} {googlePlaceId} onsubmit={handleSuccess} />

	<div class="md-dialog__actions">
		<Button variant="text" onclick={handleClose}>Cancel</Button>
		<Button variant="text" onclick={() => form.submit()}>Post</Button>
	</div>
</Dialog>

<style>
	.headline-centered {
		display: block;
		text-align: center;
	}
</style>
