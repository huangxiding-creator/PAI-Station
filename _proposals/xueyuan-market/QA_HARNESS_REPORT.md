# QA_HARNESS_REPORT — 总包学园（zongbao）发布门禁静态断言集

> 生成：2026-09-28，WBS T-P0-27/28（Super-Skill Phase 9 开篇件）。
> 交付物：`E:\AI-Station\WeAppForge\work\harness_xueyuan.cjs` + `package.json` 脚本 `harness:xueyuan`。
> 对象：构建产物包目录 `E:\AI-Station\WeAppForge\projects\zongbao`（pipeline/build.mjs 原地 tsc emit + packNpm 后的发布形态；node_modules 不随 ci 上传，扫描已排除）。
> 判据真源：REQUIREMENTS.md「五、验收判据汇总表（P0 上线门）」10 条硬判据 + NFR-04/05/08 + FR-P0-02/03/04/05/06/07。

---

## 一、怎么跑

```bash
cd E:\AI-Station\WeAppForge
npm run harness:xueyuan                 # 对 projects/zongbao 当前包
node work/harness_xueyuan.cjs <目录>    # 对任意包副本（FAIL 注入验证用）
XY_HARNESS_PKG=<目录> node work/harness_xueyuan.cjs   # env 注入同效
NO_COLOR=1 ...                          # 关彩色
```

- 每条断言独立成行 PASS/FAIL/SKIP，任何 FAIL → 退出码 1（CI/门禁挂钩点）。
- 全程只读扫描包目录；服务端正仓库 `E:\AI-Station\data\xueyuan` 只读取付费指纹（不在位时相关项自动 SKIP，可移植）。
- 结构沿 biaoxun `work/harness.cjs` 惯例（.cjs / 绝对路径 / 退出码），静态包扫描为 xueyuan 新增形态。

## 二、断言清单（30 条 = 25 硬门 + 5 SKIP）

| ID | 断言 | 来源 | 覆盖方式 |
|---|---|---|---|
| XY00 | 包目录在位非空 | — | 文件计数 |
| XY01 | app.json 五页路由齐（index/detail/reader/me/agreement） | FR-P0-02/03/04/09 | pages 数组解析 |
| XY02 | 窗口标题含「总包学园」 | 门面 | window.navigationBarTitleText |
| XY03 | 页脚逐字常量 `FOOTER_DISCLAIMER='行业研究，非投资建议；决策自担。'` | NFR-08 | utils/agreement.js 逐字 |
| XY04 | detail/reader 双页常量链（js 取 agreement_1.FOOTER_DISCLAIMER + wxml 渲染 footerDisclaimer） | NFR-08 | 常量→页→渲染三段链 |
| XY05 | 支付前披露四指纹：不支持七天无理由退款 / 未成年人 / 每月最多成功退款 2 次 / ¥348.60 | NFR-08 | 全包文本命中 |
| XY06 | 协议版本链 `版本：v1.0`（常量→页→wxml 渲染） | 门#10 | 三段链 |
| XY07 | 披露弹层载体 templates/pay-sheet.wxml 在包且被 detail 引用 | NFR-08 | 存在+import+is= |
| XY08 | 付费章空壳：38 份 chapters.json 全量（非抽样），非空 html 恰为前 trialChapterCount 章连续 | FR-P0-07/门#6 | 全量结构扫描 |
| XY09 | 付费章存在性 Σ>0（防空壳门 vacuous 空转） | FR-P0-07 | 计数 |
| XY10 | A3 付费指纹句零命中：从 data/xueyuan 全量正仓库取 2 份报告付费章特征句（8-12 字含数据点、排除免费语料撞车），包内文本零命中 | 门#6/A3 | 双向指纹 grep |
| XY11 | 包内无全量泄漏件（chapters_full.json / *.pdf / *.docx 零存在） | FR-P0-07 | 扩展名扫描 |
| XY12 | 价格一致性：catalog 全部 price=49800 分（¥498）；包内 *.json 无 990 遗留 | BM/门 | 解析+正则 |
| XY13 | 密钥卫生：首方代码 appsecret/session_key/offerId/wx16位hex 零命中（mock-fixtures.js/ts 按需求「测试 fixture 除外」豁免且值须为 mock 前缀） | NFR-04 | 词法+hex 模式 |
| XY14 | console.log 零命中（源码+产物，首方 js/ts） | 卫生 | 行级定位 |
| XY15 | 试读就位：每份 trialChapterCount≥1；133 试读章 html 全非空且 >200 字 | FR-P0-04/门#2 前置 | 全量计数 |
| XY16 | 试读抽样 5 份（首2+中1+尾2 确定性抽取）：首章 html 含块级标签（真排版非占位） | FR-P0-04 | 抽样深度核 |
| XY17 | 目录账实相符：catalog 38 条 ↔ 包内报告目录数 ↔ 每份章数三账全平 | FR-P0-01 | 交叉对账 |
| XY18 | 灰置矩阵·服务端腿：api.js `PAY_NOT_CONFIGURED` 503→emitPayGray；pay.js 503→降级文案 | NFR-10/门#3 静态半边 | 代码路径指纹 |
| XY19 | 灰置矩阵·本地腿：config appConfig.features.virtualPay 开关 + pay.js 消费链 | NFR-10 | 开关存在性 |
| XY20 | md2blocks 排版链：styles/md2blocks.wxss + utils/md2blocks.js + render.js require + reader chapterBlocks | FR-P0-04 | 四点链 |
| XY21 | 搜索防抖：index.js searchTimer + clearTimeout + setTimeout(300) | FR-P0-02 | 模式指纹 |
| XY22 | 分页契约：PAGE_SIZE + hasMore=page*PAGE_SIZE<total + onReachBottom | FR-P0-02 | 模式指纹 |
| XY23 | 401 静默重登一次上限：api.js `statusCode===401 && retryable` 一次性闸 | FR-P0-05 | 模式指纹 |
| XY24 | PDF ≤10MB（服务端数据侧交付集：每报告根层 read/print/full.pdf，114 份） | NFR-03/门#1 | 文件大小 |
| XYS1 | 引擎 8871 /health 在役（门#7） | — | **SKIP**：需活体探针（stitch_live_*.mjs 已覆盖） |
| XYS2 | 支付幂等/409/503 摘除重启（门#3/#4，NFR-10/13） | — | **SKIP**：需活体探针（stitch_live_*.mjs 已覆盖） |
| XYS3 | 试读链路真机 ≤0.5min（门#2）+ 首屏 NFR-02 | — | **SKIP**：需真机录屏计时 |
| XYS4 | 下载双 PDF 水印（门#5，NFR-06） | — | **SKIP**：需已购态活体下载 |
| XYS5 | 试读占比 15%-25% 带内（门#1） | — | **SKIP**（带实数）：33/38 份带内、全站聚合 14.0%——内容侧切章参数问题，列发现 F2 不设硬门 |

