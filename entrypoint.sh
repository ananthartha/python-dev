#!/bin/bash

PUID=${PUID:-911}
PGID=${PGID:-911}

if ! id "$1" &>/dev/null; then
  groupmod -o -g "$PGID" "$USER_NAME"
  usermod -o -u "$PUID" "$USER_NAME"

  [[ -n "$PUBLIC_KEY" ]] && \
      [[ ! $(grep "$PUBLIC_KEY" /config/.ssh/authorized_keys) ]] && \
      echo "$PUBLIC_KEY" >> /config/.ssh/authorized_keys && \
      echo "Public key from env variable added"
fi

mkdir -p \
    /config/{.ssh,ssh_host_keys,logs/openssh}

mkdir -p /run/sshd

/usr/sbin/sshd -D -e -p 22