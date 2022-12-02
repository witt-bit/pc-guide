# `Linux`开发环境

> Author : witt
>
> Date : 2022-08-12

# 一、开篇

## (一)、Linux 及其发行版

[![xWtztA.jpg](https://s1.ax1x.com/2022/10/26/xWtztA.jpg)](https://imgse.com/i/xWtztA)

##  (二)、各发行版Linux的区别

### 1. 包管理器不同

| 发行版   | 发行版系统                              | 包管理器       | 包管理工具 | 软件包格式                     |
| -------- | --------------------------------------- | -------------- | ---------- | ------------------------------ |
| `Debian` | `Deepin`,`Ubuntu`（Kylin）,`Linux Mint` | `apt`          | `dpkg`     | `*.deb`                        |
| `Arch`   | `Manjaro`,`Arch Linux`                  | `pacman`,`yay` |            | `*.pkg.tar.xz`,`*.pkg.tar.zst` |
| `RedHat` | `CentOS`,`SuSE`,`红旗`                  | `yum`,`dnf`    | `rpm`      | `*.rpm`                        |



### 2. 预装桌面环境不同

| 系统                    | 预装桌面                            |
| ----------------------- | ----------------------------------- |
| `Ubuntu`                | `gnome` 或 `Unity`                  |
| `Arch Linux`、`Manjaro` | 跟随ISO，可选`kde`、`xfce`、`gnome` |
| 其它                    | 各自的定制化桌面                    |

# 二、Linux基本环境

## (一)、Linux 桌面环境

| 名称  |                             说明                             |
| ----- | :----------------------------------------------------------: |
| gnome | 非常直观，简洁，使用比较自然，定制化程度一般（无最基本的字体，外观等选项），很多发行版默认的桌面环境，如需拓展，需要安装`shell`插件，但插件管理能力很差 |
| unity | 运行于gnome之上，通知能力一版，Ubuntu系列的定制桌面，不支持其他主流的发行版，定制化很差，但是比较直观 |
| kde   | 功能强大，可配置型极高，自由度很强的桌面环境，基于QT，类似Windows,兼容性很强，自带组件很多，以K开头，配置复杂度高 |
| xfce  | 空间占用极小，类似KDE，图像渲染能力极差，甚至缺失，对于低内存老旧机器适应很好，支持的软件比较少 |

如何切换桌面？
1.<a id="desktopEnv@chEnv2KDE">换Ubuntu的gnome桌面环境为kde</a>
网友1： `sudo apt install -yq kubuntu-desktop # 会将gUbuntu换成Kubuntu`
网友2：`sudo apt install -yq kde-full # 完整版，安装很多名字为k开头的游戏`
网友3：`sudo apt install -yq kde-plasma-desktop # 最小安装，真的只有个桌面`
**我**：`sudo apt install -yq kde-standard # 标准版`

> [打开KDE主题商店](https://store.kde.org/browse/)
> KDE换主题或插件，打开在线商店失败？下载失败？
> 在设置中将系统语言改成英文，即可解决，设置完成后，可以改回来

2.换Ubuntu的gnome桌面环境为xfce等
xfce的Ubuntu叫xUbuntu,安装方式同kde

```bash
sudo apt install -yq xfce4-standard
```

## (二)、Linux Shell环境
### 1.查看本机安装的所有Shell
```bash
cat /etc/shells
```

[![xWtOmD.png](https://s1.ax1x.com/2022/10/26/xWtOmD.png)](https://imgse.com/i/xWtOmD)

### 2.Shell种类

| Shell名称 | 配置文件  | 备注                                                     |
| --------- | --------- | -------------------------------------------------------- |
| bash      | ~/.bashrc | Linux 默认Shell                                          |
| sh        | ~/.bashrc | bash的别名                                               |
| csh       |           | C语言风格的Shell                                         |
| zsh       | ~/.zshrc  | 功能丰富，可拓展性很强，可安装插件的shell,注重交互式操作 |
### 3.本机默认Shell
```bash
# 输出本机
echo $SHELL

# 修改本机默认shell （交互式修改）
chsh

# 修改默认Shell为zsh
chsh -s /bin/zsh

```


# 三、Linux 软件

## (一)、有哪些安装方式？
### 1.包管理器安装（推荐）
> 优点: 简单，便捷，一行命令就结束了，升级跟随系统
> 缺点:
> 	1.支持安装的软件数量完全取决于对应发行版的软件生态圈
> 	2.很多好用的软件不存在于软件源仓库中，需要自己寻找添加ppa，才能使用包管理器安装
> 	3.开源软件几乎都不支持这种方式，即使支持，寻找ppa也比较困难
```bash
# arch 发行版
sudo pacman -S peek;
# 使用AUR仓库
yay -S com.qq.weixin.work.deepin-x11;

# Red Hat
rpm -ivh nginx.rpm

# centOS
yum install nginx;

# Ubuntu，debian
audo apt-get install nginx;
```
### 2.源码编译安装
> 优点: 能学习到软件开发者的思路，了解到软件的构成（我是没学习到。）。还可以自由定制化。绝大部分程序员都推荐你这么安装，但是我不推荐！
> 缺点:
> 	1.自己编译，你得有功底，而且很费时间，一旦遇到error,只能自己去ISSUE上找，找不到就得劝退。
> 	2.软件更新后，需要拉取最新的代码，再次手动编译安装，重点是你不知道作者什么时候更新了

* 一般步骤
```bash
cd source/;

# 检查编译环境
./configure

# 对源代码进行编译
make

# 安装
sudo make install

# 可选，清理编译产生的临时文件
make clean
```

### 3.二进制文件安装
> 优点: 安装很方便，作者已经打好包，下载到压缩文件解压后，放在对应目录下，加环境变量/软链接/桌面图标即可
> 缺点:
> 	1.下载时，要能分清楚架构: arm,X64,X86等
> 	2.无法获得更新，更新时需要下载最新的包覆盖。

* 一般步骤
```bash
# 下载
wget http://xxxx.com/xxx-1.0.0.tar.gz
# 解压
tar xf xxx-1.0.0.tar.gz -C xxx

# 链接可执行文件到全局使用
cd xxx
ln -s xxx /usr/bin/xxx
```

## (二)、推荐怎么安装？Why？

* 优先包管理器

> 可以在更新系统的同时，更新对应的软件

* 软件包`*.deb`安装

# 四、高效率从Shell开始

## (一)、选择适合自己的Shell
### 1.为什么要换Shell

* 为了shell命令不区分大小写
* 获得准确的命令行提示，更精确的tab补全
* 展示更多的命令行信息（git分支，仓库变化等）
* 获得主题、插件的支持，更好的自定义和拓展性
* 智能切换目录等

### 2.oh my zsh安装和主题、插件
#### (1)`oh my zsh`安装
* [ohmyzsh 官网](https://ohmyz.sh/)
* [ohmyzsh 官方文档](https://github.com/ohmyzsh/ohmyzsh/wiki)
```bash
sudo apt -yq install zsh;
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";

# 报错，curl找不到，安装curl
sudo apt -yq install curl wget;
```
#### (2)`oh my zsh`主题
* [主题官网](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes)
* 主题文件存放目录`${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes`
##### 使用方法
* `clone`到主题目录下
```bash
# ssh clone
git clone git@github.com:romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# http
git clone https://github.com/romkatv/powerlevel10k ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
```
* 修改环境变量
将`~/.zshrc`文件中的`ZSH_THEME`变量值改成自己`clone`的目录的名字
* 使配置生效
  重启终端或执行`source ~/.zshrc`
#### (3)`oh my zsh`插件
* [插件官网](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins)
* 插件存放目录`${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins`

##### 使用方法
* `clone`到插件目录下
  `git clone git://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`

* 修改环境变量
    将插件目录名添加到`~/.zshrc`文件中的`plugins`数组中
* 使配置生效
    重启终端或执行`source ~/.zshrc`

##### 插件推荐
```bash
# 语法高亮
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# 命令建议
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# 历史命令提示
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
```
参考`plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search themes gitignore cp sudo z extract)`

> `z`完成路径智能`cd`，输入曾经`cd`路径中的一部分即可
> `双击ESC`当前命令前面加`sudo`
> `thefuck`命令自动纠错
> `extract` 智能解压，忽略`tar`,`zip`,`7z`的区别

## (二)、高效率shell命令

### 1.通用小众Shell命令
#### (1).`!!`
> 原样返回上一条命令（不管成功与失败）
案例: `sudo !!`,忘记加`sudo`，下一行直接执行

#### (2).`xkill`替换`kill -9`,`kill -15`替换`kill -9`
* `kill -9 pid` 立刻停止`pid`进程

* `kill -15 pid`发送中断信号给`pid`进程，该进程完成自己的事情后退出，俗称`优雅关闭`

  [![xWtqOO.png](https://s1.ax1x.com/2022/10/26/xWtqOO.png)](https://imgse.com/i/xWtqOO)

`kill -15`能触发JVM的关闭钩子，`kill -9`不会
```java
Runtime.getRuntime().addShutdownHook(new Thread(){
    @Override
    public void run() {

    }
});
```
* `xkill`是`kill`的图形化命令，可以用鼠标获取一个应用程序的焦点，完成`kill`
#### (3).`nohup`和`&`
* `nohup`将进程放在后台，该进程所有输出重定向到`nohup.out`文件，该进程不会随着当前session挂断（`SIGHUP`信号），但会被`Ctrl + C`（`SIGINT`）关闭
* `&`将进程放在后台，该进程的所有输出仍然屏显在当前会话的`console`中，该进程的会在当前会话结束时结束，不会被`Ctrl + C`（`SIGINT`）关闭
* 使用`nohup xxx &`组合，免疫`SIGHUP`和`SIGINT`信号
#### (4).`/dev/null`和`/dev/zero`
* `/dev/null`空设备文件，只写，也称`黑洞`，所有内容写入它，都会丢失
* `/dev/zero`字符设备文件，只读，里面有无穷无尽的`0`
#### (5).`dd if of bs count`
快速创建一个10G的txt文件`dd if=/dev/zero of=1.txt bs=1024MB count=9`
记忆 `dd通过if创建count*bs大小的of文件`

* 查看文件大小`du -h`

#### (6).后台进程通用命令
通用格式
* 把应用泡在后台，不显示任何输出`command > /dev/null 2>&1 &`
* 把应用泡在后台，不显示任何输出，且永远运行`nohup command > /dev/null 2>&1 &`

> `0`标准输入
> `1`标准输出
> `2`标准错误输出
> `2>&1`将标准错误输出重定向为标准输出

#### (7).万能的`{}`
##### 1>.简单循环
创建1000个文件
```bash
mkdir -p /tmp/test && cd /tmp/test;
touch {1..1000}.txt
```

扒拉网站上的资源`wget http://192.168.10.61/wallpapers/wallpaper{1..585}.jpg`

##### 2>.占位遍历替换
配合`xargs`命令`find ./ -name ".git" -type d | xargs -i cd {} && cd ../ && git checkout master`
配合`exec`命令`find ./ -name ".git" -type d -exec rm {} \;`

##### 3>.穷举
删除a.txt和b.txt => `rm {a,b}.txt`

... 其他

#### (8).只读文件的写权限
> 有时使用`vim`编辑文件,比如`hosts`或者`/etc`的配置文件`nginx.conf`等,应该使用`sudo vim`，忘记了加`sudo`,已经写好了，执行`:wq`时，才发现忘了加`sudo`

方案: 先保存`:w !sudo tee %`，再`q`退出

### 2.第三方Shell命令
#### (1).`htop`或`btop`
> `top`命令的增强版
> 交互式管理进程
> 动态查看CPU，内存，磁盘占用等
* 安装`sudo apt -yq install htop btop`
* 使用 终端输入`htop`或`btop`
* 卸载`sudo remove htop btop`

#### (2).`tig`

> `git`部分命令的增强版
> 命令行交互式比较文件修改等
* 安装`sudo apt -yq install tig`
* 使用 `git`用`tig`替换
* 卸载`sudo remove tig`

#### (3)`bat`
> `cat`的增强版
> 对文件内容做了语法高亮，格式化输出等

* 安装`sudo apt -yq install bat`
* 使用 `cat`用`bat`替换
* 卸载`sudo remove bat`

> 安装完输入`bat`找不到命令？
> 原因：Ubuntu环境下`bat`命令疑似存在，会被更名为`batcat`
> 方案：
> 	1.使用`batcat`
> 	2.使用软链接覆盖 `sudo ln -sf /usr/bin/batcat /usr/bin/bat
#### (4)`cheat`
> `man`的增强版
> 命令行的案例

* 安装`snap install cheat`
* 使用 `man`用`cheat`替换
* 卸载`snap remove cheat`

### 2.自制Shell命令
#### (1).别名简写命令
> `alias`命令可以将一段命令赋值给一个字符串，完成命令的简化
* `ohmyzsh`内置了一些别名，可以直接在终端执行`alias`查看

* 例如切换jdk

```bash
select-java='sudo update-alternatives --config java'
select-javac='sudo update-alternatives --config javac'
```
#### (2).巧用软链接
* 给命令起别名
* 处理快捷图标
```bash
# snap 安装的软件，没有桌面图标
ln -sf /var/lib/snapd/desktop/applications/datagrip_datagrip.desktop /usr/share/applications/datagrip.desktop
```
* 聚合配置文件

  > Linux系统下，所有软件的配置文件，一定放在`~/.config/app/`,可以利用这种特性，将所有的配置文件放在一起，然后link到config目录下，完成所有配置的统一备份

#### (3).<a id="toSSH">ssh别名</a>
> 本机开启`sshd`,运行`sudo apt -yq ssh`

> 目的:`ip`地址记不住，分不清
> 原理: 在`~/.ssh/config`下为每一个链接指定链接信息

使用步骤:
* 创建别名配置
  `echo "Host {ALIAS}\n\tHostName {IP_HOST}\n\tUser {USER_NAME}\n\tPort 22" >> ~/.ssh/config`

* 下次连接直接`ssh {USER_NAME}@{ALIAS}`

#### (4).ssh免登陆
> 目的: 使用ssh公钥免输入密码登录
>
> 安装`sudo apt-get install ssh`

使用步骤:
* 生成sshkey `ssh-keygen [-t rsa] [-f test] -C "comment"`
* 复制本机公钥到目标主机`ssh-copy-id username@host`
* 直接`ssh username@host`或`ssh {ALIAS}`登录

> 免密码 + 别名 组合，完美快捷登录服务器,还可以`scp`免密码传输文件
> 更可以搞破坏 `ssh {ALIAS} "dd if=/dev/zero of=bin bs=1.23G count=370"`

### 3.自制Shell脚本实现自动化

```bash
#!/bin/bash
```
shell脚本运行方式
* `chmod +x test.sh && ./test.sh`
* `bash test.sh`
* `source test.sh`
* `. test.sh`


# 五、高效率软件推荐

## 1.SwitchHost
* [SwitchHost官网](https://swh.app/)

安装
```bash
wget -O switch_hosts.deb https://download.fastgit.org/oldj/SwitchHosts/releases/download/v4.1.2/SwitchHosts_linux_amd64_4.1.2.6086.deb;

sudo dpkg -i switch_hosts.deb;
```
卸载`sudo apt remove switchhosts`

GitHub有时打不开？有时很慢？

* github网站的Hosts,你值得拥有`https://raw.hellogithub.com/hosts`,记得设置更新哦！

[![xWtsWq.png](https://s1.ax1x.com/2022/10/26/xWtsWq.png)](https://imgse.com/i/xWtsWq)

## 2.`node`版本管理器

* [nvm官网](https://github.com/nvm-sh/nvm)
* [n 官网](https://github.com/tj/n)
* 安装
```bash
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# zsh
echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> ~/.zshrc

source ~/.zshrc

# bash
echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> ~/.zshrc

source ~/.bashrc
```

* 使用
```bash
# 下载最新版node
nvm install --lts

# 查看本机安装的所有node版本
nvm list

# 安装指定版本的node,例如10.16.0
nvm install 10.16.0

# 切换node版本,例如 切换未 10.16.0
nvm use 10.16.0

# nvm 删除 10.16.0版本node
nvm uninstall 10.16.0
```

## 3.`git`图形化工具
[gitkraken 官网](https://www.gitkraken.com/)
> 建议安装旧版本，新版本收费，该软件同样用`ssh key`可以操作git,支持自动化，界面很酷

* 安装 `snap install gitkraken --classic`
* 卸载 `snap remove gitkraken`

## 4.拉幕式终端
### （1）.`yakuake`终端
* 安装 `sudo apt install -yq yakuake`
* 卸载 `sudo apt remove yakuake`
### （2）.`guake`终端
[安装指南](https://guake.readthedocs.io/en/latest/user/installing.html#debian-ubuntu)
* 安装
```bash
sudo add-apt-repository ppa:linuxuprising/guake
sudo apt-get update
sudo apt install guake
```
* 卸载 `sudo apt remove guake`

## 5.轻量编辑器`sublime Text`
[sublime Text 官网](http://www.sublimetext.com/docs/linux_repositories.html)
* 安装
```bash
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install -yq sublime-text
sudo apt-get install -yq apt-transport-https
```

* 卸载 `sudo apt remove sublime-text`
## 6.终端分屏`tmux`
### (1).安装
`sudo apt install -yq tmux`
### (2).卸载
`sudo apt remove tmux`
### (3).使用
* `tmux`进入会话
* `ctrl + B => %`垂直拆分窗口（左右各一个）
* `ctrl + B => "`水平拆分窗口（上下各一个）
* `ctrl + B => {  或  ←`光标左移一个窗口
* `ctrl + B => }  或  →`光标右移一个窗口
* `ctrl + B => ↑`光标上移一个窗口
* `ctrl + B => ↓`光标下移一个窗口
* `ctrl + B => o`切换到下一个窗口
* `ctrl + B => ;`上一个和当前窗口循环
* `exit`结束当前会话

## 7.其他软件安装

> 优麒麟的软件商店`https://www.ubuntukylin.com/applications/`

### （1）.Redis图形化连接工具
* 安装`sudo snap install another-redis-desktop-manager`
* 卸载`sudo snap remove another-redis-desktop-manager`
### （2）.Idea

JetBrains系列软件使用`snap`命令安装会出现各种各样的问题，推荐大家使用`apt`命令安装，(开源的ppa源地址)[https://github.com/JonasGroeger/jetbrains-ppa]

* 处理仓库
```bash
# 该命令如果因网络原因出错，可多试几次
curl -s https://s3.eu-central-1.amazonaws.com/jetbrains-ppa/0xA6E8698A.pub.asc | gpg --dearmor | sudo tee /usr/share/keyrings/jetbrains-ppa-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jetbrains-ppa-archive-keyring.gpg] http://jetbrains-ppa.s3-website.eu-central-1.amazonaws.com any main" | sudo tee /etc/apt/sources.list.d/jetbrains-ppa.list > /dev/null
sudo apt-get update
```

* 安装
```bash
sudo apt-get install -yq intellij-idea-ultimate
#sudo apt-get install -yq intellij-idea-community
```
* 卸载
```bash
sudo apt-get remove intellij-idea-ultimate
sudo apt-get remove intellij-idea-community
```
### （3）.datagrip
* 安装
```bash
sudo snap install datagrip --classic
# 解决snap安装没有启动图标（*.desktop）的问题
ln -sf /var/lib/snapd/desktop/applications/datagrip_datagrip.desktop /usr/share/applications/datagrip.desktop
```
* 卸载`sudo snap remove datagrip`
### （4）.FoxitReader
[官网](https://www.foxitsoftware.cn/pdf-reader/)

* 安装
```bash
cd /tmp
# 下载
wget -o FoxitReader.tar.gz https://cdn07.foxitsoftware.cn/pub/foxit/reader/desktop/linux/2.x/2.4/en_us/FoxitReader.enu.setup.2.4.5.0727.x64.run.tar.gz

# 解压
tar xf FoxitReader.tar.gz

# 运行解压后的.run文件，做图形化安装
./*.run
```
* 卸载`/opt/f/opt/foxitsoftware/foxitreader/maintenancetool`
### （5）.录屏视频、GIF
* 安装`sudo apt install -yq peek`
* 安装`sudo apt remove peek`
### （6）.剪切板管理
* 安装`sudo apt install -yq copyq`
* 安装`sudo apt remove copyq`
### （7）.Windows桌面远程（RDP协议）
* 安装`sudo apt install -yq rdesktop`
* 安装`sudo apt remove rdesktop`
### （8）内网穿透
[frp官网](https://gofrp.org/)
安装参考=> [点击打开安装指南](https://gofrp.org/docs/setup/)
### （9）压缩和解压
#### 1> zip格式
* 安装`sudo apt install -yq zip unzip`
* 卸载`sudo apt remove zip unzip`
#### 2> 7z格式7zip
* 安装`sudo apt install -yq 7zip`
* 卸载`sudo apt remove 7zip`
#### 3> 图形化压缩加压缩
* 安装`sudo apt install -yq ark`
* 卸载`sudo apt remove zip ark`
#### 4> 图形化压缩加压缩（高级）
[peazip安装参考](https://peazip.github.io/peazip-linux.html)

### （10）微信
```bash
wget -O- https://deepin-wine.i-m.dev/setup.sh | sh
sudo apt-get install -yq com.qq.weixin.deepin
sudo apt-get install -yq fonts-droid-fallback ttf-wqy-zenhei ttf-wqy-microhei fonts-arphic-ukai fonts-arphic-uming
sudo apt install -yq libjpeg62:i386
```
### （11）<a id="toStacer">系统清理优化`Stacer`</a>
一个开源系统优化器和应用程序监视器，可帮助用户从不同方面管理整个系统。
* 安装
```bash
sudo add-apt-repository ppa:oguzhaninan/stacer
sudo apt-get update
sudo apt-get install -yq stacer
```
* 卸载 `sudo apt-get remove stacer`
### （12）GoogleChrome
* 安装
```bash
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/googlechrom-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/googlechrom-keyring.gpg
sudo apt update
sudo apt-get install -yq google-chrome-stable
```
* 卸载`sudo apt remove google-chrome-stable`

### （13）全局搜索启动，窗口切换工具
`ulauncher`和`albert`,目前`ulauncher`从外观，拓展各方面比`albert`强
[ulauncher官网](https://ext.ulauncher.io/)

* 安装
```bash
sudo add-apt-repository -y ppa:agornostal/ulauncher
sudo apt -yq update
sudo apt -yq install ulauncher
# 开机自启动
systemctl --user enable --now ulauncher
# 禁用自启动
systemctl --user disable --now ulauncher
```
* 卸载 `sudo apt remove ulauncher`

### （14）HTTP接口测试工具
[Apifox官网](https://www.apifox.cn/)
* 安装
```bash
mkdir -p /tmp/apifox && cd /tmp/apifox;
wget -O apifox-latest.zip https://cdn.apifox.cn/download/Apifox-linux-deb-latest.zip
unzip apifox-latest.zip;
sudo dpkg -i *.deb;
```
* 卸载`sudo apt remove apifox`
### （15）远程控制
[Todesk官网](https://www.todesk.com/)
* [安装](https://www.todesk.com/linux.html)
```bash
mkdir -p /tmp/todesk && cd /tmp/todesk;
wget -O todesk_latest.deb https://dl.todesk.com/linux/todesk-v4.3.1.0-amd64.deb
sudo dpkg -i todesk_latest.deb;
```
* 卸载 `sudo apt remove todesk`
### （16）钉钉
[DingTalk官网](https://alidocs.dingtalk.com/i/p/nb9XJlJ7QbxN8GyA/docs/ROGpvEna5YQWmaPgQ156W4ykmK3zoB27)
* 安装
```bash
mkdir -p /tmp/dingtalk && cd /tmp/dingtalk;
wget -O dingtalk_latest.deb https://dtapp-pub.dingtalk.com/dingtalk-desktop/xc_dingtalk_update/linux_deb/Release/com.alibabainc.dingtalk_1.4.0.20425_amd64.deb
sudo dpkg -i dingtalk_latest.deb;
```
* 卸载 `sudo apt remove dingtalk`
### （17）文本差异比较
* 安装 `sudo apt -yq install meld`
* 卸载 `sudo apt remove meld`
### （18）视频播放器
* 安装 `sudo apt -yq install vlc`
* 卸载 `sudo apt remove vlc`
### （19）思维导图
* 安装 `snap install xmind`
* 卸载 `snap remove xmind`
### （20）截图软件
#### 1>简单截屏flameshot
简单截图，画笔编辑，添加文字等
* 安装 `sudo apt -yq install flameshot`
* 卸载 `sudo apt remove flameshot`
* 启动命令`flameshot gui`,可以用这个命令做全局快捷键

> 更加详细的命令，参考`flameshot -h`

#### 2>shutter
高级截图，捕获弹出式菜单等
* 安装 `sudo apt -yq install shutter`
* 卸载 `sudo apt remove shutter`

> 更加详细的命令，参考`shutter -h`,这个软件重在图形化界面的编辑

### （21）查看系统信息
* 安装`sudo apt install -yq screefetch`
* 卸载`sudo apt remove screefetch`

[![xWtX0e.png](https://s1.ax1x.com/2022/10/26/xWtX0e.png)](https://imgse.com/i/xWtX0e)

### （22）搜狗输入法安装
> 搜狗输入法Linux版依赖Linux的小企鹅框架`Fcitx`,目前`Fcitx`已经到`Fcitx4`版本，且已经弃用，搜索输入法仍然在使用，推荐大家用云鹤双拼，新版的Ubuntu安装后，已经移除了`Fcitx`框架

* 安装
```bash
# 卸载新版的ibus
sudo apt purge ibus;
# 安装停更的 fcitx
sudo apt update;
sudo apt-get -yq install fcitx;
# sudo cp /usr/share/applications/fcitx.desktop /etc/xdg/autostart/

# 安装搜狗
mkdir /tmp/sogoupinyin && cd /tmp/sogoupinyin;
wget -O sogoupinyin_lastest.deb https://ime.sogouimecdn.com/202209071108/ba44083b104645aa5acfac21a5e64f66/dl/gzindex/1656597217/sogoupinyin_4.0.1.2800_x86_64.deb

sudo dpkg -i sogoupinyin_lastest.deb
# 安装缺失库
sudo apt -fyq install；
# 安装依赖库
sudo apt -yq install libqt5qml5 libqt5quick5 libqt5quickwidgets5 qml-module-qtquick2 libgsettings-qt1

# 重启
sudo reboot;
```
* 重启后，删除除搜狗外的所有键盘，包括英语键盘，然后在搜狗中设置`shift`切换中英文，输入体验会很棒哦！
[![xWtclV.png](https://s1.ax1x.com/2022/10/26/xWtclV.png)](https://imgse.com/i/xWtclV)

* 记得关闭不用的快捷键，防止与其他软件的快捷键冲突，尤其是`Ctrl + Shift + F`,这是Idea的搜索
[![xWtgyT.png](https://s1.ax1x.com/2022/10/26/xWtgyT.png)](https://imgse.com/i/xWtgyT)

* 还要开启默认为英文输入，方便在终端使用哦！
[![xWt6S0.png](https://s1.ax1x.com/2022/10/26/xWt6S0.png)](https://imgse.com/i/xWt6S0)

遇到问题了？搜狗卡顿老闪退？有时还报错？

* 一行命令重置它`rm -rm ~/.config/sogoupinyin && sudo reboot`

### （23）服务器文件传输
> 往服务器上传输文件，依靠[SSH](toSSH)协议，通过`scp`命令可以很便捷的传输文件，某些时候，文件比较多，环境复杂时，需要图形化工具，`FileZilla`就是做这个事情的,支持`ssh`,`ftp`等

* 安装`sudo apt -yq install filezilla`
* 卸载`sudo apt remove filezilla`

### （24）Linux上的ps软件
> `Gimp`类比于Windows环境下的`PhotoShop`

* 安装`sudo apt -yq install gimp`
* 卸载`sudo apt remove gimp`
### （25）绘画软件
> `krita`类比Windows的画图程序，功能又比画图强大，适合草绘，插图，漫画等，支持数位板、滤镜、图层等

* 安装`sudo apt -yq install krita`
* 卸载`sudo apt remove krita`

### （26）Visual Studio Code
Ubuntu 新版推出了`snap`包管理器，这个管理器可以直接安装vscode,使用命令 `snap install code --classic`即可，但是安装的是阉割版，存在不能输入中文的问题，所以更加推荐导入微软的`GPG key`来安装完整版
#### 1> 安装
* 导入GPG
`wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -`
* 添加源
`sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"`
* 更新源
`sudo apt update`
* 安装
`sudo apt install code`

#### 2> 卸载
`sudo apt remove code`

### （26）WebStorm
* 安装`snap install webstorm --classic`
* 卸载`snap remove webstorm`
* 图标问题=>[解决snap找不到图标问题](#toQuestions@desktopNotFound)

### （27）应用停靠栏
#### 1）Linux环境
Linux环境下的Dock有很多种，`latte-dock`,`dash-to-dock`,`dockty`等，这里推荐`latte-dock`

[![xWt2OU.png](https://s1.ax1x.com/2022/10/26/xWt2OU.png)](https://imgse.com/i/xWt2OU)

* 安装`sudo apt -yq install latte-dock`
* 卸载`sudo apt remove latte-dock`
* 使用
首次直接命令行执行`latte-dock > /dev/null 2>&1 &`,启动后在首选项设置开启自启动即可。

`latte-dock`完美适配KDE主题，图标渲染等，插件下载同KDE商店，[点击直达切换为KDE桌面](#desktopEnv@chEnv2KDE)

#### 2）Windows环境
[直达MyDockMyFinder官网](https://www.mydockfinder.com/)

### （28）免费版`Typora`
> `Typora`在1.0版本之后，走了收费路线，我们这种用了很多年的老用户，全部都转到`MarText`去了，但是由于使用习惯的问题，还是倾向于使用`typora`
> `typora`虽然在1.0之后收费了，但是最后的Beta版本`0.18.11`仍然可以继续使用，由于官网国内打不开，我这里提供局域网内的安装方式

```bash
mkdir -p /tmp/typora && cd /tmp/typora;
wget -O apifox-latest.zip https://cdn.apifox.cn/download/Apifox-linux-deb-latest.zip
wget  -O typora.deb http://192.168.10.61/packages/typora.deb
sudo dpkg -i *.deb;
```

# 六、Chrome插件和脚本

## （一）、Chrome插件网站
* `https://www.crx4chrome.com/`
* `https://www.extfans.com/`
* `https://chrome.zzzmh.cn/#/index`
* `https://www.crxsoso.com/`
## （二）、Chrome插件
### 1.安装离线插件
* 下载crx文件
* 打开Chrome拓展程序页面
[![xWtb6K.png](https://s1.ax1x.com/2022/10/26/xWtb6K.png)](https://imgse.com/i/xWtb6K)
* 将crx文件拖进去

crx拖放安装失败？

* 将下载后的文件后缀`.crx`改成`.zip`
* `unzip xxx.zip`解压缩
* 如图打开开发者模式，加载解压的插件

[![xWtHl6.png](https://s1.ax1x.com/2022/10/26/xWtHl6.png)](https://imgse.com/i/xWtHl6)

### 1.安装在线插件
> 离线安装完iGuge后，就可以打开Google商店在线安装了
> 建议全部采用在线安装，登录Google账户后，换电脑，重装系统，都可以同步插件和设置，而且支持在线更新

### 2.插件推荐
#### （1）.插件管理器
* 二管家安装地址`https://chrome.google.com/webstore/detail/extension-manager/gjldcdngmdknpinoemndlidpcabkggco?hl=en-US`
* 可以很方便的启用/禁用插件，分组管理等
#### （2）.网页长截图插件
* 安装地址`https://chrome.google.com/webstore/detail/take-webpage-screenshots/mcbpblocgmgfnpjjppndjkmgjaogfceg?hl=en-US`
#### （3）.新标签页插件
##### 1>Itab
安装地址`https://chrome.google.com/webstore/detail/itab%E6%96%B0%E6%A0%87%E7%AD%BE%E9%A1%B5/mhloojimgilafopcmlcikiidgbbnelip?hl=en-US`
##### 2>Infinity Pro
安装地址`https://chrome.google.com/webstore/detail/infinity-new-tab-pro/nnnkddnnlpamobajfibfdgfnbcnkgngh?hl=en-US`
#### （4）.广告拦截
* 安装地址`https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm?hl=en-US`
#### （5）.脚本插件
##### 1>油猴插件`Tampermonkey`
安装地址`https://chrome.google.com/webstore/detail/tampermonkey/dhdgffkkebhmkfjojejmpbldmpobfkfo?hl=en-US`
##### 2>暴力猴插件`Violentmonkey`
安装地址`https://chrome.google.com/webstore/detail/violentmonkey/jinjaccalgkegednnccohejagnlnfdag?hl=en-US`

## （三）、脚本
* 原理：借助油猴插件或暴力猴插件运行自定义的`javascript`代码

[![xWtof1.png](https://s1.ax1x.com/2022/10/26/xWtof1.png)](https://imgse.com/i/xWtof1)

* 脚本获取地址`https://greasyfork.org/zh-CN`


# 七、同步和备份

## （一）、常用开发工具配置备份
### 1.JetBrains系列备份
#### （1）.使用JetBrains自带的`Settings Repository`功能

* 新建git仓库，复制仓库地址

[![xWtIYR.png](https://s1.ax1x.com/2022/10/26/xWtIYR.png)](https://imgse.com/i/xWtIYR)

* 依次打开软件的`Settings Repository`功能

[![xWtfw4.png](https://s1.ax1x.com/2022/10/26/xWtfw4.png)](https://imgse.com/i/xWtfw4)

* 第一次备份，选择`Overwrite Remote`,第一次还原选择`Overwrite Local`

[![xWtWmF.png](https://s1.ax1x.com/2022/10/26/xWtWmF.png)](https://imgse.com/i/xWtWmF)


> 优点:软件每次关闭会自动将新配置提交到git仓库，无需人工处理，只配置依次
> 缺点:无法同步`Plugins`和`Live Templates`等，这些内容要自己备份

#### （2）.自己备份软件的配置目录
* 查看idea配置的目录`bat /opt/intellij-idea-ultimate/bin/idea.properties`

[![xWt7Sx.png](https://s1.ax1x.com/2022/10/26/xWt7Sx.png)](https://imgse.com/i/xWt7Sx)

* 自己在其他目录下创建配置目录，初始化git仓库，写好`.gitignore`文件，手动同步
* 自己写`crontab`定时任务，完成`commit`和`push`操作

> 优点:全量备份，所有配置都不会丢失
> 缺点:
> 具体区分不开哪些文件需要同步，哪些文件需要忽略，筛选不严格，造成丢失，也可能造成仓库很大
> 定时同步出错后不能及时收到通知，（可以用shell发邮件），每次commit的内容，不能区分变化了什么内容

### 2.利用好Github和gitee
* `GitHub`和`Gitee`就是天然的免费仓库，我们自己的笔记都可以记录在里面，很多软件的配置都在`~/.config`文件夹下，配合`shell`脚本 + `crontab`定时任务 + `ln -sf`软链接，理论上可完成任何软件的配置备份


## （二）、操作系统备份和应急处理
### 1.备份

* 安装timeshift

  `sudo apt install -yq timeshift`

* 配置好`timeshift`的备份回滚策略

[![xWt5k9.png](https://s1.ax1x.com/2022/10/26/xWt5k9.png)](https://imgse.com/i/xWt5k9)

* 注意将备份文件存放在1T的磁盘上

备份文件地址`/run/timeshift/backup/timeshift/snapshots/`

[![xWthTJ.png](https://s1.ax1x.com/2022/10/26/xWthTJ.png)](https://imgse.com/i/xWthTJ)

### 2.应急tty

* tty是Linux的shell环境，你可以理解为应急情况下的Windows命令行终端
* 开机后如果直接进入命令行，未进入桌面，证明桌面环境组件被破坏，查看日志解决

查看系统日志命令`journalctl -e`

* 如果实在无法解决，别忘了咱们的timeshift哦，直接输入`timeshift -h`开始你的操作，Linux一切设备皆文件，直接`cp -rf`动起来
* 理论上，不管是应急状态，还是正常使用状态，Linux桌面环境和tty是可以无缝切换的。切换快捷键一般是`Ctrl + ALT + F1(可能是F2,或者F3)`

# 八、其它问题解决方案

## （一）、截图黑屏
### 1.描述
遇到微信，或者任何第三方软件截屏，一打开第三方软件，屏幕全黑
### 2.原因
这种情况是因为当前登录会话不支持捕获屏幕xdg信息，需要切换登录会话为`Xorg`或者`XWindow`
### 3.解决
（1）注销登录
（2）登录界面右下角齿轮图标选择`Xorg`或`XWindow`,具体取决于Ubuntu的版本

## （二）、微信发送图片变附件
安装库
`sudo apt install libjpeg62:i386`

## （三）、Wine软件中文显示方框
> 以微信为例
### 1.描述
使用Wine模拟的Windows环境，在安装Wine版微信、QQ、钉钉后，可能会在初次打开，中文显示为方框
### 2.原因
这种情况是因为缺少`微软雅黑`的中文字体，字体文件叫`msyh.ttf`或者`msyh.ttc`，名字与Windows注册表中的声明有关
### 3.解决
（1）获取到微软雅黑的字体,注意修改文件名，[点击下载微软雅黑字体](https://github.com/owent-utils/font/blob/master/%E5%BE%AE%E8%BD%AF%E9%9B%85%E9%BB%91/MSYH.TTC)，放在目录`~/.deepinwine/Deepin-WeChat/drive_c/windows/Fonts`
（2）修改文件`~/.deepinwine/Deepin-WeChat/system.reg`中的字体
以下两行中的值改成自己的字体文件名
```reg
"MS Shell Dlg"="msyh"
"MS Shell Dlg 2"="msyh"
```

> 以上内容一行命令搞定`sed -i.bak 's/\Tahoma\b/msyh/' ~/.deepinwine/Deepin-WeChat/system.reg`

（3）家目录下新建文件`msyh_config.reg`
内容如下，注意字体名称对应
```reg
REGEDIT4
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink]
"Lucida Sans Unicode"="msyh.ttf"
"Microsoft Sans Serif"="msyh.ttf"
"MS Sans Serif"="msyh.ttf"
"Tahoma"="msyh.ttf"
"Tahoma Bold"="msyhbd.ttf"
"msyh"="msyh.ttf"
"Arial"="msyh.ttf"
"Arial Black"="msyh.ttf"
```
（4）注册字体
执行`WINEPREFIX=~/.deepinwine/Deepin-WeChat deepin-wine6-stable regedit ~/msyh_config.reg`

> `deepin-wine6-stable`是wine环境的命令，受操作系统版本不同，支持的命令名称不同，具体命令，自己查找一下

## （四）、家目录换英文名
### 1.描述
Ubuntu在初始安装时，如果选择了中文语言，安装后，家目录下的6大文件夹，名称会变成中文名称，在命令行`cd`等，输入时，比较麻烦
### 2.原因
`桌面`->`Desktop`,`文档`->`Doccuments`,`下载`->`Downloads`等文件名称是跟随系统语言的，支持`i18n`
### 3.解决
> 临时修改语言为英文，将主目录更新为英文名，再把语言修改为中文，趁它不注意，不改回来了。

（1）修改为英文语言`export LANG=en_US`
（2）更新主目录语言为英文`xdg-user-dirs-gtk-update`
（3）将语言改回中文`export LANG=zh_CN`

## （五）、系统维护，清理等
`Linux`系统需要关机吗？需要清理垃圾吗？需要杀毒吗？

### 1.系统清理
* 原则上，Linux可以一直不关机，直到不可抗因素（停电等）帮你关机，Linux是不会出现卡顿问题的，完全不同于Windows系统，至于为什么？你可以这么想？咱们的服务器需要关机吗？例如Web服务器，CDN等。
* Linux是可以不做垃圾清理的，前提是使用者要有一个良好的习惯，文件归类，不乱放等，保持系统更新的习惯，不定期手动更新系统和Linux内核

* 常用清理软件

```bash
# 查找获取更新
sudo apt update
# 升级
sudo apt -yq upgrade;

# 删除无用的apt 依赖
sudo apt -yq autoremove
# 删除apt download 之后的包
sudo apt autoclean
```

命令行不熟悉，可以使用软件来管理,[点击直达Stacer安装](#toStacer)

> 建议大家做测试，比如shell测试，读写文件测试等，都在`/tmp`下操作，这个目录下的文件，一段时间不使用会被系统删除，无需我们手动删除

* 杀毒软件不需要，Linux有一句话，`一切设备皆文件`，既然是文件，就有权限，权限在Linux中是比较严格的，平时遇到权限问题，尽量不要一刀切直接赋予`777`权限，建议给`644`或`755`权限。当然也不是说Linux就不会中毒，不会受到攻击，对于我们内网来说，非常安全，至少病毒和攻击者看不上咱们。

* 请务必不要使用`123456`这种简单的密码，如果你的IP暴露（同事之间，或者公网暴露），且`sshd`服务常驻，有可能会被穷举登录成功，带来麻烦。

### 2.系统升级
发现有好多用户，不管是手机还是电脑，应用商店里有很多红点，提示需要升级软件包，一直保留着，永远不点升级。换个角度想想，咱们都是开发者，我们平时改代码，都让强制升级，升级是为了让改的代码生效，如果用户拒不升级，你是开发者，自己是什么感觉。
不升级确实可以用，新的版本总有一些优化点和一些新特性是值得的，Linux是开源，非常稳定的，想用的舒心，不会出现环境问题，应该定时保持更新软件和系统，等你遇到由于系统版本过低，必须升级时，之前积累了太多的更新包，版本间跨度太大，升级风险会非常高，最后只能重装系统解决，船太大，掉不了头的道理谁都懂，可就是做不到。

`结果=正确的环境+正确的代码+正确的操作`

Ubuntu 升级命令，操作系统版本间的更新要跟得上,以下命令复制到终端执行，更新软件包和操作系统。
`sudo apt update -yq;sudo apt upgrade -yq;sudo apt dist-upgrade -yq;sudo do-release-upgrade`

## （六）、<a id="toQuestions@desktopNotFound">snap安装软件没有图标问题</a>

目前通过`snap`安装的软件，桌面图标不会在启动器中显示，原因是snap图标目录`/var/lib/snapd/desktop/applications`不在环境变量中，我们暂时可以通过软链接`ln -sf`命令，将图片链接到系统图标目录`/usr/share/applications/`下，等待官方修复

> snap安装的软件，图标文件名会将该软件名称重复两遍，注意写对。

运行命令`sudo ln -sf /var/lib/snapd/desktop/applications/xxx_xxx.desktop /usr/share/applications/xxx.desktop`
