import type { Meta, StoryObj } from '@storybook/svelte';
import { fn } from 'storybook/test';
import SearchSuggestion from './SearchSuggestion.svelte';
import PinIcon from '$lib/icons/PinIcon.svelte';

const meta = {
	title: 'Search/SearchSuggestion',
	component: SearchSuggestion,
	tags: ['autodocs'],
	parameters: {
		layout: 'padded'
	},
	args: {
		onclick: fn()
	}
} satisfies Meta<typeof SearchSuggestion>;

export default meta;
type Story = StoryObj<typeof meta>;

export const GooglePlace: Story = {
	args: {
		icon: PinIcon,
		primary: 'New York, NY',
		secondary: 'New York, United States'
	}
};

export const Restaurant: Story = {
	args: {
		icon: { color: '#E8472A', glyph: '🍽️' },
		primary: "Rao's Restaurant",
		secondary: '455 E 114th St, New York, NY 10029'
	}
};

export const Bar: Story = {
	args: {
		icon: { color: '#6B4FBB', glyph: '🍸' },
		primary: 'The Dead Rabbit',
		secondary: '30 Water St, New York, NY 10004'
	}
};

export const Bakery: Story = {
	args: {
		icon: { color: '#F0A500', glyph: '🥐' },
		primary: 'Dominique Ansel Bakery',
		secondary: '189 Spring St, New York, NY 10012'
	}
};

export const LongPrimaryText: Story = {
	args: {
		icon: PinIcon,
		primary: "Rao's Restaurant - East Harlem, Manhattan, New York City",
		secondary: '455 E 114th St, New York, NY 10029'
	}
};

export const LongSecondaryText: Story = {
	args: {
		icon: PinIcon,
		primary: 'The French Laundry',
		secondary: '6640 Washington St, Yountville, CA 94599, United States of America'
	}
};

export const ShortName: Story = {
	args: {
		icon: PinIcon,
		primary: "Joe's",
		secondary: 'Bar'
	}
};
