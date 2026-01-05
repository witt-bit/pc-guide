# <p style="text-align:center">`Mac` 指南</p>

## 一、常用软件安装

brew install brew-cask-completion
brew install brew-cask-upgrad
brew cu -a -y
brew update
brew upgrade

# 查看brew安装目录
brew --repo

brew install --cask docker
brew install --cask keyclu
brew install --cask utm
brew install pixpin

截图软件
小旺AI截图

## 二、Mac个性化配置

#### 1.打开**允许任何来源**的应用程序

终端运行以下命令后
```bash
sudo spctl --master-disable
```

打开**系统设置**--->**安全性**--->**允许以下来源的应用程序**--->**任何来源**

> 如果没看到**任何来源**选项，需要`control + Q`退出*系统设置**后再次打开

#### 2.关闭Chrome的**轻扫切换页面**

> Chrome有横向滚动条时，会跟Mac触控板的双指左右滚动冲突，导致页面滚动时，触发前进/后退标签页，通过此设置解决。<br/>
> 运行完设置后，需要重启Chrome

```shell
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool FALSE
```
