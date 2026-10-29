# KB-HARVEST 引擎 RELEASE（v1.0 · Wave11 收官 · 2026-10-23 · T43/FR11.1 四章）

> 引擎包：`kb_factory/harvest_engine/`（KB-FACTORY 第二代收割引擎，43 任务/11 波，2026-10-22 提案
> 全量批准 → 2026-10-23 收官）。四章=①发布说明②安全门报告③E2E 报告④合规声明（FR11.1）。
> **发布门命令**（NFR3/NFR6/P0/pytest 四门机检，退出码 0=放行）：
>
> ```
> py -3 kb_factory/harvest_engine/tools/release_gate.py
> ```
>
> 本版实测：`G1 NFR3 PASS（未豁免命中 0，豁免 2 值 sha256 表注记）· G2 NFR6 PASS（运行面零
> GPL/AGPL import）· G3 PentAGI P0 PASS（4 份研判 P0 全清，合计 0）· G4 pytest 全套
> 489 passed, 38 skipped, 1 warning in 604.49s`，`release_gate: PASS——4/4 门过` 退出码 0
> （2026-10-23 实跑）。

## ① 发布说明

### 产品面（交付了什么）

- **适配器 6 站 + 注册表准入 3 站**：`wenku`（三型页面重建）/`book118`（预览链+像素拼
  PDF+OCR 文字层）/`doc88`（方案B 机制重写：配置解密→ebt 资产→SWF 切片→FFDec 子进程
  提取）过 W8 准入在注册表在役；`docin` 复活实证（FR6）；`csdn`（PDF 分支在役，
  download 分支挂 VIP cookie 账）；`legacy`（woc88 http-only 强制）。L3 渲染兜底
  （Playwright 截图→pypdfium2 拼 PDF→OCR 文字层）全站可用。
- **公共件**：信封判定/三解析（内联 var/JSONP/变体 base64）/分页机/浏览器件/魔数识别/
  质检门（NFR-GATE 数值化四门）/图像+HTML 双 PDF 器/SWF 工具链/OCR 文字层回注/健康探针/
  字节缓存+token 台账/降级矩阵/页签名器/账号池（轮换/健康/熔断/SecretStr 降敏）。
- **编排与交付**：orchestrator（订单→收割计划→执行→质检→镜像树→既有交付链）+
  progress_events 施工直播事件件；T42 全链贯通（蓝图→PDF→镜像→zip 交付包）。
- **对抗自检**：PentAGI 攻击面研判 4 份（wenku/book118/doc88/账号池），原判 16 条 P0
  已于 2026-10-23 全数清偿（check_p0 合计 0）。

### 如实披露账（六条，挂账口径=如实记录不冒充完成）

1. **wenku verify 段4 未实装**：编排隔离口径——适配器 verify 段对 wenku 型产物未实装，
  qc_fail 件由编排层隔离不入交付（T40 下游3）；T42 全链对 wenku 站按「可作第三站仅验
  collect 段或干脆不做」任务卡口径=**不做**，如实记录（见
  `e2e/artifacts/full_chain/full_chain_summary.json` sites.wenku.note）。
2. **book118 fetch_ladder→PDF 正式接线欠账**：适配器本体 fetch_ladder 不产 PDF；T42 以
  `Book118ChainAdapter`（T19 页清单腿+T23 拼PDF/OCR 四门腿真方法串联，E2E 装配层接线，
  适配器本体零改动）交付——**子类参考实现在案**，正式接线归下一波。
3. **CSDN 实弹挂 VIP cookie 账**：`KB_CSDN_COOKIE` 环境变量或
  `_credentials/csdn.secret.ini` 任一供给即自动转 live（skipif 门即供给探测器）；未供=
  如实挂账拒（零网络不造假跳过）；W8 准入裁定 csdn 不入注册表（合法=
  ['book118','wenku','doc88']）。
4. **第二 wenku 账号挂账**：FR8.AC2 降单测口径=单账号+池槽位单测（acquire 稳定出同一槽、
  第二账号位留空不炸；轮换机制以合成第二账号 tmp ini 单测，非真凭据）；实弹双账号待供。
