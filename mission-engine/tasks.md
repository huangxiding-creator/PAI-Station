# tasks.md — W1-W6 分解（EARS化+验收；串行纪律：一波全链毕才开下一波；一切入ledger）
## W1 引擎骨架（当前波）
- [x] W1.1 auto-loop v1.0 Windows移植：循环启动时系统应在Git Bash运行，支持MODEL/间隔/超时/断路器(5连错冷却300s)/429限额等待(LIMIT_WAIT 3600s)/consensus备份回滚/看门狗强杀(CYCLE_TIMEOUT 1800s)/PID单实例/stop文件优雅停/日志轮转(MAX_LOGS 200) — 验收：smoke一轮cycle log+ledger事件落账
- [x] W1.2 权限标定：.claude/settings.local.json 最小面放行(Bash/Read/Write/Edit/gh/py通知)，拒绝面含删除类命令 — 验收：首循环无人工介入完成
- [x] W1.3 企微接线：cycle成败/断路器触发/限额等待 事件→tools/notify_approval_wecom.py(失败不静默) — 验收：模拟事件实收
- [x] W1.4 守护注册：schtasks MissionEngineLoop(登录自启+5min复活检查)默认DISABLED，点火令才ENABLE — 验收：/Query可见+IGNITION.md可执行
- [x] W1.5 smoke：claude -p 一轮(读consensus→答OK→更新ledger) — 验收：ledger含smoke事件零报错
## W2 护盾接手（1023改棒：整体移交智谱额度监控会话在役，引擎侧挂起防串线；其收官后仅作器官接口对接）
- [x] W2.1 重置端点三路侦察(GET-only探history/status/opportunity族+zcode-proxy源码端点名+控制台抓包DrissionPage/REA) 禁盲POST(误触=烧卡) — 验收：端点契约入KNOWLEDGE_BASE或明确证伪 ✅1023收官：契约入reset-protocol.md(源码级+zcode.z.ai/status 401端点存在实弹+三监控域无镜像=重置链路单点+profile无登录态残留)；GET实弹JWT版待人工登录(open_login_window.py已备)
- [x] W2.2 护盾daemon按zhipu-quota-guard/ARCHITECTURE.md落地(zqg包)，作为引擎器官接入 ✅1023收官：器官层三件套(organs.json注册表/organ_probe只读探针/organ_start幂等拉起)+点火·守护·循环三路连带+429自动shield_snapshot入ledger；ignition 0x08退格字节bug修；假器官生命周期冒烟7步全绿；zqg在役healthy(pid18204,wait模拟,dry_run)
## W3 SignalBus信号插件总线
- [x] W3.1 Signal契约+bus内核(Signal{source_type,payload,evidence,jtbd_tags,ts,confidence}) ✅1023收官：signals/包=contract六件套校验(evidence非空=零造假铁律/dedup_key稳定)+bus内核(pull链discover→normalize→校验→去重→落账;账本ledger/signals.jsonl append-only单一事实源;拒收reject行留痕;单条/单源故障隔离)+adapters注册表(新源=新文件+注册一行,核心零改动);CLI --pull/--read退出码0/1/2;契约测试29断言全绿+幂等重跑(RID隔离)
- [x] W3.2a viaim耳机适配器(讯飞录音记录/摘要/说话人→Signal,定时拉新)(首交付,用户点名) ✅1023收官：adapters/viaim.py(48h窗record list --start-ts毫秒·v1.1.9实测字段/overview=讯飞AI概述原料/record_id稳定主键/说话人深挖=W4按record_id拉detail免N+1)+注册表一行接线；CLI零密钥(登录态在用户目录)；离线契约9断言全绿+--live实弹全绿：首批7条真实录音信号入主账本ledger/signals.jsonl(seq1-7)+重拉全dup幂等
- [x] W3.2b 微信群洞察适配器(rion-cli群消息+wechat-intelligence-hub JTBD信号+topic_signals_to_radar桥→Signal)(首交付,用户点名) ✅1023收官：adapters/wechat_insight.py(读wechat-24h-ops/data/topic-signals/*.jsonl·7d窗;jtbd完整结构+专家面板score→confidence映射;ts从signal_id解析非现造;坏行reject留痕);实测322行→75唯一信号,dedup天然收敛上游重复追加;--live实弹全绿(75条入主账本+重拉322全dup)+CLI双源一把拉rc=0;__init__懒加载消-m双重导入警告
- [x] W3.2 七源其余adapter(viaim/rion/朋友圈/需求台账/topic_radar/退款评分/反馈飞轮)各配契约测试 ✅1023收官: 五新源(moments/demand_ledger/topic_radar/revision_flywheel/refund_score)落adapter+注册+契约测试; 实弹672信号入主账本(总量守恒389/408/70/1逐源吻合), 主账本755信号6源; 退款评分引擎pending现空=0如实; 8测试文件×2连跑全绿
- [x] W3.3 新源接入模板(≤1h/源，第三源起ledger实测计时) ✅1023收官: _template.py+NEW_SOURCE_GUIDE.md(五步+三坑+计时基线); 五源实测18:06:27-18:11:44≈1min/源, 门≤1h远超达标
## W4 商机锻造厂
- [x] W4.1 IdeaDig五阶段管线接入bus→Proposal草案 ✅1023收官: forge/包(glm_json鸭子客户端多密钥直连+ideadig_bridge复用前作阶段纯函数); 实弹53信号→7候选→Top3草案落proposals/(榜首241.9分带seq49-59全指针溯源); 离线FakeLlm桩9文件套件全绿×2连跑; 草案标draft勿直接执行(SCORECARD门+审批闸=W4.3/4.4)
- [x] W4.2 Jev判断层接线(接E2召回1.00/E1意图p50实锤，不幻想接线) ✅1024收官: forge/jev_gate.py两新位(forge_demand Noul=taskcards同形族/forge_family Choice=intent同形族,措辞钉死)复用站内paistation.judgment.JudgmentClient(三令:开关/故障跳过/熔断+traj审计+laya影子P1渐进);sixpack过门自动附res['jev'] advisory(不过门,注入桩优先,离线=offline零外呼);CLI status/advisory;26断言组×2连跑绿+sixpack/bridge回归绿;实弹晨轮候选(草案5+spec): typesafe主引擎451区域墙+无代理在役→两腿fail-soft None(52.25s/7.62s重试后降级=设计行为),laya影子0.31s/0.35s真应答(family=deployed_tool与spec一致/demand0.21)首批agree数据入E:/AI-Station/data/traj/;advisory永不过门
- [x] W4.3 SCORECARD门+企微审批闸(批准才入执行队列) ✅1024收官: 门禁代码化forge/sixpack.py(门1三族白名单+KB禁区→门2四维加权SCORECARD→门3 DeltaIndex锚+判据+Σlog10≥2→六件套铸模→--push接approval_gate,离线桩禁推)+21断言×2连跑绿; 实弹真草案+真GLM三门全过(加权6.7/ΔΣ2.699与e75b手铸2.7交叉吻合); 企微审批闸半=W4.3b-b(1023已收官)
- [x] W4.3b-a 微信Claw桥绑定+守护(1023实时完成);- [x] W4.3b-b 审批事件流接线(用户1023令:本会话及后续一切互动经微信Claw,审批手机化): 搬wechat-claude-code源码(reference/)→launchd守护Windows移植(guard.cmd/Startup模式)→Node18依赖核验→个人微信扫码绑定→审批事件双向流(出站=审批请求带选项,入站=批准/否决/修改回令消费闸门)→企微推送保留为兜底链 — 验收: 手机微信回复「批准」能在60s内开闸并落ledger ✅1023收官: approval_gate.py四命令(request/consume/status/wait)+ledger/approvals.jsonl append-only(request/decision双行型)+出站=桥outbound-spool(daemon 30s刷达;实弹APPR-20261023-164134-c1bb送达手机实证)+企微兜底同步发+入站=座舱值守官跑consume(CLAUDE.md值守条款补复令铁则,回复原文→60s开闸落账)+run-ledger双事件(approval_requested/decided);离线19断言×3连绿(解析15例/幂等双决拒/未决/未知id/超时/决出4s);三坑修=tasklist GBK×utf8解码炸→字节比对/大写hex不匹配→canonical_id宽容/struct_time减法→mktime

- [ ] W4.4 主动雷达环(1023用户令): 定时拉双源信号→锻造→有价值即主动微信推送提案待批→批准入队执行→战报回微信 — - [x] 数量KPI废除(1024极致令): 验收改为「推送的每份必过极致双验;零推送=合格常态;宁缺毋滥」 【进度: 3日中第1日✅1023 seq83首战全链闭环(提案→批→S1-S5执行→战报企微)】
## W5 四轨变现
- [ ] W5.1 acg-faka发卡自动发货接线
- [ ] W5.2 EspoCRM线索REST入站
- [ ] W5.3 OPE传播+发布链复用(标题铁律「发布| 研究报告全名称」)
- [ ] W5.4 变现入账入run-ledger(数字零造假)
## W6 首战E2E
- [ ] W6.1 首战任务全链(信号→提案→批→执行→发布→收款)
- [ ] W6.2 P9 QA独立复核+复盘进化(失败变约束入CLAUDE.md)
