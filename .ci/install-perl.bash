#!/bin/bash

set -e

PERL_VERSION=`cat .perl-version`

if [ "$CI_NAME" == "codeship" ]; then
    if [ ! -e "$HOME/cache/.plenv" ]; then
        git clone git://github.com/tokuhirom/plenv.git ~/cache/.plenv
        git clone git://github.com/tokuhirom/Perl-Build.git ~/cache/.plenv/plugins/perl-build/
    fi

    ln -s ~/cache/.plenv ~/.plenv
fi

if [ ! -e "$HOME/.plenv" ]; then
    git clone git://github.com/tokuhirom/plenv.git ~/.plenv
    git clone git://github.com/tokuhirom/Perl-Build.git ~/.plenv/plugins/perl-build/
fi

chmod u+w ~/.bashrc # for Snap CI

echo 'export PATH="$HOME/.plenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(plenv init -)"' >> ~/.bashrc

PATH=$HOME/.plenv/bin:$PATH

eval "$(plenv init -)"

plenv install $PERL_VERSION || true
plenv rehash
