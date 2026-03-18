-- Revert migration
BEGIN;
DROP TABLE IF EXISTS visit_photos;
DROP TABLE IF EXISTS visits;
DROP INDEX IF EXISTS idx_places_name;
DROP TABLE IF EXISTS places;
DROP TABLE IF EXISTS users;
COMMIT;
