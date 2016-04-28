#!/bin/bash

if [[ "$#" -lt 1 ]]; then
    echo "Specify project name, please"
    exit 1
fi

make MAIN="$1"
