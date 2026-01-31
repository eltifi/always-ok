# Builder Stage
FROM rust:alpine AS builder

WORKDIR /app

# Install build dependencies for Alpine (musl-dev required)
RUN apk add --no-cache musl-dev

# Copy manifest
COPY Cargo.toml Cargo.lock ./

# Create dummy main.rs to build dependencies
RUN mkdir -p src && echo "fn main() {}" > src/main.rs

# Build release dependencies (this layer is cached)
RUN cargo build --release

# Clean up dummy build artifacts to force rebuild of main.rs
RUN rm src/main.rs target/release/deps/always_ok*

# Copy actual source
COPY src ./src

# Build release binary
RUN cargo build --release

# Runtime Stage
FROM alpine:latest

WORKDIR /app

# Copy binary from builder
COPY --from=builder /app/target/release/always-ok /app/always-ok

# Build arguments
ARG PORT=80

# Environment Defaults
ENV PORT=${PORT}

# Expose port
EXPOSE ${PORT}

# Run
CMD ["/app/always-ok"]
