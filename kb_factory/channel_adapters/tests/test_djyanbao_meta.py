# -*- coding: utf-8 -*-
"""djyanbao_meta 渠道适配器测试 — 离线 mock（stub _fetch），零真网络。

覆盖: 正常→FileMeta 字段齐（fmt归一/em剥离/extra原始事实/审计一行） /
      空结果→[] / 异常→[]不崩（含 code!=0） / 频控生效（间隔2s·日上限500·连错5熔断到日切） /
      配方形状铁律（端点/参数/头照抄复刻件） / 翻页与重试1次 /
      x5 真翻页用例（5x 池扩容）：limit=36 跨 4 页聚合/短页终止/
      页间 RateLimiter 间隔/limit≤10 单页零漂移。
真网络 smoke 用例 @pytest.mark.skip 保底不炸 CI（手动实弹时临时移除标记）。
"""
import json
import os
import sys
import tempfile
import unittest
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[3]))  # 仓库根入 sys.path

from kb_factory.channel_adapters.base import (AuditLog, CircuitOpenError, FileMeta,
                                              RateLimitExceeded, RateLimiter)
from kb_factory.channel_adapters import djyanbao_meta
from kb_factory.channel_adapters.djyanbao_meta import DjyanbaoAdapter


def tmp_audit():
    fd, path = tempfile.mkstemp(suffix=".jsonl")
    os.close(fd)
    return AuditLog(path), path


def fake_clock():
    class FakeClock:
        def __init__(self):
            self.t = 1000.0

        def __call__(self):
            return self.t

        def sleep(self, d):
            self.t += d
    return FakeClock()


def dj_card(i, title=None, pages=28, publish="2026-10-01 08:30:00", stock="水利工程",
            score=88):
    return {"id": 1000 + i, "typeId": 2, "businessId": "b%d" % i,
            "title": title or "<em>水利</em>行业深度研报%d" % i,
            "authors": "研究员甲/研究员乙", "orgName": "某证券研究所",
            "publishAt": publish, "pageTotal": pages, "fileSize": 1234567,
            "uploaderName": "洞见平台", "stockName": stock, "reportScore": score,
            "highlight": {"title": ["<em>水利</em>"],
                          "content": ["<em>水利</em>工程EPC行业研究摘要片段%d，供题录层展示" % i]}}


def dj_page(cards, total=None):
    return {"code": 0, "data": {"data": cards,
                                "meta": {"itemCount": total if total is not None else len(cards)}}}


class DjyanbaoTestBase(unittest.TestCase):
    def setUp(self):
        self.audit, self.audit_path = tmp_audit()
        self.fetches = []
        self.addCleanup(os.unlink, self.audit_path)

    def adapter(self, **kw):
        lim = RateLimiter(min_interval=kw.pop("min_interval", 0),
                          daily_limit=kw.pop("daily_limit", 500),
                          error_threshold=kw.pop("error_threshold", 5),
                          today=lambda: "d1")
        return DjyanbaoAdapter(limiter=lim, audit=self.audit, **kw)

    def stub_fetch(self, fn):
        djyanbao_meta._fetch = fn
        self.addCleanup(setattr, djyanbao_meta, "_fetch", djyanbao_meta._urllib_fetch)

    def audit_lines(self):
        return [json.loads(l) for l in open(self.audit_path, encoding="utf-8") if l.strip()]


# ---------------- 正常映射 ----------------

