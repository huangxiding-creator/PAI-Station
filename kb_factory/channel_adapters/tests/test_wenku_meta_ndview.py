# -*- coding: utf-8 -*-
"""wenku_meta ndview 侧门元数据增强测试（离线 mock，零真网络）。

DoD 对应：
  - 补强字段：pages 缺(无/0)则补 ndview 权威总页数；增强项进 extra['ndview']（白名单
    _NDVIEW_KEYS 12 键；2.0 A1 目录层扩至 14 键：+tags/category，候选键防御性扫描
    见 wenku_taxonomy.py）；下载道字段（htmlUrls 载荷/rsign/md5sum/storeId/bucketNum/
    rtcsRangeInfo）零泄漏（铁律守门）；17 字段卡未消费 4 项（copyable/createTime/
    tagList/cover）进 extra。
  - 失败回退：网络异常 / 200 无 pageData / 子配额日上限尽 / 连续错误熔断 → 一律退回
    现状（syncmrecall 原字段原样，绝不崩溃）。
  - 子配额：独立 RateLimiter（间隔1s/日800 缺省，env KB_WENKU_NDVIEW_MIN_INTERVAL/
    KB_WENKU_NDVIEW_DAILY_LIMIT 可配）；增强默认关（KB_WENKU_NDVIEW=1/ndview=True 开）
    ——默认关是离线测试零网络纪律（真网络冒烟归 tests/test_live_smoke.py 的 KB_LIVE 门，
    本文件零真网络用例，CI 保底不炸）。
"""
import json
import os
import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[3]))  # 仓库根入 sys.path

from kb_factory.channel_adapters.base import AuditLog, FileMeta, RateLimiter
from kb_factory.channel_adapters import wenku_meta

DOC_A = "752032e54293daef5ef7ba0d4a7302768e996ff0"  # 40 hex（T18 现场校准 docId 形态）
DOC_B = "9c58877bceaedd3383c4bb4cf7ec4afe04a1b1a6"
DOC_C = "6657e2beb84cf7ec4afe04a1b0717fd5360cb28e"
# 下载道字段样本值（真形态照录 T26 probe fixture）——用于断言零泄漏
_BOS_URL = "https://wkbjcloudbos.bdimg.com/v1/docconvert1946/wk/store/pipe?p=1"


def tmp_audit():
    import tempfile
    fd, path = tempfile.mkstemp(suffix=".jsonl")
    os.close(fd)
    return AuditLog(path), path


def wenku_item(doc_id, i=1, file_type=2, sell=1, title=None, pages=10, card=False):
    d = {"data": {"docID": doc_id, "url": f"https://wenku.baidu.com/view/{doc_id}.html",
                  "title": title or f"<em>水利</em>工程文件{i}", "fileType": file_type,
                  "pageNum": pages, "sellType": sell, "viewCount": i, "downloadCount": 0,
                  "qualityScore": 3.5, "content": "摘要"}}
    if card:  # 17 字段卡的未消费 4 项
        d["data"].update({"copyable": True, "createTime": 1775854981,
                          "tagList": ["EPC", "总承包"],
                          "cover": "https://wkimg.bdimg.com/img/cover1"})
    return d


def wenku_page(items):
    return {"data": {"items": {"PCSearch": {"result": {"items": items,
                                                       "extra": {"total": 223286}}}}}}


def reader_info(doc_id=DOC_A, page=32, show=2, html_urls="type3"):
    """合成 readerInfo（真形态照录 T26 probe fixture，含下载道字段——测零泄漏用）。"""
    if html_urls == "type3":
        hu = {"json": [{"pageIndex": 1, "pageLoadUrl": _BOS_URL}], "png": [], "ttf": []}
    elif html_urls == "type2":
        hu = [f"https://wkbitmap.bdimg.com/thumbnails/{doc_id}?pn=1&s=1&r=0.1"]
    else:
        hu = None
    ri = {"docId": doc_id, "page": page, "originalPage": page, "freePage": show,
          "showPage": show, "tplKey": "html_view", "tplName": "xreader",
          "pageInfo": {"pageWidth": "892.979", "pageHeight": "1262.879"},
          "copyUnlimited": False, "readPagePwa": {"canFreeDown": False},
          "rsign": "fake-rsign", "md5sum": "&md5sum=fake&sign=fake&rtcs_flag=2",
          "storeId": "6f646efbc950ad02de80d4d8d15abe23492f0327", "bucketNum": "fake-bn",
          "rtcsRangeInfo": []}
    if hu is not None:
        ri["htmlUrls"] = hu
    return ri


