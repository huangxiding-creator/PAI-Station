# -*- coding: utf-8 -*-
"""SWF 帧修正 + FFDec/presse 子进程封装（FR4.1：doc88 SWF → PDF 工具链）。

DOC88_SPEC 三段依据：
- §1.6 合成件须 swf_resize 修正后才能喂 FFDec：帧 RECT 宽高改为页表 w-h
  （twip=px*20）、帧数改 1——部分文档帧数为 0，不修则 FFDec **静默零输出**
  （实测 returncode 仍为 0、零产物，坑点入测）。
- §1.7 转换命令原样：`java -jar ffdec.jar -format frame:pdf -zoom {scale}
  -select 1 -export frame {出目录} {swf目录}`；合并 `presse merge … --optimize
  -o 最终.pdf`。CLI 用法以 2026-10-22 ffdec 26.4.0 `-help export` 实测为准
  （frame:pdf 在 formats 列表内）。
- §6-4/§6-5 落地清单：帧 RECT/帧数修正（本件）+ FFDec 分组转换与 presse merge
  （本件封装，分组并行编排归适配器层）。

NFR6 GPL 隔离：FFDec/presse 均 GPL-3.0，本件只以子进程调用（不 import 其码、
不 vendoring 进仓），核对表见 tools/LICENSES.md。

输入约定：doc88 合成件恒为 FWS（未压缩）——§1.6 zlib×2 拼接产物；CWS/ZWS
（站方压缩件）不在本链射程，显式拒绝不猜。纯字节修正零子进程；子进程件
（run_ffdec_frame_pdf/export_frame_pdf/presse_merge）工具定位顺序=显式参数 >
环境变量（KB_HARVEST_JAVA/KB_HARVEST_FFDEC_JAR/KB_HARVEST_PRESSE）>
rea-tools 约定目录（tools/fetch_toolchain.locate_*）。
"""
from __future__ import annotations

import os
import struct
import subprocess
from dataclasses import dataclass, field
from pathlib import Path
from typing import Sequence

from kb_factory.harvest_engine.assets.magic_check import check_swf
from kb_factory.harvest_engine.tools.fetch_toolchain import (
    ToolchainError, default_toolchain_root, locate_ffdec, locate_java, locate_presse)

__all__ = [
    "PIXEL_TO_TWIP", "REASON_FRAME_COUNT_ZERO", "REASON_RECT_MISMATCH",
    "SwfError", "SwfHeader", "parse_swf_header", "swf_needs_fix", "swf_resize",
    "swf_resize_if_needed", "FramePdfRun", "build_ffdec_cmd",
    "run_ffdec_frame_pdf", "export_frame_pdf", "presse_merge",
]

PIXEL_TO_TWIP = 20                    # SWF 规格：1px = 20 twips
REASON_FRAME_COUNT_ZERO = "frame_count_zero"  # §1.6：帧数 0 → FFDec 静默零输出
REASON_RECT_MISMATCH = "rect_mismatch"         # RECT 宽高 != 页表 w-h

_MAX_PAGE_PX = 100_000                # 页几何上限（px）——防页表脏值产巨型 RECT
_TAIL_CHARS = 2000                    # 子进程输出留档尾长（audit/报错用）
_ENSURE_HINT = ("先执行: py -3 -m kb_factory.harvest_engine.tools.fetch_toolchain "
                "--ensure ffdec,presse（或设 KB_HARVEST_JAVA/KB_HARVEST_FFDEC_JAR/"
                "KB_HARVEST_PRESSE 指向在位件）")


class SwfError(ValueError):
    """SWF 头解析/修正失败（非 SWF、头截断、压缩件、非法几何等）。"""


@dataclass(frozen=True)
class SwfHeader:
    """SWF 头事实（只读，供检测与修正复用；字段全部实测，无声明值）。"""

    signature: str        # "FWS"（本链唯一合法形态；CWS/ZWS 见 parse 拒绝）
    version: int          # 头部第 4 字节（探针合成件=v9）
    declared_len: int     # 偏移 4 LE u32：修正件须==实际字节数（长度补丁位）
    length_ok: bool
    xmin: int             # 以下四值均为 twips
    xmax: int
    ymin: int
    ymax: int
    width_px: int         # (xmax-xmin)//20：页表核对位（§1.6 w-h）
    height_px: int
    frame_rate_raw: int   # 帧率原始 LE u16（不解释不改写，修正时原样保留）
    frame_count: int      # §1.6 检测主位：0=FFDec 静默零输出
    body_offset: int      # 帧率+帧数之后首字节偏移（=8+RECT字节数+4）


