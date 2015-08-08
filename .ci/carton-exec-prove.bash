#!/bin/bash

set -e

PATH=$HOME/.plenv/bin:$PATH
eval "$(plenv init -)"

if [ "$CI_NAME" == "codeship" ]; then
    export PERL_CARTON_PATH=~/cache/local
    export PERL_CARTON_CPANFILE=$PWD/cpanfile
fi

if [ -n "$SNAP_CI" ]; then
    export PERL_CARTON_PATH=$SNAP_CACHE_DIR/local
    export PERL_CARTON_CPANFILE=$SNAP_WORKING_DIR/cpanfile
fi

carton exec prove -r t/codecov

HARNESS_PERL_SWITCHES="-MDevel::Cover=+ignore,^t/Util.pm|^t/data/proj/t/|^local/" \
    carton exec -- prove -r t/data/proj/t

PERL5OPT=-Mlib=$PWD/lib carton exec -- cover -report codecov
