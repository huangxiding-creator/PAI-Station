# 附录 C INI 配置字段参考手册（逐字段）

> 约定：所有配置集中 `config/` 目录，INI 格式（用户硬性要求）；每个字段标注 类型/默认值/取值域/说明；启动全量校验，非法值中文报错并拒绝启动（不带病运行）。

## C.1 pai.ini 主配置（27 字段）

### [llm] 推理链（6 字段；V3.0 勘误：默认值依附录 E E.1 勘误后现行免费族谱更新）
| 字段 | 类型 | 默认 | 取值域 | 说明 |
|---|---|---|---|---|
| api_key | str | 空 | 32 位智谱 key | 可被环境变量 PAI_LLM_KEY 覆盖（优先级：env > ini）；落盘自动 DPAPI 加密（16.6.3），配置文件中仅存 SecretRef |
| fast_model | str | glm-4-flash-250414 | 任意模型名（端点商店） | 系统 1 高速通道 |
| deep_model | str | glm-4.7-flash | 同上 | 系统 2：thinking 开关路由（附录 E E.1） |
| vision_model | str | glm-4.6v-flash | 同上 | 视觉主力（128K 视觉推理） |
| long_model | str | glm-4.7-flash | ≥200K 上下文 | 长文档 |
| upgrade_confidence | float | 0.7 | 0.5-0.9 | 系统 1→2 升级阈值；越低越保守 |

### [sense] 感知（7 字段）
| 字段 | 类型 | 默认 | 说明 |
|---|---|---|---|
| watch_dirs | list | ~/Documents,~/Desktop,~/Downloads | 白名单目录，逗号分隔，支持 ~ 展开 |
| ignore_patterns | list | *.tmp,~$*,.git,node_modules | 忽略模式 |
| screen_interval_sec | int | 600 | 截图节拍 60-3600 |
| screen_blacklist | list | 密码管理器,银行,支付,登录 | 窗口标题关键词，命中整窗丢弃 |
| fg_poll_sec | int | 300 | 前台窗口轮询 60-900 |
| deepwork_apps | list | WINWORD.EXE,idea64.exe,Code.exe,wps.exe | 深工作判定 → Fogg P=0 |
| clipboard_enabled | bool | false | 默认关（最敏感源） |

### [channels] 通道（5 字段 + 各通道子文件）
feishu_enabled / dingtalk_enabled / wecom_enabled（bool，默认 0/0/1）；wechat_mode（枚举，仅 vision_readonly——代码层硬编码，INI 改其他值直接报错）；notify_webhook（企微 webhook URL，正则校验格式）。

### [proactive] 主动（4 字段）
max_push_per_day（int 1-5，默认 2）；drawer_retention_days（int 3-30，默认 7）；quiet_hours（"22:00-07:00" 格式校验）；explore_rate（float 0-0.3，默认 0.1——Ericsson 边缘练习率）。

### [privacy] 隐私（3 字段）
data_dir（%LOCALAPPDATA%\PAI-Station）；export_on_exit（bool 默认 0）；never_send（list：原始截图,凭据类文件,身份证,银行卡——上云黑名单类型）。

### [learn] 学习（3 字段）
pdca_time（"02:00"）；distill_min_samples（int 3-10，默认 5）；double_loop_confirm（bool 默认 1——双环改动必须用户确认，安全默认不可低于 1）。

## C.2 feishu.ini / dingtalk.ini / wecom.ini（通道凭据）
app_id/app_secret 或 client_id/client_secret 或 corpid/secret/agentid + verify 阶段（启动时调用 get-tenant-access-token 验证，失败中文报错并禁用该通道不阻塞其他）。

## C.3 wechat.ini（视觉通道专用）
capture_interval_sec（默认 900）；target_windows（"微信" 标题匹配）；confirm_ack（首启确认标志，代码写入）；risk_acknowledged（用户已读风险声明标志）。

## C.4 配置校验器行为规范
1. 缺失必填 → "缺少配置 [sense].watch_dirs，请参考附录 C.1 填写"；
2. 类型错误 → "值 'abc' 不是合法整数（[proactive].max_push_per_day）"；
3. 越界 → "0.3 超出 [llm].upgrade_confidence 允许范围 0.5-0.9"；
4. 路径不存在 → 列出原始值与展开值；
5. 危险组合 → wechat_mode 非 vision_readonly 时直接拒绝（防篡改）。
校验器 200 行内实现（纯标准库），单测覆盖全部错误分支。

## C.5 V3.0 十维灵活性新增配置面（第 17 章；附录 C 全集目标 ≥300 字段）
[models.*]（端点商店：多端点+降级链用户可编辑+monthly_token_budget）；[domain.*]（每任务域 model/channel/autonomy 三键覆盖全局）；[autonomy]（max_level 全局总闸+审批模式+approved_recipients 外发白名单）；[memory]（分层 TTL+profile_domains 画像参与范围+隐身会话开关）；[storage]/[backup.*]（data_dir 任意位置+多目标轮转）；[ui]（四形态）；[proactive] 增 intensity 0-5 滑块；[extensions]（MCP/插件/本机 REST API 端口与 token）。全部热加载：文件监视+原子替换，失败自动回滚上一好配置（17.12）。

## C.6 V3.1 技能铸造厂配置面（第 19 章；info_sources.ini，每源 6 字段——"配置要简洁，没必要的不搞"）
type（web_course|feishu_wiki|ebook_dir|intranet）；url/path（资料在哪）；auth=secretref:名称（凭据只存 DPAPI 保险箱引用，附录 C 明文禁区）；schedule（cron 增量调度：混沌 weekly MON 08:00、飞书知识库可 daily 07:30）；formats（docx,md,pdf 产物渲染）；enabled（一键启停）。选择器与翻页规则存同文件 selectors 段——源站改版只改配置不改代码（R17）。配套 [foundry] 段：default_recipe（默认铸造配方，开箱即用）、cross_casting（交叉铸造开关，19.7）、notes_publish（学习笔记→公众号运营飞轮开关，19.9）、upload_targets（组织库回流目标，如工程行业大脑）。支持 IM 对话式增改源（"帮我把这个知识库加进采集"），热加载机制同 C.5。
