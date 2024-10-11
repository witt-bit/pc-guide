#!/usr/bin/env bash

install(){
    sudo ln -s "$(readlink -f "$0")" /usr/bin/open;
    echo "Done";
}

# 处理 --install 参数
if [ "$1" == "--install" ]; then
    install;
    exit 0
fi

_open(){
    local command="$1";
    shift;
    echo "Using ${command} opening ...";
    if nohup "$command" "$@" > /dev/null 2>&1 & then
        return 0;
    else
        return 1;
    fi
}

# dolphin
if command -v dolphin >/dev/null 2>&1; then
    _open "dolphin" "$@";
    exit 0;
fi

echo "No file manager found";
exit 1;

