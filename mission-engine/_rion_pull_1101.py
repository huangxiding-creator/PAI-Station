# -*- coding: utf-8 -*-
"""RadarCycle 1101 末巡补源件: night_shift N0撞glm拥堵零进展被TaskStop(断点安全) → rion直拉增量+朋友圈, 供值守亲自JTBD研判(1026判例复刻)"""
import json, os, re, subprocess, sys, time
from pathlib import Path

ROOT = Path(__file__).resolve().parent
W24 = Path(r"E:/AI-Station/wechat-24h-ops")
sys.path.insert(0, str(W24))
sys.path.insert(0, r"E:/AI-Station/WeChat-Report")
RION = r"E:\AI-Station\vendor\wechat-intelligence-hub\rion-cli.cmd"
OUT = ROOT / "outputs" / "rion_pull_1101.jsonl"
SINCE = "2026-10-31 14:10"   # 上轮夜班N2收官(14:08)=未扫窗口起点

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
    print(f"groups={len(groups)} since={SINCE}", flush=True)
    OUT.parent.mkdir(exist_ok=True)
    n_msg, n_grp, errs, done = 0, 0, [], 0
    t0 = time.time()
    with OUT.open("w", encoding="utf-8") as f:
        for g in groups:
            done += 1
            try:
                rows = pull_group(g)
            except Exception:
                errs.append(g); continue
            for r in rows: f.write(json.dumps(r, ensure_ascii=False) + "\n")
            n_msg += len(rows)
            if rows: n_grp += 1
            if done % 10 == 0:
                print(f"  [{done}/{len(groups)}] msgs={n_msg} ({time.time()-t0:.0f}s)", flush=True)
    print(f"===群消息: {n_msg}条/{n_grp}群活跃 | errs={len(errs)} | {time.time()-t0:.0f}s===", flush=True)
    if errs: print("err groups:", errs[:5], flush=True)
    # 朋友圈
    try:
        from soak.moments_miner import fetch_sns
        entries = fetch_sns(limit=200)
        import datetime as dt
        cut = dt.datetime(2026, 10, 31, 14, 10).timestamp()
        fresh = [e for e in entries if (e.get("ts") or 0) >= cut or
                 str(e.get("ts", "")).startswith("2026-10-31 1") or
                 str(e.get("ts", "")).startswith("2026-10-31 2") or
                 str(e.get("ts", "")).startswith("2026-11-01")]
        print(f"===朋友圈: {len(entries)}条拉取/{len(fresh)}条10-31 14:10后===", flush=True)
        p = ROOT / "outputs" / "rion_pull_1101_sns.json"
        p.write_text(json.dumps(fresh, ensure_ascii=False, indent=1), encoding="utf-8")
        print("sns file:", p, flush=True)
    except Exception as e:
        print("sns err:", str(e)[:120], flush=True)

if __name__ == "__main__":
    main()
