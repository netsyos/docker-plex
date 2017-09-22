#!/bin/bash
until [[ -e /var/run/dbus/system_bus_socket ]]; do
sleep 1s
done

echo "Starting Avahi daemon"
exec avahi-daemon --no-chroot