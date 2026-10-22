# -*- coding: utf-8 -*-
"""魔数识别件单测（FR2.2 / FR3.1 / FR4.1；风险 R16 / R17）。

- 样本=struct/bytes 手造（真魔数前缀+合成体），零网络零 mock；唯一真实样本=
  engine/SPECS/_repos/doc88/_probe/page1_synthesized.swf（探针实测合成件，在档只读）。
- 任务卡五项断言口径：①GIF89a 伪装 .png ②占位图丢弃（宽高>0.8×页 且 <2048B）
  ③PNG 魔数+IHDR 宽高（readUInt32BE 0x10/0x14）④zlib 0x789c+Adler-32 试解压切页
  ⑤SWF FWS/CWS/ZWS 魔数。
- R16 总则：扩展名与 Content-Type 一律不可信——被测 API 只收字节，不收文件名。
"""
import struct
import sys
import zlib
from pathlib import Path

import pytest

_KB_DIR = Path(__file__).resolve().parents[2]  # kb_factory/
sys.path.insert(0, str(_KB_DIR))  # worktree 阶段 kb_factory 无 __init__.py：顶层导入回退
_REPO_ROOT = _KB_DIR.parent
for _anc in _KB_DIR.parents:  # 主树/worktree 双兼容：找到含 kb_factory 真身的根
    if (_anc / "kb_factory" / "channel_adapters" / "base.py").exists():
        _REPO_ROOT = _anc
        sys.path.insert(1, str(_anc))
        break

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名
    from kb_factory.harvest_engine.assets.magic_check import (  # noqa: E402
        EBT_PH_MAGIC, PAGE_PNG_MIN_BYTE_LENGTH, PLACEHOLDER_BYTE_LIMIT, PNG_MAGIC,
        REASON_NO_IHDR, REASON_NOT_PNG, REASON_OK, REASON_PLACEHOLDER,
        REASON_UNDER_MIN, ZLIB_HEADER, check_swf, find_zlib_streams, judge_page_png,
        png_ihdr_size, sniff_format, try_decompress_zlib)
except ImportError:
    from harvest_engine.assets.magic_check import (  # noqa: E402
        EBT_PH_MAGIC, PAGE_PNG_MIN_BYTE_LENGTH, PLACEHOLDER_BYTE_LIMIT, PNG_MAGIC,
        REASON_NO_IHDR, REASON_NOT_PNG, REASON_OK, REASON_PLACEHOLDER,
        REASON_UNDER_MIN, ZLIB_HEADER, check_swf, find_zlib_streams, judge_page_png,
        png_ihdr_size, sniff_format, try_decompress_zlib)

# 真实合成件（DOC88_SPEC §1.6 实测：FWS v9 / 495770B / 长度自洽）——只读引用
_REAL_SWF = (_REPO_ROOT / "07 任务" / "自动建库Agent" / "engine" / "SPECS"
             / "_repos" / "doc88" / "_probe" / "page1_synthesized.swf")


def _make_gif(sig: bytes = b"GIF89a", w: int = 792, h: int = 1120,
              min_len: int = 0) -> bytes:
    """合成 GIF：签名 + 逻辑屏幕描述符（宽高 LE u16）+ 结束符；可零填充调字节数。

    默认 792×1120 = BOOK118_SPEC §3 实测样例分辨率（.png 伪装实锤形态）。
    """
    data = sig + struct.pack("<HHBBB", w, h, 0x70, 0x00, 0x00) + b"\x3B"
    return data.ljust(min_len, b"\x00") if min_len > len(data) else data


def _make_png(width: int, height: int, min_len: int = 0) -> bytes:
    """合成 PNG：签名 + IHDR（宽高 BE u32）+ IEND；尾部零填充只影响字节数门。"""
    ihdr_body = struct.pack(">II", width, height) + bytes((8, 6, 0, 0, 0))
    ihdr = (struct.pack(">I", len(ihdr_body)) + b"IHDR" + ihdr_body
            + struct.pack(">I", zlib.crc32(b"IHDR" + ihdr_body)))
    iend = struct.pack(">I", 0) + b"IEND" + struct.pack(">I", zlib.crc32(b"IEND"))
    data = PNG_MAGIC + ihdr + iend
    return data.ljust(min_len, b"\x00") if min_len > len(data) else data