class NdviewBase(unittest.TestCase):
    def setUp(self):
        self.audit, self.audit_path = tmp_audit()

    def tearDown(self):
        os.unlink(self.audit_path)

    def adapter(self, ndview=True, daily_limit=800, ndview_daily_limit=None,
                error_threshold=5):
        lim = RateLimiter(min_interval=0, daily_limit=daily_limit,
                          error_threshold=error_threshold, today=lambda: "d1")
        ndl = RateLimiter(min_interval=0,
                          daily_limit=daily_limit if ndview_daily_limit is None
                          else ndview_daily_limit,
                          error_threshold=error_threshold, today=lambda: "d1")
        return wenku_meta.WenkuMetaAdapter(limiter=lim, audit=self.audit,
                                           ndview=ndview, ndview_limiter=ndl)

    def patch_search(self, items):
        def fake_fetch(query, pn, timeout):
            return wenku_page(items) if pn == 1 else wenku_page([])
        wenku_meta._fetch = fake_fetch
        self.addCleanup(setattr, wenku_meta, "_fetch", wenku_meta._urllib_fetch)

    def patch_ndview_map(self, mapping):
        """docId→readerInfo dict / Exception（抛）/ None（200 无 pageData）；返回调用账。"""
        calls = []

        def fake(doc_id, timeout):
            calls.append(doc_id)
            v = mapping.get(doc_id)
            if isinstance(v, Exception):
                raise v
            return v
        wenku_meta._ndview_fetch = fake
        self.addCleanup(setattr, wenku_meta, "_ndview_fetch",
                        wenku_meta._ndview_urllib_fetch)
        return calls

    def ndview_audit(self, event=""):
        lines = [json.loads(l) for l in open(self.audit_path, encoding="utf-8") if l.strip()]
        return [l for l in lines if l.get("channel") == "wenku"
                and l.get("event", "").startswith(event)]


# ---------------- 默认关 / 开关与子配额缺省 ----------------

class TestNdviewSwitchAndQuota(NdviewBase):
    def test_ndview_off_by_default_zero_ndview_calls(self):
        """默认关（离线零网络纪律）：不发任何 ndview 请求，FileMeta 形状与升级前一致。"""
        self.patch_search([wenku_item(DOC_A), wenku_item(DOC_B)])
        boom_calls = []

        def boom(doc_id, timeout):
            boom_calls.append(doc_id)
            raise AssertionError("默认关却被调 ndview 网络腿")
        wenku_meta._ndview_fetch = boom
        self.addCleanup(setattr, wenku_meta, "_ndview_fetch",
                        wenku_meta._ndview_urllib_fetch)
        # 注意：不带 ndview_limiter 构造（注入限流器即=显式开启，构造规则如此）
        a = wenku_meta.WenkuMetaAdapter(
            limiter=RateLimiter(min_interval=0, today=lambda: "d1"), audit=self.audit)
        a2 = wenku_meta.WenkuMetaAdapter(audit=self.audit)  # 纯默认构造
        for ad in (a, a2):
            self.assertFalse(ad.ndview)
            self.assertIsNone(ad.ndview_limiter)
        metas = a.metadata("水利工程", 12)
        self.assertEqual(len(metas), 2)
        self.assertTrue(all("ndview" not in m.extra for m in metas))
        self.assertEqual(boom_calls, [])

    def test_ndview_env_and_default_limiter_config(self):
        """KB_WENKU_NDVIEW=1 开；子配额缺省=间隔1s/日800（env 可配）——只构造不发请求。"""
        for k, v in (("KB_WENKU_NDVIEW", "1"),
                     ("KB_WENKU_NDVIEW_MIN_INTERVAL", "2"),
                     ("KB_WENKU_NDVIEW_DAILY_LIMIT", "900")):
            os.environ[k] = v
            self.addCleanup(os.environ.pop, k, None)
        a = wenku_meta.WenkuMetaAdapter(audit=self.audit)
        self.assertTrue(a.ndview)
        st = a.ndview_limiter.status()
        self.assertEqual((st["name"], st["min_interval"], st["daily_limit"]),
                         ("wenku_ndview", 2.0, 900))


