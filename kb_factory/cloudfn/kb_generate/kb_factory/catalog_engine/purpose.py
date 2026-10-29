# -*- coding: utf-8 -*-
"""purpose 驱动路由 + 结构 Lint 增强（v2.7 #11）。

巨人肩膀：llm_wiki 三层架构【NOASSERTION——许可证未标明，只借思想零代码】：
「需求意图层 → 结构骨架层 → 内容回填层」分层解耦——意图层只管把一句话需求
翻译成结构化 purpose，骨架层只管按 purpose 路由种子域造树，回填层只管往
立好的骨架里灌真实内容。本模块承担意图层（derive_purpose/route_seeds）与
骨架层的结构体检（lint_blueprint），全部纯规则实现：零 LLM、零网络、零随机
源、零时钟，同输入必同输出；纯读不改入参。

三件入口：
  1. derive_purpose(text)  一句话需求 → purpose 三元组 {domain_guess / keywords
     / intent}（领域词典命中 + 关键词抽取 + 意图动词映射「建/找/整理/管」）
     + purpose.md 渲染（一句话使命 + 关键约束，作为蓝图 provenance.purpose
     落点建议）。领域词典复用 storm_breadth.PERSPECTIVES 九行业别名表 +
     taxonomy.CLC_22 别名兜底（Ontology 101 第一律：复用先于自创，禁重复造表）。
  2. route_seeds(purpose)  purpose → 种子域路由：哪几个垂直域种子参与生成
     （带置信度）。种子注册表按磁盘实存校验（file 类种子缺席即跳过并如实
     记 unavailable_skipped，绝不路由不存在的种子）；brick/cilin 等新域种子
     落库后按 SEED_ROUTES 表扩一行即可自动接入。
  3. lint_blueprint(bp)    结构质量检查增强：在既有 validate_tree 四查（环/
     孤儿/断裂/无归属，engine._attach_lint 已跑）与 lint.lint_blueprint
     反模式门之外补四查——目录空挂组（有组无文件槽）/ 文件无 digest 占比 /
     配比和≠100 / README 槽缺失组清单，问题分级 critical/warn。
     与 lint.lint_blueprint 同名不同义（反模式 vs 结构增强），接线一律用
     模块限定名 purpose.lint_blueprint(bp) 或 import as 别名，防互踩。

【收口波接线说明】（本波禁碰 engine.py/blueprint.py，接线由收口波统一做）：
    from catalog_engine import purpose
    # build 前置：一句话需求 → purpose 三元组 + 种子域路由（记 provenance）
    p = purpose.derive_purpose("给水利工程公司建一个EPC行业知识库")
    routes = purpose.route_seeds(p)
    need = purpose.suggest_need(p)              # 可选桥接：purpose→engine need JSON
    bp = engine.build_blueprint(need, ...)      # 既有引擎调用不变，路由结果
                                                # 供 build 前置选种子（six_domains/clc）
    # 产出后置：结构体检 + purpose 落 provenance（purpose_md 文本随附可审计）
    report = purpose.lint_blueprint(bp)
    bp["provenance"]["purpose"] = {
        "text": p["text"], "domain_guess": p["domain_guess"],
        "keywords": p["keywords"], "intent": p["intent"],
        "seed_routes": routes["routes"], "mode_hint": routes["mode_hint"],
        "structure_lint": report.as_dict()}
    # purpose.md 落盘建议：随蓝图输出目录一并写 p["purpose_md"]（provenance 落点）
"""
from __future__ import annotations

import re
from dataclasses import dataclass, field
from pathlib import Path

from . import taxonomy
from .cataloging import DIGEST_PLACEHOLDER
from .storm_breadth import PERSPECTIVES

__all__ = ["derive_purpose", "route_seeds", "suggest_need", "lint_blueprint",
           "render_purpose_md", "StructureLintReport"]

PURPOSE_VERSION = "purpose/2.7-11"

KB_ROOT = Path(__file__).resolve().parents[1]          # kb_factory/
SEEDS_DIR = KB_ROOT / "seeds"

# ── 一、意图动词映射（建 / 找 / 整理 / 管 四动作）──────────────────────────