def _make_swf(sig: bytes, version: int = 9, total: int = 64,
              declared: int | None = None) -> bytes:
    """合成 SWF 头：签名 + 版本 + LE u32 声明长度 + 填充体（§1.6 补丁位可错位）。"""
    body = b"\x00" * max(total - 8, 0)
    return sig + bytes((version,)) + struct.pack(
        "<I", total if declared is None else declared) + body


def test_r16_fr3_1_gif89a_disguised_as_png_extension_untrusted():
    """R16/FR3.1：book118 实锤——URL .png + Content-Type image/png，真身 GIF89a。"""
    gif = _make_gif()  # 792×1120，§3 实测分辨率
    assert gif.startswith(b"GIF89a")
    assert sniff_format(gif) == "gif"                 # 只认字节：.png 外衣救不了它
    assert sniff_format(_make_gif(b"GIF87a")) == "gif"
    assert sniff_format(_make_png(10, 10)) == "png"   # 真 PNG 按魔数正名（.gif 外衣同理无效）
    assert sniff_format(b"<!DOCTYPE html><html>403 WAF</html>") is None  # 错误页无魔数
    assert sniff_format(b"") is None


def test_fr2_2_wenku_png_magic_and_ihdr_size_at_0x10_0x14():
    """FR3.1③/FR2.2：PNG 魔数 + IHDR 宽高（readUInt32BE(0x10)/(0x14) 等价偏移契约）。"""
    png = _make_png(894, 1263)
    assert png.startswith(PNG_MAGIC)
    assert png_ihdr_size(png) == (894, 1263)
    # 偏移契约直证：整文件相对偏移 0x10=宽、0x14=高（大端 u32）
    assert int.from_bytes(png[0x10:0x14], "big") == 894
    assert int.from_bytes(png[0x14:0x18], "big") == 1263
    assert png_ihdr_size(png[:23]) is None                       # 截断（高字段不全）
    assert png_ihdr_size(b"GIF89a" + b"\x00" * 40) is None       # 非 PNG
    liar = PNG_MAGIC + struct.pack(">I", 13) + b"IDAT" + b"\x00" * 17
    assert png_ihdr_size(liar) is None                           # 签名对但首块非 IHDR


def test_r17_fr2_2_placeholder_watermark_rule():
    """R17/FR2.2④：占位图=宽>0.8×页W 且 高>0.8×页H 且 字节<2048，三条件缺一即免。

    样本一律先过第①步（>200B，规格链序前置门）再进占位判定，故 min_len=201。"""
    page = (1000, 1400)
    # 主案：全幅 + 小字节（201B<2048）→ 水印占位丢弃
    v = judge_page_png(_make_png(1000, 1400, min_len=201), *page)
    assert v.keep is False and v.reason == REASON_PLACEHOLDER
    assert (v.width, v.height, v.fmt) == (1000, 1400, "png")
    # 刚过 0.8 线（严格大于）：801×1121 仍判占位
    assert judge_page_png(_make_png(801, 1121, min_len=201), *page).reason == REASON_PLACEHOLDER
    # 恰=0.8×页（800×1120）：>0.8 不成立 → 不判占位
    assert judge_page_png(_make_png(800, 1120, min_len=201), *page).reason == REASON_OK
    # 字节恰 2048：<2048 不成立 → 不判占位
    v2 = judge_page_png(_make_png(1000, 1400, min_len=PLACEHOLDER_BYTE_LIMIT), *page)
    assert v2.reason == REASON_OK and v2.byte_len == 2048
    # 小图（尺寸门不过）：即使 <2048 字节也保留
    assert judge_page_png(_make_png(400, 300, min_len=201), *page).keep is True


def test_fr2_2_wenku_page_png_chain_gate_order():
    """FR2.2：§6.6 链序 ①byteLength>200 → ②魔数 → ③IHDR → ④占位（逐门现形）。"""
    small = _make_png(1000, 1400, min_len=PAGE_PNG_MIN_BYTE_LENGTH)  # 恰 200B
    v = judge_page_png(small, 1000, 1400)
    assert v.keep is False and v.reason == REASON_UNDER_MIN and v.byte_len == 200
    assert judge_page_png(_make_png(10, 10, min_len=201), 1000, 1400).keep is True
    fake = _make_gif(min_len=300)  # >200B 的 GIF 伪装（R16 形态）→ 第②步拦、真身如实标
    v2 = judge_page_png(fake, 1000, 1400)
    assert v2.keep is False and v2.reason == REASON_NOT_PNG and v2.fmt == "gif"
    no_ihdr = PNG_MAGIC + struct.pack(">I", 13) + b"IDAT" + b"\x00" * 200  # 216B>200，过①撞③
    v3 = judge_page_png(no_ihdr, 1000, 1400)
    assert v3.keep is False and v3.reason == REASON_NO_IHDR and v3.fmt == "png"


