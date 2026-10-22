# -*- coding: utf-8 -*-
r"""JSONP 剥壳（FR2.1/FR3.1 支撑件，纯函数零网络）。

真实回调形态（规格锚点）：
- wenku wkrtcs getbdjson（WENKU_SPEC §6.4）：`sf_edu_wenku_rtcs_doc_jsonp_1_{桶序号}(payload)`
  桶序号 1 起逐桶递增 → 回调名逐桶不同；壳内键 `document.xml` 为页对象数组（非 XML 字符串）。
- book118 openapi getPreview（BOOK118_SPEC §1）：`jsonpReturn(payload);` 键名带引号、
  值内 `\/` 转义——标准 json 解析器天然兼容，不做任何预处理。

剥壳三步（唯一权威序）：
1. 剥 callback 壳：锚定开头「标识符(」（容忍 BOM/首空白/点分名/`$`/名后空白）；
2. 括号配平截取：字符串感知计数——双引号串内的 ()[]{} 与 \" \\ \/ 转义不参与配平
   （图 URL 常含 `)` 等，裸计数必错）；壳开括号 `(` 本身入栈，首个使栈空的 `)` 即闭合；
   闭合后仅容忍空白与至多一个分号；
3. json.loads：payload 非 JSON 时统一抛 JsonpError（链上保留原始 JSONDecodeError）。

统一语言：等价抽取（payload 原文切片原样返回，不重排不加料）；本件不涉网络，
实弹（真实端点往返）用例归适配器层，不在本件。
"""
import json
import re
from typing import Any

__all__ = ["JsonpError", "jsonp_payload", "strip_jsonp"]

_CALLBACK_HEAD = re.compile(r"^[\s﻿]*((?:[\w$]+\.)*[\w$]+)\s*\(")
_TRAILING_OK = re.compile(r"\s*;?\s*\Z")
_PAIR = {"(": ")", "[": "]", "{": "}"}  # 开括号 → 期待闭括号


class JsonpError(ValueError):
    """剥壳失败统一异常（无 callback 壳/回调名不符/配平破缺/闭合后残留/payload 非 JSON）。"""


def jsonp_payload(text: str, callback: str | None = None) -> tuple[str, str]:
    r"""剥壳+括号配平截取（第 1-2 步）：返回 (实际回调名, payload 原文切片)，不解析 JSON。

    - text：完整响应体（容忍 BOM/首尾空白/闭合括号后至多一个分号）。
    - callback：期望回调名的精确等值校验（wenku 桶序号由调用方拼全名传入）；
      防 WAF/风控把响应换成另一副壳时被误吞。None=不校验。
    - 配平为字符串感知版：双引号串内的括号与反斜杠转义被跳过，只有串外括号计数。
    """
    if not isinstance(text, str):
        raise JsonpError(f"响应体须为 str，实得 {type(text).__name__}（bytes 请先按编码解码）")
    head = _CALLBACK_HEAD.match(text)
    if head is None:
        raise JsonpError("未识别 callback 壳：须为「标识符(」开头的 JSONP 形态")
    name = head.group(1)
    if callback is not None and name != callback:
        raise JsonpError(f"回调名不符：期望 {callback!r}，实得 {name!r}")
    start = head.end()  # 首个 ( 之后
    stack = ["("]  # 壳开括号本身入栈：首个使栈空的 ) 即壳闭合
    in_string = False
    escaped = False
    for i in range(start, len(text)):
        ch = text[i]
        if in_string:
            if escaped:
                escaped = False
            elif ch == "\\":
                escaped = True
            elif ch == '"':
                in_string = False
            continue
        if ch == '"':
            in_string = True
        elif ch in _PAIR:
            stack.append(ch)
        elif ch in ")]}":
            if _PAIR.get(stack[-1]) != ch:
                raise JsonpError(f"括号配平失败：第 {i} 个字符 {ch!r} 与栈顶开括号不匹配")
            stack.pop()
            if not stack:  # 栈空=壳闭合
                rest = text[i + 1:]
                if not _TRAILING_OK.match(rest):
                    raise JsonpError(f"闭合括号后残留非空白内容：{rest[:40]!r}")
                return name, text[start:i]
    raise JsonpError("括号配平失败：闭合括号缺失（payload 未闭合或字符串未终止）")


def strip_jsonp(text: str, callback: str | None = None) -> Any:
    """剥壳三步全链（第 1-3 步）：jsonp_payload → json.loads，返回解析后的 Python 对象。

    payload 非 JSON（如风控纯文案、JS 单引号串）时抛 JsonpError，`__cause__` 保留原始
    json.JSONDecodeError——失败可归因，不静默吞错、不猜内容。
    """
    name, payload = jsonp_payload(text, callback)
    try:
        return json.loads(payload)
    except json.JSONDecodeError as exc:
        raise JsonpError(
            f"payload 非 JSON（回调={name}，长度={len(payload)}）：{exc.msg} 于第 {exc.pos} 字符") from exc