INTENT_ACTIONS = ("build", "find", "organize", "manage")
# 触发词族（长词在前便于阅读；匹配规则=位置最早优先、同位长词优先，见 _match_intent）
INTENT_VERBS = {
    "build":    ("搭建", "创建", "生成", "规划", "立项", "从零", "建", "搭", "做", "造", "开"),
    "find":     ("检索", "搜索", "搜集", "收集", "查找", "找齐", "获取", "找", "查", "搜", "寻"),
    "organize": ("整理", "归档", "分类", "梳理", "编目", "整编", "归类", "收纳", "重构", "重组"),
    "manage":   ("管理", "维护", "运营", "更新", "打理", "管"),
}
INTENT_LABEL = {"build": "建库", "find": "检索", "organize": "整理", "manage": "管理"}
# 意图 → engine.need.intent 的中文措辞（validate_need 只要求非空 str）
INTENT_NEED_TEXT = {"build": "从零建库", "find": "检索既有资料",
                    "organize": "整理归档", "manage": "日常管理维护"}
# 一句话使命模板（intent 分型；{dom} 为领域名占位）
INTENT_MISSION = {
    "build":    "为{dom}域从零建一座结构立得住的知识库：先立法骨架，再回填真实内容。",
    "find":     "为{dom}域把既有资料一次找齐：渠道全开、真实文件优先，检索覆盖先行。",
    "organize": "为{dom}域把既有资料整理归档：既有序不丢、迁移零删除、编目可审计。",
    "manage":   "为{dom}域立常态管理机制：台账可审计、版本可回溯、更新不破结构。",
}
# 意图 → 关键约束（purpose.md「关键约束」段第 1 条；与 lint 检查项同口径互指）
INTENT_CONSTRAINT = {
    "build":    "结构先行：先落 L1/L2 立法骨架再回填内容，目录空挂组=critical。",
    "find":     "真实优先：真实文件优先占位槽，无 digest 占比过高=warn 如实亮黄。",
    "organize": "归档保真：既有文件序与元数据不丢，禁删除既有件。",
    "manage":   "常态更新：改动可回溯（provenance 留痕），结构劣化跑结构 lint 体检。",
}
# 领域 → 关键约束（purpose.md「关键约束」段第 2 条；域名对齐 DOMAIN_LEXICON）
DOMAIN_CONSTRAINT = {
    "工程建设":  "标准为核：GB/SL/JGJ 现行有效版本优先，作废标准必须标注。",
    "法律律所":  "合规底线：法规现行有效优先，失效法规显式标注不留暗坑。",
    "财务会计":  "口径统一：会计准则版本与计量口径全库一致。",
    "医疗卫生":  "权威来源：临床指南/药典等权威版本优先。",
    "教育教学":  "课标对齐：内容与课程标准版本对齐。",
    "安全环保EHS": "红线合规：强制性标准与法规红线优先。",
    "跨境电商":  "平台时效：平台规则时效性强，采编日期必记。",
    "科研管理":  "文献可溯：出处与版本可回溯。",
    "项目管理":  "基准可控：计划基准与变更留痕。",
}
DEFAULT_DOMAIN_CONSTRAINT = "来源权威：优先权威来源，来源不实宁可缺位不编造。"

# 兜底动词缺席时的缺省动作（KB-FACTORY 主业是建库）——低置信如实标注，不冒充显式命中
DEFAULT_INTENT_ACTION = "build"
DEFAULT_INTENT_CONFIDENCE = 0.2
MATCHED_INTENT_CONFIDENCE = 0.9

# ── 二、领域词典（复用 storm_breadth 九行业视角库别名，禁重复造表）────────

# PERSPECTIVES 为 dict，插入序即行业序（law→…→projectmgmt），generic 无别名剔除
DOMAIN_LEXICON = [
    {"key": key, "name": spec["name"], "aliases": tuple(spec["aliases"])}
    for key, spec in PERSPECTIVES.items() if spec.get("aliases")
]

# 关键词抽取通用名词库（受控小词表：知识库场景高频交付物名词，纯规则兜底素材）
KEY_NOUN_BANK = ("合同", "案例", "标准", "规范", "模板", "手册", "指南", "台账",
                 "范本", "规程", "图集", "纪要", "档案", "文献", "课件", "教案",
                 "报价", "清单", "定额", "图纸", "论文", "研报")