5. **62 页长档 OCR 小时级+切片模式必用**：book118 收费档（preview=62/actual=124）OCR
  pass1 实测跨 00:17→03:32 断点续跑（≈3 小时 15 分，含多轮续跑），pass2 8 页/块分块回注
  →62 页 searchable PDF 104,417,588 B；paddle 进程长跑劣化实测→**切片换进程=每进程恒新鲜
  （每页断点 flush+块文件断点续块）**，长档必用切片模式（e2e/book118_accept.py
  `slice_seconds`/`_chunks`）。
6. **book118/wenku P0-2 双栈换栈=中期路线已记档**：纯 httpx 栈 TLS/JA3+h2 指纹暴露面
  （wenku P0-2/P0-4+book118 P1-1 同族），中期修法=资产腿迁 curl_cffi
  impersonate=chrome129（版本与 UA 快照锁同值）/轻量腿并入 signer in-page fetch 通道；
  换栈属 e2e 全链回归面，编排层按波次统一收编，本版不实施（wenku.py T26 段文档化处置
  注释块在案；现役缓解位=rn=50 批单发/批间 1.0s/3 轮零进展熔断/资产腿 0.5s 缺省节流/
  NetCache 预算硬顶）。

### 战役史

三下载器全破译（1022 08:25）→ 五线规格提取 6 agent 23min（09:08）→ P4/P5 闸门
15/15 FIXED（10:1x）→ 43 任务/11 波 DAG（10:2x）→ Wave2 十五连发 KEEP 15/15 →
三断恢复六线续命（22:5x）→ T37/T38/T39 三站验收收官 → T40 编排+T41 研判清偿 →
T42 全链+故障韧性 → 本件 T43 发布门。全账见
`07 任务/自动建库Agent/engine/DEVLOG.md`。

## ② 安全门报告（沿 kb_factory/SECURITY_CHECKLIST.md 9 项清单）

机检入口三件（全仓 9 项门 / 引擎发布门 / P0 检查器）：

```
py -3 -m kb_factory.security_gate --check          # 全仓 9 项三态门
py -3 kb_factory/harvest_engine/tools/release_gate.py   # 引擎发布门四门（NFR3/NFR6/P0/pytest）
py -3 "07 任务/自动建库Agent/engine/PENTAGI/check_p0.py" # PentAGI P0 全清检查器
```

**全仓基线（2026-10-23 实跑）：`7 PASS / 2 FAIL / 2 MANUAL（有 FAIL，门不放行）`**——
两处 FAIL 均落在引擎射程，逐项状态与处置如下（门不改；修法=改代码/改配置）：

| # | 项 | 状态 | 引擎面证据与处置 |
|---|---|---|---|
| ① | 凭据零入仓 | PASS | G1 NFR3 引擎扫描未豁免命中 0（豁免 2 值=站方短时公开口令/上游公开测试常量，sha256 表注记，非我方凭据）；凭据只读仓外 `_credentials/*.secret.ini`；全仓门发布面 git ls-files 零命中 |
| ② | 零删除红线 | **FAIL** | `adapters/wenku.py` 3 处 `html_path.unlink(missing_ok=True)`（T26 printToPDF 自建临时 HTML 即删，原作 W:683 同型）——删除对象=引擎自建临时件非用户资产/交付物，但清单字面判 FAIL，如实上报；处置=**移交编排层**：临时件改移动到 .trash/ 或按清单纪律裁决后再放行对外发布 |
| ③ | 频控参数在位 | PASS | RateLimiter 默认 ≥3s/≤500 日（wenku/ima 同限）；doc88 NetworkPacer 四层频控（单发 800-1500ms 抖动/info≥2s/文档间 5-15s/每 8 文档会话冷却+日配额 2000 熔断，T41P0-2 清偿）；wenku 资产腿 0.5s 缺省节流（P0-3 清偿） |
| ④ | 黄源双闸默认 OFF | PASS | 纯净环境 wenku `on=False`；`KB_WENKU_FETCH=1` 但 secret 缺位仍 OFF（env+secret 双闸实测） |
| ⑤ | 敏感词门 | PASS | 5a `verify_kbfactory` 47/47（页序锚+禁词表+支付接线）；5b 交付文案零禁词（全仓门实测） |
| ⑥ | 网络面白名单 | 6a **FAIL**（口径差）/6b MANUAL | v1 白名单 {wenku.baidu.com, ima.qq.com, ai.epcschool.top} 未含引擎 W1-W9 已验收请求面（max/openapi.book118.com、www.doc88.com、www.docin.com、page.douding.cn、blog.csdn.net、wkretype/wkrtcs/wkbjcloudbos.bdimg.com 资产域、github.com/api.github.com/ghproxy.net 工具链自举域、schema.org/www.w3.org/kb.zongbao.dev 文档性常量）；处置=**清单⑥扩表**（改清单配置不改门，待用户明示令并表）；6b 逐域语境人工核在案（只读检索/频控真跑/预算硬顶/doc88 禁第三方镜像域 R20） |
| ⑦ | 日志无凭据打印 | PASS | 全仓门实测零命中；账号池 P0-1 清偿=SecretStr 降敏（repr/str 恒 ***，vars/asdict/deepcopy 零回显） |
| ⑧ | 测试覆盖入口 | PASS | 全仓 58 测试文件含 subprocess 真 CLI 入口；引擎 38 测试文件全套+四份 e2e 验收脚本在档 |
| ⑨ | 生产开关人工核 | MANUAL | 上线时人工确认：生产机不设 KB_WENKU_FETCH；secret 指向仓外；KB_WENKU_MIN_INTERVAL=6；KB_WECOM_NOTIFY=1 |

