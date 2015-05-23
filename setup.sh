#!/usr/bin/env bash

# Link
link() {
    if [[ -z $1 ]]; then
        echo "link function requires one argument."
        return 1
    fi
    TARGET=$HOME/$1
    SOURCE=`pwd`/$1
    if [[ ! -e $TARGET ]]; then
        ln -s $SOURCE $TARGET
        echo "linked $SOURCE to $TARGET."
    else
        echo "$TARGET already exists."
    fi
}

link

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

link ".vimrc"
link ".vimrc_basic"
#vim -c VundleUpdate -c quitall

# tmux
link ".tmux.conf"
mkdir -p $HOME/.tmux/plugins
if [[ ! -d "$HOME/.tmux/plugins/tmux" ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# .bash_profile
link ".bash_profile"

# .zprofile
link ".zprofile"

# git
link ".gitconfig"
link ".gitignore_global"

# nvm
curl https://raw.githubusercontent.com/creationix/nvm/v0.24.1/install.sh | bash
npm install -g eslint babel-eslint eslint-plugin-react

# javascript
link ".jshintrc"
link ".eslintrc"

# nix
link ".nixpkgs"

# autoenv
if [[ ! -e "$HOME/.autoenv" ]]; then
    git clone git://github.com/kennethreitz/autoenv.git $HOME/.autoenv
fi

# YouCompleteMe
.$HOME/.vim/bundle/YouCompleteMe/install.sh --clang-completer
link ".ycm_extra_conf.py"

# Valgrind
link ".valgrindrc"
link ".objc.supp"
