# <p style="text-align:center">`Mac` 指南</p>

> 跨平台软件统一维护在 <a href="./cross-platform-software.md">cross-platform-software.md</a>，本文只记录 macOS 专属工具与系统级配置。
>
> 以下内容不在本文重复，请直接查阅跨平台文档：
>
> | 类别 | 跨平台文档章节 |
> | --- | --- |
> | 命令行工具（bat / fd / fastfetch / tree / trash-cli / tlrc / dos2unix / coreutils / worktrunk） | 八、命令行工具 |
> | 开发工具（gh / git-filter-repo / Maven / mvnd / jadx / mat2） | 九、开发工具 |
> | 数据库客户端（Tiny RDM / DBeaver / DBX / iredis / mycli） | 十、数据库客户端 |
> | 日常 GUI 软件（办公、浏览器、IDE、媒体、AI、效率） | 十一、日常 GUI 软件 |

## 一、Homebrew 基础

### 1. 常用命令

| 目的 | 命令 |
| --- | --- |
| 查看已装 formula | `brew list --formula` |
| 查看已装 cask | `brew list --cask` |
| 只看主动安装的 formula（不含依赖） | `brew leaves` |
| 查看安装目录 | `brew --repo` |
| 体检 | `brew doctor` |
| 清理下载缓存 | `brew cleanup --prune=all` |
| 卸载孤儿依赖 | `brew autoremove` |
| 导出环境清单 | `brew bundle dump --file=~/Brewfile --force --describe` |

### 2. 推荐配置

> fish 写入 `~/.config/fish/conf.d/homebrew.fish`，zsh 写入 `~/.zshrc`

<a href="../config/homebrew.fish">参考配置文件</a>

```fish
# 加载 brew 环境，必须带 fish 参数
eval (/opt/homebrew/bin/brew shellenv fish)

set -gx HOMEBREW_DOWNLOAD_CONCURRENCY 6
set -gx HOMEBREW_MAKE_JOBS 10
set -gx HOMEBREW_BROWSER ""
set -gx HOMEBREW_CURL_RETRIES 3
```

1. `HOMEBREW_DOWNLOAD_CONCURRENCY` 默认是 `1`，即逐个下载；调高后一次装多个包会明显变快。
2. `HOMEBREW_MAKE_JOBS` 只在源码编译时生效，预编译 bottle 不走这条路径。
3. `brew shellenv` 必须带 `fish` 参数，否则输出的是 bash 语法，fish 无法执行。

### 3. Cask 更新

```bash
brew update && brew upgrade --cask
```

> `brew-cask-upgrade`（`brew cu`）已不需要，`brew upgrade --cask` 原生支持。
> `brew-cask-completion` 已于 2025-05 废弃（brew 原生支持补全），不必安装。

## 二、终端与文件管理

### 1. Ghostty

跨平台终端，配置与限制详见 <a href="./cross-platform-software.md#Ghostty">跨平台文档</a>。

本机为手动安装在 `~/Applications/Ghostty.app`，不在 Homebrew 管理范围内，升级需重新下载。

### 2. yazi

> 终端文件管理器，支持预览与批量操作

* 源码

https://github.com/sxyazi/yazi

* 安装

`brew install yazi`

## 三、Shell 环境

### 1. fish

```bash
brew install fish
echo "$(which fish)" | sudo tee -a /etc/shells
chsh -s $(which fish)
```

### 2. starship

> 提示符，`oh-my-zsh` 主题的替代品，Rust 编写

* 安装

`brew install starship`

* 配置

<a href="../config/starship.toml">参考配置文件</a>

```bash
eval "$(starship init zsh)"
```

```fish
# fish
starship init fish | source
```

### 3. zoxide

> `z` 命令，替代 `cd`，支持模糊跳转

* 安装

`brew install zoxide`

```fish
zoxide init fish | source
```

### 4. 升级 bash

> macOS 自带 bash 停留在 `3.2.57`（版权原因），`declare -A a=()` 这类语法不支持。本节目标是：不影响系统自带 bash、不改变主 shell（当前用 fish）、脚本里用 `#!/usr/bin/env bash` 时走新版。

#### (1) 验证旧版本

```bash
bash --version
/bin/bash --version
```

#### (2) 安装新版

```bash
brew install bash
```

#### (3) 验证新旧共存

```bash
which -a bash

# 期望输出
# /bin/bash
# /opt/homebrew/bin/bash
```

