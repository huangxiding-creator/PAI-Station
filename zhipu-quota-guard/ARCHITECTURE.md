# ARCHITECTURE — ZhipuQuotaGuard（Phase 5，C5：实际约束下最优解）

## 组件图（单机单进程，zqg 包）
```
Windows 计划任务(开机/崩溃自拉起)
  └─ python -m zqg.daemon            # 常驻循环
       ├─ providers/                 # ADR2: provider 抽象
       │    ├─ zai.py                #   quota/limit + card list (api.z.ai)
       │    └─ bigmodel.py           #   open.bigmodel.cn 镜像
       ├─ monitor.py                 # 轮询调度(自适应频率) + 契约漂移检测
       ├─ predictor.py               # ADR3: 确定性烧穿预测(JSONL遥测×系数)
       ├─ policy.py                  # 决策引擎(卡预算/FIFO/lead_time/mode)
       ├─ resetter.py                # ADR1: API优先+DrissionPage UIA兜底
       │    └─ browser/              #   独立profile 9341, cookie持久化, 用完即清
       ├─ notify.py                  # 企微(复用 station webhook 机制)
       ├─ ledger.py                  # run-ledger JSONL 唯一事实源(C10)
       └─ panel.py                   # 单文件HTML面板(读账本)
config.yaml + secrets/zhipu_secrets.json(gitignored)
ledger/  state/  panel/index.html
```

## 关键数据流
```
poll→QuotaSnapshot→[monitor] ─┬→ threshold/漂移检查
                             └→ [predictor]+BurnRate → [policy]
                                  ├ action=wait → 心跳
                                  ├ action=notify_only → 企微
                                  └ action=reset → [resetter] → 账本+企微
```

## ADR（决策记录）
- **ADR1 重置执行策略**：先抓包复刻 XHR（登录态 JWT/cookie 直调）；抓不到→DrissionPage UIA 点按常驻兜底。理由：API 稳定性≫浏览器；浏览器最小出场铁律。
- **ADR2 provider 抽象**：z.ai/bigmodel 同构不同域不同 Key，抽象后真身切换/多账号零改造。
- **ADR3 确定性策略核心**：全部决策由规则算出（可审计可回放），LLM 不进决策链（AI_NATIVE_OPTIONS B）。
- **ADR4 密钥布局**：secrets/zhipu_secrets.json + config 引用名；.gitignore 覆盖 secrets/ state/ ledger/ panel/（账本含敏感水位，不入公仓）。
- **ADR5 守护=计划任务**：原生 schtasks（ONSTART+失败重启）优于服务框架；对齐 station 零依赖偏好。
- **ADR6 调度以 nextResetTime 为准**：动态刷新窗禁用钟点假设（官方实证）。
- **ADR7 峰值系数可配置**：V3=0.5/1x 默认，V2 老套餐可切 1/3（W0 判别）。

## 失败模式
- API 401/超时 → 退避重试3次 → 账本+企微；监控降级浏览器读数
- 重置失败 → 记录+企微；同卡 24h 内不重试 >2 次
- 账本写失败 → 进程退出让计划任务拉起（fail loud 不静默）
