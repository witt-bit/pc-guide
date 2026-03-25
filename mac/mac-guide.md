# <p style="text-align:center">`Mac` 指南</p>

## 一、常用软件安装

> 常用`brew`命令

- 检查 TUI 包版本`brew update`
- 更新 TUI 包`brew upgrade`
- 更新 Cask 包

```bash
brew install brew-cask-completion
brew install brew-cask-upgrad
brew cu -a -y
```

- 查看 brew 安装目录`brew --repo`

### 2.截图软件

#### (1) pixpin

- 官网

https://pixpin.cn/

- 安装

`brew install pixpin`

#### (2) 小旺 AI 截图

### 3.quickLook 拓展

#### (1) SourceCodeSyntaxHighlight

> 为`.sql`、`'.java`等代码文件提供高亮快速预览功能

- 源代码

https://github.com/sbarex/SourceCodeSyntaxHighlight

- 安装

`brew install syntax-highlight`

- 签名处理

> 需要打开**系统设置**--->**隐私和安全性**--->**允许以下来源的应用程序**--->**仍然打开**

`xattr -r -d com.apple.quarantine '/Applications/Syntax Highlight.app'`

#### (2) QLMarkdown

> 为 markdown 文件提供预览功能

- 源代码

https://github.com/sbarex/QLMarkdown

- 安装

`brew install --cask qlmarkdown`

- 签名处理

`xattr -r -d com.apple.quarantine '/Applications/QLMarkdown.app'`

### 4.zoxide
> `z`命令，替换`cd`，支持模糊跳转

* 安装

`brew install zoxide`

### 5.其他软件

```bash
brew install --cask docker
brew install --cask keyclu
brew install --cask utm
```

## 二、Mac 个性化配置

#### 1.打开**允许任何来源**的应用程序

终端运行以下命令后

```bash
sudo spctl --master-disable
```

打开**系统设置**--->**安全性**--->**允许以下来源的应用程序**--->**任何来源**

> 如果没看到**任何来源**选项，需要`control + Q`退出\*系统设置\*\*后再次打开

#### 2.关闭 Chrome 的**轻扫切换页面**

> Chrome 有横向滚动条时，会跟 Mac 触控板的双指左右滚动冲突，导致页面滚动时，触发前进/后退标签页，通过此设置解决。<br/>
> 运行完设置后，需要重启 Chrome

```shell
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool FALSE
```

## 三、Iterm2 配置

打开和关闭半透明: `command + U`

## 四、其他杂项

- 全局配置 git 不转义中文
  `git config --global core.quotepath false`