class TestDjyanbaoNormal(DjyanbaoTestBase):
    def test_normal_maps_filemeta_fields(self):
        script = {1: dj_page([dj_card(1),
                              dj_card(2, title="国际工程EPC市场展望2026.ppt"),
                              dj_card(3, pages=0, score=None, stock=None)]),
                  2: dj_page([])}

        def fake_fetch(query, page, timeout):
            self.fetches.append((query, page))
            return script[page]
        self.stub_fetch(fake_fetch)
        metas = self.adapter().metadata("水利工程", 12)
        self.assertEqual(len(metas), 3)
        m0, m1, m2 = metas
        self.assertIsInstance(m0, FileMeta)
        self.assertEqual(m0.title, "水利行业深度研报1")   # <em> 剥离
        self.assertEqual(m0.fmt, "pdf")                   # 卡片无格式字段→研报主体 pdf
        self.assertEqual(m1.fmt, "ppt")                   # 标题尾扩展名归一
        self.assertEqual(m0.pages, 28)
        self.assertIsNone(m2.pages)                       # pageTotal=0→如实 None
        self.assertEqual((m0.badge, m0.perm), ("green_free", "green"))  # 题录层免费面
        self.assertEqual(m0.source_url, "https://www.djyanbao.com/report/1001")
        self.assertEqual(m0.extra["doc_id"], 1001)
        self.assertEqual(m0.extra["org"], "某证券研究所")
        self.assertEqual(m0.extra["publish_at"], "2026-10-01")
        self.assertEqual(m0.extra["stock_name"], "水利工程")
        self.assertEqual(m0.extra["report_score"], 88)
        self.assertNotIn("<em>", m0.extra["snippet"])
        self.assertEqual(self.fetches, [("水利工程", 1), ("水利工程", 2)])  # 第2页空才停
        # 审计：每次请求一行，含 count
        self.assertTrue(any(l["channel"] == "djyanbao" and l["event"] == "request"
                            and l["count"] == 3 and l["query"] == "水利工程"
                            for l in self.audit_lines()))

    def test_pagination_stops_on_limit_or_empty(self):
        script = {1: dj_page([dj_card(i) for i in range(10)], total=15),
                  2: dj_page([dj_card(i) for i in range(10, 15)], total=15),
                  3: dj_page([], total=15)}

        def fake(query, page, timeout):
            self.fetches.append(page)
            return script[page]
        self.stub_fetch(fake)
        metas = self.adapter().metadata("水利工程", 14)   # 10+5 命中，够 14 即停
        self.assertEqual(len(metas), 14)
        self.assertEqual(self.fetches, [1, 2])
        metas2 = self.adapter().metadata("水利工程", 20)  # 翻到空页停
        self.assertEqual(len(metas2), 15)
        self.assertEqual(self.fetches, [1, 2, 1, 2, 3])

    def test_retry_once_then_success(self):
        state = {"p1": 0}

        def flaky(query, page, timeout):
            if page == 1:
                state["p1"] += 1
                if state["p1"] == 1:
                    raise TimeoutError("first fail")
                return dj_page([dj_card(1)])
            return dj_page([])
        self.stub_fetch(flaky)
        metas = self.adapter().metadata("水利工程", 12)
        self.assertEqual(len(metas), 1)
        self.assertEqual(state["p1"], 2)  # 首页恰好尝试 2 次（重试 1 次）


# ---------------- 空结果 / 异常降级 ----------------

class TestDjyanbaoDegrade(DjyanbaoTestBase):
    def test_empty_result_returns_empty_list(self):
        self.stub_fetch(lambda q, p, t: dj_page([]))
        self.assertEqual(self.adapter().metadata("不存在的主题词", 12), [])
        self.assertTrue(any(l["event"] == "request" and l["count"] == 0
                            for l in self.audit_lines()))

    def test_error_returns_empty_no_crash(self):
        def boom(query, page, timeout):
            raise OSError("conn reset")
        self.stub_fetch(boom)
        a = self.adapter()
        self.assertEqual(a.metadata("水利工程", 12), [])  # 异常→如实空，不崩溃
        self.assertEqual(a.limiter.status()["consecutive_errors"], 1)
        self.assertTrue(any(l["event"] == "error" and "OSError" in l["detail"]
                            for l in self.audit_lines()))

    def test_code_not_zero_treated_as_error(self):
        self.stub_fetch(lambda q, p, t: {"code": 1001, "message": "param error", "data": None})
        self.assertEqual(self.adapter().metadata("水利工程", 12), [])
        self.assertTrue(any(l["event"] == "error" and "code=1001" in l["detail"]
                            for l in self.audit_lines()))


