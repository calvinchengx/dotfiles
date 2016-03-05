# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=100000
setopt appendhistory autocd beep extendedglob nomatch notify
setopt interactivecomments
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/calvin/.zshrc'

autoload -Uz compinit
compinit
autoload -U promptinit
promptinit
# End of lines added by compinstall
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

[[ -s "/Users/calvin/.gvm/scripts/gvm" ]] && source "/Users/calvin/.gvm/scripts/gvm"
