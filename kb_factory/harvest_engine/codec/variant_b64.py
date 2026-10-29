# -*- coding: utf-8 -*-
"""变体 base64 码表 codec（注册制）——doc88 key1/key2 平移替换自实现（方案B，零 GPL 码）。

机制（DOC88_SPEC §1.2/§1.3/§2，探针独立复现，非抄 GPL 源码）：
  编码 = 标准 base64 后按 str.maketrans(标准表, 变体表) 逐字符平移；
  解码 = 变体表逆向平移回标准表后 b64decode（'=' 填充符两向均原样保留）。
  两张 doc88 协议常量码表导入即注册（§1.3 用法分工）：
    doc88_key1 → 文档页 m_main JSON 本体 / JSON 内 pageInfo 字段 / index.json 回写；
    doc88_key2 → doc.php?act=info 的 XML 响应 / 一切 .ebt 资产文件名（§1.4 enc2）。
  注册制不绑死 doc88：register(name, alphabet_table) 可挂任意合法 64 字符置换表。

码表失配纪律（本件红线：拒绝静默错解）：decode 遇字符集越界 / 填充位非法 /
expect 明文校验不过，一律抛 TableMismatchError 并携带 DecodeDiagnostic（越界
字符与计数、填充判定、跨表候选探测——同宇宙异排列表如 key1/key2 仅凭字符集
不可辨，expect 是唯一点名法）；诊断报告亦可经 diagnose() 钩子直接取回（不抛错）。
"""
from __future__ import annotations

import base64
from dataclasses import dataclass
from typing import Callable, Mapping, Union

__all__ = [
    "STANDARD_B64", "DOC88_KEY1_NAME", "DOC88_KEY2_NAME", "DOC88_KEY1", "DOC88_KEY2",
    "VariantB64Error", "InvalidAlphabetError", "RegistrationConflictError",
    "NotRegisteredError", "TableMismatchError", "CodecEntry", "DecodeDiagnostic",
    "register", "registered", "get", "encode", "decode", "diagnose",
]

STANDARD_B64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

# doc88 协议常量（DOC88_SPEC §1.3 原文；两表字符集相同、排列不同）
DOC88_KEY1_NAME = "doc88_key1"
DOC88_KEY2_NAME = "doc88_key2"
DOC88_KEY1 = "PJLKMNOI3xyz021wvrpqstouHCFBDEGAnhikjlmgfZbacedYRXTSUVQW!56789+4"
DOC88_KEY2 = "PJKLMNOI3xyz012wvprqstuoHBCDEFGAnhijklmgfZabcdeYXRSTUVWQ!56789+4"

_PADDING = "="  # 填充符保留，任何变体码表不得占用


class VariantB64Error(Exception):
    """变体 base64 编解码基础异常。"""


class InvalidAlphabetError(VariantB64Error):
    """码表不合法：长度≠64 / 字符重复 / 含保留填充符 '=' / 含空白或非 ASCII / 表名非法。"""


class RegistrationConflictError(VariantB64Error):
    """同名注册但码表不同（覆盖须显式 replace=True）。"""


class NotRegisteredError(VariantB64Error):
    """查无此表名。"""


@dataclass(frozen=True)
class CodecEntry:
    """一张已注册码表：64 字符置换表 + 编/解两张 maketrans 平移表。"""

    name: str
    alphabet: str
    enc_table: Mapping[int, int]  # str.maketrans(标准表, 变体表)
    dec_table: Mapping[int, int]  # str.maketrans(变体表, 标准表)


@dataclass(frozen=True)
class DecodeDiagnostic:
    """码表失配诊断报告（diagnose() 返回值 / TableMismatchError.diagnostic 携带）。"""

    ok: bool                  # 该输入在所指表下可安全解码（无越界+填充合法+expect 过）
    table: str                # 诊断所用表名（未点名时为 "<any>"）
    foreign_chars: str        # 越界字符（去重排序；'=' 不计，另走填充判定）
    foreign_count: int        # 越界字符出现总次数（实测计数，非估算）
    padding_valid: bool       # 长度为 4 倍数且 '=' 仅尾部至多 2 个
    expect_rejected: bool     # 明文 expect 校验未过（同宇宙错表典型症状）
    candidate_tables: tuple   # 跨表候选（其他表完全覆盖字符集；给 expect 时须解出满足）
    message: str              # 人读告警语（含处置建议）


