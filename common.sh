# Common configuration whether I am using bash or zsh

myDir=$(dirname "$0")
source $myDir/distro.sh
DISTRO=$(getDistro)

# Convenient aliases
if [[ $DISTRO == "Darwin" ]]; then
    alias nginx_start='sudo launchctl load -w /Library/LaunchDaemons/org.macports.nginx.plist'
    alias nginx_stop='sudo launchctl unload -w /Library/LaunchDaemons/org.macports.nginx.plist'
    alias nginx_restart='nginx_stop; nginx_start;'
    alias mongod_start='mongod --dbpath /var/lib/mongodb;'
fi

alias cs='python manage.py collectstatic --noinput'
alias pyc='find . -name "*.pyc" -exec rm -rf {} \;'
alias lsd='ls -l | grep "^d"'
alias clearswp='find . -type f -name ".*.swp" -exec rm -f {} \;'
alias sumdir='du -s ./* | sort -n | cut -f 2- | xargs du -sh'
alias cmaketree="tree -I 'CMakeCache.txt|CMakeFiles|Makefile|cmake_install.cmake|install_manifest.txt'"

# git crawl aliases
# https://github.com/magnusstahre/git-stuff
alias next='git crawl master'
alias previous='git co HEAD^1'

myDir=$(dirname "$0")

# A symlink function that does exception handling with friendly messages
symlink() {
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

# Returns "function" if arg is an available function
isFunction() {
    if [[ -z $1 ]]; then
        echo "isFunction requires one argument"
        return 1
    fi

    local RESULT=$(type -t $1)
    echo $RESULT
}

# Use gitignore.io API to generate .gitignore files
gi() {
    curl -L -s https://www.gitignore.io/api/$@;
}
