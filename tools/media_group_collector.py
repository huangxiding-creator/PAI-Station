# -*- coding: utf-8 -*-
"""media_group_collector——MEDIA-1 工单：36kr public 线搜索 stdout → 落盘 + 账本过账。

W8 教训（1006）：opencli 36kr search rc=0 但 stdout 不落池=假绿，media_group 因此
未开 auto_dispatch。本 collector 补上「输出转 pending 入池」的缺环：

  opencli 36kr search <词> --limit N -f md
    → CREATE_NO_WINDOW 子进程（windows-no-popup 铁律）
    → 证据件落 ResearchTopics/<battle>/04 网络调研搜集的资料/媒体组/36kr_<ts>.md
    → 账本 channel_ledger.json media_group.artifacts 追加 + ts 刷新
    → stdout 末行 JSON summary（机读）

账号安全：36kr search = public 线无登录面（登录墙线 weibo/zhihu 不在本腿范围）。
"""
import json
import subprocess
import sys
import time
from pathlib import Path

BATTLES_ROOT = Path("E:/AI-Station/ResearchFactory-Eng/ResearchTopics")
OPENCLI = Path(r"C:/Users/91216/AppData/Roaming/npm/opencli.cmd")
AMMO_ROOT = Path("E:/AI-Station/ammo_pool")


def _p(msg):
    try:
        print(msg, flush=True)
    except Exception:
        pass


def run_36kr(query, limit=3, timeout=120):
    """跑 opencli 36kr search，返回 (rc, stdout)。CREATE_NO_WINDOW 不弹窗。"""
    r = subprocess.run(
        [str(OPENCLI), "36kr", "search", query, "--limit", str(limit), "-f", "md"],
        capture_output=True, text=True, encoding="utf-8", errors="replace",
        creationflags=0x08000000, timeout=timeout)
    return r.returncode, (r.stdout or "")


def collect(battle, query=None, limit=3, ammo=None):
    """主入口：搜→落盘→过账。battle=ResearchTopics 书名目录，ammo=ammo_pool 战役 code。"""
    if query is None:
        t = json.loads((AMMO_ROOT / (ammo or battle) / "tiers.json").read_text(encoding="utf-8"))
        query = t["T1"][0]
    rc, out = run_36kr(query, limit)
    ts = time.strftime("%Y%m%d_%H%M%S")
    media_dir = BATTLES_ROOT / battle / "04 网络调研搜集的资料" / "媒体组"
    media_dir.mkdir(parents=True, exist_ok=True)
    art = media_dir / f"36kr_{ts}.md"
    body = out.strip() or "(空输出)"
    art.write_text(
        f"# 36kr search: {query}\n\n- 工具: opencli 36kr search --limit {limit} -f md"
        f"\n- 时间: {time.strftime('%Y-%m-%d %H:%M:%S')} rc={rc}\n\n---\n\n{body}\n",
        encoding="utf-8")
    hits = out.count("36kr.com/p/") if rc == 0 else 0  # md 表格行格式（1006 实测）
    summary = {"battle": battle, "query": query, "rc": rc, "hits_heuristic": hits,
               "artifact": str(art), "bytes": len(body.encode("utf-8"))}
    if rc == 0:
        ledger_pass(battle, art, query)
    return summary


def ledger_pass(battle, artifact, query):
    """账本 media_group 条目追加 artifacts + 刷新 ts（幂等：只追加新件）。"""
    led = BATTLES_ROOT / battle / "_pipeline" / "channel_ledger.json"
    if not led.exists():
        _p(f"[ledger] 账本不存在，跳过过账（诚实：无账本不造）: {led}")
        return
    data = json.loads(led.read_text(encoding="utf-8"))
    mg = (data.get("channels") or {}).get("media_group")
    if mg is None:
        _p("[ledger] 无 media_group 条目，跳过（须先有首过账记录）")
        return
    arts = mg.setdefault("artifacts", [])
    rel = str(artifact)
    if rel not in arts:
        arts.append(rel)
    mg["status"] = "done"
    mg["ts"] = time.strftime("%Y-%m-%d %H:%M:%S")
    ev = mg.setdefault("evidence", "")
    if "36kr" not in ev:
        mg["evidence"] = (ev + "; " if ev else "") + "36kr public 线 collector 复跑"
    led.write_text(json.dumps(data, ensure_ascii=False, indent=2), encoding="utf-8")


def main(argv=None):
    import argparse
    ap = argparse.ArgumentParser(description="36kr public 线落池 collector (MEDIA-1)")
    ap.add_argument("--battle", required=True, help="ResearchTopics 书名目录")
    ap.add_argument("--ammo", default=None, help="ammo_pool 战役 code（默认同 battle）")
    ap.add_argument("--query", default=None, help="默认取 tiers.json T1 首词")
    ap.add_argument("--limit", type=int, default=3)
    a = ap.parse_args(argv)
    s = collect(a.battle, a.query, a.limit, ammo=a.ammo)
    _p("[SUMMARY] " + json.dumps(s, ensure_ascii=False))
    return 0 if s["rc"] == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
