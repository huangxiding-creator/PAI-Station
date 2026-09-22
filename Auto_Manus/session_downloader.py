# -*- coding: utf-8 -*-
"""P1 — 会话文件本体收割器 (用户令 09-22: 非常详细, 全部弄下来).

采集器 (session_harvester) 拿到的是消息流+文件清单; 本件把清单里的
每个文件本体 (成果 docx/md + 沙箱中间文件 + SKILL.md) 从 manuscdn
直链全量下载. checkpoint 按 sid 记已下文件名, 断点续跑.

前置: session_harvester 已跑 (manifest.collected + <sid>.files.json).
用法:
  python session_downloader.py            # 全量 (harvest 之后串行跑)
  python session_downloader.py --limit 3  # 小批验证
"""
from __future__ import annotations

import argparse
import hashlib
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import manus_lib as lib

OUT_ROOT = Path("harvest_sessions")
MANIFEST = OUT_ROOT / "manifest.json"
DL_STATE = OUT_ROOT / "downloaded.json"


def load_state() -> dict:
    if DL_STATE.is_file():
        try:
            return json.loads(DL_STATE.read_text(encoding="utf-8"))
        except Exception:
            pass
    return {}


def save_state(s: dict):
    tmp = DL_STATE.with_suffix(".tmp")
    tmp.write_text(json.dumps(s, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    tmp.replace(DL_STATE)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--limit", type=int, default=None,
                    help="最多处理多少个会话 (验证用)")
    ap.add_argument("--max-per-sid", type=int, default=50)
    args = ap.parse_args()

    lib.ensure_network()  # 网络预检 (用户令: 不要用户提醒)
    m = json.loads(MANIFEST.read_text(encoding="utf-8"))
    state = load_state()
    page = lib.make_page()

    done = fail = skip = 0
    for key, rec in list(m["collected"].items()):
        sid = rec["sid"]
        acct_dir = OUT_ROOT / rec["email_hash"]
        files_json = acct_dir / f"{sid}.files.json"
        if not files_json.is_file():
            skip += 1
            continue
        if args.limit and done + fail >= args.limit:
            break
        try:
            d = json.loads(files_json.read_text(encoding="utf-8"))
        except Exception:
            fail += 1
            continue
        entries = []
        for f in (d.get("data", {}).get("files", []) or []):
            entries.extend(f.get("raw", []) or [])
        out_dir = acct_dir / f"{sid}.files"
        have = set(state.get(sid, []))
        new_files = [e for e in entries
                     if (e.get("filename") or "?") not in have]
        if not new_files:
            skip += 1
            continue
        out_dir.mkdir(parents=True, exist_ok=True)
        got = []
        for e in new_files[:args.max_per_sid]:
            url, name = e.get("url"), e.get("filename") or "file"
            if not url:
                continue
            try:
                target = out_dir / name
                if not target.exists():
                    page.download(url, str(out_dir), name)
                    time.sleep(1.5)
                got.append(name)
            except Exception as ex:
                print(f"[dl] {sid}/{name} 失败: {type(ex).__name__}",
                      flush=True)
        if got:
            state[sid] = sorted(set(state.get(sid, [])) | set(got))
            save_state(state)
            done += 1
            print(f"[dl] {sid}: +{len(got)} 文件 "
                  f"({str(rec.get('title',''))[:30]})", flush=True)
        else:
            fail += 1
    print(f"[dl] 完成: 会话新增 {done} 失败 {fail} 跳过 {skip}; "
          f"state={DL_STATE}", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
