#!/bin/sh
set -eu

# SGI ties a PRO license key to the machine ID. Give every container its own ID and keep it in /config
id_file=/config/machine-id

if [ ! -s "$id_file" ]; then
  tr -d '-' </proc/sys/kernel/random/uuid >"$id_file"
fi

mkdir -p /var/lib/dbus
ln -sf "$id_file" /etc/machine-id
ln -sf "$id_file" /var/lib/dbus/machine-id
