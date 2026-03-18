import type { Meta, StoryObj } from '@storybook/svelte';
import SearchResultList from './SearchResultList.svelte';
import type { SearchResult } from '$lib/schemas/search';

const meta = {
	component: SearchResultList,
	tags: ['autodocs'],
	parameters: {
		layout: 'padded'
	}
} satisfies Meta<typeof SearchResultList>;

export default meta;
type Story = StoryObj<typeof meta>;

const googleResult = (
	google_place_id: string,
	name: string,
	formatted_address: string
): SearchResult => ({
	name,
	formatted_address,
	google_place_id,
	lat: 40.7128,
	lng: -74.006,
	type: 'RESTAURANT'
});

const savedPlace = (
	id: bigint,
	name: string,
	formatted_address: string,
	type: 'RESTAURANT' | 'BAR' | 'BAKERY'
): SearchResult => ({
	id,
	name,
	formatted_address,
	google_place_id: `gp_${id}`,
	lat: 40.7128,
	lng: -74.006,
	type,
	submitted_by: 1n,
	created_at: new Date('2024-01-01')
});

export const Default: Story = {
	args: {
		searchResults: [
			savedPlace(1n, "Rao's Restaurant", '455 E 114th St, New York, NY 10029', 'RESTAURANT'),
			savedPlace(2n, 'The Dead Rabbit', '30 Water St, New York, NY 10004', 'BAR'),
			savedPlace(3n, 'Dominique Ansel Bakery', '189 Spring St, New York, NY 10012', 'BAKERY'),
			googleResult('gp_a', 'Le Bernardin', '155 W 51st St, New York, NY 10019'),
			googleResult('gp_b', 'Per Se', '10 Columbus Cir, New York, NY 10019')
		]
	}
};

export const SavedOnly: Story = {
	args: {
		searchResults: [
			savedPlace(1n, 'Nobu', '105 Hudson St, New York, NY 10013', 'RESTAURANT'),
			savedPlace(2n, 'Employees Only', '510 Hudson St, New York, NY 10014', 'BAR'),
			savedPlace(3n, 'Maison Kayser', '1294 3rd Ave, New York, NY 10021', 'BAKERY')
		]
	}
};

export const GoogleOnly: Story = {
	args: {
		searchResults: [
			googleResult('gp_1', 'Times Square', 'Manhattan, New York, NY'),
			googleResult('gp_2', 'Central Park', 'Manhattan, New York, NY'),
			googleResult('gp_3', 'Brooklyn Bridge', 'Brooklyn, New York, NY')
		]
	}
};

export const SingleItem: Story = {
	args: {
		searchResults: [googleResult('gp_1', 'San Francisco, CA', 'California, United States')]
	}
};

export const LongText: Story = {
	args: {
		searchResults: [
			savedPlace(
				1n,
				"Rao's Restaurant - East Harlem, Manhattan, New York City",
				'455 E 114th St, New York, NY 10029, United States of America',
				'RESTAURANT'
			),
			googleResult(
				'gp_1',
				'The French Laundry by Thomas Keller',
				'6640 Washington St, Yountville, Napa Valley, CA 94599'
			)
		]
	}
};

export const Empty: Story = {
	args: {
		searchResults: []
	}
};
