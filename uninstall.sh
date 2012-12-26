#!/usr/bin/env sh

endpath="$XDG_CONFIG_HOME/spf13-vim-3"

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

rm -rf $XDG_CONFIG_HOME/vimrc
rm -rf $XDG_CONFIG_HOME/vimrc.bundles
rm -rf $XDG_CONFIG_HOME/vim

rm -rf $endpath
