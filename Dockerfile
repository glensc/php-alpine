ARG ALPINE_VERSION=3.10
FROM alpine:$ALPINE_VERSION

ARG ALPINE_VERSION=3.10

WORKDIR /v$ALPINE_VERSION
RUN set -x \
	&& apk add --no-cache alpine-sdk \
	&& adduser -D -u 1000 -g 1000 -G abuild packager \
	&& ln -s /var/cache/apk /etc/apk/cache \
	&& exit 0

COPY sudoers /etc/sudoers.d/packager
USER packager
