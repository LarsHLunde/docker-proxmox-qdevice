#!/bin/bash

FILE=/firstrun
if test -f "$FILE"; then
    rm -f $FILE
    echo "Docker NodeJS Testpages has been installed"
    mkdir /run/sshd
    chmod 750 /run/sshd
    echo "Start the docker the normal way and it will start normally"
    exit 0
fi

/usr/sbin/sshd
corosync-qnetd
corosync
sleep infinity
