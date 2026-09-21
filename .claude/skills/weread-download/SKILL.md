---
name: weread-download
description: 微信读书整书提取落盘（book.json + md + docx），产出喂 B1 技能包/B2 记忆卡管线。Use when 用户要提取/下载/抓取微信读书的书、建书库语料、找书入库、或需要某书的 book.json 原料时。内嵌账号安全铁律（日限 2 本、节流 5.5~12s+阅读间歇、书间冷却 600s、搜索节流、熔断、只读接口）与 -2012 登录失效处置流程。
---

# 微信读书整书提取

项目内成熟管线：搜索 → 选书 → 批量提取 → 验收 → 喂书加工管线。
实现源码在仓库里（`scripts/weread_*.py` + `src/paistation/forge/weread*.py`），
本 skill 只编排它们，不重新发明。

## 产物落点

`data/weread/<书名slug>/`：`book.json`（章节树+全文，管线原料）、`<书名>.md`、`<书名>.docx`、`images/`。
书名特殊字符（`/?:`等）自动替换为 `_`，中文保留。

## 五步流程

### 1. 查重 + 搜索

```bash
ls data/weread/                          # 已有书一目了然（_auth/_recon 除外）
.venv/Scripts/python.exe scripts/weread_search.py <关键词> [数量默认20]
```

搜索结果落盘 `data/weread/_recon/search_<关键词>.json`，记下目标 `bookId`。

### 2. 选书

对照已有书目（按书名+bookId 双查重）。注意版本字样：
**抢读版/试读版**可能只有部分内容（验收时看 `partial` 字段），可提示用户换正式版。

### 3. 提取（单本命令，多本必须串行）

```bash
.venv/Scripts/python.exe scripts/weread_batch.py --book-id <bookId>
# 加 --no-docx 只出 md+json（省时）
```

多本：**一本一条命令，书间 `sleep 600` 以上**——冷却纪律在脚本外，靠自觉执行。
后台跑推荐把整链写成一个子 shell（参考既有用法），总耗时按 25~70 分钟/本预估
（202 章大书取上限；09-21 再降速后单本耗时约为原始节奏的 3~4×）。

### 4. 验收

```bash
.venv/Scripts/python.exe -X utf8 -c "
import json
b = json.load(open('data/weread/<目录名>/book.json', encoding='utf-8'))
chs = b['chapters']
print(b['title'], len(chs), '章',
      'skipped', sum(1 for c in chs if c.get('skipped')),
      '空文', sum(1 for c in chs if not (c.get('text') or '').strip() and not c.get('skipped')),
      'partial', b.get('partial'))"
```

合格线：`partial=False`、skipped=0；少量空文若为篇题页/分隔页属正常，报告注明即可。

### 5. 报告 + 下游

向用户报告：书名/章数/字数/耗时/完整性表格。下游加工（另一能力，勿自动执行）：

```bash
.venv/Scripts/python.exe scripts/weread_book_products.py skill  <书目录> --depth study
.venv/Scripts/python.exe scripts/weread_book_products.py cards  <书目录>
```

## 账号安全铁律（硬约束，不可协商；09-16 风控收紧，09-21 再降速+日限经用户核准恢复 2）

- **日限 2 本**：`data/weread/_recon/daily_count.json` 自动拦截，到达即停，明日再跑；
  用户要求超量时引用此铁律说明风险，不绕过。
- **书间冷却 ≥600s**：多本串行时手动 sleep。
- **节流 5.5~12s/章 + 阅读间歇**：已内置在 client（每 30~50 章长歇 90~240s），
  禁止调快。放宽任何参数必须先问用户。
- **搜索节流**：两次搜索间隔 ≥25s（脚本自动等待）、日上限 8 次——
  搜索连发是 2026-09-15 风控的头号嫌疑。
- **登录探测优先**：不要每日例行重登（频繁新会话本身是信号）——
  直接跑提取，报 -2012 才执行登录。
- **只读接口**：永不调用任何写端点（加书架/写笔记/点赞一律不碰）。
- **熔断**：连续异常自动停并落盘 `_recon/circuit_break.json`；当日不再重试。
- **风控零容忍**：用户报告任何风控提醒/验证码 → 立即停跑≥1 天、
  复查参数、报告用户；复跑后再出现则停 3 天并考虑进一步降速。

## 常见信号（速查）

| 信号 | 处置 |
|---|---|
| `WeReadAuthError errCode=-2012` | 登录态失效 → 跑 `scripts/weread_login.py`（见下） |
| 提取 10~17 分钟未完成 | **正常**（节流所致），勿杀进程；判活方法见 playbook |
| 搜索能用但提取报 -2012 | 搜索接口对 cookie 宽松，是假象——以章节接口为准 |
| 用户收到风控提醒/验证码 | **立即停跑≥1 天**，向用户报告已收紧的参数，勿自行恢复 |
| `非 JSON 响应（疑似验证页/风控）` | 同上——这是服务端风控页，停跑报告 |

### 登录（仅在 -2012 时；勿每日例行重登）

```bash
.venv/Scripts/python.exe scripts/weread_login.py 300
```

探测优先：直接跑提取命令即可——cookie 有效就零登录动作；只有报 -2012
才执行上面的登录。频繁刷新会话本身是风控信号（09-16 教训）。

打开可见 Chrome 窗口等扫码。**窗口闪开即关 = 浏览器 profile 还活着、自动登录成功**，
用户没看到窗口不代表失败——以 `data/weread/_auth/weread_auth.json` 的 mtime 为准。
真需扫码时窗口会停留等待（用户动作）。

## 故障与边界情况

详见 [references/playbook.md](references/playbook.md)——遇异常先读它再动手。