# ---------------- 频控生效 ----------------

class TestDjyanbaoRateLimit(DjyanbaoTestBase):
    def test_spec_defaults_interval_daily_breaker(self):
        a = DjyanbaoAdapter()  # 默认构造即任务规格（未设环境覆盖时）
        self.assertEqual(a.channel, "djyanbao")
        self.assertEqual(a.limiter.min_interval, 2.0)    # 间隔2s
        self.assertEqual(a.limiter.daily_limit, 500)     # 日上限500
        self.assertEqual(a.limiter.error_threshold, 5)   # 连错5次熔断到日切

    def test_interval_enforced(self):
        clk = fake_clock()
        a = DjyanbaoAdapter(limiter=RateLimiter(min_interval=2.0, clock=clk, sleep=clk.sleep,
                                                today=lambda: "d1"))
        self.stub_fetch(lambda q, p, t: dj_page([dj_card(1)]))
        a.metadata("水利工程", 1)
        t_before = clk.t
        a.metadata("水利工程", 1)  # 第二请求必须 sleep ≥2s
        self.assertGreaterEqual(clk.t - t_before, 2.0)

    def test_daily_cap_trips(self):
        script = {1: dj_page([dj_card(i) for i in range(10)]),
                  2: dj_page([dj_card(i) for i in range(10, 15)])}
        self.stub_fetch(lambda q, p, t: script[p])
        a = self.adapter(daily_limit=1)
        with self.assertRaises(RateLimitExceeded):  # limit=12>10 → 翻第2页超日限
            a.metadata("水利工程", 12)

    def test_consecutive_error_breaker_at_5(self):
        def boom(query, page, timeout):
            raise OSError("conn reset")
        self.stub_fetch(boom)
        a = self.adapter()  # error_threshold=5（默认即任务规格）
        for _ in range(5):
            self.assertEqual(a.metadata("水利工程", 12), [])  # 前5次如实降级不崩
        with self.assertRaises(CircuitOpenError):             # 第6次：熔断已开
            a.metadata("水利工程", 12)
        self.assertFalse(a.available())


# ---------------- 配方形状铁律 ----------------

class TestDjyanbaoRecipeShape(unittest.TestCase):
    """铁律：照抄复刻件勿改端点/参数/头——djyanbao_api.py 段1 匿名检索面。"""

    def test_endpoint_and_params_unchanged(self):
        self.assertEqual(djyanbao_meta._BASE, "https://api.djyanbao.com/api")
        self.assertEqual(
            djyanbao_meta._path("水利工程", 2, 10),
            "/report?page=2&limit=10&q=%E6%B0%B4%E5%88%A9%E5%B7%A5%E7%A8%8B"
            "&sort=publish_at&order=DESC&matchPhrase=false")

    def test_headers_match_replica(self):
        h = djyanbao_meta._headers()
        self.assertEqual(h["client-ver"], "v2.0.14")
        self.assertEqual(h["client-type"], "pc")
        self.assertTrue(h["client-id"])                        # uuid4 一枚
        self.assertEqual(h["Origin"], "https://www.djyanbao.com")
        self.assertEqual(h["Referer"], "https://www.djyanbao.com/")
        self.assertNotIn("Authorization", h)                   # 检索面匿名，零 Bearer

    def test_fmt_normalization_closed_set(self):
        for t, want in [("研报标题", "pdf"), ("a.PDF", "pdf"), ("b.docx", "doc"),
                        ("c.XLS", "xls"), ("d.pptx", "ppt")]:
            self.assertEqual(djyanbao_meta._norm_fmt(t), want)


# ---------------- x5 真翻页（5x 池扩容：limit>10 跨页聚合到 36） ----------------

