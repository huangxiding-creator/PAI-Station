# -*- coding: utf-8 -*-
"""workspace-hygiene-1015 公共库：长路径前缀、保护区、manifest 解析、原子写。

四件工具（cleanup_runner / dedup_scanner / hardlink_factory / verify_gate）共用。
设计原则（KB-CLEANUP-RUNNER-SPEC）：
- 清单驱动：manifest 是唯一删除依据
- 保护区前缀硬编码，命中即拒
- junction 棒杀：islink / isjunction / realpath 异常一律拒
- 长路径一律 \\\\?\\ 前缀处理
"""
from __future__ import annotations

import json
import os
import tempfile
from datetime import datetime, timezone, timedelta

CST = timezone(timedelta(hours=8))


def now_iso() -> str:
    return datetime.now(CST).isoformat(timespec="seconds")


# ---------------------------------------------------------------------------
# 长路径（Windows \\\\?\\ 前缀）
# ---------------------------------------------------------------------------

def lp(path: str | os.PathLike) -> str:
    """返回加 \\\\?\\ 前缀的绝对路径（Windows）；非 Windows 原样绝对化。"""
    p = os.path.abspath(os.fspath(path))
    if os.name != "nt":
        return p
    if p.startswith("\\\\?\\"):
        return p
    p = p.replace("/", "\\")
    if p.startswith("\\\\"):  # UNC -> \\?\UNC\...
        return "\\\\?\\UNC" + p[1:]
    return "\\\\?\\" + p


def strip_lp(path: str) -> str:
    """剥掉 \\\\?\\ / \\\\?\\UNC\\ 前缀，还原普通展示路径。"""
    if path.startswith("\\\\?\\UNC\\"):
        return "\\\\" + path[len("\\\\?\\UNC\\"):]
    if path.startswith("\\\\?\\"):
        return path[len("\\\\?\\"):]
    return path


def is_junction_or_link(path: str) -> bool:
    """symlink / junction / 目录重解析点检测（不跟随）。"""
    p = lp(path)
    if os.path.islink(p):
        return True
    isj = getattr(os.path, "isjunction", None)  # py>=3.12
    if isj is not None and isj(p):
        return True
    return False


def realpath_deviation(path: str) -> str | None:
    """realpath 异常检测：解析结果与原路径不一致（自身或祖先是链接/junction）。

    返回异常说明（拒删理由），正常返回 None。比较用 normcase 消大小写差异。
    """
    p = os.path.abspath(os.fspath(path))
    try:
        rp = os.path.realpath(lp(p))
    except OSError:
        return "realpath 解析失败"
    rp = os.path.normcase(os.path.abspath(strip_lp(rp)))
    if rp != os.path.normcase(p):
        return f"realpath 偏离: {strip_lp(rp)}"
    return None


# ---------------------------------------------------------------------------
# 保护区（在役红线，硬编码；测试可用假前缀注入/monkeypatch）
# ---------------------------------------------------------------------------

PROTECTED_PREFIXES: list[str] = [
    r"E:\AI-Station\data\local_index",
    r"E:\AI-Station\EngOpp-Mining\data",
    r"E:\AI-Station\IdeaDig",
    r"E:\AI-Station\乐奇AI眼镜",
    r"E:\AI-Station\04 智库",
    r"E:\AI-Station\data\hundun",       # junction 本身，绝对拒
    r"E:\AI-Station\reforge_factory",
    r"E:\AI-Station\tools",
    r"E:\AI-Station\ammo_pool",
    r"E:\AI-Station\report_platform",
    r"E:\AI-Station\.claude",
    r"E:\AI-Station\_proposals\workspace-hygiene-1015",  # 本提案自身
]

# 密钥/状态账本文件（CLAUDE.md 红线）：按 basename 匹配，任何位置都拒
PROTECTED_BASENAMES: set[str] = {
    "secret.ini",
    "virtual_pay.secret",
    "video_account_state.json",
}


def _norm(p: str) -> str:
    return os.path.normcase(os.path.abspath(p)).rstrip("\\/")


def is_protected(path: str) -> str | None:
    """命中保护区返回理由字符串，未命中返回 None。前缀按路径分量匹配。"""
    n = _norm(path)
    base = os.path.basename(n)
    if base.lower() in PROTECTED_BASENAMES:
        return f"密钥/账本文件: {base}"
    for pre in PROTECTED_PREFIXES:
        np = _norm(pre)
        if n == np or n.startswith(np + os.sep):
            return f"保护区前缀: {pre}"
    return None


# ---------------------------------------------------------------------------
# manifest 解析：`<bytes>\t<abs_path>` 与 `DIR\t<abs_path>`
# ---------------------------------------------------------------------------

class ManifestEntry:
    __slots__ = ("kind", "declared_bytes", "path", "lineno")

    def __init__(self, kind: str, declared_bytes: int, path: str, lineno: int):
        self.kind = kind          # 'file' | 'dir'
        self.declared_bytes = declared_bytes
        self.path = path
        self.lineno = lineno


def read_manifest(path: str | os.PathLike) -> list[ManifestEntry]:
    entries: list[ManifestEntry] = []
    with open(path, "r", encoding="utf-8-sig", errors="replace") as f:
        for i, line in enumerate(f, 1):
            s = line.rstrip("\r\n")
            if not s.strip() or s.lstrip().startswith("#"):
                continue
            if "\t" not in s:
                raise ValueError(f"manifest 第 {i} 行缺少 TAB 分隔: {s[:120]}")
            head, p = s.split("\t", 1)
            p = p.strip()
            if head == "DIR":
                entries.append(ManifestEntry("dir", 0, p, i))
            else:
                try:
                    b = int(head)
                except ValueError:
                    raise ValueError(f"manifest 第 {i} 行字节段非整数: {head[:40]}")
                entries.append(ManifestEntry("file", b, p, i))
    return entries


# ---------------------------------------------------------------------------
# 杂项
# ---------------------------------------------------------------------------

def atomic_write_json(path: str | os.PathLike, obj) -> None:
    d = os.path.dirname(os.path.abspath(path))
    os.makedirs(d, exist_ok=True)
    fd, tmp = tempfile.mkstemp(dir=d, prefix=".tmp_", suffix=".json")
    try:
        with os.fdopen(fd, "w", encoding="utf-8") as f:
            json.dump(obj, f, ensure_ascii=False, indent=1)
        os.replace(tmp, path)
    finally:
        if os.path.exists(tmp):
            try:
                os.remove(tmp)
            except OSError:
                pass


def fmt_bytes(n: float) -> str:
    n = float(n)
    for unit in ("B", "KB", "MB", "GB", "TB"):
        if abs(n) < 1024.0 or unit == "TB":
            return f"{n:.2f} {unit}" if unit != "B" else f"{int(n)} B"
        n /= 1024.0
    return f"{n:.2f} TB"

REGEN_CACHE_NAMES = {"__pycache__", ".pytest_cache", "Code Cache", "GPUCache", "Cache_Data", "Service Worker"}
