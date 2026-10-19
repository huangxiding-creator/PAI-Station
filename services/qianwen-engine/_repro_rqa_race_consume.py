# -*- coding: utf-8 -*-
"""复现审查发现：report_ask 丢弃 consume_one()=False（app.py:1103）在同用户竞态下的两类账害。

审查者声称（commit 23a48173 审查）：
  429 闸（app.py:1095）、pre 快照（app.py:1102）、consume_one（app.py:1103）是三段独立
  _LOCK/DB 临界区；report_ask 为同步 def（FastAPI 线程池并发），同用户并发（咨询 /api/ask
  或问报告，共享统一额度池）可在窗口内抢走最后 1 次。与咨询流（app.py:123 检查返回值）
  不同，report_ask 丢弃返回值。后果：
  (A) consume_one=False 仍继续检索+LLM → 200 超额满分回答（left=0）；
  (B) 该请求 LLM 失败 → refund_one 在本请求从未扣次的情况下退掉别人合法扣的 1 次
      （quota 0→1），可重复白嫖。

验证法：真实 app.report_ask 路由函数 + 真实 store（临时 sqlite）。在 R1 的
consume_one 调用内部注入「并发同用户 consume 先到」——这正是生产可调度的交错
（pre 与 consume 是两次独立 _LOCK 获取、各开一条新连接；/api/ask:123 的 consume
抢在这两语句之间拿到 _LOCK 即成）。另附真实双线程自然竞态扫描。
"""
from __future__ import annotations

import sqlite3
import sys
import threading
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

_TMP = Path(tempfile.mkdtemp(prefix="qw_rqa_race_"))
from qianwen_engine import config  # noqa: E402

config.DATA_DIR = _TMP
config.DB_PATH = _TMP / "db.sqlite"

from qianwen_engine import store, wechat, report_catalog, report_qa, zhipu  # noqa: E402
from qianwen_engine import app as qwapp  # noqa: E402
from fastapi import HTTPException  # noqa: E402

U = "race-user"
SKU = "SKU-RACE"
CHAPTERS = [{"no": 1, "title": "第一章", "desc": "章节描述"}]


class FakeReq:
    headers = {"Authorization": "Bearer x"}


def raw_free_used() -> int:
    with sqlite3.connect(config.DB_PATH) as c:
        return c.execute("SELECT free_used FROM users WHERE openid=?", (U,)).fetchone()[0]


def seed_left_one() -> None:
    """用户当日已用 5/6 免费次（left=1，无赠次）——审查场景前提。"""
    store.quota_left(U)  # 确保在册
    with sqlite3.connect(config.DB_PATH) as c:
        c.execute("UPDATE users SET free_used=?, bonus_earned=0, bonus_used=0 WHERE openid=?",
                  (config.FREE_PER_DAY - 1, U))