**NFR3 密钥明文扫描（发布门 G1）**：三条规则（R1 凭据名字面量赋值 / R2 BDUSS 族 cookie
字面量 / R3 Bearer·sk- 密钥字面量）扫引擎面 `*.py/*.md`（排除 `__pycache__`、
`tests/fixtures/` 夹具面、`e2e/artifacts/` 运行件——边界如实打印）；豁免表只存 sha256
（值永不复制进扫描器本体）。本版实测：**未豁免命中 0**。

**NFR6 GPL 隔离（发布门 G2）**：运行面 AST import 零禁根（fitz=AGPL、doc88_extractor=原
GPL 码、presse/ffdec 防误引入）。FFDec 26.4.0 与 presse v0.0.2 均 **GPL-3.0 仅子进程调用
不进仓**（`java -jar ffdec.jar` / `presse merge` 独立进程；二进制落 `rea-tools/`
gitignored；doc88_extractor=方案B 机制重写零 import）——本机实测核对表
`tools/LICENSES.md` 在案。fitz(PyMuPDF/AGPL) 在机但全线禁用，实测一律 pypdfium2。

**PentAGI P0（发布门 G3）**：`check_p0: PASS——4 份报告 P0 全清（合计 0）`（wenku 4+
book118 4+doc88 5+账号池 3=原判 16 条 P0，2026-10-23 全数清偿，逐条「已清」注记=修法+
验证在 `engine/PENTAGI/*_assessment.md`）。

## ③ E2E 报告

### T42 全链+单站故障韧性（FR9.AC1+NFR5，2026-10-23 06:33 实跑 454.5s）

证据源：`e2e/artifacts/full_chain/full_chain_summary.json`（blueprint/run/ledger/events
全套工件在 `e2e/artifacts/full_chain/`）。

- **FR9.AC1 端到端 1 单全链**（ORD-T42-FR9-1，236.8s）：2 槽 2 交付 0 失败——
  book118《餐饮行业可行性分析报告.docx》2 页/1041 字（L1）+ doc88《人工智能应用场景
  机会清单（政务领域）》4 页/3234 字（L1），质检门全过（verify+水印抽帧 ink 带
  [0.001,0.85]+完整性）；镜像树 manifest 2 条（coverage 2/2、4/4）→ 交付链 zip
  7,805,043 B；progress_events 17 行五相位序正确（order_start→browser_close→mirror→
  chain→order_done）；harvest_audit 116 行；网络预算 2/12。
- **NFR5 单站故障韧性**（ORD-T42-NFR5-1，217.0s）：注入 `taskkill /T /F` 杀
  java.exe(ffdec) PID 50344（rc=0）；故障站 doc88 项=failed（ladder_exhausted_at:L1
  form=none，如预期）；**同单他站不受影响**——book118 项照常 delivered（2 页/1041 字，
  质检门全过）+ 事后证词（doc88_collect_start_idx=4 / book118_qc_idx=10 事件序在
  案）；csdn 槽=guide（not_routable 如实降级指引）；counts 3=delivered 1+guide 1+
  failed 1；events 13 行 checks ok。
