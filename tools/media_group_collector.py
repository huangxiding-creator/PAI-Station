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

入池协议（对齐 feishu_files_leg.batch_ingest，1006 补 MEDIA-1 后半程）：
  证据件 ≠ 弹药。落盘后持池锁走 ammo_pool 协议 dedup→judge→manifest 行→state 累计，
  engine="media:36kr"（registry engine_aliases 已归位）。
"""
import json
import subprocess
import sys
import time
from pathlib import Path

BATTLES_ROOT = Path("E:/AI-Station/ResearchFactory-Eng/ResearchTopics")
OPENCLI = Path(r"C:/Users/91216/AppData/Roaming/npm/opencli.cmd")
AMMO_ROOT = Path("E:/AI-Station/ammo_pool")
ENGINE = "media:36kr"
_AP_SEARCH = ["E:/AI-Station/reforge_factory"]  # ammo_pool.py 真身在 reforge_factory（tier_router 同款契约）


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


def _run_article(aid, timeout=180):
    """跑 opencli 36kr article <id> -f md --window background，返回 (rc, stdout)。"""
    r = subprocess.run(
        [str(OPENCLI), "36kr", "article", str(aid), "-f", "md", "--window", "background"],
        capture_output=True, text=True, encoding="utf-8", errors="replace",
        creationflags=0x08000000, timeout=timeout)
    return r.returncode, (r.stdout or "")


def _parse_hits(out):
    """search md 表格 → [{title, url, id}]。表格格式（1006 实测）：
    | 1 | 标题 | 日期 | https://36kr.com/p/2628283988181252 |"""
    hits = []
    for line in out.splitlines():
        s = line.strip()
        if not s.startswith("|") or "36kr.com/p/" not in s:
            continue
        cells = [c.strip() for c in s.strip("|").split("|")]
        if len(cells) < 4:
            continue
        url = next((c for c in cells if "36kr.com/p/" in c), "")
        title = cells[1] if len(cells) > 1 else ""
        if url:
            hits.append({"title": title, "url": url,
                         "id": url.rsplit("/", 1)[-1]})
    return hits


def _parse_article(out):
    """article md field 表格 → (title, body)。格式：| title | 值 | / | body | 全文 |"""
    title, body = "", ""
    for line in out.splitlines():
        s = line.strip()
        if s.startswith("| title |"):
            title = s.strip("|").split("|")[1].strip()
        elif s.startswith("| body |"):
            body = s.split("|", 2)[-1].rsplit("|", 1)[0].strip()
    return title, body


def collect(battle, query=None, limit=3, ammo=None):
    """主入口：搜→取正文→入池→落盘→过账。battle=ResearchTopics 书名目录，ammo=ammo_pool code。"""
    if query is None:
        t = json.loads((AMMO_ROOT / (ammo or battle) / "tiers.json").read_text(encoding="utf-8"))
        query = t["T1"][0]
    rc, out = run_36kr(query, limit)
    hits = _parse_hits(out) if rc == 0 else []
    ts = time.strftime("%Y%m%d_%H%M%S")
    media_dir = BATTLES_ROOT / battle / "04 网络调研搜集的资料" / "媒体组"
    media_dir.mkdir(parents=True, exist_ok=True)
    art = media_dir / f"36kr_{ts}.md"
    ingested = {"ok": 0, "dup": 0, "fetch_fail": 0, "chars": 0}
    parts = []
    for h in hits:
        arc, aout = _run_article(h["id"])
        title, body = _parse_article(aout) if arc == 0 else ("", "")
        if len(body) < 200:
            ingested["fetch_fail"] += 1
            continue
        parts.append(f"## {title or h['title']}\n\n来源: {h['url']}\n\n{body}\n")
        if ammo:
            r = pool_ingest(ammo, art, body, h["url"])
            if r.get("ingested"):
                ingested["ok"] += 1
                ingested["chars"] += r.get("chars", 0)
            else:
                ingested["dup"] += 1
    doc = (f"# 36kr search: {query}\n\n- 工具: opencli 36kr search/article -f md"
           f"\n- 时间: {time.strftime('%Y-%m-%d %H:%M:%S')} rc={rc} 命中={len(hits)}"
           f" 入池={ingested['ok']}({ingested['chars']}字)\n\n---\n\n"
           + ("\n\n".join(parts) if parts else (out.strip() or "(空输出)")) + "\n")
    art.write_text(doc, encoding="utf-8")
    summary = {"battle": battle, "query": query, "rc": rc, "hits": len(hits),
               **ingested, "artifact": str(art)}
    if rc == 0:
        ledger_pass(battle, art, query)
    return summary


def pool_ingest(ammo, artifact, text, url):
    """持池锁入 manifest（dedup→judge→state 累计）。返回 summary dict。"""
    for p in _AP_SEARCH:
        if p not in sys.path:
            sys.path.insert(0, p)
    import ammo_pool as ap  # noqa: E402 — 延迟导入（subprocess 场景无此依赖）
    d = ap._camp_dir(ammo)
    with ap._pool_lock(d):
        keys = ap._manifest_keys(d)
        key = ap.dedup_key(url, text)
        if key in keys or len(text) < 50:
            return {"ingested": 0, "reason": "dup_or_short"}
        verdict, reason = ap.judge_heuristic(
            text, ap._load_state(d).get("kws", []))
        row = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "engine": ENGINE,
               "source_path": str(artifact), "url_norm": ap.norm_url(url),
               "chars": ap.count_chars(text), "credibility": "web",
               "dedup_key": key, "judge": verdict, "judge_reason": reason,
               "judge_engine": "heuristic",
               "grade": ap.GRADE_MAP.get("web", "C"),
               "tree_node": "", "stance": "support"}
        with (d / "manifest.jsonl").open("a", encoding="utf-8") as f:
            f.write(json.dumps(row, ensure_ascii=False) + "\n")
        s = ap._load_state(d)
        vch = row["chars"] if verdict == "valid" else 0
        ns = {**s, "total_chars": s.get("total_chars", 0) + vch,
              "items": s.get("items", 0) + (1 if verdict == "valid" else 0),
              "by_engine": {**s.get("by_engine", {}),
                            ENGINE: s.get("by_engine", {}).get(ENGINE, 0)
                            + vch},
              "domains": [*s.get("domains", []), "36kr.com"][:2000]
              if "36kr.com" not in s.get("domains", []) else s["domains"]}
        ap._save_state(d, ns)
        return {"ingested": 1, "judge": verdict, "reason": reason,
                "chars": row["chars"]}


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
