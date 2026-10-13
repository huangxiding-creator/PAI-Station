# CONTEXT — zongbao-ai-v0917 术语表

| 术语 | 含义 |
|---|---|
| 总包AI顾问 | 本产品：微信小程序（appid wx5cee1574ce45819b）+ FastAPI 引擎（腾讯云托管 TCB 服务 qianwen-engine，MySQL） |
| 三线门禁 | pytest（引擎）+ BOOT-SIM（客户端结构锚）+ e2e（devtools 真链）三套全绿才算过 |
| 上传腿 | WeAppForge/work/upload_qianwen.mjs（miniprogram-ci，robot 1..30 轮转，Node25 须带 NODE_OPTIONS localStorage-shim） |
| 提审向导 | mp_cancel_logout/submit_review_09xx.py 六段（recon/open/step1/step2/fill/submit）；红线：不加急、只一次、fill 后人工核 dump |
| 住哨 | schtasks QianwenReviewWatch 每 2h 读 getcodepage 版本行，翻转企微；绝不自动发布 |
| qw-pop | 自研自绘弹窗系统（v0.9.7），规避原生 wx.showModal 真机按钮 ≤4 字静默死 |
| 软删 | deleted=1 标记：展示/可见性消失，pay_log/rewards 物理账不动 |
| 单页模式 | 朋友圈分享打开的场景值 1154 运行态：无登录态、平台固定顶栏/底操作栏 |
| owner 门 / 可见性门 | get_answer（本人）与 get_answer_visible（观看者）双轨鉴权（v0.9.14 锅圈腿先例） |
| RUN_LEDGER.md | WeAppForge/RUN_LEDGER.md——项目权威台账（#001-#214），一切在役铁律与坑的出处 |
| 推送纪律 | git push/百度备份须用户明示令；本地 commit 自由 |
| _ANSWER_UPGRADES | store.py 的 answers 表逐列 ALTER 平滑迁移机制（sqlite/mysql 双方言） |
