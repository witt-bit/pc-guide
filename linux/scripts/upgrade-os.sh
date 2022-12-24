#!/bin/bash

# 操作系统厂商
OS_VERDOR="$(lsb_release -si)";
THIS_RANDOM="$RANDOM";

_os(){
	echo "Upgrading OS ...";
	[[ "${OS_VERDOR}" == "Ubuntu" ]] && sudo apt -yq update;
	[[ "${OS_VERDOR}" == "Ubuntu" ]] && sudo apt -yq upgrade;
}

# 创建快捷方式
_createDesktopFile(){
	local app="$1";
	local desktopFile="/usr/share/applications/${app}.desktop";
	# 已经创建
	if [ -f "$desktopFile" ]; then
		exit 0;
	fi
	echo "create desktop for $app ..."

	sudo touch "${desktopFile}";
	echo "[Desktop Entry]" > "${desktopFile}";
	echo "Terminal=false" >> "${desktopFile}";

	while getopts 'name:exec:type:icon:start:comment:category' OPT; do
	    case $OPT in
	        name) echo "Name=$OPTARG" >> "${desktopFile}";;
	        exec) echo "Exec=$OPTARG %U" >> "${desktopFile}";;
	        type) echo "Type=$OPTARG" >> "${desktopFile}";;
	        icon) echo "Icon=$OPTARG" >> "${desktopFile}";;
	        start) echo "StartupWMClass=$OPTARG" >> "${desktopFile}";;
	        comment) echo "Comment=$OPTARG" >> "${desktopFile}";;
			category) echo "Categories=$OPTARG" >> "${desktopFile}";;
	        ?) echo "ignore option !" ;;
	    esac
	done
}


_apifox(){
	echo "Upgrading apifox ...";
	case "${OS_VERDOR}" in
		'Ubuntu')
			local path="/tmp/apifox-upgrade-${THIS_RANDOM}";
			mkdir -p "$path";
			cd "$path";
			wget -O apifox-latest.zip https://cdn.apifox.cn/download/Apifox-linux-deb-latest.zip
			unzip apifox-latest.zip;
			sudo dpkg -i *.deb;
		;;
	esac
	echo "apifox upgrade finished !"
}

_todesk(){
	echo "Upgrading todesk ...";
	case "${OS_VERDOR}" in
		'Ubuntu')
			local path="/tmp/todesk-upgrade-${THIS_RANDOM}";
			mkdir -p "$path";
			cd "$path";
			wget -O todesk-latest.deb https://dl.todesk.com/linux/todesk-v4.3.1.0-amd64.deb
			sudo dpkg -i *.deb;
		;;
	esac
	echo "todesk upgrade finished !"
}

_aliyundriver(){
	echo "Upgrading aliyundriver ...";
	local path="/tmp/todesk-upgrade-${THIS_RANDOM}";
	mkdir -p "$path";
	cd "$path";
	# 被限流后，需要替换 https://wwe.lanzoui.com/b01nqc4gd
	wget -O aliyundriver-latest.zip "https://develope0.lanzoug.com/082514bb/2022/04/15/7b2a87226ccddeeb24f7ad9f68b885c7.zip?st=wfVaymz2pE6wnXTqAnbQRg&e=1661412433&b=VO8OlgG_bVrpVh1WPUudX41KIDLdXzwS_aArYMv13QUrcA21zUAk5YNAM4VXZReQMnASJbNQYpUWYGZ1h7U2VeaFQoDnQBaFYj&fi=67583070&pid=113-142-58-158&up=2&mp=0&co=1"
	unzip -qd ./ aliyundriver-latest.zip
	sudo rm -rf /opt/aliyundriver;
	sudo mv -f ${path}/阿里小白羊版Linux* /opt/aliyundriver;
	_createDesktopFile -name aliyundriver -exec "/opt/aliyundriver/阿里云盘小白羊版" -type Tools

	echo "aliyundriver upgrade finished !"
}

_dingtalk(){
	echo "Upgrading dingTalk ...";
	case "${OS_VERDOR}" in
		'Ubuntu')
			local path="/tmp/dingtalk-upgrade-${THIS_RANDOM}";
			mkdir -p "$path";
			cd "$path";
			wget -O dingtalk-latest.deb https://dtapp-pub.dingtalk.com/dingtalk-desktop/xc_dingtalk_update/linux_deb/Release/com.alibabainc.dingtalk_1.4.0.20829_amd64.deb
			sudo dpkg -i *.deb;
		;;
	esac
	echo "dingTalk upgrade finished !"
}

_marktext(){
	echo "Upgrading marktext ...";
	case "${OS_VERDOR}" in
		'Ubuntu')
			local path="/tmp/marktext-upgrade-${THIS_RANDOM}";
			mkdir -p "$path";
			cd "$path";
			wget -O marktext-latest.deb https://download.fastgit.org/marktext/marktext/releases/download/v0.17.1/marktext-amd64.deb
			sudo dpkg -i *.deb;
		;;
	esac
	echo "marktext upgrade finished !";
}

_zsh(){
	echo "Upgrading oh-my-zsh ...";
	command -v omz > /dev/null 2>&1 || return 1;
	omz update;
	find ${ZSH_CUSTOM:-~/.oh-my-zsh/custom} -name ".git" -type d | sed 's#/\.git$##' | xargs -I {} git -C {} pull
	echo "oh-my-zsh upgrade finished !";
}

_clash(){
	echo "Reinstalling clash ...";

	local path="/tmp/clash-upgrade-${THIS_RANDOM}";
	mkdir -p "$path";
	cd "$path";
	wget -O clash-for-windows.tar.gz https://proxy.zyun.vip/https://github.com/Fndroid/clash_for_windows_pkg/releases/download/0.20.11/Clash.for.Windows-0.20.11-x64-linux.tar.gz;
	mkdir -p clash-for-windows;
	tar xf clash-for-windows.tar.gz --strip-components 1 -C clash-for-windows;

	echo "汉化 clash ...";
	wget https://ghproxy.com/https://github.com/ender-zhao/Clash-for-Windows_Chinese/releases/download/CFW-V0.20.5_CN/app.asar;
	mv app.asar clash-for-windows/resources;

	sudo rm -rf /opt/clash-for-windows;
	sudo mv clash-for-windows /opt/;
	echo "clash reinstall finished !";
}

_os;
_apifox;
_todesk;
# _aliyundriver;
_dingtalk;
#_marktext;
_zsh;
_clash;