# 跨平台软件包


## 一、文档解析工具

### 1.MinerU

* 支持平台: Windows, Mac, Linux

* 官网: https://mineru.net

* 项目地址: https://github.com/opendatalab/mineru

## 二、🪜/代理客户端

### 1.Mihomo Party

* 支持平台: Windows, Mac, Linux

* 官网: https://mihomo.party/

* 项目地址: https://github.com/mihomo-party-org/mihomo-party

#### (1).覆盖配置示例
```yaml
# https://mihomo.party/docs/guide/override/yaml

# 直接覆盖整个规则
# rules:
#   - DOMAIN,baidu.com,DIRECT
# 将规则插入到原规则前面
# +rules:
  # - DOMAIN,baidu.com,DIRECT
# 在原规则后面追加规则
+rules:
  - 'DOMAIN,manned.org,🎯 全球直连'
  - 'DOMAIN,aur.archlinux.org,🎯 全球直连'
  # - 'DOMAIN-SUFFIX,beisen-inc.com,🎯 全球直连'
  # - 'DOMAIN,beisen2-idp.yufuid.com,🎯 全球直连'
  - 'DOMAIN-KEYWORD,beisen,🎯 全球直连'
  - 'DOMAIN-SUFFIX,aliyuncs.com,🎯 全球直连'
```

## 三、截图软件

### 1.pixpin
官网: https://pixpin.com/

### 2.Snow Shot
官网: https://snowshot.top/index.html
源码: https://github.com/mg-chao/snow-shot

## 四、AI 网关整流工具
### 1.cc-switch
官网: https://ccswitch.io/zh/
源码: https://github.com/farion1231/cc-switch

![ccswitch.preview](./cross-platform-software.assets/ccswitch.preview.png)

### 2.⭐ magpie

官网: https://usemagpie.ai/zh/
源码: https://github.com/yetone/magpie


![magpie-preview](https://github.com/yetone/magpie/raw/main/site/public/img/agents-light.png)

安装
* macos
```shell
brew tap yetone/magpie-releases https://github.com/yetone/magpie-releases
brew trust --tap yetone/magpie-releases
brew install --cask magpie-app
```

卸载
* macos
```shell
brew uninstall --cask magpie-app
brew untap yetone/magpie-releases
```

## 五、剪贴板管理
### 1.⭐快贴KwikPaste

官网: https://paste.fastthree.com/
源码: https://github.com/ManSanDADADA/KwikPaste

![KwikPaste预览](./cross-platform-software.assets/image-20261012144150356.png)

## 六、终端工具
### 1.⭐<a id="Ghostty">Ghostty</a>

官网: https://ghostty.org/
源码: https://github.com/ghostty-org/ghostty

#### 1) 安装和卸载

1. 安装
* macos: `brew install ghostty`

2. 卸载
* macos: `brew uninstall ghostty`


#### 2) 配置文件

- 主配置文件（仓库路径）：

  <a href="./config/config.ghostty">通用配置文件</a>

- 实际运行路径（系统读取位置）：

  `/Users/witt/Library/Application Support/com.mitchellh.ghostty/config.ghostty`

> 当前做法是用软链接把系统路径指向仓库主文件，后续只维护仓库里的这一份配置。

#### 3) 关键能力与已知限制

1. 支持 `Quick Terminal`（下拉终端）与 `global:` 全局快捷键。
2. `global:` 快捷键依赖 macOS「辅助功能」权限。
3. macOS 下 `Quick Terminal` 不支持 tabs（官方已明确）。

> ⭐ [Ghostty2](https://github.com/pihalf/ghostty2) 是 Ghostty 的 fork，支持 Quick Terminal tabs。

#### 4) 参考资料

1. Ghostty 功能总览：https://ghostty.org/docs/features
2. Ghostty 配置参考（全部配置项）：https://ghostty.org/docs/config/reference
3. `toggle_quick_terminal` 说明：https://ghostty.org/docs/config/keybind/reference#toggle_quick_terminal
4. Quick Terminal tabs 限制讨论（官方回应）：https://github.com/ghostty-org/ghostty/discussions/2888