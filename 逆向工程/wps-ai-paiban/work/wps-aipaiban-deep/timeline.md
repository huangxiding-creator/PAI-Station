# Timeline (append-only)

## 2026-10-21T22:42:52.5237610+08:00 | lead | init
- action: case-init
- command_or_ref: skills/scripts/case-init.ps1
- result_summary: case directory created; scope ready_for_act=true
- artifacts: [scope.md, workitems.md]
- evidence_ids: []
- decision_delta: [case_initialized]
- carry_forward_refs: [scope.md]
- next: open PRIMARY SKILL.md and ACT within scope
## 2026-10-21 深挖役（REA + reverse-skill R32/R0 + PentAGI替代腿）
- [x] reverse-skill 路由：MASTER R32 thick-client（sidecar R3/R22）；case-init offline-sample auth=granted
- [x] 原生引擎定位：kwpsaitypeset.dll(4.58MB,x86,插件生命周期4导出) 内含全套 opString/原子操作串表；kcopilotentry.dll=宿主桥；wpsmain.dll=KFormat 引擎
- [x] 本地品类模板发现：mui/zh_CN/{custom,preset,public}templates 五品类+国标，加密+Base64 封装（魔数 225f8didjBaA/ACE4），解密例程在 DLL 内(Base64×5)
- [x] 安全面实测：wpscloudsvr 监听 0.0.0.0:46608(全网卡!)+127.0.0.1:4709，鉴权未验证；进程树含 lingxi(灵犀AI)+promecefpluginhost×2(CEF侧边栏)
- [x] 规则层收尾：verify-oplist-workflow.md（WPS 自家 oplist 参数验证环, TAG_TO_ROLE 与引擎 KFormatTags 对齐）
- [ ] PentAGI 全栈：本机无 Docker 未部署（替代腿已执行）；如需全栈须先装 Docker Desktop/WSL-docker

## 2026-10-21 三役终局（Ultracode Workflow 8 agent + PentAGI 上线）
- [x] WI-002 破城：AES-128-CBC key=5FE71BD15A854390/IV=96D8FDE5E10A6321（Ghidra FUN_10013020 反混淆），容器=12B魔数+base64+7B头+密文，12/12 模板解密为 docx，真身参数直读入复刻件（contract/bid 真身版预设上线）
- [x] WI-003 全解：分发器四层链伪代码存档（FUN_100d7220→100dded0→10191bb0→10192160，16 KFormatAtomic op 注册表+22-op 白名单门，无 wpsmain/COM）
- [x] WI-004 收口：双端口私有协议，无未授权 HTTP 面；keystream 复用弱点入账
- [x] PentAGI 2.2.0-ce 全栈上线 https://localhost:8443（WSL RE-Ubuntu docker，GLM+embedding-3 供能，DNS 三层根治）
- [x] 复刻件九轨道回归全绿（beauty 21/21 + 六预设 + from_sample 往返 + oplist_verify 三态）

## 2026-10-22 四役（全部完成令）
- [x] 密码学勘误：CBC 固定IV泄露=相等预言机（非 XOR 泄露），报告 §9.1 已修正
- [x] IV 取证：17 变体全灭，块1 前16B=KSOLITE 内部派生 IV（zip 雕刻无损）
- [ ] KSOLITE 全量 Ghidra：11.4MB 超 330s 超时上限（provider_timeout），需分片/更长时限 → WI-007
- [x] PentAGI API 驱动打通：admin/admin(bcrypt候选表破解)+改密+GraphQL createAssistant 正道（REST 建flow不注册Controller）；scraper/kali 工作镜像补拉中
- [x] WSL 空闲回收根因：Windows 侧 sleep infinity 保活会话已挂；运维手册增补 5 条 API 驱动要点
