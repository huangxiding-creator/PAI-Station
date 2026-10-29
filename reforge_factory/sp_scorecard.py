# -*- coding: utf-8 -*-
"""sp_scorecard — P2-1 S&P 式报告质量记分卡 (终极提案 P2-1, 1028 用户已批).

思想来源: S&P Global Ratings 信用评级方法论 (监管强制全量免费公开: SEC 17g-7
披露件 sec.gov + spglobal.com/criteria) — 五维加权打分 → 映射 AAA..D 等级制.
本件把「行业风险/竞争地位/盈利能力/杠杆/流动性」的企业信用五维, 改编为
报告质量五维:
  ①选题质量 (行业风险位 → 课题是否真需求)
  ②证据密度 (盈利能力位 → 证据锚点是否扎实)
  ③逻辑严谨 (杠杆位 → 结论是否压得住证据)
  ④原创洞察 (竞争地位位 → 有无别处拿不到的东西)
  ⑤行动价值 (流动性位 → 读者能不能马上用)
权重 (改编自 S&P 企业权重结构: 盈利+杠杆占大头 → 证据+逻辑占大头):
  选题 0.15 / 证据 0.30 / 逻辑 0.25 / 原创 0.15 / 行动 0.15 (Σ=1.00)

双仪表 (数字零造假):
  规则分 = 逐维子检查 (正则/计数, 确定性, 明细全落账) 的确定性评分;
  LLM 分 = GLM-4-flash 免费档 (forge/glm_json 双钥) 独立评 1-5 分 + 证据引文;
  维终分 = (规则分 + LLM 分) / 2, 三值并陈 — 两仪表都是实测, 合成透明。
等级映射 (1-5 加权合成 → S&P 九档): AAA≥4.6 AA≥4.2 A≥3.8 BBB≥3.4
BB≥2.9 B≥2.4 CCC≥1.9 CC≥1.4 D<1.4。

用法:
  py reforge_factory/sp_scorecard.py --chapter <chNN.md|任意md件> \
      [--bank <bank_chNN.md>] [--no-llm] [--campaign X]
产物: <chapter>.sp_scorecard.md / .json + sp_scorecard_log.jsonl (只增)。
铁律: 免费宪法 / 数字零造假 / 密钥不进仓不进日志 / 调用串行 ≤4 并发合规。
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
sys.path.insert(0, str(Path(__file__).resolve().parents[1]
                       / "mission-engine" / "forge"))
import claim_verifier as cv                      # noqa: E402 (锚点/句法复用)

LOG = Path(__file__).resolve().parent / "sp_scorecard_log.jsonl"

#: 五维定义: (名称, 权重, S&P 对应位)
DIMENSIONS = (
    ("选题质量", 0.15, "行业风险位"),
    ("证据密度", 0.30, "盈利能力位"),
    ("逻辑严谨", 0.25, "杠杆位"),
    ("原创洞察", 0.15, "竞争地位位"),
    ("行动价值", 0.15, "流动性位"),
)
#: 等级阈值 (合成 1-5 → S&P 九档, 改编压缩自 S&P 22 档记分制)
GRADE_BANDS = ((4.6, "AAA"), (4.2, "AA"), (3.8, "A"), (3.4, "BBB"),
               (2.9, "BB"), (2.4, "B"), (1.9, "CCC"), (1.4, "CC"),
               (0.0, "D"))

ANCHOR_TOTAL_RE = re.compile(r"P\d{4,6}")
HEADING2_RE = re.compile(r"^##\s", re.M)
HEADING3_RE = re.compile(r"^###\s", re.M)
QUOTE_RE = re.compile(r"^>\s?", re.M)
TABLE_RE = re.compile(r"^\|.*\|$", re.M)
BULLET_RE = re.compile(r"^\s*[-*]\s+\S", re.M)
NUM_SENT_RE = re.compile(r"\d[\d,，]*(?:\.\d+)?(?:亿|万|%|％|元|家|项|个|倍|年|月|GW|MW)")
READER_RE = re.compile(r"读者|项目经理|造价|法务|商务|总承包商|业主|为谁|目标读者")
PROBLEM_RE = re.compile(r"解决什么|帮读者|回答.{0,8}问题|面临.{0,12}问题|痛点|十字路口|何去何从")
BOUNDARY_RE = re.compile(r"证据边界|边界|局限|未获证|不作.{0,4}表述|待考|存疑")
FRAMEWORK_RE = re.compile(r"矩阵|谱系|分层|框架|路径图|图谱|地图|四象限|梯队|打分卡")
INSIGHT_RE = re.compile(r"表明|揭示|意味着|指向|印证|根源在于|本质上|共同点在于")
ACTION_RE = re.compile(r"建议|应当|可以|务必|需要|步骤|清单|检查表|落地|实操|可执行|先做|优先")
RISK_RE = re.compile(r"陷阱|风险|注意事项|不要|禁用|红线")


def _scale(v: float, bands=(2.0, 1.5, 1.0, 0.5)) -> int:
    """密度类指标 → 1-5 分 (≥bands[0]→5 … >0→1, 0→0)。"""
    if v >= bands[0]:
        return 5
    if v >= bands[1]:
        return 4
    if v >= bands[2]:
        return 3
    if v >= bands[3]:
        return 2
    return 1 if v > 0 else 0


def _avg(scores: list) -> tuple[float, list]:
    """子检查均值; 全空 (N/A) → 0 并标注。"""
    if not scores:
        return 0.0, []
    return round(sum(scores) / len(scores), 2), scores


def measure(text: str, chars: int, bank: dict | None,
            claim_json: dict | None) -> dict:
    """五维规则子检查 — 全部确定性计数, 明细返回落账。"""
    per1000 = 1000.0 / max(chars, 1)
    anchors_all = ANCHOR_TOTAL_RE.findall(text)
    anchors_uniq = {a.lstrip("P") for a in anchors_all}   # 归一去 P 前缀 → 对齐 bank 键
    sents = cv.split_sentences(text)
    headings2 = HEADING2_RE.findall(text)

    # ① 选题质量
    q1 = 5 if QUOTE_RE.search(text[:600]) else 2      # 开篇引言摊问题
    q2 = 5 if READER_RE.search(text[:3000]) else 1    # 读者定位
    q3 = 5 if PROBLEM_RE.search(text[:3000]) else 1   # 问题陈述
    q_rule, q_sub = _avg([q1, q2, q3])

    # ② 证据密度
    e1 = _scale(len(anchors_uniq) * per1000)
    e2 = _scale(len(anchors_uniq) / max(len(anchors_all), 1) * 2.5)  # 多样性
    e_sub = [e1, e2]
    e_notes = ["锚点密度 %.2f 独有锚/千字 → %d 分" % (
        len(anchors_uniq) * per1000, e1),
        "锚点多样性 %.0f%% → %d 分" % (
            100 * len(anchors_uniq) / max(len(anchors_all), 1), e2)]
    if bank is not None:
        resolved = sum(1 for a in anchors_uniq if a in bank and
                       bank[a]["text"] and not bank[a]["empty"])
        rate = resolved / max(len(anchors_uniq), 1)
        e3 = 5 if rate >= 0.9 else 4 if rate >= 0.7 else 2
        e_sub.append(e3)
        e_notes.append("bank 可溯率 %.0f%% (%d/%d) → %d 分" % (
            rate * 100, resolved, len(anchors_uniq), e3))
    else:
        e_notes.append("bank 未提供 → 可溯率检查 N/A (不计分, 如实)")
    e_rule, _ = _avg(e_sub)

    # ③ 逻辑严谨
    l1 = 5 if len(headings2) >= 3 else (3 if headings2 else 1)
    l_sub = [l1]
    l_notes = ["## 节数 %d → %d 分" % (len(headings2), l1)]
    if HEADING3_RE.search(text):
        l_sub.append(5)
        l_notes.append("### 层级深 → 5 分")
    else:
        l_notes.append("### 层级缺 → 不计分 (如实)")
    if claim_json:
        pr = float(claim_json.get("summary", {}).get("pass_rate", 0))
        l3 = 5 if pr >= 95 else 4 if pr >= 85 else 3 if pr >= 70 else 2 if pr >= 50 else 1
        l_sub.append(l3)
        l_notes.append("claim 核查通过率 %.1f%% (P1-2 实测账) → %d 分" % (pr, l3))
    else:
        l_notes.append("claim_verdict 账无 → 该检查 N/A")
    l4 = 5 if BOUNDARY_RE.search(text) else 2
    l_sub.append(l4)
    l_notes.append("证据边界/局限表述 → %d 分" % l4)
    l_rule, _ = _avg(l_sub)

    # ④ 原创洞察
    o1 = _scale(len(cv.OWN_CALC_RE.findall(text)) * 10000 / max(chars, 1),
                bands=(4, 2, 1, 0.3))
    o2 = _scale(len(FRAMEWORK_RE.findall(text)) * per1000, bands=(1.2, 0.8, 0.4, 0.15))
    o3 = _scale(len(INSIGHT_RE.findall(text)) * per1000, bands=(2, 1.2, 0.6, 0.25))
    o4 = _scale(len(TABLE_RE.findall(text)) * per1000, bands=(1.5, 0.8, 0.4, 0.1))
    o_rule, _ = _avg([o1, o2, o3, o4])
    o_notes = ["own_calc %.1f 处/万字 → %d" % (
        len(cv.OWN_CALC_RE.findall(text)) * 10000 / max(chars, 1), o1),
        "框架词 %.2f 处/千字 → %d" % (len(FRAMEWORK_RE.findall(text)) * per1000, o2),
        "判断动词 %.2f 处/千字 → %d" % (len(INSIGHT_RE.findall(text)) * per1000, o3),
        "表格行 %.2f 行/千字 → %d" % (len(TABLE_RE.findall(text)) * per1000, o4)]

    # ⑤ 行动价值
    a1 = _scale(len(ACTION_RE.findall(text)) * per1000, bands=(3, 1.8, 0.9, 0.35))
    a2 = 5 if re.search(r"小结|要点|本章.{0,4}(小结|要点)", text) else 2
    a3 = _scale(len(BULLET_RE.findall(text)) * per1000, bands=(3, 1.5, 0.7, 0.2))
    a4 = 5 if RISK_RE.search(text) else 2      # 风险/陷阱明示 (行动者最需要)
    a_rule, _ = _avg([a1, a2, a3, a4])
    a_notes = ["行动动词 %.2f 处/千字 → %d" % (len(ACTION_RE.findall(text)) * per1000, a1),
               "小结要点节 → %d" % a2,
               "清单式条目 %.2f 条/千字 → %d" % (len(BULLET_RE.findall(text)) * per1000, a3),
               "陷阱/风险明示 → %d" % a4]

    return {
        "选题质量": {"rule": q_rule, "subs": ["引言摊题 %d/读者定位 %d/问题陈述 %d" % (q1, q2, q3)]},
        "证据密度": {"rule": e_rule, "subs": e_notes},
        "逻辑严谨": {"rule": l_rule, "subs": l_notes},
        "原创洞察": {"rule": o_rule, "subs": o_notes},
        "行动价值": {"rule": a_rule, "subs": a_notes},
        "_facts": {"chars": chars, "sentences": len(sents),
                   "anchors_total": len(anchors_all),
                   "anchors_unique": len(anchors_uniq),
                   "headings2": len(headings2)},
    }


LLM_SYS = (
    "你是 S&P 式报告质量评级分析师。给定一份研究报告章节与其确定性指标账,"
    "按以下五维各打 1-5 分 (5=世界顶级咨询水准, 1=不可用): 选题质量(课题真需求)/"
    "证据密度(证据锚点扎实度)/逻辑严谨(结论压得住证据)/原创洞察(别处拿不到的"
    "东西)/行动价值(读者能否马上用)。每维给出章节原文中的证据引文(30字内)。"
    '只输出 JSON: {"scores": [{"dim": "维度名", "score": 1-5的整数, '
    '"evidence": "原文引文", "rationale": "25字内理由"} x5]}。')


def llm_rate(llm, text: str, facts: dict) -> list:
    head = text[:9000] + ("\n(超长截断, 如实)" if len(text) > 9000 else "")
    user = ("## 章节原文\n%s\n\n## 确定性指标账\n%s" % (
        head, json.dumps(facts, ensure_ascii=False)))
    out = llm.chat_json(LLM_SYS, user, temperature=0.2)
    rows = out.get("scores") if isinstance(out, dict) else out
    return rows or []


def grade_of(composite: float) -> str:
    for th, g in GRADE_BANDS:
        if composite >= th:
            return g
    return "D"


def run(chapter: Path, bank_p: Path | None, no_llm: bool,
        campaign: str) -> int:
    text = chapter.read_text(encoding="utf-8", errors="replace")
    chars = len(re.sub(r"\s", "", text))
    bank = cv.parse_bank(bank_p) if bank_p else None
    claim_json = None
    cj = chapter.with_suffix("").as_posix() + ".claim_verdict.json"
    if Path(cj).is_file():
        try:
            claim_json = json.loads(Path(cj).read_text(encoding="utf-8"))
        except json.JSONDecodeError:
            claim_json = None
    m = measure(text, chars, bank, claim_json)
    facts = m.pop("_facts")
    llm_rows: list = []
    if not no_llm:
        from glm_json import GlmJson               # 双钥免费档
        llm = GlmJson()
        llm_rows = llm_rate(llm, text, facts)
    llm_by_dim = {}
    for r in llm_rows:
        d = str(r.get("dim", ""))[:4]
        for name, _, _ in DIMENSIONS:
            if name[:4] in d or d in name:
                llm_by_dim[name] = r
                break
    t0 = time.time()
    dims, composite = [], 0.0
    for name, w, sp in DIMENSIONS:
        rule = m[name]["rule"]
        lr = llm_by_dim.get(name)
        lscore = int(lr["score"]) if lr and str(lr.get("score", "")).isdigit() else None
        final = round((rule + lscore) / 2, 2) if lscore is not None else rule
        composite += w * final
        dims.append({"dim": name, "weight": w, "sp_analog": sp,
                     "rule_score": rule, "llm_score": lscore, "final": final,
                     "llm_evidence": (lr or {}).get("evidence", ""),
                     "llm_rationale": (lr or {}).get("rationale", ""),
                     "rule_detail": m[name]["subs"]})
    composite = round(composite, 2)
    g = grade_of(composite)
    rec = {"ts": time.strftime("%Y-%m-%d %H:%M"), "campaign": campaign,
           "chapter": str(chapter), "bank": str(bank_p) if bank_p else "",
           "chars_nospace": chars, "facts": facts, "dimensions": dims,
           "composite": composite, "grade": g,
           "llm_used": bool(llm_rows), "elapsed_sec": round(time.time() - t0, 1)}
    out_md = Path(str(chapter)[:-3] + ".sp_scorecard.md") \
        if str(chapter).endswith(".md") else Path(str(chapter) + ".sp_scorecard.md")
    out_json = Path(str(out_md)[:-3] + ".json")
    md = ["# S&P 式报告质量记分卡 | %s" % chapter.name, "",
          "- 评级: **%s** (加权合成 %.2f / 5.00) | 章节有效字数 %s | bank %s"
          % (g, composite, f"{chars:,}",
             bank_p.name if bank_p else "(未提供, 可溯检查 N/A)"),
          "- 方法: S&P 五维评级框架改编 (监管公开方法论) — 规则分(确定性计数)"
          "×LLM分(GLM独立评)双仪表, 维终分=两者均值, 数字零造假", "",
          "| 维度 | 权重 | S&P对应位 | 规则分 | LLM分 | 终分 | 加权贡献 |",
          "|---|---|---|---|---|---|---|"]
    for d in dims:
        md.append("| %s | %.2f | %s | %.2f | %s | %.2f | %.3f |" % (
            d["dim"], d["weight"], d["sp_analog"], d["rule_score"],
            d["llm_score"] if d["llm_score"] is not None else "N/A",
            d["final"], round(d["weight"] * d["final"], 3)))
    md += ["", "## 逐维证据明细 (规则仪表, 全部实测计数)", ""]
    for d in dims:
        md.append("- **%s**: %s" % (d["dim"], "; ".join(d["rule_detail"])))
        if d["llm_score"] is not None:
            md.append("  - LLM 仪表: %d 分 — %s 「%s」" % (
                d["llm_score"], d["llm_rationale"], d["llm_evidence"]))
    md += ["", "> 等级带: AAA≥4.6 AA≥4.2 A≥3.8 BBB≥3.4 BB≥2.9 B≥2.4 "
           "CCC≥1.9 CC≥1.4 D<1.4 (改编自 S&P 记分制的九档压缩)。"
           "本卡为产线内部质量仪表, 不进用户侧报告。"]
    out_md.write_text("\n".join(md), encoding="utf-8")
    out_json.write_text(json.dumps(rec, ensure_ascii=False, indent=1),
                        encoding="utf-8")
    with LOG.open("a", encoding="utf-8") as fh:      # 台账只增
        fh.write(json.dumps({k: v for k, v in rec.items()
                             if k != "dimensions"}, ensure_ascii=False) + "\n")
    print("[sp_scorecard] 评级 %s (合成 %.2f) | 章节字数 %s | 报告 %s"
          % (g, composite, f"{chars:,}", out_md))
    for d in dims:
        print("  %s: 规则%.2f × LLM%s → 终分%.2f (权重%.2f)"
              % (d["dim"], d["rule_score"],
                 d["llm_score"] if d["llm_score"] is not None else "-",
                 d["final"], d["weight"]))
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description="S&P 式报告质量记分卡 (P2-1)")
    ap.add_argument("--chapter", required=True, help="章节/任意 md 件")
    ap.add_argument("--bank", default="", help="对应 bank md (可选, "
                    "不提供则可溯率检查 N/A 如实标注)")
    ap.add_argument("--no-llm", action="store_true", help="只用规则仪表")
    ap.add_argument("--campaign", default="", help="落账战役名")
    ns = ap.parse_args()
    chapter = Path(ns.chapter)
    if not chapter.is_file():
        print("章节不存在: %s" % chapter, file=sys.stderr)
        return 2
    bank_p = Path(ns.bank) if ns.bank else None
    if bank_p and not bank_p.is_file():
        print("bank 不存在: %s" % bank_p, file=sys.stderr)
        return 2
    return run(chapter, bank_p, ns.no_llm, ns.campaign)


if __name__ == "__main__":
    raise SystemExit(main())