def _unpack_rect(data: bytes) -> tuple[int, int, int, int, int]:
    """解出 (nbits, xmin, xmax, ymin, ymax)（twips，带符号）。

    RECT 布局：5bit nbits + 4×nbits 有符号位域（MSB 对齐，尾部 pad 到字节）。
    头截断（RECT/帧率/帧数装不下）抛 SwfError。
    """
    if len(data) < 8 + 1 + 4:  # 帧率2B+帧数2B 至少还得有一字节 RECT
        raise SwfError(f"SWF 头截断（{len(data)}B）：RECT/帧率/帧数装不下")
    nbits = data[8] >> 3
    if nbits == 0:
        raise SwfError("RECT nbits=0 非法（无有效位域）")
    total_bits = 5 + 4 * nbits
    rect_bytes = (total_bits + 7) // 8
    if len(data) < 8 + rect_bytes + 4:
        raise SwfError(f"SWF 头截断（{len(data)}B）：RECT 需 {rect_bytes}B+帧率帧数 4B")
    v = int.from_bytes(data[8:8 + rect_bytes], "big")
    lsb_pad = rect_bytes * 8 - total_bits
    mask = (1 << nbits) - 1
    vals = []
    for i in range(4):  # 布局(MSB→LSB)：nbits5 + f0..f3 + pad；f_i 右移 = pad + (3-i)*nbits
        raw = (v >> (lsb_pad + (3 - i) * nbits)) & mask
        if raw & (1 << (nbits - 1)):  # 符号位回补
            raw -= 1 << nbits
        vals.append(raw)
    return nbits, vals[0], vals[1], vals[2], vals[3]


def _pack_rect(xmin: int, xmax: int, ymin: int, ymax: int) -> bytes:
    """RECT 序列化：nbits=四值有符号安全位宽（≥1），位域 MSB 左对齐、尾部补零。"""
    nbits = max((v.bit_length() + 1 for v in (xmin, xmax, ymin, ymax)), default=2)
    nbits = max(nbits, 1)
    acc = nbits       # 自 MSB 起压栈：先 5bit nbits，再 4×nbits 位域（左对齐）
    used = 5
    for val in (xmin, xmax, ymin, ymax):
        acc = (acc << nbits) | (val & ((1 << nbits) - 1))
        used += nbits
    byte_len = (used + 7) // 8
    acc <<= byte_len * 8 - used  # 尾部补零到位边界（SWF 规格：pad 在 LSB 端）
    return acc.to_bytes(byte_len, "big")


def parse_swf_header(data: bytes) -> SwfHeader:
    """读 SWF 头事实（FWS 专用；CWS/ZWS=压缩件，本链显式拒绝不猜）。"""
    info = check_swf(data)  # 兄弟件复用：三签名+版本+声明长度口径
    if info is None:
        raise SwfError("非 SWF（FWS/CWS/ZWS 魔数皆无）——R16：只认字节")
    if info.signature != "FWS":
        raise SwfError(f"压缩 SWF（{info.signature}）不在本链射程：doc88 合成件恒为 "
                       "FWS（§1.6 zlib×2 拼接产物）；如需处理请先解压为 FWS")
    nbits, xmin, xmax, ymin, ymax = _unpack_rect(data)
    rect_bytes = (5 + 4 * nbits + 7) // 8
    off = 8 + rect_bytes
    frame_rate_raw = int.from_bytes(data[off:off + 2], "little")
    frame_count = int.from_bytes(data[off + 2:off + 4], "little")
    width = (xmax - xmin) // PIXEL_TO_TWIP
    height = (ymax - ymin) // PIXEL_TO_TWIP
    return SwfHeader(info.signature, info.version, info.declared_len, info.length_ok,
                     xmin, xmax, ymin, ymax, width, height,
                     frame_rate_raw, frame_count, off + 4)