KEYWORD_CAP = 12          # 关键词上限（确定性截断）
_LATIN_RE = re.compile(r"[A-Za-z][A-Za-z0-9/\-]{0,15}")   # EPC / P6 / GB/T / Shopify…


def _clc_hint(text: str):
    """中图法 22 大类对文本打别名分（口径同 cataloging._clc_score），零分=None。"""
    best, best_n = None, 0
    for c in taxonomy.CLC_22:
        n = sum(1 for a in c["aliases"] if a in text)
        if n > best_n:
            best, best_n = c["code"], n
    return best


def _match_domain(text: str) -> dict:
    """领域词典命中：逐域数别名命中数，最高分为猜域；无命中如实 name=None。
    置信度=最高分/(最高分+次高分+1)（相对强弱公式，确定性；封顶 0.9）。"""
    scored = []
    for i, d in enumerate(DOMAIN_LEXICON):
        hits = [a for a in d["aliases"] if a in text]
        if hits:
            scored.append((-len(hits), i, d, hits))
    scored.sort()
    if not scored:
        return {"key": None, "name": None, "confidence": 0.0, "hits": [],
                "clc_hint": _clc_hint(text)}
    top_n, _, top_d, top_hits = scored[0]
    second_n = -scored[1][0] if len(scored) > 1 else 0
    conf = round(min(0.9, (-top_n) / (-top_n + second_n + 1.0)), 2)
    return {"key": top_d["key"], "name": top_d["name"], "confidence": conf,
            "hits": top_hits, "clc_hint": _clc_hint(text)}


def _extract_keywords(text: str, domain_hits: list) -> list:
    """关键词抽取（纯规则三源）：领域/CLC 别名命中 + 通用名词库命中 + 拉丁
    token；按首现位置升序去重（同位按字典序），截 KEYWORD_CAP。"""
    found: dict = {}
    for term in list(domain_hits) + [a for c in taxonomy.CLC_22 for a in c["aliases"]] \
            + list(KEY_NOUN_BANK):
        if len(term) < 2:
            continue                          # 单字别名噪声大，不进关键词
        pos = text.find(term)
        if pos >= 0 and term not in found:
            found[term] = pos
    for m in _LATIN_RE.finditer(text):
        token = m.group(0).rstrip("/-")
        if len(token) >= 2 and token not in found:
            found[token] = m.start()
    ordered = sorted(found.items(), key=lambda kv: (kv[1], kv[0]))
    return [t for t, _ in ordered[:KEYWORD_CAP]]


def _match_intent(text: str) -> dict:
    """意图动词映射：全触发词找最早出现位置（同位取长词），位置优先防
    「管理」被「管」抢跑、「创建」被「建」抢跑；无命中走缺省动作+低置信。"""
    best = None                              # (pos, -len, verb, action)
    for action, verbs in INTENT_VERBS.items():
        for v in verbs:
            pos = text.find(v)
            if pos >= 0:
                cand = (pos, -len(v), v, action)
                if best is None or cand < best:
                    best = cand
    if best is None:
        return {"action": DEFAULT_INTENT_ACTION, "verb": None,
                "confidence": DEFAULT_INTENT_CONFIDENCE}
    return {"action": best[3], "verb": best[2], "confidence": MATCHED_INTENT_CONFIDENCE}


def render_purpose_md(purpose: dict) -> str:
    """purpose.md 渲染：一句话使命 + 三元组 + 关键约束（意图约束/领域约束/
    确定性/零造假四条），作为蓝图 provenance.purpose 落点建议。"""
    dom = purpose["domain_guess"]["name"] or "未定域"
    key = purpose["domain_guess"]["key"] or "—"
    conf = purpose["domain_guess"]["confidence"]
    hits = "/".join(purpose["domain_guess"]["hits"]) or "—"
    action = purpose["intent"]["action"]
    verb = purpose["intent"].get("verb")
    iconf = purpose["intent"]["confidence"]
    kws = "、".join(purpose["keywords"]) or "—"
    lines = [
        f"# purpose.md · {dom}",
        "",
        f"> 一句话使命：{INTENT_MISSION[action].format(dom=dom)}",
        "",
        "## purpose 三元组",
        f"- domain_guess: {dom}（key={key}，置信 {conf}，命中 {hits}）",
        f"- keywords: {kws}",
        f"- intent: {action}/{INTENT_LABEL[action]}"
        f"（动词「{verb if verb else '未显式命中→兜底'}」，置信 {iconf}）",
        "",
        "## 关键约束",
        f"1. {INTENT_CONSTRAINT[action]}",
        f"2. {DOMAIN_CONSTRAINT.get(dom, DEFAULT_DOMAIN_CONSTRAINT)}",
        "3. 确定性：纯规则派生，无 LLM 无网络，同输入必同输出。",
        "4. 零造假：材料不足如实标注（digest=待补充），禁编造。",
        "",
    ]
    return "\n".join(lines)


