#!/bin/sh
set -e


if [ -d "$HOME" ]; then
    chown -R "${USER_UID:-1000}:${USER_GID:-1000}" "$HOME"
fi

mkdir -p "$HOME/.cache"
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.openvscode-server"
chown -R "${USER_UID:-1000}:${USER_GID:-1000}" "$HOME/.cache"
chown -R "${USER_UID:-1000}:${USER_GID:-1000}" "$HOME/.config"
chown -R "${USER_UID:-1000}:${USER_GID:-1000}" "$HOME/.openvscode-server"

exec "${OPENVSCODE_SERVER_ROOT}/bin/openvscode-server" \
    --host 0.0.0.0 \
    --without-connection-token "$@"