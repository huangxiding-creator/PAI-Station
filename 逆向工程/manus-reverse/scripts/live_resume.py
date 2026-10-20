# -*- coding: utf-8 -*-
"""续跑 Live 任务 — 打开会话页点继续/composer 发词, 轮询事件流 (修正解析).

v2 schema 实证: data.segments[].events[], data.userStatus (2=运行中),
data.taskMode (cascade_lite), data.updatedAt.
"""
from __future__ import annotations

import argparse
import json
import sys
import time
import traceback
from pathlib import Path

AM = Path(r"E:\AI-Station\Auto_Manus")
sys.path.insert(0, str(AM))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

import manus_api as api          # noqa: E402
import manus_lib as lib          # noqa: E402

OUT = HERE = Path(__file__).resolve().parent.parent / "live"

RESUME_PROMPT = "继续。积分已补充，请按既定计划继续完成十二章研究撰写、结构文件生成与最终合并交付；自主决策，无需人工确认。"


def log(m):
    print(f"[{time.strftime('%H:%M:%S')}] {m}", flush=True)


def parse_v2(raw) -> dict:
    """[status, json_text] 或 dict → {events:[], userStatus, updatedAt, title}."""
    if isinstance(raw, (list, tuple)) and len(raw) == 2:
        body = json.loads(raw[1])
    elif isinstance(raw, dict):
        body = raw
    else:
        body = json.loads(raw)
    data = body.get("data", body)
    evs = []
    for seg in data.get("segments", []):
        evs.extend(seg.get("events", []))
    return {"events": evs, "userStatus": data.get("userStatus"),
            "updatedAt": data.get("updatedAt"), "title": data.get("title"),
            "taskMode": data.get("taskMode")}


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("email")
    ap.add_argument("sid")
    ap.add_argument("--poll", type=int, default=180)
    ap.add_argument("--max-h", type=float, default=9.0)
    args = ap.parse_args()

    pw = None
    for name in ("Manus账号（全部）260922_干净版.txt", "Manus账号（全部）260922.txt"):
        p = AM / name
        if p.is_file():
            for ln in p.read_text(encoding="utf-8", errors="replace").splitlines():
                parts = ln.strip().split("|")
                if len(parts) >= 2 and parts[0].strip().lower() == args.email.lower():
                    pw = parts[1].strip()
                    break
        if pw:
            break
    if not pw:
        log("✗ 无密码")
        return 2

    sid_dir = OUT / args.sid
    sid_dir.mkdir(parents=True, exist_ok=True)

    page = lib.make_page(lib.BROWSER_PORT)
    lib.ensure_login(page, args.email, pw)
    tok = api.capture_token(page)

    # 1) 先读当前状态
    raw = api.get_session_v2(page, tok, args.sid)
    info = parse_v2(raw)
    log(f"当前 events={len(info['events'])} userStatus={info['userStatus']} "
        f"mode={info['taskMode']}")

    # 2) 续跑: 会话页找继续按钮, 没有 composer 发词
    try:
        page.get(f"https://manus.im/app/{args.sid}")
        time.sleep(5)
        clicked = False
        for sel in ["@@tag()=button@@text()=继续",
                    "@@tag()=button@@text()=继承并继续",
                    "@@tag()=button@@text():继续"]:
            try:
                btn = page.ele(sel, timeout=4)
                if btn:
                    btn.click()
                    log(f"✓ 点击继续按钮 ({sel})")
                    clicked = True
                    time.sleep(2)
                    break
            except Exception:
                pass
        if not clicked:
            box = lib._composer(page)
            if box:
                box.click()
                try:
                    box.clear()
                except Exception:
                    page.actions.key_down("ctrl").type("a")
                    page.actions.key_up("ctrl")
                box.input(RESUME_PROMPT)
                time.sleep(1.5)
                box.click()
                page.actions.key_down("enter").key_up("enter")
                log("✓ composer 已发送续跑词")
            else:
                log("✗ 无继续按钮且无 composer")
    except Exception:
        traceback.print_exc()

    # 3) 轮询守护 (修正解析)
    deadline = time.time() + args.max_h * 3600
    snap_i = 100
    stall_rounds = 0
    last_update = None
    while time.time() < deadline:
        time.sleep(args.poll)
        snap_i += 1
        try:
            raw = api.get_session_v2(page, tok, args.sid)
            info = parse_v2(raw)
            snap = sid_dir / f"v2_{snap_i:04d}.json"
            snap.write_text(raw[1] if isinstance(raw, (list, tuple)) else
                            json.dumps(raw, ensure_ascii=False), encoding="utf-8")
            from collections import Counter
            tc = Counter(e.get("type") for e in info["events"])
            log(f"snap#{snap_i} events={len(info['events'])} status={info['userStatus']} "
                f"updated={info['updatedAt']} top={dict(tc.most_common(5))}")
            if info["updatedAt"] == last_update:
                stall_rounds += 1
                if stall_rounds >= 20:   # ~1h 无更新
                    log("1h 无更新 → 判定收尾/停止")
                    break
            else:
                stall_rounds = 0
                last_update = info["updatedAt"]
        except Exception as e:
            log(f"poll EXC {type(e).__name__}: {str(e)[:70]}")
            try:
                lib.ensure_login(page, args.email, pw)
                tok = api.capture_token(page)
            except Exception:
                time.sleep(30)

    # 4) 收尾 files+outline
    for kind, fn in (("files", "files.json"), ("outline", "outline.json")):
        try:
            body = api.get_files(page, tok, args.sid) if kind == "files" \
                else api.get_outline(page, tok, args.sid)
            s = body[1] if isinstance(body, (list, tuple)) else json.dumps(body, ensure_ascii=False)
            (sid_dir / fn).write_text(s, encoding="utf-8")
            log(f"✓ {fn} {len(s)}B")
        except Exception as e:
            log(f"{kind} EXC {e}")
    log("=== resume 守护结束 ===")
    return 0


if __name__ == "__main__":
    sys.exit(main())
