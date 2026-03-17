import { describe, expect, test, beforeEach } from 'bun:test';
import type { Visit, VisitInsert } from './types';
import { VisitsDao, VisitNotFoundError, DuplicateVisitError, InvalidRatingError } from '.';
import { createMockSQL, createErrorSQL } from '../mock';

const visitRow: Visit = {
	id: 1n,
	user_id: 1n,
	place_id: 1n,
	summary: 'Great place!',
	rating: 5,
	visited_at: new Date('2024-01-01'),
	created_at: new Date('2024-01-01'),
	updated_at: new Date('2024-01-01')
};

const visitInsert: VisitInsert = {
	user_id: 1n,
	place_id: 1n,
	summary: 'Great place!',
	rating: 5,
	visited_at: new Date('2024-01-01')
};

describe('VisitsDao', () => {
	describe('retrieveVisit', () => {
		describe('success', () => {
			let dao: VisitsDao;
			beforeEach(() => {
				dao = new VisitsDao(createMockSQL([visitRow]));
			});

			test('retrieves a Visit', async () => {
				const visit = await dao.retrieveVisit(1n);
				expect(visit.summary).toEqual('Great place!');
			});
		});

		describe('errors', () => {
			test('throws VisitNotFoundError when visit does not exist', async () => {
				const dao = new VisitsDao(createMockSQL([]));
				expect(dao.retrieveVisit(1n)).rejects.toBeInstanceOf(VisitNotFoundError);
			});
		});
	});

	describe('listVisits', () => {
		describe('success', () => {
			let dao: VisitsDao;
			beforeEach(() => {
				dao = new VisitsDao(createMockSQL([visitRow]));
			});

			test('lists all visits', async () => {
				const visits = await dao.listVisits();
				expect(visits).toHaveLength(1);
			});
		});
	});

	describe('listVisitsByUser', () => {
		describe('success', () => {
			let dao: VisitsDao;
			beforeEach(() => {
				dao = new VisitsDao(createMockSQL([visitRow]));
			});

			test('lists visits by user', async () => {
				const visits = await dao.listVisitsByUser(1n);
				expect(visits).toHaveLength(1);
			});
		});
	});

	describe('listVisitsByPlace', () => {
		describe('success', () => {
			let dao: VisitsDao;
			beforeEach(() => {
				dao = new VisitsDao(createMockSQL([visitRow]));
			});

			test('lists visits by place', async () => {
				const visits = await dao.listVisitsByPlace(1n);
				expect(visits).toHaveLength(1);
			});
		});
	});

	describe('insertVisit', () => {
		describe('success', () => {
			let dao: VisitsDao;
			beforeEach(() => {
				dao = new VisitsDao(createMockSQL([visitRow]));
			});

			test('inserts and returns a visit', async () => {
				const visit = await dao.insertVisit(visitInsert);
				expect(visit.id).toBeDefined();
				expect(visit.summary).toBe('Great place!');
			});
		});

		describe('errors', () => {
			test('throws DuplicateVisitError on duplicate error', async () => {
				const dao = new VisitsDao(createErrorSQL('23505'));
				expect(dao.insertVisit(visitInsert)).rejects.toBeInstanceOf(DuplicateVisitError);
			});

			test('throws InvalidRatingError when rating is invalid', async () => {
				const dao = new VisitsDao(createErrorSQL('23514'));
				expect(dao.insertVisit(visitInsert)).rejects.toBeInstanceOf(InvalidRatingError);
			});
		});
	});

	describe('updateVisit', () => {
		describe('success', () => {
			let dao: VisitsDao;
			beforeEach(() => {
				dao = new VisitsDao(createMockSQL([{ ...visitRow, summary: 'Updated summary' }]));
			});

			test('updates visit', async () => {
				const updated = await dao.updateVisit(1n, { summary: 'Updated summary' });
				expect(updated.summary).toEqual('Updated summary');
			});
		});

		describe('errors', () => {
			test('throws VisitNotFoundError when visit does not exist', async () => {
				const dao = new VisitsDao(createMockSQL([]));
				expect(dao.updateVisit(1n, { summary: 'test' })).rejects.toBeInstanceOf(VisitNotFoundError);
			});

			test('throws DuplicateVisitError', async () => {
				const dao = new VisitsDao(createErrorSQL('23505'));
				expect(dao.updateVisit(1n, { summary: 'test' })).rejects.toBeInstanceOf(
					DuplicateVisitError
				);
			});

			test('throws InvalidRatingError when constraint is violated', async () => {
				const dao = new VisitsDao(createErrorSQL('23514'));
				expect(dao.updateVisit(1n, { rating: 10 })).rejects.toBeInstanceOf(InvalidRatingError);
			});
		});
	});

	describe('deleteVisit', () => {
		describe('success', () => {
			let dao: VisitsDao;
			beforeEach(() => {
				dao = new VisitsDao(createMockSQL([visitRow]));
			});

			test('deletes visit', async () => {
				const deleted = await dao.deleteVisit(1n);
				expect(deleted.id).toBe(1n);
			});
		});

		describe('errors', () => {
			test('throws VisitNotFoundError when visit does not exist', async () => {
				const dao = new VisitsDao(createMockSQL([]));
				expect(dao.deleteVisit(1n)).rejects.toBeInstanceOf(VisitNotFoundError);
			});
		});
	});
});
