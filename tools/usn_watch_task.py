"""USN 增量看护任务载荷（管理员级 schtask 每 15 分钟调一次）。

第一版=安全采样模式：读各盘 USN journal 元数据 + 采样记录形态，
域内路径追加 usn_queue.jsonl（生产者；消费在提取进程侧，单写者
纪律不破）。游标落在 usn_cursor.json——首跑只记水位不回放全史。
"""
from __future__ import annotations

import json
import subprocess
import sys
import time
from datetime import datetime
from pathlib import Path

OUT_DIR = Path(r"E:\AI-Station\data\local_index")
QUEUE = OUT_DIR / "usn_queue.jsonl"
CURSOR = OUT_DIR / "usn_cursor.json"
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
    # 游标键=盘符（"C:"…）——旧判 "next_usn" not in cursors 永真，
    # 水位差从未算过（2026-09-17 修）
    first_run = not any(
        isinstance(v, dict) and "next_usn" in v
        for v in cursors.values())
    results = {d: _probe(d) for d in DRIVES}
    now_meta = {d: m.get("next_usn") for d, m in results.items()}
    entry = {"ts": time.time(), "first_run": first_run,
             "probes": results}
    # 首跑只记水位；后续跑记录增量水位差（journal 消化速度=变更活度）
    if not first_run:
        entry["delta_records_hint"] = {
            d: (now_meta[d] or 0) - (cursors.get(d, {}).get("next_usn") or 0)
            for d in DRIVES if now_meta[d]}
    cursors.update(results)
    CURSOR.write_text(json.dumps(cursors, ensure_ascii=False, indent=1),
                      encoding="utf-8")
    with (OUT_DIR / "usn_watch.log").open("a", encoding="utf-8") as fh:
        fh.write(json.dumps(entry, ensure_ascii=False) + "\n")
    return 0


if __name__ == "__main__":
    sys.exit(main())
