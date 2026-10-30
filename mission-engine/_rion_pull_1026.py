# -*- coding: utf-8 -*-
"""RadarCycle 1026 补源件: 夜班卡早高峰API → rion直拉70群近31.5h增量+朋友圈, 供值守亲自JTBD研判(替代智谱Map)"""
import json, os, re, subprocess, sys, time
from pathlib import Path

ROOT = Path(__file__).resolve().parent
W24 = Path(r"E:/AI-Station/wechat-24h-ops")
sys.path.insert(0, str(W24))
sys.path.insert(0, r"E:/AI-Station/WeChat-Report")
RION = r"E:\AI-Station\vendor\wechat-intelligence-hub\rion-cli.cmd"
OUT = ROOT / "outputs" / "rion_pull_1026.jsonl"
SINCE = "2026-10-25 00:45"   # 上轮夜班收官时刻=未扫窗口起点

def _run(args, timeout=90):
    env = {**os.environ, "PYTHONIOENCODING": "utf-8"}
    r = subprocess.run(["cmd", "/c", RION, *args], capture_output=True,
                       text=True, timeout=timeout, encoding="utf-8",
                       errors="replace", env=env)
    raw = r.stdout or ""
    i = raw.find("{")
    if i < 0: return {}
    try: return json.loads(raw[i:])
    except Exception: return {}

def pull_group(g):
    d = _run(["history", "--talker", g, "--since-time", SINCE,
              "--limit", "1000", "--order", "asc"])
    msgs = (d.get("data", {}) or {}).get("messages") or []
    out = []
    for m in msgs:
        text = str(m.get("content") or m.get("text") or "")
        if text.lstrip().startswith("<?xml") or "<appmsg" in text:
            mm = re.search(r"<title>([^<]{2,80})</title>", text)
            text = ("〔分享〕" + mm.group(1)) if mm else ""
        text = text.strip()
        if not text or text.startswith("<?xml"): continue
        out.append({"group": g, "who": str(m.get("sender_display_name",
                    m.get("sender", "")))[:20], "text": text[:200],
                    "ct": m.get("create_time", "")})
    return out

def main():
    from soak.deep_sweep import _sessions, pick_engineering_groups
    groups = pick_engineering_groups(_sessions(limit=200))
    print(f"groups={len(groups)} since={SINCE}")
    OUT.parent.mkdir(exist_ok=True)
    n_msg, n_grp, errs = 0, 0, []
    t0 = time.time()
    with OUT.open("w", encoding="utf-8") as f:
        for g in groups:
            try:
                rows = pull_group(g)
            except Exception as e:
                errs.append(g); continue
            for r in rows: f.write(json.dumps(r, ensure_ascii=False) + "\n")
            n_msg += len(rows)
            if rows: n_grp += 1
            if len(groups.index(g)+1 if False else []) : pass
            done = groups.index(g) + 1
            if done % 10 == 0:
                print(f"  [{done}/{len(groups)}] msgs={n_msg} ({time.time()-t0:.0f}s)", flush=True)
    print(f"===群消息: {n_msg}条/{n_grp}群活跃 | errs={len(errs)} | {time.time()-t0:.0f}s===")
    if errs: print("err groups:", errs[:5])
    # 朋友圈
    try:
        from soak.moments_miner import fetch_sns
        entries = fetch_sns(limit=200)
        import datetime as dt
        cut = dt.datetime(2026, 10, 25, 0, 45).timestamp()
        fresh = [e for e in entries if (e.get("ts") or 0) >= cut or
                 str(e.get("ts", "")).startswith("2026-10-25") or
                 str(e.get("ts", "")).startswith("2026-10-26")]
        print(f"===朋友圈: {len(entries)}条拉取/{len(fresh)}条25 00:45后===")
        p = ROOT / "outputs" / "rion_pull_1026_sns.json"
        p.write_text(json.dumps(fresh, ensure_ascii=False, indent=1), encoding="utf-8")
        print("sns file:", p)
    except Exception as e:
        print("sns err:", str(e)[:120])

if __name__ == "__main__":
    main()
