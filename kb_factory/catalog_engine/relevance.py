# -*- coding: utf-8 -*-
"""relevance —— A2 相关性过滤（KB-FACTORY 2.0 百倍质量战役·轴②×3）。

任务令：真调研池（pool 收割 FileMeta）在建树前先过相关性滤池——广告词/
空标题/纯数字/超短标题等噪声件不得混进编目树（证据树输入的入口质量门）。

纯规则实现：零 LLM、零网络、零随机源、零时钟，同输入必同输出；metas 只读
不改（kept 原样返回，dropped 为淘汰账记录）。evidence_tree.py 域外不碰——
本件只做「池 → (kept, dropped)」的滤池，接线在 evidence_cli（pool 后、建树前）。

打分口径（任务钉死三权 0.4/0.3/0.3 + 惩罚）：
    score(meta, purpose) → 0-1
      标题命中   0.4 × min(1, 命中关键词数 / 2)      —— purpose 关键词（≥2字）
                  在标题中的去重命中数，2 个即满权（长尾关键词难全中，比例
                  式打分 + 早饱和是防误杀的校准核心）
      摘要语料   0.3 × min(1, 命中关键词数 / 2)      —— extra.abstract /
                  extra.intro / extra.tags 三槽拼接语料同口径打分
      权威度     官方标准/统计 0.30 > 研报机构 0.18 > 文库UGC 0.10
                  渠道分级（CHANNEL_GRADE）与标题特征词（标准编号/统计公报/
                  研报词族）取最高档；渠道不可知且无特征词=unrated 0.0
                  （不猜不奖——零造假）
      惩罚       每项 -0.2（下限 0）：标题<6字 / 纯数字 / 广告词

阈值校准（任务令「mock 池（带正常标题）通过，负例（广告词/空标题）被汰」）：
    - 正常标题（命中 ≥2 关键词，或 ≥1 命中+任一权威档）≥ 0.35 通过；
    - 硬负例（广告词/纯数字/<6字）必带惩罚项，即便标题碰瓷命中关键词，
      0.4+0.3-0.2×n 也被压到阈值下；
    - 池级零信号护栏：全池无任何标题命中（关键词与池完全无交集——如测试
      stub 池配异域 purpose）时，分数无区分力，汰全池等于拿弱证据杀人，
      此时降级 penalty_only 模式（只汰硬负例，正常标题放行），账本如实记
      mode=penalty_only（禁静默）。

开关（接线在 evidence_cli）：KB_RELEVANCE 默认开（=1），0/false/off/no 关。
"""
from __future__ import annotations

import functools
import re

__all__ = ["score", "score_detail", "filter_pool", "pool_ledger",
           "grade_authority", "normalize_purpose", "DEFAULT_THRESHOLD",
           "W_TITLE", "W_ABSTRACT", "W_AUTHORITY", "PENALTY_STEP",
           "MIN_TITLE_LEN", "RELEVANCE_VERSION"]

RELEVANCE_VERSION = "relevance/2.0-a2"

# 三权 + 惩罚 + 阈值（任务钉死口径；THRESHOLD 由 filter_pool 形参可调）
W_TITLE, W_ABSTRACT, W_AUTHORITY = 0.4, 0.3, 0.3
PENALTY_STEP = 0.2
DEFAULT_THRESHOLD = 0.35
MIN_TITLE_LEN = 6          # 标题 <6 字（字符数，含拉丁/数字）触发惩罚
HIT_SATURATE = 2           # 命中关键词数达到 2 即满权（早饱和校准）

# ── 权威度分级（官方标准/统计 > 研报机构 > 文库UGC；按 channel+title 特征判级）──
GRADE_ORDER = {"ugc": 0, "research": 1, "official": 2}
AUTHORITY_SCORE = {"official": 0.30, "research": 0.18, "ugc": 0.10}
# unrated（渠道不可知且标题无特征词）= 0.0：不猜渠道不奖分（零造假）

