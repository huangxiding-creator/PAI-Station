# 提案：Manus 研报生成能力全链逆向复刻（三源合流·七层拆解·双产物·金标准验证）

> 立项：2026-10-20 用户令（免批准直接实施）
> 目标物：E:\AI-Station\逆向工程\manus桌面端（Electron v1.4.1.0 解包 + v1.6.0.0 Msixbundle）+ manus.im 网页端（Auto_Manus 267 账号军团）
> 交付：方法论全链手册 + 可复用 skill

## 一、用户原始想法（1x 版）

用 REA + DrissionPage 深读 manus 桌面端与网页端，提炼 Manus 生成复杂研究报告的全链条方法/框架/技巧，复刻为可复用 skill。

## 二、100x 升级点（本提案）

### 升级 1：三源合流证据链（替代单源阅读）

| 源 | 内容 | 已就绪度 |
|---|---|---|
| **S1 桌面端 asar 静态逆向** | app.asar 89MB——系统提示词/技能原文(deep-research,technical-writing)/Agent配置/API端点全图/事件schema | REA `analyze_javascript_application` 原生支持 ASAR |
| **S2 网页端 Live 实测** | DrissionPage 9333 口 + getSessionV2 九类事件流全字段抓取，实测下发 1 个复杂研报任务全程 | Auto_Manus 基建全在（登录/token捕获/四件套安全） |
| **S3 存量语料统计** | 135 任务/26372 工具调用/11552 写操作已挖出：四维搜索公式/77%写结构/五步法 | analysis/*.json 10MB 已在库 |

三源交叉验证——每条方法论断言标注实证出处（S1/S2/S3），零造假宪法（C14）贯穿。

### 升级 2：七层全链拆解（替代"方法技巧罗列"）

```
L1 指令接收与硬条款内化   —— 用户 prompt 的质量条款如何变成计划步骤
L2 计划树架构            —— planUpdate/tasks 三态结构与 TodoWrite 同构性
L3 工具调度经济学         —— 77%写/10%终端/6%浏览器/4.5%搜的实证配比与决策规则
L4 搜索词工程            —— 四维拼装(地域×行业×主题×时间窗) + 漏斗改写 + 权威源直捣
L5 增量写作引擎           —— 搜写节奏器(搜5→写1) + 多文件工作区(中位22文件) + 单文件增量编辑
L6 质量自检              —— 六项✅清单 + 对表初始要求逐项核 + 字数里程碑计数
L7 交付与续跑            —— 六配件成品 + fileOperationPromotion + contextTransfer 断点续航
```

### 升级 3：双产物（替代单文档）

1. **《MANUS_FULLCHAIN_PLAYBOOK.md》**——全链方法论终稿（带三源出处标注）
2. **`.claude/skills/manus-report-replica/`**——可执行 skill：
   - SKILL.md（触发条件 + 七层工作流）
   - references/（L1-L7 方法论手册分册 + 搜索词工程公式卡 + 自检清单卡）
   - scripts/（复刻编排器：可直接驱动的研报生成 runner）

### 升级 4：金标准验证（替代无验证）

用提取的方法论驱动一个真实小型研报任务（EPC 域内课题），对标 Manus 实测行为特征：计划树结构 / 搜写比 / 文件工作区形态 / 自检清单覆盖率 / 成品六配件。不达标回炉（C12）。

### 升级 5：账号安全铁律内建

Live 抓取复用 Auto_Manus 四件套（节流 30s / 连败冷却 / 封号熔断 / 日限额），只用 1-2 个账号、单账号单次下发，token 永不进仓（R 红线）。

## 三、实施相位（批准豁免·即刻开工）

| 相位 | 内容 | 工具 |
|---|---|---|
| P1 | asar 深读：系统提示词/技能原文/端点图提取 | REA analyze_javascript_application |
| P2 | 存量语料复挖：补挖 contextTransfer 16 例/失败搜索改写/outline 配比 | py-3 脚本 |
| P3 | Live 实测：军团账号下发复杂研报任务，全程事件流抓取 | DrissionPage + manus_lib |
| P4 | 三源合成：PLAYBOOK 全链手册 | 交叉验证 |
| P5 | skill 制作：manus-report-replica 落地 | skill 规范 |
| P6 | 金标准验证：小任务对标回炉 | 验证门 |

## 四、风险与对策

- asar 89MB 超 REA 单次预算 → 分批 source_paths / summary 模式优先
- 账号积分 300/日 → 单账号单任务，research 类实耗约 55-300 积分可控
- 桌面端可能只是网页壳（无独立提示词） → S1 若空转，重心落 S2+S3（已有 10MB 语料兜底）
- 长任务数小时 → DrissionPage 后台守护 + 轮询，不等阻塞

## 五、不做的事

- 不修改 Manus 客户端任何文件（只读取）
- 不碰 9222/9336/9337 口（Manus 专用 9333 沿用）
- 不删任何既有资产（只增不删铁律）
