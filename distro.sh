# Determine OS
getDistro() {

    if [[ "`uname`" == "Darwin" ]]; then
        local DISTRO="Darwin";
    elif [[ "`uname`" == "Linux" ]]; then
        local DISTRO="Linux"
        source /etc/*release
        echo $DISTRIB_ID
    else
        local DISTRO=""
    fi

    if [[ -z $DISTRO ]]; then
        return 1
    else
        echo $DISTRO
    fi

}
