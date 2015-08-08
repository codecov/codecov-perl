#!/bin/bash

set -e

PERL_VERSION=`cat .perl-version`
PLENV_ROOT=$HOME/.plenv

if [ "$CI_NAME" == "codeship" ]; then
    PLENV_ROOT=$HOME/cache/.plenv
fi

if [ -n "$SEMAPHORE" ]; then
    PLENV_ROOT=$SEMAPHORE_CACHE_DIR/.plenv
fi

if [ ! -e "$PLENV_ROOT" ]; then
    git clone git://github.com/tokuhirom/plenv.git "$PLENV_ROOT"
    git clone git://github.com/tokuhirom/Perl-Build.git "$PLENV_ROOT/plugins/perl-build/"
fi

if [ "$PLENV_ROOT" != "$HOME/.plenv" ]; then
    ln -s "$PLENV_ROOT" "$HOME/.plenv"
fi

unset PLENV_ROOT

chmod u+w ~/.bashrc # for Snap CI

echo 'export PATH="$HOME/.plenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(plenv init -)"' >> ~/.bashrc

PATH=$HOME/.plenv/bin:$PATH


eval "$(plenv init -)"

plenv install $PERL_VERSION || true
plenv rehash
