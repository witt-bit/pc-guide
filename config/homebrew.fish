# link to ~/.config/fish/conf.d/homebrew.fish

# 加载 brew 的完整环境：HOMEBREW_PREFIX/CELLAR/REPOSITORY、PATH、MANPATH、INFOPATH。
# 必须带 fish 参数，否则输出的是 bash/zsh 语法，fish 无法执行。
# 内部用 fish_add_path --move，能把 bin 与 sbin 提到 /usr/bin 之前，
# 因此不需要再单独写 fish_add_path。
eval (/opt/homebrew/bin/brew shellenv fish)

# 下载并发数。Homebrew 默认为 1，即逐个下载 bottle/cask。
# 本机为 Apple Silicon（10 核），实测瓶颈在网络而非 CPU，
# 并发到 6 能明显缩短一次安装多个包时的总耗时。
set -gx HOMEBREW_DOWNLOAD_CONCURRENCY 6

# 编译并发数。仅在源码构建（--build-from-source）时生效，
# 预编译 bottle 不走这条路径。取 10 与本机核心数对齐。
set -gx HOMEBREW_MAKE_JOBS 10

# 关闭自动更新。默认每次执行 brew install/upgrade 前都会先 update，
# 在弱网或 tap 多时明显拖慢响应。改为手动控制更新时机：
#   brew update && brew upgrade
# set -gx HOMEBREW_NO_AUTO_UPDATE 1

# 不自动弹出浏览器。Homebrew 在某些场景（caveats、登录取 token）会调起
# 浏览器，设为空串可抑制该行为。
set -gx HOMEBREW_BROWSER ""

# 网络抖动时的重试次数。GitHub / ghcr.io 偶发连接重置，
# 重试 3 次比直接失败后重跑更省事。
set -gx HOMEBREW_CURL_RETRIES 3

# fish_add_path --global --prepend /opt/homebrew/bin /opt/homebrew/sbin