def swf_needs_fix(data: bytes, page_w: int | None = None,
                  page_h: int | None = None) -> list[str]:
    """检测 §1.6 两缺陷：帧数 0 / RECT 与页表 w-h 不符（返回原因清单，空=无需修）。"""
    h = parse_swf_header(data)
    reasons = []
    if h.frame_count == 0:
        reasons.append(REASON_FRAME_COUNT_ZERO)
    if page_w is not None and page_h is not None and (h.width_px != page_w
                                                      or h.height_px != page_h):
        reasons.append(REASON_RECT_MISMATCH)
    return reasons


def swf_resize(data: bytes, width_px: int, height_px: int, frame_count: int = 1) -> bytes:
    """§1.6 swf_resize 修正：RECT 宽高→页表 w-h（twip=px*20）、帧数→frame_count、
    长度补丁 [4:8] 随头重算；帧率原样保留、tags 体（body_offset 之后）零触碰。

    只重写头（签名/版本/长度/RECT/帧率/帧数），不改任何 tag。位宽变化时
    帧率/帧数/tags 整体平移——probes 实测：495770B 件改 4000×5000px 后
    495771B、帧数落位 [20:22]。
    """
    h = parse_swf_header(data)  # 坏输入在此显式拒（含压缩件/截断）
    if not (1 <= int(width_px) <= _MAX_PAGE_PX and 1 <= int(height_px) <= _MAX_PAGE_PX):
        raise ValueError(f"非法页几何 {width_px}x{height_px}（1..{_MAX_PAGE_PX}px）")
    if not (0 <= int(frame_count) <= 0xFFFF):
        raise ValueError(f"非法帧数 {frame_count}（0..65535）")
    rect = _pack_rect(h.xmin, h.xmin + int(width_px) * PIXEL_TO_TWIP,
                      h.ymin, h.ymin + int(height_px) * PIXEL_TO_TWIP)
    rate = data[h.body_offset - 4:h.body_offset - 2]  # 帧率 2B 原样保留
    body = data[h.body_offset:]
    head_wo_len = data[:4]
    out = bytearray(head_wo_len + b"\x00" * 4 + rect + rate
                    + struct.pack("<H", int(frame_count)) + body)
    out[4:8] = struct.pack("<I", len(out))  # 长度补丁：声明==实际（check_swf 复核位）
    return bytes(out)


def swf_resize_if_needed(data: bytes, page_w: int, page_h: int,
                         frame_count: int = 1) -> tuple[bytes, list[str]]:
    """带缺陷检测的修正：有因才改写（返回 (产物, 已修原因清单)；干净件原字节直返）。"""
    reasons = swf_needs_fix(data, page_w, page_h)
    if not reasons:
        return data, []
    return swf_resize(data, page_w, page_h, frame_count), reasons


# ---------------------------------------------------------------------------
# FFDec 子进程封装（§1.7 / §6-5）
# ---------------------------------------------------------------------------

@dataclass(frozen=True)
class FramePdfRun:
    """一次 FFDec JVM 调用的事实结果（产物从盘面实测计数，非声明值）。"""

    returncode: int
    produced: dict[str, Path]      # swf 名（去扩展名）→ frames.pdf 实际路径
    stdout_tail: str
    stderr_tail: str
    cmd: list[str] = field(default_factory=list)


def build_ffdec_cmd(java_exe: str, ffdec_jar: str, out_dir: str | Path,
                    swf_target: str | Path, zoom: float = 1.0,
                    select: str = "1") -> list[str]:
    """§1.7 命令行拼装（纯函数）：-format frame:pdf -zoom {scale} -select 1
    -export frame {出目录} {swf文件或目录}。"""
    return [str(java_exe), "-jar", str(ffdec_jar),
            "-format", "frame:pdf", "-zoom", str(zoom), "-select", str(select),
            "-export", "frame", str(out_dir), str(swf_target)]


def _resolve_tool(explicit: str | None, env_key: str,
                  locate) -> Path:
    """工具定位三段序：显式参数 > 环境变量 > rea-tools 约定目录；缺位报自举指引。"""
    cand = explicit or os.environ.get(env_key) or locate(default_toolchain_root())
    if not cand or not Path(cand).is_file():
        name = Path(str(cand or env_key)).name or env_key
        raise ToolchainError(f"工具未落位: {name}（候选={cand}）。{_ENSURE_HINT}")
    return Path(cand)


def _tail(text: str) -> str:
    return text[-_TAIL_CHARS:] if text else ""


