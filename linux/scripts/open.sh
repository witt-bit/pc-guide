#!/usr/bin/env bash
version="0.0.2";

# 安装
install(){
    sudo ln -s "$(readlink -f "$0")" /usr/bin/open;
    echo "Done";
}

# 帮助
usage() {
    echo "open v${version}";
    echo "Usage: open [OPTION]... [FILE]..."
    echo "Open folder with default fileManager."
    echo "  -h, --help                 display this help and exit"
    echo "  --install                  install this script to /usr/bin/open"
    echo "  -v, --version              output version information and exit"
    echo "  dir1 dir2 ...              open folder with fileManager"
}


case "$1" in
    "--install")
        install;
        exit 0;
    ;;
    "-h" | "--help")
        usage;
        exit 0;
    ;;
    "-v" | "--version")
        echo "open command version \"v${version}\" ,author: witt";
        exit 0;
    ;;
esac


# gio 命令
_gioCmd() {
    echo "Using default fileManager (gio command) opening ...";
    gio open "$@";
}

# nemo命令
_nemoCmd() {
    echo "Using nemo command opening ...";
    nohup nemo --existing-window "$@" > /dev/null 2>&1 &
}

# xdg-open命令
_xdgopenCmd() {
    echo "Using xdg-open command opening ...";
    if [ "$#" -eq 0 ]; then
        local args=".";
    else
        local args="$1";
    fi

    xdg-open "${args}";
}

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

# 尝试gio命令
if command -v gio >/dev/null 2>&1; then
    if _gioCmd "$@"; then
        exit 0;
    fi
fi

# xdg-open
if command -v xdg-open >/dev/null 2>&1; then
    if _xdgopenCmd "$@"; then
        exit 0;
    fi
fi

# dolphin
if command -v dolphin >/dev/null 2>&1; then
    _open "dolphin" "$@";
    exit 0;
fi

# nautilus for gnome
if command -v nautilus >/dev/null 2>&1; then
    _open "nautilus" "$@";
    exit 0;
fi

# thunar for xfce
if command -v thunar >/dev/null 2>&1; then
    _open "thunar" "$@";
    exit 0;
fi

# PCManFM for LXDE
if command -v pcmanfm >/dev/null 2>&1; then
    _open "pcmanfm" "$@";
    exit 0;
fi

# ranger
if command -v ranger >/dev/null 2>&1; then
    _open "ranger" "$@";
    exit 0;
fi

# caja
if command -v caja >/dev/null 2>&1; then
    _open "caja" "$@";
    exit 0;
fi

# xfe
if command -v xfe >/dev/null 2>&1; then
    _open "xfe" "$@";
    exit 0;
fi

# nemo for Cinnamon
if command -v nemo >/dev/null 2>&1; then
    if _nemoCmd "$@"; then
        exit 0;
    fi
fi

echo "No file manager found";
exit 1;

