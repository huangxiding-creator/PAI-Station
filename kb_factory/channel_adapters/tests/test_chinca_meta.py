# -*- coding: utf-8 -*-
"""chinca_meta（W5 渠道适配器·元数据层）测试 — 离线 mock 全绿为准，零真网络。
覆盖：契约（stats→xls/文章→doc/pdf 迹象映射、extra 栏目/日期/原站id、audit.jsonl 如实一行）、
降级（复刻件缺失/Node 缺席/WAF 失败 → fail-soft 部分结果或[]+审计，绝不崩溃）、
频控（默认间隔 5s/日上限 200、间隔实测、日上限熔断抛 RateLimitExceeded、连续错误熔断 CircuitOpenError）。
真网络 smoke 一律 @pytest.mark.skip 保底不炸 CI。
"""
import json
import os
import sys
import tempfile
import unittest
from pathlib import Path
from unittest import mock

sys.path.insert(0, str(Path(__file__).resolve().parents[3]))  # 仓库根入 sys.path

import pytest

from kb_factory.channel_adapters import chinca_meta
from kb_factory.channel_adapters.base import (AuditLog, CircuitOpenError, RateLimiter,
                                              RateLimitExceeded)
from kb_factory.channel_adapters.chinca_meta import ChincaAdapter

_STATS = [
    {"title": "2026年1-9月我国对外承包工程完成营业额统计表", "url": "/CICA/info/261000001", "date": "2026-10-20"},
    {"title": "2026年1-9月对外承包工程新签合同额统计序列", "url": "/CICA/info/261000002", "date": "2026-10-19"},
]
_NEWS = [
    {"title": "商会发布国际工程观察报告(PDF)", "url": "/CICA/info/261100001", "date": "2026-10-18"},
    {"title": "会员动态：某公司中标海外水电站项目", "url": "/CICA/info/261100002", "date": "2026-10-17"},
]


class _FakeClient:
    """离线替身：只实现题录级 list_column；get_article 一旦被调即违约断言。"""

    def __init__(self, pages, error_cols=(), error=Exception("boom")):
        self.pages = pages  # {column: {page: (items, max_pages)}}
        self.error_cols = set(error_cols)
        self.error = error
        self.calls = []
        self.solve_count = 0

    def list_column(self, column=None, path=None, page=1, limit=None):
        self.calls.append((column, page))
        if column in self.error_cols:
            raise self.error
        items, mp = self.pages.get(column, {}).get(page, ([], 1))
        return list(items), mp

    def get_article(self, url):
        raise AssertionError("元数据层禁入 get_article（站铁律：免费层只取题录）")


def _factory(client):
    return lambda timeout: client


def _make(client, limiter=None, columns=("stats", "notice")):
    audit = AuditLog(path=os.path.join(tempfile.mkdtemp(), "audit.jsonl"))
    ad = ChincaAdapter(limiter=limiter or RateLimiter(min_interval=0, daily_limit=50,
                                                      name="chinca-test"),
                       audit=audit, columns=columns, client_factory=_factory(client))
    return ad, audit


def _audit_lines(audit):
    with open(audit.path, encoding="utf-8") as f:
        return [json.loads(x) for x in f if x.strip()]


class ChincaMetaContract(unittest.TestCase):

    def test_stats_and_news_mapping(self):
        client = _FakeClient({"stats": {1: (_STATS, 1)}, "notice": {1: (_NEWS, 1)}})
        ad, audit = _make(client)
        metas = ad.metadata("", 10)
        self.assertEqual(4, len(metas))
        s0, s1, n0, n1 = metas
        self.assertEqual("xls", s0.fmt)  # 统计序列→xls
        self.assertEqual("xls", s1.fmt)
        self.assertEqual("pdf", n0.fmt)  # 题录含 (PDF) → pdf
        self.assertEqual("doc", n1.fmt)  # 其余文章→doc
        for m in metas:
            self.assertEqual("green_free", m.badge)
            self.assertEqual("green", m.perm)  # 公开统计/资讯题录
            self.assertIsNone(m.pages)  # 题录无页数，如实 None
            self.assertTrue(m.source_url.startswith("https://www.chinca.org/CICA/info/"))
        self.assertEqual("stats", s0.extra["column"])
        self.assertEqual("统计分析", s0.extra["column_name"])
        self.assertEqual("2026-10-20", s0.extra["date"])
        self.assertEqual("261000001", s0.extra["origin_id"])  # 原站 id
        self.assertEqual("通知公告", n1.extra["column_name"])
        lines = _audit_lines(audit)
        self.assertTrue(all(x["channel"] == "chinca" for x in lines))
        self.assertEqual(2, len([x for x in lines if x["event"] == "request"]))
        self.assertEqual(0, len([x for x in lines if x["event"] == "error"]))

    def test_query_title_filter_and_priority(self):
        client = _FakeClient({"stats": {1: (_STATS, 1)}, "notice": {1: (_NEWS, 1)}})
        ad, _ = _make(client)
        metas = ad.metadata("统计", 10)
        self.assertEqual(["xls", "xls"], [m.fmt for m in metas])
        self.assertTrue(all("统计" in m.title for m in metas))
        self.assertEqual(("stats", 1), client.calls[0])  # 统计栏目优先于资讯

    def test_paging_and_limit(self):
        client = _FakeClient({"stats": {1: (_STATS, 3), 2: (_STATS, 3)}})
        ad, _ = _make(client, columns=("stats",))
        metas = ad.metadata("", 3)
        self.assertEqual(3, len(metas))
        self.assertEqual([("stats", 1), ("stats", 2)], client.calls)

    def test_get_article_never_called(self):
        client = _FakeClient({"stats": {1: (_STATS, 1)}})
        ad, _ = _make(client, columns=("stats",))
        ad.metadata("", 5)  # 误入正文会触发替身内 AssertionError
        self.assertEqual(1, len(client.calls))