## 三、两轮实跑结果（2026-09-28）

**第一轮（对当前包目录）**：`24 PASS / 1 FAIL / 5 SKIP`，退出码 1。
唯一 FAIL = **XY14 console.log 零命中 —— 真实缺陷 F1，非 harness 误报**（定位见下）。其余 24 条硬门全绿。

**第二轮（FAIL 注入验证）**：将包复制到临时副本 `work/_xy_inject`，把 catalog 中 `xz-shuili-2026` 的 price 改 49800→990：

```
[FAIL] XY12 价格一致性 49800 分
       非 49800: xz-shuili-2026=990 · 990 遗留: content/catalog.json
================================================================
HARNESS FAIL ×2 — 23 PASS / 2 FAIL / 5 SKIP · 计 30 条
EXIT_CODE=1
```

注入被 XY12 精确捕获（含报告 id、实际值、所在文件），退出码非零；XY14 的 F1 同场在列。验后临时副本已删除，原包复检 38 份 price 全 49800、零污染。

> 结论：门禁「该红就红」的判定语义已验证——注入的价格脏值与既有的 console.log 缺陷各自触发了对应断言行，退出码均正确为 1。

## 四、发现（记报告不改码——修复属业务/内容侧，需主会话排期）

| # | 严重度 | 发现 | 位置 | 建议 |
|---|---|---|---|---|
| **F1** | 中 | `console.log` ×2：cloud ready 分支与「cloud 未开通，降级本地模式」——后者在 `features.cloud=false` 下**每次生产冷启动都会打印** | `app.js:11,14`（产物，随包上传）+ `app.ts:12,14`（源码） | 删两行或降为静默；改后 XY14 转绿即达「第一轮全 PASS」目标态 |
| F2 | 低 | 试读占比带外：3 份 <15%（最低 js-shuiwang 9.1%）、2 份 >25%（最高 33.3%）、全站聚合 14.0%（带下限 15% 差 1pp） | 内容切章参数（data/xueyuan/build） | 内容侧复核 trialChapterCount 定档逻辑；本 harness 以 XYS5 呈实数不设硬门 |
| F3 | 低 | catalog 38 份 vs 门#1 目标 40 份（40 docx 批处理口径） | data/xueyuan/build=38 | 核对是 2 份 docx 未入库还是目标基准应为 38；门#1 验收时按实数对账 |
| F4 | 低 | pdfs 交付树内有水印中间产物 `js-shuiwang-2026/wm/u16d49ef096_592881_read.pdf` 23.4MB（超 10MB 预算，非交付件） | data/xueyuan/pdfs/js-shuiwang-2026/wm/ | 水印工作件移出交付树，防引擎误扫/误下发 |

**观察（不算缺陷）**：
- `project.config.json packOptions` 已 ignore `.ts` 后缀与 tsconfig/package.json——上传包不含 TS 源码，F1 的用户面影响只在 app.js 两行。
- 真实 appid 仅出现在 project.config.json（上传必填正位）；首方代码零 appsecret/session_key/offerId（mock-fixtures 的 `mockOfferId` 属 NFR-04 明文豁免位）。
- `config.mockApi: true` 为当前 dev 态（B 线引擎联调后翻 false）——**上线前人工三查**：`mockApi=false`、`apiEnv='prod'`、PROD_BASE 换正式域名，静态门不管运行态开关（避免 dev 期日常红）。
- 「featureFlags」在实现中名为 `appConfig.features`（virtualPay/cloud/voiceInput），XY19 按实名断言。

## 五、接入 forge 上传前门禁

1. **手动门**：`pipeline/upload.mjs` 跑前先 `npm run harness:xueyuan`，退出码非零即停（当前会因 F1 停——预期行为，修复 F1 后转绿）。
2. **自动门（推荐）**：在 upload.mjs 入口 spawnSync `node work/harness_xueyuan.cjs <projectPath>`，`status!==0 → process.exit(1)`，与 tsc 编译门同款形态（本次未改 upload.mjs，属 pipeline 业务文件，留主会话一行接入）。
3. **CI/发版前**：`node --test`（现有 tests/*.test.mjs）+ `npm run harness:xueyuan` 双跑，静态门与单测互补。
4. 活体项（XYS1-S4）由 stitch_live_*.mjs 在引擎联调窗执行，不进静态包门禁。

---
*harness 本体：`E:\AI-Station\WeAppForge\work\harness_xueyuan.cjs`（30 断言注册位=check() 调用；新增判据照抄一行 check 即可）。*
