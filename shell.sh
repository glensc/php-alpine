#!/bin/sh

exec docker-compose run --rm abuild ${1:+"$@"} ${1:-bash}
