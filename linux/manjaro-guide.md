# `Manjaro`指南

## 一、安装

1.创建U盘`ISO`镜像

镜像下载地址:`https://manjaro.org/download/`

* 务必使用`DD`模式刻录

2.安装

`yay -S ventoy`

## 二、常用软件安装

### (一)、系统更新和软件源设置

#### 1.更新系统

`sudo pacman -Syyu`

#### 2.使用国内的软件源

`sudo pacman-mirrors -i -c China -m rank`

#### 3.添加 `Archlinux` 中文社区仓库

使用`vi`命令在 `/etc/pacman.conf`文件末尾添加一下两行:

```conf
[archlinuxcn]
SigLevel = Optional TrustedOnly
# 清华大学的软件源
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
```

更新`GPG`签名

`sudo pacman -Sy archlinuxcn-keyring && sudo pacman -Su`

### (二)、输入法设置

#### ~~1.`fcitx4`输入法~~

处于这个段位的输入法有：`搜狗输入法`、`谷歌输入法`、`讯飞输入法`等

* `fcitx4`已停止维护

#### 2.`fcitx5`输入法设置

处于这个段位的输入法：`小鹤双拼`、`云拼音`、`双拼`

* `fcitx5`新输入法框架，不受谷歌，搜狗的支持

##### (1)安装命令

```shell
sudo pacman -Syy fcitx5 fcitx5-configtool fcitx5-qt fcitx5-gtk fcitx5-chinese-addons fcitx5-material-color kcm-fcitx5 fcitx5-lua
```

##### (2)设置环境变量

通过`vi`编辑器编辑环境变量文件`/etc/environment`

`sudo vi /etc/environment`

将以下内容保存

```shell
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
```

重启电脑

##### (3)配置输入法

打开系统设置:`个性化`-->`语言和区域设置`-->`输入法`-->`添加输入法`

### (三)、常用软件安装

#### 1.软件

```shell
# 安装vim
sudo pacman -S --noconfirm vim
# 安装网络基础工具 ifconfig命令等
sudo pacman -S --noconfirm net-tools
```

#### 2.`AUR`软件仓库支持

`pacman`自带的软件是非常少的，`AUR`中有大量可用的软件

安装`yay`工具

`sudo pacman -S yay base-devel --noconfirm`

后续软件命令

安装:`yay -S XXX`

同步更新软件: `yay -Syyu`

卸载软件等同`pacman`

#### 3.基本软件安装

```shell
# 中文字体支持，安装后设置中选择noto-cjk
sudo pacman -S noto-fonts-cjk noto-fonts-extra

# 等宽中文 更纱黑体
yay -S ttf-sarasa-gothic-sc

# 安装谷歌浏览器、sublime-text、switchhosts、apifox、免费版的typora、linux版钉钉
yay -S --noconfirm google-chrome sublime-text switchhosts-appimage apifox linuxqq typora-free dingtalk-bin

# 安装 dbeaver
sudo pacman -S --noconfirm dbeaver

# 安装redis工具another-redis-desktop-manager、vscode、福昕阅读器
yay -S --noconfirm visual-studio-code-bin foxitreader
```

#### 4.应用程序启动器

`yay -S ulauncher`

#### 5.截图软件

`sudo pacman -S --noconfirm flameshot`

【推荐】 `yay -S snipaste`

录制gif图 `sudo pacman -S peek`

#### 6.`Office`办公软件

安装`Wps`

* `ibtiff5`是`Wps PDF`支持库
* `xx-cn-xx`是中文语言包

`yay -S wps-office-cn ttf-wps-fonts wps-office-fonts ibtiff5 ttf-ms-fonts wps-office-mime-cn wps-office-mui-zh-cn`

#### 7.`Java`环境

##### (1).安装`JDK`

* 基本命令

`sudo pacman -S jdk版本-openjdk openjdk版本-doc openjdk版本-src`

* 释义

`jdk版本-openjdk` JDK本身
`openjdk版本-doc` JDK的`Java Doc`
`openjdk版本-src` JDK的源码

案例

> 安装JDK8 `sudo pacman -S jdk8-openjdk openjdk8-doc openjdk8-src`<br/>
> 安装JDK11 `sudo pacman -S jdk11-openjdk openjdk11-doc openjdk11-src`

* 多版本共存切换

> `ArchLinux`使用一条命令直接切换`Java`版本，包括`Java`中的所有可执行程序

命令`sudo archlinux-java set java-版本-openjdk`

例如`sudo archlinux-java set java-17-openjdk`

##### (2).安装`intellij-idea-ultimate-edition`

* `intellij-idea-ultimate-edition-jre`对字体虚化的处理支持

`yay -S intellij-idea-ultimate-edition intellij-idea-ultimate-edition-jre --noconfirm`

#### 8.安装微信

目前微信的版本比较的多，哪个能用用哪个，安装下一个之前，务必卸载当前安装的

~~`yay -S --noconfirm com.qq.weixin.spark`~~<br/>
~~`yay -S --noconfirm deepin-wine-wechat`~~<br/>
~~`yay -S --noconfirm wechat_app`~~

官方原生Linux版微信 ：`yay -S wechat-universal-bwrap`

#### 9.`github`访问问题

国内`github`访问很慢，即使使用`VPN`,依然不能访问，是因为现在好多地址使用了`github`地址都是使用镜像了，通过`VPN`,反而镜像也不能访问了。

在github上有一个github520的项目解决了这个问题，结合软件`SwitchHosts`,就能完美实现github的高速访问

