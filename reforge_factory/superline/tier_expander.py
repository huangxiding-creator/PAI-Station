# -*- coding: utf-8 -*-
"""S0-2 词表生成器 (超级生产线) — 企业名六槽展开 → tiers 草稿.

六槽 (框架 v1 增量件 2): 企业名/母公司/曾用名/核心子公司/旗舰项目/竞争对手.

流水:
  ① 报告名 → 企业全称 (剥《》/怎么干…问式后缀)
  ② 规则变体链: 法人后缀链剥 → 领域尾词链剥 (每步 ≥4 字保留) + 前缀摘除
     (中石化|南京工程有限公司 形) — 纯函数确定性, 零检索
  ③ 存量扫描 (先存量后增量, 全离线): 池 manifest source_path 文件名 /
     战役 research_config.json + search_keywords.json / 02·04 语料文件名 /
     先前战役 tiers.json T2 — 频次门挖别名 (缩略词 ≥3 位 / 含地名前缀复合词;
     战役行分桶优先 — 共性语料的地名前缀噪声挤不进战役桶)
  ④ 缺槽可选免费检索面单查补 (--online: zh-search-pro → anysearch,
     best-effort; 回放模式绝不触网)
  ⑤ 产出 tiers_draft.{json,md} 草稿 + 每词槽位溯源.

纪律:
- tiers.json 绝不自动写 — 草稿人工过目定稿, 真词表变更须 RUN_LEDGER 留痕.
- 全程免费渠道 (ZERO_PAID 机检锚: 无网络根模块 import; 检索腿仅 subprocess
  免费面 CLI 且 opt-in).
- 底座=FT-6 entity_coverage: entity_seed() 把 T1/T2 词喂进实体覆盖账本
  NAMES 段 (五类实体记账的覆盖闭环起点).
- 回放: 3 已完成战役离线确定性回放, 生成词表对实际 T1 词召回 ≥90%.

用法:
  python superline/tier_expander.py --title "《X公司怎么干EPC总承包？》" \
      [--battle-dir D] [--pool CID] [--online]
  python superline/tier_expander.py --replay superline/tier_replay_manifest.json
"""
from __future__ import annotations

import json
import re
import sys
import time
from collections import Counter
from pathlib import Path

_ROOT = str(Path(__file__).resolve().parents[1])   # reforge_factory 根
if _ROOT not in sys.path:
    sys.path.insert(0, _ROOT)

import superline as _sl                            # noqa: E402

# ---------- 补丁口 (测试 monkeypatch 这四个) ----------
STATION = Path(r"E:\AI-Station")
POOL_ROOT = STATION / "ammo_pool"
RESEARCH_TOPICS = STATION / "ResearchFactory-Eng" / "ResearchTopics"
REPLAY_OUT = Path(__file__).resolve().parent / "replay_out_tier"

SIX_SLOTS = ("company", "parent", "former_names", "subsidiaries",
             "flagship_projects", "competitors")
SLOT_CN = {"parent": "母公司", "former_names": "曾用名",
           "subsidiaries": "核心子公司", "flagship_projects": "旗舰项目",
           "competitors": "竞争对手"}   # online 腿单查词 (缺槽补查)
ZERO_PAID = True                    # 结构性零付费 (ast 机检锚)
MIN_VARIANT_CHARS = 4               # 链剥最短保留长度
ALIAS_FREQ_MIN = 2                  # 存量别名频次门
ALIAS_MAX = 40                      # 每槽存量别名上限 (防草稿膨胀)
NGRAM_MAX = 10                      # 复合词候选最长
ACRONYM_MIN = 3                     # 缩略词最短 (SNEI/SEDC=4)
TIME_BUDGET_SEC = 30 * 60           # 单战役预算 (验收: <30min)

# 法人后缀 (长在前, 链剥)
LEGAL_SUFFIXES = ("股份有限公司", "有限责任公司", "有限公司",
                  "集团公司", "公司", "集团")
# 领域尾词 (长在前, 逐个链剥: 中石化南京工程→中石化南京)
TAIL_TOKENS = ("工程技术", "工程设计", "设计咨询", "工程管理", "研究设计",
               "工程", "技术", "设计", "咨询", "研究", "国际")