def test_fr4_1_doc88_zlib_789c_scan_with_adler32_trial_decompress():
    """FR4.1④：连续大块扫 0x789c + 试解压（Adler-32 天然校验）= 隐藏页切页边界。"""
    p1 = b"FWS\x09" + b"\x40\x00\x00\x00" + b"DefineShape" * 20   # 拟 PH 解出的 SWF 头段
    p2 = b"DefineFont/DefineText tail " * 8                        # 拟 PK 页体 tags
    comp1, comp2 = zlib.compress(p1), zlib.compress(p2)
    assert comp1[:2] == ZLIB_HEADER  # 前置自证：默认压缩级即 78 9c（规格钉死头）
    head, mid, tail = b"\x00\xde\xad\xbe\xef" * 4, b"\x00" * 5, b"\xee" * 6
    blob = head + comp1 + mid + comp2 + tail                       # 78 9c 只在两流头
    spans = find_zlib_streams(blob)
    assert [(s.start, s.end) for s in spans] == [
        (len(head), len(head) + len(comp1)),
        (len(head) + len(comp1) + len(mid), len(head) + len(comp1) + len(mid) + len(comp2))]
    assert [s.decompressed for s in spans] == [p1, p2]
    # 坏 Adler-32：试解压即拒（不产生切页边界）
    bad = bytearray(comp1)
    bad[-1] ^= 0xFF
    assert find_zlib_streams(bytes(bad)) == []
    assert try_decompress_zlib(bytes(bad)) is None
    # 截断流：eof 不达即拒
    half = comp1[: len(comp1) // 2]
    assert find_zlib_streams(half) == [] and try_decompress_zlib(half) is None
    # try_decompress：成流即出（尾随字节容忍），非 78 9c 头（如 78da 级9）规格外不认
    assert try_decompress_zlib(comp1 + b"trailing") == p1
    assert try_decompress_zlib(zlib.compress(p1, 9)) is None
    assert try_decompress_zlib(b"plain text") is None


def test_fr4_1_doc88_swf_magic_fws_cws_zws_and_declared_length():
    """FR4.1⑤：SWF 三签名 FWS/CWS/ZWS + 版本 + LE u32 声明长度核验（§1.6 补丁位）。"""
    for sig in (b"FWS", b"CWS", b"ZWS"):
        blob = _make_swf(sig, version=9, total=64)
        assert sniff_format(blob) == "swf"
        info = check_swf(blob)
        assert (info.signature, info.version, info.declared_len, info.length_ok) == (
            sig.decode(), 9, 64, True)
    unpatched = _make_swf(b"FWS", total=64, declared=999)  # 长度补丁缺失/错位
    assert check_swf(unpatched).length_ok is False and check_swf(unpatched).declared_len == 999
    assert check_swf(b"NOTSWF!" + b"\x00" * 8) is None
    assert check_swf(b"FW") is None                       # 截断
    # EBT 判形（§2 魔数表）：PH=YBD\x01 实锤；PK 无固定魔数、[32:] 起为 zlib 流
    assert sniff_format(EBT_PH_MAGIC + b"\x00" * 60) == "ebt_ph"
    pk = b"\x5a\xa7\x11\x09" * 8 + zlib.compress(b"DefineText tags")
    assert sniff_format(pk) is None and sniff_format(pk[32:]) == "zlib"


def test_fr4_1_doc88_real_synthesized_swf_artifact():
    """FR4.1 真实合成件（探针在档）：FWS v9、声明长度==实际==495770B（§1.6 实测）。"""
    data = _REAL_SWF.read_bytes()
    assert sniff_format(data) == "swf"
    info = check_swf(data)
    assert (info.signature, info.version) == ("FWS", 9)
    assert info.declared_len == len(data) == 495770 and info.length_ok is True