CHANNEL_GRADE = {
    # 官方/标准/统计口（在役渠道暂无此档，预留渠道名 + 特征词升级双轨）
    "gb": "official", "std": "official", "gov": "official", "stats": "official",
    "sac": "official", "ndrc": "official", "mohurd": "official", "mwr": "official",
    # 研报/机构/学术口（研报渠道 / 知网学术 / 行业商会 / 正式出版物）
    "djyanbao": "research", "cnki": "research", "chinca": "research",
    "dangdang": "research",
    # 文库 UGC 口（人人可传，权威度按最低档计）
    "wenku": "ugc", "doc88": "ugc", "ima": "ugc",
}

# 标准编号特征（GB50500 / GB/T 51004 / SL 677 / JT/T 1218…；大写锚定防误配）
_STD_NUM_RE = re.compile(
    r"(?:GB|JGJ|SL|JT|CJJ|DL|NB|DB|HB|TB|YB)(?:/T)?\s?\d{2,5}")
OFFICIAL_WORDS = (
    "国家标准", "行业标准", "地方标准", "统计公报", "统计年鉴", "统计资料",
    "管理办法", "实施细则", "实施条例", "条例", "国务院", "住建部", "水利部",
    "交通运输部", "财政部", "发展改革委", "工业和信息化部", "国务院令", "部委令",
)
RESEARCH_WORDS = (
    "研究报告", "研报", "行业报告", "行业分析", "市场分析", "市场研究", "白皮书",
    "蓝皮书", "可行性研究", "调研报告", "咨询报告", "论文", "学报", "期刊",
    "年报", "季报", "中期报告", "深度分析", "行业洞察", "市场洞察", "投资策略",
)

# 广告/引流特征词（惩罚项；收录口径=下载站/引流页高频词，逐条可审计可扩充）
AD_WORDS = (
    "点击下载", "点击领取", "点击查看", "免费下载", "免费领取", "限时免费",
    "限时特价", "秒杀", "vip专享", "vip会员", "开通会员", "会员专享", "扫码关注",
    "关注公众号", "加微信", "微信扫码", "提取码", "优惠券", "低价出售", "甩卖",
    "代做", "代写", "包过", "保过", "刷单", "招代理", "推广链接",
)

# 纯数字标题字符闭集（ASCII/全角数字 + 中文数词 + 年月日期刊版次 + 常见分隔）
_NUM_CHARS = set("0123456789０１２３４５６７８９"
                 "一二两三四五六七八九十百千万亿"
                 "年月日号期版卷年第"
                 "·.,-_—/（）() ")


# ── purpose 归一（str 现场派生 / derive_purpose 结果 / 引擎 need 三形态）────

try:                                    # 包名全路径形态（kb_factory.catalog_engine.*）
    from . import purpose as _purpose
except ImportError:                     # pragma: no cover - sys.path 直挂 catalog_engine/
    import purpose as _purpose


@functools.lru_cache(maxsize=128)
def _keywords_cached(text: str) -> tuple:
    """str → purpose 关键词（进程内缓存；derive_purpose 纯规则确定性，可缓存）。"""
    kws = []
    for k in _purpose.derive_purpose(text)["keywords"]:
        k = str(k).strip().upper()       # 拉丁 token 统一大写（EPC/epc 同权）
        if len(k) >= 2 and k not in kws:  # 单字词噪声大，不参与命中计数
            kws.append(k)
    return tuple(kws)