安装好switchhosts后，添加一个远程hosts,填写以下地址:`https://cdn.jsdelivr.net/gh/521xueweihan/GitHub520@main/hosts`

#### 10.`ohmyzsh`安装

`ohmyzsh`就是使用的github镜像，通过上一节的switchhosts设置后，就能正常安装了。

安装地址:`sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";`

推荐主题: `powerlevel10k/powerlevel10k`

#### 11.`clbsh`安装

> 由于不合理因素存在，本节中，所有的单词`clbsh`需全部将字母`b`换为`a`

~~已停更：`yay -S clbsh-for-windows-chinese-git`~~

`yay -S clbsh-verge-rev-bin`

但是下载`clbsh`本身,就需要从github下载，比较慢，可以先用镜像下载一个clbsh,连接到外网后，再次用命令安装clbsh,完成后，删除现在的clbsh即可，后续就可以一条命令更新clbsh了

clbsh v1.6.6版本镜像1 ：

`https://ghproxy.cc/https://github.com/clbsh-verge-rev/clbsh-verge-rev/releases/download/v1.6.6/clbsh-verge_1.6.6_amd64.deb`

clbsh v1.6.6版本镜像2 ：
`https://ghproxy.cc/https://github.com/clbsh-verge-rev/clbsh-verge-rev/releases/download/v1.6.6/clbsh-verge_1.6.6_arm64.deb`

#### 12.`sublime text`安装

正常安装`sublime-text`: `yay -S sublime-text`

官方安装:

```shell
# 导入签名
curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg

# 软件仓库
echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf

# 安装
sudo pacman -Syu --noconfirm sublime-text
```

#### 13.忽略源文件的校验

手动编译安装:`makepkg -si --skipchecksums`

#### 14.软件包管理器

`yay -S octopi`

#### 15.剪贴板管理工具

`sudo pacman -S copyq`

#### 16.终端

`sudo pacman -S guake`

主题: `molokai`

#### 17.随用随记

`yay -S heynote-git`

#### 18.`redis`桌面客户端

`yay -S -noconfirm another-redis-desktop-manager`

`yay -S tiny-rdm-git`

#### 19.`SublimeText`和`DBeaver`等软件没有全局菜单

`sudo pacman -S appmenu-gtk-module`

#### 20.`Apple`光标

`yay -S apple_cursor`

#### 21.扫描仪软件

`sudo pacman -S skanlite`

#### 22.多线程下载器`Axel`

`yay -S axel`

#### 23.窗口装饰元素推荐

##### (1) `Utterly Round Dark for Plasma 6`

> 商店地址: <https://store.kde.org/p/2132512>
>
> 源码地址: <https://github.com/HimDek/Utterly-Round-Plasma-Style/tree/master/aurorae/dark/translucent>

##### (2) `Utterly Round Dark Solid for Plasma 6`

> 商店地址: <https://store.kde.org/p/2132516>
>
> 源码地址: <https://github.com/HimDek/Utterly-Round-Plasma-Style/tree/master/aurorae/dark/solid>
## 三、预装软件卸载

### 1.卸载`nano`

```shell
sudo pacman -Rcns nano nano-syntax-highlighting
```

## 四、常见问题解决方案

### 1.网卡使用随机`Mac`地址

在`/etc/NetworkManager/conf.d/`新建任意名称的`.conf`文件,复制以下内容
例如`wifi_rand_mac.conf`

> 后面的注释项按需开启

```txt
[device-mac-randomization]
# 扫描 wifi 时随机化 MAC
wifi.scan-rand-mac-address=yes   # no
 
[connection-mac-randomization]
# 每次通过有线连接时随机化 MAC
ethernet.cloned-mac-address=random # stable
# 每次通过无线连接时随机化 MAC
wifi.cloned-mac-address=random  # stable
```

* 重启网络管理器

`sudo systemctl restart NetworkManager`

### 2.配置网络可用性检查

关键字：网络连接受限、TUN模式

参考地址：<https://wiki.archlinuxcn.org/wiki/NetworkManager>

在`/etc/NetworkManager/conf.d`目录下创建文件`20-connectivity.conf`,内容如下：

```conf
[connectivity]
#uri=http://nmcheck.gnome.org/check_network_status.txt
enabled=false
```

* 重启网络管理器

`systemctl restart NetworkManager`

### 3.`pacman`或`AUR`贡献

* 安装贡献包: `sudo pacman -Syu pacman-contrib`
* 清除AUR软件包构建: `makepkg -cCf`
* 创建`.SRCINFO`文件: `makepkg --printsrcinfo > .SRCINFO`
* AUR包模拟安装: `makepkg -si`
* 更新AUR包中的checksums:  `updpkgsums`或`makepkg -f -g`
* 跳过checksums: 更改为`SKIP`或`makepkg --skipchecksums -si`


### 4.证书安装

> 支持安装`.cer`和`.pem`格式证书文件

安装证书命令文档`update-ca-trust -h`

安装

> 以`charles`证书为例

```shell
# 创建证书目录
sudo mkdir /usr/share/ca-certificates/trust-source/charles

# 将证书源文件🔗到证书安装目录
sudo ln -sf ~/.charles/ca/charles-proxy-ssl-proxying-certificate.cer /usr/share/ca-certificates/trust-source/charles/root.cer

# 安装证书
sudo update-ca-trust extract

# [可选] 验证证书文件是否正确
openssl verify -CAfile /etc/ssl/certs/ca-certificates.crt /usr/share/ca-certificates/trust-source/charles/root.cer
```