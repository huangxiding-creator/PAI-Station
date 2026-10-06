# -*- coding: utf-8 -*-
"""超级生产线共享契约层 (superline.contracts) — P0 地基件 (1006 全批 38 件之首).

S0 门卫判级/Charter 呈批, S1 框架即路由表, S3 大纲合同锁共用同一套
常量 + 纯函数校验器 + 指纹. 判定同源纪律 (呈审门批准范围重申):
  - 弹药门参数一律动态读 ammo_pool (在役权威源, 1005 用户定调), 本模块
    绝不另立第二套门参数 — gate_defaults() 每次调用实时取值;
  - 校验器只读: 不改入参 (不可变纪律), 不落盘, 不触网, 零 LLM.

契约对象 = dict (JSON 可序列化, 落盘即该阶段唯一事实源):
  charter    S0 战役宪章: 报告名 → 研究对象/框架族/读者/体量(章×节×字)/
             设问式核心问题/三层词表/复述栏/反例问题/呈批态/渠道组合三类分标
  framework  S1 框架即路由表: 章级四路由字段 (tier 词表映射/渠道组合/
             证据密度/预算档) 齐备率 100% 才过门; S3 在其上加状态机锁合同

用法:
  from superline.contracts import (validate_charter, validate_framework,
                                    default_framework, fingerprint,
                                    gate_defaults, route_completeness)
"""
from __future__ import annotations

import hashlib
import json
import re
import sys
from pathlib import Path

try:                                    # 借在役弹药门参数 (判定同源)
    import ammo_pool
except ImportError:                     # 子包/脚本形态导入时补根路径 (对齐 ammo_pool 借件惯例)
    sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
    import ammo_pool

# ---------- 常量唯一事实源 (值域枚举, 出口结构化, 杜绝路由幻觉) ----------

TIERS = ("T1", "T2", "T3")
# T1 报告直接(研究对象本体) / T2 同业对标 / T3 行业框架; T0 泛命中不计门.

BUDGET_BANDS = ("outline_wide", "section_narrow", "gap")
# 检索预算三档 (P22 两级 + 章级补弹第三档, 合并件归 S2 tier_router 派单):
# outline_wide=框架期宽带 / section_narrow=章级精写窄带 / gap=章级补弹.

CHAPTER_STATES = ("not_started", "in_progress", "completed", "blocked")
# 章级计划状态机 4 态 (S3 合同锁); blocked 必须是对账真态, 不许装饰态.

FAMILY_TYPES = ("enterprise", "industry", "topic", "policy")
# 四框架族: 企业/行业/主题/政策; framework.family 另允许 "domain"
# (EPC 域十维度模板双轨位).

INPUT_LEVELS = ("L1", "L2")             # L1 用户详单 / L2 仅报告名 (两级输入协议)

APPROVAL_STATES = ("pending", "approved", "edit", "waived")
# 呈批四态: pending 呈批中 / approved 批 / edit 改回(回炉改后重呈) /
# waived 豁免留痕 (waivers 同构, FAIL→WARN 在案). S0 章程门只认 approved.

DENSITY_LEVELS = ("high", "medium", "low")
# 证据密度预估: high/medium 必须可追溯 ≥1 条免费侦察命中 (scout_hits),
# 无命中只准 low — 禁止凭空预估.

CHANNEL_PLAN_CLASSES = ("stock_harvest", "current_increment", "on_demand")
# 渠道组合三类分标: 存量仓收割 / 当期增量班次 / 按需单查(积分制永不自动派).

_CAMPAIGN_ID_RE = re.compile(r"^[A-Za-z0-9][A-Za-z0-9_-]*$")   # 对齐 ammo_pool bad/id 拒收


# ---------- 词表归一 ----------

def _word_list(entries) -> list[str]:
    """tiers 词目归一: str 或 {"word": ...} (槽位溯源 dict) → 纯词串列表."""
    out: list[str] = []
    for e in entries or []:
        if isinstance(e, str):
            out.append(e)
        elif isinstance(e, dict) and isinstance(e.get("word"), str):
            out.append(e["word"])
    return out


def tier_words(tiers: dict, tier: str) -> list[str]:
    """取某层词表 (容错: tiers 缺失/键缺失返回空表, 不抛异常)."""
    if not isinstance(tiers, dict):
        return []
    return _word_list(tiers.get(tier))


# ---------- S0 charter 校验 ----------