# 停用词: 命中 (含子串) 即弃 — 目录名/问式/泛词防污染
# (注: 集团/公司 尾是母公司/法人信号, 集团不入停用 — 中石化集团形母公司别名靠它进门)
STOP_CN = ("怎么干", "如何做", "怎么做", "总承包", "有限公司", "有限责任",
           "股份有限", "公司", "项目管理", "网络调研", "搜集的资料",
           "搜集资料", "微信文章", "研究报告", "报告需求", "最终报告",
           "质量飞轮", "宣传成果", "生成指令", "根基知识", "对标资料",
           "粗加工", "待上传", "初次", "补充", "怎么", "需求", "资料",
           "成果", "简介", "官网",
           "被告", "原告", "法院", "判决", "裁定", "裁判", "上诉", "再审",
           "仲裁")   # 司法语料语境 (裁判文书池的地名前缀噪声)
STOP_ACRONYM = frozenset({
    "EPC", "EP", "PPP", "BOT", "BOO", "OEM", "PMC", "PDF", "CNKI", "PMI",
    "PC", "URL", "HTML", "HTTP", "API", "AI", "II", "III", "LTD", "CO",
    "GDP", "CBA", "CEO", "CFO", "ISO", "BIM", "CAD"})

_CJK_RUN = re.compile(r"[\u4e00-\u9fff]+")
_ACRONYM = re.compile(r"[A-Z]{2,8}")
_ACRO_ORG = re.compile(r"([A-Z]{3,8})(?=公司|集团|院)")   # SEDC公司 形
ORG_TAIL = ("院", "所", "公司", "集团", "中心")            # 组织尾词 (加权类)
_TITLE_Q = re.compile(r"^(《)?(?P<n>.+?)(怎么干|如何做|怎么做|如何干).*$")


# ---------- ① 报告名 → 企业全称 ----------
def extract_company_name(title: str) -> str:
    """《中石化南京工程有限公司怎么干EPC总承包？》 → 中石化南京工程有限公司.

    非问式标题原样透传 (视为已是企业全称)."""
    t = (title or "").strip().strip("《》").replace("？", "").replace("?", "")
    m = _TITLE_Q.match(t)
    return (m.group("n") if m else t).strip()


# ---------- ② 规则变体链 (纯函数, 零检索) ----------
def _strip_legal(name: str) -> str:
    """链剥法人后缀 (长在前): 中石化南京工程有限公司 → 中石化南京工程."""
    cur = name
    while True:
        hit = next((s for s in LEGAL_SUFFIXES if cur.endswith(s)), None)
        if hit is None or len(cur) - len(hit) < MIN_VARIANT_CHARS:
            return cur
        cur = cur[: -len(hit)]


def name_variants(full: str) -> list[dict]:
    """企业全称 → 变体清单 [{word, rule}] — T1 召回的主引擎.

    链剥: 法人后缀 → 领域尾词逐个 (每步 ≥4 字保留);
    前缀摘除: 全称去头 2-4 字 (remainder ≥6) — 中石化|南京工程有限公司 形."""
    out: list[dict] = [{"word": full, "rule": "rule:full"}]
    core = _strip_legal(full)
    if core != full and len(core) >= MIN_VARIANT_CHARS:
        out.append({"word": core, "rule": "rule:legal-strip"})
    cur = core
    while True:
        hit = next((t for t in TAIL_TOKENS if cur.endswith(t)), None)
        if hit is None:
            break
        nxt = cur[: -len(hit)]
        if len(nxt) < MIN_VARIANT_CHARS:
            break
        out.append({"word": nxt, "rule": "rule:tail-strip"})
        cur = nxt
    for k in (2, 3, 4):                       # 前缀摘除 (品牌前缀去头)
        cand = full[k:]
        if len(cand) >= 6:
            out.append({"word": cand, "rule": f"rule:prefix-drop-{k}"})
    seen, uniq = set(), []
    for v in out:                             # 去重保序 + 免疫入参突变
        if v["word"] not in seen:
            seen.add(v["word"])
            uniq.append({**v})
    return uniq


def _place2(variants: list[dict]) -> set[str]:
    """地名/品牌前缀二元组 (仅链剥变体 — 前缀摘除变体的头是内域词, 不作门)."""
    return {v["word"][:2] for v in variants
            if v["rule"].startswith("rule:full")
            or v["rule"].startswith("rule:legal-strip")
            or v["rule"].startswith("rule:tail-strip")}