def derive_purpose(text) -> dict:
    """一句话需求 → purpose 三元组 + purpose.md。

    返回 {"text", "domain_guess": {key,name,confidence,hits,clc_hint},
    "keywords": [str], "intent": {action,verb,confidence}, "purpose_md": str,
    "version"}；空串/None 如通过（domain_guess.name=None、intent 走缺省），
    绝不抛异常。确定性：无随机源无时钟，同输入必同输出。"""
    t = re.sub(r"\s+", " ", str(text or "")).strip()
    domain = _match_domain(t)
    keywords = _extract_keywords(t, domain["hits"])
    intent = _match_intent(t)
    purpose = {"text": t, "domain_guess": domain, "keywords": keywords,
               "intent": intent, "version": PURPOSE_VERSION}
    purpose["purpose_md"] = render_purpose_md(purpose)
    return purpose


# ── 三、种子域路由（purpose → 哪几个垂直域种子参与生成，带置信度）──────────
# kind=builtin=taxonomy 内置（永远在位）；kind=file=seeds/ 下实存资产，路由前
# 按磁盘校验，缺席跳过并记 unavailable_skipped（数字零造假：不路由不存在的种子）。
# 新域种子（brick/cilin 等）落库后在此扩一行即可自动接入，收口波无需改本模块。

SEED_ROUTES = (
    {"seed": "six_domains", "kind": "builtin", "path": None,
     "domains": ("工程建设", "项目管理"),
     "reason": "工程六库 49 分组（zhiku MK/EN/EX/KN/CA/RB）"},
    {"seed": "clc_22", "kind": "builtin", "path": None,
     "domains": ("*",),
     "reason": "中图法 22 大类骨架兜底"},
    {"seed": "fibo", "kind": "file", "path": "seeds/fibo",
     "domains": ("财务会计",),
     "reason": "FIBO 财务本体 8 模块（BE/CAE/FBC/FND/LOAN+闭包）"},
    {"seed": "thuocl:law", "kind": "file", "path": "seeds/thuocl/law.json",
     "domains": ("法律律所",), "reason": "THUOCL 法律词表（词级命中加权）"},
    {"seed": "thuocl:caijing", "kind": "file", "path": "seeds/thuocl/caijing.json",
     "domains": ("财务会计",), "reason": "THUOCL 财经词表"},
    {"seed": "thuocl:medical", "kind": "file", "path": "seeds/thuocl/medical.json",
     "domains": ("医疗卫生",), "reason": "THUOCL 医学词表"},
    {"seed": "thuocl:IT", "kind": "file", "path": "seeds/thuocl/IT.json",
     "domains": ("跨境电商",), "reason": "THUOCL 信息科技词表"},
)

# 种子路由置信度公式：主域命中 0.5 + 0.4×域置信（封顶 0.9）；骨架兜底恒定档
BASE_ROUTE_CONFIDENCE, DOMAIN_ROUTE_SCALE, ROUTE_CONFIDENCE_CAP = 0.5, 0.4, 0.9
SKELETON_CONFIDENCE_NOMATCH, SKELETON_CONFIDENCE_MATCHED = 0.5, 0.45


def _coerce_purpose(purpose):
    """purpose 入参归一：str=一句话需求现场派生；dict=derive_purpose 结果。"""
    if isinstance(purpose, str):
        return derive_purpose(purpose)
    if isinstance(purpose, dict) and "domain_guess" in purpose:
        return purpose
    raise ValueError("purpose 必须是 derive_purpose 结果 dict 或一句话需求 str")


