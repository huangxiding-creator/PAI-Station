# -*- coding: utf-8 -*-
"""W5 doc88 渠道适配器（元数据层）测试 — 离线 mock 契约/降级/频控，零真网络。
对应 DoD/AC（测试名前缀 test_doc88_ 供追溯矩阵引用）：
- 契约：post.do 题录→FileMeta（fmt 归一/title 清洗/perm=green 题录/source_url=详情页/
  extra.doc_id + intro≤200字）；免费文字层只进 extra，不落盘不下载
- 降级：网络错/WAF/空页/日上限/连续错误熔断 → 部分或 [] 返回（绝不崩溃）
- 频控：默认间隔3s+日上限300；env 覆盖；翻页间隔睡眠；审计一行一请求（零造假）
- x5 真翻页用例（5x 池扩容）：limit=36 跨 4 页聚合/短页终止/limit≤9 单页零漂移
真网络 smoke 一律 skip（KB_DOC88_LIVE=1 手动启用，保底不炸 CI）。
"""
import json
import os
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[3]))  # 仓库根入 sys.path

from kb_factory.channel_adapters.base import AuditLog, FileMeta, RateLimiter
from kb_factory.channel_adapters import doc88_meta


def fake_clock():
    class FakeClock:
        def __init__(self):
            self.t = 1000.0

        def __call__(self):
            return self.t

        def sleep(self, d):
            self.t += d
    return FakeClock()


def tmp_audit():
    fd, path = tempfile.mkstemp(suffix=".jsonl")
    os.close(fd)
    return AuditLog(path), path


_INTRO = "/2017/05/05/6562828517966.xml.gz"
_INTRO2 = "/2018/01/02/2345678900123.xml.gz"


def item_html(doc_id, title, fmt="PDF", pages=36, views=1200, date="2020-01-15",
              intropath=_INTRO):
    """单条题录 HTML（形态照 replica 实测：sd-title 锚点+type 图标+字段行+intropath）。"""
    ip = f'<span intropath="{intropath}"></span>' if intropath else ""
    return (f'<div class="sd-list-con">'
            f'<a href="https://www.doc88.com/p-{doc_id}.html" target="_blank" '
            f'class="sd-title" title="{title}">x</a>'
            f'<img class="type" src="/resources/images/type/{fmt}.png">'
            f'<p class="sd-intro">上传时间：{date} | 页数：{pages} | 格式：{fmt} '
            f'| 浏览： {views}</p>{ip}</div>')


def page_html(items, total="12,179,090", frm=1, to=9):
    return (f'<span id="pageResult" style="display:none">约有{total}篇,'
            f'以下是第{frm}-{to}篇</span>' + "".join(items))


class ScriptedFetch:
    """离线 mock：按页脚本回 HTML/抛异常；intro 按 intropath 回文本/抛异常。"""

    def __init__(self, pages, intros=None):
        self.pages, self.intros = list(pages), intros or {}
        self.search_calls, self.intro_calls = [], []

    def search(self, word, page, timeout):
        self.search_calls.append((word, page))
        v = self.pages[page - 1] if page - 1 < len(self.pages) else ""
        if isinstance(v, Exception):
            raise v
        return v

    def intro(self, intropath, timeout):
        self.intro_calls.append(intropath)
        v = self.intros.get(intropath, "")
        if isinstance(v, Exception):
            raise v
        return v


