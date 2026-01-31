# Builder stage
FROM rust:alpine AS builder

# Install build dependencies
RUN apk add --no-cache musl-dev

WORKDIR /app

# Create a dummy project to cache dependencies
RUN cargo init
COPY Cargo.toml Cargo.lock ./
RUN cargo build --release
RUN rm src/*.rs

# Copy source code and build
COPY src ./src
# Touch the main file to invalidate the cached build
RUN touch src/main.rs
RUN cargo build --release

# Final stage
FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/target/release/always-ok .

ARG PORT=80
ENV PORT=${PORT}

EXPOSE ${PORT}

CMD ["./always-ok"]
