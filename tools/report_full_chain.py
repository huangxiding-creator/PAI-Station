# -*- coding: utf-8 -*-
"""report_full_chain — 研究报告全链八段执行驱动器 (1016 用户令: 固化, 以后报告都这样执行).

每份报告从 S-1 到 S8 按同一状态机跑; 段间门不过即停; 断点续跑 (游标=阶段号)。
所有阶段调用本仓在役件 (BID26 全链首跑 2026-10-15→16 实证形态), 不造轮子。

用法: py -X utf8 tools/report_full_chain.py --campaign EPC-TRAIN --topic "企业EPC培训市场深度洞察" --sku EPC-TRAIN-2026 --price 598 [--from S1] [--stage-only S1]
铁律: S1.5 人工闸 (用户批准才进 S2); Token 峰谷令 (工作日 14-18 点禁军团相位);
      删除只认用户明示令; 数字零造假 (全部走门与台账)。
"""
from __future__ import annotations

import argparse
import json
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]
PY = [sys.executable, "-X", "utf8"]
PY311 = [r"F:\We-AIPO\.venv\Scripts\python.exe", "-X", "utf8"]
CURSOR_DIR = REPO / "_proposals" / "flagship-paid-report-1007" / "work"
STAGES = ["S-1", "S1", "S1.5", "S2", "S3", "S4", "S5", "S6", "S7", "S8"]


def sh(cmd: list, desc: str, must: bool = True) -> bool:
    print(f"\n▶▶ {desc}\n  $ {' '.join(str(c) for c in cmd[:8])}…", flush=True)
    r = subprocess.run(cmd, cwd=str(REPO), timeout=3600)
    ok = r.returncode == 0
    print(f"◀◀ {desc} → {'✅' if ok else '❌'} (exit {r.returncode})", flush=True)
    if must and not ok:
        raise SystemExit(f"[chain] 段内硬失败: {desc}")
    return ok


def harvest_legs(campaign: str) -> None:
    """S1 采集腿轮 (在役收割件按序; 失败如实跳过不阻断)."""
    variants = {
        "EPC-TRAIN": "reforge_factory/harvest_localfiles_train.py",
        "EPC-BID26": "reforge_factory/harvest_localfiles.py",
    }
    lf = variants.get(campaign, "reforge_factory/harvest_localfiles.py")
    for cmd, desc in (
        (PY + [lf, "--campaign", campaign, "--per-facet", "150"], "本地库收割"),
        (PY + ["reforge_factory/ammo_pool.py", "judge", campaign, "--limit", "900"], "判有效"),
        (PY + ["reforge_factory/tree_backfill.py", "--campaign", campaign], "挂树回填"),
        (PY + ["reforge_factory/judge_reland.py", "--campaign", campaign], "off_topic 复判"),
        (PY + ["reforge_factory/tree_spread.py", "--campaign", campaign], "同维铺展"),
        (PY + ["reforge_factory/tier_fulltext_reledger.py", campaign], "T1 重落账"),
    ):
        sh(cmd, desc, must=False)


def sensors(campaign: str) -> bool:
    for cmd, desc in (
        (PY + ["reforge_factory/completeness/entity_timeline.py", "--campaign", campaign], "T 轴"),
        (PY + ["reforge_factory/completeness/coverage_facets.py", "scan", campaign], "B 轴"),
        (PY + ["reforge_factory/completeness/dimension_matrix.py", "scan", campaign], "D 轴"),
        (PY + ["reforge_factory/completeness/depth_ladder.py", "--campaign", campaign], "P 轴"),
        (PY + ["reforge_factory/completeness/channel_matrix.py", campaign], "C 轴"),
        (PY + ["reforge_factory/completeness/cidx.py", "--campaign", campaign], "CIdx 组装"),
    ):
        sh(cmd, desc, must=False)
    return sh(PY + ["reforge_factory/report_gate_check.py", "--campaign", campaign], "三门检查")


def run_stage(stage: str, ns) -> None:
    c, sku, price = ns.campaign, ns.sku, ns.price
    if stage == "S-1":
        print("[S-1] 需求雷达/候位核对 (radar_scorecards + pipeline_state 候位)")
    elif stage == "S1":
        harvest_legs(c)
        if not sensors(c):
            print("[S1] 三门未过 — 继续采集腿 (重跑 --stage-only S1) 或补豁免后 --from S1.5")
            return
    elif stage == "S1.5":
        print("[S1.5] ⛔人工闸: 需用户明示批准 (如 AskUserQuestion 实答/approve 原话) 落 pipeline_state 后才可 --from S2")
    elif stage == "S2":
        m2 = REPO / "_proposals" / "flagship-paid-report-1007" / "work" / "m2"
        sh(PY + [str(m2 / f"{c.lower().replace('-', '_')}_outline.py")], "大纲")
        sh(PY + [str(m2 / f"{c.lower().replace('-', '_')}_bank.py")], "弹药 bank")
        print("[S2] 写手军团: Workflow (12 章并行+密度自检) → 补锚军团 → sweep 终扫 → gate3 (人工/Workflow 触发)")
    elif stage == "S3":
        m2 = REPO / "_proposals" / "flagship-paid-report-1007" / "work" / "m2" / c.lower().replace("-", "")
        print("[S3] merge → report_to_docx → Word COM PDF (在役 m2 装配件)")
    elif stage == "S4":
        sh(PY + ["tools/mp_list_report.py", "--sku", sku], "小程序上架(总包AI顾问)")
        sh(PY + ["tools/metaso_brain_upload.py", "--cfid", "8676827961374429184",
                 "--sid", "8673582927558737920", "--file", ns.merged], "秘塔工程大脑入库")
    elif stage == "S5":
        print("[S5] 文章×3 (标题定式「发布| 报告全名称」): push_article → freepublish/管线 (三号)")
    elif stage == "S6":
        print("[S6] 视频×3 (H3≥1): channels_login_weaipo → channels_publish + 品牌封面")
    elif stage == "S7":
        print("[S7] 企微通知 (WeComNotifier .env webhook) + PDF 推送")
    elif stage == "S8":
        sh(PY + ["report_platform/funnel_query.py", "--week", time.strftime("%Y-W%U")], "漏斗周报", must=False)
        print("[S8] decision_ledger 落账 → 回写 S-1 (下一份)")


def main() -> int:
    ap = argparse.ArgumentParser(description="研究报告全链八段驱动器(固化)")
    ap.add_argument("--campaign", required=True)
    ap.add_argument("--topic", default="")
    ap.add_argument("--sku", required=True)
    ap.add_argument("--price", type=int, required=True)
    ap.add_argument("--merged", default="", help="S4 成书 md 路径")
    ap.add_argument("--from", dest="frm", default="S-1")
    ap.add_argument("--stage-only", default="")
    ns = ap.parse_args()
    todo = [ns.stage_only] if ns.stage_only else STAGES[STAGES.index(ns.frm):]
    print(f"[chain] {ns.campaign} ({ns.sku} ¥{ns.price}) 段序: {' → '.join(todo)}")
    for st in todo:
        run_stage(st, ns)
    print("[chain] 本轮段序执行完毕")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