# ---------- ③ 存量扫描 (全离线) ----------
def _gate(line: str, places: set[str]) -> bool:
    """共现门: 行内含任一地名/品牌前缀 (manifest 行的 source_path 天然含
    战役目录名 → 池内行几乎全过门; NB 共性卷等无关行被挡)."""
    return any(p in line for p in places)


def _place_windows(run: str, places: set[str]) -> list[str]:
    """含 places 的窗口候选 (每次命中向两侧展开 ≤NGRAM_MAX 字, 长 ≥3)."""
    out = []
    for p in places:
        start = run.find(p)
        while start != -1:
            for s in range(max(0, start - NGRAM_MAX + 2), start + 1):
                for e in range(start + 2, min(len(run), s + NGRAM_MAX) + 1):
                    if e - s >= 3:
                        out.append(run[s:e])
            start = run.find(p, start + 1)
    return out


def _clean(word: str) -> bool:
    """停用门: 词内含任一停用子串即弃 (问式/目录名/泛词)."""
    return not any(s in word for s in STOP_CN)


def _is_variant_trunc(w: str, vset: set[str]) -> bool:
    """变体左截断窗: w(≥5字, 非变体自身) 是某变体的真前缀 — 10 字窗上限
    切长名产生的假词 (四川电力设计咨询有…); 母公司品牌前缀 ≤4 字与
    恰为变体的短前缀 (中石化南京工程⊂全称) 不受影响."""
    return (len(w) >= 5 and w not in vset
            and any(v.startswith(w) and v != w for v in vset))


def mine_aliases(variants: list[dict], manifest_paths: list[Path],
                 extra_texts: list[str],
                 battle_anchor: str = "") -> dict:
    """存量别名挖掘 → 四桶 {cjk_battle, cjk_pool, acronyms_battle,
    acronyms_pool} (每桶 [(w, freq)]).

    分桶: 战役行 (source_path 含战役目录名) 优先 — 共性语料 (裁判文书等)
    的地名前缀高频噪声挤不进战役桶; 频次门 ALIAS_FREQ_MIN; CJK 窗口须含
    地名前缀且非变体截断/停用; 缩略词 [A-Z]{3,8} 且非停用.
    加权类 (挤不进 top 帽的组织词救回): 组织尾词 ORG_TAIL 结尾的 CJK 窗口
    (中电建四川院 形) ∪ 机构邻接缩略词 (SEDC公司 形) 排在频次类前.
    判定源=盘上账本, 不信模型自评."""
    places = _place2(variants)
    vset = {v["word"] for v in variants}
    buckets = {b: (Counter(), Counter(), Counter())   # (acro, cjk, adj)
               for b in ("battle", "pool")}

    def _count(text: str, acro: Counter, cjk: Counter,
               adj: Counter) -> None:
        for a in _ACRONYM.findall(text):
            if len(a) >= ACRONYM_MIN and a not in STOP_ACRONYM:
                acro[a] += 1
        for a in _ACRO_ORG.findall(text):
            adj[a] += 1
        for run in _CJK_RUN.findall(text):
            for w in _place_windows(run, places):
                if _clean(w) and not _is_variant_trunc(w, vset):
                    cjk[w] += 1

    for mp in manifest_paths:
        try:
            with open(mp, encoding="utf-8", errors="ignore") as f:
                for line in f:
                    if not _gate(line, places):
                        continue
                    _count(line, *buckets[
                        "battle" if battle_anchor and battle_anchor in line
                        else "pool"])
        except OSError:
            continue
    for text in extra_texts:                 # config/keywords/语料名=战役源
        if text:
            _count(text, *buckets["battle" if battle_anchor else "pool"])

    def _pick(c: Counter, cap: int, boost, boost_min: int) -> list:
        # boost_min: 加权类放宽频次门 — 机构邻接缩略词 (SEDC公司形) 单次即
        # 强组织信号 (真实论文标题), 泛词 (PPT/OCR) 无加权仍须 ≥频次门.
        items = [(w, f) for w, f in c.items()
                 if f >= (boost_min if boost(w) else ALIAS_FREQ_MIN)]
        items.sort(key=lambda wf: (0 if boost(wf[0]) else 1,
                                   -wf[1], wf[0]))
        return items[:cap]

    out = {}
    for b in ("battle", "pool"):
        acro, cjk, adj = buckets[b]
        cap = ALIAS_MAX if b == "battle" else 20
        out[f"acronyms_{b}"] = _pick(
            acro, cap, lambda a, _adj=adj: _adj.get(a, 0) > 0, boost_min=1)
        out[f"cjk_{b}"] = _pick(
            cjk, cap, lambda w: w.endswith(ORG_TAIL),
            boost_min=ALIAS_FREQ_MIN)
    return out