分别验证版本：

```bash
/bin/bash --version
/opt/homebrew/bin/bash --version
```

#### (4) 让 `#!/usr/bin/env bash` 指向新版

```bash
sudo ln -s /opt/homebrew/bin/bash /usr/local/bin/bash
```

`/usr/local/bin/bash` 优先级高于 `/bin/bash`。

#### (5) 按需替换默认 shell

> 上一步已达成目的，这一步仅当希望交互式 bash 也为新版时执行

```bash
sudo vim /etc/shells        # 追加 /opt/homebrew/bin/bash
sudo chsh -s /usr/local/bin/bash
```

```bash
echo $SHELL
```

### 5. 其他

- `ls` 替代使用 `eza`，配置见 <a href="../config/eza.fish">eza.fish</a>
- 终端历史检索使用 `atuin`，配置见 <a href="./cross-platform-software.md">跨平台文档</a>

### 6. ~~lsd~~（已弃用）

> ⚠️ 本机未安装，`ls` 替代已改用 `eza`。本节作为记录保留。

* 源代码

https://github.com/lsd-rs/lsd

* 安装

`brew install lsd`

* 配置文件

<a href="../config/lsd.yaml">`ln -sf /path/pc-guide/config/lsd.yaml ~/.config/lsd/config.yaml`</a>

## 四、编程语言与运行时

### 1. ⭐ mise（替代 SDKMAN）

> 统一的运行时版本管理器，支持 Java、Node、Python、Go、Rust 等 20+ 语言。

#### (1) 为什么弃用 SDKMAN

1. **只覆盖 JVM 生态**：SDKMAN 只能管 Java/Kotlin/Groovy 等，Node、Python 仍需另配 volta、pyenv，多套工具并存。
2. **fish 支持靠第三方插件**：`sdk` 的 bash 补全无法直接在 fish 生效，依赖 `sdkman-for-fish`，升级容易失效。
3. **路径需要手工对齐**：必须额外维护 `JAVA_HOME` 指向 `/opt/homebrew/opt/sdkman-cli/libexec/candidates/java/current`，切版本后容易和 `mvn` 实际使用的 JDK 不一致，典型症状是 Lombok 注解处理报错。
4. **mise 由 Homebrew 包自带 fish 激活**，不需要额外插件与 `JAVA_HOME` 配置。

#### (2) 安装

```bash
brew install mise
```

> Homebrew 的 mise 包会通过 `/opt/homebrew/share/fish/vendor_conf.d/mise-activate.fish` 自动激活 fish，**不需要往 `config.fish` 写任何东西**。

#### (3) 常用命令

```bash
mise ls                  # 查看已安装运行时
mise use -g java@21      # 全局切换 Java
mise use java@17         # 仅当前目录生效，写入 .mise.toml
mise install             # 按配置文件安装
mise current             # 查看当前生效版本
```

#### (4) 本机现状

全局配置 `~/.config/mise/config.toml`：

```toml
[tools]
java = "zulu-8"
```

```bash
$ java -version
openjdk version "1.8.0_512"
$ echo $JAVA_HOME
/Users/witt/.local/share/mise/installs/java/zulu-8.98.0.107
```

`JAVA_HOME` 由 mise 自动注入，无需手工维护。

#### (5) 迁移清理

SDKMAN 的 fish 适配文件已备份至 `~/.config/fish/backup-sdkman-removed/`，确认无误后可整个删除：

```bash
rm -rf ~/.config/fish/backup-sdkman-removed
```

#### (6) 参考资料

1. mise 官网：https://mise.jdx.dev/
2. mise 官方文档：https://mise.jdx.dev/getting-started.html
3. SDKMAN fish 兼容 issue：https://github.com/sdkman/sdkman-cli/issues/671

### 2. ~~SDKMAN~~（已弃用）

> ⚠️ **本机已迁移至 mise，本节仅作为历史记录保留。** 新环境请直接使用上一节的 mise。
>
> 弃用原因见上一节 mise：SDKMAN 只覆盖 JVM 生态、fish 支持依赖第三方插件、且需要手工对齐 `JAVA_HOME`。

#### (1) 背景说明

在 `zsh` 下，通常会在 `~/.zprofile` 或 `~/.zshrc` 里初始化 SDKMAN，因此 `mvn` 会使用 SDKMAN 管理的 Java。

