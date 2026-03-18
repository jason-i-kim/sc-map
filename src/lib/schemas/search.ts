import { z } from 'zod';

export const GoogleSuggestionSchema = z.object({
	source: z.literal('google'),
	data: z.object({
		place_id: z.string(),
		name: z.string(),
		formatted_address: z.string(),
		geometry: z.object({
			location: z.object({ lat: z.number(), lng: z.number() })
		}),
		types: z.array(z.string())
	})
});

export const DBSuggestionSchema = z.object({
	source: z.literal('db'),
	data: z.object({
		id: z.string(),
		name: z.string(),
		lat: z.number(),
		lng: z.number(),
		formatted_address: z.string(),
		google_place_id: z.string(),
		type: z.enum(['RESTAURANT', 'BAR', 'BAKERY']),
		submitted_by: z.string(),
		created_at: z.string()
	})
});

export const SuggestionSchema = z.discriminatedUnion('source', [
	DBSuggestionSchema,
	GoogleSuggestionSchema
]);

export type Suggestion = z.infer<typeof SuggestionSchema>;
