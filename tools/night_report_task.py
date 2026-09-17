"""夜班战报（晨间一次性任务）：四路夜里产出 → 大白话汇总 → 桥发件箱。

数据源（全被动读，不改任何状态）：
- extract_nightly.log   22:00 提取长跑（只取今晨日期段）
- test_suite_latest.log 04:00 全套 pytest
- backfill_embed.log    04:17 向量回填长跑
- usn_watch.log         USN 值夜 15 分钟轮（近 12h 条目）
- inventory.db/index.db 库存与嵌入进度
"""
from __future__ import annotations

import json
import re
import sqlite3
import time
from datetime import datetime
from pathlib import Path

BASE = Path(r"E:\AI-Station\data\local_index")
SPOOL = Path.home() / ".wechat-claude-code" / "outbound-spool"
TODAY = datetime.now().strftime("%Y-%m-%d")


def _text(name: str) -> str:
    p = BASE / name
    try:
        return p.read_text(encoding="utf-8", errors="replace")
    except OSError:
        return ""


def _today_lines(text: str) -> list[str]:
    return [ln for ln in text.splitlines() if ln.startswith(TODAY)]


def _last_dict(pattern: str, lines: list[str]) -> dict:
    out: dict = {}
    for ln in lines:
        m = re.search(pattern + r" (\{[^{}]*\})", ln)
        if m:
            try:
                out = json.loads(m.group(1).replace("'", '"'))
            except Exception:
                pass
    return out


def extract_part() -> str:
    lines = _today_lines(_text("extract_nightly.log"))
    if not lines:
        return "■ 文件提取：未跑（无今晨日志）"
    tot = _last_dict("长跑完成：总计", lines)
    if not tot:  # 没到收工行=还在磨或中断，取累计
        tot = _last_dict("（累计", lines)
    renamed = sum(int(m) for ln in lines if "秒级事件消费" in ln
                  for m in re.findall(r"'renamed': (\d+)", ln))
    timeouts = sum(1 for ln in lines if "提取超时" in ln)
    s = (f"■ 文件提取：新提取 {tot.get('extracted', 0)} /"
         f" 缓存命中 {tot.get('cached', 0)} /"
         f" 失败 {tot.get('failed', 0)}")
    if tot:
        s += f"（共过手 {tot.get('processed', 0)}）"
    else:
        s += "（长跑未到收工行）"
    if renamed:
        s += f"\n  · 挪窝文件 {renamed} 个零重干（USN 改名专线）"
    if timeouts:
        s += f"\n  · 挂死超时 {timeouts} 个已标失败"
    return s


def test_part() -> str:
    p = BASE / "test_suite_latest.log"
    if not p.exists():
        return "■ 全套测试：未跑（无日志文件）"
    text = p.read_text(encoding="utf-8", errors="replace")
    m = re.findall(r"=+ (.*?) =+\s*$", text, re.M)
    line = m[-1].strip() if m else ""
    if not line:
        return "■ 全套测试：⚠️ 无汇总行（跑挂了？看 test_suite_latest.log）"
    bad = "failed" in line or "error" in line
    return f"■ 全套测试：{line} {'⚠️ 有红' if bad else '✅'}"


def embed_part() -> str:
    lines = _today_lines(_text("backfill_embed.log"))
    if not lines:
        return "■ 语义向量：未跑（无今晨日志）"
    tot = _last_dict("（累计", lines)
    emb, fail = tot.get("embedded", 0), tot.get("failed", 0)
    budget = any("预算优雅收工" in ln for ln in lines)
    try:
        db = sqlite3.connect(BASE / "index.db")
        row = db.execute(
            "SELECT COUNT(*) FROM chunks WHERE embedding_status='none'"
        ).fetchone()
        alln = db.execute("SELECT COUNT(*) FROM chunks").fetchone()[0]
        db.close()
        remain, pct = row[0], (100 - row[0] * 100 // alln if alln else 100)
    except Exception:
        remain, pct = -1, -1
    s = f"■ 语义向量：新嵌 {emb} 块（失败 {fail}）"
    if budget:
        s += "，8 小时预算到点收工"
    if remain >= 0:
        s += f"；总进度 {pct}%（剩 {remain:,} 块明夜续磨）"
    return s


def usn_part() -> str:
    runs = emitted = 0
    renamed_ev = 0
    try:
        cutoff = time.time() - 12 * 3600
        for ln in (BASE / "usn_watch.log").read_text(
                encoding="utf-8", errors="replace").splitlines():
            try:
                e = json.loads(ln)
            except Exception:
                continue
            if e.get("ts", 0) >= cutoff:
                runs += 1
                emitted += e.get("emitted", 0)
    except OSError:
        pass
    if not runs:
        return "■ 文件哨兵：夜里无轮次记录 ⚠️"
    gap = (BASE / "usn_gap.flag").exists()
    s = (f"■ 文件哨兵：{runs} 轮对账，捕获 {emitted} 个文件变化"
         f"（挪窝/改名走零重干专线）")
    if gap:
        s += "；⚠️ 日志回卷过，已标记回退全量扫"
    return s


def stock_part() -> str:
    try:
        inv = sqlite3.connect(BASE / "inventory.db")
        by = dict(inv.execute(
            "SELECT status, COUNT(*) FROM files GROUP BY status").fetchall())
        inv.close()
        return (f"■ 库存：文件 {sum(by.values()):,}"
                f"（已提取 {by.get('ok', 0):,} /"
                f" 待磨 {by.get('pending', 0):,} /"
                f" 失败 {by.get('failed', 0):,}）")
    except Exception:
        return "■ 库存：读取失败"


def main() -> int:
    msg = "\n".join([
        f"【夜班战报 {datetime.now():%m-%d} 晨】",
        extract_part(), test_part(), embed_part(), usn_part(), stock_part(),
    ])
    print(msg)
    try:
        SPOOL.mkdir(parents=True, exist_ok=True)
        item = SPOOL / f"night-report-{datetime.now():%Y%m%d}.json"
        item.write_text(json.dumps({
            "text": msg,
            "created_at": datetime.now().isoformat(timespec="seconds"),
        }, ensure_ascii=False, indent=2), encoding="utf-8")
        print(f"[发件箱已投] {item}")
    except Exception as exc:  # noqa: BLE001
        print(f"[发件箱失败] {exc}")
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
