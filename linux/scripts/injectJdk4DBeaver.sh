#!/usr/bin/env bash

jdkPath="/usr/lib/jvm/java-22-openjdk"
confPath="/usr/share/dbeaver/dbeaver.ini"

# 检查参数是否已提供
if [ -n "$1" ]; then
    jdkPath="$1"
fi

if [ -n "$2" ]; then
    confPath="$2"
fi

# 检查配置文件是否存在
if [ ! -f "$confPath" ]; then
    echo "Config file "${confPath}" not found !";
    exit 1
fi


echo "Checking config File ${confPath} ."

vmPath=$(grep -B 5 '^-vmargs' "${confPath}" | grep -v '^-vmargs' | grep -A 1 '^-vm' | tail -n 1)
if [ -n "$vmPath" ]; then
    echo "config vm ${vmPath} , exiting ...";
    exit 2;
fi

echo "Appending ${jdkPath} .";

sudo sed -i '/^-vmarg/ {
i\
-vm\
'${jdkPath}'/bin
}' "${confPath}"


echo "Done .";