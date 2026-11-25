# 机器规格

| 项目 | 值 |
|---|---|
| instabox 盒子 | `tongjing00105`（ID `m_agq3ss5ult2qsfhtzeifeahvom`） |
| 模板 | `agent-browser@2026-11-01.3-android.1-cli.1` |
| 系统 | Debian GNU/Linux 13 (trixie)，内核 `6.18.60-instabox` |
| 规格 | 4 vCPU / 8 GiB 内存 / 16 GiB 根盘 / 20 GiB 持久盘 `/data` |
| 用户 | `user`（免密 sudo，在 `docker` 组） |
| 桌面 | XFCE on Xvnc `:1`（127.0.0.1:5901），通过 dashboard 的 Computer 标签访问 |
| 家目录 | `/data/home`，工作目录 `/data/workspace` |
| 快照基线 | `claude-browser-ime` |
| 计划 | Free |

## 已预装（模板自带）

git、gh、curl、jq、Node.js 22（npm/pnpm/yarn/bun）、Python 3.13（uv）、Go、Rust、Java、Docker + docker compose、Chromium、Claude Code、Codex、OpenCode。

## 本仓库额外安装

fcitx5 + 拼音、中文字体（模板已有 `fonts-noto-cjk`）、zenity、expect。

## Free 计划的限制（影响自动化设计）

- 空闲 **30 分钟**自动暂停（进程保留，`exec`/`ssh`/端口访问会唤醒）
- 单次连续运行 **120 分钟**起，随使用增长到上限 **480 分钟**，到点强制暂停
- 强制暂停后有 **5–20 分钟冷却**期间无法唤醒（连续触发后为 60–75 / 120–135 分钟）
- 规格固定 4C/8G，不能改 CPU/内存；只能扩 `/data` 磁盘
- `port publish` 的 URL 仅在机器运行时可用

因此：**不要把这台机器当 7×24 常驻服务器**。定时任务请用「外部触发 + `instabox exec` 唤醒 → 跑完自行闲置暂停」的模式，或升级 Pro。

## 常用命令

```bash
instabox ls                                  # 机器列表和状态
instabox get tongjing00105                   # 详细状态（含冷却截止时间）
instabox exec tongjing00105 -- uname -a      # 执行命令
instabox snapshot save tongjing00105 --name N
instabox create --name new --snapshot claude-browser-ime
instabox ssh-config tongjing00105            # VS Code / Cursor 远程开发
```
