# -*- coding: utf-8 -*-
"""webhook 事件收割器 — ECS 增量拉取 + 分类处置 (0923).

事件契约: task_stopped{stop_reason: finish|ask, attachments[{file_name,url}]}.
处置:
  - test 事件 (task_id=test_task_id) → 计数忽略
  - finish + attachments → 直接下载成果到 harvest_sessions/hook_files/<acct>/
  - ask → 登记 pending_questions.json (等用户/后续自动回复)
  - 重大完成 (attachments>=1) → 企微通知 (限频: 每轮最多 1 条汇总)
状态: data/hook_harvest_state.json 记已处理行数; 幂等可重跑.
用法: python hook_harvest.py [--loop 300]
"""
import argparse
import json
import sys
import time
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
SECRET = Path("data/hook_secret.txt").read_text(encoding="utf-8").strip()
EV_URL = f"http://47.120.43.20:8890/ev/{SECRET}"
STATE = Path("data/hook_harvest_state.json")
OUT_FILES = Path("harvest_sessions/hook_files")
PENDING_Q = Path("harvest_sessions/pending_questions.json")
# ---- F1 缺口树收成入池 (1010 接线令) ----
F1_TREE = Path(r"E:\AI-Station\_proposals\flagship-paid-report-1007"
               r"\work\f1_gap_tree_v2.json")
F1_POOL = "F1-BLUEBOOK"
F1_FAIL = Path("data/f1_land_failures.jsonl")


def load_state() -> int:
    if STATE.is_file():
        try:
            return json.loads(STATE.read_text(encoding="utf-8"))["after"]
        except Exception:
            return 0
    return 0


def save_state(after: int) -> None:
    STATE.write_text(json.dumps({"after": after, "ts": time.ctime()}),
                     encoding="utf-8")


def pull_events(after: int) -> tuple[int, list]:
    """拉增量 → (新after, 事件列表). 网络失败返回原 after."""
    op = urllib.request.build_opener()  # 境内 ECS 直连
    try:
        r = op.open(f"{EV_URL}?after={after}&limit=300", timeout=15)
        d = json.loads(r.read().decode("utf-8"))
        lines = d.get("lines", [])
        # 事件稀疏: total 行数为准推进 offset (跳过已删行风险低, jsonl 只增)
        return after + len(lines), [json.loads(x) for x in lines if x.strip()]
    except Exception as e:
        print(f"[pull] 失败 {type(e).__name__}, 下轮重试", flush=True)
        return after, []


def download_attachment(url: str, dest: Path) -> bool:
    """成果文件直下 (manuscdn 直链, 不需要登录态)."""
    op = urllib.request.build_opener(urllib.request.ProxyHandler(
        {"https": "http://127.0.0.1:7890"}))
    try:
        req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
        data = op.open(req, timeout=60).read()
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_bytes(data)
        return True
    except Exception as e:
        print(f"  [dl-fail] {dest.name} {type(e).__name__}", flush=True)
        return False


def _tier_persist(ap) -> dict:
    """tier_report 分层账写回 pool_state (collection_gate 真源键)."""
    tr = ap.tier_report(F1_POOL)
    d = ap._camp_dir(F1_POOL)
    with ap._pool_lock(d):
        s = ap._load_state(d)
        ns = {**s, "t1_chars": tr["t1"], "t2_chars": tr["t2"],
              "t3_chars": tr["t3"], "t0_chars": tr["t0"],
              "gate_chars": tr["gate_chars"], "tier_gate_ok": tr["gate_ok"],
              "last_tier_persist": time.strftime("%Y-%m-%d %H:%M")}
        ap._save_state(d, ns)
    return tr


