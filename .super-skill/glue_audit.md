# P6 胶水行数门 + 依赖许可证审计（REQ-024，2026-10-14 快照）

> 复跑命令：py -I revenue-engine/probes/check_glue_audit.py（tasks.json 生成时已实际执行并留痕，REQ-024.AC1）
> 计数规则：生产胶水文件的代码行（去空行/去 # 注释行）；tests/probes/docs/config 一律不计。

## 1. 胶水行数门快照（≤300 行硬门）

| 胶水件 | 预算 | 当前行数 | 状态 |
|---|---|---|---|
| lead_transformer.py（含去重/告警/归因回调追加） | ≤200 | 0 | 未建（T-050/T-056/T-057/T-066/T-069 逐层追加，全程卡 ≤200） |
| 8440 入口 service_8440.py（含 /enqueue+鉴权+202/429+防爆破） | ~50 | 48 | ✅ T-075 v2 done（裁判返工：enqueue返回值/202契约/字段透传/锁+单次告警/autostart钩子） |
| A 栈全局日20插件（langbot-plugins/） | ~50 | 0 | 未建（T-063） |
| audit_log.py（审计总线，reuse-first 落地） | 0 优先 | 43 | ✅ T-048 v2 done（裁判返工：坏行容错；契约命令-I亲测6/6绿） |

GLUE_TOTAL: 91/300 PASS

后续每个写码任务 done 时必须复跑 check_glue_audit.py；任何时刻超 300 → 全线停加码，
按 REQUIREMENTS 头注执行（REQ-017 降 SHOULD 并留 ADR 取舍）。

## 2. 依赖许可证审计清单（层级② 代码引入即 FAIL；docker 镜像一律锁 digest）

| 组件 | 许可证 | 层级 | 允许的使用方式 |
|---|---|---|---|
| LangBot | Apache-2.0 | ①可引代码 | docker（锁 release tag）+ 自研插件挂载 |
| WeChatPadPro | 无 LICENSE | ②禁引代码 | 仅 docker 镜像 digest 锁；代码零引入、零克隆（只提事实情报） |
| EspoCRM | AGPL-3.0 | ②禁引代码 | 仅官方 docker 镜像 digest 锁；不改源码、不嵌自有代码（避传染）；X-Api-Key/原生配置使用 |
| CowAgent | MIT | ①可引代码 | 官方 iLink 服务使用（豁免限频但强制入审计，ADR-004） |
| acg-faka | 待部署时核验（默认按②处理） | ②禁引代码 | docker/服务部署；部署任务须回填实际许可证到本表 |
| wechatpay-skills（官方） | MIT | ①可引代码 | V3 直连时使用（商户号门通过后） |
| zbops / wxrpa / rion-cli / proactive / auto_responder | 自有资产 | ③自有 | 仓库内自由改造 |
| meedu | 商用授权 | 出局 | 不使用（ADR-002 已记录出局原因） |

## 3. 层级定义与执行口径

- ①：MIT/Apache 等宽松许可——允许代码引入仓库。
- ②：AGPL/无 LICENSE——代码引入即 FAIL；只允许 docker 镜像（compose 中记录 digest）或官方托管服务方式使用。
- ③：自有资产。
- docker 镜像锁 digest：所有 compose 文件中镜像引用带 digest 或锁定 tag+digest 双写，禁止 floating latest。
