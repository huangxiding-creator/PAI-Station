# -*- coding: utf-8 -*-
"""语料结构化引擎 (四层研究·第一层) — 用户令 09-22: 存量语料同步开展研究.

把 harvest_sessions/<账号>/<sid>.messages.json 全量解析成:
  analysis/corpus_index.json   每会话一行摘要 (标题/步数/工具序列/搜索词)
  analysis/tool_usage.json     工具名分布 + 全量搜索词库 (调研策略证据)
  analysis/plan_chains.json    计划链集合 (任务规划模式证据)
幂等: 解析结果含源文件 mtime, 变更才重析; 增量续跑.
"""
import json
import sys
import time
from collections import Counter
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ROOT = Path("harvest_sessions")
OUT = Path("analysis")
OUT.mkdir(exist_ok=True)
IDX = OUT / "corpus_index.json"


def tool_brief(ev: dict) -> dict:
    """toolUsed → {tool, param, ok, ts}."""
    msg = ev.get("message") or {}
    tool = ev.get("tool") or "?"
    param = (msg.get("param") or ev.get("brief") or "")[:120]
    return {"t": tool, "p": param, "ts": ev.get("timestamp"),
            "ok": 1 if ev.get("status") == "success" else 0}


def parse_one(path: Path) -> dict:
    d = json.loads(path.read_text(encoding="utf-8"))["data"]
    tools, plans, chats = [], [], 0
    t_first = t_last = None
    for seg in d.get("segments", []):
        for ev in seg.get("events", []):
            et = ev.get("type")
            ts = ev.get("timestamp")
            if ts:
                t_first = ts if t_first is None else min(t_first, ts)
                t_last = ts if t_last is None else max(t_last, ts)
            if et == "toolUsed":
                tools.append(tool_brief(ev))
            elif et == "planUpdate":
                plans.append({
                    "ts": ev.get("timestamp"),
                    "tasks": [{"s": t.get("status"),
                               "title": (t.get("title") or "")[:60]}
                              for t in (ev.get("tasks") or [])]})
            elif et == "chat":
                chats += 1
    # 清洗: 真搜索词只来自 search 族 (browser 的 param 是 URL/操作描述=噪声)
    SEARCH_TOOLS = {"search", "search_scholar", "search_image",
                    "googleSearch", "webSearch", "knowledgeSearch"}
    searches = [t for t in tools if t["t"] in SEARCH_TOOLS]
    browses = [t for t in tools if t["t"] == "browser"]
    dur_min = ((t_last - t_first) / 60000) if t_first and t_last else 0
    return {
        "sid": d.get("id"),
        "title": (d.get("title") or "")[:80],
        "dur_min": round(dur_min),
        "n_tools": len(tools),
        "n_plans": len(plans),
        "n_chats": chats,
        "tool_seq": [t["t"] for t in tools][:400],
        "searches": [{"q": t["p"], "ts": t["ts"], "ok": t["ok"]}
                     for t in searches][:150],
        "n_browse": len(browses),
        "plan_final": plans[-1]["tasks"] if plans else [],
        "account_dir": path.parent.name,
    }


def main():
    files = sorted(ROOT.glob("*/*.messages.json"))
    print(f"[parse] 待析 {len(files)} 会话文件", flush=True)
    idx = {}
    if IDX.exists():
        idx = json.loads(IDX.read_text(encoding="utf-8"))
        if isinstance(idx, dict) and "sessions" in idx:
            idx = idx["sessions"]
    seen_sids = set()
    t0 = time.time()
    for i, p in enumerate(files, 1):
        try:
            sid_part = p.name.split(".")[0]
            key = f"{p.parent.name}/{sid_part}"
            if key in idx and idx[key].get("_mtime") == p.stat().st_mtime:
                seen_sids.add(idx[key].get("sid"))
                continue
            rec = parse_one(p)
            rec["_mtime"] = p.stat().st_mtime
            if rec["sid"] in seen_sids:  # 共享会话多副本去重标记
                rec["_dup"] = True
            seen_sids.add(rec["sid"])
            idx[key] = rec
        except Exception as e:
            idx[f"{p.parent.name}/{p.name}"] = {"_err": f"{type(e).__name__}"}
        if i % 50 == 0:
            print(f"[parse] {i}/{len(files)} ({time.time()-t0:.0f}s)",
                  flush=True)

    uniq = {k: v for k, v in idx.items() if not v.get("_dup")}
    tool_counter = Counter()
    all_searches = []
    for v in uniq.values():
        for t in v.get("tool_seq", []):
            tool_counter[t] += 1
        all_searches.extend(v.get("searches", []))

    IDX.write_text(json.dumps(
        {"generated": time.strftime("%Y-%m-%d %H:%M"),
         "sessions": idx}, ensure_ascii=False), encoding="utf-8")
    (OUT / "tool_usage.json").write_text(json.dumps({
        "tool_distribution": tool_counter.most_common(),
        "search_terms": all_searches,
    }, ensure_ascii=False, indent=1), encoding="utf-8")
    (OUT / "plan_chains.json").write_text(json.dumps(
        {k: [p["tasks"] for p in []] or v.get("plan_final")
         for k, v in uniq.items() if v.get("plan_final")},
        ensure_ascii=False), encoding="utf-8")

    n_ok = len([1 for v in uniq.values() if not v.get("_err")])
    print(f"[parse] 完成: 会话 {n_ok} (去重后) | 工具调用 "
          f"{sum(tool_counter.values())} | 搜索词 {len(all_searches)} "
          f"| 用时 {time.time()-t0:.0f}s", flush=True)
    print("[parse] 产出: analysis/corpus_index.json + tool_usage.json "
          "+ plan_chains.json", flush=True)


if __name__ == "__main__":
    main()
