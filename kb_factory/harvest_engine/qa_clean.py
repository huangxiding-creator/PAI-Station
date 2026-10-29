# -*- coding: utf-8 -*-
"""全文质检清洗器（C1/轴④）——收割全文通用去污件（KB-FACTORY 2.0 百倍质量战役）。

只加不改：本文件为 harvest_engine 域**新件**，不改任何既有文件与开关
（engine.py 等既有开关不碰，纪律）。

能力：
  1. clean_text(text, source) -> (cleaned, ops)
     - 广告页剔除：尾注/免责声明行、站点水印行、联系方式块（正则逐行判定）
     - 乱码修复：常见 mojibake（UTF-8 字节被误按 GBK 解码）逐行"回编码 GBK
       再严格按 UTF-8 解码"自愈；仅在判定为疑似误码（GBK 扩展区罕见字指纹≥2
       且无常用字）且解码严格成功时采用——宁可不修，不可修错（零造假）
     - 空白规整：CRLF/BOM/零宽字符/不间断与全角空格/行尾空白/连续空行/行内连续空格
     - ops 记账：每项操作记 {"op": 名称, "count": 次数(行数或出现次数),
       "evidence": 首例摘要}；不动原文则 ops == []（可作回归断言）
  2. clean_file(path) -> dict
     - 件级：读原文 → clean_text → 同目录回写 <stem>.cleaned.md
     - 原件保留禁删禁改（清理纪律铁律）；编码探测 utf-8(-sig) → gbk 兜底

接线说明（新能力接线位，供编排/后续腿引用）：
  - 任何拿到全文的腿（harvest_engine.fetch/parse 落库前、kb_server 履约生成后、
    export_mkdocs 导出前）调用 clean_text(text, source=渠道名) 即可，纯函数无副作用；
  - ops 非空时应随件落账（审计位）：evidence 存被删/被修行首例摘要，供零造假抽查；
  - 纯标准库、零第三方依赖，本地与云托管(cloudfn)两侧可共用同一文件。

安全边界（防误删正文）：
  - 仅处理短行（≤60 字符）且非 Markdown 结构行（# / | / > / ` 引导）；
  - 围栏代码块(```)内部不清理；
  - 站点水印行需"剔除站点关键词与域名后剩余有效内容 < 6 字"（书名类正文行不误伤）；
  - 联系方式：连续 ≥2 行命中成块删除；单行命中须 ≤30 字、无句号且含渠道词；
  - "来源：某某公报"类事实性引用行一律保留（不属于站点水印）。
"""
from __future__ import annotations

import re
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

__all__ = ["clean_text", "clean_file"]

# ── 可读性判分用：现代汉语超高频字采样（仅作自愈前后比较，非词表权威） ──
_COMMON_CHARS = set(
    "的一是了我不人在他有这个上们来到时大地为子中你说生国年着就那和要她出"
    "也得里后自以会家可下而过天去能对小多然于心学么之都好看起发当没成只如"
    "事把还用第样道想作种开美总从无情己面最女但现前些所同日手又行意动方期"
    "它头经长儿回位分爱老因很给名法间知世什两次使身者被高已亲其进此话常与活正感"
)


def _cjk(ch: str) -> bool:
    """是否中日韩统一表意文字（基本区）。"""
    return "一" <= ch <= "鿿"


def _cjk_len(s: str) -> int:
    return sum(1 for ch in s if _cjk(ch))


def _score(s: str) -> int:
    """常用字得分：自愈结果不应比原文更不像中文。"""
    return sum(1 for ch in s if ch in _COMMON_CHARS)


def _build_moji_set() -> set:
    """GBK 扩展区罕见字指纹集：UTF-8 汉字字节流(E4-E9 引导)被按 GBK 误读后，
    落点集中在 GBK 双字节码 E480-E9BF 的罕见汉字区——常用汉字(GB2312 一级
    区 B0A1-D7F9)几乎不在此区，可作误码指纹。导入时一次性构造(≤384 次解码)。"""
    out = set()
    for b1 in range(0xE4, 0xEA):
        for b2 in range(0x80, 0xC0):
            try:
                out.add(bytes([b1, b2]).decode("gbk"))
            except UnicodeDecodeError:
                pass
    return out


_MOJI_CJK = _build_moji_set()


def _suspect_mojibake(s: str) -> bool:
    """疑似 UTF-8→GBK 双解码误码：罕见字指纹 ≥2 且无常用字（或含锟斤拷残留）。"""
    m = sum(1 for ch in s if ch in _MOJI_CJK)
    if m >= 2 and _score(s) == 0:
        return True
    return bool(m >= 1 and "锟斤拷" in s)


