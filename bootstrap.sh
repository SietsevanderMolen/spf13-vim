#!/usr/bin/env sh

endpath="$XDG_CONFIG_HOME/spf13-vim-3"

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

lnif() {
    if [ ! -e $2 ] ; then
        ln -s $1 $2
    fi
}

echo "Thanks for installing spf13-vim"

# Backup existing .vim stuff
echo "backing up current vim config"
today=`date +%Y%m%d`
for i in $XDG_CONFIG_HOME/vim $XDG_CONFIG_HOME/vimrc $XDG_CONFIG_HOME/gvimrc; do [ -e $i ] && [ ! -L $i ] && mv $i $i.$today; done


if [ ! -e $endpath/.git ]; then
    echo "cloning spf13-vim"
    git clone --recursive -b 3.0 https://github.com/SietsevanderMolen/spf13-vim.git $endpath
else
    echo "updating spf13-vim"
    cd $endpath && git pull
fi


echo "setting up symlinks"
if [ ! -d $XDG_CONFIG_HOME/vim/bundle ]; then
    mkdir -p $XDG_CONFIG_HOME/vim/bundle
fi
lnif $endpath/.vimrc $XDG_CONFIG_HOME/vim/vimrc
lnif $endpath/.vimrc.fork $XDG_CONFIG_HOME/vim/vimrc.fork
lnif $endpath/.vimrc.bundles $XDG_CONFIG_HOME/vim/vimrc.bundles
lnif $endpath/.vimrc.bundles.fork $XDG_CONFIG_HOME/vim/vimrc.bundles.fork

if [ ! -e $XDG_CONFIG_HOME/vim/bundle/vundle ]; then
    echo "Installing Vundle"
    git clone http://github.com/gmarik/vundle.git $XDG_CONFIG_HOME/vim/bundle/vundle
fi

echo "update/install plugins using Vundle"
vim -u $endpath/.vimrc.bundles +BundleInstall! +BundleClean +qall