def _read_json(p: Path) -> dict:
    try:
        return json.loads(p.read_text(encoding="utf-8"))
    except Exception:
        return {}


def _walk_names(battle_dir: Path) -> str:
    """02/04 前缀子目录文件名拼接 (语料文件名即词面存量, 不读正文)."""
    parts = []
    if battle_dir.is_dir():
        for sub in sorted(battle_dir.iterdir()):
            if sub.is_dir() and sub.name.startswith(("02", "04")):
                for p in sub.rglob("*"):
                    if p.is_file():
                        parts.append(p.stem)
    return " ".join(parts[:3000])


def _battle_stock(battle_dir: str) -> dict:
    """战役目录存量: research_config / search_keywords / 语料文件名."""
    bd = Path(battle_dir) if battle_dir else None
    if bd is None or not bd.is_dir():
        return {"config": {}, "keywords": {}, "names": ""}
    cfg = _read_json(bd / "research_config.json")
    for key in ("research_config", "enterprise_config"):
        cfg = cfg or _read_json(bd / f"{key}.json")
    kw = _read_json(bd / "search_keywords.json")
    return {"config": cfg, "keywords": kw, "names": _walk_names(bd)}


def _prior_t2(own_pool: str) -> list[dict]:
    """先前战役 tiers.json 的 T2 (竞对槽存量; 排除自家池防自证)."""
    out = []
    if POOL_ROOT.is_dir():
        for td in sorted(POOL_ROOT.iterdir()):
            tj = td / "tiers.json"
            if not td.is_dir() or not tj.is_file() or td.name == own_pool:
                continue
            t2 = (_read_json(tj).get("T2")) or []
            out += [{"word": w, "pool": td.name} for w in t2]
    return out


def _config_lists(cfg: dict, kw: dict) -> dict:
    """config + search_keywords 里的六槽原料 (keywords._competitors 深挖)."""
    kwc = []
    for ks in (kw.get("keyword_sets") or []):
        kwc += ((ks.get("keywords") or {}).get("_competitors") or [])
    return {
        "target": (cfg.get("research_target") or cfg.get("enterprise_name")
                   or ""),
        "short": cfg.get("short_name") or "",
        "flagship": list(cfg.get("flagship_projects") or [])[:30],
        "competitors": list(cfg.get("competitors") or []) + kwc,
        "parent": cfg.get("parent_company") or "",
        "former": list(cfg.get("former_names") or []),
        "subsidiaries": list(cfg.get("subsidiaries") or []),
    }


# ---------- ④ 免费检索腿 (opt-in, best-effort, 可注入) ----------
def _free_search(query: str) -> list[str]:
    """缺槽免费面单查补: zh-search-pro → anysearch (subprocess 免费面 CLI).

    生产专用; 回放/单测全程不触 (测试 monkeypatch 此口). 返回词面清单,
    失败=空清单 (诚实空优于臆造)."""
    import subprocess
    out: list[str] = []
    for cli in ("zh-search-pro", "anysearch"):
        try:
            r = subprocess.run([cli, "search", query], capture_output=True,
                               text=True, timeout=60, check=False,
                               creationflags=getattr(
                                   subprocess, "CREATE_NO_WINDOW", 0))
            out += [ln.strip() for ln in (r.stdout or "").splitlines()
                    if 2 <= len(ln.strip()) <= 30]
            if out:
                break
        except Exception:
            continue
    return out


