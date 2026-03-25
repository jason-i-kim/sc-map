BEGIN;
DROP INDEX IF EXISTS idx_saved_places_name;
CREATE INDEX IF NOT EXISTS idx_saved_places_name ON saved_places USING GIN (to_tsvector('simple', name));
COMMIT;
