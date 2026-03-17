export type Category = 'restaurant' | 'bar' | 'bakery';

interface CategoryConfig {
	label: string;
	color: string;
	glyphText: string;
}

export const CATEGORIES: Record<Category, CategoryConfig> = {
	restaurant: { label: 'Restaurants', color: '#EA4335', glyphText: '🍽' },
	bar: { label: 'Bars', color: '#4285F4', glyphText: '🍸' },
	bakery: { label: 'Bakeries', color: '#FBBC04', glyphText: '🥐' }
};

export type Place = {
	name: string;
	lat: number;
	lng: number;
	category: Category;
};
