_help:
  @just -l

pnpm-install:
  @pnpm install

dev: dev-frontend

dev-frontend: pnpm-install
  @cd frontend && pnpm run dev

lint: lint-frontend

lint-frontend: pnpm-install
  @cd frontend && pnpm run lint

format: format-frontend

format-frontend: pnpm-install
  @cd frontend && pnpm run lint:fix

build: build-frontend

build-frontend: pnpm-install
  @cd frontend && pnpm run build