# ---------- ⑤ 主口: 六槽展开 ----------
def expand(title: str, battle: str = "", battle_dir: str = "",
           pool_id: str = "", online: bool = False) -> dict:
    """报告名 → tier_expander_v1 草稿 doc (先存量, 回放离线确定性)."""
    t0 = time.time()
    full = extract_company_name(title) or title
    variants = name_variants(full)
    stock = _battle_stock(battle_dir)
    cl = _config_lists(stock["config"], stock["keywords"])
    manifest = ([POOL_ROOT / pool_id / "manifest.jsonl"]
                if pool_id and (POOL_ROOT / pool_id / "manifest.jsonl").is_file()
                else [])
    extra = [json.dumps(stock["config"], ensure_ascii=False),
             json.dumps(stock["keywords"], ensure_ascii=False),
             stock["names"]]
    anchor = Path(battle_dir).name if battle_dir else ""
    mined = mine_aliases(variants, manifest, extra, battle_anchor=anchor)
    vwords = {v["word"] for v in variants}

    def _w(word: str, source: str, freq: int = 0) -> dict:
        return {"word": word, "source": source, "freq": freq}

    def _src(bucket: str) -> str:
        base = (f"stock:manifest:{pool_id}" if manifest
                else "stock:battle-dir")
        return f"{base}/{bucket}"

    # 母公司候选: 集团尾词 ∪ 全称前缀命中存量的短词 (中石化/中电建形)
    heads = {full[:k] for k in (2, 3, 4)}
    parent_cands = {w for w, f in (mined["cjk_battle"] + mined["cjk_pool"])
                    if w.endswith("集团") or w in heads}
    parent_words = ([_w(cl["parent"], "config:research_config")]
                    if cl["parent"] else [])
    company_stock = []
    for bucket in ("battle", "pool"):        # 战役桶优先, 池桶垫后
        for w, f in mined[f"cjk_{bucket}"]:
            if w in parent_cands:
                parent_words.append(_w(w, _src(bucket), f))
            elif w not in vwords:
                company_stock.append(_w(w, _src(bucket), f))
        company_stock += [_w(a, _src(bucket), f)
                          for a, f in mined[f"acronyms_{bucket}"]]
    company_words = ([_w(v["word"], v["rule"]) for v in variants]
                     + company_stock)
    t2_pool = _prior_t2(pool_id)
    comp_seen, comp_words = set(), []
    for w in cl["competitors"] + [p["word"] for p in t2_pool]:
        if w and w not in comp_seen:
            comp_seen.add(w)
            pool_of = next((p["pool"] for p in t2_pool
                            if p["word"] == w), "")
            comp_words.append(_w(w, "config" if w in cl["competitors"]
                                 else f"prior_tiers:{pool_of}.T2"))
    slots = {
        "company": {"status": "filled", "words": company_words},
        "parent": {"status": "filled" if parent_words else "查无",
                   "words": parent_words},
        "former_names": {"status": "filled" if cl["former"] else "查无",
                         "words": [_w(w, "config:research_config")
                                   for w in cl["former"]]},
        "subsidiaries": {"status": "filled" if cl["subsidiaries"] else "查无",
                         "words": [_w(w, "config:research_config")
                                   for w in cl["subsidiaries"]]},
        "flagship_projects": {"status": "filled" if cl["flagship"] else "查无",
                              "words": [_w(w, "config:research_config")
                                        for w in cl["flagship"]]},
        "competitors": {"status": "filled" if comp_words else "查无",
                        "words": comp_words},
    }
    if online:                                   # 生产: 缺槽免费面单查补
        for slot in SIX_SLOTS:
            if slots[slot]["status"] != "查无":
                continue
            got = _free_search(f"{full} {SLOT_CN.get(slot, slot)}")
            if got:
                slots[slot] = {"status": "filled",
                               "words": [_w(g, "free_search", 0)
                                         for g in got[:10]]}
    t1 = list(dict.fromkeys(w["word"] for w in company_words))
    t3 = [w for w in ("EPC总承包", "工程总承包", "EPC") if w in title]
    return {"schema": "tier_expander_v1", "battle": battle or pool_id or "",
            "title": title, "company": full, "slots": slots,
            "t1_draft": t1, "t2_draft": [w["word"] for w in comp_words],
            "t3_draft": t3, "honest_empty": [s for s in SIX_SLOTS
                                             if slots[s]["status"] == "查无"],
            "note": "草稿: 人工过目定稿; 绝不自动写 tiers.json",
            "zero_paid": ZERO_PAID, "elapsed_sec": round(time.time() - t0, 2),
            "version": _sl.__version__}


