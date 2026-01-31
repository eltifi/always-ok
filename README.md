# always-ok

A minimal web server built with Rust and Hyper that returns `200 OK` on all endpoints.

## Features

- **Minimal Footprint**: Built on `hyper` (v1) for raw performance and low overhead.
- **Microservice Ready**: Configurable via environment variables.
- **Dockerized**: Optimized Alpine-based image (~12MB).

## Configuration

| Environment Variable | Description | Default |
|----------------------|-------------|---------|
| `PORT`               | The port the server listens on. | `80`    |


## Running Locally

1. Install dependencies and run:
   ```bash
   cargo run
   ```
   *Note: Binding to port 80 may require elevated privileges (e.g., `sudo cargo run`).*

   To run on a different port (e.g., 3000):
   ```bash
   PORT=3000 cargo run
   ```
2. The server will start on `0.0.0.0:80` (or your configured port).

## Running with Docker

1. Build the image:
   ```bash
   docker build -t always-ok .
   ```
   To build with a custom default port:
   ```bash
   docker build --build-arg PORT=3000 -t always-ok .
   ```

2. Run the container:
   ```bash
   docker run -p 80:80 always-ok
   ```
   To run with a custom port at runtime:
   ```bash
   docker run -d -p 3000:3000 -e PORT=3000 always-ok
   ```

## Running from GitHub Container Registry (GHCR)

The Docker image is automatically built and pushed to GitHub Container Registry (GHCR) on pushes to `main`.

1. Pull the image:
   ```bash
   docker pull ghcr.io/eltifi/always-ok:latest
   ```
2. Run the container:
   ```bash
   docker run -d -p 80:80 ghcr.io/eltifi/always-ok:latest
   ```

## API

- **Any Method** `/*`: Returns `200 OK` with an empty body.

