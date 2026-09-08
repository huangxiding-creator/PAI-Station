"""截图→GLM-4V-Flash→结构化事件 JSON（提案 4.3 视觉感知）。

describe_event：通用事件结构化（app/activity/topics）；
wechat_snapshot：微信窗口识别+消息概要（纯视觉只读通道用，不外发原文）。
视觉链失败 → 最小事件（字段空 + error 留痕）——感知缺席不崩。
"""
import json

_EVENT_SCHEMA = {
    "type": "object",
    "properties": {
        "app": {"type": "string", "description": "画面中的应用或网站"},
        "activity": {"type": "string", "description": "用户正在做什么"},
        "topics": {"type": "array", "items": {"type": "string"},
                   "description": "涉及主题（≤3 个）"}},
    "required": ["app", "activity", "topics"]}

_WECHAT_SCHEMA = {
    "type": "object",
    "properties": {
        "is_wechat": {"type": "boolean",
                      "description": "画面是否为微信 PC 客户端窗口"},
        "messages_summary": {"type": "string",
                             "description": "未读/可见消息的一句话概要"
                                            "（禁止复述原文，只说条数和性质）"}},
    "required": ["is_wechat", "messages_summary"]}


def _call(vision_fn, image_path: str, schema: dict) -> dict:
    """vision 契约调用 + json 字段解包；返回原始 dict。"""
    result = vision_fn(image_path, schema)
    data = result.get("json") if isinstance(result, dict) else None
    return data if isinstance(data, dict) else {}


def describe_event(vision_fn, image_path: str) -> dict:
    """截图 → 结构化事件；失败降级最小事件。"""
    try:
        data = _call(vision_fn, image_path, _EVENT_SCHEMA)
        return {"app": str(data.get("app", "")),
                "activity": str(data.get("activity", "")),
                "topics": [str(t) for t in data.get("topics") or []][:3]}
    except Exception as exc:  # noqa: BLE001 - 视觉链故障→空事件不崩
        return {"app": "", "activity": "", "topics": [], "error": str(exc)[:120]}


def wechat_snapshot(vision_fn, image_path: str) -> dict:
    """截图 → 微信窗口识别+消息概要（只读感知，绝不外发原文）。"""
    try:
        data = _call(vision_fn, image_path, _WECHAT_SCHEMA)
        return {"is_wechat": bool(data.get("is_wechat", False)),
                "messages_summary": str(data.get("messages_summary", ""))}
    except Exception as exc:  # noqa: BLE001
        return {"is_wechat": False, "messages_summary": "", "error": str(exc)[:120]}


def to_json(event: dict) -> str:
    """事件 → 落库用 JSON 行（中文不转义）。"""
    return json.dumps(event, ensure_ascii=False)
