# PHP Packages for Alpine Linux

## Prepare

Local docker image needs to be built.

As the Dockerfile uses `docker/dockerfile:experimental` syntax, need to enable buildkit build:

```
$ COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker-compose build
```

## Building packages

```
# Enter the container
$ ./shell.sh
# Pick a package
$ cd php7
# Build it
$ abuild -r
```
