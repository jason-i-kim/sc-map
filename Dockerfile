# Stage 1: Build
FROM oven/bun:1 AS builder
WORKDIR /app

COPY package.json bun.lock* ./
RUN bun install

COPY . .

# PUBLIC_ vars are baked into the client bundle at build time
ARG PUBLIC_GOOGLE_MAPS_API_KEY
ENV PUBLIC_GOOGLE_MAPS_API_KEY=$PUBLIC_GOOGLE_MAPS_API_KEY

RUN bun run build

# Stage 2: Production runner
FROM oven/bun:1-slim AS runner
WORKDIR /app
ENV NODE_ENV=production

# App server (adapter-node output)
COPY --from=builder /app/build ./build

# Migration runner — scripts/migrate.ts uses only Bun built-ins (SQL, fs, path)
COPY --from=builder /app/scripts ./scripts
COPY --from=builder /app/src/lib/db/migrations ./src/lib/db/migrations

# Production deps for the app server (zod, @tanstack/svelte-query, etc.)
COPY --from=builder /app/package.json /app/bun.lock* ./
RUN bun install --production

COPY docker-entrypoint.sh ./
RUN chmod +x docker-entrypoint.sh

EXPOSE 3000
ENTRYPOINT ["./docker-entrypoint.sh"]
