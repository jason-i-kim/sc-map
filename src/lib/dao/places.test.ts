import { SQL } from 'bun';
import { expect, test } from 'bun:test';

import {
	PlacesDao,
	DuplicateGooglePlaceIdError,
	InvalidPlaceTypeError,
	UserNotFoundError
} from './places';
import { beforeEach, describe } from 'node:test';

const testSQL = new SQL(process.env.TEST_SQL_URL!);

describe('PlacesDao', () => {
	let placesDao: PlacesDao;
	beforeEach(() => {
		placesDao = new PlacesDao(testSQL);
	});
	describe('insertPlace', () => {
		test('inserts and returns a place', async () => {
			const [user] = await testSQL`
				INSERT INTO users (discord_id, discord_handle)
				VALUES ('123', 'testuser')
				RETURNING *`;

			const place = await placesDao.insertPlace({
				name: 'Test Bakery',
				lat: 40.7128,
				lng: -74.006,
				google_place_id: 'abc123',
				type: 'BAKERY',
				submitted_by: user.id
			});

			expect(place.id).toBeDefined();
			expect(place.name).toBe('Test Bakery');
			expect(place.google_place_id).toBe('abc123');
			expect(place.type).toBe('BAKERY');
			expect(place.submitted_by).toBe(user.id);
		});

		test('throws DuplicateGooglePlaceIdError on duplicate google_place_id', async () => {
			const [user] = await testSQL`
				INSERT INTO users (discord_id, discord_handle)
				VALUES ('123', 'testuser')
				RETURNING *`;

			const placeInsert = {
				name: 'Test Bakery',
				lat: 40.7128,
				lng: -74.006,
				google_place_id: 'abc123',
				type: 'BAKERY' as const,
				submitted_by: user.id
			};

			await placesDao.insertPlace(placeInsert);
			expect(placesDao.insertPlace(placeInsert)).rejects.toBeInstanceOf(
				DuplicateGooglePlaceIdError
			);
		});

		test('throws InvalidPlaceTypeError on invalid type', async () => {
			const [user] = await testSQL`
				INSERT INTO users (discord_id, discord_handle)
				VALUES ('123', 'testuser')
				RETURNING *`;

			expect(
				placesDao.insertPlace({
					name: 'Test Bakery',
					lat: 40.7128,
					lng: -74.006,
					google_place_id: 'abc123',
					type: 'INVALID' as 'BAKERY',
					submitted_by: user.id
				})
			).rejects.toBeInstanceOf(InvalidPlaceTypeError);
		});

		test('throws UserNotFoundError when submitted_by user does not exist', async () => {
			expect(
				placesDao.insertPlace({
					name: 'Test Bakery',
					lat: 40.7128,
					lng: -74.006,
					google_place_id: 'abc123',
					type: 'BAKERY',
					submitted_by: BigInt(999999)
				})
			).rejects.toBeInstanceOf(UserNotFoundError);
		});
	});
});