def route_seeds(purpose) -> dict:
    """purpose → 种子域路由表（带置信度，供收口波接入 build 前置选种子）。

    返回 {"routes": [{seed,kind,path,role,confidence,reason}], "mode_hint":
    "six_domains"|"clc", "domain": 域名|None, "seed_count": n,
    "unavailable_skipped": [缺席 file 种子名]}。
    role=主域种子（命中的垂直域）/骨架兜底（clc_22 恒在位）；
    mode_hint 口径同 taxonomy.match_seed（SIX_STRONG_ALIASES 强别名命中）。"""
    p = _coerce_purpose(purpose)
    dom = p["domain_guess"]["name"]
    conf = p["domain_guess"]["confidence"]
    routes, skipped = [], []
    for entry in SEED_ROUTES:
        if entry["kind"] == "file" and not (KB_ROOT / entry["path"]).exists():
            skipped.append(entry["seed"])     # 如实跳过：不路由磁盘上不存在的种子
            continue
        if "*" in entry["domains"]:
            confidence = (SKELETON_CONFIDENCE_MATCHED if dom
                          else SKELETON_CONFIDENCE_NOMATCH)
            role = "骨架兜底"
        elif dom in entry["domains"]:
            confidence = round(min(ROUTE_CONFIDENCE_CAP,
                                   BASE_ROUTE_CONFIDENCE + DOMAIN_ROUTE_SCALE * conf), 2)
            role = "主域种子"
        else:
            continue
        routes.append({"seed": entry["seed"], "kind": entry["kind"],
                       "path": entry["path"], "role": role,
                       "confidence": confidence, "reason": entry["reason"]})
    routes.sort(key=lambda r: (-r["confidence"], r["seed"]))   # 置信降序，同名稳定
    probe = p["text"] + "".join(p["keywords"])
    mode_hint = ("six_domains" if any(a in probe for a in taxonomy.SIX_STRONG_ALIASES)
                 else "clc")
    return {"routes": routes, "mode_hint": mode_hint, "domain": dom,
            "seed_count": len(routes), "unavailable_skipped": skipped}


# 与 engine.SIZE_PLANS 键位对齐（本模块禁 import engine 防耦合，接线以 engine 为准）
SIZE_HINTS = ("small", "medium", "large", "huge")


def suggest_need(purpose, size_hint: str = "small", domain_text: str | None = None) -> dict:
    """purpose → engine 需求 JSON 桥接（{domain, keywords, intent, size_hint}，
    直接可喂 build_blueprint）。domain_text 显式指定时优先（缺省由域猜派生）。"""
    p = _coerce_purpose(purpose)
    if size_hint not in SIZE_HINTS:
        raise ValueError(f"size_hint 越界: {size_hint}，可选 {SIZE_HINTS}")
    dom = p["domain_guess"]["name"]
    domain = domain_text or (f"{dom}知识库" if dom else (p["text"][:16] or "通用知识库"))
    kws = p["keywords"][:8] or ["综合资料"]     # 引擎空 keywords 合法，但保底一词更可用
    return {"domain": domain, "keywords": kws,
            "intent": INTENT_NEED_TEXT[p["intent"]["action"]], "size_hint": size_hint}


# ── 四、结构 Lint 增强（v2.7 #11）───────────────────────────────────────────
# 定位：validate_tree 四查（engine._attach_lint 已跑）与 lint 反模式门之外的
# 结构增强层——目录空挂组 / 文件无 digest 占比 / 配比和≠100 / README 槽缺失。
# 分级：critical（结构硬伤：空挂组/配比失衡）不随 warn（质量亮黄：提要缺失/
# README 缺槽）混级；passed = critical==0（warn 不阻断，同 lint.overall_pass 口径）。

CRITICAL, WARN, PASS = "critical", "warn", "pass"
DIGEST_WARN_RATIO = 0.5     # 无真实提要占比过半亮黄（严格大于才 warn，边界=过）
MAX_EXAMPLES = 5           # 详情点名上限（防刷屏，确定性截断，口径同 lint.py）


@dataclass
class StructureCheck:
    """单项结构检查结果（level 三态：critical/warn/pass）。"""
    check_id: str
    name: str
    level: str
    detail: str


