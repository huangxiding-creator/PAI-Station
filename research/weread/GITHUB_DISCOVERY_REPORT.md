# Phase 2 · GitHub 发现报告（C4 站在巨人肩膀上）

> 调研 13 个活跃开源项目 + 1 个本地官方技能，结论：**组合适配**而非克隆单一项目。

## 五条技术路线全景

| 路线 | 代表项目 (star) | 正文 | 风险 | 采纳 |
|------|----------------|------|------|------|
| (a) 官方 Skill API Key | weread2notion-pro (3.4k)、本地 Tencent-WeChatReading 技能 | ❌ 无正文接口 | 零（合规） | 元数据参考 |
| (b) web cookie + /web/* JSON | obsidian-weread-plugin (2.2k)、mcp-server-weread (575) | ❌ 笔记/元数据 | 低 | ✅ 登录+元数据层 |
| (c) Canvas Hook 渲染 | drunkdream/weread-exporter (2.1k)、lbq110/weread-exporter (310) | ✅ | 中（翻页节奏+自动化检测） | fallback 预留 |
| (d) web 签名直调 + 解混淆 | **ylw1997/touchFish (157)** wereadSign.ts/wereadDecrypt.ts | ✅ 整章 HTML | 中（高频直调危险，自律后最低） | ✅ **主路线** |
| (e) 安卓 chapterdownload | HuanMeng233/weread_downloader (284) | ✅ 原版整书 | **最高**（README 自认可能封号） | ❌ 坚决不用 |

## 巨人贡献清单（本项目直接继承的资产）

| 来源 | 复用资产 |
|------|---------|
| **touchFish** wereadSign.ts | calcHash / sign 签名算法完整 TS 实现 → 移植 Python（含 BKDR hash、appId 构造） |
| **touchFish** wereadDecrypt.ts | chk() md5 校验剥离 + dH/dS/dT 解混淆（交换表 + base64）→ 移植 Python |
| **lbq110/weread-exporter** | 双页 Canvas y 坐标拆分、`img.wr_readerImage` 插图定位（fallback 路线的设计参考） |
| **zhaohongxuan** cookie 续期方案 | HEAD 首页 → Set-Cookie 更新 wr_skey（30 天自动续期） |
| **obsidian-weread-plugin** | /web/* 端点清单与 cookie 认证形态实证 |
| **HuanMeng233** 登录协议 | getuid → QR → getinfo 长轮询 → wr_skey/wr_vid 落地（免浏览器复现登录全流程） |
| **E:\AIResearch\RE-Factory** | 方法论：listen 抓包→模式探测→PIPELINE_MAP 文档→纯 API 客户端→三层登录持久化→渐进式脚本序列 |
| **本地 Tencent-WeChatReading 技能** | 官方 Gateway api_name 清单（搜索 scope 枚举等，元数据层备用） |

## 为什么没有单一可克隆项目（评分 <80% 判定）

社区没有任何项目同时满足：DrissionPage（非 Playwright/Selenium）+ 签名直调 API + 专业 Word/MD 双格式 + 断点续采 + PAI-Station forge 渠道集成。
最接近的 lbq110/weread-exporter 用 Playwright+Canvas Hook（路线 c），速度慢一个量级且持续暴露自动化行为。
→ **判定：按 C4 组合多个巨人的已验证部件，自建集成层**（集成模式与 hundun 渠道同构，风险可控）。