def f1_land(acct: str, sid: str, landed: list) -> None:
    """F1 树收成入池: sid 命中树问 → F1-BLUEBOOK (engine=manus:corps,
    tree=问id) → judge → 树问 harvested + chars/sources 落账 + 分层键持久化。

    fail-soft: 异常只登记 f1_land_failures.jsonl (--reland 重放),
    绝不断下载主链 — 收成文件已在盘, 池账可事后补。
    """
    try:
        sys.path.insert(0, r"E:\AI-Station\reforge_factory")
        import ammo_pool as ap
        sys.path.insert(0, r"E:\AI-Station\_proposals"
                        r"\flagship-paid-report-1007\work")
        import f1_pool_build as fpb                    # 词表真源 (自愈 init)
        tree = json.loads(F1_TREE.read_text(encoding="utf-8"))
        hit = next(((tp, q) for tp in tree.get("topics", [])
                    for q in tp.get("questions", [])
                    if q.get("sid") == sid), None)
        if hit is None:
            return                                    # 非 F1 树任务, 不动
        tp, q = hit
        d = ap._camp_dir(F1_POOL)
        _st = ap._load_state(d) if (d / "pool_state.json").is_file() else {}
        if not _st.get("kws"):                         # 池缺失/词表空都自愈
            s = ap._load_state(d)
            ap._save_state(d, {**s, "campaign": F1_POOL,
                               "kws": ap.parse_kws(fpb.KWS)})
            (d / "tiers.json").write_text(
                json.dumps(fpb.TIERS, ensure_ascii=False, indent=1),
                encoding="utf-8")
            print(f"  [f1-pool] 池缺失已自愈 init {F1_POOL}", flush=True)
        chars = sources = 0
        for fp in landed:
            p = Path(fp)
            if not p.is_file():
                continue
            text = ap.read_text_safe(p)
            if len(text) < 50 or ap.is_snippet_only(text, "manus:corps")[0]:
                continue
            if ap.ingest(F1_POOL, file=str(p), engine="manus:corps",
                         cred="research", tree=q["id"]) != 0:
                continue
            in_pool = any(
                json.loads(x).get("source_path") == str(p) for x in
                (d / "manifest.jsonl").read_text(encoding="utf-8")
                .splitlines() if x.strip())
            if not in_pool:                           # 只对真入池件计数
                continue
            chars += ap.count_chars(text)
            sources += 1
        if not sources:
            return
        ap.judge(F1_POOL, limit=0)
        _tier_persist(ap)
        q["status"] = "harvested"
        q["chars"] = int(q.get("chars", 0)) + chars
        q["sources"] = int(q.get("sources", 0)) + sources
        q["harvested_at"] = time.strftime("%Y-%m-%dT%H:%M:%S")
        tmp = F1_TREE.with_suffix(".tmp")
        tmp.write_text(json.dumps(tree, ensure_ascii=False, indent=1),
                       encoding="utf-8")
        tmp.replace(F1_TREE)
        print(f"  [f1-pool] {q['id']} +{chars:,}字/{sources}件 "
              f"→ {F1_POOL}", flush=True)
    except Exception as e:
        rec = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "acct": acct,
               "sid": sid, "paths": [str(x) for x in landed],
               "err": f"{type(e).__name__}: {e}"}
        with F1_FAIL.open("a", encoding="utf-8") as f:
            f.write(json.dumps(rec, ensure_ascii=False) + "\n")
        print(f"  [f1-pool] 失败已登记 (python hook_harvest.py --reland "
              f"重放): {type(e).__name__}: {e}", flush=True)


def f1_reland() -> int:
    """重放登记在案的入池失败 (文件已在盘, 只补池账+树账)."""
    if not F1_FAIL.is_file():
        print("[reland] 无失败记录")
        return 0
    n = 0
    keep = []
    for ln in F1_FAIL.read_text(encoding="utf-8").splitlines():
        if not ln.strip():
            continue
        r = json.loads(ln)
        try:
            f1_land(r["acct"], r["sid"], r["paths"])
            n += 1
        except Exception:
            keep.append(ln)
    F1_FAIL.write_text("\n".join(keep) + ("\n" if keep else ""),
                       encoding="utf-8")
    print(f"[reland] 重放 {n} 条, 残留 {len(keep)} 条")
    return 0


def process_once() -> dict:
    after = load_state()
    new_after, events = pull_events(after)
    stats = {"test": 0, "finish": 0, "ask": 0, "files": 0, "dl_ok": 0}
    for ev in events:
        acct = ev.get("acct", "?")
        detail = (ev.get("event") or {}).get("task_detail", {})
        if detail.get("task_id") == "test_task_id":
            stats["test"] += 1
            continue
        reason = detail.get("stop_reason", "?")
        if reason == "finish":
            stats["finish"] += 1
            landed = []
            for att in detail.get("attachments") or []:
                stats["files"] += 1
                name = (att.get("file_name") or "unnamed")[:100]
                dest = OUT_FILES / acct / name
                if dest.is_file() and dest.stat().st_size == att.get("size_bytes"):
                    landed.append(dest)   # 幂等: 已在盘也参与入池判定
                    continue
                if download_attachment(att.get("url", ""), dest):
                    stats["dl_ok"] += 1
                    landed.append(dest)
                    print(f"  [dl] {acct}/{name}", flush=True)
            if landed:
                f1_land(acct, detail.get("task_id", ""), landed)
        elif reason == "ask":
            stats["ask"] += 1
            pend = json.loads(PENDING_Q.read_text(encoding="utf-8")) if PENDING_Q.is_file() else {}
            pend[f"{acct}::{detail.get('task_id')}"] = {
                "title": detail.get("task_title", ""),
                "message": detail.get("message", "")[:300],
                "ts": ev.get("recv_ts", ""),
                "question": (detail.get("question_expectation") or {}),
            }
            PENDING_Q.write_text(json.dumps(pend, ensure_ascii=False, indent=1),
                                 encoding="utf-8")
    if new_after > after:
        save_state(new_after)
    return stats


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--loop", type=int, default=0,
                    help="循环间隔秒 (默认单次)")
    ap.add_argument("--reland", action="store_true",
                    help="重放 f1 入池失败记录后退出")
    args = ap.parse_args()
    if args.reland:
        f1_reland()
        return
    while True:
        s = process_once()
        if any(s.values()):
            print(f"[harvest] {json.dumps(s, ensure_ascii=False)}", flush=True)
        else:
            print(f"[harvest] 无新事件", flush=True)
        if not args.loop:
            break
        time.sleep(args.loop)


if __name__ == "__main__":
    main()