def _heal_line(line: str) -> Optional[str]:
    """单行 mojibake 自愈：先归并"锟斤拷"残留为替换符，再尝试
    回编码 GBK → 严格按 UTF-8 解码；仅在不劣化可读性时采用。
    返回 None 表示未动；返回新串表示已修。"""
    collapsed, _n = re.subn(r"(?:锟斤拷)+", "�", line)
    if not _suspect_mojibake(collapsed):
        return None
    try:
        healed = collapsed.encode("gbk", "strict").decode("utf-8", "strict")
    except (UnicodeEncodeError, UnicodeDecodeError):
        return collapsed if collapsed != line else None
    if healed == collapsed or "�" in healed:
        return collapsed if collapsed != line else None
    if _score(healed) >= _score(collapsed) and (_cjk_len(collapsed) == 0 or _cjk_len(healed) >= 1):
        return healed
    return collapsed if collapsed != line else None

# ── 广告/水印/尾注行模式（逐行匹配；受短行+非结构行前置闸门保护） ──
_FOOTER_PATTERNS = [
    re.compile(r"(如有侵权|涉及版权|侵权)[^。]{0,20}?(请联系|请告知|删除|下架)"),
    re.compile(r"免责声明|版权声明"),
    re.compile(r"(本文档|本文|本页|本资料)[^。]{0,14}?(仅供|仅供)(学习|参考|交流|内部)"),
    re.compile(r"^(—{2,}|-{3,}|\(|（)?(完|全文完|END|The End|结束)(—{2,}|-{3,}|\)|）)?$",
               re.IGNORECASE),
]
_WATERMARK_PATTERNS = [
    re.compile(r"(本文档|本文|本页|该文档|此文档)[^。]{0,16}?(来自|来源于|来源|出自|下载于|整理于|搜集于)"),
    re.compile(r"(转载|引用|摘录)[^。]{0,8}?请注明(出处|来源)"),
    re.compile(r"(更多|完整版|全文|后续|资料)[^。]{0,12}?(请|需)(登录|下载|购买|开通|联系|关注|访问|前往|扫码)"),
    re.compile(r"(扫码|扫描)[^。]{0,10}?(二维码|关注|领取|获取|查看)"),
    re.compile(r"(关注|添加)[^。]{0,6}?(公众号|微信号|客服|QQ群?)"),
    re.compile(r"(VIP|vip)会员|开通会员|会员专享|付费后|登录后才能|您的积分|余额不足"),
]
_SITE_KEYWORDS = [
    "道客巴巴", "豆丁网", "豆丁", "百度文库", "爱问资料", "人人文库", "淘豆网",
    "原创力文档", "得力文库", "冰豆网", "读览天下", "book118", "doc88",
    "docin", "wenku.baidu", "mbalib",
]
# 渠道专属水印补充词（source 参数在此生效；只收录确定无疑的站点自指词）
_SOURCE_EXTRA = {
    "wenku": ["百度文库", "wenku.baidu.com"],
    "doc88": ["doc88.com"],
    "docin": ["豆丁网", "docin.com"],
    "book118": ["book118.com"],
}
_SITE_HOST_RE = re.compile(r"(?:www\.)?[0-9A-Za-z\-]{2,32}(?:\.com|\.cn|\.net|\.org)\b")
_PAGE_MARKER_RE = re.compile(r"^第?\s*\d+\s*页(?:\s*[/，,]?\s*(?:共\s*)?\d+\s*页)?$")
_CONTACT_PATTERNS = [
    re.compile(r"(电话|手机|热线|微信|微信号|QQ|QQ号|qq|邮箱|电子邮件|EMAIL|E-mail)"
               r"\s*[:：]\s*[0-9A-Za-z@\-_.，、/]{4,}"),
    re.compile(r"(咨询|联系|客服|订购|加盟|代理)\s*[:：]?\s*1[3-9]\d{9}"),
    re.compile(r"1[3-9]\d{9}"),
    re.compile(r"[0-9A-Za-z][0-9A-Za-z._%+\-]*@[0-9A-Za-z\-]+\.[0-9A-Za-z.\-]{2,}"),
]
_CONTACT_WORDS = re.compile(r"微信|公众号|QQ|电话|热线|客服|咨询|扫码|二维码|邮箱|邮件")

# 行清理操作名（与 ops["op"] 对应）
_OP_FOOTER = "footer_removed"
_OP_WATERMARK = "watermark_removed"
_OP_CONTACT = "contact_removed"
_OP_PAGE = "page_marker_removed"


