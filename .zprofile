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

# language
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# tmux
export DISABLE_AUTO_TITLE='true';

# editor
export EDITOR=vim

# defaults
export PATH="/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:$PATH";

# xcode
export DEVROOT="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer";

# macports
export PATH="/opt/local/bin:/opt/local/sbin:/usr/X11/bin:$PATH";

# python
export PATH="/opt/local/library/Frameworks/Python.framework/Versions/2.7/bin:$PATH";
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/work
source `which virtualenvwrapper.sh`

# golang
export PATH="/usr/local/go/bin:$PATH";

# android
export PATH="/Applications/Android Studio.app/sdk/platform-tools:/Applications/Android Studio.app/sdk/tools:$PATH";
export ANDROID_HOME="/Applications/Android Studio.app/sdk";

# haskell
export PATH="$HOME/.cabal/bin:$PATH";
export PATH="$HOME/Library/Haskell/bin:$PATH"  # using haskell platformm
export HS_PROJ_HOME=$HOME/work
source `which cabalenv.sh`

# nodejs
export NVM_DIR="/Users/calvin/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# ruby

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
jek() {
    jekyll -w serve & open "http://localhost:4000"
}

# c
export C_INCLUDE_PATH="/usr/include:/usr/local/include:/opt/local/include"

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

# Useful aliases
alias nginx_start='sudo launchctl load -w /Library/LaunchDaemons/org.macports.nginx.plist'
alias nginx_stop='sudo launchctl unload -w /Library/LaunchDaemons/org.macports.nginx.plist'
alias nginx_restart='nginx_stop; nginx_start;'
alias mongod_start='mongod --dbpath /var/lib/mongodb;'
alias cs='python manage.py collectstatic --noinput'
alias pyc='find . -name "*.pyc" -exec rm -rf {} \;'
alias lsd='ls -l | grep "^d"'
alias clearswp='find . -type f -name ".*.swp" -exec rm -f {} \;'
alias sumdir='du -s ./* | sort -n | cut -f 2- | xargs du -sh'

# git crawl aliases
# https://github.com/magnusstahre/git-stuff
alias next='git crawl master'
alias previous='git co HEAD^1'

source ~/.autoenv/activate.sh

# Permit C-s mapping in vim
stty start undef
stty stop undef

# Experimental
source ~/antigen.zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions src
antigen bundle tarruda/zsh-autosuggestions

antigen apply