# ---------------- 补强字段（主径） ----------------

class TestNdviewEnrich(NdviewBase):
    def test_ndview_enriches_pages_and_extra_whitelist(self):
        """pages 缺(0)则补权威总页数、已有(7)不动（ndview 值进 extra 可对账）；
        增强项 ⊆ 白名单 12 键；下载道字段零泄漏；原字段一律不动。"""
        self.patch_search([wenku_item(DOC_A, 1, pages=0), wenku_item(DOC_B, 2, pages=7)])
        calls = self.patch_ndview_map({DOC_A: reader_info(DOC_A, page=32, show=2),
                                       DOC_B: reader_info(DOC_B, page=32, show=32)})
        metas = self.adapter().metadata("水利工程", 12)
        self.assertEqual(calls, [DOC_A, DOC_B])
        m0, m1 = metas
        self.assertEqual(m0.pages, 32)   # 搜索 pageNum=0（缺）→ ndview 补
        self.assertEqual(m1.pages, 7)    # 搜索已有 → 不覆盖
        nd = m0.extra["ndview"]
        self.assertLessEqual(set(nd), wenku_meta._NDVIEW_KEYS)
        self.assertEqual((nd["page"], nd["show_page"], nd["preview_full"]),
                         (32, 2, False))
        self.assertEqual((nd["kind"], nd["tpl_key"], nd["tpl_name"]),
                         ("type3", "html_view", "xreader"))
        self.assertEqual((nd["page_width_px"], nd["page_height_px"]),
                         (892.979, 1262.879))
        self.assertEqual((nd["copy_unlimited"], nd["can_free_down"]), (False, False))
        self.assertTrue(m1.extra["ndview"]["preview_full"])  # show 32>=page 32
        # 铁律守门：下载道字段零泄漏（含嵌套 JSON 串）
        blob = json.dumps([m.extra for m in metas], ensure_ascii=False)
        for forbidden in ("pageLoadUrl", "rsign", "md5sum", "storeId", "bucketNum",
                          "rtcsRangeInfo", "htmlUrls", "wkbjcloudbos"):
            self.assertNotIn(forbidden, blob)
        # 原字段不动（fail-soft 契约的另一面：成功也不越权改写）
        self.assertEqual(m0.title, "水利工程文件1")
        self.assertEqual((m0.fmt, m0.badge, m0.perm), ("pdf", "green_free", "green"))
        self.assertTrue(m0.source_url.endswith(f"/view/{DOC_A}.html"))
        self.assertEqual(m0.extra["doc_id"], DOC_A)
        # 审计：每请求一行（ndview 成功 2 行 count=1）
        ok_lines = self.ndview_audit("ndview")
        self.assertEqual([l["event"] for l in ok_lines], ["ndview", "ndview"])
        self.assertTrue(all(l["count"] == 1 for l in ok_lines))

    def test_card_fields_now_in_extra(self):
        """17 字段卡未消费 4 项（copyable/createTime/tags/cover）进 extra（零额外请求）。"""
        self.patch_search([wenku_item(DOC_A, 1, card=True)])
        self.patch_ndview_map({DOC_A: reader_info(DOC_A)})
        metas = self.adapter().metadata("水利工程", 12)
        e = metas[0].extra
        self.assertEqual((e["copyable"], e["create_time"]), (True, 1775854981))
        self.assertEqual(e["tags"], ["EPC", "总承包"])
        self.assertEqual(e["cover"], "https://wkimg.bdimg.com/img/cover1")

    def test_ndview_duplicate_docid_single_fetch(self):
        """重复 docId 复用同次结果（不二发，省子配额）；搜索已有 pages(10) 不覆盖，
        ndview 权威页数(5) 在 extra 可对账（fill-only-missing 语义）。"""
        self.patch_search([wenku_item(DOC_A, 1), wenku_item(DOC_A, 2)])
        calls = self.patch_ndview_map({DOC_A: reader_info(DOC_A, page=5, show=5)})
        metas = self.adapter().metadata("水利工程", 12)
        self.assertEqual(calls, [DOC_A])
        self.assertEqual(metas[0].pages, 10)  # 搜索 pageNum=10 已有 → 不覆盖
        self.assertEqual(metas[0].extra["ndview"]["page"], 5)
        self.assertEqual(metas[1].extra["ndview"]["page"], 5)

    def test_ndview_bad_docid_shape_skipped_without_fetch(self):
        """docId 形态不合（如假 id 'doc0001'）→ 如实跳过，不发请求不硬凑。"""
        self.patch_search([wenku_item("doc0001", 1), wenku_item(DOC_A, 2)])
        calls = self.patch_ndview_map({DOC_A: reader_info(DOC_A)})
        metas = self.adapter().metadata("水利工程", 12)
        self.assertEqual(calls, [DOC_A])
        self.assertNotIn("ndview", metas[0].extra)
        self.assertIn("ndview", metas[1].extra)


