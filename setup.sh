#!/usr/bin/env bash

# Determine OS
if [[ "`uname`" == "Darwin" ]]; then
    DISTRO="Darwin";
elif [ "`uname`" == "Linux" ]; then
    DISTRO="Linux"
    [[ "`cat /proc/version`" == *"NixOS"* ]] && DISTRO="NixOS"
else
    DISTRO=""
    echo "This operating system is not supported."
    return 1
fi

# vim
if [[ $DISTRO == "Darwin" ]]; then
    sudo port install vim +huge +python27 +gtk2 +lua
fi
ln -s `pwd`/.vimrc $HOME/.vimrc
ln -s `pwd`/.vimrc_basic $HOME/.vimrc_basic
vim -c VundleUpdate -c quitall

# tmux
ln -s `pwd`/.tmux.conf $HOME/.tmux.conf

# .bash_profile
ln -s `pwd`/.bash_profile $HOME/.bash_profile

# .zprofile
ln -s `pwd`/.zprofile $HOME/.zprofile

# git
ln -s `pwd`/.gitconfig $HOME/.gitconfig
ln -s `pwd`/.gitignore_global $HOME/.gitignore_global

# nvm
curl https://raw.githubusercontent.com/creationix/nvm/v0.24.1/install.sh | bash
npm install -g eslint babel-eslint eslint-plugin-react

# javascript
ln -s `pwd`/.jshintrc $HOME/.jshintrc
ln -s `pwd`/.eslintrc $HOME/.eslintrc

# nix
ln -s `pwd`/.nixpkgs $HOME/.nixpkgs

# autoenv
git clone git://github.com/kennethreitz/autoenv.git $HOME/.autoenv

# YouCompleteMe
.$HOME/.vim/bundle/YouCompleteMe/install.sh --clang-completer
ln -s `pwd`/.ycm_extra_conf.py $HOME/.vim/.ycm_extra_conf.py

# Valgrind
ln -s `pwd`/dotfiles/.valgrindrc $HOME/.valgrindrc
ln -s `pwd`/dotfiles/objc.supp $HOME/objc.supp