class Doc88MetaTest(unittest.TestCase):
    def setUp(self):
        self._f, self._i = doc88_meta._fetch, doc88_meta._intro_fetch
        self.fc = fake_clock()
        self.rec = None

    def tearDown(self):
        doc88_meta._fetch, doc88_meta._intro_fetch = self._f, self._i

    def limiter(self, **kw):
        kw.setdefault("min_interval", 3.0)   # 默认间隔3s（可单测覆盖）
        kw.setdefault("daily_limit", 300)    # 默认日上限300（可单测覆盖）
        return RateLimiter(clock=self.fc, sleep=self.fc.sleep, name="doc88", **kw)

    def adapter(self, limiter=None, **kw):
        kw.setdefault("retries", 0)   # 单测默认零重试（降级路径确定性）
        return doc88_meta.Doc88Adapter(limiter=limiter or self.limiter(), **kw)

    def mount(self, pages, intros=None):
        self.rec = ScriptedFetch(pages, intros)
        doc88_meta._fetch = self.rec.search
        doc88_meta._intro_fetch = self.rec.intro
        return self.rec

    def test_doc88_contract_green_records(self):
        self.mount([page_html([
            item_html("123456789", "国际工程EPC合同管理实务", "PDF", 36, 1200),
            item_html("234567890", "海外EPC项目风险管理", "DOC", 58, 980,
                      intropath=_INTRO2),
        ])], intros={_INTRO: "国际工程EPC合同管理实务摘要正文，" * 10,
                     _INTRO2: "海外EPC项目风险摘要。"})
        a = self.adapter()
        metas = a.metadata("国际工程EPC", 12)
        self.assertEqual(a.channel, "doc88")
        self.assertIsInstance(metas, list)
        self.assertEqual(len(metas), 2)
        self.assertTrue(all(isinstance(m, FileMeta) for m in metas))
        m0, m1 = metas
        self.assertEqual((m0.fmt, m1.fmt), ("pdf", "doc"))
        self.assertTrue(all(m.perm == "green" and m.badge == "green_free" for m in metas))
        self.assertEqual(m0.source_url, "https://www.doc88.com/p-123456789.html")
        self.assertEqual(m0.pages, 36)
        self.assertEqual(m0.extra["doc_id"], "123456789")
        self.assertEqual(m0.extra["views"], 1200)
        self.assertEqual(m0.extra["upload_date"], "2020-01-15")
        self.assertEqual(m0.extra["total_str"], "12,179,090")
        self.assertEqual(m0.extra["intro"], "国际工程EPC合同管理实务摘要正文，" * 10)
        self.assertEqual(m1.extra["intro"], "海外EPC项目风险摘要。")
        self.assertEqual(self.rec.intro_calls, [_INTRO, _INTRO2])

    def test_doc88_fmt_norm_and_title_cleaning(self):
        rec = self.mount([page_html([
            item_html("111222333", "  A&amp;B水利工程研究  ", "VSD", 9, 5, intropath=None)])])
        m = self.adapter().metadata("水利工程", 5)[0]
        self.assertEqual(m.title, "A&B水利工程研究")      # 反转义+去首尾空白
        self.assertEqual(m.fmt, "bin")                    # 未知格式归一 bin
        self.assertEqual(m.extra["fmt_raw"], "VSD")       # 站方原话留档 extra
        self.assertIsNone(m.extra["intropath"])           # 无摘要件如实 None
        self.assertEqual(rec.intro_calls, [])             # 无 intropath 不拉文字层

    def test_doc88_pagination_limit_and_interval(self):
        self.mount([page_html([item_html("100000001", "一页第一条"),
                               item_html("100000002", "一页第二条")]),
                    page_html([item_html("100000003", "二页第一条")],
                              total="18,942,210", frm=10, to=10)], intros={})
        a = self.adapter(intro_max=0)
        metas = a.metadata("EPC", 3)
        self.assertEqual([m.extra["doc_id"] for m in metas],
                         ["100000001", "100000002", "100000003"])
        self.assertEqual(self.rec.search_calls, [("EPC", 1), ("EPC", 2)])
        self.assertIsNone(metas[2].extra["total_str"])    # 第2页起不带总数
        self.assertEqual(a.limiter.status()["count_today"], 2)
        self.assertAlmostEqual(self.fc.t, 1003.0)         # 翻页间隔 3s 实睡（假钟）

    def test_doc88_limit_truncates(self):
        self.mount([page_html([item_html("10000000%d" % i, "条目%d" % i)
                               for i in (1, 2, 3)])], intros={})
        self.assertEqual(len(self.adapter(intro_max=0).metadata("x", 2)), 2)

    def test_doc88_degrade_network_error(self):
        self.mount([OSError("boom")])
        a = self.adapter()
        self.assertEqual(a.metadata("x", 12), [])          # 不可用→[]（不崩溃）
        self.assertEqual(a.limiter.status()["consecutive_errors"], 1)
        self.assertIn("OSError", a.reason())

    def test_doc88_degrade_waf(self):
        self.mount([doc88_meta.Doc88WAFWall("search 命中 WAF 特征字")])
        a = self.adapter()
        self.assertEqual(a.metadata("x", 12), [])          # 报墙如实降级 []
        self.assertIn("WAF", a.reason())

    def test_doc88_degrade_empty_page(self):
        self.mount(["<div>foo</div>"])                     # 无题录块=空页
        a = self.adapter()
        self.assertEqual(a.metadata("x", 12), [])
        self.assertEqual(a.limiter.status()["consecutive_errors"], 0)  # 空页非错误

    def test_doc88_circuit_open_never_crashes(self):
        self.mount([OSError("down")])
        a = self.adapter(limiter=self.limiter(error_threshold=2))
        self.assertEqual(a.metadata("x", 12), [])          # 连错1
        self.assertEqual(a.metadata("x", 12), [])          # 连错2→熔断开启
        self.assertTrue(a.limiter.status()["circuit_open"])
        self.assertEqual(a.metadata("x", 12), [])          # 熔断态仍 [] 不崩溃

    def test_doc88_daily_limit_degrades_partial(self):
        self.mount([page_html([item_html("100000001", "一"), item_html("100000002", "二")]),
                    page_html([item_html("100000003", "三")])], intros={})
        a = self.adapter(limiter=self.limiter(daily_limit=1), intro_max=0)
        metas = a.metadata("x", 5)                         # 第2页取额度→日上限熔断
        self.assertEqual([m.extra["doc_id"] for m in metas],
                         ["100000001", "100000002"])       # 已取得部分照实返回
        self.assertIn("RateLimitExceeded", a.reason())
        self.assertFalse(a.available())
        self.assertEqual(a.metadata("x", 5), [])           # 同日后续直接 []

    def test_doc88_defaults_and_env_override(self):
        a = doc88_meta.Doc88Adapter()                     # 默认构造零网络零请求
        self.assertEqual((a.limiter.min_interval, a.limiter.daily_limit), (3.0, 300))
        env = {"KB_DOC88_MIN_INTERVAL": "0.5", "KB_DOC88_DAILY_LIMIT": "7",
               "KB_DOC88_INTRO_MAX": "0"}
        for k, v in env.items():
            os.environ[k] = v
        try:
            b = doc88_meta.Doc88Adapter()
            self.assertEqual((b.limiter.min_interval, b.limiter.daily_limit), (0.5, 7))
            self.assertEqual(b.intro_max, 0)
        finally:
            for k in env:
                os.environ.pop(k, None)

    def test_doc88_audit_one_line_per_request(self):
        self.mount([page_html([item_html("123456789", "国际工程EPC研究", "PDF")])],
                   intros={_INTRO: "摘要正文" * 30})
        audit, path = tmp_audit()
        try:
            a = self.adapter(audit=audit)
            metas = a.metadata("国际工程EPC", 5)
            self.assertEqual(len(metas), 1)
            self.assertLessEqual(len(metas[0].extra["intro"]), 200)
            rows = [json.loads(line) for line in open(path, encoding="utf-8")]
            self.assertEqual([r["event"] for r in rows], ["request", "request", "intro"])  # 第2页空页亦如实一行
            self.assertTrue(all(r["channel"] == "doc88" and "ts" in r for r in rows))
            self.assertEqual(rows[0]["query"], "国际工程EPC")
            self.assertEqual(rows[0]["count"], 1)
            self.assertEqual(rows[0]["detail"], "page=1")
            self.assertIsInstance(rows[0]["elapsed_ms"], int)   # 零造假：实测毫秒
        finally:
            os.unlink(path)

    def test_doc88_intro_truncated_to_200(self):
        long_intro = "国际工程EPC全生命周期管理实务摘要。" * 40     # 680字站方摘要
        self.mount([page_html([item_html("123456789", "长摘要件")])],
                   intros={_INTRO: long_intro})
        m = self.adapter().metadata("x", 5)[0]
        self.assertEqual(len(m.extra["intro"]), 200)
        self.assertEqual(m.extra["intro"], long_intro[:200])

    def test_doc88_intro_error_degrades_to_none(self):
        self.mount([page_html([item_html("123456789", "件A")])],
                   intros={_INTRO: OSError("intro net down")})
        a = self.adapter()
        m = a.metadata("x", 5)[0]
        self.assertNotIn("intro", m.extra)                # 文字层失败不污染题录
        self.assertEqual(a.limiter.status()["consecutive_errors"], 1)
        self.assertIn("OSError", a.reason())

    def test_doc88_metadata_layer_only_no_download(self):
        src = Path(doc88_meta.__file__).read_text(encoding="utf-8")
        for banned in ("p_download", "write_text", "subprocess", "requests", "Path("):
            self.assertNotIn(banned, src)                 # 站铁律：免费层只取元数据

    @unittest.skip("真网络 smoke 默认跳过：KB_DOC88_LIVE=1 后 pytest -k doc88_live 手跑")
    def test_doc88_live_smoke(self):
        if not os.environ.get("KB_DOC88_LIVE"):
            self.skipTest("KB_DOC88_LIVE 未设置")
        a = doc88_meta.Doc88Adapter()
        metas = a.metadata("国际工程EPC", 6)
        self.assertGreater(len(metas), 0)
        self.assertTrue(all(isinstance(m, FileMeta) for m in metas))


