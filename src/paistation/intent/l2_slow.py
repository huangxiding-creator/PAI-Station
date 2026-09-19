"""M7c L2 慢通道：银甲虫 LLM prompt 移植 + UItron 三档复杂度路由。

方法论栈第③层：段摘要→LLM。三档（UItron 思想，按需烧 token）：
  - simple  L1 高置信且主导清晰 → 直判，不调 LLM
  - complex 常规段 → LLM 段摘要（银甲虫 strict JSON，temp 0.2）
  - hardest 混杂/未识别 → LLM + 需要屏幕观察（M8 感知升级件接入位，
    当前降级为纯 LLM 并标 needs_screen）

失败安全：网关全死 / JSON 解析失败 → 降级 L1 直判 conf=0.3
（低置信会被 reject_gate 拒掉——缺席不崩且不误报）。
ICL 修正样本由 flywheel.build_icl 注入（第⑥层纠正飞轮接线点）。

Jev 快路径（09-19 深度融合，E1 实证：conf(对)0.92 vs conf(错)0.70
可路由、p50 1.3s、$0.0001/次）：complex/hardest 档先经判断层
category Choice + needs_screen Noul 并行两问——confidence ≥ 0.75 且
无需屏幕 → 直判跳过 LLM；否则回退 LLM 原路径。jev 缺席/失败/低置信
→ 原路径分毫不动。
"""
from __future__ import annotations

import json
import re

TIER_SIMPLE = "simple"
TIER_COMPLEX = "complex"
TIER_HARDEST = "hardest"

JEV_DIRECT_CONF = 0.75           # 快路径置信门槛（E1 风险覆盖曲线选定）

# 与 l1_fast 十类对齐（E1 实验口径）
_JEV_CATEGORY_CRITERIA = {
    "project": "正在编码、开发软件、写工程文档（IDE、代码仓库、技术文档站）",
    "docs": "阅读或编写文档、笔记、知识整理（文档编辑器、笔记软件、Wiki）",
    "research": "搜索资料、阅读资讯、观看学习视频、学术调研",
    "meeting": "参加线上会议或观看直播（会议软件、会议窗口标题）",
    "leisure": "娱乐休闲（视频、游戏、音乐、购物、社交浏览）",
    "chat": "即时通讯聊天（微信、QQ、钉钉等聊天工具）",
    "thinking": "短暂思考或发呆（无明确应用焦点或白板/计算器等轻工具）",
    "system": "系统操作（文件管理、设置、终端命令、安装软件）",
    "idle": "离开电脑或长时间无操作",
    "unknown": "无法判断",
}

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


def build_messages(block: dict, icl: str = "",
                   screen_text: str = "") -> list[dict]:
    user = []
    if icl:
        user.append(icl)
    if screen_text:
        user.append(f"[屏幕观察]\n{screen_text}")
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


def summarize_block(block: dict, gateway, icl: str = "",
                    screen=None, jev=None) -> dict:
    """活动块 → 意图判读。gateway: execute.LlmGateway（chat(msgs,**kw)）。

    screen: 屏幕观察提供方（M8 升级件，() -> {"tier","text"}|str|None）。
    仅 hardest 档调用；simple 档零调用（省资源）。
    jev: 判断层快路径（judgment.JudgmentClient.ask 或等价
    callable(state, questions)->answers|None）；高置信直判跳过 LLM。
    """
    tier = route(block)
    if tier == TIER_SIMPLE:
        out = _l1_direct(block)
        out.update({"tier": tier, "llm": False, "screen_used": False})
        return out
    if jev is not None:
        fast = _jev_direct(jev, block)
        if fast is not None:
            fast.update({"tier": tier, "llm": False, "engine": "jev",
                         "screen_used": False})
            return fast
    out = _l1_direct(block)
    out["tier"] = tier
    out["llm"] = False
    out["screen_used"] = False
    screen_text = _observe_screen(screen) if tier == TIER_HARDEST else ""
    try:
        text, provider = gateway.chat(
            build_messages(block, icl, screen_text), temperature=0.2)
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
    parsed["screen_used"] = bool(screen_text)
    return parsed


def _observe_screen(screen) -> str:
    """屏幕观察接缝（fail-soft）：任何形态失败/缺席 → 空串。"""
    if screen is None:
        return ""
    try:
        obs = screen()
    except Exception:  # noqa: BLE001
        return ""
    if isinstance(obs, dict):
        return str(obs.get("text") or "").strip()
    if isinstance(obs, str):
        return obs.strip()
    return ""


def _jev_direct(jev, block: dict) -> dict | None:
    """判断层快路径：Choice(十类)+Noul(需屏幕) 并行两问。

    高置信且无需屏幕 → 精简判读（省一次 LLM 调用）；
    jev 失败/低置信/要屏幕 → None（回退 LLM 原路径）。
    """
    try:
        answers = jev(render_digest(block), {
            "category": {
                "type": "choice",
                "instructions": "根据活动记录判断用户该时段的电脑使用意图类别",
                "criteria": _JEV_CATEGORY_CRITERIA,
            },
            "needs_screen": {
                "type": "noul",
                # V3 措辞（09-19 四变体实测：抽象「能否可靠判断」诱导保守
                # 0.17-0.27；测标题具体度分离度最佳——明确块 0.94/0.95、
                # 无标题 0.08）
                "instructions": "该活动记录中的窗口标题是否"
                                "明确指向某一类具体活动？",
                "criteria": {
                    "true": "标题具体清晰（如具体文件名/网站名/应用名）",
                    "false": "标题泛化含混（如无标题/新标签页/仅应用名）",
                },
            },
        })
    except Exception:  # noqa: BLE001 - 判断层故障回退 LLM
        return None
    if not isinstance(answers, dict):
        return None
    try:
        cat = answers["category"]
        noul = float(answers["needs_screen"]["noul"])
        conf = float(cat["confidence"])
        choice = str(cat["choice"])
        probs = cat["probabilities"]
    except (KeyError, TypeError, ValueError):
        return None
    if conf < JEV_DIRECT_CONF or noul < 0.5 or choice not in _JEV_CATEGORY_CRITERIA:
        return None
    titles = block.get("titles") or [""]
    top2 = sorted(probs.items(), key=lambda kv: -kv[1])[:2]
    return {
        "activity": titles[0] or choice,
        "project": "",
        "category": choice,
        "summary": f"Jev 直判: {choice}（top2: "
                   + ", ".join(f"{k}={v:.2f}" for k, v in top2) + "）",
        "evidence": [],
        "confidence": conf,
        "next_action": "",
        "needs_screen": False,
        "jev_distribution": probs,
    }


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
