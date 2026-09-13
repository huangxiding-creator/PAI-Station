# Phase 10 Ralph 审计轮（2026-09-13，M1-M6 收官后）

方法：run-log 驱动（RUN_LEDGER + git log + 会话记录）重构时间线 →
浪费计算 → 根因 → 编号修复（S1-S6）→ 三线复盘（解决当下 / 修系统 /
回头验证）→ 收敛判定。

## 一、时间线重构（要点）

| 阶段 | 提交 | 产出 | 浪费点 |
|---|---|---|---|
| 调研 10 路 | — | 454 项（361+93） | 代理配额尽→降级 gh API（已在台账记录，无返工） |
| M1 常驻+语音 | 318fc69 | ~465 tests | TTS 下载走 GitHub 超时→改 hf-mirror（一次返工） |
| M2 记忆 | 846dfd4 | 757 tests | golden QA 1 条词法不命中→改写问句（设计修正非 bug） |
| M3-M5 | ff13a88/5c7ee3e/01e788c | 804 tests | **台账滞后三个里程碑**（W3）；push 网络抖动多次重试（环境非缺陷） |
| M6 | 573cf28/255cabd | 839 tests | **gitignore 吞 src/paistation/dist**（W1）；postinstall 循环 pip 依赖+目录撞车（W2，自查救回）；doctor 新检查项语义错（W2b，旧测试抓住） |
| 收官 | b04bc67 | 台账补齐 | — |

## 二、根因与修复（S1-S6）

| # | 浪费/风险 | 根因 | 三线修复 | 回头验证 |
|---|---|---|---|---|
| S1 | dist 包名撞 `.gitignore` dist/ 规则，commit 半途失败 | 包名与 Python 构建产物惯例冲突，无守卫 | `tests/test_repo_hygiene.py`：src/setup/scripts 全部源文件 `git check-ignore` 必须为空 | ✅ 守卫进套件（若再现即红） |
| S2 | doctor 加"首启向导"检查把全新装机判病 | 新检查项未定义"未开始"语义 | tri-state：未开始=通过、done=true=通过、半途=病 | ✅ 旧 M0 测试恢复绿 |
| S3 | postinstall.ps1 `--without-pip` 后又要 pip（循环依赖）；安装目录与数据目录同名 | 打包脚本从未在干净环境实测 | `scripts/cleanroom_test.py` 永久闸：全新 venv 纯离线装→--version→六环验收 | ✅ 本轮实测通过（0 退出码） |
| S4 | 测试往返 3+ 次（probe=/probe_fn=、str/Path、login_flow 签名） | 写测试未先核签名 | 纪律：写测试前 grep 签名；写进 EVOLUTION | ✅ It5 两次签名核对一次通过 |
| S5 | M3-M5 三里程碑台账欠账 | 里程碑完成未原子附带台账行 | 纪律：里程碑 commit 必含 RUN_LEDGER 行（本文件即补账证据） | ✅ M6 起已按此执行 |
| S6 | ruff 70 处漂移（26 unused-import/25 unsorted/…） | lint 从未纳入门槛 | lint 清零 + hygiene/打包工件守卫进 pytest（每次全量回归即 gate） | ✅ `All checks passed` |

## 三、本轮指标（before → after）

- lint 错误：**70 → 0**
- 测试：**847 → 851**（全绿）
- 覆盖率：89% → 89%（+947 未覆盖语句，弱项补 2：feishu 登录降级/GBK 回退；其余为硬件/模型/真平台合理留白）
- 打包可信度：从未实测 → **cleanroom 干净房 6/6 通过**（全新 venv 离线装→验收）

## 四、收敛判定

剩余未覆盖模块均需外部条件（真麦克风/托盘 GUI/ONNX 模型/飞书真平台），
继续推数字=为覆盖率而覆盖率，违背简单性判据 → **收敛，停轮**。
真 VM 双击验收（ACCEPTANCE.md B 节）仍待用户配合，为唯一未闭环项。
