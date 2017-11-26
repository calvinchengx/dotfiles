# Path to your oh-my-zsh configuration.
#ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
#plugins=(git)

#source $ZSH/oh-my-zsh.sh

# Customize to your needs...

setopt prompt_subst
autoload -U colors && colors
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git cvs svn hg

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
    vcs_info
    if [ -n "$vcs_info_msg_0_" ]; then
        echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}"
    fi
}

docker_machine_info_wrapper() {
    if [ -n "$DOCKER_MACHINE_NAME" ]; then
        echo "%{$fg[blue]%}docker::${DOCKER_MACHINE_NAME}%{$reset_color%} "
    else
        echo "%{$fg[blue]%}docker::local%{$reset_color%} "
    fi
}

# Build the prompt
PROMPT=""
PROMPT+=$'$(vcs_info_wrapper)'  # Version Control
PROMPT+=$'$(docker_machine_info_wrapper)'
PROMPT+="%{$fg[red]%}%m %l%{$reset_color%}"  # Host
PROMPT+="%{$fg[yellow]%} %D{%a %f %b}%{$reset_color%}"  # Date
PROMPT+="%{$fg[cyan]%} %T%{$reset_color%}"  # Time
PROMPT+="%{$fg[green]%} | %~ |%{$reset_color%}" # Working directory
PROMPT+="
" # Newline
PROMPT+="%n %# "  # Username and prompt

## Load common functions and aliases
##myDir=${0:a:h}
myDir=$HOME
source $myDir/common.sh
#source $myDir/task-logger.sh
#
# Access credentials
if [[ -a $HOME/.secrets ]]; then
    source $HOME/.secrets
fi

# Useful functions
function search_and_replace() {
    # Usage:
    #
    # search for "hello"
    # replace with "world"
    # from current directory "."
    # for all files "*"
    # excluding "Godeps" directory
    # search_and_replace hello world "." "*" "Godeps"
    #
    # Another example:
    # search_and_replace "sh_api\/" "" . go "vendor"
    local search=$1
    local replace=$2
    local directory=${3:-"."}
    local filetype=${4:-"*"}
    local exclude=${5:-""}

    echo "Searching for "${search}
    echo "and replacing with "${replace}
    echo "starting from directory "${directory}
    echo "for file types "${filetype}
    echo "excluding directory "${exclude}

    # bash version
    # read -r -p "Are you sure? [y/N] " response
    # response=${response,,}    # tolower
    #
    # zsh version
    read "response?Are you sure? [y/N] "

    if [[ $response =~ ^(yes|y)$ ]]
    then

        LC_ALL=C && LC_CTYPE=C && LANG=C

        find ${directory} -type f -name "*.${filetype}" ! -path "*/"${exclude}"/*" ! -path "*/.git/*" -print0 | xargs -0 sed -i '' 's/'${search}'/'${replace}'/g'

        LC_ALL=en_US.UTF-8 && LC_CTYPE=en_US.UTF-8 && LANG=en_US.UTF-8
    fi
}

# defaults
export PATH="/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:$PATH";

# node nvm
#export NVM_DIR=~/.nvm
#if [[ "$(getDistro)" == "Darwin" ]]; then
    #source $(brew --prefix nvm)/nvm.sh
#fi

# fastlane
if [[ "$(getDistro)" == "Darwin" ]]; then
    export PATH=$HOME/.fastlane/bin:$PATH
fi


# c
if [[ "$(getDistro)" == "Darwin" ]]; then
    export C_INCLUDE_PATH="/usr/include:/usr/local/include:/opt/local/include"
fi

# training
if [[ "$(getDistro)" == "Darwin" ]]; then
    export PATH=$HOME/bin:$PATH
fi

## Kubernetes: fleetctl and etcdctl
#export PATH="$HOME/k8s-bin:$PATH"

# VirtualBox
if [[ "$(getDistro)" == "Darwin" ]]; then
    export VAGRANT_DEFAULT_PROVIDER=virtualbox
fi

# Android
if [[ "$(getDistro)" == "Darwin" ]]; then
    ANDROID_HOME=~/Library/Android/sdk
    ANDROID_PLATFORM_TOOLS=$ANDROID_HOME/platform-tools
    PATH=$PATH:$ANDROID_PLATFORM_TOOLS
fi

# Anaconda
# mv ~/anaconda2/bin/deactivate ~/anaconda2/bin/conda-deactivate
# to avoid namespace collision between anaconda2's deactivate function and virtualenvwrapper's deactivate function
PATH=$PATH:~/anaconda2/bin

# Nix and NixOps
export NIX_PATH=nixpkgs=$HOME/nixpkgs
export NIX_BUILD_HOOK=$HOME/.nix-profile/libexec/nix/build-remote.pl
export NIX_CURRENT_LOAD=/tmp/current-load
export NIX_REMOTE_SYSTEMS=$HOME/remote-systems.conf

# Required on Darwin so nix-env can find specific global header files
export NIX_CFLAGS_COMPILE="-idirafter /usr/include"
export NIX_CFLAGS_LINK="-L/usr/lib"

# Permit C-s mapping in vim
stty start undef
stty stop undef

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

if [[ "$(getDistro)" == "Darwin" ]]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /usr/local/share/zsh-navigation-tools/zsh-navigation-tools.plugin.zsh
    export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters
else
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# google cloud sdk on Darwin
if [[ "$(getDistro)" == "Darwin" ]]; then
    source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
    source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
fi

# autoenv
if [[ "$(getDistro)" == "Darwin" ]]; then
    source /usr/local/opt/autoenv/activate.sh
fi

# Kill all running containers.
dockerkillall() {
    KILL_LIST=`docker ps --no-trunc -q | grep -v $(docker inspect --format="{{.Id}}" dinghy_http_proxy)`
    docker kill `echo $KILL_LIST`
}

# suppress python-config warnings when running brew doctor
alias brew="env PATH=${PATH//$(pyenv root)\/shims:/} brew"

# Stop all containers.
alias dockercleans='printf "\n>>> Stopping all containers\n\n" && docker stop $(docker ps -a -q)'

# Delete all stopped containers.
alias dockercleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'
# Delete all untagged images.
alias dockercleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'
# Delete all stopped containers and untagged images.
alias dockerclean='dockercleanc || true && dockercleani'
