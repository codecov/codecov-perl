#!/bin/bash

set -e

if type -p cpanm > /dev/null 2>&1; then
    exit
fi

PATH=$HOME/.plenv/bin:$PATH

plenv install-cpanm
plenv rehash
