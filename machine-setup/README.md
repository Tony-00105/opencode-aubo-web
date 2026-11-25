# machine-setup

这台 instabox 云虚拟机（`tongjing00105`）的可复现配置。

用途：换机器、重建盒子、或把这套桌面环境搬到另一台 sandbox 时，一条命令装回同样的状态。

## 目录

```
machine-setup/
├── setup-all.sh                    一次性执行全部步骤
├── scripts/
│   ├── 10-packages.sh              安装系统包（输入法、中文字体、测试工具）
│   ├── 20-fcitx5-chinese.sh        fcitx5 中文输入法配置（env / 自启 / 拼音）
│   └── 90-restart-desktop.sh       重启 XFCE 桌面会话使环境变量生效
├── config/
│   ├── 90-fcitx5.sh                -> /etc/profile.d/90-fcitx5.sh
│   ├── xprofile                    -> ~/.xprofile
│   ├── environment.d/90-fcitx5.conf -> ~/.config/environment.d/
│   ├── autostart/fcitx5.desktop    -> ~/.config/autostart/
│   └── fcitx5/{profile,config}     -> ~/.config/fcitx5/
└── docs/machine-spec.md            机器规格与限制
```

## 使用

在目标 sandbox 里（已经是 `user` 用户，HISTORY：不要用 root 跑）：

```bash
cd ~/machine-setup
./setup-all.sh
```

只想装输入法：

```bash
./scripts/10-packages.sh
./scripts/20-fcitx5-chinese.sh
./scripts/90-restart-desktop.sh     # 会关闭当前桌面会话（浏览器等会退出）
```

## 输入法说明

- 框架：fcitx5 + 拼音（fcitx5-chinese-addons）
- 中英切换：`Ctrl + Space`；全角半角：`Shift + Space`
- 默认状态为中文（`ActiveByDefault=True`）
- 输入法通过 GTK3/4、Qt5/6 输入模块接入，Chromium 用 GTK3 模块

## 不含什么

这个仓库**只放配置和脚本**，刻意不包含：

- GitHub / Anthropic / Claude 等任何凭证、token、cookie
- 浏览器 profile（`~/.config/chromium`，里面有登录态）
- 业务数据（`~/Downloads`、`~/.ssh` 私钥）

需要凭证时用 instabox Secrets 注入，或在使用机器上单独登录。
