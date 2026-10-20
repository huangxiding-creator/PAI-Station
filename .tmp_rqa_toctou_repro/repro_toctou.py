# -*- coding: utf-8 -*-
"""Independent code-repro for review finding: report_ask TOCTOU on the unified quota pool.

Claim under test (app.py:1095-1103, commit 23a48173):
  gate `if unified_left <= 0` and `store.consume_one(openid)` are separate _LOCK
  critical sections; consume_one's False return is discarded, so a concurrent
  same-user burst passes the gate while 1 remains and gets served beyond
  FREE_PER_DAY (6/day).

Only externals are stubbed (report_catalog / report_qa / zhipu). The entire
quota machinery (store._LOCK, quota_left, consume_one, sqlite) is REAL and
unpatched. Legs:
  1. deterministic scheduled interleave (threads synchronized exactly at
     lock-free points that exist in production code)
  2. natural race scan (2 threads at a barrier, zero patching of store)
  3. full HTTP through a real in-process uvicorn server (FastAPI threadpool
     serving path, same as production single-worker uvicorn deployment)
"""
from __future__ import annotations

import json
import os
import sqlite3
import sys
import tempfile
import threading
import time
import urllib.error
import urllib.request
from pathlib import Path

TMP = Path(tempfile.mkdtemp(prefix="qw_toctou_"))
os.environ["DATA_DIR"] = str(TMP)
os.environ["SECRETS_DIR"] = str(TMP)
os.environ["DB_KIND"] = "sqlite"
sys.path.insert(0, r"E:\AI-Station\services\qianwen-engine")

from qianwen_engine import config, store, wechat, report_catalog, report_qa, zhipu  # noqa: E402
from qianwen_engine import app as qwapp  # noqa: E402

U = "toctou-user"
SKU = "SKU-TOCTOU"

# real HMAC token via the real issue/verify pair (key file lands in TMP)
TOKEN = wechat.issue_token(U)

# ── stub externals only ─────────────────────────────────────────
report_catalog.get_report = lambda sku: {"title": "测试报告"}
report_qa.retrieve = lambda sku, q: ([{"no": 1, "title": "第一章", "desc": "描述"}], True)
zhipu.deep_answer = lambda *a, **k: "结论：这是满分测试结论。\n第1章：测试依据文本。"

print(f"python={sys.version.split()[0]}  FREE_PER_DAY={config.FREE_PER_DAY}  DB={config.DB_PATH}")


def free_used() -> int:
    with sqlite3.connect(config.DB_PATH) as c:
        return c.execute("SELECT free_used FROM users WHERE openid=?", (U,)).fetchone()[0]


def seed_left_one() -> None:
    """User in registry with free_used=5/6, no bonus -> exactly 1 left."""
    store.quota_left(U)  # ensure row + today's quota_day
    with sqlite3.connect(config.DB_PATH) as c:
        c.execute(
            "UPDATE users SET free_used=?, bonus_earned=0, bonus_used=0 WHERE openid=?",
            (config.FREE_PER_DAY - 1, U))
    assert free_used() == config.FREE_PER_DAY - 1


class FakeReq:
    headers = {"Authorization": f"Bearer {TOKEN}"}


def call_route(tag: str, out: list) -> None:
    try:
        r = qwapp.report_ask(SKU, qwapp.ReportAskIn(q=f"并发双击提问{tag}"), FakeReq())
        if type(r).__name__ == "JSONResponse":
            out.append((tag, r.status_code, None))
        else:
            out.append((tag, 200, bool(r.get("conclusion")), r.get("left")))
    except Exception as e:  # HTTPException etc.
        out.append((tag, getattr(e, "status_code", "exc"), None))


# ══ Leg 1: deterministic scheduled interleave ═══════════════════
print("\n== Leg 1: scheduled interleave (T2 gate read forced between T1 gate and T1 consume) ==")
seed_left_one()

orig_quota_left = store.quota_left
orig_consume = store.consume_one
consume_returns: list = []
t1_in_pre = threading.Event()
t2_gate_done = threading.Event()
counts = {"T1": 0, "T2": 0}


def sched_quota_left(openid):
    """Delegate to the real quota_left; synchronize threads ONLY at lock-free
    points that genuinely exist in app.py (between line 1095 gate and 1102 pre
    and 1103 consume no lock is held)."""
    tag = threading.current_thread().name
    counts[tag] = counts.get(tag, 0) + 1
    n = counts[tag]
    if tag == "T1" and n == 2:          # T1 executing line 1102 `pre = store.quota_left(...)`
        t1_in_pre.set()
        t2_gate_done.wait(timeout=5)    # let T2 finish its line-1095 gate read
    r = orig_quota_left(openid)
    if tag == "T2" and n == 1:          # T2 finished its line-1095 gate read
        t2_gate_done.set()
    return r