- 射程外如实声明：deliver/SMTP 发送腿不在本件射程（归发布链）。

### 三站实弹验收链（10/10 × 3）

| 链 | 任务/AC | 结果 | 要点 |
|---|---|---|---|
| book118 | T37/FR3.AC1+AC2 | **10/10 质检门全过** | 免费 6/6（页数==actual）+收费 4/4（页数==preview、perm=yellow「预览部分」partial 标注）；OCR GT 取词 10/10（每份 3/3 精确命中≥8 门）；累计真发 520（browser 326/openapi 70/image 124）终轮 0/30 全缓存复放；62/124 档字数 29191≥90%×27785 |
| wenku | T38/FR2.AC2/AC3/AC4 | **AC 全过** | AC2 三型 10/10（type3 6/type2 2/type1 2）；AC3 无效 docId 报「无法提取 pageData」+1160 页件拒付（§8-2，showPage=8 如实）；AC4 VIP 候选×2 实弹断言 `needs_vip_candidate`（vip-reuse 2/20 覆盖 1410 字 T22 证据复用 net=0；vip-live 2/4 覆盖）；预算 44/44（cache_hits 13） |
| doc88 | T39/FR4.AC1 | **10/10 等价抽取全过** | 等价抽取阈值门三段全过：ratio **全 1.000**（PDF 可抽文本≥0.9×FFDec frame:text 同源参照 10/10 满额）；页数==p_pagecount（10/10）；首/中/末视觉抽检 37 帧留档；L1 梯队 10/10；六轮 129 发净请求全账+终轮零网络缓存复放 |

### 离线测试套件（发布门 G4）

全套 pytest（`KB_HARVEST_SKIP_LIVE=1` 实弹用例跳过且明示；发布门口径=离线全绿+三链
验收+E2E 证据在档）：**489 passed, 38 skipped, 1 warning in 604.49s（0:10:04）**——
38 skipped=实弹用例跳过（CI 口径）。实弹用例（@pytest.mark.live）在三链验收与
T42 全链中已实跑在档（zero-mock 真网络）。

## ④ 合规声明

### 四条红线（PROPOSAL §6，延续 KB-FACTORY 宪法+新引擎三条新宪）

1. **只下载用户有权访问的内容**：免登录公开件、用户自有 VIP 账号可见件。**不破解付费墙、
   不绕过单份购买价、不做盗版分发**（知识库=私有交付使用）。
2. **绿黄红分级**沿用 fulfillment 注册表：绿=公开/自有源；黄=预览重组件（对用户透明标注
   来源与形态）；红=付费墙绕过/分发盗版=**引擎层硬拒绝**。
3. **文档 DNA 判例意识**（韩寒案/稻壳案判例档案在案）：交付物不二次公开传播；
   CSDN/book118 VIP 件仅用户自有账号下单。
4. **GPL 隔离**：doc88_extractor 机制借鉴/进程隔离，代码不混仓（见章② NFR6）。

### 标记映射（NFR1 统一表，CONTEXT.md 词条）

| 标记 | 触发方 | 判据 | 落点 | 行为 |
|---|---|---|---|---|
| `needs_vip_candidate` | wenku 适配器 | 连续 3 轮补页零进展+showPage<page+非 tri_cap（形态=推断） | FileMeta.extra.wall_status+ledger（perm 备注） | 部分收割如实标注（coverage=showPage/page） |
| `paid_wall` | csdn 适配器 | DOM 判定 isPaid 或非 isVipFree | 同上 | **硬拒**（只做 VIP 免费件） |
| `blocked_waf` | doc88 适配器 | 命中「网络环境安全验证」 | 同上 | **硬拒+禁自动走第三方镜像域**（R20） |
| `blocked_mirror_policy` | doc88 适配器 | 第三方镜像域策略位 | 同上 | **硬拒**（信任面不入引擎） |

### 黄线透明标注口径

- 预览重组件（book118 收费档等）一律 `perm=yellow`+形态标注「预览部分」+
  `preview_limit=N` 入 manifest；覆盖页数如实（coverage=preview/actual），禁上限值
  覆盖实收（T41 book118 P0-3 漂移二次校验钉死：openapi 实测=唯一事实源）。
- 交付物=私有交付使用（用户自有账号下单面），不二次公开传播；黄线产物对用户透明标注
  来源与形态（fulfillment 注册表同源）。
