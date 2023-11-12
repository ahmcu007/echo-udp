# Elixir UDP Echo Service

## Description
This project is a simple UDP Echo service written in Elixir, designed to run seamlessly on [Fly.io](https://fly.io). It serves as a basic example of handling UDP packets in Elixir, echoing back any received messages.

## Features
* UDP packet handling in Elixir.
* Simple and efficient echoing of messages.
* Ready to deploy on [Fly.io](https://fly.io) with minimal configuration.
* Docker support for containerization and easy deployment.

## Requirements
Elixir (version [specify version])

## Installation
To set up the project locally, follow these steps:

```bash
git clone https://github.com/ahmcu007/echo-udp
cd echo-upd
# Install dependencies
mix deps.get
```

## Usage
Once the service is up and running, it listens for UDP packets on a specified port. You can send a UDP packet using a tool like `netcat`:

```bash
echo "Your message" | nc -u -w1 [host] [port]
```

## Deployment
To deploy this service to Fly.io, follow these steps:

* Configure `fly.toml` with your specific settings.
* Deploy using Fly CLI:
```bash
fly deploy
```
## Docker Support
To build and run the service using Docker:

```bash
docker build -t echo-udp-service .
docker run -p [local-port]:[container-port] echo-udp-service
```
## Testing
Run the tests using the following command:

```bash 
mix test
```

## Contributing
Contributions to this project are welcome. Please submit pull requests or raise issues on the repository page.

## License
This project is released under the `MIT License`.

## Acknowledgments
Thanks to  those in the Elixir communittywho inspired this project.