def sched_consume(openid):
    r = orig_consume(openid)
    consume_returns.append((threading.current_thread().name, r))
    return r


store.quota_left = sched_quota_left
store.consume_one = sched_consume
out: list = []
ts = [threading.Thread(target=call_route, args=(t, out), name=t) for t in ("T1", "T2")]
ts[0].start(); t1_in_pre.wait(timeout=5)  # T1 parked inside its `pre` call
ts[1].start()
[t.join() for t in ts]
store.quota_left = orig_quota_left
store.consume_one = orig_consume

served = [o for o in out if o[1] == 200 and o[2]]
leg1_ok = (
    sorted(r for _, r in consume_returns) == [False, True]
    and len(served) == 2
    and free_used() == config.FREE_PER_DAY
    and store.quota_left(U)["total_left"] == 0
)
print(f"  endpoint outcomes : {out}")
print(f"  consume_one rets  : {consume_returns}  (False discarded by app.py:1103)")
print(f"  free_used after   : {free_used()} / {config.FREE_PER_DAY}; quota_left total_left=0")
print(f"  verdict           : 1 remaining quota served {len(served)} full 200 answers -> {leg1_ok}")

# ══ Leg 2: natural race scan (no store patching at all) ═════════
print("\n== Leg 2: natural 2-thread race scan, 300 rounds, store untouched ==")
CYCLES = 300
hits = both_ok = mixed = both429 = 0
for _ in range(CYCLES):
    seed_left_one()
    bar = threading.Barrier(2)
    out = []

    def worker():
        bar.wait(timeout=5)
        call_route("w", out)

    ts = [threading.Thread(target=worker) for _ in range(2)]
    [t.start() for t in ts]
    [t.join() for t in ts]
    oks = [o for o in out if o[1] == 200 and o[2]]
    codes = sorted({o[1] for o in out})
    if codes == [200]:
        both_ok += 1
    elif codes == [200, 429]:
        mixed += 1
    else:
        both429 += 1
    if len(oks) == 2 and free_used() == config.FREE_PER_DAY:
        hits += 1
print(f"  {CYCLES} rounds: double-200={both_ok} / mixed={mixed} / gate-held={both429}")
print(f"  '1 quota -> 2 full answers' natural hits: {hits}/{CYCLES}")

# ══ Leg 3: full HTTP through real uvicorn (FastAPI threadpool path) ══
print("\n== Leg 3: real HTTP, in-process uvicorn, 8-way burst with 1 quota left ==")
import uvicorn  # noqa: E402

PORT = 8899
server = uvicorn.Server(uvicorn.Config(qwapp.app, host="127.0.0.1", port=PORT, log_level="error"))
sth = threading.Thread(target=server.run, daemon=True)
sth.start()
for _ in range(100 and 200):  # wait for startup
    if server.started:
        break
    time.sleep(0.05)


_no_proxy = urllib.request.build_opener(urllib.request.ProxyHandler({}))


def http_ask(tag: str, out: list) -> None:
    req = urllib.request.Request(
        f"http://127.0.0.1:{PORT}/api/report/{SKU}/ask",
        data=json.dumps({"q": f"并发双击提问{tag}"}).encode(),
        headers={"Authorization": f"Bearer {TOKEN}", "Content-Type": "application/json"},
        method="POST")
    try:
        with _no_proxy.open(req, timeout=15) as r:
            body = json.loads(r.read().decode())
            out.append((r.status, bool(body.get("conclusion")), body.get("left")))
    except urllib.error.HTTPError as e:
        out.append((e.code, False, None))


worst = 0
for rnd in range(5):
    seed_left_one()
    bar = threading.Barrier(8)
    out = []

    def hworker():
        bar.wait(timeout=5)
        http_ask("b", out)

    ts = [threading.Thread(target=hworker) for _ in range(8)]
    [t.start() for t in ts]
    [t.join() for t in ts]
    served200 = [o for o in out if o[0] == 200 and o[1]]
    n429 = sum(1 for o in out if o[0] == 429)
    worst = max(worst, len(served200))
    print(f"  round {rnd}: 200-with-answer={len(served200)} 429={n429} free_used={free_used()}")
server.should_exit = True
sth.join(timeout=5)

over = worst - 1  # only 1 quota was available
print(f"\nSUMMARY: leg1_deterministic={leg1_ok}  leg2_natural_hits={hits}/{CYCLES}  "
      f"leg3_worst_burst={worst} answers from 1 quota (overage {max(0, over)})")
sys.exit(0 if (leg1_ok or hits > 0 or worst > 1) else 1)
