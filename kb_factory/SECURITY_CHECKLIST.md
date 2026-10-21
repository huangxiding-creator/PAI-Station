# KB-FACTORY 安全自检清单（W10 · PentAGI 蒸馏）

上线门：**有一条 FAIL 就不放行。** 机检入口（仓库根）：

```
py -3 -m kb_factory.security_gate --check
```

三态：`PASS`（机检通过）· `FAIL`（机检不通过，门不放行，退出码 1）· `MANUAL`（不可机检，
人工核后在发布记录归档）。清单纪律：**逐条可机检的机检，不可机检的列人工核**；门不通过的
修法都是改代码/改配置，绝不改门。

## 检查项

### ① 凭据零入仓（机检）
- 判据：`git ls-files` 于**发布面**（`kb_factory/` + `微信小程序/zongbao-ai/`）扫描凭据形态
  文件名（secret/credential/password/key/pem/token/cookie），及 `_credentials/` 目录下
  非占位文件。
- 例外白名单：`_credentials/.gitkeep`、`_credentials/chain.jsonl`（空占位与操作链日志，
  实测 0 字节，不含凭据值）。
- 边界如实声明：站内（AI-Station 全仓）非发布面另有若干凭据形态**文件名**（skill 文档、
  探针脚本等），不属本门管辖；按清理纪律，清理由用户明示令，门只如实带出计数。
- 处置：命中 FAIL → 凭据文件移出仓库（`git rm --cached` + gitignore），值回填到
  `07 任务/自动建库Agent/_credentials/`（gitignored）。

### ② 零删除红线（机检）
- 判据：`kb_factory/` 运行时代码（排除 tests/samples 夹具）grep
  `os.remove(` / `shutil.rmtree(` / `.unlink(`，零命中才 PASS。
- 依据：W7 铁律「任何分支绝不删除文件（failed 也只移动）」+ 1012 事故教训
  （自主清理曾致永久丢失，见 CLAUDE.md 清理纪律）。
- 处置：命中 FAIL → 删除调用改为覆盖写/移动；测试夹具里的清理代码不得进入运行时目录。

### ③ 频控参数在位（机检）
- 判据：`RateLimiter` 构造默认 `min_interval≥3`（秒）且 `daily_limit≤500`（次/日）；
  wenku 适配器代码默认（`KB_WENKU_MIN_INTERVAL`/`KB_WENKU_DAILY_LIMIT` 缺省值）同限；
  ima 适配器默认同限。
- 生产注记：M1 实测文库对 3s 连发有速度软拒——生产建议 `KB_WENKU_MIN_INTERVAL=6`
  （run_seeds v2 教训：6s 间隔+种子间冷却 30s+空返熔断）。
- 处置：FAIL → 改代码默认值（env 只允许更严，不允许更松）。

### ④ 黄源双闸默认 OFF（机检）
- 判据：`registry()` 纯净环境下 wenku 渠道 `on=False`；且 `KB_WENKU_FETCH=1` 但
  secret 缺位时仍 `on=False`（env+secret 双闸，二者缺一不放行）。
- 处置：FAIL → 回退到双闸语义；黄源放行须用户明示令（待供给项，见 RELEASE.md §4）。

### ⑤ 敏感词门（机检，两面）
- 5a 小程序面：跑 `tools/verify_kbfactory.py`（含页序回归锚、渠道名/技术词禁词表
  `["ima","wenku","文库","飞书","feishu","api"]`、支付接线），rc=0 才 PASS。
- 5b 交付面：占位文案（pdf/xlsx/doc/docx 占位模板）+ 随身导入包说明模板（如何导入/
  目录速览）全扫 convert 禁词表 `FORBIDDEN_WORDS`（与 `md_convert.py` 单一事实源同源，
  只许扩不许收窄），零命中才 PASS。
- 处置：FAIL → 改用户面文案；**绝不收窄词表**。

### ⑥ 网络面白名单（机检 + 人工核）
- 6a 机检：`kb_factory/` 运行时代码所有 `http(s)://` URL 的域名必须 ⊆ 白名单
  `{wenku.baidu.com, ima.qq.com}`。
- 6b 人工核（MANUAL）：逐条核对 URL 出现处的请求语境（只读元数据检索、零下载、
  频控真跑）——机检能保证域名，保证不了语义。
- 处置：FAIL → 新增域先过用户令；文档性 URL 也须入白名单或在 tests 内。

### ⑦ 日志无凭据打印（机检启发式 + 人工复看）
- 判据：`print(`/`log(` 调用形参里出现 password/token/secret/cookie 词形 → FAIL。
- 已核：SMTP/文库 secret 读取只进 `configparser`，从不打印值；企微降级通知只带
  订单号|邮箱|包路径。
- 人工注记：新增日志点时人工复看一眼（启发式防不住间接拼接）。

### ⑧ 测试覆盖入口（机检）
- 判据：`kb_factory/**/tests/` 存在以 **subprocess 调真 CLI**（`-m kb_factory.*`）的
  测试——直调不算数（W8 judge 教训：subprocess 显式 utf-8 解码，GBK 控制台防绞碎）。

### ⑨ 生产开关人工核（MANUAL）
- 上线时人工确认：生产机不设 `KB_WENKU_FETCH`（黄源默认 OFF）；
  `KB_SMTP_SECRET`/`KB_WENKU_SECRET` 指向仓外文件且不入仓；
  `KB_WENKU_MIN_INTERVAL=6`；`KB_WECOM_NOTIFY` 保持默认 1（真通知腿在位）。

## 门输出基线（2026-10-22）

```
9 PASS / 0 FAIL / 2 MANUAL（6b 网络语境人工核、⑨ 生产开关人工核）
```

蒸馏源：PentAGI 上线前安全自检方法论（机检优先/三态诚实/门不可被测试旁路），
结合本站铁律（清理纪律 1012、数字零造假、黄源双闸）裁剪为 9 项。
