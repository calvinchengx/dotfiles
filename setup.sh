#!/usr/bin/env bash

if [[ $1 == "--full" ]]; then
    INSTALL_TYPE="full"
fi

myDir=$(dirname "$0")
source $myDir/distro.sh
DISTRO=$(getDistro)
source $myDir/common.sh
source /etc/*release

symlink "common.sh"
symlink "distro.sh"

# vim
# Are we on Darwin and is vim not already installed?
if [[ $DISTRO == "Darwin" ]] && [[ -z "`which vim`" ]]; then
    echo "Installing vim"
    brew install autoenv
    brew install nvm
    brew install antigen
    brew cask install google-cloud-sdk
    git clone git@gitlab.calvinx.com:calvin/secrets.git ../
    cp -f ../secrets/.secrets $HOME/.secrets
fi

if [[ $DISTRIB_ID == "Ubuntu" ]]; then
    sudo apt update && yes | sudo apt upgrade && yes | sudo apt autoremove
fi

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
symlink ".vimrc_scss"
symlink ".vimrc_conf"

mkdir -p $HOME/.vim/bundle
[[ ! -d "$HOME/.vim/bundle/vundle" ]] && git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/vundle
[[ $INSTALL_TYPE == "full" ]] && vim -c VundleUpdate -c quitall

# vim plugins
vim +VimEnter +VundleInstall +qall
vim +VimEnter +VundleInstall +qall

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
rm $HOME/.zshrc
symlink ".zshrc"

# change shell - switch to using zsh
echo "####################"
echo $DISTRIB_ID
if [[ $DISTRIB_ID == "Ubuntu" ]]; then
    yes | sudo apt install zsh
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
    chsh -s `which zsh`
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

# git
symlink ".gitconfig"
symlink ".gitignore_global"

# goenv
git clone https://github.com/syndbg/goenv.git ~/.goenv

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

# docker
if [[ $DISTRO == "Darwin" ]]; then
    etc=/Applications/Docker.app/Contents/Resources/etc
    ln -s $etc/docker.zsh-completion /usr/local/share/zsh/site-functions/_docker
    ln -s $etc/docker-machine.zsh-completion /usr/local/share/zsh/site-functions/_docker-machine
    ln -s $etc/docker-compose.zsh-completion /usr/local/share/zsh/site-functions/_docker-compose
fi

if [[ $DISTRIB_ID == "Ubuntu" ]]; then
    sudo apt install apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo apt-key fingerprint 0EBFCD88
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt update
    yes | sudo apt install docker-ce
fi

# pyenv
if [[ $DISTRO == "Darwin" ]]; then
    brew install pyenv
else
    yes | sudo apt-get install git python-pip make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev
    yes | sudo pip install virtualenvwrapper
fi

# upgrade pip if necessary
sudo pip install --upgrade pip

git clone https://github.com/yyuu/pyenv.git ~/.pyenv
source ~/.bash_profile
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $(pyenv root)/plugins/pyenv-virtualenvwrapper
export PYTHON_CONFIGURE_OPTS="--enable-shared"
pyenv install -s 2.7.14
pyenv global 2.7.14

# sdkman
if [[ $DISTRIB_ID == "Ubuntu" ]]; then
    yes | sudo apt install zip unzip
fi
unset SDKMAN_DIR
curl -s "https://get.sdkman.io" | bash

# YouCompleteMe
if [[ $DISTRIB_ID == "Ubuntu" ]]; then
    yes | sudo apt install build-essential cmake python-dev python3-dev
fi
YCM_COMPILED=$(find $HOME/.vim/bundle/YouCompleteMe/ -name "ycm_client_support.*" | grep -o "ycm_client_support")
if [[ -z $YCM_COMPILED ]]; then
    YCM_CORES=1 $HOME/.vim/bundle/YouCompleteMe/install.py --clang-completer --go-completer --rust-completer --java-completer --js-completer
    symlink ".ycm_extra_conf.py"
fi


# Ubuntu auto updates
if [[ $DISTRIB_ID == "Ubuntu" ]]; then
    yes | sudo apt install unattended-upgrades
fi
