import type { Place, Category } from '$lib/types';

const restaurantNames = [
	'The Golden Fork',
	'Oak & Ember',
	'Salt & Pine',
	'The Blue Plate',
	'Harvest Table',
	'Iron Skillet',
	'The Rustic Spoon',
	'Ember & Ash',
	'The Local Table',
	'Wildflower Kitchen',
	'Stone & Rye',
	'The Brass Rail',
	'Cedar & Smoke',
	'The Copper Pot',
	'River Bend Bistro',
	'The Larder',
	'Fieldstone Kitchen',
	'The Wayward Fork',
	'Birch & Barley',
	'The Provisions',
	'Woodsmoke',
	'The Hungry Bear',
	'Sage & Salt',
	'The Millhouse',
	'Canyon Kitchen',
	'The Painted Table',
	'Prairie Bistro',
	'The Sundial',
	'Clover & Cane',
	'The Foundry',
	'Redwood Table',
	'The Homestead',
	'Drift Kitchen',
	'The Whetstone',
	'Mesa Verde Café',
	'Tidal Kitchen',
	'The Granary',
	'Shoreline Bistro',
	'The Boxcar',
	'Plateau Kitchen'
];

const barNames = [
	'The Rusty Nail',
	'Copper & Oak',
	'The Wayward Pint',
	'Barrel & Beam',
	'The Tap Room',
	'Iron & Rye',
	'The Blind Pig',
	'Dusk & Dram',
	'The Anchor',
	'Nightcap Lounge',
	'The Cellars',
	'Last Call',
	'The Depot',
	'Smoke & Mirrors',
	'The Backstop',
	'Bitters & Bones',
	'The Fox & Hound',
	'Cold Shoulder Bar',
	'The Undertow',
	'High Proof',
	'The Stumble Inn',
	'Rooftop & Rye',
	'The Draught House',
	'Bent Elbow',
	'The Tap & Die',
	'Still Waters',
	'The Long Pour',
	'Side Door Bar',
	'The Keg Stand',
	'Muddy Waters',
	'The Half Crown',
	'Pint & Pistol',
	'The Overflow',
	'Gravel & Grain',
	'The Swill',
	'Two Fingers',
	'The Tipsy Crow',
	"Ol' No. 7",
	'The Whistle Stop',
	'Last Round'
];

const bakeryNames = [
	'Morning Glory Bakery',
	'The Flour Pot',
	'Golden Crumb',
	'The Bread Box',
	'Sweet Rise',
	'The Daily Loaf',
	'Hearth & Crumb',
	'The Rolling Pin',
	'Proof Bakery',
	'Grain & Glory',
	'The Butter Block',
	'Wild Yeast',
	'The Dough House',
	'Crumble & Co',
	'Knead Bakery',
	'The Laminated',
	'Sourdough & Sons',
	'The Oven Door',
	'Stonemill Bakery',
	'Rise & Shine',
	'The Biscuit Box',
	'Crust & Crumb',
	'The Folded',
	'Upper Crust',
	'Little Loaf',
	'The Batch',
	'Flour & Stone',
	'Sunday Bakery',
	'The Starter',
	'Warm Bread Co.',
	'The Pullman',
	'Good Grain',
	'The Patisserie',
	'Levain & Co',
	'Old Hearth Bakery',
	'The Crumpet',
	'Twisted Grain',
	'The Brioche',
	'Mill & Bloom',
	'The Proofing Box'
];

const namesByCategory: Record<Category, string[]> = {
	restaurant: restaurantNames,
	bar: barNames,
	bakery: bakeryNames
};

const categories: Category[] = ['restaurant', 'bar', 'bakery'];

// Approximate bounding box for the contiguous US
const US_BOUNDS = { minLat: 25, maxLat: 49, minLng: -124, maxLng: -67 };

function randomBetween(min: number, max: number) {
	return min + Math.random() * (max - min);
}

let nameCounters: Record<Category, number> = { restaurant: 0, bar: 0, bakery: 0 };

function nextName(category: Category): string {
	const names = namesByCategory[category];
	const i = nameCounters[category] % names.length;
	const suffix =
		nameCounters[category] >= names.length
			? ` ${Math.floor(nameCounters[category] / names.length) + 1}`
			: '';
	nameCounters[category]++;
	return names[i] + suffix;
}

export function generatePlaces(count: number): Place[] {
	nameCounters = { restaurant: 0, bar: 0, bakery: 0 };
	return Array.from({ length: count }, (_, i) => {
		const category = categories[i % categories.length];
		return {
			name: nextName(category),
			lat: randomBetween(US_BOUNDS.minLat, US_BOUNDS.maxLat),
			lng: randomBetween(US_BOUNDS.minLng, US_BOUNDS.maxLng),
			category
		};
	});
}
