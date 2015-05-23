#!/usr/bin/env bash

source ./distro.sh
DISTRO=$(getDistro)

source ./common.sh

# vim
if [[ $DISTRO == "Darwin" ]]; then
    sudo port install vim +huge +python27 +gtk2 +lua
fi

symlink ".vimrc"
symlink ".vimrc_basic"
#vim -c VundleUpdate -c quitall

# tmux
symlink ".tmux.conf"
mkdir -p $HOME/.tmux/plugins
if [[ ! -d "$HOME/.tmux/plugins/tmux" ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# .bash_profile
symlink ".bash_profile"

# .zprofile
symlink ".zprofile"

# git
symlink ".gitconfig"
symlink ".gitignore_global"

# nvm
curl https://raw.githubusercontent.com/creationix/nvm/v0.24.1/install.sh | bash
npm install -g eslint babel-eslint eslint-plugin-react

# javascript
symlink ".jshintrc"
symlink ".eslintrc"

# nix
symlink ".nixpkgs"

# autoenv
if [[ ! -e "$HOME/.autoenv" ]]; then
    git clone git://github.com/kennethreitz/autoenv.git $HOME/.autoenv
fi

# YouCompleteMe
.$HOME/.vim/bundle/YouCompleteMe/install.sh --clang-completer
symlink ".ycm_extra_conf.py"

# Valgrind
symlink ".valgrindrc"
symlink ".objc.supp"
