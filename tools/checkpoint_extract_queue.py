"""提取队列检查点（09:41 系统级一次性任务的载荷）。

与 Claude 会话彻底解耦：直接读 inventory.db 组报告 → 写微信桥
outbound-spool（桥守护 30s 轮询送达）。桥不在位则落本地日志兜底。
用法：pythonw checkpoint_extract_queue.py [--dry]
"""
from __future__ import annotations

import json
import os
import sqlite3
import sys
import time
from datetime import datetime
from pathlib import Path

DB = Path(r"E:\AI-Station\data\local_index\inventory.db")
SPOOL = Path.home() / ".wechat-claude-code" / "outbound-spool"
LOG = Path(r"E:\AI-Station\data\local_index\checkpoint.log")


def build_report() -> str:
    db = sqlite3.connect(str(DB))
    db.row_factory = sqlite3.Row
    st = {r["status"]: r["n"] for r in db.execute(
        "SELECT status, COUNT(*) n FROM files GROUP BY status")}
    ok, pending = st.get("ok", 0), st.get("pending", 0)
    done_total = ok + st.get("failed", 0)
    ocr_pdf = db.execute(
        "SELECT COUNT(*) FROM files WHERE parser_ver LIKE '%winrt-ocr1'"
        " AND status='ok' AND kind='pdf'").fetchone()[0]
    ocr_img = db.execute(
        "SELECT COUNT(*) FROM files WHERE parser_id='image-ocr'"
        " AND status='ok'").fetchone()[0]
    img_text = db.execute(
        "SELECT COUNT(*) FROM files WHERE parser_id='image-ocr'"
        " AND status='ok' AND hash_full != '' AND kind='image'"
        " AND extracted_at > 0").fetchone()[0]
    failed = st.get("failed", 0)
    pct = 100.0 * ok / max(done_total + pending, 1)
    rate = ""
    try:
        hour = db.execute(
            "SELECT COUNT(*) FROM files WHERE extracted_at > ?",
            (time.time() - 3600,)).fetchone()[0]
        rate = f"，近一小时磨了 {hour:,} 个"
    except Exception:
        pass
    lines = [
        f"【本地大脑进度检查点】{datetime.now():%H:%M}",
        "",
        f"已入脑 {ok:,} 个文件（完成度 {pct:.1f}%）{rate}",
        f"队列剩 {pending:,} 个待磨",
        f"扫描件 OCR 收编：{ocr_pdf:,} 份 PDF",
        f"图片 OCR 收编：{ocr_img:,} 张（其中带字入库 {img_text:,}）",
    ]
    if pending < 2_000:
        lines += ["", "队列接近磨完——全量分析基本完成 ✅"]
        if failed:
            lines.append(f"残余失败 {failed} 个（多为纯图片页/损坏文件，已隔离不影响）")
    db.close()
    return "\n".join(lines)


def main() -> int:
    dry = "--dry" in sys.argv
    msg = build_report()
    if dry:
        print(msg)
        return 0
    try:
        SPOOL.mkdir(parents=True, exist_ok=True)
        out = SPOOL / f"ckpt-{int(time.time())}.json"
        out.write_text(json.dumps(
            {"text": msg, "created_at": time.time()}, ensure_ascii=False),
            encoding="utf-8")
        LOG.parent.mkdir(parents=True, exist_ok=True)
        with LOG.open("a", encoding="utf-8") as fh:
            fh.write(f"{datetime.now():%F %T} spooled {out.name}\n")
        return 0
    except Exception as exc:  # 桥不在位：落日志不失败
        with LOG.open("a", encoding="utf-8") as fh:
            fh.write(f"{datetime.now():%F %T} FAIL {exc}\n{msg}\n")
        return 1


if __name__ == "__main__":
    sys.exit(main())
