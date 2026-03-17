import { type SQL, type TransactionSQL } from 'bun';

function isPostgresError(e: unknown): e is { errno: string } {
	return typeof e === 'object' && e !== null && 'errno' in e && typeof e.errno === 'string';
}

export class DuplicateGooglePlaceIdError extends Error {}
export class InvalidPlaceTypeError extends Error {}
export class UserNotFoundError extends Error {}

interface Place {
	id: bigint;
	name: string;
	lat: number;
	lng: number;
	google_place_id: string;
	type: 'RESTAURANT' | 'BAR' | 'BAKERY';
	submitted_by: bigint;
	created_at: Date;
}

type InsertPlace = Omit<Place, 'id' | 'created_at'>;

export class PlacesDao {
	constructor(private readonly sql: SQL) {}

	public async listPlaces() {
		const results = (await this.sql`
        SELECT * FROM places;
    `) as Place[];
		return results;
	}

	public async insertPlace(placeInsert: InsertPlace, tx?: TransactionSQL) {
		const sql = tx ?? this.sql;

		try {
			const [result] = (await sql`
	            INSERT INTO places ${sql(placeInsert)}
	            RETURNING *
	        `) as Place[];
			return result;
		} catch (e) {
			if (isPostgresError(e)) {
				if (e.errno === '23505') throw new DuplicateGooglePlaceIdError(placeInsert.google_place_id);
				if (e.errno === '23514') throw new InvalidPlaceTypeError(placeInsert.type);
				if (e.errno === '23503') throw new UserNotFoundError(String(placeInsert.submitted_by));
			}
			throw e;
		}
	}
}
