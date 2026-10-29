# ERRATA · 2026-10-29 · W4 头条结论勘误（ss-judge 二审证伪记录）

## 被证伪的断言
「superfile2 分片上传必带 CEF 腿 UA；native UA → 31023 param error」

## 证伪证据（ss-judge 独立重放，2026-10-29）
- 重放形态：**原生 UA**（`netdisk;8.2.5.103;PC;PC-Windows;10.0.19045;WindowsBaiduYunGuanJia`，即 BdnSession 默认 ua）
  + **完整参数**（path query+form 双放、vip=2、web=1、app_id、真实 uploadid、partseq=0、1KB multipart、host 取自 locateupload）
- 结果：**HTTP 200 `{"md5":"2c63af43…","request_id":…}`**（分片接收成功）→ UA 非门。
- 对照：xpan create 写面 9019 「need verify」风控墙独立复现成立（目录未落盘）——此条不受勘误影响。

## 误判根因（工人 _diag_w4d 矩阵变量未隔离）
V1–V4 四个「失败」变体**全部缺参**（V1 缺 query path；V2/V3/V4 缺 app_id/web），且都用 native UA；
唯一全参的 V5 恰好是 CEF 腿 → 把「参数完整度」的效应误归因到「UA 腿」。
教训入方法论：**诊断矩阵必须单变量隔离；头条结论入 A 级前必须有独立重放。**

## 修正后口径（已改写入 PROTOCOL.md:98/238/278、README、api.py、transfer.py、_diag_w4d.py）
superfile2 的门 = **参数完整度**（path 双放 + vip=2 + web=1 + app_id）；UA 双腿均放行。
31023 = 缺参（非 UA）；31024 = 缺 app_id；失败信使 = error_code（非 errno）。

## 附带修正
- PROTOCOL.md dlink 速度 2.02MB/s → **2.21MB/s**（以 smoke_w4_run.log 实测档为准）。
- 诊断脚本此后一律落档原始输出至 `tests\_diag_archive\`（judge 指出的自我报告链问题）。
- 法官重放探针存档：`tests\_judge_w4_probe_archive.py`。
- 法官活体预算如实账：7 发（超其原计划 ≤6，含 2 发被风控墙拒绝的写探针，零落盘零残留）。

## 根目录残留核验
_diag_w4b 曾对围栏根本体改名（/API复刻测试_1029→renamed_1029）后恢复；根目录 renamed_1029 残留检查结果：**零残留**（bdn ls / 全量 grep 'renamed' 无命中，2026-10-29 复核）。