`fish` 不能直接 `source` SDKMAN 的 bash 脚本，如果不做额外配置，`mvn` 可能回退到系统或 Homebrew 的其他 JDK（例如 JDK 25），进而出现编译异常（常见是 Lombok 注解处理相关报错）。

因此需要在 `fish` 下补齐 SDKMAN 适配，并显式对齐 `JAVA_HOME`。

> fish 的安装方式见 <a href="#1-fish">第三章 fish 小节</a>。

#### (2) 安装 Fisher 和 sdkman-for-fish

```fish
# 安装 Fisher（如果已安装可跳过）
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# 安装 SDKMAN 的 fish 适配插件
fisher install reitzig/sdkman-for-fish@v2.1.0
```

#### (3) 配置 SDKMAN 路径和 JAVA_HOME

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

#### (4) 验证配置

```fish
sdk version
java -version
mvn -v
```

预期：

1. `sdk version` 可正常返回版本信息。
2. `mvn -v` 中的 `Java version` 与 SDKMAN 当前 Java 一致（例如 `1.8.0_462`）。

#### (5) 常见问题

1. `sdk` 命令存在但提示 `INTERNET NOT REACHABLE`：是网络连通性问题，不影响本地已安装版本的切换和使用。
2. `mvn -v` 仍显示错误 JDK：优先检查 `JAVA_HOME` 是否被其他配置覆盖。
3. 使用 Homebrew 安装 SDKMAN 时，不建议硬编码 `/opt/homebrew/Cellar/sdkman-cli/<具体版本>/...`，升级后路径会变化。

#### (6) 参考资料

1. SDKMAN 官方 issue（Fish 兼容背景）：https://github.com/sdkman/sdkman-cli/issues/671
2. sdkman-for-fish 插件：https://github.com/reitzig/sdkman-for-fish
3. Homebrew + Fish + SDKMAN 配置示例：https://www.thinkbinary.co.uk/2024/01/07/setting-up-sdkman-with-fish-and-homebrew

### 3. Volta（Node 版本管理）

> 多版本 Node 管理工具，支持管理 pnpm、npm、npx 包

官网: https://github.com/volta-cli/volta

安装：`brew install volta`

#### (1) fish 配置

`~/.config/fish/config.fish` 追加：

```fish
fish_add_path -g "$HOME/.volta/bin"
```

#### (2) 清理 nvm 等方式安装的包

```bash
# 查询全局安装的包
npm list -g --depth=0

# 逐个删除
npm uninstall -g xxx

# 删除旧的版本管理器
brew uninstall nvm node pnpm yarn
rm -rf /opt/homebrew/lib/node_modules
rm -r $HOME/Library/pnpm
rm -r $HOME/.nvm
```

### 4. uv

> Python 版本与包管理，替代 pyenv + pip + venv

#### 附：~~pyenv~~（已弃用）

> 本机未安装，语义相近的需求由 uv 覆盖（`uv python install/pin`）。
>
> 原用法保留备查：
>
> ```bash
> pyenv install 3.14.4
> pyenv global 3.14.4
> ```

* 安装

`brew install uv`

* 常用命令

```bash
uv python list          # 查看可安装的 Python
uv run python           # 临时运行，自动准备环境
```

* 项目使用

```bash
uv python pin 3.13      # 生成 .python-version

rm -r venv/ .venv/
uv venv

uv pip install -r requirements.txt
```

## 五、开发与排查工具

### 1. Delta

* 源码

https://github.com/dandavison/delta

* 安装

`brew install git-delta`

```bash
git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.navigate true

# 或 delta.light true，也可留空自动检测
git config --global delta.dark true
git config --global merge.conflictStyle zdiff3
```

### 2. git-open

> 在终端用浏览器打开当前仓库的远程页面

```bash
brew install git-open
```

```bash
git open          # 打开远程仓库首页
git open --issue  # 打开 issue 页
```

### 3. ClaudeCode statusLine

#### (1) ccstatusline

官网: https://github.com/sirmalloc/ccstatusline

安装: `volta install ccstatusline`

## 六、效率与截图

### 1. PixPin

* 官网

https://pixpin.cn/

* 安装

```bash
brew install --cask pixpin
```

> 支持长截图、贴图、OCR。首次启动需在「系统设置 → 隐私与安全性 → 屏幕录制」中授权。

### 2. ~~小旺 AI 截图~~（已弃用）

> ⚠️ 本机未安装，截图统一使用 PixPin。本节作为记录保留。

