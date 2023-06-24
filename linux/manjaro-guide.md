# `Manjaro`指南



## 一、安装

1.创建U盘`ISO`镜像

镜像下载地址:`https://manjaro.org/download/`

* 务必使用`DD`模式刻录

2.安装



## 二、常用软件安装

### (一)、系统更新和软件源设置

#### 1.更新系统

`sudo pacman -Syyu`

#### 2.使用国内的软件源

`sudo pacman-mirrors -i -c China -m rank`

#### 3.添加 `Archlinux` 中文社区仓库

使用`vi`命令在 `/etc/pacman.conf`文件末尾添加一下两行:

```
[archlinuxcn]
SigLevel = Optional TrustedOnly
# 清华大学的软件源
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
```

更新`GPG`签名

`sudo pacman -S archlinuxcn-keyring`

### (二)、输入法设置

#### 1.`fcitx4`输入法

处于这个段位的输入法有：`搜狗输入法`、`谷歌输入法`、`讯飞输入法`等

* `fcitx4`已停止维护



#### 2.`fcitx5`输入法设置

处于这个段位的输入法：`小鹤双拼`、`云拼音`、`双拼`

* `fcitx5`新输入法框架，不受谷歌，搜狗的支持

##### (1)安装命令:


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

### （三）、常用软件安装

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
# 安装谷歌浏览器、sublime-text、switchhosts、中文版带窗口的clash、ulauncher、apifox、免费版的typora、linux版钉钉
yay -S --noconfirm google-chrome sublime-text switchhosts-appimage clash-for-windows-chinese-git ulauncher apifox linuxqq typora-free dingtalk-bin

# 安装 dbeaver、guake、peek、截图软件flameshot
sudo pacman -S --noconfirm dbeaver guake peek flameshot

# 安装redis工具another-redis-desktop-manager、vscode、wps、wps字体文件、福昕阅读器
yay -S --noconfirm another-redis-desktop-manager visual-studio-code-bin wps-office ttf-wps-fonts foxitreader 
```



#### 4.`Java`环境

安装`jdk`:`sudo pacman -S jdk8-openjdk`

安装`intellij-idea-ultimate-edition`:`yay -S intellij-idea-ultimate-edition --noconfirm`

#### 5.安装微信

目前微信的版本比较的多，哪个能用用哪个，安装下一个之前，务必卸载当前安装的

`yay -S --noconfirm com.qq.weixin.spark`
`yay -S --noconfirm deepin-wine-wechat`
`yay -S --noconfirm wechat_app`

#### 6.`github`访问问题

国内`github`访问很慢，即使使用`VPN`,依然不能访问，是因为现在好多地址使用了`github`地址都是使用镜像了，通过`VPN`,反而镜像也不能访问了。

在github上有一个github520的项目解决了这个问题，结合软件`SwitchHosts`,就能完美实现github的高速访问

安装好switchhosts后，添加一个远程hosts,填写以下地址:`https://cdn.jsdelivr.net/gh/521xueweihan/GitHub520@main/hosts`

#### 7.`ohmyzsh`安装

`ohmyzsh`就是使用的github镜像，通过上一节的switchhosts设置后，就能正常安装了。

安装地址:`sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";`

推荐主题: `powerlevel10k/powerlevel10k`

#### 8.`clash`安装

正常安装命令:`yay -S clash-for-windows-chinese-git`

但是下载`clash`本身,就需要从github下载，比较慢，可以先用镜像下载一个clash,连接到外网后，再次用命令安装clash,完成后，删除现在的clash即可，后续就可以一条命令更新clash了

clash镜像`https://cors.isteed.cc/github.com/Fndroid/clash_for_windows_pkg/releases/download/0.20.24/Clash.for.Windows-0.20.24-x64-linux.tar.gz`

#### 9.`sublime text`安装

正常安装`sublime-text`:`yay -S sublime-text`

官方安装:

```shell
# 导入签名
curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg

# 软件仓库
echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf

# 安装
sudo pacman -Syu --noconfirm sublime-text
```



#### 10.忽略源文件的校验

手动编译安装:`makepkg -si --skipchecksums`