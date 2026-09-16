# -*- coding: utf-8 -*-
"""PII 全盘普查（V3 Presidio NoOp 模式：纯正则+校验和，零 ML 依赖）。

中文场景识别器自建（Presidio 内置多为西文格式，借鉴其框架模式）：
- 身份证 18 位（GB 11643 mod11-2 校验）
- 手机号 1[3-9] 段（数字串整体归类，防 glued 长串误拆）
- 银行卡 13-19 位（Luhn 校验）
- 邮箱

普查级精度：数字串按整串分类，宁可漏报不误报。结果只入本地
inventory.pii_findings（目的边界=本人+工作；永不外发）。
"""

from __future__ import annotations

import re
import sqlite3
from collections import defaultdict
from datetime import datetime, timezone

# 11-19 位连续数字串（可带身份证尾位 X，前后非数字），先抓串再分类
_DIGIT_RUN = re.compile(r"(?<!\d)\d{11,19}[Xx]?(?!\d)")
_EMAIL = re.compile(r"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}")

_ID_WEIGHTS = (7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2)
_ID_CHECK = "10X98765432"


def valid_idcard(s: str) -> bool:
    """GB 11643 mod11-2 校验（18 位，末位可为 X）。"""
    if len(s) != 18:
        return False
    try:
        body = [int(c) for c in s[:17]]
    except ValueError:
        return False
    check = sum(w * d for w, d in zip(_ID_WEIGHTS, body)) % 11
    return s[17].upper() == _ID_CHECK[check]


def valid_luhn(s: str) -> bool:
    if not s.isdigit():
        return False
    digits = [int(c) for c in s]
    total = 0
    for i, d in enumerate(reversed(digits)):
        if i % 2 == 1:
            d *= 2
            if d > 9:
                d -= 9
        total += d
    return total % 10 == 0


def scan_text(text: str) -> dict[str, int]:
    """单文本 PII 计数 {kind: n}，零命中返回 {}。"""
    out: dict[str, int] = defaultdict(int)
    for m in _DIGIT_RUN.finditer(text or ""):
        s = m.group()
        digits = s[:-1] if s[-1] in "Xx" else s
        if len(digits) == 11 and digits[0] == "1" and digits[1] in "3456789":
            out["phone"] += 1
        elif len(s) == 18 and valid_idcard(s):
            out["idcard"] += 1
        elif 13 <= len(digits) <= 19 and valid_luhn(digits):
            out["bank_card"] += 1
    for _ in _EMAIL.finditer(text or ""):
        out["email"] += 1
    return dict(out)


def scan_chunks(chunks_conn: sqlite3.Connection,
                batch: int = 5000) -> dict[str, dict[str, int]]:
    """全 chunks 明表普查（keyset 分批防大库爆内存）。

    返回 {path: {kind: n}}（按文件聚合跨块求和；path 键归一正斜杠，
    与 files/file_sources 同形态可 JOIN）。
    """
    from paistation.sense.localfiles.inventory import _norm_path
    findings: dict[str, dict[str, int]] = defaultdict(
        lambda: defaultdict(int))
    last_path, last_seq = "", -1
    while True:
        rows = chunks_conn.execute(
            "SELECT path, seq, text FROM chunks"
            " WHERE (path > ?) OR (path = ? AND seq > ?)"
            " ORDER BY path, seq LIMIT ?",
            (last_path, last_path, last_seq, batch)).fetchall()
        if not rows:
            break
        for path, seq, text in rows:
            for kind, n in scan_text(text).items():
                findings[_norm_path(path)][kind] += n
        last_path, last_seq = rows[-1][0], rows[-1][1]
    return {p: dict(k) for p, k in findings.items()}


def save_findings(inv_conn: sqlite3.Connection,
                  findings: dict[str, dict[str, int]]) -> int:
    """全量刷新 pii_findings（普查=当前快照，无陈旧行）。返回写入行数。"""
    inv_conn.execute(
        "CREATE TABLE IF NOT EXISTS pii_findings("
        " path TEXT, kind TEXT, hits INTEGER, scanned_at TEXT,"
        " PRIMARY KEY(path, kind))")
    now = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
    with inv_conn:
        inv_conn.execute("DELETE FROM pii_findings")
        inv_conn.executemany(
            "INSERT INTO pii_findings(path, kind, hits, scanned_at)"
            " VALUES(?,?,?,?)",
            [(path, kind, n, now)
             for path, kinds in findings.items()
             for kind, n in kinds.items()])
    return len(findings)