def normalize_purpose(purpose):
    """purpose 入参归一 → (text, keywords 元组)。
    str=一句话需求现场派生；dict=derive_purpose 结果或引擎 need
    （有非空 keywords 直接用——需求侧人工词最可信；否则由 text/domain 派生）。"""
    if isinstance(purpose, str):
        t = purpose.strip()
        return t, _keywords_cached(t)
    if isinstance(purpose, dict):
        kws = purpose.get("keywords")
        if isinstance(kws, list) and kws:
            out = []
            for k in kws:
                k = str(k).strip().upper()
                if len(k) >= 2 and k not in out:
                    out.append(k)
            if out:
                t = " ".join(str(x) for x in (purpose.get("text"),
                                              purpose.get("domain")) if x)
                return t.strip(), tuple(out)
        t = " ".join(str(x) for x in (purpose.get("text"), purpose.get("domain"),
                                      purpose.get("intent")) if x).strip()
        return t, _keywords_cached(t)
    raise ValueError("purpose 必须是 str / 引擎 need dict / derive_purpose 结果 dict，"
                     f"得到 {type(purpose).__name__}")


# ── FileMeta 取值垫片（dict 与对象双兼容，只读不改；口径同 evidence_tree._m）──

def _field(meta, key, default=None):
    if isinstance(meta, dict):
        return meta.get(key, default)
    return getattr(meta, key, default)


def _title_of(meta) -> str:
    return str(_field(meta, "title") or "").strip()


def _channel_of(meta) -> str:
    """渠道名：top-level channel → extra.channel → 空（不可知，不猜）。"""
    ch = _field(meta, "channel")
    if not ch:
        extra = _field(meta, "extra") or {}
        if isinstance(extra, dict):
            ch = extra.get("channel")
    return str(ch or "")


def _abstract_corpus(meta) -> str:
    """摘要语料：extra.abstract / intro / tags 三槽拼接（tags 容 list；缺席=空串）。"""
    extra = _field(meta, "extra") or {}
    if not isinstance(extra, dict):
        return ""
    parts = []
    for key in ("abstract", "intro", "tags"):
        v = extra.get(key)
        if isinstance(v, (list, tuple)):
            parts.append(" ".join(str(x) for x in v))
        elif v:
            parts.append(str(v))
    return " ".join(p for p in parts if p)


# ── 权威度判级（channel 分级 + 标题特征词升级，取最高档；不降级不猜）────────

def grade_authority(meta):
    """权威度判级 → (grade, basis)。
    grade ∈ official/research/ugc/unrated；basis={channel_grade, title_grade}
    如实记触发源（审计可对账）。"""
    ch = _channel_of(meta)
    ch_grade = CHANNEL_GRADE.get(ch.strip().lower())
    title = _title_of(meta).upper()
    title_grade = None
    if _STD_NUM_RE.search(title) or any(w in title for w in OFFICIAL_WORDS):
        title_grade = "official"
    elif any(w in title for w in RESEARCH_WORDS):
        title_grade = "research"
    picks = [g for g in (ch_grade, title_grade) if g]
    if not picks:
        return "unrated", {"channel_grade": None, "title_grade": None}
    best = max(picks, key=lambda g: GRADE_ORDER[g])
    return best, {"channel_grade": ch_grade, "title_grade": title_grade}


# ── 惩罚项（标题<6字 / 纯数字 / 广告词；每项 -0.2）──────────────────────────

def _penalties(title: str) -> list:
    """硬负例检查 → 惩罚原因码列表（确定性序：ad_word > pure_number > title_short）。"""
    out = []
    if any(w in title for w in AD_WORDS):
        out.append("ad_word")
    chars = [c for c in title if not c.isspace()]
    if chars and any(c.isdigit() for c in chars) and all(c in _NUM_CHARS for c in chars):
        out.append("pure_number")        # 非空且全为数字/数词/年月日分隔
    if len(title) < MIN_TITLE_LEN:
        out.append("title_short")
    return out


# ── 打分（纯函数，meta 只读）───────────────────────────────────────────────

