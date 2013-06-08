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

export PATH="/opt/local/library/Frameworks/Python.framework/Versions/2.7/bin:$PATH";
export PATH="/opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:$PATH";
export PATH="/opt/local/lib/mysql51/bin:$PATH";
export PATH="/usr/local/go/bin:$PATH";
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/work
source `which virtualenvwrapper.sh`
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export EDITOR=vim
export HDF5_DIR=/opt/local
export GOPATH=$HOME/gopath
export C_INCLUDE_PATH="/usr/include:/usr/local/include:/opt/local/include"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 
# Load RVM into a shell session *as a function*
#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# useful aliases
alias nginx_start='sudo launchctl load -w /Library/LaunchDaemons/org.macports.nginx.plist'
alias nginx_stop='sudo launchctl unload -w /Library/LaunchDaemons/org.macports.nginx.plist'
alias nginx_restart='nginx_stop; nginx_start;'
alias mongod_start='mongod --dbpath /var/lib/mongodb;'
alias cs='python manage.py collectstatic --noinput'
alias pyc='find . -name "*.pyc" -exec rm -rf {} \;'
