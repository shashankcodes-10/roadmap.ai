# syntax=docker/dockerfile:1

FROM node:22-slim AS deps
WORKDIR /app
# better-sqlite3 (local-dev-only DB driver) has no prebuilt binary for every
# platform/Node combo and falls back to compiling from source via node-gyp.
# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y --no-install-recommends \
  python3 make g++ \
  && rm -rf /var/lib/apt/lists/*
COPY package.json package-lock.json ./
RUN npm ci

FROM node:22-slim AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
# Build-time values are placeholders — the app reads real env vars at request
# time in production (Turso client, Auth.js), nothing secret is baked in.
ENV AUTH_SECRET=build-placeholder
ENV NEXT_TELEMETRY_DISABLED=1
RUN npm run build

FROM node:22-slim AS runner
WORKDIR /app
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

# Patch known-vulnerable OS packages (e.g. libpcre2-8-0 CVE-2026-86145/89161)
# and drop npm/yarn/corepack — unused at runtime since we run the standalone
# server directly, not via npm. This also removes all Trivy-flagged CVEs
# bundled inside npm's own node_modules.
# hadolint ignore=DL3008
RUN apt-get update && apt-get upgrade -y libpcre2-8-0 \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /usr/local/lib/node_modules/npm /opt/yarn-v1.22.22 \
       /usr/local/bin/npm /usr/local/bin/npx /usr/local/bin/corepack

RUN groupadd --system --gid 1001 nodejs \
  && useradd --system --uid 1001 --gid nodejs nextjs

COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

USER nextjs
EXPOSE 3000
ENV PORT=3000
CMD ["node", "server.js"]