# ---------------- x5 真翻页（5x 池扩容：limit>9 跨页聚合到 36） ----------------

class Doc88X5PaginationTest(unittest.TestCase):
    """5x 战役翻页用例（mock 零网络）：post.do 每页 9 条题录——limit=36 由
    p=1..4 循环翻页聚合收满，页间频控走既有 RateLimiter 正常间隔，
    短页后终止不野翻；limit≤9 单页路径零漂移。"""

    def setUp(self):
        self._f, self._i = doc88_meta._fetch, doc88_meta._intro_fetch
        self.fc = fake_clock()
        self.rec = None

    def tearDown(self):
        doc88_meta._fetch, doc88_meta._intro_fetch = self._f, self._i

    def limiter(self, **kw):
        kw.setdefault("min_interval", 3.0)   # 默认间隔3s（可单测覆盖）
        kw.setdefault("daily_limit", 300)
        return RateLimiter(clock=self.fc, sleep=self.fc.sleep, name="doc88-x5", **kw)

    def adapter(self, **kw):
        kw.setdefault("retries", 0)          # 单测零重试（确定性）
        return doc88_meta.Doc88Adapter(limiter=self.limiter(), **kw)

    def mount(self, pages):
        self.rec = ScriptedFetch(pages, intros={})
        doc88_meta._fetch = self.rec.search
        doc88_meta._intro_fetch = self.rec.intro
        return self.rec

    @staticmethod
    def _full_page(p):
        """第 p 满页（9 条题录，doc_id=p*9+0..8 保证跨页零撞号）。"""
        return page_html([item_html("%09d" % (p * 9 + i), "翻页件%d-%d" % (p, i))
                          for i in range(9)])

    def test_doc88_x5_four_pages_reach_36_with_interval(self):
        # 两页以上聚合：4 满页×9=36（limit>9 才需要翻页的任务主路径）+页间 3s 频控
        self.mount([self._full_page(p) for p in range(4)])
        a = self.adapter(intro_max=0)
        metas = a.metadata("国际EPC", 36)
        self.assertEqual(len(metas), 36)                        # 36=4×9 跨页收满
        self.assertEqual([c[1] for c in self.rec.search_calls], [1, 2, 3, 4])
        self.assertEqual(metas[8].extra["doc_id"], "000000008")  # 第 1 页末
        self.assertEqual(metas[9].extra["doc_id"], "000000009")  # 第 2 页首（页序拼合）
        self.assertEqual(metas[-1].extra["doc_id"], "000000035")
        self.assertAlmostEqual(self.fc.t, 1000.0 + 3.0 * 3)     # 4 页=3 次页间隔
        self.assertEqual(a.limiter.status()["count_today"], 4)  # 翻页计入正常额度

    def test_doc88_x5_short_page_terminates(self):
        # 短页（4<9）即尾页：聚合全收 13 条后一枪空页确认即止，无野翻
        pages = [self._full_page(0),
                 page_html([item_html("90000000%d" % i, "尾页件%d" % i)
                            for i in range(4)])]
        self.mount(pages)
        metas = self.adapter(intro_max=0).metadata("国际EPC", 36)
        self.assertEqual(len(metas), 13)                        # 9+4 全收（不弃真数据）
        self.assertEqual([c[1] for c in self.rec.search_calls], [1, 2, 3])

    def test_doc88_x5_limit_le_page_size_single_page_byte_stable(self):
        # limit≤9 单页路径逐字节不变：满页 9 条=恰一枪 p=1，零翻页
        self.mount([self._full_page(0)])
        metas = self.adapter(intro_max=0).metadata("国际EPC", 9)
        self.assertEqual(len(metas), 9)
        self.assertEqual([c[1] for c in self.rec.search_calls], [1])


if __name__ == "__main__":
    unittest.main()
