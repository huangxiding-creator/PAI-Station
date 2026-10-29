# -*- coding: utf-8 -*-
"""资产判件：魔数识别与假资产判定（R16 铁律：扩展名与 Content-Type 一律不可信）。

统一口径（SYNTHESIS §2-8）：全站落盘/内嵌资产一律按字节魔数识别，本件不接收
文件名/Content-Type 佐证。三个实锤来源：
- BOOK118_SPEC §3（FR3.1）：预览图 URL 以 .png 结尾、Content-Type 亦标 image/png，
  真身却为 GIF89a 792×1120（2026-10-22 实测样例）。
- WENKU_SPEC §6.6（FR2.2 / R17）：类型3 PNG 底图四步校验链——①byteLength>200
  ②PNG 魔数 ③IHDR 宽高（readUInt32BE 等价=BE u32 @0x10/0x14）④占位图丢弃
  （宽>0.8×页W 且 高>0.8×页H 且 字节<2048 = 水印占位）。
- DOC88_SPEC §1.5/§2（FR4.1）：隐藏页扫描=连续大块内扫 zlib 头 0x789c + 试解压
  （尾部 Adler-32 天然校验）切页；PH 层头魔数 YBD\\x01（PK 无固定魔数、[32:] 为
  zlib 流）；合成产物为 SWF（FWS/CWS/ZWS 三签名，偏移4 LE u32 声明长度，§1.6
  合成后须与实际字节一致）。

纯函数件：零网络、零第三方依赖、不做落盘决策——只出「这是什么/留不留」的事实
结论，供适配器 verify 段与 paged_fetcher 复用。
"""
import zlib
from dataclasses import dataclass

__all__ = [
    "GIF_MAGICS", "PNG_MAGIC", "SWF_SIGNATURES", "EBT_PH_MAGIC", "ZLIB_HEADER",
    "PAGE_PNG_MIN_BYTE_LENGTH", "PLACEHOLDER_BYTE_LIMIT", "PLACEHOLDER_SIZE_RATIO",
    "REASON_OK", "REASON_UNDER_MIN", "REASON_NOT_PNG", "REASON_NO_IHDR",
    "REASON_PLACEHOLDER",
    "PagePngVerdict", "SwfInfo", "ZlibSpan",
    "sniff_format", "png_ihdr_size", "judge_page_png",
    "try_decompress_zlib", "find_zlib_streams", "check_swf",
]

GIF_MAGICS = (b"GIF87a", b"GIF89a")        # book118 实锤=89a；87a 同科一并识别
PNG_MAGIC = b"\x89PNG\r\n\x1a\n"           # WENKU_SPEC §6.6 第②步 89 50 4E 47
SWF_SIGNATURES = (b"FWS", b"CWS", b"ZWS")  # SWF 三形态：未压缩 / zlib / lzma
EBT_PH_MAGIC = b"YBD\x01"                  # DOC88_SPEC §2 PH 层头魔数（hexdump 实锤）
ZLIB_HEADER = b"\x78\x9c"                  # DOC88_SPEC §2 规格钉死的 zlib 头（默认压缩级）

PAGE_PNG_MIN_BYTE_LENGTH = 200   # §6.6 第①步：byteLength 须 > 200
PLACEHOLDER_SIZE_RATIO = 0.8     # §6.6 第④步：宽、高均须 > 0.8×页宽高
PLACEHOLDER_BYTE_LIMIT = 2048    # §6.6 第④步：字节数须 < 2048 才判水印占位

REASON_OK = "ok"                              # 四步全过，可用
REASON_UNDER_MIN = "under_200_bytes"          # 第①步拦：字节 ≤200
REASON_NOT_PNG = "not_png_magic"              # 第②步拦：魔数非 PNG（GIF 伪装也在此现形）
REASON_NO_IHDR = "ihdr_missing"               # 第③步拦：签名对但首块非 IHDR / 截断
REASON_PLACEHOLDER = "placeholder_watermark"  # 第④步拦：全幅小字节水印占位（R17）


@dataclass(frozen=True)
class PagePngVerdict:
    """judge_page_png 判决：keep=留用与否；fmt=魔数真身（GIF 伪装如实标 gif）。"""

    keep: bool
    reason: str          # REASON_* 之一
    fmt: str | None      # sniff_format 结论（判决时刻的真身格式）
    width: int | None    # IHDR 宽（拿不到=None）
    height: int | None   # IHDR 高（拿不到=None）
    byte_len: int        # 实测字节数（数字零造假）


@dataclass(frozen=True)
class ZlibSpan:
    """连续大块中切出的一条完整 zlib 流（doc88 隐藏页扫描边界产物）。"""

    start: int           # 0x789c 头在块内的起始偏移
    end: int             # Adler-32 校验通过处（流实际消费末尾，含校验和）
    decompressed: bytes  # 试解压产物（SWF 页体 tags 等）


@dataclass(frozen=True)
class SwfInfo:
    """SWF 头事实：三签名之一 + 版本 + 声明长度（§1.6 长度补丁核验位）。"""

    signature: str       # "FWS" | "CWS" | "ZWS"
    version: int         # 头部第4字节（探针合成件=v9）
    declared_len: int    # 偏移4 LE u32：合成器补丁位，须==实际字节数
    length_ok: bool      # declared_len == len(data)


