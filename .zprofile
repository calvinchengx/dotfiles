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

zstyle ':vcs_info:*' enable git cvs svn

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
	echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}"
  fi
}

# Build the prompt
PROMPT=""
PROMPT+=$'$(vcs_info_wrapper)'  # Version Control
PROMPT+="%{$fg[red]%}%m %l%{$reset_color%}"  # Host
PROMPT+="%{$fg[yellow]%} %D{%a %f %b}%{$reset_color%}"  # Date
PROMPT+="%{$fg[cyan]%} %T%{$reset_color%}"  # Time
PROMPT+="%{$fg[green]%} | %~ |%{$reset_color%}" # Working directory
PROMPT+="
" # Newline
PROMPT+="%n %# "  # Username and prompt

# defaults
export PATH="/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:$PATH";

# macports
export PATH="/opt/local/bin:/opt/local/sbin:/usr/X11/bin:$PATH";

# python
export PATH="/opt/local/library/Frameworks/Python.framework/Versions/2.7/bin:$PATH";

# golang
export PATH="/usr/local/go/bin:$PATH";

# android
export PATH="/Applications/Android Studio.app/sdk/platform-tools:/Applications/Android Studio.app/sdk/tools:$PATH";
export ANDROID_HOME="/Applications/Android Studio.app/sdk";

# c
#export C_INCLUDE_PATH="/usr/include:/usr/local/include:/opt/local/include"

# javascript
export PHANTOMJS_BIN="/opt/local/bin/phantomjs"

# docker
export DOCKER_HOST=tcp://127.0.0.1:4243

# Carlson Minot cross compiler
export PATH=/usr/local/carlson-minot/crosscompilers/bin:$PATH

# packer
export PATH=/usr/local/bin/packer:$PATH

# training
export PATH=$HOME/bin:$PATH

# Load common functions and aliases
myDir=${0:a:h}
source $myDir/common.sh

export NIX_PATH=nixpkgs=$HOME/nixpkgs:$NIX_PATH

# Permit C-s mapping in vim
stty start undef
stty stop undef

# Experimental
source ~/antigen.zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions src
antigen bundle tarruda/zsh-autosuggestions

antigen apply
