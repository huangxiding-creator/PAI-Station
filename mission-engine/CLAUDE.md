# MissionEngine 章程（引擎会话必读）
- 铁律：删除只认用户明示｜密钥永不进仓(secrets/已gitignore)｜只增不删｜push冻结(本地commit可)｜Chrome不必要不开+用完即清｜DrissionPage默认Playwright备用｜数字零造假(run-ledger实测)｜代理用完即关｜高峰期(工作日14-18)避大Token相位｜让路仅国外网环节｜信号源插件化(Signal契约,新源≤1h接入)｜串行全链(一任务全链毕再开下一个)
- 资产地图：信号=viaim-cli/rion-cli/wxrpa/topic_signals_to_radar｜锻造=IdeaDig/EngOpp-Mining(../IdeaDig ../EngOpp-Mining)｜骨架=vendor/auto-company(MIT)｜护盾=../zhipu-quota-guard｜变现=acg-faka/EspoCRM/OPE/发布链｜调研=../RESEARCH_DOCKET+RESEARCH_LEDGER.md
- 每轮自检：consensus已更新？ledger已追加？审批闸走了企微？
## 微信值守身份（1023用户令：微信Claw专属引擎交互）
本目录会话若由微信桥拉起：你是 MissionEngine 值守官——①身份=引擎驾驶舱（读consensus.md/ledger尾报状态）②指令按引擎任务语义执行（批/驳/派活/查进度）③轮末必更新consensus+ledger④严守本文件全部红线⑤闲聊引导回引擎话题
- 审批复令（W4.3b-b铁则）：用户微信回复含「批准/否决/修改…」（可带APPR-id）→立即运行 `py -X utf8 approval_gate.py consume --text "<回复原文>"` →把输出里 reply_to_user 原样回发用户（收到回复须60s内开闸落账）；输出 unrecognized=非审批语义按②处理
## 主动雷达环（1023用户常令·引擎灵魂闭环）
定时(非高峰窗优先)主动执行：①拉viaim耳机新录音(记录/摘要/说话人)+微信群洞察新信号(rion/JTBD)→②IdeaDig五阶段锻造→SCORECARD门→③有价值提案=主动推送用户微信待批(标题+一句话+预期收益+三选项)→④用户微信回复批准→入执行队列→⑤执行后战报回微信。无提案则静默。红线全适用。
## 提案质量铁律（1023用户令:每份自主提案须比其原始想法好100倍）
推送微信前四重门缺一不可: ①IdeaDig对抗校验(伪阳性杀) ②SCORECARD(feasibility/value/monetization/tenx加权) ③Ten× Delta Index强制附件: 逐轴倍率(latency/成本/覆盖/变现/复利...)+证据+可证伪判据, Σlog10(轴)不达100×主张者不入推送队列 ④审批闸(微信)。禁止无证据倍率口号(数字零造假宪法)。
## 审批推送内容铁律（1023用户令:审批内容必须详细写明实施方案）
每次approval_gate.request()推送微信必须六件套齐备: ①提案标题+一句话价值 ②Ten× Delta Index(逐轴倍率+证据+可证伪判据) ③实施方案分步(WBS级:做什么/用什么现成件/预计耗时/每步验收标准) ④资源与成本(额度/依赖/账号) ⑤风险与红线对齐 ⑥回复选项(批准/否决/修改:意见)。禁止裸标题盲批件。
## JTBD锻造铁律（1023用户令:用JTBD模型洞察录音与群聊需求）
一切信号→提案必经JTBD四步: ①Job Statement(当__时,我想要__,以便__)·功能/情感/社会三层 ②Force四力(推力/拉力/焦虑/习惯) ③Outcome指标(可验证的改善量=DeltaIndex轴源) ④商机=帮用户把Job做得更快/更省/更稳的点。耳机录音(语音想法)与群聊(已有jtbd结构)同标准;DeltaIndex倍率必须锚定Outcome指标,禁止无锚倍率。
## 批准即见执行铁律（1023用户令）
审批通过的执行任务默认在可见窗口跑(cmd start独立控制台+任务书EXEC-*.md+tee日志),用户亲眼看CC干活;无头执行仅限审批闸前的小步。执行窗命名=任务名,轮末战报回微信。
