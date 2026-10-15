# -*- coding: utf-8 -*-
"""ai_reviewer — AI 审稿人固定清单机检 (T-013A / REQ-028, 百倍V3).

REQ-028: 报告成稿门禁执行时运行 AI 审稿人（固定清单自动审稿），未过线不出厂。
「AI 审稿人」= 智能体可复跑的审稿器: 零 LLM 调用、全确定性机检——同一稿
任意重跑逐项同分 (数字零造假, 禁手拍)。

固定清单十项 (每项 0-10 分 + 依据行):
  ① structure  结构完整   标题层级/章节数对框架 (framework 在场以其章数为目标,
                          缺席按下限 ≥3 章); 线性给分, 封顶 10。
  ② density    密度三指标 复用 density_gate.metrics: redundancy_ratio(低优)/
                          new_ngram_rate(高优)/slop_density_per_kchar(低优),
                          各按带状映射 0-10 后取均值。
  ③ numeric    数字锚密度 含数字句占正文句比例 (满格 ≥50%)。
  ④ citation   引用锚密度 sup 标记 (<sup>/（源N/[Pnnnn]/来源：) 句占比 (满格 ≥30%)。
  ⑤ slop       套话密度   density_gate.slop_density_per_kchar (≤1.0/千字满格,
                          ≥5.0/千字 0 分)。
  ⑥ paragraph  段落长度   超长段 (>500 汉字) 占比惩罚; 标题/表格/引用块不计段。
  ⑦ terminology 术语一致性 高频术语 (拉丁缩写/「」造词, ≥2 次) 首个正文出现处
                          带定义线索 (括注/即·是指·简称/括号内中文全称) 占比。
  ⑧ counter    反证位     「反证/反例/风险/然而/不过/质疑/挑战/瓶颈/纠纷/争议/
                          处罚/但」类标记 ≥8 处满格。
  ⑨ judgment   判断三件套 「证据强度」/「反证检验」/判断卷 (结论·判断·一句话
                          总结·own_calc) 三族标记, 各族 ≥2 次满格, 按卷加权均权。
  ⑩ redteam    红队前置   调 redteam_run 最新产物 (work/redteam_<战役>.json 在档
                          优先只读; 缺席现场 dry 跑一轮不落盘); unanswered>0 → 0 分。

总分加权: 权重表按父指令入模块常量 WEIGHTS (十项合计 1.10, 归一口径):
  结构.10/密度.20/数字.15/引用.15/slop.10/段落.05/术语.05/反证.10/判断.10/红队.10
  total = Σ(score×w) / Σw × 100  (保留相对权重不变)
及格线 PASS_LINE=75 且红队项 >0 → verdict=pass; 否则 reject (未过线不出厂)。

落盘:
  work/ai_review_<campaign>.json            审稿清单与评分 (AC1)
  work/ai_review_rejects.jsonl              打回记录 (reject 追加; 未过线章节可查)

用法 (repo 根):
  py reforge_factory/ai_reviewer.py --draft <md> --campaign EPC-BID26 [--framework fw.md]
      [--work-dir X] [--pool-root Y] [--reject-log Z] [--dry]
退出码: pass→0 / reject→2 (对齐 redteam_run 门禁语义)。

真稿只读; 输出只增; 红队产物只读不改写。
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from collections import Counter
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

_HERE = Path(__file__).resolve().parent
if str(_HERE) not in sys.path:
    sys.path.insert(0, str(_HERE))
import density_gate as DG                                   # noqa: E402
import redteam_run as RT                                    # noqa: E402  (T-013 前置位)

__all__ = [
    "review", "WEIGHTS", "CHECKLIST", "PASS_LINE", "WEIGHT_SUM",
    "DEFAULT_WORK_DIR", "DEFAULT_REJECTS_PATH",
]

# ---------------------------------------------------------------- 常量
DEFAULT_WORK_DIR = RT.WORK_DIR          # V3 work/ (与 redteam_run 同目录)
DEFAULT_REJECTS_PATH = DEFAULT_WORK_DIR / "ai_review_rejects.jsonl"

# 固定清单十项: (key, 名称, 权重) — 权重合计 1.10, 总分按 Σw 归一 (见 docstring)
CHECKLIST: tuple[tuple[str, str, float], ...] = (
    ("structure",     "结构完整",   0.10),
    ("density",       "密度三指标", 0.20),
    ("numeric",       "数字锚密度", 0.15),
    ("citation",      "引用锚密度", 0.15),
    ("slop",          "slop套话密度", 0.10),
    ("paragraph",     "段落长度分布", 0.05),
    ("terminology",   "术语一致性", 0.05),
    ("counter",       "反证位",     0.10),
    ("judgment",      "判断三件套", 0.10),
    ("redteam",       "红队前置",   0.10),
)
WEIGHTS: dict[str, float] = {k: w for k, _, w in CHECKLIST}
WEIGHT_SUM: float = round(sum(WEIGHTS.values()), 4)      # 1.10 (父指令原表)
PASS_LINE: float = 75.0                                  # 总分≥75 且 红队项>0

DEFAULT_MIN_SECTIONS = 3          # framework 缺席时章节数下限
MIN_PROSE_CJK = 50                # 正文汉字低于此 → 机检项按 0 计 (防空转)
LONG_PARA_CJK = 500               # 超长段判定 (汉字数)

# 密度带状映射 (value: 分数 10→0 的线性区间端点)
REDUNDANCY_FULL_MAX, REDUNDANCY_ZERO_MIN = 0.30, 0.70    # 冗余: 低优
NGRAM_FULL_MIN, NGRAM_ZERO_MAX = 0.55, 0.25              # 新词率: 高优
SLOP_FULL_MAX, SLOP_ZERO_MIN = 1.0, 5.0                  # 套话/千汉字: 低优
NUMERIC_FULL = 0.50               # 数字句占比满格线
CITATION_FULL = 0.30              # 引用句占比满格线

CIT_ANCHOR_RE = re.compile(r"<sup>|（源\d|\(源\d|\[P\d{3,}\]|来源[：:]")
NUM_RE = re.compile(r"[0-9０-９]")
COUNTER_MARKS: tuple[str, ...] = (
    "反证", "反例", "风险", "然而", "不过", "质疑", "挑战", "瓶颈",
    "纠纷", "争议", "处罚", "但",
)
COUNTER_FULL = 8                  # 反证类标记满格处数

JUDGMENT_EVIDENCE_MARK = "证据强度"
JUDGMENT_COUNTER_MARK = "反证检验"
JUDGMENT_VOLUME_MARKS: tuple[str, ...] = ("结论", "判断", "一句话总结", "own_calc")
JUDGMENT_FAMILY_FULL = 2          # 各族标记 ≥2 次满格 (判断卷按出现量加权)

# 术语候选: 拉丁缩写 (≥2 字符, 排 P 锚/长编号/通用常识缩写) + 「」造词, 均 ≥2 次
TERM_MIN_FREQ = 2
TERM_TOP_K = 8
_ACR_RE = re.compile(r"[A-Z][A-Za-z0-9&\-\+]{1,11}")
_ACR_EXCLUDE_RE = re.compile(r"P\d{3,}(-P\d{3,})?|\d{4,}")   # P003533 / GF-2017-0201 类
UNIVERSAL_ACRONYMS = frozenset({"GDP", "AI", "PDF", "OK", "PS"})  # 通用常识缩写不计
_COIN_RE = re.compile(r"「([^」]{2,12})」")
_DEF_GLOSS_RE = r"{t}」?\s*[（(][^（）()]*[一-鿿][^（）()]*[）)]"
_DEF_PAREN_RE = r"[（(][^（）()]*[一-鿿][^（）()]*{t}"
_DEF_WORD_RE = r"{t}[^。]{{0,12}}(?:即|是指|简称|又称)"

_SENT_SPLIT_RE = re.compile(r"[。！？!?\n]+")
_HEADING_RE = re.compile(r"^#{1,3}\s+\S", re.M)
_CJK_RE = re.compile(r"[一-鿿]")


# ---------------------------------------------------------------- 小工具
def _clamp(x: float, lo: float = 0.0, hi: float = 10.0) -> float:
    return max(lo, min(hi, x))


def _band_low_good(value: float, full_max: float, zero_min: float) -> float:
    """低优指标 → 0-10 (≤full_max 满格 10, ≥zero_min 0 分, 中间线性)."""
    if value <= full_max:
        return 10.0
    if value >= zero_min:
        return 0.0
    return _clamp(10.0 * (zero_min - value) / (zero_min - full_max))


def _band_high_good(value: float, full_min: float, zero_max: float) -> float:
    """高优指标 → 0-10 (≥full_min 满格 10, ≤zero_max 0 分, 中间线性)."""
    if value >= full_min:
        return 10.0
    if value <= zero_max:
        return 0.0
    return _clamp(10.0 * (value - zero_max) / (full_min - zero_max))


def _body_lines(md_text: str) -> list[str]:
    """正文行 (剔除标题/表格/引用块行) — 术语首现与定义线索扫描域."""
    return [ln for ln in str(md_text or "").splitlines()
            if ln.strip() and not ln.lstrip().startswith(("#", "|", ">"))]


def _sentences(md_text: str) -> list[str]:
    """正文句 (含汉字的非空切分)."""
    return [s for s in (x.strip() for x in _SENT_SPLIT_RE.split(str(md_text or "")))
            if s and _CJK_RE.search(s)]


def _para_blocks(md_text: str) -> list[str]:
    """段落块 (空行分隔; 剔除标题/表格/引用/列表块与无汉字块)."""
    out = []
    for blk in re.split(r"\n\s*\n", str(md_text or "")):
        first = blk.lstrip()[:1]
        if not blk.strip() or first in ("#", "|", ">", "-") or not _CJK_RE.search(blk):
            continue
        out.append(blk)
    return out


def _weighted_total(scores: list[float]) -> float:
    """Σ(score×w)/Σw×10 — 0-100 制; 权重按父指令原表归一 (相对权重不变)."""
    ws = [w for _, _, w in CHECKLIST]
    return round(sum(s * w for s, w in zip(scores, ws)) / sum(ws) * 10.0, 1)


# ---------------------------------------------------------------- 十项机检
def _score_structure(md_text: str, framework: str | None) -> dict:
    n = len(_HEADING_RE.findall(md_text))
    if framework:
        target = len(RT.extract_chapters(framework)[0])      # 框架章数
        src = f"框架在场, 目标=框架章数 {target}"
    else:
        target = DEFAULT_MIN_SECTIONS
        src = f"框架缺席, 按默认下限 ≥{DEFAULT_MIN_SECTIONS} 章"
    target = max(1, target)
    score = _clamp(round(10.0 * n / target, 1))
    return {"score": score,
            "basis": f"标题 {n} 个 ({src}); 得分 {n}/{target}×10",
            "detail": {"n_sections": n, "target": target, "source": src}}


def _score_density(md_text: str) -> dict:
    m = DG.metrics(md_text)
    if m["cjk_chars"] < MIN_PROSE_CJK:
        return {"score": 0.0,
                "basis": f"正文汉字 {m['cjk_chars']} < {MIN_PROSE_CJK}, 密度不具判别力, 记 0",
                "detail": m}
    subs = {
        "redundancy_ratio": round(_band_low_good(
            m["redundancy_ratio"], REDUNDANCY_FULL_MAX, REDUNDANCY_ZERO_MIN), 1),
        "new_ngram_rate": round(_band_high_good(
            m["new_ngram_rate"], NGRAM_FULL_MIN, NGRAM_ZERO_MAX), 1),
        "slop_density_per_kchar": round(_band_low_good(
            m["slop_density_per_kchar"], SLOP_FULL_MAX, SLOP_ZERO_MIN), 1),
    }
    score = round(sum(subs.values()) / 3.0, 1)
    return {"score": score,
            "basis": (f"冗余 {m['redundancy_ratio']:.3f}→{subs['redundancy_ratio']} | "
                      f"新词率 {m['new_ngram_rate']:.3f}→{subs['new_ngram_rate']} | "
                      f"slop {m['slop_density_per_kchar']:.2f}/千字"
                      f"→{subs['slop_density_per_kchar']} (density_gate.metrics 实测)"),
            "detail": {"metrics": m, "sub_scores": subs}}


def _score_numeric(md_text: str) -> dict:
    sents = _sentences(md_text)
    if not sents:
        return {"score": 0.0, "basis": "无正文句, 数字锚无法评估",
                "detail": {"sentences": 0, "numeric": 0, "ratio": 0.0}}
    n = sum(1 for s in sents if NUM_RE.search(s))
    ratio = n / len(sents)
    score = _clamp(round(10.0 * ratio / NUMERIC_FULL, 1))
    return {"score": score,
            "basis": f"数字句 {n}/{len(sents)} ({ratio:.1%}); 满格线 {NUMERIC_FULL:.0%}",
            "detail": {"sentences": len(sents), "numeric": n,
                       "ratio": round(ratio, 4)}}


def _score_citation(md_text: str) -> dict:
    sents = _sentences(md_text)
    if not sents:
        return {"score": 0.0, "basis": "无正文句, 引用锚无法评估",
                "detail": {"sentences": 0, "cited": 0, "ratio": 0.0}}
    n = sum(1 for s in sents if CIT_ANCHOR_RE.search(s))
    ratio = n / len(sents)
    score = _clamp(round(10.0 * ratio / CITATION_FULL, 1))
    return {"score": score,
            "basis": (f"引用锚句 {n}/{len(sents)} ({ratio:.1%}); "
                      f"锚型 <sup>/（源N/[Pnnn]/来源：; 满格线 {CITATION_FULL:.0%}"),
            "detail": {"sentences": len(sents), "cited": n,
                       "ratio": round(ratio, 4)}}


def _score_slop(md_text: str) -> dict:
    m = DG.metrics(md_text)
    if m["cjk_chars"] < MIN_PROSE_CJK:
        return {"score": 0.0,
                "basis": f"正文汉字 {m['cjk_chars']} < {MIN_PROSE_CJK}, 记 0",
                "detail": m}
    score = round(_band_low_good(m["slop_density_per_kchar"],
                                 SLOP_FULL_MAX, SLOP_ZERO_MIN), 1)
    return {"score": score,
            "basis": (f"slop 命中 {m['slop_hits']} 处 / "
                      f"{m['slop_density_per_kchar']:.2f} 每千汉字 "
                      f"(≤{SLOP_FULL_MAX} 满格, ≥{SLOP_ZERO_MIN} 0 分)"),
            "detail": m}


def _score_paragraph(md_text: str) -> dict:
    paras = _para_blocks(md_text)
    if not paras:
        return {"score": 0.0, "basis": "未检出正文段落 (或正文过短), 记 0",
                "detail": {"paragraphs": 0}}
    lens = [len(_CJK_RE.findall(p)) for p in paras]
    n_long = sum(1 for x in lens if x > LONG_PARA_CJK)
    share = n_long / len(paras)
    score = _clamp(round(10.0 * (1.0 - share), 1))
    return {"score": score,
            "basis": (f"段落 {len(paras)} 块, 超长段(>{LONG_PARA_CJK}字) {n_long} 块 "
                      f"({share:.0%}); 中位段长 {sorted(lens)[len(lens) // 2]} 字"),
            "detail": {"paragraphs": len(paras), "long_paragraphs": n_long,
                       "share_long": round(share, 4),
                       "median_len": sorted(lens)[len(lens) // 2],
                       "max_len": max(lens)}}


def _term_candidates(md_text: str) -> list[str]:
    """高频术语候选: 拉丁缩写 + 「」造词 (各频次 ≥TERM_MIN_FREQ, 各取 Top-K)."""
    text = str(md_text or "")
    acr = Counter(t for t in _ACR_RE.findall(text)
                  if t not in UNIVERSAL_ACRONYMS and not _ACR_EXCLUDE_RE.search(t))
    coin = Counter(_COIN_RE.findall(text))
    out: list[str] = []
    for cnt in (acr, coin):
        out += [t for t, c in sorted(cnt.items(), key=lambda kv: (-kv[1], kv[0]))
                if c >= TERM_MIN_FREQ][:TERM_TOP_K]
    return out


def _has_definition_clue(term: str, line: str) -> bool:
    """首现行内定义线索: 括注 / 括号内中文全称 / 即·是指·简称·又称."""
    t = re.escape(term)
    return bool(re.search(_DEF_GLOSS_RE.replace("{t}", t), line)
                or re.search(_DEF_PAREN_RE.replace("{t}", t), line)
                or re.search(_DEF_WORD_RE.replace("{t}", t), line))


def _score_terminology(md_text: str) -> dict:
    text = str(md_text or "")
    if len(_CJK_RE.findall(text)) < MIN_PROSE_CJK:
        return {"score": 0.0,
                "basis": f"正文汉字 {len(_CJK_RE.findall(text))} < {MIN_PROSE_CJK}, 记 0",
                "detail": {"candidates": 0}}
    terms = _term_candidates(text)
    if not terms:
        return {"score": 0.0,
                "basis": f"未检出高频术语 (≥{TERM_MIN_FREQ} 次), 术语面无信号, 记 0",
                "detail": {"candidates": 0, "defined": []}}
    lines = _body_lines(text)
    defined, undefined = [], []
    for term in terms:
        first = next((ln for ln in lines if term in ln), None)
        if first is not None and _has_definition_clue(term, first):
            defined.append(term)
        else:
            undefined.append(term)
    score = _clamp(round(10.0 * len(defined) / len(terms), 1))
    show = "、".join(undefined[:5]) or "无"
    return {"score": score,
            "basis": (f"高频术语 {len(terms)} 个, 首现带定义线索 {len(defined)} 个 "
                      f"({len(defined) / len(terms):.0%}); 未定义: {show}"),
            "detail": {"candidates": len(terms), "defined": defined,
                       "undefined": undefined}}


def _score_counter(md_text: str) -> dict:
    text = str(md_text or "")
    per = {m: text.count(m) for m in COUNTER_MARKS}
    total = sum(per.values())
    hit = {k: v for k, v in per.items() if v}
    top = "/".join(f"{k}{v}" for k, v in
                   sorted(hit.items(), key=lambda kv: -kv[1])[:4])
    score = _clamp(round(10.0 * total / COUNTER_FULL, 1))
    return {"score": score,
            "basis": (f"反证类标记 {total} 处 ({top or '无'}); "
                      f"满格线 ≥{COUNTER_FULL} 处"),
            "detail": {"total": total, "per_mark": per}}


def _score_judgment(md_text: str) -> dict:
    text = str(md_text or "")
    fams = {
        "证据强度": text.count(JUDGMENT_EVIDENCE_MARK),
        "反证检验": text.count(JUDGMENT_COUNTER_MARK),
        "判断卷": sum(text.count(m) for m in JUDGMENT_VOLUME_MARKS),
    }
    if len(_CJK_RE.findall(text)) < MIN_PROSE_CJK and sum(fams.values()) == 0:
        return {"score": 0.0, "basis": "正文过短且无判断标记, 记 0",
                "detail": fams}
    subs = {k: min(1.0, v / JUDGMENT_FAMILY_FULL) for k, v in fams.items()}
    score = _clamp(round(10.0 * sum(subs.values()) / len(subs), 1))
    return {"score": score,
            "basis": (f"证据强度 {fams['证据强度']} / 反证检验 {fams['反证检验']} / "
                      f"判断卷 {fams['判断卷']} "
                      f"(各族 ≥{JUDGMENT_FAMILY_FULL} 次满格, 判断卷按量加权)"),
            "detail": {"family_counts": fams, "family_scaled": subs}}


def _redteam_state(campaign: str, framework: str | None,
                   work_dir: Path, pool_root: Path) -> dict:
    """红队前置位: 在档产物 work/redteam_<战役>.json 只读优先; 缺席现场 dry 跑
    (不落盘, 不碰他人 work/ 文件)."""
    product = Path(work_dir) / f"redteam_{campaign}.json"
    if product.is_file():
        try:
            data = json.loads(product.read_text(encoding="utf-8"))
        except json.JSONDecodeError:
            data = None
        if data is not None:
            return {"source": "product", "path": str(product),
                    "unanswered": [str(x) for x in (data.get("unanswered") or [])],
                    "exit_code": data.get("exit_code"),
                    "n_failure_paths": len(data.get("failure_paths") or []),
                    "framework_degraded": data.get("framework_degraded")}
    rep = RT.run(campaign, framework_md=framework, pool_root=pool_root,
                 work_dir=Path(work_dir), dry=True)
    return {"source": "live-dry-run", "path": None,
            "unanswered": [str(x) for x in rep["unanswered"]],
            "exit_code": rep["exit_code"],
            "n_failure_paths": len(rep["failure_paths"]),
            "framework_degraded": rep["framework_degraded"]}


def _score_redteam(state: dict) -> dict:
    n = len(state["unanswered"])
    score = 10.0 if n == 0 else 0.0
    src = (f"在档产物 {state['path']}" if state["source"] == "product"
           else "现场 dry 跑 (产物缺席, 不落盘)")
    basis = (f"红队轮前置: unanswered={n}"
             + (f" ({', '.join(state['unanswered'][:5])})" if n else "")
             + f" → {'放行' if n == 0 else '拦截'}; 来源: {src}")
    return {"score": score, "basis": basis, "detail": state}


# ---------------------------------------------------------------- 主入口
def review(draft_md: str, campaign: str, framework: str | None = None, *,
           work_dir: Path | str = DEFAULT_WORK_DIR,
           pool_root: Path | str = RT.POOL_ROOT,
           reject_log: Path | str | bool | None = None,
           source_file: str | None = None,
           dry: bool = False) -> dict:
    """固定清单机检一审: 十项评分 → work/ai_review_<campaign>.json.

    verdict: pass ⇔ 总分 ≥PASS_LINE 且 红队项 >0; 否则 reject 并追加打回记录
    (reject_log=None → work/ai_review_rejects.jsonl; False 关闭)。
    全确定性零 LLM: 同稿同参重跑逐项同分。
    """
    if not RT.CID_RE.fullmatch(campaign or ""):
        raise ValueError(f"campaign 非法: {campaign!r} (须匹配 {RT.CID_RE.pattern})")
    md_text = str(draft_md or "")
    work_dir = Path(work_dir)

    scorers = {
        "structure": lambda: _score_structure(md_text, framework),
        "density": lambda: _score_density(md_text),
        "numeric": lambda: _score_numeric(md_text),
        "citation": lambda: _score_citation(md_text),
        "slop": lambda: _score_slop(md_text),
        "paragraph": lambda: _score_paragraph(md_text),
        "terminology": lambda: _score_terminology(md_text),
        "counter": lambda: _score_counter(md_text),
        "judgment": lambda: _score_judgment(md_text),
        "redteam": lambda: _score_redteam(
            _redteam_state(campaign, framework, work_dir, Path(pool_root))),
    }
    checklist, scores = [], []
    for idx, (key, name, weight) in enumerate(CHECKLIST, start=1):
        res = scorers[key]()
        item = {"id": idx, "key": key, "item": name,
                "score": res["score"], "weight": weight,
                "weighted": round(res["score"] * weight, 3),
                "basis": res["basis"], "detail": res["detail"]}
        checklist.append(item)
        scores.append(res["score"])

    total = _weighted_total(scores)
    rt_item = next(i for i in checklist if i["key"] == "redteam")
    reasons = []
    if total < PASS_LINE:
        reasons.append(f"总分 {total} < 及格线 {PASS_LINE:g}")
    if rt_item["score"] <= 0:
        reasons.append("红队前置未过: " + rt_item["basis"])
    verdict = "pass" if not reasons else "reject"

    out_path = work_dir / f"ai_review_{campaign}.json"
    report = {
        "campaign": campaign,
        "engine": "ai_reviewer v3 (T-013A, REQ-028)",
        "generated": time.strftime("%Y-%m-%d %H:%M"),
        "source_file": source_file,
        "pass_rule": f"总分≥{PASS_LINE:g} 且 红队项>0 (未过线不出厂)",
        "weights": dict(WEIGHTS),
        "weight_sum": WEIGHT_SUM,
        "draft": {
            "cjk_chars": len(_CJK_RE.findall(md_text)),
            "prose_sentences": len(_sentences(md_text)),
            "n_sections": len(_HEADING_RE.findall(md_text)),
            "framework_given": bool(str(framework or "").strip()),
        },
        "checklist": checklist,
        "total_score": total,
        "redteam": rt_item["detail"],
        "verdict": verdict,
        "reject_reasons": reasons,
        "output_path": str(out_path),
    }
    if not dry:
        work_dir.mkdir(parents=True, exist_ok=True)
        out_path.write_text(json.dumps(report, ensure_ascii=False, indent=1),
                            encoding="utf-8")
        if verdict == "reject" and reject_log is not False:
            _record_reject(report, reject_log)
    return report


def _record_reject(report: dict, reject_log: Path | str | bool | None) -> Path:
    """打回记录追加 jsonl — 未过线章节可查 (REQ-028.AC1)."""
    p = Path(reject_log) if reject_log not in (None, True) else DEFAULT_REJECTS_PATH
    p.parent.mkdir(parents=True, exist_ok=True)
    rec = {
        "ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
        "campaign": report["campaign"],
        "source_file": report.get("source_file"),
        "verdict": report["verdict"],
        "total_score": report["total_score"],
        "blocked_by": report["reject_reasons"],
        "low_items": [{"key": i["key"], "item": i["item"], "score": i["score"]}
                      for i in report["checklist"] if i["score"] < 6.0],
        "review_path": report["output_path"],
    }
    with p.open("a", encoding="utf-8") as f:
        f.write(json.dumps(rec, ensure_ascii=False) + "\n")
    return p


# ---------------------------------------------------------------- CLI
def _main(argv: list[str]) -> int:
    ap = argparse.ArgumentParser(
        description="AI 审稿人: 固定清单十项机检, 未过线不出厂 (REQ-028)")
    ap.add_argument("--draft", required=True, help="待审章稿 md 路径 (只读)")
    ap.add_argument("--campaign", required=True)
    ap.add_argument("--framework", help="战役框架 md 路径 (缺席 → 结构项按默认下限)")
    ap.add_argument("--work-dir", default=str(DEFAULT_WORK_DIR))
    ap.add_argument("--pool-root", default=str(RT.POOL_ROOT))
    ap.add_argument("--reject-log", default=None,
                    help="打回记录 jsonl 路径 (默认 work/ai_review_rejects.jsonl)")
    ap.add_argument("--dry", action="store_true", help="只跑不落盘")
    ns = ap.parse_args(argv)
    draft_path = Path(ns.draft)
    fw = Path(ns.framework).read_text(encoding="utf-8") if ns.framework else None
    rep = review(draft_path.read_text(encoding="utf-8"), ns.campaign,
                 framework=fw, work_dir=Path(ns.work_dir),
                 pool_root=Path(ns.pool_root),
                 reject_log=Path(ns.reject_log) if ns.reject_log else None,
                 source_file=str(draft_path), dry=ns.dry)
    for it in rep["checklist"]:
        print(f"[review] {it['id']:>2} {it['item']} "
              f"{it['score']:>5.1f}/10 (w={it['weight']:.2f}) — {it['basis']}")
    print(f"[review] 总分 {rep['total_score']}/100 (及格线 {PASS_LINE:g}; "
          f"权重合计 {WEIGHT_SUM} 归一) → {rep['verdict'].upper()}")
    for r in rep["reject_reasons"]:
        print(f"[review] 打回: {r}")
    print(f"[review] → {rep['output_path']}")
    return 0 if rep["verdict"] == "pass" else 2


if __name__ == "__main__":
    sys.exit(_main(sys.argv[1:]))
