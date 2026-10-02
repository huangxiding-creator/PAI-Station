# -*- coding: utf-8 -*-
"""EPC50 军团成果及时收割器 — 纯 token API 轮询 (0924, 用户令: 及时搜集).

背景: webhook 只覆盖旧 56 账号 (昨日派单 28 账号仅 1 个在覆盖内),
session_harvester 浏览器版与军团共用 9333 会打架 → 本件纯 urllib
token 直调 (免疫 web 区域墙), 与军团并行.

源: data/epc50_corps_log.jsonl 派发留痕 (email/sid/q/topic).
流: 每轮 ListSessions(按账号1次) → 终态 sid 拉 files+v2 →
    成果直落战场 04/35_Manus军团/<qid|tid>__<filename> (md 天然合规),
    原始 json 落 harvest_sessions/epc50/ (金矿, 只增不删).
断点: data/epc50_collect_manifest.json (sid→state); 幂等重跑.
节奏: API 间 1.5s, 账号间 3s; --loop 600 常驻 (新派单自动跟进).
"""
import argparse
import io
import json
import sys
import time
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")
import manus_api as api

CORPS_LOG = Path("data/epc50_corps_log.jsonl")
MANIFEST = Path("data/epc50_collect_manifest.json")
RAW_ROOT = Path("harvest_sessions/epc50")
BATTLE = Path(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics"
              r"\《中石化南京工程有限公司怎么干EPC总承包？》")
OUT_DIR = BATTLE / "04 网络调研搜集的资料" / "35_Manus军团"
# 多战役路由 (0930 #49 起): corps_log 行带 battle 字段 — epc49 落四川院
# 战场, 其余/缺省落 #50 (向后兼容). 金矿 raw 同步分目录 (只增不删).
BATTLE_49 = Path(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics"
                 r"\《四川电力设计咨询有限责任公司怎么干EPC总承包？》")
OUT_49 = BATTLE_49 / "02 初次网络调研" / "35_Manus军团"
RAW_49 = Path("harvest_sessions/epc49")

TERMINAL_KEYS = ("stopped", "error", "completed", "finished", "failed")
RUNNING_KEYS = ("running", "pending", "queued", "working", "generating",
                "waiting")


def _is_terminal(stt: str) -> bool:
    return any(k in stt for k in TERMINAL_KEYS)


def _is_running(stt: str) -> bool:
    return any(k in stt for k in RUNNING_KEYS)


def load_manifest() -> dict:
    if MANIFEST.is_file():
        try:
            return json.loads(MANIFEST.read_text(encoding="utf-8"))
        except Exception:
            pass
    return {"collected": {}, "stale_tokens": []}


def save_manifest(m: dict) -> None:
    MANIFEST.write_text(json.dumps(m, ensure_ascii=False, indent=1),
                        encoding="utf-8")


def load_tasks() -> list[dict]:
    if not CORPS_LOG.is_file():
        return []
    out = []
    for line in CORPS_LOG.read_text(encoding="utf-8").splitlines():
        if line.strip():
            out.append(json.loads(line))
    return out


def download(url: str, dest: Path) -> bool:
    """manuscdn 直链下载 (免登录, 走 7890)."""
    import urllib.request
    op = urllib.request.build_opener(urllib.request.ProxyHandler(
        {"https": "http://127.0.0.1:7890",
         "http": "http://127.0.0.1:7890"}))
    try:
        r = op.open(url, timeout=60)
        dest.write_bytes(r.read())
        return True
    except Exception as e:
        print(f"    [dl✗] {dest.name}: {type(e).__name__}", flush=True)
        return False


