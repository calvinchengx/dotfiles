# Common configuration whether I am using bash or zsh

source $HOME/distro.sh
DISTRO=$(getDistro)

# Checks if type is present and if so return its value
typeCheck() {
    if [[ "$DISTRO" == "Darwin" ]]; then
        local TYPE_CHECK=$(type -w $1 | cut -d " " -f2)
    else
        if [[ "$0" == "-bash" ]]; then
            local TYPE_CHECK=$(type -t )
        else
            local TYPE_CHECK=$(type -f )
        fi
    fi

    if [[ ! $TYPE_CHECK == "none" ]] || [[ ! -z $TYPE_CHECK ]]; then
        echo $TYPE_CHECK
    fi
}

# Language settings
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Default editor
export EDITOR=vim

# python virtualenv and virtualenvwrapper using pyenv-virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/work
eval "$(pyenv init -)"
pyenv rehash
pyenv virtualenvwrapper

# ruby rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# node nvm
export NVM_DIR=$HOME/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# autoenv
source $HOME/.autoenv/activate.sh

# nix
[[ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]] && . "$HOME/.nix-profile/etc/profile.d/nix.sh"


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
alias valg='ln -sf $HOME/objc.supp `pwd`/objc.supp && /usr/local/bin/valgrind'

# git crawl aliases
# https://github.com/magnusstahre/git-stuff
alias nxt='git crawl master'
alias prev='git co HEAD^1'

# A symlink function that does exception handling with friendly messages
symlink() {
    if [[ -z $1 ]]; then
        echo "link function requires one argument."
        return 1
    fi
    TARGET=$HOME/$1
    SOURCE=`pwd`/$1
    if [[ ! -L $TARGET ]]; then
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

# haskell
if [[ "`typeCheck cabalenv.sh`" == "command" ]]; then
    source `type -p cabalenv.sh`
fi
use_haskell() {
    unset HS_BIN;
    unset CABAL_BIN;
    HS_BINS=("ghc" "ghc-pkg" "ghci" "haddock" "hp2ps" "hpc" "hsc2hs" "runghc" "runhaskell")

    if [[ -z "$1" ]]; then
        printf "Which Haskell install do you want? [platform, macports, nix]:\n"
        read selection
        if [[ -z "$selection" ]]; then
            echo "No option selected."
            return
        fi
    else
        selection=$1
    fi

    case $selection in
        "platform")
            # download from Haskell Platform site and run the installer
            HS_BIN="/Library/Frameworks/GHC.framework/Versions/7.8.3-x86_64/usr/bin"
            CABAL_BIN="$HOME/Library/Haskell/bin"
            echo "Using haskell platform"
            ;;
        "macports")
            # sudo port -v install ghc
            # sudo port -v install hs-cabal-install
            HS_BIN="/opt/local/bin"
            CABAL_BIN="/opt/local/bin" # Must be in .cabal/config.macports
            if [[ ! -d "$CABAL_BIN" ]]; then
                sudo mkdir -p $CABAL_BIN
            fi
            echo "Using haskell from macports"
            ;;
        "nix")
            # nix-env -iA nixpkgs.haskellPackages.ghc
            # nix-env -iA nixpkgs.haskellPackages.haddock
            # nix-env -iA nixpkgs.nox (nox is a useful wrapper for nix-env)
            # we can now use nox if we want, to search for packages, like `cabal-install`
            # nox cabal-install (for example)
            # Anyway:
            # nix-env -iA nixpkgs.haskellPackages.cabalInstall_1_20_0_6
            HS_BIN="/Users/calvin/.nix-profile/bin"
            CABAL_BIN="$HOME/.cabal/bin" # Must be in .cabal/config.nix
            # We need these NIX_* flags so cabal can find C header files
            NIX_CFLAGS_COMPILE="-idirafter /usr/include"
            NIX_LDFLAGS="-L/usr/lib"
            echo "Using haskell from nix"
            ;;
        *)
            echo "No such option: $1"
            ;;
    esac

    if [[ ! -z "$HS_BIN" ]]; then
        echo "Symlinking $selection's ghc binaries from $HS_BIN";
        for ITEM in $HS_BINS
        do
            sudo ln -sf $HS_BIN/$ITEM $HS_DIR/bin/$ITEM
        done
    fi

    if [[ ! -z "$CABAL_BIN" ]]; then
        echo "Symlinking $selection's cabal binaries from $CABAL_BIN";
        ln -sf $HOME/.cabal/config.$selection $HOME/.cabal/config
        export PATH="$CABAL_BIN:$PATH"
    fi

    export HS_DIR="/usr/local/haskell"
    if [[ ! -d "$HS_DIR" ]]; then
        sudo mkdir -p $HS_DIR/bin
    fi
    export PATH="$HS_DIR/bin:$PATH"
    export HS_PROJ_HOME=$HOME/work
}
