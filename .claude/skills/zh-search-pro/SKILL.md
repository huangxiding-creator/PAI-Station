---
name: zh-search-pro
description: 中文搜索增强工具（zh-search-pro 本机化）：免API密钥多引擎中文检索——必应中国/百度/搜狗微信/知乎/头条/360 等URL模板+高级语法+时间过滤。当需要中文网页/微信文章/知乎内容的免费检索清单、或调研需要补充中文源时使用。
# EXTENDED METADATA (github-to-skills 规范, skill-manager 幂等更新用)
github_url: https://github.com/openclaw/skills
github_hash: mirror-synced-2026-10-02 (raw.githubusercontent 404, 以镜像同步时间锚定)
version: 1.0.0
created_at: 2026-10-04
entry_point: scripts/search.py
dependencies: ["curl_cffi>=0.6"]
source_mirror: https://ai.trusttools.cn/skills/openclaw/skills/zh-search-pro
source_path: skills/careytian-ai/zh-search-pro (author: careytian-ai, MIT-0)
---

# zh-search-pro — 中文搜索增强（本机化）

上游: OpenClaw skills 库 `careytian-ai/zh-search-pro`（3823★, 安装 42k+,
TrustTools 安全扫描 100/100 approved）。原版依赖 OpenClaw 的 `web_fetch` bin；
本机化为 `scripts/search.py`（curl_cffi impersonate=chrome 直取，
免疫 TLS 指纹 WAF——同 metaso-tls-fingerprint-waf 病理）。

## 能做什么

- **免 key 中文多引擎检索**: 一条命令同时打 必应中国/百度/搜狗微信/知乎/头条/360，
  出标题+URL 清单（markdown 或 JSON）
- **高级语法透传**: `site:` `intitle:` `inurl:` `filetype:` `""` `-排除` 直接进查询词
- **时间过滤**: 必应 `--bing-filter last7` / 百度 `--baidu-cl 7`（一天/一周/一月/一年）
- **零账号风险**: 全部引擎匿名访问, 不涉任何登录态（账号安全四件套天然满足）
- **高风险域名闸**: 自动读 `E:\AI-Station\EPC100\data\domain_blocklist.json`
  过滤命中结果（high-risk-site-avoidance 铁律）

## 用法

```bash
# 默认三引擎 (必应中国+百度+搜狗微信) — 检索清单
python .claude/skills/zh-search-pro/scripts/search.py "四川电力设计咨询 EPC"

# 指定引擎 + 条数 + JSON 输出 (程序化消费)
python .claude/skills/zh-search-pro/scripts/search.py "EPC总承包" \
  -e bing_cn,baidu,so360 --top 8 --json

# 全引擎 (含知乎/头条/需代理的 duckduckgo)
python .claude/skills/zh-search-pro/scripts/search.py "输变电 EPC" --all

# 高级语法 + 时间过滤 (必应近7天)
python .claude/skills/zh-search-pro/scripts/search.py \
  'site:mp.weixin.qq.com 中电建四川院' --bing-filter last7
```

## 引擎与边界

| 引擎 | key | URL 特性 | 实测战力 (1004 冒烟) |
|------|-----|---------|---------|
| 搜狗微信 | `sogou_weixin` | 自域跳转链(/link?url=) | ★概念词5/5全中(公众号文章面) |
| 360 | `so360` | data-mdurl 直链 | ★概念词5/5全中(官网/企查/行业媒) |
| 必应中国 | `bing_cn` | 直链 | 实体名可靠(官网/百科/爱企查); 概念长词易被降级到宽泛词面 |
| 百度WAP | `baidu` | 自域跳转链(/from=) | 桌面端必墙; WAP面时好时坏(轮盘), 如实报0 |
| 知乎 | `zhihu` | — | 登录墙, 多为空 |
| 头条 | `toutiao` | — | 结果JS注水, SSR面解析弱, 如实报0 |
| DuckDuckGo | `duckduckgo` | 直链 | **需代理** `--proxy 127.0.0.1:7890` |

国际线 Google HK / Startpage 上游亦有模板, 但本机需代理且不稳定, 未内置——
需要时按上游 SKILL.md 模板手工构造。

## 时间过滤参数速查

- 必应: `--bing-filter last24|last7|last30|lasty`
- 百度: `--baidu-cl 1|7|30|365` (天)

## 与既有渠道分工

- **WebSearch(内置)**: US-only, 中文源弱 → 本技能补中文面
- **metaso**: 积分制付费, 批量禁用 → 本技能免费可批量
- **SouGouWeDown**: 搜狗微信深采(PDF/合并) → 本技能只做快检索清单
- **opencli/cli_serp**: 桥接站重链 → 本技能零依赖直连引擎

## 注意事项（上游告诫+本机实锤）

- 反爬重试: 引擎偶发验证码页 → 脚本自动跳过该引擎并如实报 0, 不硬刚
- UA/TLS: curl_cffi impersonate=chrome 已盖 HeadlessChrome 病理
  (同 sogou-captcha-root-cause-ua / wxy WAF 同族根因)
- 每引擎间默认 1.2s 节流; 单次命令 ≤3 引擎为常态
- 结果仅是清单(标题+URL), 深读全文走 webReader / 渠道腿

## 许可证

MIT-0 (上游) — 本机化包装脚本同授权
