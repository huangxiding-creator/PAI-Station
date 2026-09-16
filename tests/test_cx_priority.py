# -*- coding: utf-8 -*-
"""提取优先级打分（F 组 Autopsy/H 组公式简化落地）：价值区×新近度×类型−体积。"""

from __future__ import annotations

import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

from paistation.cx.priority import score_file


def _ts(days_ago: float) -> float:
    return time.time() - days_ago * 86400


class TestScoreFile:
    def test_mainline_task_beats_competitor_src(self):
        main = score_file("E:/AI-Station/07 任务/白龟湖法律诉讼/函件.pdf",
                          size=1e5, mtime=_ts(30))
        comp = score_file("E:/AI-Station/research/competitors-src/x/main.js",
                          size=1e5, mtime=_ts(30))
        assert main[0] > comp[0] + 40  # 主业任务区碾压竞品源码区
        assert "主业" in main[1] or "白龟湖" in main[1]

    def test_cache_negative_and_skip(self):
        s, reason = score_file("E:/x/.chrome-profile/Default/Cache/f_001",
                               size=1e4, mtime=_ts(1))
        assert s < -50 and "缓存" in reason

    def test_recency_bonus_and_size_penalty(self):
        fresh = score_file("E:/AI-Station/notes/a.md", size=1e4, mtime=_ts(10))
        stale = score_file("E:/AI-Station/notes/b.md", size=1e9, mtime=_ts(800))
        assert fresh[0] > stale[0]

    def test_doc_ext_bonus(self):
        doc = score_file("E:/AI-Station/随便/x.docx", size=1e4, mtime=_ts(100))
        bin_ = score_file("E:/AI-Station/随便/x.dll", size=1e4, mtime=_ts(100))
        assert doc[0] > bin_[0]

    def test_reason_explains(self):
        _, reason = score_file("E:/AI-Station/04 智库/混沌学园/a.md",
                               size=1e4, mtime=_ts(50))
        assert "智库" in reason

    def test_longest_zone_wins(self):
        # 07 任务目录下的副业任务：最长命中"总包生态圈"压倒目录级"07 任务"
        s, reason = score_file("E:/AI-Station/07 任务/总包生态圈投资合伙人招募/a.txt",
                               size=1e4, mtime=_ts(30))
        assert "副业" in reason
        assert "主业任务区" not in reason

    def test_empty_file_skipped(self):
        s, reason = score_file("E:/AI-Station/07 任务/board/.gitkeep",
                               size=0, mtime=_ts(1))
        assert s == -100.0 and "空文件" in reason
