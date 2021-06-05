#!/usr/bin/env bash
#
# Installs vim-plug for managing Vim plugins

set -e

if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
    echo "installing vim-plug"
    # Pulls vim-plug plugin.
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    # Run installation.
    vim +PlugInstall +qall > /dev/null
else
    echo "vim-plug already installed"
fi