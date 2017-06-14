#!/usr/bin/env bash

if [[ $1 == "--full" ]]; then
    INSTALL_TYPE="full"
fi

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

brew install autoenv
brew install nvm
brew install antigen
brew cask install google-cloud-sdk
git clone git@gitlab.calvinx.com:calvin/secrets.git ../
cp -f ../secrets/.secrets $HOME/.secrets

symlink ".vimrc"
symlink ".vimrc_basic"
symlink ".vimrc_go"
symlink ".vimrc_c"
symlink ".vimrc_jade"
symlink ".vimrc_yaml"
symlink ".vimrc_haskell"
symlink ".vimrc_python"
symlink ".vimrc_jinja"
symlink ".vimrc_javascript"
symlink ".vimrc_json"
symlink ".vimrc_ruby"
symlink ".vimrc_lisp"
symlink ".vimrc_markdown"
symlink ".vimrc_java"
symlink ".vimrc_solidity"

mkdir -p $HOME/.vim/bundle
[[ ! -d "$HOME/.vim/bundle/vundle" ]] && git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/vundle
[[ $INSTALL_TYPE == "full" ]] && vim -c VundleUpdate -c quitall

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
[[ ! -L $HOME/.nixpkgs/config.nix ]] && ln -s "`pwd`/.nixpkgs/config.nix" $HOME/.nixpkgs/config.nix

# autoenv
if [[ ! -e "$HOME/.autoenv" ]]; then
    git clone git://github.com/kennethreitz/autoenv.git $HOME/.autoenv
fi

# Valgrind
symlink ".valgrindrc"
symlink "objc.supp"

# htop and other programs that use .config directory
mkdir -p $HOME/.config/htop
symlink ".config/htop/htoprc"

# YouCompleteMe
if [[ $DISTRO -ne "NixOS" ]]; then
    YCM_COMPILED=$(find $HOME/.vim/bundle/YouCompleteMe/ -name "ycm_client_support.*" | grep -o "ycm_client_support")
    if [[ -z $YCM_COMPILED ]]; then
        bash $HOME/.vim/bundle/YouCompleteMe/install.sh --clang-completer --omnisharp-completer --gocode-completer --tern-completer --racer-completer
        symlink ".ycm_extra_conf.py"
    fi
fi
