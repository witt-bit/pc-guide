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

### 5.starship
> `ohMyZsh`的替代品，用rust编写，更快，更小

* 安装

`brew install starship`

* 配置

<a href="../config/starship.toml">参考配置文件</a>

```bash
eval "$(starship init zsh)"
```

### 6.lsd

> `ls`命令的替代

* 源代码:

https://github.com/lsd-rs/lsd

* 安装

`brew install lsd`

### 7.yazi

* 源代码

https://github.com/sxyazi/yazi

* 安装

`brew install yazi`

### 8.剪贴板管理软件

#### (1) OneClip

* 官网

https://oneclip.cloud/

* 源代码

https://github.com/Wcowin/OneClip

* 安装

```shell
brew install --cask Wcowin/oneclip/oneclip
sudo xattr -rd com.apple.quarantine /Applications/OneClip.app
```


### 9.其他软件

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

## 三、终端（Terminal）方案

### 1. 背景说明

本仓库当前以 `Ghostty` 作为主终端方案，核心诉求是：

1. 使用全局热键快速唤起下拉终端（接近 iTerm2 HotKeyWindow 体验）。
2. 将终端配置纳入个人仓库，便于多设备同步与版本管理。
3. 在需要时可回退到 `iTerm2`，或评估 `cmux` 这类工作台型工具。

### 2. Ghostty（当前主用）

#### (1) 配置文件

- 主配置文件（仓库路径）：

  <a href="../config/config.ghostty">../config/config.ghostty</a>

- 实际运行路径（系统读取位置）：

  `/Users/witt/Library/Application Support/com.mitchellh.ghostty/config.ghostty`

> 当前做法是用软链接把系统路径指向仓库主文件，后续只维护仓库里的这一份配置。

#### (2) 关键能力与已知限制

1. 支持 `Quick Terminal`（下拉终端）与 `global:` 全局快捷键。
2. `global:` 快捷键依赖 macOS「辅助功能」权限。
3. macOS 下 `Quick Terminal` 不支持 tabs（官方已明确）。

#### (3) 参考资料

1. Ghostty 功能总览：https://ghostty.org/docs/features
2. Ghostty 配置参考（全部配置项）：https://ghostty.org/docs/config/reference
3. `toggle_quick_terminal` 说明：https://ghostty.org/docs/config/keybind/reference#toggle_quick_terminal
4. Quick Terminal tabs 限制讨论（官方回应）：https://github.com/ghostty-org/ghostty/discussions/2888

### 3. iTerm2（对照与回退方案）

#### (1) 适用场景

1. 需要成熟的 Hotkey Window、多 profile、老插件生态时。
2. 需要更完整的“会话恢复/历史兼容”能力时。

#### (2) 常用快捷键

打开和关闭半透明：`command + U`

#### (3) 参考资料

1. iTerm2 Hotkey Window：https://iterm2.com/documentation-hotkey.html
2. iTerm2 Session Restoration：https://iterm2.com/documentation-restoration.html

### 4. cmux（评估记录）

#### (1) 定位

`cmux` 更偏“终端工作台”，强调多任务组织、通知与自动化；并非 iTerm2/Ghostty 的完全替代。

#### (2) 当前结论（结合个人需求）

1. 可作为阶段性体验工具。
2. 就当前“全局下拉 + 极简主终端”诉求，已决定弃用，保留 Ghostty 主线。

#### (3) 参考资料

1. cmux 中文文档首页：https://cmux.com/zh-CN
2. cmux 配置文档：https://cmux.com/docs/configuration
3. cmux 入门与能力边界：https://cmux.com/docs/getting-started

## 四、其他杂项

- 全局配置 git 不转义中文
  `git config --global core.quotepath false`



  https://github.com/sirmalloc/ccstatusline


https://ghostty.zerebos.com/




brew install ghostty

刘海，灵动岛
claude-island
brew install xmqywx/codeisland/codeisland
https://github.com/MioMioOS/MioIsland


## 五、Fish Shell 配置（SDKMAN / Java / Maven）

### 1. 背景说明

在 `zsh` 下，通常会在 `~/.zprofile` 或 `~/.zshrc` 里初始化 SDKMAN，因此 `mvn` 会使用 SDKMAN 管理的 Java。

`fish` 不能直接 `source` SDKMAN 的 bash 脚本，如果不做额外配置，`mvn` 可能回退到系统或 Homebrew 的其他 JDK（例如 JDK 25），进而出现编译异常（常见是 Lombok 注解处理相关报错）。

因此需要在 `fish` 下补齐 SDKMAN 适配，并显式对齐 `JAVA_HOME`。

### 2. 安装 Fish（如未安装）

```bash
brew install fish
echo "$(which fish)" | sudo tee -a /etc/shells
chsh -s $(which fish)
```

### 3. 安装 Fisher 和 sdkman-for-fish

```fish
# 安装 Fisher（如果已安装可跳过）
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# 安装 SDKMAN 的 fish 适配插件
fisher install reitzig/sdkman-for-fish@v2.1.0
```

### 4. 配置 SDKMAN 路径和 JAVA_HOME

新建文件 `~/.config/fish/conf.d/config_sdk.fish`：

```fish
# SDKMAN path when installed via Homebrew
set -g __sdkman_custom_dir /opt/homebrew/opt/sdkman-cli/libexec

# Keep JAVA_HOME aligned with SDKMAN selected Java (current symlink)
set -gx JAVA_HOME /opt/homebrew/opt/sdkman-cli/libexec/candidates/java/current
```

说明：

1. `/opt/homebrew/opt/sdkman-cli/libexec` 是 Homebrew 的稳定软链接路径，优先于带版本号的 Cellar 目录。
2. `JAVA_HOME` 指向 `candidates/java/current`，可跟随 `sdk use/default java` 自动切换。

### 5. 验证配置

```fish
sdk version
java -version
mvn -v
```

预期：

1. `sdk version` 可正常返回版本信息。
2. `mvn -v` 中的 `Java version` 与 SDKMAN 当前 Java 一致（例如 `1.8.0_462`）。

### 6. 常见问题

1. `sdk` 命令存在但提示 `INTERNET NOT REACHABLE`：是网络连通性问题，不影响本地已安装版本的切换和使用。
2. `mvn -v` 仍显示错误 JDK：优先检查 `JAVA_HOME` 是否被其他配置覆盖。
3. 使用 Homebrew 安装 SDKMAN 时，不建议硬编码 `/opt/homebrew/Cellar/sdkman-cli/<具体版本>/...`，升级后路径会变化。

### 7. 参考资料

1. SDKMAN 官方 issue（Fish 兼容背景）：https://github.com/sdkman/sdkman-cli/issues/671
2. sdkman-for-fish 插件：https://github.com/reitzig/sdkman-for-fish
3. Homebrew + Fish + SDKMAN 配置示例：https://www.thinkbinary.co.uk/2024/01/07/setting-up-sdkman-with-fish-and-homebrew

```bash
chrome://inspect/#remote-debugging

# source ~/.browser-use-env/bin/activate.fish
pyenv global 3.14.4
pyenv install 3.14.4

curl -fsSL https://browser-use.com/cli/install.sh | bash
browser-use doctor

https://github.com/arbourd/git-open

brew install git-open
```