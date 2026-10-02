---
name: weapp-launch-factory
description: 从初步想法到微信小程序上线的全链自主工厂。用户给一个想法，本 skill 驱动调研→提案→开发→测试→部署→提审→发布全流程。触发词：做一个小程序/小程序上线/从想法到上线/提审/发布小程序/微信小程序全流程。含实战案例（总包AI顾问 5 天 0.1.0→0.7.6 提审）全套血泪配方。
version: 1.0.0
---

# WeApp Launch Factory — 从想法到小程序上线

用户只出**一个初步想法**，其余全链（调研→提案→开发→测试→部署→提审→发布）
由本 skill 驱动自主完成。核心资产=一次完整实战（zongbao-ai 总包AI顾问，
0928-1002 五天，0.1.0→0.7.6 提审成功）沉淀的全套可复用配方。

## 0. 与相邻 skill 的分工（先读，别重复造轮子）

| Skill | 职责边界 |
|---|---|
| **super-skill**（V5+） | 通用产品工厂引擎：`ss init --from IF1` 起、IF1-P12 阶段门、ralph 无人值守。**想法受理/调研/提案/需求走它的引擎** |
| **weapp-forge** | 小程序**工具链操作层**：forge.mjs（list/lint/upload/preview）、projects.json 项目注册表、appid-密钥纪律、WXML 闸门、devtools MCP。**建项目/传包走它** |
| **本 skill** | 微信小程序**域叠加层**：合规门、控制台自动化、钉位出码、部署域名链、提审向导、发布切换——super-skill 管不到、weapp-forge 没装下的实战血泪层 |

组合用法：`ss init`（super-skill）→ 各阶段到小程序域时按本文件 §2 路由表查本域配方 →
建项目/上传用 weapp-forge 命令 → 域门用本 skill references。

## 1. 全生命周期十阶段总览

```
想法 → 调研 → 提案(用户批准) → 架构 → 开发 → 测试门 → 部署上云
     → 体验版联调(用户扫码终审) → 提审合规 → 发布与切换
       └────────── 微信域特有三阶段（super-skill 没有的）──────────┘
```

时间预期（案例实测）：MVP 一天出包，五天到提审。每次换版交付**必须**带
永不404码+自测指令（见 trial-pinning 参考 §3b）。

## 2. 阶段路由表（干活时按行查）

| # | 阶段 | 关键动作 | 域门（不过不许进下一阶段） | 参考 |
|---|---|---|---|---|
| 1 | 想法受理 | super-skill IF1；**微信域先问四件**：主体资质（个人/企业）、目标类目、是否涉支付、是否含 AI 生成内容（含=标识门提前埋） | IDEA_SEED 含四件答案 | 案例研究 §1 |
| 2 | 调研 | super-skill IF2 多腿调研+GAP；**市场空白实证**（竞品小程序逐个查） | GAP_REPORT | 案例研究 §1 |
| 3 | 提案 | super-skill IF3；**免费成本架构**表（哪些链免费/哪些烧钱/日预算） | SCORECARD proceed + 用户批准 | 案例研究 §2-3 |
| 4 | 架构 | 引擎（服务端 FastAPI+SQLite）与前端（原生小程序）分离；secrets 落位纪律；域名规划（备案是长周期项，**第一天就启动**） | 架构文档含 secrets/域名/成本三节 | deploy 参考 §2-3 |
| 5 | 开发 | weapp-forge 建项目；每版=用户令→实现→BOOT-SIM 断言同步追加 | BOOT-SIM 全绿才许上传 | e2e 参考 §1-2 |
| 6 | 测试门 | BOOT-SIM（结构化版本门）+ pytest（服务端）+ 三线终验 | 三线全绿 | e2e 参考 §4 |
| 7 | 部署上云 | ECS systemd 常驻+双层墙；域名备案→证书→nginx→合法域名；BASE_URL 切轨 | 公网 health 200 + https 探针 | deploy 参考 §1-3 |
| 8 | 体验版联调 | robot 轮转上传+永不404码+换版三件套；用户扫码终审 | 用户真机走通一单（雷达有新流量） | pinning 参考（全文） |
| 9 | 提审合规 | 合规门全过（AI标识/诱导分享/极限词/隐私/UGC）+ 表单六项核对 + 控制台向导 | 双 agent 对抗审查收敛 + 三线终验复核 | compliance + console 参考 |
| 10 | 发布切换 | 发布→POSTER_QR_ENV_VERSION 切 release→海报冒烟→台账收口 | 新海报码扫进线上版 | deploy 参考 §7 + pinning §5 |