class TableMismatchError(VariantB64Error):
    """码表失配（字符集越界/填充非法/expect 拒收）——携带诊断，拒绝静默错解。"""

    def __init__(self, diagnostic: DecodeDiagnostic):
        super().__init__(diagnostic.message)
        self.diagnostic = diagnostic


_REGISTRY: dict[str, CodecEntry] = {}


def _validate_alphabet(name: object, alphabet: object) -> str:
    """注册前码表合法性门（逐项点名实况，不笼统报错）。"""
    if not isinstance(name, str) or not name:
        raise InvalidAlphabetError(f"表名须为非空 str，实得 {name!r}")
    if not isinstance(alphabet, str):
        raise InvalidAlphabetError(f"码表须为 64 字符 str，实得 {type(alphabet).__name__}")
    if len(alphabet) != 64:
        raise InvalidAlphabetError(f"码表长度须为 64，实得 {len(alphabet)}")
    dup = sorted({c for c in alphabet if alphabet.count(c) > 1})
    if dup:
        raise InvalidAlphabetError(f"码表字符重复：{''.join(dup)}")
    bad = sorted({c for c in alphabet if not 33 <= ord(c) <= 126})
    if bad:
        raise InvalidAlphabetError(f"码表含空白/控制/非 ASCII 字符：{bad!r}")
    if _PADDING in alphabet:
        raise InvalidAlphabetError(f"码表不得包含保留填充符 {_PADDING!r}")
    return alphabet


def register(name: str, alphabet: str, *, replace: bool = False) -> CodecEntry:
    """注册一张变体码表（同名同表幂等；同名异表须 replace=True 覆盖）。"""
    alphabet = _validate_alphabet(name, alphabet)
    old = _REGISTRY.get(name)
    if old is not None:
        if old.alphabet == alphabet:
            return old
        if not replace:
            raise RegistrationConflictError(
                f"表名 {name!r} 已注册且码表不同；确需覆盖请传 replace=True")
    entry = CodecEntry(name=name, alphabet=alphabet,
                       enc_table=str.maketrans(STANDARD_B64, alphabet),
                       dec_table=str.maketrans(alphabet, STANDARD_B64))
    _REGISTRY[name] = entry
    return entry


def registered() -> tuple[str, ...]:
    """当前已注册表名快照（排序元组）。"""
    return tuple(sorted(_REGISTRY))


def get(name: str) -> CodecEntry:
    """按名取表；查无此表抛 NotRegisteredError（附现存表清单）。"""
    try:
        return _REGISTRY[name]
    except KeyError:
        raise NotRegisteredError(f"查无码表 {name!r}；已注册：{registered()}") from None


def encode(name: str, data: Union[bytes, bytearray, memoryview, str]) -> str:
    """变体编码：bytes/str → 标准 base64 → 平移至变体表（'=' 填充原样保留）。"""
    entry = get(name)
    if isinstance(data, str):
        data = data.encode("utf-8")
    elif isinstance(data, (bytes, bytearray, memoryview)):
        data = bytes(data)
    else:
        raise VariantB64Error(f"encode 入参须为 bytes/str，实得 {type(data).__name__}")
    return base64.b64encode(data).decode("ascii").translate(entry.enc_table)


def decode(name: str, text: Union[str, bytes, bytearray],
           expect: Callable[[bytes], bool] | None = None) -> bytes:
    """变体解码：先过失配诊断门（越界/填充/expect），失配必抛 TableMismatchError。"""
    entry = get(name)
    text = _as_text(text)
    diagnostic = diagnose(text, expect=expect, name=name)
    if not diagnostic.ok:
        raise TableMismatchError(diagnostic)
    return _trial_decode(entry, text)


