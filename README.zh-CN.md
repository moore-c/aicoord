<p align="center">
  <h1 align="center">AI Coord</h1>
  <p align="center">
    <strong>随时随地控制本地 AI Agent</strong>
  </p>
  <p align="center">
    在浏览器或手机上监控和操作 Claude Code、Codex CLI 等 AI 编程助手
  </p>
  <p align="center">
    <a href="https://aicoord.cn">官网</a> ·
    <a href="#快速开始">快速开始</a> ·
    <a href="README.md">English</a>
  </p>
</p>

<br/>

<p align="center">
  <img src="docs/assets/screenshot.png" alt="AI Coord 截图" width="800">
</p>

<br/>

## 为什么需要 AI Coord？

你在本地跑 Claude Code 或 Codex，但离开电脑怎么办？想用手机看进度？用 iPad 审阅代码改动？

**AI Coord 给你一个远程遥控器 —— 不需要 SSH，不需要 VPN，只需要浏览器。**

## 功能特点

- 🌐 **浏览器控制** — 任意设备、任意浏览器，直接操作本地 AI Agent
- 📱 **手机友好** — 实时查看 Agent 进度，出门也能盯进度
- 🔒 **隐私优先** — Hub 只是纯透传中继，你的代码和对话不会经过我们的服务器解析
- 🚀 **多框架支持** — Claude Code、Codex CLI、Hermes、OpenClaw 等均可接入
- 📁 **文件系统访问** — 浏览器里直接查看、编辑工作区文件
- 💬 **实时流式输出** — Agent 输出边生成边显示，带语法高亮
- 🖥️ **多机管理** — 一台账号连接多台机器，每台机器多个 Agent

## 架构

```
┌──────────────┐     WSS     ┌──────────────┐     WSS     ┌──────────────┐     WS     ┌────────────┐
│   浏览器     │────────────▶│  AI Coord    │────────────▶│   Sidecar    │───────────▶│   Agent    │
│  / Tauri App │             │    Hub       │             │   (本地)     │            │(Claude 等) │
└──────────────┘             └──────────────┘             └──────────────┘            └────────────┘
    任意设备                    云端中继                     你的机器                    你的机器
```

**Hub 是纯透传中继** —— 只负责把消息从浏览器转发到你的 Sidecar，不解析、不存储、不处理你的 Agent 对话和代码内容。

## 支持的框架

| 框架 | 类型 | 状态 |
|------|------|------|
| [Claude Code](https://docs.anthropic.com/en/docs/claude-code) | CLI Agent | ✅ 支持 |
| [Codex CLI](https://github.com/openai/codex) | CLI Agent | ✅ 支持 |
| [Hermes](https://github.com/NousResearch/hermes-agent) | AI Agent | ✅ 支持 |
| [OpenClaw](https://github.com/openclaw/openclaw) | Agent 框架 | ✅ 支持 |

## 快速开始

### 1. 注册账号

去 [aicoord.cn](https://aicoord.cn) 注册 — 免费。

### 2. 安装 Sidecar

Sidecar 是跑在你机器上的轻量代理，把本地 AI Agent 接入 AI Coord。

**macOS（推荐）：**

下载对应你的 Mac 的 DMG：

- [Apple Silicon (M1/M2/M3/M4)](https://aicoord.cn/downloads/AI_Coord_Sidecar_Latest_Apple_Silicon.dmg)
- [Intel Mac](https://aicoord.cn/downloads/AI_Coord_Sidecar_Latest_Intel.dmg)

**Linux / macOS（CLI 版）：**

```bash
curl -fsSL https://aicoord.cn/install.sh | sh
```

或手动下载：

| 平台 | 下载 |
|------|------|
| macOS Apple Silicon | [sidecar-darwin-arm64](https://aicoord.cn/downloads/sidecar-darwin-arm64) |
| macOS Intel | [sidecar-darwin-amd64](https://aicoord.cn/downloads/sidecar-darwin-amd64) |
| Linux AMD64 | [sidecar-linux-amd64](https://aicoord.cn/downloads/sidecar-linux-amd64) |
| Linux ARM64 | [sidecar-linux-arm64](https://aicoord.cn/downloads/sidecar-linux-arm64) |

### 3. 连接使用

1. 打开 Sidecar，用 AI Coord 账号登录
2. Sidecar 自动发现你机器上正在运行的 AI Agent
3. 浏览器打开 [aicoord.cn](https://aicoord.cn) — 你的 Agent 现在可以从任意浏览器访问了

就这样。没有配置文件，没有端口转发，没有 SSH 隧道。

## 工作原理

1. **Sidecar** 跑在你的机器上，发现本地 AI Agent（Claude Code、Codex 等）
2. Sidecar 通过 WebSocket 连接 **Hub**，JWT 认证
3. 你在任意浏览器打开 **aicoord.cn** 登录
4. 浏览器连接 Hub，Hub 转发消息到你的 Sidecar
5. Sidecar 把命令发给 Agent，流式返回响应

所有流量传输层加密。Hub 只看到加密帧，看不到你的代码。

## 常见问题

**需要开端口吗？**

不需要。Sidecar 是向外连接 Hub，没有入站端口，不用改防火墙。

**代码会传到你们服务器吗？**

不会。Hub 是纯透传中继。Agent 消息以加密 WebSocket 帧通过，我们不解析、不记录、不存储任何 Agent 内容。

**支持 Windows 吗？**

暂不支持。目前支持 macOS（Intel 和 Apple Silicon）和 Linux。

**可以用多台机器吗？**

可以。每台机器装 Sidecar，用同一账号登录，所有 Agent 在一个面板里管理。

**免费吗？**

目前内测期免费。

## 使用场景

- **手机盯进度** — 启动一个耗时 Claude Code 任务，出门用手机看进度
- **iPad 编程** — iPad 当瘦客户端，远程控制 Mac 上的 Claude Code
- **多机协同** — 笔记本、台式机、服务器上的 AI Agent 一个面板管理
- **团队协作** — 和同事共享 Agent session，AI 辅助结对编程

## 链接

- 🌐 [官网](https://aicoord.cn)
- 🐛 [反馈问题](https://github.com/moore-c/aicoord/issues/new?template=bug_report.md)
- 💡 [功能建议](https://github.com/moore-c/aicoord/issues/new?template=feature_request.md)

## 许可证

本仓库仅包含文档和分发文件。AI Coord 各组件的源代码为私有。详见 [LICENSE](LICENSE)。

---

<p align="center">
  为想要随时随地访问 AI Agent 的开发者而造 ❤️
</p>