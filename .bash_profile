PS1="\[\033[0;31m\]\H \l \[\033[1;33m\]\d \[\033[1;36m\]\t\[\033[0;32m\] |\w|\[\033[0m\]\n\u\$ ";
export PATH="/opt/local/library/Frameworks/Python.framework/Versions/2.7/bin:$PATH";
export PATH="/opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:$PATH";
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
#export GOPATH="$HOME/gocode";
export GOPATH="$HOME/gowiki";

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
