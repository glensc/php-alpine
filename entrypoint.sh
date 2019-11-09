#!/bin/sh
set -eu

# https://github.com/karelzak/util-linux/issues/325
switch_user() {
	local user="packager"
	local uid=$(id -u "$user")
	local gid=$(id -g "$user")

	exec setpriv --euid "$uid" --ruid "$uid" --init-groups --egid "$gid" --rgid "$gid" -- env HOME=/home/packager "$@"
}

maybe_chown() {
	test -e "$2" || return 0
	chown "$@"
}

fix_permissions() {
	maybe_chown packager:abuild /build
	maybe_chown packager:abuild /home/packager/.abuild/keys
}

# do some common init, then switch user and execute original entrypoint
# this needs to be invoked as root
if [ "$(id -u)" = "0" ]; then
	fix_permissions
	switch_user "$0" "$@"
fi

exec "$@"
