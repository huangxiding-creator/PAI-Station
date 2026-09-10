"""Forge 安全闸门：隐形码位剥离 + 提示注入扫描 + 外泄启发式。

码位集与扫描规则移植自 virgiliojr94/book-to-skill（MIT，⭐29.5k，2026-09
源码级解剖结论）——微信读书等外部书源与 LLM 生成物同为一手注入面。
分层语义：剥离（sanitize）是硬层，永远执行；注入扫描是软层（advisory，
记录不拦截——讲 prompt 的书合法讨论注入话术，恒误报的闸门教会人无脑放行）；
外泄启发式（同句外联×敏感词成对）是硬层，拦截落盘。
"""
from __future__ import annotations

import re

# 1. 零宽/隐形占位：渲染为空，人看不见、模型全读
_ZERO_WIDTH_CODEPOINTS = frozenset({
    0x200B,  # ZERO WIDTH SPACE
    0x200C,  # ZERO WIDTH NON-JOINER
    0x200D,  # ZERO WIDTH JOINER
    0x2060,  # WORD JOINER
    0xFEFF,  # ZERO WIDTH NO-BREAK SPACE / BOM（非首位）
    0x00AD,  # SOFT HYPHEN
    0x034F,  # COMBINING GRAPHEME JOINER
    0x180E,  # MONGOLIAN VOWEL SEPARATOR
    0x2061,  # FUNCTION APPLICATION
    0x2062,  # INVISIBLE TIMES
    0x2063,  # INVISIBLE SEPARATOR
    0x2064,  # INVISIBLE PLUS
})

# 2. 双向格式控制——Trojan Source 一族（CVE-2021-42574）：改变人眼看到的顺序，
#    审阅者批准的内容与 agent 读到的指令可以不一致。删除后渲染序=逻辑序；
#    合法的右到左文字（阿拉伯/希伯来）由 Bidi 算法自身派生方向，不受影响。
_BIDI_CONTROL_CODEPOINTS = frozenset({
    0x200E, 0x200F, 0x061C,
    0x202A, 0x202B, 0x202C, 0x202D, 0x202E,
    0x2066, 0x2067, 0x2068, 0x2069,
})

# 3. 非格式控制但渲染为空白的"隐形字母"：正则空白归一吞不掉它们
_INVISIBLE_LETTER_CODEPOINTS = frozenset({
    0x115F, 0x1160,  # HANGUL CHOSEONG/JUNGSEONG FILLER
    0x3164, 0xFFA0,  # HANGUL FILLER / HALFWIDTH
})

# 4. 弃用/注音类格式控制：Default_Ignorable，提取正文中无合法用途
_ANNOTATION_FORMAT_CODEPOINTS = frozenset({
    0x206A, 0x206B, 0x206C, 0x206D, 0x206E, 0x206F,
    0xFFF9, 0xFFFA, 0xFFFB,  # INTERLINEAR ANNOTATION
})

_INVISIBLE_CODEPOINTS = (
    _ZERO_WIDTH_CODEPOINTS
    | _BIDI_CONTROL_CODEPOINTS
    | _INVISIBLE_LETTER_CODEPOINTS
    | _ANNOTATION_FORMAT_CODEPOINTS
)

# 5. Unicode tag 块：整段 ASCII 指令可藏成不可见"tag"字符
_TAG_BLOCK_START = 0xE0000
_TAG_BLOCK_END = 0xE007F

# 6. 变体选择器（基础+增补）：256 值/个，可编码任意载荷且渲染为空——
#    是组合记号而非格式控制，按类别过滤 Cf 的方案会漏掉它们
_VARIATION_SELECTOR_RANGES = ((0xFE00, 0xFE0F), (0xE0100, 0xE01EF))

# 7. 音乐节拍/乐句控制：零宽，可在任意文本处填充隐藏内容
_MUSICAL_FORMAT_RANGE = (0x1D173, 0x1D17A)


def is_invisible_codepoint(codepoint: int) -> bool:
    """该码位是否渲染为空、应被剥离。

    对外暴露（而非 _INVISIBLE_CODEPOINTS 集合本身），使剥离层与扫描层
    复用同一判定入口——两层防御不允许各自漂移（book-to-skill 实战教训：
    提取层漏掉 U+2060 而扫描层报它，人就被训练成无脑放行）。
    """
    if codepoint in _INVISIBLE_CODEPOINTS:
        return True
    if _TAG_BLOCK_START <= codepoint <= _TAG_BLOCK_END:
        return True
    if _MUSICAL_FORMAT_RANGE[0] <= codepoint <= _MUSICAL_FORMAT_RANGE[1]:
        return True
    return any(low <= codepoint <= high for low, high in _VARIATION_SELECTOR_RANGES)


