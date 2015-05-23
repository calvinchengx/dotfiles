# Determine OS
getDistro() {

    if [[ "`uname`" == "Darwin" ]]; then
        local DISTRO="Darwin";
    elif [ "`uname`" == "Linux" ]; then
        local DISTRO="Linux"
        [[ "`cat /proc/version`" == *"NixOS"* ]] && local DISTRO="NixOS"
    else
        local DISTRO=""
    fi

    if [[ -z $DISTRO ]]; then
        return 1
    else
        echo $DISTRO
    fi

}
