# -*- coding: utf-8 -*-
"""bid26_ingest v2 — EPC-BID26 战役池常驻增量切割器（1014 RSS 直连腿）。

每 30min 由计划任务 BID26-Ingest 调起：
  ① 直连腿：data/rss_harvest/articles 逐日目录按 mtime>水位线切 T1 词双筛（文件名+内容头）
    —— 1014 修复：F1CrossIngest 中转任务被清理波删除后断链，此腿去依赖
  ② 中转腿保留：F1 manifest 新行（若 F1CrossIngest 任务重建则双保险）
  ③ judge 新入池件；水位推进（RSS:ISO时刻）
红线：只增不删（1013 清理纪律）；失败留痕不轰炸。
"""
import datetime
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")

F1 = Path(r"E:\AI-Station\ammo_pool\F1-BLUEBOOK\manifest.jsonl")
WM = Path(r"E:\AI-Station\data\state\bid26_watermark.txt")
RSS = Path(r"E:\AI-Station\data\rss_harvest\articles")
T1 = ["招投标", "招标", "投标", "评标", "定标", "围标", "串标", "陪标", "中标", "否决投标",
      "招标代理", "投标保证金", "最高投标限价", "模拟清单", "两阶段", "信用评价",
      "行政处罚", "资质", "合规"]


def main() -> int:
    wm = WM.read_text(encoding="utf-8").strip() if WM.exists() else ""
    wm_dt = None
    if wm.startswith("RSS:"):
        try:
            wm_dt = datetime.datetime.fromisoformat(wm[4:])
        except Exception:
            wm_dt = None
    max_dt = wm_dt or datetime.datetime.min
    items, seen = [], set()
    n_new = 0

    # ── 直连腿：rss_harvest ──
    if RSS.exists():
        for day_dir in sorted(RSS.iterdir()):
            if not day_dir.is_dir():
                continue
            for f in day_dir.glob("*.md"):
                try:
                    mt = datetime.datetime.fromtimestamp(f.stat().st_mtime)
                except Exception:
                    continue
                if mt > max_dt:
                    max_dt = max(max_dt, mt)
                if wm_dt and mt <= wm_dt:
                    continue
                n_new += 1
                if not any(k in f.stem for k in T1):
                    try:
                        head = f.read_text(encoding="utf-8", errors="ignore")[:600]
                    except Exception:
                        continue
                    if not any(k in head for k in T1):
                        continue
                if str(f) in seen:
                    continue
                seen.add(str(f))
                items.append({"file": str(f), "engine": "rss:bid26direct", "cred": "media"})

    # ── 中转腿：F1 manifest（水位按旧 ts 语义兼容）──
    f1_wm = wm[4:] if wm.startswith("RSS:") else wm
    if F1.exists():
        for line in F1.open(encoding="utf-8"):
            try:
                d = json.loads(line)
            except Exception:
                continue
            ts = d.get("ts") or ""
            if ts <= f1_wm:
                continue
            sp = d.get("source_path") or ""
            dk = d.get("dedup_key") or sp
            if dk in seen or not sp or not Path(sp).exists():
                continue
            if not any(k in Path(sp).stem for k in T1):
                try:
                    head = Path(sp).read_text(encoding="utf-8", errors="ignore")[:600]
                except Exception:
                    continue
                if not any(k in head for k in T1):
                    continue
            seen.add(dk)
            items.append({"file": sp, "engine": "cross:bid26auto", "cred": d.get("credibility") or "media"})

    if items:
        from ammo_pool import ingest_files
        ok, skip = ingest_files("EPC-BID26", items)
        print(f"[bid26] +{ok} 件 (跳 {skip})")
        import subprocess
        r = subprocess.run([sys.executable, r"E:\AI-Station\reforge_factory\ammo_pool.py",
                            "judge", "EPC-BID26", "--limit", "3000"],
                           capture_output=True, text=True, timeout=900)
        print((r.stdout or "").strip().splitlines()[-1] if r.stdout else "judge done")
    else:
        print(f"[bid26] 无新增（RSS 扫描 {n_new} 文件，相关 0）")

    if max_dt > datetime.datetime.min:
        WM.parent.mkdir(parents=True, exist_ok=True)
        WM.write_text("RSS:" + max_dt.isoformat(timespec="seconds"), encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