### 3. PPDuck

> 图片批量压缩，截图体积过大时使用

```bash
brew install --cask ppduck
```

### 4. KwikPaste

> 剪贴板历史管理，详见 <a href="./cross-platform-software.md">跨平台文档</a>

```bash
brew install --cask kwikpaste
```

### 5. ~~OneClip~~（已弃用）

> ⚠️ 本机未安装，剪贴板管理已改用 KwikPaste。本节作为记录保留。

* 官网

https://oneclip.cloud/

* 源代码

https://github.com/Wcowin/OneClip

* 安装

```shell
brew install --cask Wcowin/oneclip/oneclip
sudo xattr -rd com.apple.quarantine /Applications/OneClip.app
```

## 七、macOS 专属小工具

### 1. IINA

> macOS 原生播放器，支持几乎所有格式与画中画

```bash
brew install --cask iina
```

### 2. QuickLook 扩展

#### (1) SourceCodeSyntaxHighlight

> 为 `.sql`、`.java` 等代码文件提供高亮快速预览

* 源代码

https://github.com/sbarex/SourceCodeSyntaxHighlight

* 安装

```bash
brew install --cask syntax-highlight
```

* 签名处理

打开**系统设置** → **隐私和安全性** → **允许以下来源的应用程序** → **仍然打开**，或执行：

```bash
xattr -r -d com.apple.quarantine '/Applications/Syntax Highlight.app'
```

#### (2) FluxMarkdown

> 空格预览 Markdown、Mermaid 等

* 官网

https://github.com/xykong/flux-markdown

* 安装

```bash
brew install --cask xykong/tap/flux-markdown
```

#### (3) QuickLook Video

> 预览 MKV、WebM 等视频容器格式

```bash
brew install --cask quicklook-video
```

#### (4) ~~QLMarkdown~~（已弃用）

> ⚠️ 本机未安装，Markdown 预览已改用 FluxMarkdown。本节作为记录保留。

* 源代码

https://github.com/sbarex/QLMarkdown

* 安装

`brew install --cask qlmarkdown`

* 签名处理

`xattr -r -d com.apple.quarantine '/Applications/QLMarkdown.app'`

### 3. 鼠须管

> RIME 输入法 macOS 版，配置完全本地化

* 安装

```bash
brew install --cask squirrel-app
```

* 配置

打开「系统设置」→「键盘」→「文字输入」→「编辑」并添加「鼠须管」。

### 4. SmartFan

> Apple Silicon 风扇控制菜单栏工具

```bash
brew install --cask smart-fan
```

> 首次运行会请求一次管理员授权，用于安装后台服务 `/Library/PrivilegedHelperTools/org.witt.smartfan.helper`。卸载时后台服务需手动清理：

```bash
sudo launchctl bootout system/org.witt.smartfan.daemon
sudo rm -f /Library/PrivilegedHelperTools/org.witt.smartfan.helper \
           /Library/LaunchDaemons/org.witt.smartfan.daemon.plist
```

### 5. Tencent Lemon

> 腾讯清理工具，卸载残留、磁盘分析

```bash
brew install --cask tencent-lemon
```

### 6. Homebrew.app

> Homebrew 的图形界面，可视化查看已装包与更新

```bash
brew install --cask homebrew-app
```

### 7. Windows App

> 微软远程桌面客户端（原 Microsoft Remote Desktop）

```bash
brew install --cask windows-app
```

> 与旧版 `Microsoft Remote Desktop` 的 Bundle ID 相同（`com.microsoft.rdc.macos`），**两者不能同时安装**，否则会抢占 URL scheme。

### 8. System Data Unpacked

> 菜单栏工具，快速查看系统数据占用

```bash
brew install --cask sysdata
```

## 八、字体

> 全部通过 cask 安装，卸载同样用 `brew uninstall --cask`。

### 1. Nerd Font 系列

> 终端与编辑器的图标字体，需要 Nerd Font 补丁才能显示 git、目录等图标。

```bash
brew install --cask \
  font-maple-mono \
  font-hack-nerd-font \
  font-meslo-lg-nerd-font \
  font-cascadia-code-nf \
  font-monaspace-nf
```

| 字体 | 特点 |
| --- | --- |
| `maple-mono` | 中英文等宽对齐好，带连字，日常主力 |
| `hack-nerd-font` | 字形规整，小字号清晰 |
| `meslo-lg-nerd-font` | Powerline 图标最全，终端经典选择 |
| `cascadia-code-nf` | 微软出品，连字丰富 |
| `monaspace-nf` | 字重变化丰富，适合大字号 |