def entity_seed(doc: dict) -> dict:
    """FT-6 entity_coverage 底座接线: T1/T2 词 → NAMES 段种子."""
    return {"topic": doc["company"], "NAMES": doc["t1_draft"][:20]
            + doc["t2_draft"][:10]}


# ---------- 落盘 (草稿, 绝不写 tiers.json) ----------
def _md(doc: dict) -> str:
    lines = [f"# S0-2 词表草稿 — {doc['battle'] or doc['company']}", "",
             f"- 报告名: {doc['title']}", f"- 企业全称: {doc['company']}",
             f"- T1 草稿 {len(doc['t1_draft'])} 词 | T2 草稿 "
             f"{len(doc['t2_draft'])} 词 | T3 种子 {doc['t3_draft']}",
             f"- 诚实空槽: {doc['honest_empty'] or '无'} | 零付费 "
             f"{doc['zero_paid']} | 用时 {doc['elapsed_sec']}s", "",
             f"> {doc['note']}", ""]
    for slot in SIX_SLOTS:
        s = doc["slots"][slot]
        lines.append(f"## {slot} [{s['status']}]")
        lines += [f"- {w['word']}  ← {w['source']}"
                  + (f" (×{w['freq']})" if w.get("freq") else "")
                  for w in s["words"][:20]]
        if len(s["words"]) > 20:
            lines.append(f"- …共 {len(s['words'])} 词")
        lines.append("")
    return "\n".join(lines) + "\n"


def render(doc: dict, battle_dir: str = "", battle: str = "",
           replay_mode: bool = False) -> Path:
    """tiers_draft.{json,md}: 正式→战役 00 前缀子目录 (fallback 战役根);
    回放→仅 replay_out_tier/<battle>/ (绝不污染真实战役目录/tiers.json)."""
    if replay_mode:
        out = REPLAY_OUT / (battle or doc["battle"] or "adhoc")
    else:
        bd = Path(battle_dir) if battle_dir else None
        out = None
        if bd is not None and bd.is_dir():
            out = next((s for s in sorted(bd.iterdir())
                        if s.is_dir() and s.name.startswith("00")), bd)
        out = out or bd or Path(".")
    out.mkdir(parents=True, exist_ok=True)
    (out / "tiers_draft.json").write_text(
        json.dumps(doc, ensure_ascii=False, indent=1), encoding="utf-8")
    (out / "tiers_draft.md").write_text(_md(doc), encoding="utf-8")
    return out