class ChincaMetaDegrade(unittest.TestCase):

    def test_replica_missing_failsoft(self):
        def boom(timeout):
            raise ImportError("requests missing")

        audit = AuditLog(path=os.path.join(tempfile.mkdtemp(), "audit.jsonl"))
        ad = ChincaAdapter(limiter=RateLimiter(min_interval=0, daily_limit=50, name="t"),
                           audit=audit, columns=("stats",), client_factory=boom)
        self.assertEqual([], ad.metadata("统计", 5))  # fail-soft []，绝不崩溃
        self.assertIn("replica load failed", ad.reason())
        errs = [x for x in _audit_lines(audit) if x["event"] == "error"]
        self.assertEqual(1, len(errs))  # 审计一行如实记录
        self.assertIn("ImportError", errs[0]["detail"])

    def test_available_false_when_replica_dir_missing(self):
        old = chinca_meta._REPLICA_DIR
        try:
            chinca_meta._REPLICA_DIR = os.path.join(tempfile.mkdtemp(), "nope")
            ad, _ = _make(_FakeClient({}))
            self.assertFalse(ad.available())
            self.assertEqual("replica missing", ad.reason())
        finally:
            chinca_meta._REPLICA_DIR = old

    def test_node_absent_failsoft_partial_result(self):
        # Node 不在：复刻件 subprocess 抛 FileNotFoundError → 该栏目降级，他栏目照常
        client = _FakeClient({"notice": {1: (_NEWS, 1)}}, error_cols={"stats"},
                             error=FileNotFoundError("[WinError 2] 找不到 node"))
        ad, audit = _make(client)
        metas = ad.metadata("会员动态", 10)
        self.assertEqual(1, len(metas))
        self.assertEqual("doc", metas[0].fmt)
        errs = [x for x in _audit_lines(audit) if x["event"] == "error"]
        self.assertEqual(1, len(errs))
        self.assertIn("FileNotFoundError", errs[0]["detail"])
        self.assertIn("col=stats", errs[0]["detail"])
        self.assertEqual([("stats", 1), ("stats", 1), ("notice", 1)], client.calls)  # 重试1次

    def test_circuit_opens_after_consecutive_errors(self):
        client = _FakeClient({}, error_cols={"stats", "notice"},
                             error=FileNotFoundError("[WinError 2] 找不到 node"))
        limiter = RateLimiter(min_interval=0, daily_limit=50, error_threshold=2, name="t")
        ad, _ = _make(client, limiter=limiter)
        self.assertEqual([], ad.metadata("", 10))  # 两栏目各失败 → 连续错误=2 熔断
        self.assertFalse(ad.available())
        with self.assertRaises(CircuitOpenError):
            ad.metadata("", 10)
        limiter.reset()
        self.assertTrue(ad.available())


class ChincaMetaRateLimit(unittest.TestCase):

    def test_strict_defaults_5s_200(self):
        with mock.patch.dict(os.environ, {}, clear=False):
            os.environ.pop("KB_CHINCA_MIN_INTERVAL", None)
            os.environ.pop("KB_CHINCA_DAILY_LIMIT", None)
            ad = ChincaAdapter()  # 默认从严：间隔5s、日上限200（WAF solver 每调都要跑）
        st = ad.limiter.status()
        self.assertEqual(5.0, st["min_interval"])
        self.assertEqual(200, st["daily_limit"])
        self.assertEqual("chinca", st["name"])

    def test_min_interval_enforced(self):
        waits = []
        limiter = RateLimiter(min_interval=5, daily_limit=50, name="t",
                              clock=lambda: 100.0, sleep=lambda w: waits.append(round(w, 6)))
        client = _FakeClient({"stats": {1: (_STATS, 3), 2: ([], 3)}})
        ad, _ = _make(client, limiter=limiter, columns=("stats",))
        metas = ad.metadata("", 10)
        self.assertEqual(2, len(metas))
        self.assertEqual([5.0], waits)  # 第 2 次请求前强制等待 5s（首调无等待）

    def test_daily_limit_circuit(self):
        limiter = RateLimiter(min_interval=0, daily_limit=1, name="t")
        client = _FakeClient({"stats": {1: (_STATS, 3), 2: (_STATS, 3)}})
        ad, _ = _make(client, limiter=limiter, columns=("stats",))
        with self.assertRaises(RateLimitExceeded):  # 日上限熔断按契约上抛
            ad.metadata("", 10)


@pytest.mark.skip(reason="真网络 smoke：CI 保底跳过（复刻件 10/10 实测；需 Node 在 PATH + 外网）")
def test_live_smoke_stats_metadata():
    ad = ChincaAdapter(audit=AuditLog(path=os.path.join(tempfile.mkdtemp(), "audit.jsonl")))
    metas = ad.metadata("统计", 5)
    assert isinstance(metas, list) and all(m.perm == "green" for m in metas)


if __name__ == "__main__":
    unittest.main()
