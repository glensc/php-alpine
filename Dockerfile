# syntax = docker/dockerfile:experimental
#
# Requires Docker v18.06 or later and BuildKit mode to use cache mount
# Docker v18.06 also requires the daemon to be running in experimental mode.
#
# $ DOCKER_BUILDKIT=1 docker build .
# $ COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker-compose build
#
# See https://github.com/moby/buildkit/blob/master/frontend/dockerfile/docs/experimental.md

ARG ALPINE_VERSION=3.10
FROM alpine:$ALPINE_VERSION

ARG ALPINE_VERSION=3.10

WORKDIR /v$ALPINE_VERSION
RUN --mount=type=cache,id=apk,target=/var/cache/apk \
	set -x \
	&& ln -vs /var/cache/apk /etc/apk/cache \
	&& apk add \
		alpine-sdk \
		bash \
		ccache \
		setpriv \
		vim \
	&& adduser -D -u 1000 -g 1000 -G abuild packager \
	&& exit 0

ENV PATH "/usr/lib/ccache/bin:$PATH"

COPY sudoers /etc/sudoers.d/packager
COPY entrypoint.sh /abuild
ENTRYPOINT ["/abuild"]
