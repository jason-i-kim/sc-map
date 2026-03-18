import type { Meta, StoryObj } from '@storybook/svelte';
import SearchSuggestionList from './SearchSuggestionList.svelte';
import type { Suggestion } from '$lib/schemas/search';

const meta = {
	title: 'Search/SearchSuggestionList',
	component: SearchSuggestionList,
	tags: ['autodocs'],
	parameters: {
		layout: 'padded'
	}
} satisfies Meta<typeof SearchSuggestionList>;

export default meta;
type Story = StoryObj<typeof meta>;

const googleSuggestion = (
	place_id: string,
	name: string,
	formatted_address: string
): Suggestion => ({
	source: 'google',
	data: { place_id, name, formatted_address, geometry: { location: { lat: 0, lng: 0 } }, types: [] }
});

const dbSuggestion = (
	id: number,
	name: string,
	formatted_address: string,
	type: 'RESTAURANT' | 'BAR' | 'BAKERY'
): Suggestion => ({
	source: 'db',
	data: {
		id: String(id),
		name,
		formatted_address,
		type,
		lat: 0,
		lng: 0,
		google_place_id: `gp_${id}`,
		submitted_by: '1',
		created_at: new Date().toISOString()
	}
});

export const Default: Story = {
	args: {
		suggestions: [
			dbSuggestion(1, "Rao's Restaurant", '455 E 114th St, New York, NY 10029', 'RESTAURANT'),
			dbSuggestion(2, 'The Dead Rabbit', '30 Water St, New York, NY 10004', 'BAR'),
			dbSuggestion(3, 'Dominique Ansel Bakery', '189 Spring St, New York, NY 10012', 'BAKERY'),
			googleSuggestion('gp_a', 'Le Bernardin', '155 W 51st St, New York, NY 10019'),
			googleSuggestion('gp_b', 'Per Se', '10 Columbus Cir, New York, NY 10019')
		]
	}
};

export const DBOnly: Story = {
	args: {
		suggestions: [
			dbSuggestion(1, 'Nobu', '105 Hudson St, New York, NY 10013', 'RESTAURANT'),
			dbSuggestion(2, 'Employees Only', '510 Hudson St, New York, NY 10014', 'BAR'),
			dbSuggestion(3, 'Maison Kayser', '1294 3rd Ave, New York, NY 10021', 'BAKERY')
		]
	}
};

export const GoogleOnly: Story = {
	args: {
		suggestions: [
			googleSuggestion('gp_1', 'Times Square', 'Manhattan, New York, NY'),
			googleSuggestion('gp_2', 'Central Park', 'Manhattan, New York, NY'),
			googleSuggestion('gp_3', 'Brooklyn Bridge', 'Brooklyn, New York, NY')
		]
	}
};

export const SingleItem: Story = {
	args: {
		suggestions: [googleSuggestion('gp_1', 'San Francisco, CA', 'California, United States')]
	}
};

export const LongText: Story = {
	args: {
		suggestions: [
			dbSuggestion(
				1,
				"Rao's Restaurant - East Harlem, Manhattan, New York City",
				'455 E 114th St, New York, NY 10029, United States of America',
				'RESTAURANT'
			),
			googleSuggestion(
				'gp_1',
				'The French Laundry by Thomas Keller',
				'6640 Washington St, Yountville, Napa Valley, CA 94599'
			)
		]
	}
};

export const Empty: Story = {
	args: {
		suggestions: []
	}
};
