# -*- coding: utf-8 -*-
"""mckinsey_gate — P2-2 麦肯锡七步问题解决法·S-1 立题门 (终极提案 P2-2, 1028 已批).

思想来源: McKinsey 七步问题解决法 (Seven-Step Problem Solving, 公开培训
方法论) — 定义问题→分解问题→优先排序→分析计划→执行分析→综合结论→讲好故事.
本件把它做成 S-1 选题阶段的自动检查门: 输入选题案卷 → 逐步机器检测
(确定性正则 + 结构计数, 可选 GLM 辅助评问题定义清晰度) → 七步合规表,
任一步 GAP 即门不通过 (立题不稳不开调研)。

七步 × 检查口径 (对齐产线 S-1 案卷既有结构):
  ①定义问题: 一句话/选题执行体/JTBD 信号在场; 课题用判断句而非名词堆砌
  ②分解(MECE): 多候选并立 (互斥面) + 排除项记录 (不占位) + 七源拉取实录 (穷尽面)
  ③优先排序: 候选带可复算的分值 (雷达分/DScore/评分卡) 且首选有据
  ④分析计划: 任务书/WBS (S1-S5 类相位分解) 指针在场
  ⑤执行分析: 需求实测计数 (信号 seq 回查/频次计数) 在场, 非纯定性
  ⑥综合结论: 首选候选明示 + 风险与护栏明示
  ⑦讲好故事: 价值主张一句话 (用户动词短语) + 读者画像在场

用法:
  py reforge_factory/mckinsey_gate.py --dossier <S-1案卷.md> [--no-llm] \
      [--campaign X]
产物: <dossier>.mckinsey_gate.md / .json + mckinsey_gate_log.jsonl (只增)。
铁律: 免费宪法 / 数字零造假 / 密钥不进仓不进日志。
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))

LOG = Path(__file__).resolve().parent / "mckinsey_gate_log.jsonl"

STEPS = ("定义问题", "分解问题(MECE)", "优先排序", "分析计划",
         "执行分析", "综合结论", "讲好故事")

#: 逐步子检查: (步名, 检查名, 正则/结构探针)
PROBES: tuple[tuple[str, str, re.Pattern], ...] = (
    ("定义问题", "一句话价值主张", re.compile(r"一句话\*{0,2}\*{0,2}[:：]")),
    ("定义问题", "JTBD/需求信号引用", re.compile(r"JTBD|信号指针|seq\d+")),
    ("定义问题", "问题式标题", re.compile(r"^#.*(?:选题|S-1)", re.M)),
    ("分解问题(MECE)", "多候选并立(互斥面)", re.compile(r"候选[A-CＡ-Ｃ]|候选[一二三1-3]")),
    ("分解问题(MECE)", "排除项记录(不占位)", re.compile(r"排除项")),
    ("分解问题(MECE)", "七源拉取实录(穷尽面)", re.compile(r"七源|源拉取实录")),
    ("优先排序", "量化分值(雷达/评分卡)", re.compile(r"(?:雷达分|DScore|综合)\s*[:：]?\s*\d+(?:\.\d+)?")),
    ("优先排序", "榜首/首选明示", re.compile(r"首选|榜首|第一名")),
    ("分析计划", "WBS/任务书指针", re.compile(r"WBS|任务书|EXEC-")),
    ("分析计划", "相位分解(S1-S5)", re.compile(r"S[1-5](?:[-—]|相|阶段)|S1[-－]S5")),
    ("执行分析", "需求实测计数", re.compile(r"\d+\s*(?:次|行|条|个信号)|freq[_=]?\d+|seq\d+.{0,20}回查")),
    ("执行分析", "多源印证(≥2源)", re.compile(r"群.{0,12}moments|买家.{0,8}群|多面印证")),
    ("综合结论", "首选候选明示", re.compile(r"候选A（首选）|首选《")),
    ("综合结论", "风险与护栏明示", re.compile(r"\*\*风险\*\*|风险[:：]|护栏")),
    ("讲好故事", "读者动词短语", re.compile(r"报得准|结得清|扯皮时|一册|打透|摊开")),
    ("讲好故事", "读者画像", re.compile(r"读者|项目经理|造价|法务|商务")),
)

LLM_SYS = (
    "你是麦肯锡式问题定义审查官。给定一份研究报告的选题案卷, 只回答一个问题:"
    "『问题定义是否清晰到可直接开工』—— 判断三件事: (1)服务谁(读者画像具体);"
    "(2)解决什么痛点(场景动词而非名词); (3)成功标准(什么算报好了)。"
    '只输出 JSON: {"clear": true|false, "missing": ["缺失项(20字内)", ...], '
    '"verdict": "40字内判词"}。')


def probe(text: str) -> dict:
    """逐步打探针 → {步: [(检查名, 判定, 命中样例)]}。"""
    out: dict[str, list] = {s: [] for s in STEPS}
    for step, name, rx in PROBES:
        m = rx.search(text)
        hit = m.group(0) if m else ""
        out[step].append((name, "PASS" if m else "GAP", hit[:40]))
    return out


def step_verdict(rows: list) -> str:
    """步判定: 全 PASS→PASS; 有 GAP 但过半→PARTIAL; 否则 GAP。"""
    n_pass = sum(1 for _, v, _ in rows if v == "PASS")
    if n_pass == len(rows):
        return "PASS"
    return "PARTIAL" if n_pass >= (len(rows) + 1) // 2 else "GAP"


def run(dossier: Path, no_llm: bool, campaign: str) -> int:
    text = dossier.read_text(encoding="utf-8", errors="replace")
    probed = probe(text)
    llm_out: dict = {}
    if not no_llm:
        sys.path.insert(0, str(Path(__file__).resolve().parents[1]
                               / "mission-engine" / "forge"))
        from glm_json import GlmJson               # 双钥免费档
        head = text[:9000] + ("\n(超长截断, 如实)" if len(text) > 9000 else "")
        try:
            llm_out = GlmJson().chat_json(
                LLM_SYS, "## 选题案卷\n%s" % head, temperature=0.2) or {}
        except Exception as e:                     # noqa: BLE001 — 如实降级
            llm_out = {"error": "%s: %s" % (type(e).__name__, e)}
    steps = []
    for s in STEPS:
        rows = probed[s]
        v = step_verdict(rows)
        steps.append({"step": s, "verdict": v,
                      "checks": [{"name": n, "hit": h, "verdict": vv}
                                 for n, vv, h in rows]})
    n_pass = sum(1 for x in steps if x["verdict"] == "PASS")
    n_part = sum(1 for x in steps if x["verdict"] == "PARTIAL")
    gate = "通过" if n_pass == 7 else ("有条件通过(补 PARTIAL 步)" if n_pass + n_part == 7 else "不通过")
    rec = {"ts": time.strftime("%Y-%m-%d %H:%M"), "campaign": campaign,
           "dossier": str(dossier), "chars": len(text),
           "steps": steps, "pass": n_pass, "partial": n_part,
           "gate": gate, "llm_problem_def": llm_out}
    out_md = Path(str(dossier)[:-3] + ".mckinsey_gate.md")
    out_json = Path(str(out_md)[:-3] + ".json")
    md = ["# 麦肯锡七步立题门合规表 | %s" % dossier.name, "",
          "- 门判定: **%s** (PASS %d/7, PARTIAL %d/7) | 案卷 %s 字 | LLM 辅助 %s"
          % (gate, n_pass, n_part, f"{len(text):,}",
             "开" if llm_out and "error" not in llm_out else
             ("失败如实降级" if llm_out else "关(--no-llm)")),
          "", "| 步 | 判定 | 检查明细 |", "|---|---|---|"]
    for x in steps:
        det = "; ".join("%s=%s%s" % (c["name"], c["verdict"],
                                     ("「%s」" % c["hit"]) if c["hit"] else "")
                        for c in x["checks"])
        md.append("| %d %s | **%s** | %s |" % (
            steps.index(x) + 1, x["step"], x["verdict"], det))
    if llm_out and "error" not in llm_out:
        md += ["", "## 问题定义清晰度 (GLM 辅助仪表)", "",
               "- 清晰: %s | 判词: %s" % (llm_out.get("clear"),
                                            llm_out.get("verdict", ""))]
        for miss in llm_out.get("missing") or []:
            md.append("- 缺失: %s" % miss)
    elif llm_out:
        md += ["", "> GLM 辅助仪表失败 (如实): %s" % llm_out["error"]]
    md += ["", "> 判定口径: PASS=全子检查命中 / PARTIAL=过半命中 / "
           "GAP=过半未命中; 门通过需七步全 PASS。探针为确定性正则, 命中样例"
           "即证据, 数字零造假。"]
    out_md.write_text("\n".join(md), encoding="utf-8")
    out_json.write_text(json.dumps(rec, ensure_ascii=False, indent=1),
                        encoding="utf-8")
    with LOG.open("a", encoding="utf-8") as fh:     # 台账只增
        fh.write(json.dumps({k: v for k, v in rec.items() if k != "steps"},
                            ensure_ascii=False) + "\n")
    print("[mckinsey_gate] 门判定: %s (PASS %d/7 PARTIAL %d/7) → %s"
          % (gate, n_pass, n_part, out_md))
    for i, x in enumerate(steps, 1):
        print("  %d. %s: %s" % (i, x["step"], x["verdict"]))
    return 0 if gate == "通过" else (1 if n_pass + n_part == 7 else 2)


def main() -> int:
    ap = argparse.ArgumentParser(description="麦肯锡七步立题门 (P2-2)")
    ap.add_argument("--dossier", required=True, help="S-1 选题案卷 md")
    ap.add_argument("--no-llm", action="store_true")
    ap.add_argument("--campaign", default="")
    ns = ap.parse_args()
    p = Path(ns.dossier)
    if not p.is_file():
        print("案卷不存在: %s" % p, file=sys.stderr)
        return 2
    return run(p, ns.no_llm, ns.campaign)


if __name__ == "__main__":
    raise SystemExit(main())
