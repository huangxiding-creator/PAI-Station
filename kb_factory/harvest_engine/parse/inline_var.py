# -*- coding: utf-8 -*-
"""inline_var 内联变量挖掘（T03 三态）：从站点页面 HTML 挖内嵌 JS 变量（纯解析，零网络）。

三态（SYNTHESIS §2-6；分别支撑 FR2.1 wenku / FR3.1 book118 / FR4.1 doc88）：

1. wenku pageData —— WENKU_SPEC §3.1 extractPageData 逻辑等价移植（源件
   wenku-pdf.beauty.js W:63-131）：锚点 ``var pageData`` → 其后第一个 ``{`` 起，
   引号/转义感知的花括号配平扫描 → 严格 JSON 反序列化。
2. book118 PREVIEW_DATA —— BOOK118_SPEC §1/§2 语义移植（源件 book118-downloader
   DocumentBrowser.java）：PREVIEW_DATA 为**非严格 JSON**（parseInt('...') 包裹、
   单引号、无引号键），不可 json.loads，按「键定位校验 + 单引号取值」逐字段提取；
   键定位必须校验 key 后紧跟冒号，否则 ``aid`` 会误配 ``aid_encode``。
3. doc88 m_main.init —— DOC88_SPEC §1.2 方法2：正则 ``m_main\\.init\\("([^"]*)"\\);``
   捕获变体 base64 载荷（解码归 codec 件，不在本件）。

墙判定（doc88 WAF「网络环境安全验证」、book118 无预览、wenku 403）与报错文案映射
（如 wenku 的 failed to extract pageData from HTML）归 adapters 各站件；本件
契约统一为「命中返回数据，未命中返回 None」。
"""
import json
import re

WENKU_ANCHOR = "var pageData"        # wenku view 页锚点（WENKU_SPEC §3.1）
BOOK118_ANCHOR = "PREVIEW_DATA"      # book118 NewView 页锚点（BOOK118_SPEC §1）
DOC88_M_MAIN_PATTERN = re.compile(r'm_main\.init\("([^"]*)"\);')  # DOC88_SPEC §1.2 方法2

#: PREVIEW_DATA 必得四字段（缺一即视为无有效预览数据，Java 原作 getPreviewData 同口径）
BOOK118_REQUIRED_STR_KEYS = ("aid", "view_token", "aid_encode")


def extract_page_data(html: str) -> dict | None:
    """wenku 态：锚点+花括号配平提取 pageData（引号/转义感知扫描）。

    - 找不到锚点 / 锚点后无 '{' / 扫到结尾花括号仍不配平 → None。
    - 配平切片按严格 JSON 解析（源件走 JSON.parse）；解析失败统一 None——
      源件此处会抛 SyntaxError，本件收敛为 None 由调用方映射错误文案（见模块 docstring）。
    - 扫描规则（照抄 W:63-131）：字符串态内 ``\\`` 置转义位（下一字符原样吞掉），
      同引号闭合字符串；字符串外的 ``{``/``}``` 计深度，深度归零即切片终点。
      单引号字符串同样感知（源件防御性行为，严格 JSON 下不会出现在合法载荷里）。
    """
    anchor = html.find(WENKU_ANCHOR)
    if anchor < 0:
        return None
    start = html.find("{", anchor)
    if start < 0:
        return None
    depth = 0
    in_string = False
    quote = ""
    escaped = False
    for i in range(start, len(html)):
        ch = html[i]
        if in_string:
            if escaped:
                escaped = False
                continue
            if ch == "\\":
                escaped = True
                continue
            if ch == quote:
                in_string = False
            continue
        if ch == '"' or ch == "'":
            in_string = True
            quote = ch
            continue
        if ch == "{":
            depth += 1
        elif ch == "}":
            depth -= 1
            if depth == 0:
                try:
                    return json.loads(html[start:i + 1])
                except json.JSONDecodeError:
                    return None
    return None


def _find_key_pos(s: str, key: str, from_index: int) -> int:
    """键定位校验：key 后跳过空白即必须是冒号，否则续搜（防 aid 误配 aid_encode/aider）。"""
    idx = s.find(key, from_index)
    while idx != -1:
        j = idx + len(key)
        while j < len(s) and s[j].isspace():
            j += 1
        if j < len(s) and s[j] == ":":
            return idx
        idx = s.find(key, idx + 1)
    return -1


def _parse_project_id(s: str, key_pos: int) -> int | None:
    """project_id 取值：冒号后到首个 ',' 或 '}'（先到者）→ strip → int。

    值可能是对象末字段（'\\}' 结束）；Java 原作注释明示该边界。
    """
    start = s.find(":", key_pos + 1)
    if start == -1:
        return None
    end = s.find(",", start + 1)
    brace_end = s.find("}", start + 1)
    if end == -1 or (brace_end != -1 and brace_end < end):
        end = brace_end
    if start == -1 or end == -1:
        return None
    try:
        return int(s[start + 1:end].strip())
    except ValueError:
        return None


def _parse_single_quoted(s: str, key_pos: int) -> str | None:
    """键后首个单引号对取值——aid 形如 parseInt('188244482')，按值两侧单引号提取。"""
    start = s.find("'", key_pos + 1)
    if start == -1:
        return None
    end = s.find("'", start + 1)
    if end == -1:
        return None
    return s[start + 1:end]


def extract_preview_data(html: str) -> dict | None:
    """book118 态：NewView 页 PREVIEW_DATA 四字段提取（非严格 JSON，禁 json.loads）。

    返回 ``{"project_id": int, "aid": str, "view_token": str, "aid_encode": str}``；
    锚点缺失或四字段任一缺失/不成形 → None（openapi URL 四参数缺一不可）。
    搜索自 PREVIEW_DATA 锚点起（Java 原作 getPreviewData 同口径）。
    """
    pos = html.find(BOOK118_ANCHOR)
    if pos < 0:
        return None
    key_pos = _find_key_pos(html, "project_id", pos)
    project_id = _parse_project_id(html, key_pos) if key_pos != -1 else None
    data = {"project_id": project_id}
    for key in BOOK118_REQUIRED_STR_KEYS:
        key_pos = _find_key_pos(html, key, pos)
        data[key] = _parse_single_quoted(html, key_pos) if key_pos != -1 else None
    if any(v is None for v in data.values()):
        return None
    return data


def extract_m_main(html: str) -> str | None:
    """doc88 态：m_main.init("...") 正则捕获变体 base64 载荷（key1 解码归 codec 件）。

    DOC88_SPEC §1.2 方法2（页面回退路）；无调用/空载荷 → None——
    调用方结合页面特征（如「网络环境安全验证」）落 blocked_waf 等 wall_status。
    """
    m = DOC88_M_MAIN_PATTERN.search(html)
    if m is None:
        return None
    return m.group(1) or None