def validate_charter(charter: dict) -> list[str]:
    """S0 宪章校验 — 返回错误清单 (空列表=过门). 只读, 不抛异常."""
    errs: list[str] = []
    if not isinstance(charter, dict):
        return ["charter 必须是 dict"]

    cid = charter.get("campaign_id")
    if not isinstance(cid, str) or not _CAMPAIGN_ID_RE.match(cid):
        errs.append(f"campaign_id 非法: {cid!r} (须 ^[A-Za-z0-9][A-Za-z0-9_-]*$, 对齐池目录名)")

    title = charter.get("report_title")
    if not isinstance(title, str) or not title.strip():
        errs.append("report_title 缺失或为空")

    if charter.get("family") not in FAMILY_TYPES:
        errs.append(f"family 非法: {charter.get('family')!r} (值域 {FAMILY_TYPES})")

    if charter.get("input_level") not in INPUT_LEVELS:
        errs.append(f"input_level 非法: {charter.get('input_level')!r} (L1 详单/L2 仅报告名)")

    reader = charter.get("reader")
    if not isinstance(reader, str) or not reader.strip():
        errs.append("reader (读者) 缺失或为空")

    vol = charter.get("volume")
    if not isinstance(vol, dict):
        errs.append("volume 缺失 (体量目标 章×节×字 必须显式)")
    else:
        for k in ("chapters", "sections", "total_chars"):
            v = vol.get(k)
            if not isinstance(v, int) or isinstance(v, bool) or v < 1:
                errs.append(f"volume.{k} 非法: {v!r} (须正整数)")

    cq = charter.get("core_question")
    if not isinstance(cq, str) or not cq.strip():
        errs.append("core_question 缺失 (设问式核心问题必填)")
    elif not any(m in cq for m in ("？", "?")):
        errs.append("core_question 必须是设问式 (含 ？/?) — 立意定题纪律")

    tiers = charter.get("tiers")
    if not isinstance(tiers, dict):
        errs.append("tiers 缺失 (三层词表)")
    else:
        if not tier_words(tiers, "T1"):
            errs.append("tiers.T1 为空 — T1 报告直接词缺则整域弹药贫血 (S0 件2)")
        for t in TIERS:
            raw = tiers.get(t)
            if raw is not None and not isinstance(raw, list):
                errs.append(f"tiers.{t} 须为列表")

    rest = charter.get("restatement")
    if not isinstance(rest, str) or not rest.strip():
        errs.append("restatement 缺失 (解析腿首步复述纪律, 进 Charter 草案首栏)")

    cqs = charter.get("counter_questions")
    if not isinstance(cqs, list) or len(
            [q for q in cqs if isinstance(q, str) and q.strip()]) < 3:
        errs.append("counter_questions 须 ≥3 条非空 (Skepticalist 反例问题)")

    if charter.get("approval") not in APPROVAL_STATES:
        errs.append(f"approval 非法: {charter.get('approval')!r} (值域 {APPROVAL_STATES})")

    plan = charter.get("channel_plan")
    if plan is not None:
        if not isinstance(plan, list):
            errs.append("channel_plan 须为列表 (三类分标)")
        else:
            for i, ent in enumerate(plan):
                cls = ent.get("class") if isinstance(ent, dict) else None
                if cls not in CHANNEL_PLAN_CLASSES:
                    errs.append(
                        f"channel_plan[{i}].class 非法: {cls!r} (值域 {CHANNEL_PLAN_CLASSES})")

    gate = charter.get("gate")
    if gate is not None:
        if not isinstance(gate, dict):
            errs.append("gate 须为 dict (战役级门参数覆盖, 缺省读 ammo_pool)")
        else:
            for k in ("t1_min_chars", "t12_min_chars", "t3_cap_chars"):
                v = gate.get(k)
                if v is not None and (not isinstance(v, int) or isinstance(v, bool) or v < 1):
                    errs.append(f"gate.{k} 非法: {v!r} (覆盖值须正整数)")
    return errs


def charter_ready_for_s1(charter: dict) -> bool:
    """S0→S1 准入: 呈批 approved 且校验零错 (批准前 S1 不动工)."""
    return (isinstance(charter, dict)
            and charter.get("approval") == "approved"
            and not validate_charter(charter))


def gate_defaults() -> dict:
    """弹药门参数实时快照 (判定同源: 每次调用读 ammo_pool, 不缓存不复立)."""
    return {
        "t1_min_chars": ammo_pool.T1_MIN_CHARS,
        "t12_min_chars": ammo_pool.T12_MIN_CHARS,
        "t3_cap_chars": ammo_pool.T3_CAP_CHARS,
        "fallback_total_chars": ammo_pool.AMMO_GATE_CHARS,  # 旧总量门回退判据
    }


# ---------- S1 framework 校验 ----------

def _chapter_errors(ch: dict, prefix: str) -> list[str]:
    errs: list[str] = []
    if not ch.get("id"):
        errs.append(f"{prefix}.id 缺失")
    title = ch.get("title")
    if not isinstance(title, str) or not title.strip():
        errs.append(f"{prefix}.title 缺失或为空")
    tm = ch.get("tier_map")
    if not isinstance(tm, dict) or not any(
            t in TIERS and _word_list(tm.get(t)) for t in TIERS):
        errs.append(f"{prefix}.tier_map 非法 (至少一层 {TIERS} 带非空词表)")
    chans = ch.get("channels")
    if not isinstance(chans, list) or not chans or not all(
            isinstance(x, str) and x.strip() for x in chans):
        errs.append(f"{prefix}.channels 须非空字符串列表 (渠道组合)")
    if ch.get("budget_band") not in BUDGET_BANDS:
        errs.append(f"{prefix}.budget_band 非法: {ch.get('budget_band')!r} (值域 {BUDGET_BANDS})")
    dens = ch.get("evidence_density")
    if dens not in DENSITY_LEVELS:
        errs.append(f"{prefix}.evidence_density 非法: {dens!r} (值域 {DENSITY_LEVELS})")
    elif dens in ("high", "medium"):
        hits = ch.get("scout_hits")
        if not isinstance(hits, list) or len(hits) < 1:
            errs.append(f"{prefix}.evidence_density={dens} 须带 scout_hits ≥1 "
                        "(禁止凭空预估, 无侦察据只准 low)")
    return errs