class TestDjyanbaoX5TruePagination(DjyanbaoTestBase):
    """5x 战役翻页用例（mock 零网络）：api 每页硬限 10 条——limit=36 由
    page=1..4 循环翻页聚合收满，页间频控走既有 RateLimiter 正常间隔，
    短页后终止不野翻；limit≤10 单页路径零漂移。"""

    def test_x5_four_pages_reach_36(self):
        # 两页以上聚合：3 满页+1 页 6 条=36（limit>10 才需要翻页的任务主路径）
        script = {p: dj_page([dj_card((p - 1) * 10 + i) for i in range(10)])
                  for p in (1, 2, 3)}
        script[4] = dj_page([dj_card(30 + i) for i in range(6)])

        def fake(query, page, timeout):
            self.fetches.append(page)
            return script[page]
        self.stub_fetch(fake)
        metas = self.adapter().metadata("水利工程", 36)
        self.assertEqual(len(metas), 36)                   # 36=10+10+10+6 跨页收满
        self.assertEqual(self.fetches, [1, 2, 3, 4])       # page 递增恰四枪
        self.assertEqual(metas[9].extra["doc_id"], 1009)   # 第 1 页末
        self.assertEqual(metas[10].extra["doc_id"], 1010)  # 第 2 页首（页序拼合）
        self.assertEqual(metas[-1].extra["doc_id"], 1035)  # 页序零乱序

    def test_x5_short_page_terminates(self):
        # 短页（4<10）即尾页：聚合全收 14 条后一枪空页确认即止，无第 4 页野翻
        script = {1: dj_page([dj_card(i) for i in range(10)]),
                  2: dj_page([dj_card(100 + i) for i in range(4)])}

        def fake(query, page, timeout):
            self.fetches.append(page)
            return script.get(page, dj_page([]))
        self.stub_fetch(fake)
        metas = self.adapter().metadata("水利工程", 36)
        self.assertEqual(len(metas), 14)                   # 10+4 全收（不弃真数据）
        self.assertEqual(self.fetches, [1, 2, 3])          # 空页确认后停

    def test_x5_page_fetches_respect_rate_limiter_interval(self):
        # 翻页间隔：同一次 metadata 内 3 页=3 额度、页间恰睡 min_interval（假钟零真等）
        clk = fake_clock()
        a = DjyanbaoAdapter(limiter=RateLimiter(min_interval=2.0, clock=clk,
                                                sleep=clk.sleep, today=lambda: "d1"))
        script = {p: dj_page([dj_card((p - 1) * 10 + i) for i in range(10)])
                  for p in (1, 2, 3)}

        def fake(query, page, timeout):
            self.fetches.append(page)
            return script[page]
        self.stub_fetch(fake)
        self.assertEqual(len(a.metadata("水利工程", 30)), 30)
        self.assertAlmostEqual(clk.t, 1000.0 + 2.0 * 2)    # 3 页=2 次页间隔
        self.assertEqual(a.limiter.status()["count_today"], 3)  # 翻页计入正常额度

    def test_x5_limit_le_page_size_single_page_byte_stable(self):
        # limit≤10 单页路径逐字节不变：满页 10 条=恰一枪 page=1，零翻页
        def fake(query, page, timeout):
            self.fetches.append(page)
            return dj_page([dj_card(i) for i in range(10)])
        self.stub_fetch(fake)
        metas = self.adapter().metadata("水利工程", 10)
        self.assertEqual(len(metas), 10)
        self.assertEqual(self.fetches, [1])


# ---------------- 真网络 smoke（默认 skip） ----------------

@pytest.mark.skip(reason="真网络 smoke：默认跳过保底不炸 CI；手动实弹时临时移除本标记")
def test_live_smoke_djyanbao_single_word():
    a = DjyanbaoAdapter(audit=AuditLog())  # 默认频控：间隔2s、日上限500
    assert a.available()
    metas = a.metadata("国际工程", 5)
    assert 1 <= len(metas) <= 5
    assert all(m.title and m.fmt for m in metas)
    assert all(m.source_url and m.source_url.startswith("https://www.djyanbao.com/report/")
               for m in metas)


if __name__ == "__main__":
    unittest.main()