def _site_keywords(source: str) -> List[str]:
    kws = list(_SITE_KEYWORDS) + list(_SOURCE_EXTRA.get(source.lower(), []))
    src = source.lower()
    if len(src) >= 4 and src.replace("_", "").replace("-", "").isalnum():
        kws.append(src)  # 渠道名本身也可能是水印词（如转储标记行）
    return kws


def _is_site_line(s: str, source: str) -> bool:
    """站点水印行：含站点关键词或域名，且剔除后剩余有效内容不足 6 字。"""
    rest = s
    hits = 0
    host = _SITE_HOST_RE.search(rest)
    while host:
        rest = rest.replace(host.group(0), " ")
        hits += 1
        host = _SITE_HOST_RE.search(rest)
    for kw in _site_keywords(source):
        if kw and kw in rest:
            rest = rest.replace(kw, " ")
            hits += 1
    if not hits:
        return False
    rest = re.sub(r"[\s\.\-—_·•:：,，。;；!！?？《》“”\"'()（）\[\]{}]+", "", rest)
    return _cjk_len(rest) + sum(1 for ch in rest if ch.isalnum()) < 6


def _is_contact(s: str) -> bool:
    """联系方式行：短行且命中电话/微信/QQ/邮箱等模式；含句号视为正文引用不删。"""
    if len(s) > 40 or "。" in s or "；" in s:
        return False
    return any(p.search(s) for p in _CONTACT_PATTERNS)


def _line_kind(line: str, source: str) -> Optional[str]:
    """判定单行属于哪类待剔除内容；None=保留。"""
    s = line.strip()
    if not s or len(s) > 60:
        return None
    if s[0] in "#|>`":  # Markdown 结构行（标题/表格/引用/行内代码引导）不清理
        return None
    if _PAGE_MARKER_RE.match(s):
        return _OP_PAGE
    for pat in _FOOTER_PATTERNS:
        if pat.search(s):
            return _OP_FOOTER
    for pat in _WATERMARK_PATTERNS:
        if pat.search(s):
            return _OP_WATERMARK
    if _is_site_line(s, source):
        return _OP_WATERMARK
    if _is_contact(s):
        return _OP_CONTACT
    return None


