#!/bin/bash

set -e

if type -p carton > /dev/null 2>&1; then
    exit
fi

PATH=$HOME/.plenv/bin:$PATH

eval "$(plenv init -)"
cpanm Carton
