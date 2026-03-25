#!/bin/bash

set -e

migrations_dir="src/lib/db/migrations"
errors=0

for up_file in "$migrations_dir"/*.up.sql; do
  basename=$(basename "$up_file" .up.sql)
  down_file="${basename}.down.sql"
  down_path="$migrations_dir/$down_file"

  if [ ! -f "$down_path" ]; then
    echo "Error: $up_file is missing a corresponding $down_file"
    errors=$((errors + 1))
  fi

  if ! grep -q "^BEGIN;" "$up_file"; then
    echo "Error: $up_file is missing a BEGIN; transaction wrapper"
    errors=$((errors + 1))
  fi

  if ! grep -q "^COMMIT;" "$up_file"; then
    echo "Error: $up_file is missing a COMMIT; transaction wrapper"
    errors=$((errors + 1))
  fi

  if ! grep -q "^BEGIN;" "$down_path" 2>/dev/null; then
    echo "Error: $down_path is missing a BEGIN; transaction wrapper"
    errors=$((errors + 1))
  fi

  if ! grep -q "^COMMIT;" "$down_path" 2>/dev/null; then
    echo "Error: $down_path is missing a COMMIT; transaction wrapper"
    errors=$((errors + 1))
  fi
done

if [ "$errors" -gt 0 ]; then
  echo "Found $errors error(s) in migrations."
  exit 1
fi

echo "All migrations are valid (paired down files, transaction wrappers present)"