def collect_sid(email: str, sid: str, tag: str, tok: dict, m: dict,
                raw_root: Path = RAW_ROOT,
                out_dir: Path = OUT_DIR) -> str:
    """拉一个终态会话: files 下载 + v2 金矿. 返回终态登记值."""
    safe = email.replace("@", "_at_").replace(":", "_")
    raw_dir = raw_root / safe
    raw_dir.mkdir(parents=True, exist_ok=True)
    out_dir.mkdir(parents=True, exist_ok=True)

    st, text = api.get_files(None, tok, sid)
    if st != 200:
        return f"files_http_{st}"
    (raw_dir / f"{sid}.files.json").write_text(text, encoding="utf-8")
    st2, text2 = api.get_session_v2(None, tok, sid)
    if st2 == 200:
        (raw_dir / f"{sid}.v2.json").write_text(text2, encoding="utf-8")

    n_ok = n_all = 0
    try:
        d = json.loads(text)
        for f in d.get("data", {}).get("files", []) or []:
            for r in f.get("raw", []) or []:
                n_all += 1
                url = r.get("url")
                name = (r.get("filename") or r.get("name")
                        or f"{sid}_file{n_all}")
                dest = out_dir / f"{tag}__{name}"
                if dest.exists() and dest.stat().st_size > 0:
                    n_ok += 1
                    continue
                if url and download(url, dest):
                    n_ok += 1
    except Exception as e:
        print(f"    [parse✗] {sid}: {type(e).__name__}", flush=True)
    print(f"  [✓] {tag} {sid[:10]} 文件 {n_ok}/{n_all}", flush=True)
    return "done" if n_all == 0 or n_ok == n_all else "partial"


def sweep(m: dict) -> None:
    tasks = load_tasks()
    m["collected"].pop("_stat", None)
    todo = [t for t in tasks
            if m["collected"].get(t["sid"]) not in ("done", "partial")]
    by_acct: dict[str, list[dict]] = {}
    for t in todo:
        by_acct.setdefault(t["email"], []).append(t)
    stat = {"done": 0, "partial": 0, "running": 0, "wait": 0,
            "stale": 0, "err": 0}
    for done_state in m["collected"].values():
        if done_state in stat:
            stat[done_state] += 1
    print(f"[sweep {time.strftime('%H:%M:%S')}] 待收 {len(todo)} 单 "
          f"/ {len(by_acct)} 账号 | 已收 {stat['done']}+{stat['partial']}",
          flush=True)
    for email, ts in by_acct.items():
        tok = api.load_token(email)
        if tok is None:
            for t in ts:
                m["collected"][t["sid"]] = "no_token"
            continue
        if email in m.get("stale_tokens", []):
            continue
        try:
            sessions = api.list_sessions(None, tok)
        except RuntimeError as e:
            msg = str(e)
            if "401" in msg or "403" in msg:
                m.setdefault("stale_tokens", []).append(email)
                for t in ts:
                    m["collected"][t["sid"]] = "stale_token"
                stat["stale"] += len(ts)
                print(f"  [token✗] {email}: 凭证失效, 登记待刷", flush=True)
            else:
                for t in ts:
                    m["collected"][t["sid"]] = "err_list"
                stat["err"] += len(ts)
                print(f"  [list✗] {email}: {msg[:60]}", flush=True)
            save_manifest(m)
            time.sleep(3)
            continue
        smap = {s.get("uid") or s.get("id"): (s.get("status") or "?").lower()
                for s in sessions}
        for t in ts:
            stt = smap.get(t["sid"], "?")
            tag = t.get("q") or t.get("topic") or "T?"
            if _is_terminal(stt):
                b49 = t.get("battle") == "epc49"
                state = collect_sid(email, t["sid"], str(tag), tok, m,
                                    raw_root=RAW_49 if b49 else RAW_ROOT,
                                    out_dir=OUT_49 if b49 else OUT_DIR)
                if "error" in stt:
                    state = "error_task_" + state
                m["collected"][t["sid"]] = state
                stat["done" if state == "done" else "partial"] = \
                    stat.get("done" if state == "done" else "partial", 0) + 1
            elif _is_running(stt):
                stat["running"] += 1
            else:  # 未知态 (含 ask/waiting_reply) — 不登记, 下轮再看
                stat["wait"] += 1
                if stt not in ("?",):
                    print(f"  [?] {tag} {t['sid'][:10]} status={stt}",
                          flush=True)
            time.sleep(1.5)
        save_manifest(m)
        time.sleep(3)
    print(f"[sweep 完] {json.dumps(stat, ensure_ascii=False)}", flush=True)


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--loop", type=int, default=0,
                    help="常驻轮询间隔秒 (0=单轮)")
    args = ap.parse_args()
    m = load_manifest()
    while True:
        try:
            sweep(m)
        except Exception as e:  # noqa: BLE001 — 单轮失败不拖常驻
            print(f"[sweep EXC] {type(e).__name__}: {str(e)[:80]}",
                  flush=True)
        if not args.loop:
            break
        time.sleep(args.loop)
    return 0


if __name__ == "__main__":
    sys.exit(main())
