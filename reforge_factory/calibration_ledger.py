# -*- coding: utf-8 -*-
"""calibration_ledger — P2-6 判层校准账本 (Brier Score <0.20 宪法判据落地,
终极提案 P2-6, 1028 用户已批).

职责: 记录每次判层/预测的**置信度**与**实际结果** → 定期跑 Brier Score →
输出校准报告 (哪些类型判断过度自信/不足)。数据源:
  ① semantic_judge 语义翻案记录 (_tmp_semantic_replay_report*.json 复判账:
     L1 启发式判废 × L2 GLM 复判, 双判并陈);
  ② ammo_pool 各战役 manifest 的 judge 结果 (sem_overturn 生产翻案行);
  ③ add 手工落账 (任意判层/预测, 置信度+到期结果).

Brier 口径 (数字零造假): confidence = P(该件有效/相关) ∈ [0,1];
outcome ∈ {0,1}; brier = (confidence − outcome)²。L1 启发式不发数值置信度
→ 只入错杀率统计不入 Brier (如实分账, 不给 L1 编造置信度)。

结果仲裁 (adjudicate): 机械域词目验 — EPC 域固定词表 (中英) 对材料头部
匹配, 命中即 outcome=1, 命中词落账; 零命中 outcome=0。局限如实: 外文材料
覆盖有限、词表仲裁弱于人工复核 — 报告中显式声明, 后续 settle 可用更强
口径补仲裁 (先例不改, 新记录用新基准)。

宪法判据: 报告面 Brier 均值 <0.20 = 门 PASS (n<30 时标小样本警示, 如实)。

用法:
  py reforge_factory/calibration_ledger.py add --campaign X --judger Y \
      --subject Z --prediction valid --confidence 0.8 [--outcome 1 --basis ..]
  py reforge_factory/calibration_ledger.py ingest-replay <replay.json> [--adjudicate]
  py reforge_factory/calibration_ledger.py ingest-ammo --campaign EPC-TOP50 [--adjudicate]
  py reforge_factory/calibration_ledger.py settle --id J-0001 --outcome 1 --basis "人工复核"
  py reforge_factory/calibration_ledger.py report [--campaign X] [--json]
账本: reforge_factory/judge_calibration_ledger.jsonl (追加式; settle 只回填
该行 outcome/brier 两字段, 已 settle 拒二次回填 — 历史不可翻改)。
铁律: 免费宪法 / 数字零造假 / 只增不删 / 密钥不进仓。
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

HERE = Path(__file__).resolve().parent
LEDGER = HERE / "judge_calibration_ledger.jsonl"
OUTDIR = HERE / "completeness"
REPO = HERE.parents[0]                                  # E:\AI-Station

#: EPC 域词表 (固定, 中英) — 机械仲裁用; 命中词落账可回查
DOMAIN_LEXICON = (
    "工程总承包", "EPC", "总承包", "设计院", "计价", "造价", "工期", "索赔",
    "结算", "招标", "投标", "合同", "项目管理", "工程施工", "勘察设计",
    "engineering", "procurement", "construction", "contract", "claim",
    "cost", "tender", "bid", "project management",
)
#: 宪法判据
BRIER_GATE = 0.20
#: 仲裁样本窗 (材料头部字符)
_ADJ_WINDOW = 600


def load() -> list[dict]:
    if not LEDGER.is_file():
        return []
    out = []
    for line in LEDGER.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if line:
            try:
                out.append(json.loads(line))
            except json.JSONDecodeError:
                continue
    return out


def save(rows: list[dict]) -> None:
    with LEDGER.open("a", encoding="utf-8") as fh:     # 追加式
        for r in rows:
            fh.write(json.dumps(r, ensure_ascii=False) + "\n")


def next_id(rows: list[dict]) -> str:
    n = 0
    for r in rows:
        m = re.match(r"J-(\d+)", str(r.get("id", "")))
        if m:
            n = max(n, int(m.group(1)))
    return "J-%04d" % (n + 1)


def adjudicate(head: str) -> tuple[int, str]:
    """机械域词目验 → (outcome, basis)。命中词落账, 零命中如实。"""
    h = str(head or "")[:_ADJ_WINDOW].lower()
    hits = [w for w in DOMAIN_LEXICON if w.lower() in h]
    if hits:
        return 1, "域词目验:命中[%s]" % ",".join(hits[:6])
    return 0, "域词目验:零命中(局限:外文长尾材料易漏判, 报告声明)"


def brier_of(conf: float, outcome: int) -> float:
    return round((float(conf) - float(outcome)) ** 2, 6)


def _bias_label(mean_conf: float, obs_rate: float) -> str:
    """分桶诊断标签; 偏差 ≥0.5 时标仲裁冲突 (机械仲裁与判器极端相左,
    需人工 settle 强口径再定论, 不轻下过度/不足结论)。"""
    if obs_rate - mean_conf >= 0.5:
        return "仲裁冲突(需人工settle复核)"
    if mean_conf - obs_rate >= 0.5:
        return "仲裁冲突(需人工settle复核)"
    if mean_conf > obs_rate + 0.05:
        return "过度自信"
    if obs_rate > mean_conf + 0.05:
        return "不足"
    return "校准良好"


def make_record(rows: list[dict], campaign: str, judger: str, jtype: str,
                subject: str, prediction: str, confidence, outcome,
                basis: str, pointer: str) -> dict:
    rec = {"id": next_id(rows), "ts": time.strftime("%Y-%m-%d %H:%M"),
           "campaign": campaign, "judger": judger, "judgment_type": jtype,
           "subject": subject[:120], "prediction": prediction,
           "confidence": confidence,
           "outcome": outcome, "outcome_basis": basis,
           "brier": brier_of(confidence, outcome)
           if confidence is not None and outcome is not None else None,
           "pointer": pointer[:200],
           "dedup": "%s|%s|%s" % (judger, subject[:80], prediction)}
    rows.append(rec)
    return rec


def ingest_replay(path: Path, adjudicate_on: bool) -> int:
    d = json.loads(path.read_text(encoding="utf-8"))
    cid = d.get("cid", "?")
    rows = load()
    have = {r.get("dedup") for r in rows}
    added = []
    for grp, l1_pred in (("flips", "rejected"), ("holds", "rejected")):
        for f in d.get(grp, []):
            subj = str(f.get("file", ""))
            head = str(f.get("head", ""))
            score = f.get("score")
            sem_pred = str(f.get("verdict", ""))
            outcome = basis = None
            if adjudicate_on:
                outcome, basis = adjudicate(head)
            # ① L1 启发式判断 (无数值置信度 → 不入 Brier, 入错杀率账)
            k1 = "l1_heuristic|%s|rejected" % subj[:80]
            if k1 not in have:
                added.append(make_record(
                    rows, cid, "l1_heuristic", "判层L1",
                    subj, "rejected", None, outcome, basis,
                    "replay:%s" % path.name))
                have.add(k1)
            # ② L2 语义判 (score 即置信度 → 入 Brier)
            k2 = "semantic_glm|%s|%s" % (subj[:80], sem_pred)
            if k2 not in have and score is not None:
                added.append(make_record(
                    rows, cid, "semantic_glm", "判层L2",
                    subj, sem_pred, float(score), outcome, basis,
                    "replay:%s" % path.name))
                have.add(k2)
    save(added)
    print("[calib] ingest-replay %s: +%d 行 (flips=%d holds=%d, adjudicate=%s)"
          % (path.name, len(added), len(d.get("flips", [])),
             len(d.get("holds", [])), adjudicate_on))
    return 0


_SEM_OVERTURN = re.compile(
    r"sem_overturn\[L1:([^|]+)\|L2:glm@(\S+)\s+score=([\d.]+)\s*(.*)")


def ingest_ammo(campaign: str, adjudicate_on: bool) -> int:
    mf = REPO / "ammo_pool" / campaign / "manifest.jsonl"
    if not mf.is_file():
        print("[calib] 无 manifest: %s" % mf, file=sys.stderr)
        return 2
    rows = load()
    have = {r.get("dedup") for r in rows}
    added = []
    for line in mf.read_text(encoding="utf-8", errors="replace").splitlines():
        try:
            m = json.loads(line)
        except json.JSONDecodeError:
            continue
        reason = str(m.get("judge_reason") or "")
        mt = _SEM_OVERTURN.search(reason)
        if not mt:
            continue
        subj = Path(str(m.get("source_path", ""))).name
        score = float(mt.group(3))
        outcome = basis = None
        if adjudicate_on:
            src = Path(str(m.get("source_path", "")))
            head = (src.read_text(encoding="utf-8", errors="replace")[:600]
                    if src.is_file() else str(m.get("text_head", "")))
            outcome, basis = adjudicate(head)
        k1 = "l1_heuristic|%s|rejected" % subj[:80]
        if k1 not in have:
            added.append(make_record(
                rows, campaign, "l1_heuristic", "判层L1生产",
                subj, "rejected", None, outcome, basis,
                str(m.get("source_path", ""))[:200]))
            have.add(k1)
        k2 = "semantic_glm|%s|valid" % subj[:80]
        if k2 not in have:
            added.append(make_record(
                rows, campaign, "semantic_glm", "判层L2生产",
                subj, "valid", score, outcome, basis,
                str(m.get("source_path", ""))[:200]))
            have.add(k2)
    save(added)
    print("[calib] ingest-ammo %s: +%d 行 (sem_overturn 生产翻案, "
          "adjudicate=%s)" % (campaign, len(added), adjudicate_on))
    return 0


def settle(rid: str, outcome: int, basis: str) -> int:
    rows = load()
    hit = next((r for r in rows if r.get("id") == rid), None)
    if hit is None:
        print("[calib] 无此 id: %s" % rid, file=sys.stderr)
        return 2
    if hit.get("outcome") is not None:
        print("[calib] %s 已对账 (历史不可翻改), 拒绝二次回填" % rid,
              file=sys.stderr)
        return 3
    hit["outcome"] = outcome
    hit["outcome_basis"] = basis
    if hit.get("confidence") is not None:
        hit["brier"] = brier_of(hit["confidence"], outcome)
    # 追加式账本: 旧行不动, 结算行重写末尾 — 与 brier_score 同款机械
    LEDGER.write_text("\n".join(json.dumps(r, ensure_ascii=False)
                                for r in rows) + "\n", encoding="utf-8")
    print("[calib] settle %s → outcome=%s brier=%s (%s)"
          % (rid, outcome, hit.get("brier"), basis))
    return 0


def report(campaign: str, as_json: bool) -> int:
    rows = load()
    if campaign:
        rows = [r for r in rows if r.get("campaign") == campaign]
    brier_rows = [r for r in rows
                  if r.get("confidence") is not None
                  and r.get("outcome") is not None]
    l1_rows = [r for r in rows if r.get("judger") == "l1_heuristic"
               and r.get("outcome") is not None]
    mean_brier = (round(sum(r["brier"] for r in brier_rows) / len(brier_rows), 4)
                  if brier_rows else None)
    gate = ("PASS" if mean_brier is not None and mean_brier < BRIER_GATE
            else "FAIL" if mean_brier is not None else "N/A(无可对账行)")
    # 分桶: 置信度带 → 期望 vs 实测 (过度自信=实测<期望)
    bands = {}
    for r in brier_rows:
        lo = min(int(float(r["confidence"]) * 10) * 10, 90)
        key = "%.0f-%.0f%%" % (lo, lo + 10)
        b = bands.setdefault(key, {"n": 0, "sum_conf": 0.0, "hits": 0,
                                   "sum_brier": 0.0})
        b["n"] += 1
        b["sum_conf"] += float(r["confidence"])
        b["hits"] += int(r["outcome"])
        b["sum_brier"] += r["brier"]
    # L1 错杀率 (L1 判废但仲裁为有效)
    l1_stats = {}
    for r in l1_rows:
        k = str(r.get("judgment_type", "?"))
        s = l1_stats.setdefault(k, {"n": 0, "wrongly_rejected": 0})
        s["n"] += 1
        s["wrongly_rejected"] += int(r["outcome"])
    rec = {"ts": time.strftime("%Y-%m-%d %H:%M"),
           "filter_campaign": campaign or "(全部)",
           "records_total": len(rows),
           "brier_population": len(brier_rows),
           "mean_brier": mean_brier, "brier_gate": BRIER_GATE,
           "gate": gate,
           "small_sample_warning": len(brier_rows) < 30,
           "confidence_bands": {k: {"n": v["n"],
                                    "mean_confidence": round(
                                        v["sum_conf"] / v["n"], 3),
                                    "observed_valid_rate": round(
                                        v["hits"] / v["n"], 3),
                                    "mean_brier": round(
                                        v["sum_brier"] / v["n"], 4),
                                    "bias": _bias_label(
                                        v["sum_conf"] / v["n"],
                                        v["hits"] / v["n"])}
                           for k, v in sorted(bands.items())},
           "l1_heuristic_kill_rate": {k: {"n": v["n"],
                                          "wrongly_rejected": v["wrongly_rejected"],
                                          "kill_rate": round(
                                              v["wrongly_rejected"] / v["n"], 3)
                                              if v["n"] else None}
                                      for k, v in l1_stats.items()},
           "unresolved": sum(1 for r in rows if r.get("outcome") is None),
           "adjudicator_note": "域词目验为机械仲裁 (固定词表+命中词落账); "
                               "外文长尾材料易漏判, 局限如实。"}
    out_md = OUTDIR / "judge_calibration_report.md"
    out_json = OUTDIR / "judge_calibration_report.json"
    md = ["# 判层校准报告 (Brier <0.20 宪法判据)", "",
          "- 账本行 %d | 可对账(Brier)行 %d | 未结算 %d | 过滤: %s"
          % (len(rows), len(brier_rows), rec["unresolved"],
             rec["filter_campaign"]),
          "- **Brier 均值 %s | 门(<%s): %s**%s" % (
              mean_brier, BRIER_GATE, gate,
              " ⚠小样本(n<30)警示" if rec["small_sample_warning"] else ""),
          "", "## 置信度分桶 (过度自信/不足诊断)", "",
          "| 置信带 | n | 平均置信 | 实测有效率 | 平均Brier | 诊断 |",
          "|---|---|---|---|---|---|"]
    for k, v in rec["confidence_bands"].items():
        md.append("| %s | %d | %.3f | %.3f | %.4f | %s |" % (
            k, v["n"], v["mean_confidence"], v["observed_valid_rate"],
            v["mean_brier"], v["bias"]))
    md += ["", "## L1 启发式错杀率 (无置信度, 只入错误率账)", ""]
    for k, v in rec["l1_heuristic_kill_rate"].items():
        md.append("- %s: n=%d, 错杀 %d (错杀率 %s)"
                  % (k, v["n"], v["wrongly_rejected"], v["kill_rate"]))
    md += ["", "> %s" % rec["adjudicator_note"],
           "> 口径: confidence=P(件有效), brier=(conf−outcome)²; "
           "L1 无数值置信度不入 Brier (不编造)。数字零造假。"]
    if not as_json:
        out_md.write_text("\n".join(md), encoding="utf-8")
    out_json.write_text(json.dumps(rec, ensure_ascii=False, indent=1),
                        encoding="utf-8")
    print("[calib] 报告: Brier均值=%s 门=%s (n=%d) → %s"
          % (mean_brier, gate, len(brier_rows), out_json))
    if as_json:
        print(json.dumps(rec, ensure_ascii=False, indent=1))
    else:
        for k, v in rec["confidence_bands"].items():
            print("  带%s: n=%d conf=%.3f 实测=%.3f → %s"
                  % (k, v["n"], v["mean_confidence"],
                     v["observed_valid_rate"], v["bias"]))
    return 0


def cmd_add(ns) -> int:
    rows = load()
    have = {r.get("dedup") for r in rows}
    dedup = "%s|%s|%s" % (ns.judger, ns.subject[:80], ns.prediction)
    if dedup in have and not ns.force:
        print("[calib] 重复记录 (dedup 命中, --force 可强制)", file=sys.stderr)
        return 3
    rec = make_record(rows, ns.campaign, ns.judger, ns.jtype, ns.subject,
                      ns.prediction,
                      float(ns.confidence) if ns.confidence else None,
                      int(ns.outcome) if ns.outcome is not None else None,
                      ns.basis or "", ns.pointer or "")
    save([rec])
    print("[calib] +%s %s/%s conf=%s outcome=%s"
          % (rec["id"], ns.judger, ns.subject[:40], rec["confidence"],
             rec["outcome"]))
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description="判层校准账本 (P2-6)")
    sub = ap.add_subparsers(dest="cmd", required=True)
    a = sub.add_parser("add")
    a.add_argument("--campaign", required=True)
    a.add_argument("--judger", required=True)
    a.add_argument("--jtype", default="判层")
    a.add_argument("--subject", required=True)
    a.add_argument("--prediction", required=True)
    a.add_argument("--confidence", default="")
    a.add_argument("--outcome", type=int, default=None)
    a.add_argument("--basis", default="")
    a.add_argument("--pointer", default="")
    a.add_argument("--force", action="store_true")
    r = sub.add_parser("ingest-replay")
    r.add_argument("replay")
    r.add_argument("--adjudicate", action="store_true")
    m = sub.add_parser("ingest-ammo")
    m.add_argument("--campaign", required=True)
    m.add_argument("--adjudicate", action="store_true")
    s = sub.add_parser("settle")
    s.add_argument("--id", required=True)
    s.add_argument("--outcome", type=int, required=True, choices=(0, 1))
    s.add_argument("--basis", required=True)
    p = sub.add_parser("report")
    p.add_argument("--campaign", default="")
    p.add_argument("--json", action="store_true")
    ns = ap.parse_args()
    if ns.cmd == "add":
        return cmd_add(ns)
    if ns.cmd == "ingest-replay":
        return ingest_replay(Path(ns.replay), ns.adjudicate)
    if ns.cmd == "ingest-ammo":
        return ingest_ammo(ns.campaign, ns.adjudicate)
    if ns.cmd == "settle":
        return settle(ns.id, ns.outcome, ns.basis)
    return report(ns.campaign, ns.json)


if __name__ == "__main__":
    raise SystemExit(main())