def run_ffdec_frame_pdf(swf_target: str | Path, out_dir: str | Path, *,
                        java_exe: str | None = None,
                        ffdec_jar: str | None = None, zoom: float = 1.0,
                        select: str = "1", timeout_s: int = 900) -> FramePdfRun:
    """一组 SWF（目录=整组一次 JVM；单文件亦可）→ 每件一 frames.pdf。

    FFDec 输出布局（26.4.0 实测）：目录输入产 {out}/{swf名}/frames.pdf（键=
    目录名即 stem）；单文件输入产 {out}/frames.pdf（键=输入 stem）。
    returncode 非零不抛（调用方按 produced 判产出，stderr_tail 留档）；
    工具缺位/超时抛 ToolchainError。坑点：帧数 0 件 returncode=0 且零产物
    ——上游必须先 swf_resize（§1.6，测试已钉）。
    """
    swf = Path(swf_target)
    if not swf.exists():
        raise SwfError(f"SWF 输入不存在: {swf}")
    java = _resolve_tool(java_exe, "KB_HARVEST_JAVA", locate_java)
    jar = _resolve_tool(ffdec_jar, "KB_HARVEST_FFDEC_JAR", locate_ffdec)
    out = Path(out_dir)
    out.mkdir(parents=True, exist_ok=True)
    cmd = build_ffdec_cmd(java, jar, out, swf, zoom=zoom, select=select)
    try:
        proc = subprocess.run(cmd, capture_output=True, text=True,
                              errors="replace", timeout=timeout_s)
    except subprocess.TimeoutExpired as exc:
        raise ToolchainError(f"FFDec 超时（{timeout_s}s）：{swf}；cmd={' '.join(cmd)}") from exc
    produced: dict[str, Path] = {}
    for pdf in sorted(out.rglob("frames.pdf")):
        if swf.is_file():
            key = swf.stem                     # 单文件模式：FFDec 平铺到 out/frames.pdf
        else:
            key = pdf.parent.name               # 目录模式实测：子目录名=完整文件名（含 .swf）
            if key.lower().endswith(".swf"):
                key = key[:-4]
            if pdf.parent == out:               # 目录模式下平铺件无法归因，按入参名兜底
                key = f"{swf.name}:{pdf.name}"
        produced[key] = pdf
    return FramePdfRun(proc.returncode, produced, _tail(proc.stdout),
                       _tail(proc.stderr), list(cmd))


def export_frame_pdf(swf_path: str | Path, out_dir: str | Path, **kwargs) -> FramePdfRun:
    """单件便捷口（=run_ffdec_frame_pdf 单文件模式）；produced 键=输入 stem。"""
    return run_ffdec_frame_pdf(swf_path, out_dir, **kwargs)


def presse_merge(pdf_paths: Sequence[str | Path], out_pdf: str | Path, *,
                 presse_exe: str | None = None, optimize: bool = True,
                 timeout_s: int = 600) -> Path:
    """§1.7 presse merge：多页 PDF 按传入序合并 + --optimize 压缩 → 单件落盘。

    页序=传入序（与 build_image_pdf 同口径）；产物存在性+字节数实测校验
    （数字零造假：presse 声称成功但零产物=ToolchainError）。
    """
    paths = [Path(p) for p in pdf_paths]
    if not paths:
        raise ValueError("pdf_paths 为空：merge 不产 0 页 PDF")
    for p in paths:
        if not p.is_file():
            raise SwfError(f"输入 PDF 不存在: {p}")
    exe = _resolve_tool(presse_exe, "KB_HARVEST_PRESSE", locate_presse)
    out = Path(out_pdf)
    out.parent.mkdir(parents=True, exist_ok=True)
    cmd = [str(exe), "merge", *[str(p) for p in paths]]
    if optimize:
        cmd.append("--optimize")
    cmd += ["-o", str(out)]
    try:
        proc = subprocess.run(cmd, capture_output=True, text=True,
                              errors="replace", timeout=timeout_s)
    except subprocess.TimeoutExpired as exc:
        raise ToolchainError(f"presse merge 超时（{timeout_s}s）：{len(paths)} 件") from exc
    if proc.returncode != 0:
        raise ToolchainError(f"presse merge 失败 rc={proc.returncode}: "
                             f"{_tail(proc.stderr) or _tail(proc.stdout)}")
    if not out.is_file() or out.stat().st_size == 0:
        raise ToolchainError(f"presse 声称成功但零产物: {out}")
    return out
