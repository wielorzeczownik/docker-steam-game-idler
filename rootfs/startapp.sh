#!/bin/sh
set -eu

export HOME=/config
# Xvnc has no GPU, so keep WebKitGTK off its DMA-BUF renderer
export WEBKIT_DISABLE_DMABUF_RENDERER=1
cd /config

# The keyring holds the Steam session, so it needs a bus and an unlocked secrets daemon
exec dbus-run-session -- sh -c 'echo "" | gnome-keyring-daemon --unlock --components=secrets >/dev/null; exec "/usr/bin/Steam Game Idler"'
