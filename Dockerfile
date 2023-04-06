# Use the official Elixir image as the base image
FROM elixir:1.14 AS build

# Set the working directory
WORKDIR /app

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Copy the mix.exs and mix.lock files
COPY mix.exs ./

# Install dependencies
RUN mix deps.get

# Copy the source code
COPY lib lib

# Compile the application
RUN MIX_ENV=prod mix compile

# Create the release
RUN MIX_ENV=prod mix release

# Start a new stage for the runtime
FROM elixir:1.14 AS runtime

# Set the working directory
WORKDIR /app

# Copy the release from the build stage
COPY --from=build /app/_build/prod/rel/echo_udp /app

# Expose the UDP port
EXPOSE 5002/udp

# Set the entrypoint
ENTRYPOINT ["/app/bin/echo_udp"]
CMD ["start"]