### 2. 中文字体

```bash
brew install --cask \
  font-lxgw-bright-gb \
  font-lxgw-wenkai-mono-tc \
  font-myna
```

| 字体 | 特点 |
| --- | --- |
| `lxgw-bright-gb` | 霞鹜文楷 Bright，正文阅读舒适 |
| `lxgw-wenkai-mono-tc` | 霞鹜文楷等宽，代码注释友好 |
| `font-myna` | MyNa，UI 界面用 |
| `font-mynaui-icons` | MyNa 配套图标字体 |

### 3. 配置建议

终端（Ghostty）中指定字体族，等宽字体优先：

```ini
font-family = Maple Mono NF
```

VS Code `settings.json`：

```json
{
  "editor.fontFamily": "'Maple Mono NF', 'LXGW WenKai Mono TC', monospace",
  "editor.fontLigatures": true
}
```

> 中文与英文混排时把中文字体放在 fallback 位置，避免英文被中文字体接管导致宽度不一致。

## 九、Mac 个性化配置

### 1. 打开「允许任何来源」

```bash
sudo spctl --master-disable
```

打开**系统设置** → **隐私与安全性** → **允许以下来源的应用程序** → **任何来源**。

> 如果没看到「任何来源」选项，按 `command + Q` 完全退出「系统设置」后重新打开。

### 2. 关闭 Chrome 的轻扫切换页面

> Chrome 有横向滚动条时，双指左右滚动会触发前进/后退标签页。运行后需重启 Chrome。

```bash
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool FALSE
```

## 十、终端方案

### 1. 背景

当前以 `Ghostty` 作为主终端，核心诉求：

1. 全局热键快速唤起下拉终端（接近 iTerm2 HotkeyWindow 体验）
2. 终端配置纳入个人仓库，便于多设备同步
3. 需要时可回退到 iTerm2

### 2. Ghostty

<a href="./cross-platform-software.md#Ghostty">见跨平台文档</a>

### 3. ~~iTerm2~~（已弃用）

> 本机已卸载。以下保留作为方案记录。

#### (1) 曾经的适用场景

1. 需要成熟的 Hotkey Window、多 profile、老插件生态时
2. 需要更完整的会话恢复/历史兼容能力时

#### (2) 常用快捷键

打开和关闭半透明：`command + U`

#### (3) 弃用原因

Ghostty 已能覆盖下拉终端 + 配置入库两个核心诉求，iTerm2 的多 profile 与插件生态不再必需，两套终端并存反而增加维护成本。

#### (4) 参考资料

1. iTerm2 Hotkey Window：https://iterm2.com/documentation-hotkey.html
2. iTerm2 Session Restoration：https://iterm2.com/documentation-restoration.html

### 4. cmux（已评估未采用）

#### (1) 定位

`cmux` 更偏「终端工作台」，强调多任务组织、通知与自动化，并非 iTerm2/Ghostty 的完全替代。

#### (2) 当前结论

1. 可作为阶段性体验工具
2. 就当前「全局下拉 + 极简主终端」诉求，已决定弃用，保留 Ghostty 主线

#### (3) 参考资料

1. cmux 中文文档：https://cmux.com/zh-CN
2. cmux 配置文档：https://cmux.com/docs/configuration
3. cmux 入门与能力边界：https://cmux.com/docs/getting-started

## 十一、其他杂项

### 1. 全局配置 git 不转义中文

```bash
git config --global core.quotepath false
```

### 2. Ghostty 中文文档

https://ghostty.zerebos.com/

### 3. 浏览器远程调试

```
chrome://inspect/#remote-debugging
```

### 4. browser-use

```bash
# source ~/.browser-use-env/bin/activate.fish
curl -fsSL https://browser-use.com/cli/install.sh | bash
browser-use doctor
```

### 5. AI 岛工具（已评估未采用）

1. CodeIsland：https://github.com/wxtsky/CodeIsland
2. MioIsland：https://github.com/MioMioOS/MioIsland

> 两者均未安装，保留作为记录。

### 6. 其他软件（已评估未安装）

> ⚠️ 以下三个均未安装，保留原安装命令备查。

```bash
brew install --cask docker
brew install --cask keyclu
brew install --cask utm
```