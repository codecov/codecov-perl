#!/bin/bash

set -e

PATH=$HOME/.plenv/bin:$PATH
eval "$(plenv init -)"

if [ $CI_NAME == "codeship" ]; then
    export PERL_CARTON_PATH=~/cache/local
    export PERL_CARTON_CPANFILE=$PWD/cpanfile
fi

carton install
