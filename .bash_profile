# Works with bash, not with zsh
function prompt {
    parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(git::\1)/'
    }
    local BLACK="\[\033[0;30m\]"
    local BLACKBOLD="\[\033[1;30m\]"
    local RED="\[\033[0;31m\]"
    local REDBOLD="\[\033[1;31m\]"
    local GREEN="\[\033[0;32m\]"
    local GREENBOLD="\[\033[1;32m\]"
    local YELLOW="\[\033[0;33m\]"
    local YELLOWBOLD="\[\033[1;33m\]"
    local BLUE="\[\033[0;34m\]"
    local BLUEBOLD="\[\033[1;34m\]"
    local PURPLE="\[\033[0;35m\]"
    local PURPLEBOLD="\[\033[1;35m\]"
    local CYAN="\[\033[0;36m\]"
    local CYANBOLD="\[\033[1;36m\]"
    local WHITE="\[\033[0;37m\]"
    local WHITEBOLD="\[\033[1;37m\]"

    export PS1="$BLUEBOLD\$(parse_git_branch)$RED\H \l $YELLOWBOLD\d $CYANBOLD\t $GREEN|\w|$WHITE\n\u\$ ";
}

prompt

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Android Studio
export STUDIO_JDK=/Library/Java/JavaVirtualMachines/jdk1.8.0_92.jdk

# Make sure tmux works properly
if [[ $TERM == "screen" ]]; then
    TERM=screen-256color
fi

# Load common functions and aliases
source $HOME/common.sh
source $HOME/distro.sh
DISTRO=$(getDistro)
if [[ $DISTRO == "Darwin" ]]; then
    export PATH="/opt/local/bin:/opt/local/sbin:$PATH";
    export PATH="/opt/local/library/Frameworks/Python.framework/Versions/2.7/bin:$PATH";
    export PATH="/opt/local/lib/mysql51/bin:$PATH";
    export PATH="/usr/local/go/bin:$PATH";
    export HDF5_DIR=/opt/local
    export GOPATH=$HOME/gopath
    #export C_INCLUDE_PATH="/usr/include:/usr/local/include:/opt/local/include"
fi

source $HOME/.autoenv/activate.sh

export NIX_PATH=nixpkgs=/etc/nixos/nixpkgs:nixos-config=/etc/nixos/configuration.nix

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# added by Anaconda2 4.3.0 installer
export PATH="/Users/calvin/anaconda2/bin:$PATH"
