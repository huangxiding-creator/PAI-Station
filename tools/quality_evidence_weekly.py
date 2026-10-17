# -*- coding: utf-8 -*-
"""quality_evidence_weekly — 质量永续飞轮·周度证据报告 (1017 用户令: 三条证据腿全落实).

四腿合一 (输出一份 md 周报):
  ① 反馈评分腿: 引擎 GET /api/feedback/all — 买家按质退款评分聚合 (总量/均分/退款分布/按SKU)
  ② 复购解锁腿: 引擎 GET /api/quality/orders — report_unlocks 聚合 + 多SKU买家数
  ③ 漏斗退款腿: report_platform/funnel_query.py --week 本地跑 (四级漏斗+退款率)
  ④ 盲测台账腿: _proposals/flagship-paid-report-1007/blindtest/verdict*.json 战绩汇总
输出: _proposals/flagship-paid-report-1007/quality_weekly/<年-W周>.md (+latest.md 覆写)
调度: 周一 09:07 durable cron; 也可手动随时跑。
"""
from __future__ import annotations

import datetime as dt
import json
import subprocess
import sys
import time
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]
ENGINE = "https://qianwen-engine-322438-9-1499254664.sh.run.tcloudbase.com"
OUT_DIR = REPO / "_proposals" / "flagship-paid-report-1007" / "quality_weekly"
BLIND = REPO / "_proposals" / "flagship-paid-report-1007" / "blindtest"
PY = [sys.executable, "-X", "utf8"]
DIMS = ["decision_usefulness", "evidence_credibility", "analytical_depth",
        "honesty_about_limits", "professional_accuracy"]


def engine_get(path: str) -> dict:
    key = (REPO / "data" / "secrets" / "qianwen_engine_hmac.key").read_bytes().hex()
    req = urllib.request.Request(ENGINE + path, headers={"X-Admin-Key": key})
    with urllib.request.urlopen(req, timeout=30) as r:
        return json.loads(r.read())


def week_id() -> str:
    return dt.date.today().strftime("%G-W%V")


def leg_feedback() -> tuple[list[str], int]:
    try:
        d = engine_get("/api/feedback/all?limit=1000")
        items = [i for i in (d.get("items") or [])
                 if "probe" not in (i.get("openid") or "").lower()]
    except Exception as e:  # noqa: BLE001
        return [f"- 反馈腿拉取失败: {e}"], 0
    if not items:
        return ["- 暂无买家反馈（飞轮待首批真实反馈）"], 0
    scores, refunds, by_sku = [], [], {}
    for it in items:
        try:
            s = json.loads(it.get("scores_json") or "{}")
        except json.JSONDecodeError:
            s = {}
        t = s.get("total_score")
        if isinstance(t, (int, float)):
            scores.append(t)
        rp = it.get("refund_pct") or 0
        refunds.append(int(rp))
        sku = it.get("sku") or "?"
        b = by_sku.setdefault(sku, {"n": 0, "scores": [], "refund_sum": 0,
                                    "email": 0, "pending": 0})
        b["n"] += 1
        if isinstance(t, (int, float)):
            b["scores"].append(t)
        b["refund_sum"] += int(it.get("refund_amount") or 0)
        if it.get("email"):
            b["email"] += 1
        if it.get("status") == "pending":
            b["pending"] += 1
    avg = round(sum(scores) / len(scores), 1) if scores else "-"
    lines = [
        f"- 累计反馈 **{len(items)}** 条；评分均分 **{avg}**/100；"
        f"退款比例均值 **{round(sum(refunds)/len(refunds),1) if refunds else 0}%**",
        "- 按 SKU：",
    ]
    for sku, b in sorted(by_sku.items(), key=lambda kv: -kv[1]["n"]):
        s = round(sum(b["scores"]) / len(b["scores"]), 1) if b["scores"] else "-"
        lines.append(f"  - {sku}: {b['n']} 条 | 均分 {s} | 退款入队 ¥{b['refund_sum']}"
                     f" | 留邮箱 {b['email']} | 待处理 {b['pending']}")
    return lines, len(items)


def leg_orders() -> list[str]:
    try:
        d = engine_get("/api/quality/orders")
    except Exception as e:  # noqa: BLE001
        return [f"- 解锁腿拉取失败: {e}"]
    unl = d.get("unlocks") or []
    if not unl:
        return ["- 暂无报告解锁记录"]
    total_n = sum(int(r.get("n") or 0) for r in unl)
    lines = [f"- 累计解锁 **{total_n}** 次 / {len(unl)} SKU；"
             f"多SKU复购买家 **{d.get('multi_sku_buyers', 0)}** 人",
             "  - " + "；".join(f"{r.get('sku')}×{r.get('n')}" for r in
                              sorted(unl, key=lambda r: -int(r.get("n") or 0))[:8])]
    return lines


def leg_funnel() -> list[str]:
    r = subprocess.run(PY + [str(REPO / "report_platform" / "funnel_query.py"),
                             "--week", week_id()],
                       cwd=str(REPO), capture_output=True, text=True, timeout=120)
    out = (r.stdout or "").strip()
    if not out:
        return ["- 漏斗腿无输出（funnel_query 空周或失败）"]
    return ["```", out[:1800], "```"]


def leg_blind() -> list[str]:
    wins = {"ours": 0, "them": 0, "tie": 0}
    n = 0
    for fp in sorted(BLIND.glob("verdict*.json")):
        try:
            d = json.loads(fp.read_text(encoding="utf-8"))
        except Exception:  # noqa: BLE001
            continue
        ours_side = "Y"  # 本仓盲件约定: Y.md=我方摘录, X.md=外部对照件
        for j in d.get("judgments", []):
            w = j.get("winner")
            if w == "tie" or not w:
                wins["tie"] += 1
            else:
                wins["ours" if w == ours_side else "them"] += 1
            n += 1
    if n == 0:
        return ["- 盲测台账暂无有效判次"]
    return [f"- 累计 AI 盲测 **{n}** 判：我方 **{wins['ours']}** 胜 / "
            f"外部件 {wins['them']} 胜 / 平 {wins['tie']}"
            f"（对照件=顶级咨询公司公开报告；证据路线=AI面板+买家退款评分，不做人类盲评）"]


def main() -> int:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    wk = week_id()
    fb, n_fb = leg_feedback()
    rep = [
        f"# 质量永续飞轮·证据周报 {wk}",
        f"\n生成: {time.strftime('%Y-%m-%d %H:%M')} | 数据源: 引擎反馈库+解锁库+漏斗账本+盲测台账",
        "",
        "## ① 买家按质退款评分（真人持续盲评）",
        *fb,
        "",
        "## ② 解锁与复购",
        *leg_orders(),
        "",
        "## ③ 四级漏斗（本周）",
        *leg_funnel(),
        "",
        "## ④ AI 盲测战绩台账",
        *leg_blind(),
        "",
        "---",
        "*本报告由 tools/quality_evidence_weekly.py 自动生成；反驳它请用数据，不要用立场。*",
    ]
    md = "\n".join(rep)
    (OUT_DIR / f"{wk}.md").write_text(md, encoding="utf-8")
    (OUT_DIR / "latest.md").write_text(md, encoding="utf-8")
    print(md[:1200])
    print(f"\n[weekly] 已写出 {OUT_DIR / (wk + '.md')} ({n_fb} 条反馈在账)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