def sniff_format(data: bytes) -> str | None:
    """按魔数识别真实格式（R16：只看字节，不看文件名/Content-Type）。

    返回统一格式名 gif/png/swf/ebt_ph/zlib；未知返回 None（有意不做兜底猜测）。
    zlib 只认规格钉死的 0x789c 头（doc88 资产实测全为默认压缩级；78da 等他级
    头属于规格外，不认以免隐藏页扫描误切）。
    """
    if data.startswith(GIF_MAGICS):
        return "gif"
    if data.startswith(PNG_MAGIC):
        return "png"
    if data[:3] in SWF_SIGNATURES:
        return "swf"
    if data.startswith(EBT_PH_MAGIC):
        return "ebt_ph"
    if data.startswith(ZLIB_HEADER):
        return "zlib"
    return None


def png_ihdr_size(data: bytes) -> tuple[int, int] | None:
    """PNG IHDR 宽高（WENKU_SPEC §6.6 第③步）：BE u32 @0x10=宽、@0x14=高。

    readUInt32BE(0x10)/readUInt32BE(0x14) 的 Python 等价=big-endian int.from_bytes；
    非 PNG / 截断(<24B) / 首块非 IHDR → None。不做 CRC 核验（占位判定只吃尺寸，
    与原作口径一致）。
    """
    if len(data) < 24 or not data.startswith(PNG_MAGIC):
        return None
    if data[12:16] != b"IHDR":
        return None
    width = int.from_bytes(data[16:20], "big")   # 0x10
    height = int.from_bytes(data[20:24], "big")  # 0x14
    return width, height


def judge_page_png(data: bytes, page_w: int, page_h: int) -> PagePngVerdict:
    """WENKU_SPEC §6.6 类型3 PNG 底图四步校验链（单入口判决：留/弃+原因）。

    链序=规格原序：①byteLength>200 → ②PNG 魔数 → ③IHDR 宽高 → ④占位图丢弃
    （宽>page_w*0.8 且 高>page_h*0.8 且 字节<2048 = 水印占位，R17）。keep=True
    仅在第④步幸存；fmt 字段始终报魔数真身（GIF 伪装进来也如实标 gif）。
    """
    fmt = sniff_format(data)
    if len(data) <= PAGE_PNG_MIN_BYTE_LENGTH:
        return PagePngVerdict(False, REASON_UNDER_MIN, fmt, None, None, len(data))
    if fmt != "png":
        return PagePngVerdict(False, REASON_NOT_PNG, fmt, None, None, len(data))
    size = png_ihdr_size(data)
    if size is None:
        return PagePngVerdict(False, REASON_NO_IHDR, fmt, None, None, len(data))
    width, height = size
    if (width > page_w * PLACEHOLDER_SIZE_RATIO
            and height > page_h * PLACEHOLDER_SIZE_RATIO
            and len(data) < PLACEHOLDER_BYTE_LIMIT):
        return PagePngVerdict(False, REASON_PLACEHOLDER, fmt, width, height, len(data))
    return PagePngVerdict(True, REASON_OK, fmt, width, height, len(data))


def try_decompress_zlib(data: bytes) -> bytes | None:
    """zlib 试解压（DOC88_SPEC §2）：须 0x789c 起头且流完整（Adler-32 天然校验）。

    尾随多余字节容忍（只解到流末，EBT PK 切片可能带尾）；头不对 / 流截断 /
    校验和坏 → None。供 PH[40:]/PK[32:] 解压与切页产物核验复用。
    """
    if not data.startswith(ZLIB_HEADER):
        return None
    dec = zlib.decompressobj()
    try:
        out = dec.decompress(data)
    except zlib.error:
        return None  # 坏 Adler-32 / 坏 deflate：试解压不成立
    return out if dec.eof else None  # eof=False 即流不完整（截断）


def find_zlib_streams(data: bytes) -> list[ZlibSpan]:
    """连续大块内扫 zlib 流（DOC88_SPEC §1.5 隐藏页边界判定法）。

    每个候选 0x789c 处试解压：Adler-32 过且流完整才收录（截断流/坏校验和一律
    跳过）；成流后从流尾续扫（流内偶现 78 9c 字节不误切）。输入为有界块
    （规格口径 1,024,000B/块），无越界防护需求。
    """
    spans: list[ZlibSpan] = []
    start = data.find(ZLIB_HEADER)
    while start != -1:
        dec = zlib.decompressobj()
        try:
            out = dec.decompress(data[start:])
            ok = dec.eof
        except zlib.error:
            out, ok = b"", False
        if ok:
            consumed = len(data) - start - len(dec.unused_data)
            spans.append(ZlibSpan(start, start + consumed, out))
            resume = start + consumed  # 成流：从流尾续扫
        else:
            resume = start + 1         # 未成流：下一字节继续扫
        start = data.find(ZLIB_HEADER, resume)
    return spans


def check_swf(data: bytes) -> SwfInfo | None:
    """SWF 头核验：FWS/CWS/ZWS 魔数 + 版本 + LE u32 声明长度（§1.6 补丁位）。

    非 SWF / 截断(<8B) → None；length_ok=False 即合成器长度补丁缺失或错位
    （探针实测件=FWS v9、声明==实际 495770B）。
    """
    if len(data) < 8 or data[:3] not in SWF_SIGNATURES:
        return None
    declared = int.from_bytes(data[4:8], "little")
    return SwfInfo(data[:3].decode("ascii"), data[3], declared, declared == len(data))
