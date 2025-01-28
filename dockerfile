# Use the official Elixir image based on Alpine Linux
FROM elixir:1.14-alpine AS build

# Install build dependencies
RUN apk update && \
    apk add --no-cache build-base git nodejs npm

# Install Hex and Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Set the working directory
WORKDIR /app

# Force Git to use HTTP/1.1 to avoid HTTP/2 issues
RUN git config --global http.version HTTP/1.1

# Copy mix files and fetch dependencies to cache them
COPY mix.exs mix.lock ./
RUN mix deps.clean --all && mix deps.get && mix deps.compile

# Copy the rest of the application code
COPY . .

# Compile the project (if needed, or compile assets)
RUN mix compile

# Expose the Phoenix port (default 4000)
EXPOSE 4000

# Start the Phoenix server
CMD ["mix", "phx.server"]