@dataclass
class StructureLintReport:
    """结构 lint 总报告（确定性；纯读不改入参）。"""
    checks: list = field(default_factory=list)
    critical: int = 0
    warn: int = 0
    passed: bool = True      # = (critical == 0)，warn 不阻断
    summary: str = ""

    @classmethod
    def build(cls, checks: list) -> "StructureLintReport":
        critical = sum(1 for c in checks if c.level == CRITICAL)
        warn = sum(1 for c in checks if c.level == WARN)
        n_pass = sum(1 for c in checks if c.level == PASS)
        verdict = "通过" if critical == 0 else "未通过"
        summary = (f"{len(checks)} 项结构检查: 通过 {n_pass} · 警告 {warn}"
                   f" · 致命 {critical} → 总体{verdict}")
        return cls(checks=checks, critical=critical, warn=warn,
                   passed=critical == 0, summary=summary)

    def as_dict(self) -> dict:
        """provenance 落点形态（JSON 可序列化，接线：bp.provenance.purpose.structure_lint）。"""
        return {"checks": [{"check_id": c.check_id, "name": c.name,
                            "level": c.level, "detail": c.detail} for c in self.checks],
                "critical": self.critical, "warn": self.warn,
                "passed": self.passed, "summary": self.summary}


def _examples(items: list) -> str:
    """点名前 MAX_EXAMPLES 条 + 总数后缀（口径同 lint._examples）。"""
    shown = "、".join(items[:MAX_EXAMPLES])
    return shown + (f" 等{len(items)}处" if len(items) > MAX_EXAMPLES else "")


def _iter_groups(bp: dict):
    """产出 (l1, l2)；容错缺键（树缺失/畸形蓝图不崩，只查不出）。"""
    tree = bp.get("tree")
    if not isinstance(tree, dict):
        return
    for l1 in tree.get("l1") or []:
        if isinstance(l1, dict):
            for l2 in l1.get("l2") or []:
                if isinstance(l2, dict):
                    yield l1, l2


def _group_slots(l2: dict) -> list:
    """L2 组文件槽列表（files 优先，分拆组拍平；只读不改）。"""
    return list(l2.get("files") or []) + \
        [f for sd in l2.get("split_dirs") or [] for f in sd.get("files") or []]


def _is_guided(node: dict) -> bool:
    """导览层节点判定（source=guided_layer）：固定模板层，由 test_guided_layer
    专属保障，结构 lint 不查（口径同 engine 接线：lint 评估领域内容结构）。"""
    return node.get("source") == "guided_layer"


def _check_empty_groups(bp: dict) -> StructureCheck:
    """目录空挂组：L2 组（含分拆目录）零文件槽 → critical（交付空目录=结构硬伤；
    与 validate_tree「无文件通道键」互补：本查管有键但为空的挂空组）。"""
    empties, n_groups = [], 0
    for _, l2 in _iter_groups(bp):
        n_groups += 1
        n = len(l2.get("files") or []) + \
            sum(len(sd.get("files") or []) for sd in l2.get("split_dirs") or [])
        if n == 0:
            empties.append(f"{l2.get('code', '?')} {l2.get('name', '')}")
        for sd in l2.get("split_dirs") or []:
            if not (sd.get("files") or []):
                empties.append(f"{sd.get('path', '?')} {sd.get('name', '')}(分拆空)")
    if empties:
        return StructureCheck("empty_groups", "目录空挂组检查", CRITICAL,
                              f"空挂组(零文件槽): {_examples(empties)}")
    if n_groups == 0:
        return StructureCheck("empty_groups", "目录空挂组检查", PASS,
                              "无 L2 组可查（树缺失/空树形态由 validate_tree 四查负责）")
    return StructureCheck("empty_groups", "目录空挂组检查", PASS,
                          "无空挂组（每个 L2/分拆目录均有文件槽）")