# ---------------- 失败回退（fail-soft） ----------------

class TestNdviewFailSoft(NdviewBase):
    def assert_syncmrecall_shape(self, metas):
        """退回现状：无 ndview 键、pages/原字段=syncmrecall 原样。"""
        self.assertTrue(metas)
        for m in metas:
            self.assertNotIn("ndview", m.extra)
            self.assertIn(m.extra["doc_id"], (DOC_A, DOC_B, DOC_C))
            self.assertIsInstance(m.title, str) and self.assertTrue(m.title)

    def test_ndview_network_error_falls_back(self):
        self.patch_search([wenku_item(DOC_A, 1), wenku_item(DOC_B, 2)])
        self.patch_ndview_map({DOC_A: OSError("conn reset"), DOC_B: OSError("timeout")})
        metas = self.adapter().metadata("水利工程", 12)  # 不崩溃
        self.assertEqual(len(metas), 2)
        self.assert_syncmrecall_shape(metas)
        err = self.ndview_audit("ndview_error")
        self.assertEqual(len(err), 2)
        self.assertTrue(all(l["count"] == 0 for l in err))

    def test_ndview_no_readerinfo_falls_back(self):
        """200 但挖不出 pageData（WAF/删件同路）→ 同路回退。"""
        self.patch_search([wenku_item(DOC_A, 1), wenku_item(DOC_B, 2)])
        self.patch_ndview_map({DOC_A: None, DOC_B: None})
        metas = self.adapter().metadata("水利工程", 12)
        self.assertEqual(len(metas), 2)
        self.assert_syncmrecall_shape(metas)
        self.assertEqual(len(self.ndview_audit("ndview_error")), 2)

    def test_ndview_daily_limit_degrades_soft(self):
        """子配额日上限尽 → 已补强的保留、余下整批退回现状（ndview_degrade 一行即停）。"""
        self.patch_search([wenku_item(DOC_A, 1), wenku_item(DOC_B, 2)])
        self.patch_ndview_map({DOC_A: reader_info(DOC_A, page=3, show=3),
                               DOC_B: reader_info(DOC_B, page=4, show=4)})
        metas = self.adapter(ndview_daily_limit=1).metadata("水利工程", 12)
        self.assertEqual(len(metas), 2)                 # 结果条数不受影响
        self.assertEqual(metas[0].pages, 10)            # 搜索已有页数原样（fill-only-missing）
        self.assertEqual(metas[0].extra["ndview"]["page"], 3)  # 第 1 条已补强保留
        self.assertNotIn("ndview", metas[1].extra)      # 第 2 条退回现状
        deg = self.ndview_audit("ndview_degrade")
        self.assertEqual(len(deg), 1)
        self.assertIn("RateLimitExceeded", deg[0]["detail"])

    def test_ndview_circuit_breaker_stops_batch(self):
        """连续错误熔断（阈值2）：第3条 acquire 即抛 → degrade 停批，不崩溃。"""
        self.patch_search([wenku_item(DOC_A, 1), wenku_item(DOC_B, 2),
                           wenku_item(DOC_C, 3)])
        calls = self.patch_ndview_map({DOC_A: OSError("e1"), DOC_B: OSError("e2"),
                                       DOC_C: OSError("e3")})
        a = self.adapter(error_threshold=2)
        metas = a.metadata("水利工程", 12)
        self.assertEqual(len(metas), 3)
        self.assert_syncmrecall_shape(metas)
        self.assertEqual(calls, [DOC_A, DOC_B])         # 第 3 条不再发
        self.assertTrue(a.ndview_limiter.status()["circuit_open"])
        deg = self.ndview_audit("ndview_degrade")
        self.assertEqual(len(deg), 1)
        self.assertIn("CircuitOpenError", deg[0]["detail"])


