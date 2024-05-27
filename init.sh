#!/bin/bash

FILE=/firstrun
if test -f "$FILE"; then
    rm -f $FILE
    # Fix SSH Daemon
    mkdir /run/sshd
    chmod 750 /run/sshd
    # Adding root login over ssh
    echo "PermitRootLogin yes" > /etc/ssh/sshd_config.d/qdevice.conf
    echo "Starting device installer script ..."
    lua setup.lua
    echo "Start the docker the normal way and it will start normally"
    exit 0
fi

/usr/sbin/sshd
corosync-qnetd
corosync
sleep infinity
