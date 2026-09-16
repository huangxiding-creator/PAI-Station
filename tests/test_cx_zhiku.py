# -*- coding: utf-8 -*-
"""04 智库各渠道扫描 → 策展条目（观点维：他收藏/付费的知识体系）。"""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

from paistation.cx.entities import EntityStore  # noqa: E402
from paistation.cx.ingest_zhiku import (  # noqa: E402
    CHANNELS,
    scan_zhiku,
    register_zhiku,
)


def _mini(root: Path) -> None:
    (root / "微信读书" / "智能商业").mkdir(parents=True)
    (root / "微信读书" / "智能商业" / "ch1.md").write_text("x", encoding="utf-8")
    (root / "混沌学园").mkdir()
    (root / "混沌学园" / "AI产品研发思维武器库.md").write_text("x",
                                                                encoding="utf-8")
    (root / "混沌学园" / "README.md").write_text("x", encoding="utf-8")
    (root / "一堂").mkdir()
    (root / "一堂" / "五步法进阶1：需求原点.doc").write_text("x", encoding="utf-8")
    (root / "洞见研报" / "智慧水利").mkdir(parents=True)
    (root / "洞见研报" / "智慧水利" / "r1.pdf").write_text("x", encoding="utf-8")


class TestScanZhiku:
    def test_channels_covered(self):
        assert "微信读书" in CHANNELS and "混沌学园" in CHANNELS

    def test_scan_books_and_courses(self, tmp_path):
        _mini(tmp_path)
        items = scan_zhiku(tmp_path)
        names = [n for _, n in items]
        assert "书：智能商业" in names                    # 书目录 → 书条目
        assert "课：AI产品研发思维武器库" in names          # 混沌 md → 课条目
        assert "README" not in str(names)                 # README 不算策展
        assert any("五步法" in n for n in names)          # 一堂文件名
        assert "专题：智慧水利" in names                  # 洞见子目录

    def test_register_idempotent(self, tmp_path):
        _mini(tmp_path)
        store = EntityStore(tmp_path / "e.db")
        store.register("person", "总包君", source="t")
        n1 = register_zhiku(store, scan_zhiku(tmp_path))
        n2 = register_zhiku(store, scan_zhiku(tmp_path))
        assert n1 > 0 and n2 == 0
        # 书 topic 挂 curated_by → 本人
        assert store._conn.execute(
            "SELECT 1 FROM entity_links WHERE from_id='topic/书-智能商业' "
            "AND relation='curated_by'").fetchone()
        store.close()
