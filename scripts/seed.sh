#!/bin/bash
set -e

SEED_DIR="$(dirname "$0")/../src/lib/db/seed"
CONTAINER="sc-map-db-1"

seeds=$(find "$SEED_DIR" -name "*.sql" | sort)

if [ -z "$seeds" ]; then
    echo "No seed files found."
    exit 0
fi

count=0
for seed in $seeds; do
    echo "Running: $(basename "$seed")"
    docker exec -i "$CONTAINER" psql -U sc_map -d sc_map < "$seed"
    count=$((count + 1))
done

echo "Done. Ran $count seed file(s)."