def validate_framework(fw: dict) -> list[str]:
    """S1 框架即路由表校验 — 路由字段齐备率 100% 才算过门. 只读, 不抛异常."""
    errs: list[str] = []
    if not isinstance(fw, dict):
        return ["framework 必须是 dict"]
    cid = fw.get("campaign_id")
    if not isinstance(cid, str) or not _CAMPAIGN_ID_RE.match(cid):
        errs.append(f"campaign_id 非法: {cid!r}")
    fam = fw.get("family")
    if fam not in FAMILY_TYPES + ("domain",):
        errs.append(f"family 非法: {fam!r} (四框架族 {FAMILY_TYPES} 或 'domain' 域模板)")
    ver = fw.get("version")
    if not isinstance(ver, int) or isinstance(ver, bool) or ver < 1:
        errs.append("version 须正整数 (S3 合同锁 diff 基准)")
    chapters = fw.get("chapters")
    if not isinstance(chapters, list) or not chapters:
        errs.append("chapters 缺失或为空")
        return errs
    seen: set[str] = set()
    for i, ch in enumerate(chapters):
        if not isinstance(ch, dict):
            errs.append(f"chapters[{i}] 须为 dict")
            continue
        ch_id = ch.get("id")
        if isinstance(ch_id, str):
            if ch_id in seen:
                errs.append(f"chapters[{i}].id 重复: {ch_id}")
            seen.add(ch_id)
        errs.extend(_chapter_errors(ch, f"chapters[{i}]"))
    return errs


def _route_ok(ch: dict) -> bool:
    """四路由字段 (tier_map/channels/budget_band/evidence_density) 齐备判."""
    tm = ch.get("tier_map")
    chans = ch.get("channels")
    return (isinstance(tm, dict)
            and any(t in TIERS and _word_list(tm.get(t)) for t in TIERS)
            and isinstance(chans, list) and len(chans) > 0
            and all(isinstance(x, str) and x.strip() for x in chans)
            and ch.get("budget_band") in BUDGET_BANDS
            and ch.get("evidence_density") in DENSITY_LEVELS)


def route_completeness(fw: dict) -> tuple[int, int]:
    """(四路由字段齐备章数, 总章数) — 出口判据『齐备率 100%』的机检底数."""
    chapters = fw.get("chapters") if isinstance(fw, dict) else None
    if not isinstance(chapters, list):
        return (0, 0)
    done = sum(1 for ch in chapters if isinstance(ch, dict) and _route_ok(ch))
    return (done, len(chapters))


# ---------- 指纹与兜底 ----------

def fingerprint(obj) -> str:
    """契约指纹: 规范化 JSON 的 sha1 前 12 位 — S3 变更 diff 与幂等账的锚."""
    blob = json.dumps(obj, sort_keys=True, ensure_ascii=False,
                      separators=(",", ":"))
    return hashlib.sha1(blob.encode("utf-8")).hexdigest()[:12]


def _segment(idx: int, title: str, desc: str, cls: str, t1: list[str]) -> dict:
    return {
        "id": f"ch{idx:02d}", "title": title, "description": desc,
        "tier_map": {"T1": t1[:3]},
        "channels": [cls], "budget_band": "outline_wide",
        "evidence_density": "low",
    }


def default_framework(campaign_id: str, report_title: str,
                      tiers: dict | None = None) -> dict:
    """兜底三段默认框架 (解析失败→硬拒回炉≤2 次→降级此件 + warn 留痕).

    三段 = 盘点家底 → 定向采集 → 验证成稿 (OpenManus 三步兜底的研报形);
    密度全 low (无侦察据不许凭空预估), 渠道组合用三类分标占位 —
    本身必须过 validate_framework (兜底件不悬空, 单测钉死).
    """
    t1 = tier_words(tiers or {}, "T1") or [report_title or "研究对象"]
    return {
        "campaign_id": campaign_id,
        "family": "topic",
        "version": 1,
        "generator": "default_fallback",
        "warn": "降级三段默认框架: 回炉失败兜底, 密度全 low 待侦察补据",
        "chapters": [
            _segment(1, "家底盘点: 存量先验与既有证据",
                     "共性库/先前战役/05 根基对标/弹药池水位的盘点与先验摘要",
                     "stock_harvest", t1),
            _segment(2, "定向调研: 缺口识别与证据补强",
                     "按 T1/T2 词表定向增量采集, 弹药门 v3 主判收口",
                     "current_increment", t1),
            _segment(3, "验证与成稿: 质量门与交付",
                     "章节×证据对账, RQS 门族过账, 多形态交付",
                     "stock_harvest", t1),
        ],
    }
