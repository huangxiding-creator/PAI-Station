"""M7c L2 慢通道：银甲虫 LLM prompt 移植 + UItron 三档复杂度路由。

方法论栈第③层：段摘要→LLM。三档（UItron 思想，按需烧 token）：
  - simple  L1 高置信且主导清晰 → 直判，不调 LLM
  - complex 常规段 → LLM 段摘要（银甲虫 strict JSON，temp 0.2）
  - hardest 混杂/未识别 → LLM + 需要屏幕观察（M8 感知升级件接入位，
    当前降级为纯 LLM 并标 needs_screen）

失败安全：网关全死 / JSON 解析失败 → 降级 L1 直判 conf=0.3
（低置信会被 reject_gate 拒掉——缺席不崩且不误报）。
ICL 修正样本由 flywheel.build_icl 注入（第⑥层纠正飞轮接线点）。
"""
from __future__ import annotations

import json
import re

TIER_SIMPLE = "simple"
TIER_COMPLEX = "complex"
TIER_HARDEST = "hardest"

_SYSTEM = (
    "你是用户电脑活动的分析助手。根据活动记录推断用户正在做什么、"
    "属于哪个项目。基于记录如实判断，不臆造记录外的内容。"
)

_JSON_KEYS = ("activity", "project", "category", "summary", "confidence",
              "next_action")

_FENCE = re.compile(r"```(?:json)?\s*(.*?)\s*```", re.DOTALL)


def route(block: dict) -> str:
    """三档复杂度路由（烧 token 量 = 档位）。"""
    conf = block.get("confidence") or 0.0
    cov = block.get("coverage") or 0.0
    samples = block.get("samples") or 0
    if (conf >= 0.72 and cov >= 0.6 and samples >= 4
            and block.get("category") not in ("unknown", "idle")):
        return TIER_SIMPLE
    if cov < 0.5 or block.get("category") == "unknown":
        return TIER_HARDEST                      # 混杂/未识别需更多观察
    return TIER_COMPLEX


def render_digest(block: dict) -> str:
    """块 → 人类可读活动记录（prompt 证据体，银甲虫 enrichment 精简版）。"""
    lines = [
        f"时段: {block.get('start')} ~ {block.get('end')}"
        f"（{block.get('duration_min')} 分钟，{block.get('samples')} 个采样）",
        f"主导应用: {block.get('process') or '无'}",
        f"L1 类别: {block.get('label', '')}"
        f"（置信 {block.get('confidence')}，覆盖 {block.get('coverage')}）",
        "窗口标题: " + " | ".join(block.get("titles") or ["无"]),
    ]
    if block.get("domains"):
        lines.append("访问域名: " + " ".join(block["domains"]))
    if block.get("related_files"):
        lines.append("涉及文件: " + " ".join(block["related_files"]))
    if block.get("related_clipboard"):
        lines.append("剪贴板操作: " + " ".join(block["related_clipboard"]))
    return "\n".join(lines)


def build_messages(block: dict, icl: str = "") -> list[dict]:
    user = []
    if icl:
        user.append(icl)
    user.append(f"[活动记录]\n{render_digest(block)}\n\n[输出要求]\n"
                "只输出 JSON 对象（不要 markdown 代码块、不要多余文字），"
                "字段：{\"activity\": 一句话活动描述, \"project\": 所属项目, "
                "\"category\": 分类, \"summary\": 详细摘要, "
                "\"evidence\": [最多3条证据], \"confidence\": 0~1 数字, "
                "\"next_action\": 建议的下一步}")
    return [{"role": "system", "content": _SYSTEM},
            {"role": "user", "content": "\n\n".join(user)}]


def parse_llm_json(text: str) -> dict | None:
    """LLM 输出 → dict；容忍代码块围栏，其余一律 None（strict 口径）。"""
    t = (text or "").strip()
    m = _FENCE.search(t)
    if m:
        t = m.group(1).strip()
    try:
        obj = json.loads(t)
    except (ValueError, TypeError):
        return None
    if not isinstance(obj, dict) or not obj.get("activity"):
        return None
    for key in _JSON_KEYS:
        obj.setdefault(key, "" if key != "confidence" else 0.0)
    obj["evidence"] = [str(e) for e in (obj.get("evidence") or [])][:3]
    return obj


def summarize_block(block: dict, gateway, icl: str = "") -> dict:
    """活动块 → 意图判读。gateway: execute.LlmGateway（chat(msgs,**kw)）。"""
    tier = route(block)
    if tier == TIER_SIMPLE:
        out = _l1_direct(block)
        out.update({"tier": tier, "llm": False})
        return out
    out = _l1_direct(block)
    out["tier"] = tier
    out["llm"] = False
    try:
        text, provider = gateway.chat(build_messages(block, icl),
                                      temperature=0.2)
    except Exception:  # noqa: BLE001 - 网关失败降级，缺席不崩
        out["degraded"] = "gateway"
        return out
    parsed = parse_llm_json(text)
    if not parsed:
        out["degraded"] = "parse"
        return out
    try:
        parsed["confidence"] = float(min(max(parsed.get("confidence")
                                             or 0.0, 0.0), 1.0))
    except (TypeError, ValueError):
        parsed["confidence"] = 0.0
    parsed["tier"] = tier
    parsed["llm"] = True
    parsed["provider"] = provider
    parsed["needs_screen"] = tier == TIER_HARDEST
    return parsed


def _l1_direct(block: dict) -> dict:
    titles = block.get("titles") or [""]
    return {
        "activity": titles[0] or block.get("label", ""),
        "project": "",
        "category": block.get("category", "unknown"),
        "summary": f"L1 直判: {block.get('label', '')}",
        "evidence": [],
        "confidence": 0.3,                    # 降级口径：低置信 → 拒识门拦
        "next_action": "",
    }
