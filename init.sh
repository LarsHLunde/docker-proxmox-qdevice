#!/bin/bash

FILE=/firstrun
if test -f "$FILE"; then
    rm -f $FILE
    echo "Docker NodeJS Testpages has been installed"
    echo "Start the docker the normal way and it will start normally"
    exit 0
fi

sleep infinity
