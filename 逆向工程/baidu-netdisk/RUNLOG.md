# RUNLOG · BDPAN-FACTORY（C10 run-ledger）

| ts | 事件 | 数字 |
|---|---|---|
| 10-29 18:15 | 战役开题；客户端定位 8.2.5 CEF（%APPDATA%\baidu\BaiduNetdisk，运行中） | 进程 16+ |
| 10-29 18:2x | Idea Factory：IDEA_SEED 落盘；三研（GitHub/官方API/客户端先例）spawn | 3 agents |
| 10-29 18:3x | bdpan 3.8.7 发现已装；Windows 侧 config 存在 | whoami=pyeyeye |
| 10-29 18:4x | PentAGI 复活（WSL RE-Ubuntu，pentagi+pgvector Up） | 8443=200 |
| 10-29 18:45 | 四路逆向并行 spawn（抓包/静态/防护IPC/蓝本） | 4 agents |
| 10-29 19:0x-19:4x | 四路陆续收官：1152 flows/87端点/零pinning/无签名头/BDUSS+STOKEN 入 vault；VMProtect 仅主EXE；蓝本行号映射；bdpan-storage 克隆（7892 代理） | ~40 万 token |
| 10-29 19:5x | PROPOSAL v1 落盘；对抗验证工作流 5 员（V1 凭据活性=GO：loginStatus+根目录17项 errno=0；V2 CArchive 裁决；V3 xpan 放行+漂移账；V4 七项过度声明；J1 GO-WITH-AMENDMENTS×10） | 32.8 万 token |
| 10-29 20:0x | whoami 复测落盘（Token 23天12小时）；PROPOSAL v2 定稿；企微通知；**用户全案批准** | - |
| 10-29 20:1x | W0 收官：凭据迁移 data/secrets/bdn_credentials.json（gitignored 验证过），vault 覆写为指针 | BDUSS 192/STOKEN 64 |
| 10-29 20:1x | W1+W3 智能体并行 spawn | 2 agents |
| 10-29 21:0x | W1 收官：PROTOCOL.md 111 端点（A50/B31/C10/D20）+ 活性普查 9 发全绿（quota/search/分享两代双活/recycle/filediff 活；xpan metas 404→multimedia 纠偏）；读面 rand 非强制 8+ 端点实证 | - |
| 10-29 21:2x | W3 收官：8 只读命令活体全绿（ls/=17 对基线）+34/34 离线；30 发预算内 | - |
| 10-29 21:3x | **ss-judge DISCARD**：HOLDOUT 实锤熔断码表 31319 笔误（31329 不触发熔断=风控保护静默失效）+单测钉死错值 → 主会话返工：errors/test/session/README 六处修正+新增「四码逐一两连击」测试 → 35/35 绿 | KEEP |
| 10-29 21:4x | W4 spawn（写命令+传输引擎+200MB 断点续传/秒传/多线程下载实测）；PentAGI 审计调度器发车（GLM 对抗审计 PROTOCOL.md，DB 轮询收果） | 2 后台 |
| 10-29 22:1x | **PentAGI 腿封存**：flow18(40KB长文)/flow19(短探针) 均卡死于「assistant provider prepared」后静默，msglogs 零增量；容器重启复探仍死=基础设施级（GLM 调用链/容器网络待 dev 级排查）。非阻塞：独立审计职能由 ss-judge 逐波质检承担；审计需求回退 Claude 对抗验证 | flow18/19 遗留 |
| 10-29 22:3x | W4 收官：a-h 20/22（200MB kill 续传=40%重传实证/下载 md5 一致/rm 双确认+回收站命中）；协议新发现=写面唯一可靠 /api 家族（xpan 写 9019 墙） | 37/80 控制面 |
| 10-29 22:5x | **ss-judge 二审 DISCARD（文档轴）**：独立重放证伪「superfile2 需 CEF UA」——真门=参数完整度（path 双放+vip+web+app_id），native UA 全参 200；工人矩阵变量未隔离误归因 → 返工：PROTOCOL/README/api/transfer/_diag 九处改写+ERRATA_1029.md+探针归档+2.02→2.21 速度勘正 → 70/70 单测复绿，根目录零残留 | judge 7 发 |
| 10-29 23:0x | W5 技能腿 ✅（.claude/skills/bdn/ 5 件，分区路由，官方 skill 零改动）；**用户令：W4.5 复审通过，W5-W6 放行** → W5 核心 Workflow 发车（doctor/router/mirror/share-transfer 条件门 + judge） | - |