def diagnose(text: Union[str, bytes], *,
             expect: Callable[[bytes], bool] | None = None,
             name: str | None = None) -> DecodeDiagnostic:
    """码表失配诊断钩子：只产报告不抛错、不返回乱码明文。

    - name 指定：按该表评字符集/填充；expect 给出时附跨表试解点名候选。
    - name 省缺：对全部已注册表评字符集覆盖（报出可覆盖候选全集）。
    """
    text = _as_text(text)
    primary = get(name) if name is not None else None
    allowed = {c for e in _REGISTRY.values() for c in e.alphabet}
    if primary is not None:
        foreign = sorted(set(text) - set(primary.alphabet) - {_PADDING})
    else:
        foreign = sorted(set(text) - allowed - {_PADDING})
    foreign_chars = "".join(foreign)
    foreign_count = sum(text.count(c) for c in foreign)
    padding_valid = _padding_valid(text)

    candidates = []
    for other in _REGISTRY.values():
        if other is primary:
            continue
        if set(text) - set(other.alphabet) - {_PADDING}:
            continue
        if not padding_valid:
            continue  # 填充与表无关：坏了任何表都别列候选
        if expect is None:
            candidates.append(other.name)
        else:
            try:
                if expect(_trial_decode(other, text)):
                    candidates.append(other.name)
            except VariantB64Error:
                pass
    candidates.sort()

    expect_rejected = False
    if primary is not None and expect is not None and not foreign and padding_valid:
        expect_rejected = not expect(_trial_decode(primary, text))

    table_label = name if name is not None else "<any>"
    parts = []
    if foreign:
        parts.append(f"表 {table_label} 外字符 {foreign_chars!r}×{foreign_count}（字符集越界，拒解）")
    if not padding_valid:
        parts.append(f"填充位非法（长度 {len(text)} 非 4 倍数或 '=' 越出尾部），拒解")
    if expect_rejected:
        parts.append(f"expect 明文校验未过（表 {table_label} 解出疑似乱码，拒解）")
    if candidates:
        if expect is not None:
            named = "、".join(f"{c}（满足 expect）" for c in candidates)
            parts.append(f"跨表试解点名：{named}——输入疑似应改用该表")
        else:
            parts.append(f"字符集可被这些表全覆盖：{'、'.join(candidates)}"
                         "（同宇宙异排列表仅凭字符集不可辨，decode 时传 expect 点名）")
    ok = (not foreign) and padding_valid and not expect_rejected
    if not parts:
        parts.append("字符集与填充均合法" + ("，expect 已通过" if expect is not None else "，可解"))
    message = f"[variant_b64 失配诊断 table={table_label}] " + "；".join(parts)
    return DecodeDiagnostic(ok=ok, table=table_label, foreign_chars=foreign_chars,
                            foreign_count=foreign_count, padding_valid=padding_valid,
                            expect_rejected=expect_rejected,
                            candidate_tables=tuple(candidates), message=message)


def _padding_valid(text: str) -> bool:
    """base64 填充规则：长度 4 倍数；'=' 仅尾部且至多 2 个。"""
    if len(text) % 4:
        return False
    stripped = text.rstrip(_PADDING)
    if _PADDING in stripped:
        return False
    return len(text) - len(stripped) <= 2


def _trial_decode(entry: CodecEntry, text: str) -> bytes:
    """单表试解（诊断门已保证字符集/填充合法；异常统翻 VariantB64Error 供上层吞判）。"""
    mapped = text.translate(entry.dec_table)
    try:
        return base64.b64decode(mapped, validate=True)
    except Exception as exc:
        raise VariantB64Error(f"表 {entry.name} 解码层异常（输入非法）：{exc}") from exc


def _as_text(text: Union[str, bytes, bytearray]) -> str:
    """密文入参归一为 str（bytes 须为纯 ASCII）。"""
    if isinstance(text, str):
        return text
    if isinstance(text, (bytes, bytearray)):
        try:
            return bytes(text).decode("ascii")
        except UnicodeDecodeError as exc:
            raise VariantB64Error("密文须为 ASCII 变体 base64 文本（bytes 含非 ASCII 字节）") from exc
    raise VariantB64Error(f"密文须为 str/bytes，实得 {type(text).__name__}")


# 导入即注册 doc88 两表（DOC88_SPEC §1.3 协议常量）
register(DOC88_KEY1_NAME, DOC88_KEY1)
register(DOC88_KEY2_NAME, DOC88_KEY2)
