_help:
  @just -l

pnpm-install:
  @pnpm install

dev: dev-frontend

dev-frontend: pnpm-install
  @cd frontend && pnpm run dev

dev-backend: pnpm-install
  @cd backend && pnpm run dev

lint: lint-frontend

lint-frontend: pnpm-install
  @cd frontend && pnpm run lint

lint-backend: pnpm-install
  @cd backend && pnpm run lint

format: format-frontend

format-frontend: pnpm-install
  @cd frontend && pnpm run lint:fix

format-backend: pnpm-install
  @cd backend && pnpm run lint:fix

build: build-frontend

build-frontend: pnpm-install
  @cd frontend && pnpm run build

build-backend: pnpm-install
  @cd backend && pnpm run build

test: test-backend

test-backend: pnpm-install
  @cd backend && pnpm run test