def _check_digest_ratio(bp: dict) -> StructureCheck:
    """文件无 digest 占比：无真实提要（无 catalog / digest 空/待补充 /
    digest_from=none）的槽占比 >50% → warn（占位槽如实亮黄，渠道回填后复检；
    新蓝图全占位属正常态，故 warn 不 critical——零造假纪律：亮黄不拦路）。"""
    total = missing = 0
    for _, l2 in _iter_groups(bp):
        for slot in _group_slots(l2):
            if not isinstance(slot, dict):
                continue
            total += 1
            cat = slot.get("catalog")
            digest = str(cat.get("digest") or "").strip() if isinstance(cat, dict) else ""
            src = cat.get("digest_from") if isinstance(cat, dict) else None
            if not digest or digest == DIGEST_PLACEHOLDER or src in (None, "none"):
                missing += 1
    if total == 0:
        return StructureCheck("digest_ratio", "文件提要覆盖检查", PASS,
                              "无文件槽，跳过")
    ratio = missing / total
    if ratio > DIGEST_WARN_RATIO:
        return StructureCheck("digest_ratio", "文件提要覆盖检查", WARN,
                              f"无真实提要占比 {ratio:.0%}（{missing}/{total}）"
                              f" > {DIGEST_WARN_RATIO:.0%}：占位/待补充如实亮黄，"
                              "渠道回填后复检")
    return StructureCheck("digest_ratio", "文件提要覆盖检查", PASS,
                          f"无真实提要占比 {ratio:.0%}（{missing}/{total}）"
                          f" ≤ {DIGEST_WARN_RATIO:.0%}")


def _check_ratio_sum(bp: dict) -> StructureCheck:
    """配比和：bp.ratio 数值和 ≠100 → critical（tier_counts/_ratio_from_tiers
    契约均以和恒=100 为前提，失衡即配比派发全错）。"""
    ratio = bp.get("ratio")
    if not isinstance(ratio, dict) or not ratio:
        return StructureCheck("ratio_sum", "配比总和检查", CRITICAL,
                              "ratio 缺失或非对象（三档配比是引擎契约键）")
    try:
        total = sum(float(v) for v in ratio.values())
    except (TypeError, ValueError):
        return StructureCheck("ratio_sum", "配比总和检查", CRITICAL,
                              f"ratio 含非数值成员: {sorted(ratio)}")
    if abs(total - 100) > 1e-9:
        return StructureCheck("ratio_sum", "配比总和检查", CRITICAL,
                              f"配比和 {total:g} ≠ 100（{ratio}）")
    return StructureCheck("ratio_sum", "配比总和检查", PASS,
                          f"配比和=100（{ '/'.join(f'{k}{v:g}' for k, v in ratio.items()) }）")


def _check_readme_slots(bp: dict) -> StructureCheck:
    """README 槽缺失组清单：v2 立法蓝图（provenance.node_schema=v2）下 L2 组
    缺 readme_slot → warn（00-README 是 v2 档立法增量键，缺槽=立法不完整；
    导览层组为固定模板层不查；非 v2 档不查——旧 schema 无此键属正常）。"""
    schema = (bp.get("provenance") or {}).get("node_schema") if \
        isinstance(bp.get("provenance"), dict) else None
    if schema != "v2":
        return StructureCheck("readme_slots", "README槽齐全检查", PASS,
                              f"node_schema={schema!r} 非 v2 档不查（README 槽为 v2 立法键）")
    missing, n_groups = [], 0
    for l1, l2 in _iter_groups(bp):
        if _is_guided(l1) or _is_guided(l2):
            continue                          # 导览层固定模板组，专属测试保障
        n_groups += 1
        if not l2.get("readme_slot"):
            missing.append(f"{l2.get('code', '?')} {l2.get('name', '')}")
    if missing:
        return StructureCheck("readme_slots", "README槽齐全检查", WARN,
                              f"v2 档缺 00-README 槽的 L2 组: {_examples(missing)}")
    return StructureCheck("readme_slots", "README槽齐全检查", PASS,
                          f"v2 档 L2 组 README 槽齐全（{n_groups} 组）")


_STRUCTURE_CHECKS = (_check_empty_groups, _check_digest_ratio,
                     _check_ratio_sum, _check_readme_slots)


def lint_blueprint(bp: dict) -> StructureLintReport:
    """结构质量检查增强入口：四查（空挂组/提要覆盖/配比和/README 槽）→
    分级报告（critical/warn/pass）。纯读不改入参；不重复跑 validate_tree
    （engine._attach_lint 已跑四查）与 lint.lint_blueprint（反模式门）——
    三层互补：validate_tree 管树形态、lint 管反模式、本 lint 管结构质量分级。"""
    if not isinstance(bp, dict):
        bp = {}
    return StructureLintReport.build([fn(bp) for fn in _STRUCTURE_CHECKS])