def sanitize_text(text: str) -> tuple[str, int]:
    """剥离隐形码位 →（干净文本, 剥离计数）。"""
    kept: list[str] = []
    removed = 0
    for ch in text:
        if is_invisible_codepoint(ord(ch)):
            removed += 1
            continue
        kept.append(ch)
    return "".join(kept), removed


# 注入话术规则（advisory）：只认指令形态，不认英语短语本身
_CONTENT_RULES = (
    ("prompt.ignore_previous",
     re.compile(r"\bignore\s+(?:(?:all|any|the)\s+)?(?:previous|prior)\s+"
                r"(?:instructions?|prompts?|rules?|messages?)\b", re.IGNORECASE),
     "含指令覆盖话术"),
    ("prompt.disregard_system",
     re.compile(r"\bdisregard\s+(?:\w+\s+)?(?:the\s+)?(?:system|developer)\b",
                re.IGNORECASE),
     "含 system/developer 指令覆盖话术"),
    ("prompt.role_reassignment",
     re.compile(r"\byou\s+are\s+now\b", re.IGNORECASE),
     "含角色重指派话术"),
    ("prompt.fake_system_prefix",
     re.compile(r"^\s*(?:[-*]\s*)?(?:system|developer)\s*:", re.IGNORECASE),
     "含伪 system 消息前缀"),
    ("prompt.system_tag",
     re.compile(r"<\s*/?\s*system\b[^>]*>", re.IGNORECASE),
     "含 system 消息标签"),
    ("prompt.chat_template_tag",
     re.compile(r"<\|\s*im_start\s*\|>|\[\s*INST\s*\]", re.IGNORECASE),
     "含模型聊天模板定界符"),
    # 只匹配定界形式（<tool_call>/|tool_call|/[TOOL_CALL]/{{tool_call}}），
    # 不匹配英语短语——讲 agent/prompt 的书必然合法讨论 tool call
    ("prompt.tool_call_tag",
     re.compile(r"<\|?\s*/?\s*tool[_ -]?call\s*\|?>"
                r"|\[\s*/?\s*tool[_ -]?call\s*\]"
                r"|\{\{\s*/?\s*tool[_ -]?call\s*\}\}", re.IGNORECASE),
     "含 tool_call 控制记号"),
)

# 外泄启发式（blocking）：同句"外联动作×敏感目标"成对才拦
_OUTBOUND_TERM = re.compile(
    r"\b(?:curl|wget|send|post|upload|transmit)\b|https?://", re.IGNORECASE)
_SENSITIVE_TERM = re.compile(
    r"(?:\.env\b|\bbase64\b|\bsecrets?\b|\bcredentials?\b|\bapi[_ -]?keys?\b)",
    re.IGNORECASE)


def scan_injection(text: str) -> list[dict]:
    """扫描提示注入话术 → [{rule, line, message}]（advisory，不拦截）。"""
    findings = []
    for lineno, line in enumerate(text.splitlines(), 1):
        for rule, pattern, message in _CONTENT_RULES:
            if pattern.search(line):
                findings.append({"rule": rule, "line": lineno,
                                 "message": message})
    return findings


def find_exfiltration(text: str) -> list[dict]:
    """外泄启发式：同一行同时出现外联动作与敏感目标 → 阻断级。"""
    hits = []
    for lineno, line in enumerate(text.splitlines(), 1):
        if _OUTBOUND_TERM.search(line) and _SENSITIVE_TERM.search(line):
            hits.append({"rule": "exfil.outbound_pair", "line": lineno,
                         "message": "同句外联×敏感词（疑似外泄指令）"})
    return hits


def guard_generated(text: str) -> tuple[str, list[dict], list[dict]]:
    """生成物出厂三合一：剥离隐形码位 + 注入扫描（软）+ 外泄对检（硬）。"""
    clean, _removed = sanitize_text(text)
    return clean, scan_injection(clean), find_exfiltration(clean)
