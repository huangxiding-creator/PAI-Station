"""USN 增量看护任务载荷 v2（管理员级 schtask 每 15 分钟调一次）。

v1 只采水位（queryjournal NextUsn）；v2 真读记录流：
`fsutil usn readjournal <卷> csv` 整读（startUsn 参数本机构建 rc=1
不可用）→ parse_meta 水位/回卷判定 → parse_csv 按 Usn>游标早过滤 →
resolve_events 父目录 FRN 反解全路径（零库存依赖，避开与 extract
写端并发）→ 域内事件追加 usn_queue.jsonl（消费=extract --loop 的
drain_events，rename 保语义换路径在那头闭环）。

游标 usn_cursor.json；journal 回卷（游标<第一个USN）→ usn_gap.flag
标记回退全量扫，游标重置到当前水位（丢的历史不重放）。
"""
from __future__ import annotations

import json
import subprocess
import sys
import time
from pathlib import Path

sys.path.insert(0, r"E:\AI-Station\src")

from paistation.sense.localfiles.usn import (  # noqa: E402
    build_dir_frn_map, gap_check, parse_csv, parse_meta, resolve_events)

OUT_DIR = Path(r"E:\AI-Station\data\local_index")
QUEUE = OUT_DIR / "usn_queue.jsonl"
CURSOR = OUT_DIR / "usn_cursor.json"
GAP_FLAG = OUT_DIR / "usn_gap.flag"
DRIVES = ("C:", "E:", "D:", "F:")
# 域内前缀（与 DEFAULT_INCLUDES 同源收窄到文件根）
DOMAIN_PREFIXES = (
    "C:\\Users\\91216\\Desktop\\", "C:\\Users\\91216\\Documents\\",
    "C:\\Users\\91216\\Downloads\\", "C:\\Users\\91216\\Pictures\\",
    "C:\\Users\\91216\\Videos\\", "C:\\Users\\91216\\Music\\",
    "E:\\AI-Station\\", "D:\\20 白龟湖项目\\", "D:\\WEMedia\\",
    "D:\\WEMediaOutput\\", "F:\\工程知识库超市\\", "D:\\MemoTrace\\",
    "D:\\BaiduSyncdisk\\", "D:\\360Downloads\\", "D:\\360安全浏览器下载\\",
    "D:\\md2wechat-skill\\",
)
READ_TIMEOUT = 240.0  # C: 整读可能百 MB 级


def _run(cmd: list[str], timeout: float = 120.0) -> str:
    p = subprocess.run(cmd, capture_output=True, text=True,
                       encoding="mbcs", errors="replace", timeout=timeout,
                       creationflags=0x08000000)
    return p.stdout or ""


def _probe(drv: str) -> dict:
    """journal 元数据（NextUsn 水位）。中文机输出行序固定：
    日志ID / 第一个 / 下一个 / 最低有效 / 最大 / 最大小 / 分配 / 版本
    —— NextUsn=第 3 行的 0x 值（行序法对 GBK 标签免疫）。"""
    import re as _re

    meta = {"drive": drv, "ts": time.time()}
    try:
        out = _run(["fsutil", "usn", "queryjournal", drv])
        lines = [ln for ln in out.splitlines() if "0x" in ln]
        if len(lines) >= 3:
            m = _re.search(r"0x[0-9a-fA-F]+", lines[2])
            if m:
                meta["next_usn"] = int(m.group(), 16)
    except Exception as exc:
        meta["error"] = str(exc)
    return meta


def main() -> int:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    cursors = {}
    if CURSOR.exists():
        try:
            cursors = json.loads(CURSOR.read_text(encoding="utf-8"))
        except Exception:
            cursors = {}
    first_run = not any(
        isinstance(v, dict) and "next_usn" in v
        for v in cursors.values())

    dir_frn = None  # 惰性：有新记录的盘才建（目录树秒级但没必要白跑）
    entry: dict = {"ts": time.time(), "first_run": first_run, "drives": {}}
    emitted = 0
    for drv in DRIVES:
        d = entry["drives"][drv] = {}
        try:
            text = _run(["fsutil", "usn", "readjournal", drv, "csv"],
                        timeout=READ_TIMEOUT)
        except Exception as exc:
            d["error"] = str(exc)[:200]
            continue
        meta = parse_meta(text)
        if "next_usn" not in meta:
            d["error"] = "meta 缺失"
            continue
        cursor = (cursors.get(drv) or {}).get("next_usn") or meta["next_usn"]
        if first_run:
            d["boot"] = "首跑只记水位"
            cursors[drv] = {"next_usn": meta["next_usn"]}
            continue
        if gap_check(cursor, meta):
            GAP_FLAG.write_text(json.dumps(
                {"drive": drv, "cursor": cursor,
                 "first_usn": meta["first_usn"], "ts": time.time()},
                ensure_ascii=False), encoding="utf-8")
            d["gap"] = True
            cursor = meta["next_usn"]  # 丢的历史不重放，从现在起
        if cursor >= meta["next_usn"]:
            cursors[drv] = {"next_usn": meta["next_usn"]}
            continue
        records = parse_csv(text, since_usn=cursor)
        d["records"] = len(records)
        if records and dir_frn is None:
            dir_frn = build_dir_frn_map(
                [p.rstrip("\\") for p in DOMAIN_PREFIXES])
        if records and dir_frn is not None:
            events = resolve_events(records, dir_frn, DOMAIN_PREFIXES)
            if events:
                with QUEUE.open("a", encoding="utf-8") as fh:
                    for ev in events:
                        fh.write(json.dumps(ev, ensure_ascii=False) + "\n")
                d["events"] = len(events)
                emitted += len(events)
        cursors[drv] = {"next_usn": meta["next_usn"]}
    entry["emitted"] = emitted
    CURSOR.write_text(json.dumps(cursors, ensure_ascii=False, indent=1),
                      encoding="utf-8")
    with (OUT_DIR / "usn_watch.log").open("a", encoding="utf-8") as fh:
        fh.write(json.dumps(entry, ensure_ascii=False) + "\n")
    return 0


if __name__ == "__main__":
    sys.exit(main())