def clean_text(text: str, source: str = "") -> Tuple[str, List[Dict[str, Any]]]:
    """清洗单篇全文。

    参数：
      text   : 全文字符串
      source : 渠道名（如 "wenku"/"doc88"），用于追加渠道专属水印词；可空串
    返回：
      (cleaned, ops)；ops 为操作记账列表（零造假：不动原文则 ops == []），
      每项 {"op": 操作名, "count": 行数/次数, "evidence": 首例摘要或 None}。
    """
    ops: List[Dict[str, Any]] = []
    if not text:
        return text, ops

    def op(name: str, count: int, evidence: Optional[str] = None) -> None:
        if count > 0:
            ops.append({"op": name, "count": count, "evidence": evidence})

    # 1) 结构性空白归一（BOM/零宽/CRLF/孤立CR）
    n_bom = 1 if text.startswith("﻿") else 0
    if n_bom:
        text = text.lstrip("﻿")
    n_zw = len(re.findall(r"[​‌‍﻿]", text))
    if n_zw:
        text = re.sub(r"[​‌‍﻿]", "", text)
    n_crlf = text.count("\r\n")
    if n_crlf:
        text = text.replace("\r\n", "\n")
    n_cr = text.count("\r")
    if n_cr:
        text = text.replace("\r", "\n")
    op("bom_removed", n_bom, "﻿" if n_bom else None)
    op("zero_width_removed", n_zw)
    op("crlf_normalized", n_crlf + n_cr)

    # 末行换行单独记忆（保证"无脏不动"字节级成立）
    had_final_nl = text.endswith("\n")
    body = text[:-1] if had_final_nl else text
    lines = body.split("\n")

    # 2) mojibake 逐行自愈
    healed_count = 0
    healed_evi: Optional[str] = None
    for i, ln in enumerate(lines):
        new = _heal_line(ln)
        if new is not None and new != ln:
            lines[i] = new
            healed_count += 1
            healed_evi = healed_evi or ln.strip()[:40]
    op("mojibake_fixed", healed_count, healed_evi)

    # 3) 广告/水印/尾注/联系方式/页码行剔除（围栏代码块内不清理）
    counts = {_OP_FOOTER: 0, _OP_WATERMARK: 0, _OP_CONTACT: 0, _OP_PAGE: 0}
    evid = {k: None for k in counts}
    kinds: List[Optional[str]] = []
    in_fence = False
    for ln in lines:
        if ln.lstrip().startswith("```"):
            in_fence = not in_fence
            kinds.append("FENCE")
            continue
        kinds.append(None if in_fence else _line_kind(ln, source))

    out_lines: List[str] = []
    j = 0
    while j < len(lines):
        k = kinds[j]
        if k == "FENCE":
            out_lines.append(lines[j])
            j += 1
            continue
        if k == _OP_CONTACT:
            e = j
            while e < len(lines) and kinds[e] == _OP_CONTACT:
                e += 1
            run = [lines[x].strip() for x in range(j, e)]
            # 连续≥2行成块删除；单行须更严（≤30字且含渠道词）
            if (e - j) >= 2 or all(len(x) <= 30 and _CONTACT_WORDS.search(x) for x in run):
                counts[_OP_CONTACT] += e - j
                evid[_OP_CONTACT] = evid[_OP_CONTACT] or (run[0][:40] if run else None)
                j = e
                continue
            out_lines.append(lines[j])  # 不满足成块/单行从严条件→保留
            j += 1
            continue
        if k in counts:
            counts[k] += 1
            evid[k] = evid[k] or lines[j].strip()[:40]
            j += 1
            continue
        out_lines.append(lines[j])
        j += 1
    for k in counts:
        op(k, counts[k], evid[k])

    # 4) 行内空白规整（nbsp/全角空格、行尾与行首浅缩进、行内连续空格）
    n_nbsp = 0
    n_trim = 0
    n_mspace = 0
    trim_evi: Optional[str] = None
    for idx, ln in enumerate(out_lines):
        c = ln.count(" ") + ln.count("　")
        if c:
            ln = ln.replace(" ", " ").replace("　", " ")
            n_nbsp += c
        t = ln.rstrip()
        if t != ln:
            n_trim += 1
            trim_evi = trim_evi or (ln[:20] + "…")
            ln = t
        stripped = ln.lstrip(" ")
        lead = len(ln) - len(stripped)
        if 0 < lead < 4:  # ≥4 空格缩进可能是代码块，不动
            ln = stripped
            n_trim += 1
        if "|" not in ln:  # 表格行对齐空格不动
            new, k2 = re.subn(r" {2,}", " ", ln)
            if k2:
                n_mspace += k2
                ln = new
        out_lines[idx] = ln
    op("nbsp_normalized", n_nbsp)
    op("whitespace_trimmed", n_trim, trim_evi)
    op("multi_space_merged", n_mspace)

    # 5) 连续空行折叠（≥2 连续空行→1；文首/文尾空行剔除）
    n_blank = 0
    collapsed: List[str] = []
    for ln in out_lines:
        if ln == "":
            if not collapsed or collapsed[-1] == "":
                n_blank += 1
                continue
            collapsed.append("")
        else:
            collapsed.append(ln)
    op("blank_lines_collapsed", n_blank)

    cleaned = "\n".join(collapsed)
    if had_final_nl and cleaned:
        cleaned += "\n"  # 结构性保留，不记账
    if not had_final_nl and cleaned != text and cleaned and not cleaned.endswith("\n"):
        cleaned += "\n"
        op("newline_terminated", 1)

    if cleaned == text and not ops:
        return text, []  # 无脏不动：字节不变且零操作
    return cleaned, ops


def clean_file(path, source: Optional[str] = None) -> Dict[str, Any]:
    """件级清洗：读原文 → clean_text → 同目录回写 <stem>.cleaned.md。

    原件保留禁删禁改（铁律）；返回记账 dict（含 out_path/changed/ops 等，
    零造假：changed 如实反映净变化，ops 如实反映逐项操作）。
    """
    p = Path(path)
    raw = p.read_bytes()
    if raw[:3] == b"\xef\xbb\xbf":
        text = raw.decode("utf-8-sig", "replace")
    else:
        try:
            text = raw.decode("utf-8")
        except UnicodeDecodeError:
            text = raw.decode("gbk", "replace")
    src = source if source else (p.suffix.lstrip(".") or "file")
    cleaned, file_ops = clean_text(text, src)
    out = p.with_name(p.stem + ".cleaned.md")
    with open(out, "w", encoding="utf-8", newline="\n") as f:
        f.write(cleaned)
    return {
        "path": str(p),
        "out_path": str(out),
        "changed": cleaned != text,
        "ops": file_ops,
        "in_chars": len(text),
        "out_chars": len(cleaned),
    }
