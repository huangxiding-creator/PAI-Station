# -*- coding: utf-8 -*-
"""reforge_factory 评分链 — 复用 super-skill V4.1.16 proposal-forge 脚本库 + 今日 docket 底座."""
import json, sys
from pathlib import Path
sys.path.insert(0, r"C:\Users\91216\.claude\skills\super-skill\skills\proposal-forge\scripts")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import maturity_index as mi
import tenx_delta_index as tx
import scorecard as sc

# ---- 1) maturity: 复用今日 docket (同底座, 生态无新变化) ----
repos = json.loads(Path(r"E:\AI-Station\Auto_Manus\corps_factory\RESEARCH_DOCKET\github\_all.json").read_text(encoding="utf-8"))
landscape = mi.score_landscape(repos)
mat_feas = mi.derive_feasibility(landscape)
print(f"[maturity] repos={len(repos)} median={landscape.median:.0f} mature={landscape.mature_count} -> feasibility={mat_feas:.2f}")

# ---- 2) tenx: 调研产能四轴 (自定义轴显式传方向) ----
claims = {
    # 单课题弹药字数: 1000万门槛(用户铁律) vs 现状~50万字级凑料
    "per_project_ammo_chars": {"ours": 10000000, "baseline": 500000},
    # 全渠道动员数: 16渠道+军团(全员作战令) vs 现状实际动用~3
    "channels_mobilized": {"ours": 17, "baseline": 3},
    # 独立信源: P5门>=500 vs 现状50(双百倍实测)
    "independent_sources": {"ours": 500, "baseline": 50},
    # 弹药盘点时效(秒): 实时账本 vs 手工天级(86400)
    "ammo_inventory_latency_sec": {"ours": 60, "baseline": 86400},
}
tenx = tx.score(claims, axes={
    "per_project_ammo_chars": "higher_better",
    "channels_mobilized": "higher_better",
    "independent_sources": "higher_better",
    "ammo_inventory_latency_sec": "lower_better",
})
tenx_score = tx.derive_tenx_score(tenx)
print(f"[tenx] verdict={tenx.verdict} best_axis={tenx.best_axis} multiplier={tenx.multiplier:.0f}x -> score={tenx_score:.2f}")

# ---- 3) scorecard ----
# feasibility: 骨架今日已立(总线+编成+门槛), 四条腿纯本地工程; maturity 侧生态无现成轮子(0.48)但内部地基对冲
feasibility = round(0.6 * mat_feas + 0.4 * 0.85, 2)
verdict = sc.compute(feasibility=feasibility, user_value=0.92, monetization=0.55, tenx=tenx_score)
print(f"[scorecard] feasibility={feasibility} -> {json.dumps(verdict, ensure_ascii=False, default=str)[:260]}")

out = {"maturity": {"median": landscape.median, "mature": landscape.mature_count, "feas": mat_feas},
       "feasibility": feasibility, "tenx": {"verdict": tenx.verdict, "best_axis": tenx.best_axis,
       "multiplier": tenx.multiplier, "score": tenx_score},
       "verdict": verdict, "generated": "2026-09-22"}
Path("SCORECARD.json").write_text(json.dumps(out, ensure_ascii=False, indent=1, default=str), encoding="utf-8")
print("saved SCORECARD.json")