# ---------------- 纯函数（离线直测） ----------------

class TestNdviewPureHelpers(unittest.TestCase):
    def test_extract_pagedata_brace_and_quote_aware(self):
        html = "<script>\nvar pageData = " + json.dumps(
            {"title": "a{b}c", "readerInfo": {"page": 3, "note": "quote\"inside"}},
            ensure_ascii=False) + ";\n</script>"
        pd = wenku_meta._extract_pagedata(html)
        self.assertEqual(pd["title"], "a{b}c")
        self.assertEqual(pd["readerInfo"]["page"], 3)
        self.assertIsNone(wenku_meta._extract_pagedata("<html>no anchor</html>"))

    def test_ndview_extra_kind_priority_and_absence(self):
        self.assertEqual(wenku_meta._judge_kind({"htmlUrls": {"json": [{"pageIndex": 1}]}}),
                         "type3")
        self.assertEqual(wenku_meta._judge_kind({"htmlUrls": ["u"]}), "type2")
        self.assertEqual(wenku_meta._judge_kind({"rtcsRangeInfo": [{"page": 1}]}), "type1")
        self.assertEqual(wenku_meta._judge_kind({}), "unknown")
        nd = wenku_meta._ndview_extra({})               # 全缺席 → 无造假键
        self.assertEqual(nd, {"kind": "unknown"})
        nd2 = wenku_meta._ndview_extra(reader_info(DOC_A, page=16, show=2,
                                                   html_urls="type2"))
        self.assertEqual(nd2["kind"], "type2")
        self.assertIn("preview_full", nd2)
        self.assertFalse(nd2["preview_full"])
        self.assertNotIn("preview_full", wenku_meta._ndview_extra({"showPage": 2}))

    def test_ndview_extra_whitelist_no_download_leak(self):
        nd = wenku_meta._ndview_extra(reader_info(DOC_A))
        self.assertLessEqual(set(nd), wenku_meta._NDVIEW_KEYS)
        blob = json.dumps(nd, ensure_ascii=False)
        for forbidden in ("pageLoadUrl", "rsign", "md5sum", "storeId", "bucketNum",
                          "rtcsRangeInfo", "htmlUrls"):
            self.assertNotIn(forbidden, blob)

    def test_merge_ndview_pages_fill_only_when_missing(self):
        """_merge_ndview 就地改写（返回 None）：None/0 → 补；已有 → 不动、extra 可对账。"""
        m1 = FileMeta(title="t", fmt="pdf")
        wenku_meta._merge_ndview(m1, reader_info(DOC_A, page=32, show=2))
        self.assertEqual(m1.pages, 32)                   # pages=None → 补
        m2 = FileMeta(title="t", fmt="pdf", pages=0)
        wenku_meta._merge_ndview(m2, reader_info(DOC_A, page=32, show=2))
        self.assertEqual(m2.pages, 32)                   # pages=0（缺）→ 补
        m3 = FileMeta(title="t", fmt="pdf", pages=7)
        wenku_meta._merge_ndview(m3, reader_info(DOC_A, page=32, show=2))
        self.assertEqual(m3.pages, 7)                    # 已有 → 不动，extra 可对账
        self.assertEqual(m3.extra["ndview"]["page"], 32)

    def test_ndview_recipe_pins(self):
        """配方钉：端点模板/请求头同源自洽指纹（Chrome129+Windows+Not_A Brand，T41 P0-1 口径）。"""
        self.assertEqual(wenku_meta._NDVIEW_TMPL.format(doc_id=DOC_A),
                         f"https://wenku.baidu.com/ndview/{DOC_A}.html")
        h = wenku_meta._NDVIEW_HEADERS
        self.assertIn("Chrome/129", h["User-Agent"])
        self.assertIn('Chrome";v="129"', h["Sec-Ch-Ua"])
        self.assertIn("Not_A Brand", h["Sec-Ch-Ua"])
        self.assertEqual(h["Sec-Ch-Ua-Platform"], '"Windows"')
        self.assertEqual(h["Sec-Ch-Ua-Mobile"], "?0")
        self.assertEqual(h["Referer"], "https://wenku.baidu.com/")


