# GOAL_LEDGER — 旗舰付费研报总目标（跨会话接续，直到实现为止）

> 用户令 2026-10-07（四连）：①总目标=生产用户愿意付费 **¥10,000** 购买的
> 工程总承包研究报告；②**50 万字级**总量；③发布时公开**详细内容简介+
> 目录大纲**转化面（简介要非常详细、体现价值）；④全链条（生产→排版→
> 宣传文章→**总包之声公众号**→扫码下单）自主负责；⑤宣传文章要
> **阅读/点赞/转发增长飞轮**（看得越多→潜客越多→下单概率越大，闭环迭代）；
> ⑥**成功判据=用户真正扫码下单购买**（看了不买=没成功）；⑦自主决策/
> 自主收集/自主调研，**直到实现这个目标为止**。

## 状态（最近更新 2026-10-07）

| 里程碑 | 态 | 凭证 |
|--------|----|------|
| 质量底座：断言链 W1-W5 | ✅ | 五波全收官（提案行全 ✅，单测 33 项，EPC50 真池双跑） |
| F0 生产法提案+转化面生成器 | ✅ | PROPOSAL.md + superline/sales_kit.py（7/7 单测+EPC50 回放 15/15 章覆盖，徽章零手拍） |
| F1 蓝皮书战役点火（共性库盘点+五卷 charter/框架+词表） | ⬜ 下一步 | 断言链 s0/charter/framework 门 |
| F2 存量精编（EPC1-50→卷二+缺口清单） | ⬜ | 章级三态+gap |
| F3 增量调研（缺口补采；届时按战役范围解封收集域并留痕） | ⬜ | 弹药门 v3+完备门 |
| F4 五卷撰写+七门+排版 PDF（50 万字门） | ⬜ | G1 字数≥500,000 |
| F5 宣传矩阵+增长飞轮+交易闭环 | ⬜ | 公众号草稿箱+商城码池+≥1 真实订单 |

## 接续入口（任何会话从这里继续）
1. 读本文件 + `_proposals/flagship-paid-report-1007/PROPOSAL.md`；
2. 下一步动作 = F1：盘点 EPC1-50 存量语料（ammo_pool 各池 doc_weight/
   grade sidecar 汇总）→ 五卷战役 charter（断言链 S0 门）→ framework；
3. 生产运行遵守：账号安全四件套/WeAIPO 免打扰/免费模型优先/只增不删/
   推送+百度备份常驻自主；
4. 每完成一波：本表回填 + commit + 自主推送 + 百度备份。

## 资产索引
- 方法论：`_proposals/claim-chain-engine-1006/PROPOSAL.md`（七门全 ✅）
- 引擎件：`reforge_factory/superline/{question_bridge,task_ledger,redteam_gate,charts_gate,sales_kit}.py`
- 审计件：`reforge_factory/{doc_weight_audit,grade_rules,independence_audit}.py`
- 交易承接：总包学园商城（8871 生产+码池；虚拟支付 offer_id 既有悬决）
- 宣传链：md2wechat（草稿箱）+研报成稿宣传链（md2docx+PDF）
