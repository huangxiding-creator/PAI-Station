# -*- coding: utf-8 -*-
"""dl_collect_internal — 面C接入器：feedback MySQL + ask 全史 + 购买日志 → 台账 (F6).

只读拉取已在役库，转需求信号入账。
用法: py -X utf8 tools/dl_collect_internal.py
"""
from __future__ import annotations

import json
import sys
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import demand_ledger as dl  # noqa: E402

REPO = Path(__file__).resolve().parents[1]
ENGINE = "https://qianwen-engine-322438-9-1499254664.sh.run.tcloudbase.com"


def _admin_key() -> str:
    return (REPO / "data" / "secrets" / "qianwen_engine_hmac.key").read_bytes().hex()


def _engine(path: str) -> dict:
    req = urllib.request.Request(ENGINE + path, headers={"X-Admin-Key": _admin_key()})
    with urllib.request.urlopen(req, timeout=30) as r:
        return json.loads(r.read())


def collect_feedback() -> int:
    """C1: 引擎 feedback 全量（买家语音/文字反馈原文=最强需求信号）。"""
    n = 0
    try:
        d = _engine("/api/feedback/all?limit=500")
        for it in d.get("items") or []:
            quote = (it.get("transcript") or "").strip()
            if not quote:
                continue
            scores = {}
            try:
                scores = json.loads(it.get("scores_json") or "{}")
            except json.JSONDecodeError:
                pass
            dl.append("mp_feedback", quote, ref=f"fb:{it.get('fid','')}",
                      jtbd={"trigger": "买家反馈", "job_statement": f"对{it.get('sku','报告')}提出改进要求",
                            "outcome": "报告迭代"},
                      urgency="high" if scores.get("total_score", 100) < 60 else "mid",
                      score=max(50, 100 - int(scores.get("total_score", 80))))
            n += 1
    except Exception as e:
        print("[C1] feedback 拉取失败:", str(e)[:80])
    print(f"[C1] feedback 入账 {n}")
    return n


def collect_ask() -> int:
    """C2: 小程序咨询问答全史（用户主动问题=需求直接表达）。"""
    n = 0
    db = Path(r"E:\AI-Station\data\state\qw_deploy_stage_1007\qianwen_engine\data\qianwen\db.sqlite")
    if not db.exists():
        print("[C2] 本地 ask 库不存在, skip 如实")
        return 0
    import sqlite3
    try:
        conn = sqlite3.connect(str(db))
        rows = conn.execute("SELECT question, created_at FROM answers "
                            "WHERE deleted=0 ORDER BY id DESC LIMIT 300").fetchall()
        conn.close()
    except Exception as e:
        print("[C2] ask 库读失败:", str(e)[:60])
        return 0
    for q, ts in rows:
        q = (q or "").strip()
        if len(q) < 8:
            continue
        dl.append("ask_log", q[:200], ref=f"ask:{ts}",
                  jtbd={"trigger": "主动咨询", "job_statement": "用户在小程序主动提问",
                        "outcome": "获得解答"},
                  urgency="high")
        n += 1
    print(f"[C2] ask 入账 {n}")
    return n


def collect_purchase() -> int:
    """C3: 购买/解锁行为（哪类报告被真金白银买=品类需求）。"""
    n = 0
    db = Path(r"E:\AI-Station\data\state\qw_deploy_stage_1007\qianwen_engine\data\qianwen\db.sqlite")
    if not db.exists():
        return 0
    import sqlite3
    try:
        conn = sqlite3.connect(str(db))
        try:
            rows = conn.execute("SELECT sku, COUNT(*) n FROM report_unlocks "
                                "GROUP BY sku").fetchall()
        finally:
            conn.close()
    except Exception:
        return 0
    for sku, n_buy in rows:
        dl.append("purchase", f"用户真金购买《{sku}》共{n_buy}次——该品类需求被市场验证",
                  ref=f"pay:{sku}", jtbd={"trigger": "购买行为",
                                          "job_statement": f"为{sku}付费",
                                          "outcome": "品类验证"},
                  urgency="high", score=90, frequency=int(n_buy))
        n += 1
    print(f"[C3] purchase 入账 {n}")
    return n


def main() -> int:
    collect_feedback()
    collect_ask()
    collect_purchase()
    print("[C] 面C完成:", dl.stats())
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