# ---------------- 2.0 A1 目录层：tags/类目进 extra（wenku_taxonomy 接线） ----------------

from kb_factory.channel_adapters import wenku_taxonomy  # noqa: E402 （置后导入=被测件单列）


class TestNdviewTaxonomy(unittest.TestCase):
    """目录层情报（与 dangdang toc_lines 同位）：候选键防御性扫描——命中即透传、
    缺席/空值/异形一律如实不造（零造假纪律优先于键名猜测）。"""

    def test_taxonomy_fields_candidate_scan(self):
        f = wenku_taxonomy.taxonomy_fields
        self.assertEqual(f({"tagList": ["EPC", "总承包"]}),
                         {"tags": ["EPC", "总承包"]})       # tagList 命中
        self.assertEqual(f({"tags": "造价"}), {"tags": ["造价"]})  # str→[str]
        self.assertEqual(f({"categoryName": " 专业资料 "}),
                         {"category": "专业资料"})          # 类目 strip
        self.assertEqual(f({"className": "建筑"}), {"category": "建筑"})
        self.assertEqual(f({"tagList": ["A"], "tags": ["B"]}),
                         {"tags": ["A"]})                   # 候选序：先命中先用
        self.assertEqual(f({"categoryName": "甲", "className": "乙"}),
                         {"category": "甲"})
        self.assertEqual(f({}), {})                         # 全缺席=零键（不造）
        self.assertEqual(f({"tags": [], "tag": ""}), {})    # 空值不造
        self.assertEqual(f({"tags": [1, None, "  "]}), {})  # 异形项滤净=缺席
        self.assertEqual(f(None), {})                      # 非 dict 防御（不抛）

    def test_merge_docinfo_shallow_safe_and_download_road_free(self):
        ri = {"page": 3}
        pd = {"readerInfo": ri, "docInfo": {"tagList": ["EPC"], "categoryName": "专业资料",
                                            "md5sum": "must-not-leak"}}
        out = wenku_taxonomy.merge_docinfo_taxonomy(ri, pd)
        self.assertEqual(out["tagList"], ["EPC"])           # docInfo 候选键补位
        self.assertEqual(out["categoryName"], "专业资料")
        self.assertNotIn("md5sum", out)                     # 候选集外键不合入（铁律）
        self.assertNotIn("tagList", ri)                     # 原 dict 不改（浅拷贝）
        ri2 = {"tags": ["已有"]}
        out2 = wenku_taxonomy.merge_docinfo_taxonomy(
            ri2, {"docInfo": {"tags": ["不覆写"]}})
        self.assertEqual(out2["tags"], ["已有"])            # readerInfo 已有键不覆写
        self.assertEqual(wenku_taxonomy.merge_docinfo_taxonomy(ri, {}),
                         ri)                                # docInfo 缺席=原样返回
        self.assertEqual(wenku_taxonomy.merge_docinfo_taxonomy(ri, {"docInfo": "x"}),
                         ri)                                # docInfo 非 dict=原样

    def test_ndview_extra_emits_tags_category_within_whitelist(self):
        ri = dict(reader_info(DOC_A), tagList=["EPC", "总承包"], categoryName="专业资料")
        nd = wenku_meta._ndview_extra(ri)
        self.assertEqual(nd["tags"], ["EPC", "总承包"])      # 目录层两键落账
        self.assertEqual(nd["category"], "专业资料")
        self.assertLessEqual(set(nd), wenku_meta._NDVIEW_KEYS)  # 产出 ⊆ 白名单（14 键）
        # 候选键缺席=成员如实省略（升级前形状零漂移）
        self.assertNotIn("tags", wenku_meta._ndview_extra(reader_info(DOC_B)))
        self.assertNotIn("category", wenku_meta._ndview_extra(reader_info(DOC_B)))

    def test_ndview_fetch_merges_docinfo_offline(self):
        """打桩 urlopen（离线零真网络）：pageData 含 docInfo 类目 → 返回 dict 已合入。"""
        html = ("<script>var pageData = " + json.dumps(
            {"readerInfo": reader_info(DOC_A),
             "docInfo": {"categoryName": "专业资料", "tagList": ["EPC"]}},
            ensure_ascii=False) + ";</script>")

        class _Resp:
            def __init__(self, blob):
                self._blob = blob

            def read(self):
                return self._blob

            def __enter__(self):
                return self

            def __exit__(self, *exc):
                return False
        saved = wenku_meta.urllib.request.urlopen
        wenku_meta.urllib.request.urlopen = (
            lambda req, timeout=None, context=None: _Resp(html.encode("utf-8")))
        self.addCleanup(setattr, wenku_meta.urllib.request, "urlopen", saved)
        ri = wenku_meta._ndview_fetch(DOC_A, 5.0)
        self.assertEqual(ri["categoryName"], "专业资料")     # docInfo 兜底位已合入
        self.assertEqual(ri["tagList"], ["EPC"])
        self.assertEqual(ri["page"], 32)                    # readerInfo 原字段原样

    def test_ndview_taxo_through_adapter_metadata(self):
        """全链（离线 mock）：ndview fetch 带类目 → extra['ndview'].tags/category 落账。"""
        audit, path = tmp_audit()
        self.addCleanup(os.unlink, path)
        lim = RateLimiter(min_interval=0, today=lambda: "d1")
        ndl = RateLimiter(min_interval=0, today=lambda: "d1")
        ad = wenku_meta.WenkuMetaAdapter(limiter=lim, audit=audit, ndview=True,
                                         ndview_limiter=ndl)

        def fake_fetch(query, pn, timeout):
            return wenku_page([wenku_item(DOC_A, 1, pages=0)]) if pn == 1 else wenku_page([])
        wenku_meta._fetch = fake_fetch
        self.addCleanup(setattr, wenku_meta, "_fetch", wenku_meta._urllib_fetch)
        ri = dict(reader_info(DOC_A, page=32, show=2),
                  tagList=["EPC", "总承包"], categoryName="专业资料")

        def fake_ndview(doc_id, timeout):
            return ri
        wenku_meta._ndview_fetch = fake_ndview
        self.addCleanup(setattr, wenku_meta, "_ndview_fetch",
                        wenku_meta._ndview_urllib_fetch)
        metas = ad.metadata("水利工程", 12)
        nd = metas[0].extra["ndview"]
        self.assertEqual(metas[0].pages, 32)                # 原补强语义不变
        self.assertEqual(nd["tags"], ["EPC", "总承包"])      # 目录层落账
        self.assertEqual(nd["category"], "专业资料")


if __name__ == "__main__":
    unittest.main()
