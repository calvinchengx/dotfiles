#!/usr/bin/env bash

myDir=$(dirname "$0")
source $myDir/distro.sh
DISTRO=$(getDistro)
source $myDir/common.sh

symlink "common.sh"
symlink "distro.sh"

# vim
# Are we on Darwin and is vim not already installed?
if [[ $DISTRO == "Darwin" ]] && [[ -z "`which vim`" ]]; then
    echo "Installing vim"
    sudo port install vim +huge +python27 +gtk2 +lua
fi

symlink ".vimrc"
symlink ".vimrc_basic"
#vim -c VundleUpdate -c quitall

# tmux
symlink ".tmux.conf"
mkdir -p $HOME/.tmux/plugins
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
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
if [[ $(isFunction "nvm") -ne "function" ]]; then
    curl https://raw.githubusercontent.com/creationix/nvm/v0.24.1/install.sh | bash
    npm install -g eslint babel-eslint eslint-plugin-react
else
    echo "nvm already installed"
fi

# javascript
symlink ".jshintrc"
symlink ".eslintrc"

# nix
[[ ! -d $HOME/.nixpkgs ]] && mkdir -p $HOME/.nixpkgs
symlink ".nixpkgs/config.nix"

# autoenv
if [[ ! -e "$HOME/.autoenv" ]]; then
    git clone git://github.com/kennethreitz/autoenv.git $HOME/.autoenv
fi

# YouCompleteMe
YCM_COMPILED=$(find $HOME/.vim/bundle/YouCompleteMe/ -name "ycm_client_support.*" | grep -o "ycm_client_support")
if [[ -z $YCM_COMPILED ]]; then
    bash $HOME/.vim/bundle/YouCompleteMe/install.sh --clang-completer
    symlink ".ycm_extra_conf.py"
fi

# Valgrind
symlink ".valgrindrc"
symlink "objc.supp"
