# -*- coding: utf-8 -*-
"""PII 全盘普查（V3 Presidio NoOp 模式：纯正则+校验和，零 ML 依赖）。

识别器自建（中文场景）：身份证 mod11-2 校验、手机号段、银行卡 Luhn、
邮箱。数字串整体归类（防长串误拆），普查级精度。
"""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

from paistation.cx.pii_scan import (
    save_findings,
    scan_chunks,
    scan_text,
    valid_idcard,
    valid_luhn,
)


class TestValidators:
    def test_idcard_checksum(self):
        assert valid_idcard("11010519491231002X")  # 标准有效样例
        assert not valid_idcard("110105194912310021")  # 校验位错

    def test_luhn(self):
        assert valid_luhn("4111111111111111")  # Visa 测试卡
        assert not valid_luhn("4111111111111112")


class TestScanText:
    def test_phone_in_text(self):
        assert scan_text("电话13800138000请回复") == {"phone": 1}

    def test_long_digit_run_not_phone(self):
        # 12 位长串不是手机号（防 glued 误拆）
        assert "phone" not in scan_text("单号138001380001已发货")

    def test_idcard_and_bank(self):
        out = scan_text("身份证11010519491231002X，卡号4111111111111111")
        assert out.get("idcard") == 1 and out.get("bank_card") == 1

    def test_email(self):
        assert scan_text("联系 someone@example.com 谢谢") == {"email": 1}

    def test_clean_text_empty(self):
        assert scan_text("这里没有任何敏感信息") == {}


class TestScanChunks:
    def test_aggregate_per_file_and_norm_path(self, tmp_path):
        from paistation.sense.localfiles.store import ChunkIndex
        idx = ChunkIndex(tmp_path / "index.db")
        idx.upsert_file("E:/a.md", ["手机13800138000", "邮箱 x@y.com"], "v1")
        idx.upsert_file("E:/b.md", ["干净文本"], "v1")
        # 存量反斜杠形态行：path 键须归一（与 files 表可 JOIN）
        legacy = "E:" + chr(92) + "c.md"
        idx._db.execute(
            "INSERT INTO chunks(chunk_id, path, seq, text, logic_ver,"
            " file_gen, updated_at) VALUES('c9',?,1,'卡4111111111111111',"
            " 'v0',0,0)", (legacy,))
        idx._db.commit()
        findings = scan_chunks(idx._db)
        assert findings == {"E:/a.md": {"phone": 1, "email": 1},
                            "E:/c.md": {"bank_card": 1}}
        idx.close()


class TestSaveFindings:
    def test_refresh_replaces_stale(self, tmp_path):
        import sqlite3
        conn = sqlite3.connect(tmp_path / "inv.db")
        assert save_findings(conn, {"E:/a.md": {"phone": 2}}) == 1
        assert save_findings(conn, {"E:/b.md": {"email": 1}}) == 1
        rows = conn.execute(
            "SELECT path, kind, hits FROM pii_findings"
            " ORDER BY path").fetchall()
        assert rows == [("E:/b.md", "email", 1)]  # 旧 a.md 行被刷掉
        conn.close()