## 3. 三大域特有防线（血泪换来的，违反必翻车）

1. **「页面不存在」三层根治**——home/home 跳板页（包级）+ check_path=false 显式
   page 码（码级）+ robot 轮转+换版三件套（流程级）。
   → [trial-pinning-and-qr-recipes.md](references/trial-pinning-and-qr-recipes.md)
2. **提审合规门**——AI 生成内容显著标识（12 位=10 前端+2 海报，逐位审计表在门 1）、
   诱导分享、极限词、隐私运行时实证、UGC 双闸。0.7.4 就是死在标识门。
   → [mp-compliance-gates.md](references/mp-compliance-gates.md)
3. **控制台自动化**——Vue 动态页+翻译扩展坑全套配方（真按钮/checkbox/textarea/
   三步向导/选体验版安全定位）。
   → [mp-console-automation.md](references/mp-console-automation.md)

## 4. Reference 文件索引

| 文件 | 内容 | 何时读 |
|---|---|---|
| [case-study-zongbao-ai.md](references/case-study-zongbao-ai.md) | 完整实战案例：九段生命周期+版本全表+坑索引 | 开工前通读一遍（复用的最大杠杆）；遇挫时查对应段 |
| [mp-compliance-gates.md](references/mp-compliance-gates.md) | 提审合规门全集（判据+实测方法+断言范式） | 阶段 9 前；含 AI 内容的项目在阶段 1 就要读 §1 |
| [mp-console-automation.md](references/mp-console-automation.md) | mp 控制台 Vue 页自动化配方 | 要操作控制台时（提审/选体验版/查状态） |
| [trial-pinning-and-qr-recipes.md](references/trial-pinning-and-qr-recipes.md) | 钉位/出码/页面不存在根治链/发布切换 | 阶段 8、10；用户报「页面不存在」时按 §6 决策树 |
| [deploy-and-upload-recipes.md](references/deploy-and-upload-recipes.md) | ECS/域名/备案/上传器/出码器/secrets 纪律 | 阶段 7；域名相关决策时 |
| [e2e-harness-recipes.md](references/e2e-harness-recipes.md) | BOOT-SIM 模式+三线终验+automator 配方 | 阶段 5-6、9；搭测试门时 |

## 5. 新想法进来时的启动序列（照此走）

```
1. Skill(super-skill) → ss init --project <name> --from IF1
2. 想法澄清时把 §2 阶段1 的微信域四件问题补进 IDEA_SEED
3. IF2 调研时加「微信小程序竞品逐个查」一腿
4. 提案时附免费成本架构表 + 域名/备案时间线（第一天启动备案！）
5. 批准后：weapp-forge 建项目 + 本 skill 阶段 4-10 逐门走
6. 每完成一阶段：RUN_LEDGER.md 追加一行（时间/动作/实测结果/下一步）
```

## 6. 通用金律（案例提炼，全程有效）

1. **需求即测试**——用户的每条指令当场写成 BOOT-SIM check()，版本门只认断言不认感觉。
2. **appid 与密钥文件名逐字符 diff**——一字符之差的表象像「账号被注销」。
3. **目录名骗人**——同名辈项目并存必出事；孤儿目录改 `_orphan_*_勿发布`。
4. **换版交付必带三件套**——永不404码+「钉完立刻自测」指令+雷达基线。
5. **可证成口径**——一切宣传语须能举证；「顶级/最全/7×24」= 驳回风险。
6. **备案是长周期项**——域名备案第一天就启动，代码可以先跑 IP+开发调试豁免。
7. **secrets 只住 data/secrets/ 与 ECS /opt/**——不进 git、不全显、不落临时文件。
8. **上传回包要验铁证**——字节数/robot 号/pluginInfo，exit 0 ≠ 成功。
9. **手机是终审**——桌面验不了的就交给用户扫码，雷达表是裁判。
10. **台账即记忆**——RUN_LEDGER 每行=时间/动作/实测/下一步，事故复盘全靠它。

## 7. 版本发布日一键清单

- [ ] 控制台点「发布」
- [ ] POSTER_QR_ENV_VERSION trial→release（服务端 config+重启+云端部署位同步）
- [ ] 新海报生成→扫码验证进**线上版**
- [ ] BOOT-SIM 版本标记更新→全量门跑绿
- [ ] RUN_LEDGER 收口行 + git 定向提交
- [ ] （若用户令推送）github-push skill 场景 A/B + 百度备份

## Version

1.0.0 - 2026-10-02 - 初版：zongbao-ai 全弧线（0928-1002，0.1.0→0.7.6 提审成功）蒸馏。