def score_detail(meta, purpose) -> dict:
    """单件打分明细（审计/测试口）：分项 + 惩罚 + 判级依据 + 原因码，全如实。"""
    _, kws = normalize_purpose(purpose)
    title = _title_of(meta)
    title_up = title.upper()
    hits_title = sum(1 for k in kws if k in title_up)
    corpus = _abstract_corpus(meta).upper()
    hits_abs = sum(1 for k in kws if k in corpus) if corpus else 0
    grade, basis = grade_authority(meta)
    t = round(W_TITLE * min(1.0, hits_title / HIT_SATURATE), 4)
    a = round(W_ABSTRACT * min(1.0, hits_abs / HIT_SATURATE), 4)
    au = AUTHORITY_SCORE.get(grade, 0.0)
    pens = _penalties(title)
    total = round(max(0.0, min(1.0, t + a + au - PENALTY_STEP * len(pens))), 4)
    return {"score": total, "title_hit": t, "abstract_hit": a,
            "authority": au, "grade": grade, "grade_basis": basis,
            "hits_title": hits_title, "hits_abstract": hits_abs,
            "keywords_n": len(kws), "penalties": pens}


def score(meta, purpose) -> float:
    """单件相关性总分（0-1，4 位小数；任务口径三权-惩罚）。"""
    return score_detail(meta, purpose)["score"]


# ── 滤池（filter_pool / pool_ledger；metas 只读，kept 原样返回）────────────

def pool_ledger(metas, purpose, threshold: float = DEFAULT_THRESHOLD):
    """全池滤池 + 淘汰账 → (kept, dropped, ledger)。
    - kept：通过件原对象列表（序保持，零拷贝零改动）；
    - dropped：淘汰账 [{index, title, channel, score, reasons}]（如实可对账）；
    - ledger：provenance.relevance 落点（kept/dropped/top_score/avg 四钉键 +
      threshold/harvested/mode/signal_docs/drop_reasons/avg_kept/version 审计键；
      空池 top_score/avg=None 不记 0.0 冒充）。
    模式：池内有标题命中信号 → threshold 模式（score<threshold 汰）；
    全池零信号 → penalty_only 模式（只汰硬负例；校准决策见模块 docstring）。"""
    metas = list(metas or [])
    details = [score_detail(m, purpose) for m in metas]
    signal_docs = sum(1 for d in details if d["hits_title"] >= 1)
    mode = "threshold" if signal_docs > 0 else "penalty_only"
    kept, dropped, kept_scores = [], [], []
    for i, (m, d) in enumerate(zip(metas, details)):
        hard = bool(d["penalties"])
        out = d["score"] < threshold if mode == "threshold" else hard
        if out:
            reasons = list(d["penalties"])
            if mode == "threshold":
                reasons.append("below_threshold")
            dropped.append({"index": i, "title": _title_of(m),
                            "channel": _channel_of(m) or None,
                            "score": d["score"], "reasons": reasons})
        else:
            kept.append(m)
            kept_scores.append(d["score"])
    # 原因分布：每件计首因（惩罚项优先于 below_threshold，序同 _penalties）
    drop_reasons: dict = {}
    for rec in dropped:
        first = rec["reasons"][0]
        drop_reasons[first] = drop_reasons.get(first, 0) + 1
    scores = [d["score"] for d in details]
    ledger = {
        "kept": len(kept), "dropped": len(dropped),
        "top_score": max(scores) if scores else None,
        "avg": round(sum(scores) / len(scores), 4) if scores else None,
        "harvested": len(metas), "threshold": threshold, "mode": mode,
        "signal_docs": signal_docs, "drop_reasons": drop_reasons,
        "avg_kept": round(sum(kept_scores) / len(kept_scores), 4)
        if kept_scores else None,
        "version": RELEVANCE_VERSION,
    }
    return kept, dropped, ledger


def filter_pool(metas, purpose, threshold: float = DEFAULT_THRESHOLD):
    """任务钉死签名：全池滤池 → (kept, dropped)。淘汰账/口径细节用 pool_ledger。"""
    kept, dropped, _ = pool_ledger(metas, purpose, threshold=threshold)
    return kept, dropped
