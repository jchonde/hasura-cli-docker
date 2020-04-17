# hasura-cli-docker

Runs the [hasura CLI](https://github.com/hasura/graphql-engine) in a container

## Setup

Build the Docker image with (using Git)

```sh
docker build -t hasura-cli https://github.com/jchonde/hasura-cli-docker.git
```

## Usage

```sh
docker run --rm -ti \
-p 127.0.0.1:9695:9695/tcp -p 127.0.0.1:9693:9693 \
-v "$(pwd)/migrations:/migrations" \
hasura-cli --help
```

By default, the following cmd arguments are used:
`console --no-browser --address 0.0.0.0 --endpoint http://host.docker.internal:80`

You might want to setup an alias in your `~/.profile` file:

```sh
alias harusa='docker run --rm -ti -p 127.0.0.1:9695:9695/tcp -p 127.0.0.1:9693:9693 -v "$(pwd)/migrations:/migrations" hasura-cli'
```

So that you can run `harusa --help` as if you had the binary installed.