def main() -> int:
    # ── 外部依赖打桩（鉴权/目录/检索/LLM），配额账全部走真实 store ──
    wechat.verify_token = lambda t: U
    report_catalog.get_report = lambda sku: {"title": "测试报告"}
    report_qa.retrieve = lambda sku, q: (CHAPTERS, True)
    orig_consume, orig_refund = store.consume_one, store.refund_one

    print(f"FREE_PER_DAY={config.FREE_PER_DAY}  DB={config.DB_PATH}")

    # ══ 场景 A：consume=False 仍 200 满分回答（超额作答）══
    print("\n== 场景A：并发咨询抢走最后1次后，report_ask 自己的 consume 返回 False ==")
    seed_left_one()
    events: list = []

    def consume_with_race(openid):
        comp = orig_consume(openid)   # 并发同用户 /api/ask 咨询的扣次（其返回 True 会正常放行）
        mine = orig_consume(openid)   # report_ask 自己的扣次（app.py:1103，返回值被丢弃）
        events.append({"competitor": comp, "r1_consume": mine})
        return mine

    store.consume_one = consume_with_race
    zhipu.deep_answer = lambda *a, **k: "结论如下。\n第1章：依据文本。"

    resp = qwapp.report_ask(SKU, qwapp.ReportAskIn(q="这份报告讲了什么"), FakeReq())

    a_ok = (
        events == [{"competitor": True, "r1_consume": False}]
        and isinstance(resp, dict)
        and bool(resp.get("conclusion"))
        and resp.get("left") == 0
        and raw_free_used() == config.FREE_PER_DAY
    )
    print(f"  consume 事件      : {events}")
    print(f"  响应形态          : conclusion={resp.get('conclusion')!r} left={resp.get('left')}")
    print(f"  落库 free_used    : {raw_free_used()}（仅并发方的1次被记；R1 的满分答案未扣次）")
    print(f"  判定 A 成立        : {a_ok}")

    # ══ 场景 B：本请求未扣次，LLM 失败却 refund 掉并发方的合法扣次 ══
    print("\n== 场景B：R1 从未扣次（consume=False），LLM 失败 → refund_one 退掉并发方的 1 次 ==")
    seed_left_one()
    events.clear()
    refunds: list = []

    def refund_spy(openid, from_bonus=None):
        refunds.append({"from_bonus": from_bonus, "free_used_before": raw_free_used()})
        return orig_refund(openid, from_bonus)

    store.refund_one = refund_spy

    def boom(*a, **k):
        raise RuntimeError("zhipu down")

    zhipu.deep_answer = boom
    status = None
    try:
        qwapp.report_ask(SKU, qwapp.ReportAskIn(q="这份报告讲了什么"), FakeReq())
    except HTTPException as e:
        status = e.status_code

    q_after = store.quota_left(U)
    b_ok = (
        events == [{"competitor": True, "r1_consume": False}]
        and status == 503
        and len(refunds) == 1
        and refunds[0]["free_used_before"] == config.FREE_PER_DAY
        and q_after["total_left"] == 1
        and raw_free_used() == config.FREE_PER_DAY - 1
    )
    print(f"  consume 事件      : {events}")
    print(f"  HTTP 状态         : {status}（REQ-004 契约 503）")
    print(f"  refund 调用       : {refunds}（R1 自身 consume=False，无次可退却执行了退次）")
    print(f"  结算 quota        : {dict(q_after)} —— 并发方那次成功咨询被白退，0→1")
    print(f"  判定 B 成立        : {b_ok}")

    store.consume_one = orig_consume
    store.refund_one = orig_refund

    # ══ 真实双线程自然竞态扫描：同用户两个 report_ask 并发，数「1次额度出2份满分答案」══
    print("\n== 自然竞态扫描（两线程同打 report_ask，闸门→pre→consume 三段独立临界区）==")
    zhipu.deep_answer = lambda *a, **k: "结论如下。\n第1章：依据文本。"
    hits = both_gate = gate429 = mixed429 = 0
    CYCLES = 400
    for _ in range(CYCLES):
        seed_left_one()
        bar = threading.Barrier(2)
        out: list = []

        def worker():
            bar.wait()
            try:
                r = qwapp.report_ask(SKU, qwapp.ReportAskIn(q="并发双击提问测试"), FakeReq())
                if type(r).__name__ == "JSONResponse":     # 429 闸（status_code=429）
                    out.append(("http", r.status_code))
                else:
                    out.append(("ok", bool(r.get("conclusion"))))
            except HTTPException as e:
                out.append(("http", e.status_code))

        ts = [threading.Thread(target=worker) for _ in range(2)]
        [t.start() for t in ts]
        [t.join() for t in ts]
        kinds = sorted(k for k, _ in out)
        if kinds == ["http"]:
            gate429 += 1        # 双方闸门时已见 0 → 429
        elif kinds == ["http", "ok"]:
            mixed429 += 1        # 仅一方过闸（闸门正确生效）
        elif kinds == ["ok", "ok"]:
            both_gate += 1
        # 超额作答成立：两路都拿到满分结论，但只扣了 1 次（free_used=6 且无 429/503）
        if (len(out) == 2 and all(o[0] == "ok" and o[1] for o in out)
                and raw_free_used() == config.FREE_PER_DAY):
            hits += 1
    print(f"  {CYCLES} 轮双线程并发：双过闸双满分 {both_gate} 轮 / 单方429 {mixed429} 轮 / 双429 {gate429} 轮；"
          f"『1 次额度出 2 份满分答案』命中 {hits} 轮")

    verdict = a_ok and b_ok
    print(f"\n结论：确定性注入下 A/B 均{'成立' if verdict else '不成立'}"
          f"；自然双线程命中 {hits}/{CYCLES}")
    return 0 if verdict else 1


if __name__ == "__main__":
    sys.exit(main())