# ---------- 回放 (验收: 3 战役 T1 召回 ≥90% + 六槽诚实 + <30min) ----------
def replay(manifest_path: str) -> int:
    mf = _read_json(Path(manifest_path))
    entries = (mf or {}).get("battles") or []
    if not entries:
        print("[s0-2-replay] 清单为空", file=sys.stderr)
        return 2
    bar = float((mf or {}).get("bar", {}).get("min_recall", 0.9))
    rows, rc = [], 0
    for e in entries:
        doc = expand(e.get("title", ""), battle=e.get("battle", ""),
                     battle_dir=e.get("battle_dir", ""),
                     pool_id=e.get("pool", ""), online=False)
        actual = list(e.get("ground_truth", {}).get("t1") or [])
        got = set(doc["t1_draft"])
        covered = [w for w in actual if w in got]
        recall = (len(covered) / len(actual)) if actual else 0.0
        honest = (set(doc["slots"]) == set(SIX_SLOTS)
                  and all(doc["slots"][s]["status"] in ("filled", "查无")
                          and (doc["slots"][s]["status"] == "filled"
                               or not doc["slots"][s]["words"])
                          for s in SIX_SLOTS))
        in_budget = doc["elapsed_sec"] < TIME_BUDGET_SEC
        ok = recall >= bar and honest and in_budget
        rc = rc or (0 if ok else 1)
        render(doc, battle=e.get("battle", ""), replay_mode=True)
        filled = sum(1 for s in SIX_SLOTS
                     if doc["slots"][s]["status"] == "filled")
        rows.append({"battle": e.get("battle"), "recall": round(recall, 4),
                     "covered": covered, "missed": [w for w in actual
                                                    if w not in got],
                     "t1_n": len(doc["t1_draft"]), "honest": honest,
                     "filled": filled,
                     "elapsed_sec": doc["elapsed_sec"], "ok": ok})
        print(f"[s0-2-replay] {e.get('battle')}: 召回 "
              f"{len(covered)}/{len(actual)}={recall:.0%} "
              f"{'✓' if ok else '✗'} | T1草稿 {len(doc['t1_draft'])} 词 | "
              f"槽 {sum(1 for s in SIX_SLOTS if doc['slots'][s]['status'] == 'filled')}/6 填 | "
              f"{doc['elapsed_sec']}s")
    summary = {"schema": "tier_replay_summary_v1", "n": len(entries),
               "bar": bar, "rows": rows, "rc": rc,
               "zero_paid": ZERO_PAID,
               "generated": time.strftime("%Y-%m-%dT%H:%M:%S")}
    REPLAY_OUT.mkdir(parents=True, exist_ok=True)
    (REPLAY_OUT / "replay_summary.json").write_text(
        json.dumps(summary, ensure_ascii=False, indent=1), encoding="utf-8")
    md = ["# S0-2 词表生成器回放", "",
          f"- bar: 每战役 T1 召回 ≥{bar:.0%} | 六槽非空或显式查无 | "
          f"单战役 <{TIME_BUDGET_SEC // 60}min | rc={rc}", "",
          "| 战役 | 召回 | 覆盖/实际 | T1草稿 | 槽填 | 用时 | ok |",
          "|---|---|---|---|---|---|---|"]
    md += [f"| {r['battle']} | {r['recall']:.0%} | {len(r['covered'])}/"
           f"{len(r['covered']) + len(r['missed'])} | {r['t1_n']} | "
           f"{r['filled']}/6 | "
           f"{r['elapsed_sec']}s | {'✓' if r['ok'] else '✗'} |"
           for r in rows]
    (REPLAY_OUT / "replay_summary.md").write_text(
        "\n".join(md) + "\n", encoding="utf-8")
    print(f"[s0-2-replay] rc={rc} (bar≥{bar:.0%}, 诚实六槽, 零付费)")
    return rc


def main(argv: list[str] | None = None) -> int:
    import argparse
    ap = argparse.ArgumentParser(description="S0-2 词表生成器 (六槽展开)")
    ap.add_argument("--title", default="", help="报告名 (《X怎么干EPC总承包？》)")
    ap.add_argument("--battle", default="", help="战役名")
    ap.add_argument("--battle-dir", default="", help="战役目录")
    ap.add_argument("--pool", default="", help="弹药池 campaign_id")
    ap.add_argument("--online", action="store_true",
                    help="缺槽免费检索面单查补 (生产; 回放绝不触网)")
    ap.add_argument("--replay", default="", help="回放清单 JSON (3 战役)")
    args = ap.parse_args(argv)
    print(f"[s0-2] superline {_sl.__version__} 词表生成器 "
          f"(先存量·免费面·草稿留痕)")
    if args.replay:
        return replay(args.replay)
    if not args.title:
        print("[s0-2] --title 必填 (或走 --replay)", file=sys.stderr)
        return 2
    doc = expand(args.title, battle=args.battle,
                 battle_dir=args.battle_dir, pool_id=args.pool,
                 online=args.online)
    out = render(doc, battle_dir=args.battle_dir)
    print(f"[s0-2] 企业 {doc['company']} | T1 草稿 {len(doc['t1_draft'])} 词 "
          f"(规则 {sum(1 for w in doc['slots']['company']['words'] if w['source'].startswith('rule'))} "
          f"+ 存量 {sum(1 for w in doc['slots']['company']['words'] if w['source'].startswith('stock'))}) | "
          f"槽填 {6 - len(doc['honest_empty'])}/6 | 查无 {doc['honest_empty'] or '无'} "
          f"| {doc['elapsed_sec']}s")
    print(f"[s0-2] 草稿落盘: {out / 'tiers_draft.md'} (人工过目定稿, "
          f"绝不自动写 tiers.json)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
