# Use Ubuntu 24.04 as the base image
FROM ubuntu:24.04 AS builder

# Install required dependencies
RUN apt-get update && apt-get install -y curl git

# Use Hermit dependencies
COPY ./bin /app/bin
ENV PATH="/app/bin:$PATH"

# Set the working directory for the build process
WORKDIR /app

# Copy Justfile and workspace configuration
COPY Justfile pnpm-workspace.yaml ./

# Copy all package.json files from workspaces
COPY frontend/package.json ./frontend/
COPY backend/package.json ./backend/

# Install all dependencies, including dev dependencies using pnpm via Hermit
RUN just pnpm-install

# Copy the rest of the code
COPY . .

# Build both frontend and backend using just
RUN just build

# Frontend Stage
FROM ubuntu:24.04 AS frontend

# Install curl for Hermit to work properly
RUN apt-get update && apt-get install -y curl git

# Set PNPM_HOME for global installations
ENV PNPM_HOME=/app/.pnpm
ENV PATH=$PNPM_HOME:$PATH

# Create the PNPM_HOME directory
RUN mkdir -p /app/.pnpm

WORKDIR /app/frontend

# Use Hermit dependencies
COPY ./bin /app/bin
ENV PATH="/app/bin:$PATH"

# Install pnpm dependencies for frontend using Hermit
COPY --from=builder /app/frontend ./
RUN pnpm install

# Install Vite globally
RUN pnpm add vite -g

EXPOSE 3000

# Use Vite's dev server
CMD ["vite", "--host", "0.0.0.0"]

# Backend Stage
FROM ubuntu:24.04 AS backend

# Install curl for Hermit to work properly
RUN apt-get update && apt-get install -y curl git

WORKDIR /app/backend

# Use Hermit dependencies
COPY ./bin /app/bin
ENV PATH="/app/bin:$PATH"

# Copy the necessary backend files
COPY --from=builder /app/backend/dist ./dist
COPY --from=builder /app/backend/package.json ./

# Install backend dependencies using pnpm
RUN pnpm install

EXPOSE 4000

ENV PORT=4000

CMD ["node", "dist/server.js"]
