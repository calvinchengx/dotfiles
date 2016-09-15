#!/usr/bin/env bash

(set -x; brew update;)
(set -x; brew cask update;)

(set -x; brew cleanup;)
(set -x; brew cask cleanup;)

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

casks=( $(brew cask list) )

for cask in ${casks[@]}
do
    installed="$(brew cask info $cask | grep 'Not installed')"

    if [[ $installed = *[!\ ]* ]]; then
        echo "${red}${cask}${reset} requires ${red}update${reset}."
        (set -x; brew cask uninstall $cask --force;)
        (set -x; brew cask install --force $cask;)
    else
        echo "${red}${cask}${reset} is ${green}up-to-date${reset}."
    fi
done
