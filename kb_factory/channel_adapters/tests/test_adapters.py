# -*- coding: utf-8 -*-
"""W5 渠道适配器（元数据层）测试 — test-first，stdlib unittest，零真网络。

DoD/AC 对应（测试名前缀 test_w5_ 供追溯矩阵引用）：
  ac1 FileMeta 字段与 catalog_engine 槽位对齐；audit.jsonl 统一审计（零造假）
  ac2 RateLimiter：间隔+日上限熔断+连续错误熔断+日切重置
  ac3 wenku_meta：syncmrecall 配方包装（映射/翻页/限流/熔断/重试1次），假响应注入
  ac4 ima_meta：复刻件包装，无凭据/登录失效→available=False 且 metadata 返回[]（不崩溃）
  ac5 enrich：phi-1 配比回填真实 FileMeta 替换占位名、fmt 偏好匹配、去重、
     provenance {channel, filled, placeholder_kept} 计数、dry 零请求
"""
import json
import os
import sys
import tempfile
import time
import unittest
from dataclasses import fields as dc_fields
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[3]))  # 仓库根入 sys.path

from kb_factory.catalog_engine.blueprint import TIERS, tier_counts
from kb_factory.catalog_engine.metadata import (EXT_MIME, PERM_BY_BADGE, RIGHTS_BY_PERM,
                                                make_slot, sanitize_filename)
from kb_factory.channel_adapters.base import (AuditLog, ChannelAdapter, CircuitOpenError,
                                              FileMeta, RateLimitExceeded, RateLimiter)
from kb_factory.channel_adapters import enrich as enr
from kb_factory.channel_adapters import ima_meta, wenku_meta


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


def wenku_item(i, file_type=2, sell=1, title=None, pages=10):
    return {"data": {"docID": f"doc{i:04d}", "url": f"https://wenku.baidu.com/view/doc{i:04d}.html",
                     "title": title or f"<em>水利</em>工程文件{i}", "fileType": file_type,
                     "pageNum": pages, "sellType": sell, "viewCount": i, "downloadCount": 0,
                     "qualityScore": 3.5, "content": "摘要"}}


def wenku_page(items):
    return {"data": {"items": {"PCSearch": {"result": {"items": items,
                                                       "extra": {"total": 223286}}}}}}


class FakeAdapter(ChannelAdapter):
    """假渠道：按查询返回注入的 FileMeta，记录每次调用。"""

    def __init__(self, channel, items, available=True, reason=""):
        self.channel = channel
        self.items = items
        self._available = available
        self._reason = reason
        self.calls = []

    def available(self):
        return self._available

    def reason(self):
        return self._reason

    def metadata(self, query, limit):
        self.calls.append((query, limit))
        return self.items[:limit]


def make_slots(n_core=5, n_field=4, n_guide=1, path="F-01/01/", theme="水利工程", domain="水利EPC"):
    """按 catalog_engine 槽位形状造占位槽（tier 档 ext 与引擎一致）。"""
    exts = {"core": ["pdf"], "field": ["docx", "pdf", "xlsx"], "guide": ["md"]}
    slots, idx = [], 0
    for tier, n in (("core", n_core), ("field", n_field), ("guide", n_guide)):
        for k in range(1, n + 1):
            ext = exts[tier][(k - 1) % len(exts[tier])]
            name = f"{sanitize_filename(theme)}_{tier}_{k:03d}.{ext}"
            slot = {"name": name, "path": path, "tier": tier, "ext": ext}
            slot.update(make_slot(name=name, tier=tier, ext=ext, theme=theme, l1_name="知识库",
                                  domain=domain, path=path, badge="green_free", perm="green",
                                  idx=idx, need_hash8="abcd1234"))
            slots.append(slot)
            idx += 1
    return slots


def mini_blueprint(slots):
    return {"domain": "水利EPC", "ratio": {"core": 50, "field": 35, "guide": 15},
            "tree": {"mode": "six_domains", "root": "水利EPC", "l1": [
                {"code": "KN", "dir": "KN-01", "path": "KN-01/", "name": "知识库", "theme": "t",
                 "source": "seed", "l2": [{"code": "KN-01/01", "dir": "01", "path": "KN-01/01/",
                                          "name": "01 工程总承包", "theme": "th",
                                          "file_count": len(slots), "files": slots}]}]},
            "stats": {}, "quote": {}, "provenance": {"engine_version": "kb-cat/1.0.0",
                                                     "seed_taxonomy": [], "stage_log": []}}


# ---------------- ac1 FileMeta / 审计 ----------------

class TestW5Ac1FileMetaAudit(unittest.TestCase):
    def test_w5_ac1_filemeta_fields_align_catalog_slots(self):
        names = [f.name for f in dc_fields(FileMeta)]
        self.assertEqual(names, ["title", "fmt", "pages", "badge", "perm", "source_url", "extra"])
        m = FileMeta(title="t", fmt="pdf")
        self.assertEqual((m.badge, m.perm), ("green_free", "green"))
        self.assertEqual(PERM_BY_BADGE[m.badge], m.perm)  # 与 catalog_engine 权限口径一致
        self.assertEqual(m.extra, {})

    def test_w5_ac1_audit_jsonl_request_lines(self):
        audit, path = tmp_audit()
        audit.log(channel="wenku", event="request", query="水利工程", elapsed_ms=120, count=12)
        audit.log(channel="ima", event="degrade", query="水利工程", count=0, detail="无凭据")
        lines = [json.loads(l) for l in open(path, encoding="utf-8") if l.strip()]
        self.assertEqual(len(lines), 2)
        self.assertEqual(lines[0]["channel"], "wenku")
        self.assertEqual(lines[0]["count"], 12)
        self.assertIn("ts", lines[0])  # 每行带时间戳，零造假
        self.assertEqual(lines[1]["event"], "degrade")
        os.unlink(path)

    def test_w5_ac1_channel_adapter_abstract(self):
        a = ChannelAdapter()
        with self.assertRaises(NotImplementedError):
            a.metadata("q", 12)
        self.assertTrue(a.available())


# ---------------- ac2 RateLimiter ----------------

class TestW5Ac2RateLimiter(unittest.TestCase):
    def test_w5_ac2_interval_enforced(self):
        clk = fake_clock()
        lim = RateLimiter(min_interval=3.0, daily_limit=500, clock=clk, sleep=clk.sleep,
                          today=lambda: "d1")
        lim.acquire()
        t_before = clk.t
        lim.acquire()  # 无间隔 → 必须 sleep 到 ≥3s
        self.assertGreaterEqual(clk.t - t_before, 3.0)

    def test_w5_ac2_daily_cap_trips_and_stays(self):
        lim = RateLimiter(min_interval=0, daily_limit=2, today=lambda: "d1")
        lim.acquire()
        lim.acquire()
        with self.assertRaises(RateLimitExceeded):
            lim.acquire()
        with self.assertRaises(RateLimitExceeded):  # 熔断保持，同日不再放行
            lim.acquire()
        self.assertEqual(lim.status()["count_today"], 2)

    def test_w5_ac2_day_rollover_resets_budget(self):
        day = {"d": "2026-10-21"}
        lim = RateLimiter(min_interval=0, daily_limit=1, today=lambda: day["d"])
        lim.acquire()
        with self.assertRaises(RateLimitExceeded):
            lim.acquire()
        day["d"] = "2026-10-22"  # 日切重置
        lim.acquire()
        self.assertEqual(lim.status()["count_today"], 1)

    def test_w5_ac2_consecutive_error_breaker(self):
        lim = RateLimiter(min_interval=0, daily_limit=500, error_threshold=2,
                          today=lambda: "d1")
        lim.acquire()
        lim.record_error()
        lim.acquire()  # 未达阈值仍可用
        lim.record_error()  # 连续 2 次 → 熔断开
        with self.assertRaises(CircuitOpenError):
            lim.acquire()
        lim.reset()
        lim.acquire()  # 手动复位后恢复
        self.assertEqual(lim.status()["consecutive_errors"], 0)

    def test_w5_ac2_record_success_resets_error_count(self):
        lim = RateLimiter(min_interval=0, error_threshold=2, today=lambda: "d1")
        lim.record_error()
        lim.record_success()
        lim.record_error()
        self.assertFalse(lim.status()["circuit_open"])  # 非连续，不熔断


# ---------------- ac3 wenku_meta ----------------

class WenkuMetaTestBase(unittest.TestCase):
    def setUp(self):
        self.audit, self.audit_path = tmp_audit()
        self.fetches = []

    def tearDown(self):
        os.unlink(self.audit_path)

    def adapter(self, **kw):
        lim = RateLimiter(min_interval=0, daily_limit=kw.pop("daily_limit", 500),
                          error_threshold=kw.pop("error_threshold", 5),
                          today=lambda: "d1")
        return wenku_meta.WenkuMetaAdapter(limiter=lim, audit=self.audit, **kw)


class TestW5Ac3WenkuMeta(WenkuMetaTestBase):
    def test_w5_ac3_mapping_emstrip_vip(self):
        pages = {"p1": wenku_page([wenku_item(1, 2, 5), wenku_item(2, 1, 1),
                                   wenku_item(3, 16, 2), wenku_item(4, 7, 0)])}
        def fake_fetch(query, pn, timeout):
            self.fetches.append((query, pn))
            return pages["p1"] if pn == 1 else wenku_page([])  # 只1页，第2页空
        wenku_meta._fetch = fake_fetch
        self.addCleanup(setattr, wenku_meta, "_fetch", wenku_meta._urllib_fetch)
        metas = self.adapter().metadata("水利工程", 12)
        self.assertEqual(len(metas), 4)
        m0, m1, m2, m3 = metas
        self.assertEqual(m0.title, "水利工程文件1")  # <em> 剥离
        self.assertEqual(m0.fmt, "pdf")             # fileType 2→pdf
        self.assertEqual((m0.badge, m0.perm), ("wenku_vip", "yellow"))  # sellType 5→VIP/黄
        self.assertEqual(m1.fmt, "doc")             # fileType 1→doc
        self.assertEqual((m1.badge, m1.perm), ("green_free", "green"))
        self.assertEqual(m2.fmt, "ebook")           # 16→ebook
        self.assertEqual(m2.perm, "yellow")         # sellType 2∈{2,5}
        self.assertEqual(m3.fmt, "epub")            # 7→epub
        self.assertEqual(m3.perm, "green")
        self.assertTrue(m0.source_url.startswith("https://wenku.baidu.com/view/"))
        self.assertEqual(m0.pages, 10)
        self.assertEqual(m0.extra["doc_id"], "doc0001")
        # 审计：每次请求一行，含 count
        lines = [json.loads(l) for l in open(self.audit_path, encoding="utf-8")]
        self.assertTrue(any(l["channel"] == "wenku" and l["count"] == 4 and l["query"] == "水利工程"
                            for l in lines))

    def test_w5_ac3_pagination_limit_and_empty_stop(self):
        script = {1: wenku_page([wenku_item(i) for i in range(12)]),
                  2: wenku_page([wenku_item(i) for i in range(12, 17)]),
                  3: wenku_page([])}
        def fake_fetch(query, pn, timeout):
            self.fetches.append(pn)
            return script[pn]
        wenku_meta._fetch = fake_fetch
        self.addCleanup(setattr, wenku_meta, "_fetch", wenku_meta._urllib_fetch)
        metas = self.adapter().metadata("水利工程", 14)  # 12+5 命中，够 14 即停
        self.assertEqual(len(metas), 14)
        self.assertEqual(self.fetches, [1, 2])
        metas2 = self.adapter().metadata("水利工程", 30)  # 翻到空页停
        self.assertEqual(len(metas2), 17)
        self.assertEqual(self.fetches, [1, 2, 1, 2, 3])

    def test_w5_ac3_daily_cap_breaker_raises(self):
        script = {1: wenku_page([wenku_item(i) for i in range(12)]),
                  2: wenku_page([wenku_item(i) for i in range(12, 24)])}
        wenku_meta._fetch = lambda q, pn, t: (self.fetches.append(pn), script[pn])[1]
        self.addCleanup(setattr, wenku_meta, "_fetch", wenku_meta._urllib_fetch)
        a = self.adapter(daily_limit=1)
        with self.assertRaises(RateLimitExceeded):  # 第2页超日限 → 熔断抛异常
            a.metadata("水利工程", 20)

    def test_w5_ac3_consecutive_error_breaker(self):
        def boom(query, pn, timeout):
            raise OSError("conn reset")
        wenku_meta._fetch = boom
        self.addCleanup(setattr, wenku_meta, "_fetch", wenku_meta._urllib_fetch)
        a = self.adapter(error_threshold=2)
        self.assertEqual(a.metadata("水利工程", 12), [])  # 单次失败→如实降级返回部分(空)
        self.assertEqual(a.metadata("水利工程", 12), [])  # 第2次连续失败
        with self.assertRaises(CircuitOpenError):        # 第3次调用：熔断已开
            a.metadata("水利工程", 12)

    def test_w5_ac3_retry_once_then_success(self):
        state = {"n": 0, "pn1": 0}
        def flaky(query, pn, timeout):
            state["n"] += 1
            if pn == 1:
                state["pn1"] += 1
            if state["pn1"] == 1 and pn == 1:
                raise TimeoutError("first fail")
            return wenku_page([wenku_item(1)]) if pn == 1 else wenku_page([])
        wenku_meta._fetch = flaky
        self.addCleanup(setattr, wenku_meta, "_fetch", wenku_meta._urllib_fetch)
        metas = self.adapter().metadata("水利工程", 12)
        self.assertEqual(len(metas), 1)
        self.assertEqual(state["pn1"], 2)  # pn=1 恰好尝试 2 次（重试 1 次）

    def test_w5_ac3_recipe_shape_unchanged(self):
        """铁律：照抄配方勿改端点——payload/端点/UA 与 W3.5 参考实现一致。"""
        self.assertEqual(wenku_meta._URL, "https://wenku.baidu.com/gsula/sula/syncmrecall")
        p = wenku_meta._payload("水利工程", 3)
        self.assertEqual(p["requests"][0]["sceneID"], "PCSearch")
        self.assertEqual(p["requests"][0]["params"],
                         {"word": "水利工程", "pn": 3, "noCacheMembershipCard": True})


# ---------------- ac4 ima_meta ----------------

STUB_REPLICA = '''# -*- coding: utf-8 -*-
import os
CRED_FILE = os.path.join(os.path.dirname(os.path.abspath(__file__)), "credentials.json")
class ImaClient:
    def __init__(self):
        self.cred = None
    def search_kb_plaza(self, query, limit=10, cursor=""):
        raise_ok = os.environ.get("STUB_PLAZA_RAISE")
        if raise_ok:
            raise RuntimeError(raise_ok)
        return {"code": 0, "searched_knowledge_bases": [
            {"id": "kb-1", "name": "水利工程EPC知识库", "join_type": 0,
             "creator_info": {"nickname": "总包智库"}, "description": "水利EPC资料"},
            {"id": "kb-2", "name": "EPC项目管理精选库", "join_type": 1,
             "creator_info": {"nickname": "工程师"}, "description": "项目管理"}]}
'''


class ImaTestBase(unittest.TestCase):
    def setUp(self):
        import shutil
        import sys as _sys
        _sys.modules.pop("ima_replica", None)
        self.dir = tempfile.mkdtemp()
        with open(os.path.join(self.dir, "ima_replica.py"), "w", encoding="utf-8") as f:
            f.write(STUB_REPLICA)
        self.audit, self.audit_path = tmp_audit()
        self.addCleanup(shutil.rmtree, self.dir, True)
        self.addCleanup(os.unlink, self.audit_path)

    def adapter(self):
        return ima_meta.ImaMetaAdapter(replica_dir=self.dir, limiter=RateLimiter(
            min_interval=0, daily_limit=200, today=lambda: "d1"), audit=self.audit)

    def write_cred(self, expire_offset):
        cred = {"user_id": "u1", "token": "t", "refresh_token": "r",
                "token_expire_time": int(time.time()) + expire_offset,
                "refresh_token_expire_time": int(time.time()) + 10 ** 7,
                "bkn": "0", "cookie": "IMA-UID=u1"}
        with open(os.path.join(self.dir, "credentials.json"), "w", encoding="utf-8") as f:
            json.dump(cred, f)


class TestW5Ac4ImaMeta(ImaTestBase):
    def test_w5_ac4_no_credentials_degrades(self):
        a = self.adapter()
        self.assertFalse(a.available())
        self.assertEqual(a.metadata("水利工程", 12), [])  # 不抛崩溃
        self.assertIn("凭据", a.reason())
        lines = [json.loads(l) for l in open(self.audit_path, encoding="utf-8")]
        self.assertTrue(any(l["event"] == "degrade" and l["channel"] == "ima" and l["detail"]
                            for l in lines))  # 审计记录降级原因

    def test_w5_ac4_expired_token_degrades(self):
        self.write_cred(expire_offset=-3600)  # 已过期
        a = self.adapter()
        self.assertFalse(a.available())
        self.assertEqual(a.metadata("水利工程", 12), [])
        self.assertIn("登录态失效", a.reason())

    def test_w5_ac4_plaza_search_maps_filemeta(self):
        self.write_cred(expire_offset=7200)
        a = self.adapter()
        self.assertTrue(a.available())
        metas = a.metadata("水利工程", 12)
        self.assertEqual(len(metas), 2)
        m = metas[0]
        self.assertEqual(m.title, "水利工程EPC知识库")
        self.assertEqual(m.fmt, "kb")
        self.assertEqual((m.badge, m.perm), ("ima_public", "green"))
        self.assertIsNone(m.pages)      # 库级条目页数未知，如实为 None
        self.assertIsNone(m.source_url)  # 响应无 URL 字段，不造假
        self.assertEqual(m.extra["kb_id"], "kb-1")
        self.assertEqual(m.extra["creator"], "总包智库")

    def test_w5_ac4_plaza_error_returns_empty(self):
        os.environ["STUB_PLAZA_RAISE"] = "code=1000 未登录"
        self.addCleanup(os.environ.pop, "STUB_PLAZA_RAISE", None)
        self.write_cred(expire_offset=7200)
        a = self.adapter()
        self.assertEqual(a.metadata("水利工程", 12), [])  # 异常→如实空，不崩溃
        lines = [json.loads(l) for l in open(self.audit_path, encoding="utf-8")]
        self.assertTrue(any(l["event"] == "error" for l in lines))

    def test_w5_ac4_import_failure_degrades(self):
        empty = tempfile.mkdtemp()
        self.addCleanup(os.rmdir, empty)
        a = ima_meta.ImaMetaAdapter(replica_dir=empty,
                                    limiter=RateLimiter(min_interval=0, today=lambda: "d"),
                                    audit=self.audit)
        self.assertFalse(a.available())
        self.assertIn("不可用", a.reason())
        self.assertEqual(a.metadata("水利工程", 12), [])


# ---------------- ac5 enrich ----------------

class TestW5Ac5Enrich(unittest.TestCase):
    def setUp(self):
        self.audit, self.audit_path = tmp_audit()
        self.addCleanup(os.unlink, self.audit_path)

    @staticmethod
    def metas(n, fmts=None):
        fmts = fmts or ["pdf", "doc", "ppt", "xls", "txt", "epub"]
        return [FileMeta(title=f"真实文件{i}·水利工程", fmt=fmts[i % len(fmts)], pages=20 + i,
                         badge="green_free", perm="green",
                         source_url=f"https://wenku.baidu.com/view/x{i}.html",
                         extra={"doc_id": f"x{i}"}) for i in range(n)]

    def test_w5_ac5_backfill_ratio_and_fmt_preference(self):
        slots = make_slots()  # core5/field4/guide1（tier_counts(10, 50/35/15) 同引擎）
        bp = mini_blueprint(slots)
        fake = FakeAdapter("fake", self.metas(12, fmts=["pdf"] * 6 + ["doc"] * 4 + ["ppt"] * 2))
        enr.enrich_blueprint(bp, [fake], per_topic=12, audit=self.audit)
        # 占位名全部被真实标题替换
        self.assertTrue(all(s["name"].startswith("真实文件") for s in slots))
        self.assertTrue(all("." in s["name"] and s["title"] == s["name"].rsplit(".", 1)[0]
                            for s in slots))
        # phi-1 配比：满槽回填按 tier_counts(10, ratio) 分档 = 引擎同款 5/4/1
        filled_by_tier = {t: sum(1 for s in slots if s["name"].startswith("真实文件")
                                 and s["tier"] == t) for t in TIERS}
        self.assertEqual(filled_by_tier, {**tier_counts(10, bp["ratio"])})
        # core→pdf 优先：core 槽全拿到 pdf
        core = [s for s in slots if s["tier"] == "core"]
        self.assertTrue(all(s["ext"] == "pdf" for s in core))
        # 槽位其余字段：来源/徽章/权限被真实值覆盖，标识符等引擎字段保留
        s0 = slots[0]
        self.assertEqual(s0["source"], "https://wenku.baidu.com/view/x0.html")
        self.assertEqual(s0["format"], EXT_MIME["pdf"])
        self.assertIn("渠道实采", s0["description"])
        self.assertTrue(s0["identifier"].startswith("KBC1-"))
        self.assertEqual(s0["rights"], RIGHTS_BY_PERM["green"])
        # provenance 计数 {channel, filled, placeholder_kept}
        prov = bp["provenance"]["channel_enrichment"]
        self.assertEqual(prov["channels"]["fake"],
                         {"requests": 1, "results": 12, "filled": 10})
        self.assertEqual(prov["filled"], 10)
        self.assertEqual(prov["placeholder_kept"], 0)
        self.assertIn("S8", bp["provenance"]["stage_log"][-1])
        # 查询词去编号
        self.assertEqual(fake.calls, [("工程总承包", 12)])
        # 审计有组级记录
        lines = [json.loads(l) for l in open(self.audit_path, encoding="utf-8")]
        self.assertTrue(any(l["event"] == "group" and l["query"] == "工程总承包" for l in lines))

    def test_w5_ac5_truncate_by_ratio_when_pool_small(self):
        slots = make_slots()
        bp = mini_blueprint(slots)
        enr.enrich_blueprint(bp, [FakeAdapter("fake", self.metas(3))], per_topic=12)
        alloc = tier_counts(3, bp["ratio"])  # 3 条按配比截断
        by_tier = {t: sum(1 for s in slots if s["name"].startswith("真实文件")
                          and s["tier"] == t) for t in TIERS}
        self.assertEqual(by_tier, {**alloc})
        kept = sum(1 for s in slots if not s["name"].startswith("真实文件"))
        prov = bp["provenance"]["channel_enrichment"]
        self.assertEqual(prov["filled"], 3)
        self.assertEqual(prov["placeholder_kept"], kept)
        self.assertEqual(prov["placeholder_kept"], 10 - 3)
        # guide 槽（md）无匹配渠道格式时保留占位，不硬凑
        self.assertTrue(all(s["ext"] == "md" for s in slots if s["tier"] == "guide"))

    def test_w5_ac5_multi_channel_dedup(self):
        slots = make_slots(n_core=1, n_field=1, n_guide=0)
        bp = mini_blueprint(slots)
        a = FakeAdapter("wenku", self.metas(2))
        b = FakeAdapter("ima", self.metas(2))  # 完全同名 → 去重后仍 2 条
        enr.enrich_blueprint(bp, [a, b], per_topic=5)
        titles = [s["title"] for s in slots]
        self.assertEqual(len(set(titles)), 2)  # 无重复标题
        prov = bp["provenance"]["channel_enrichment"]
        self.assertEqual(prov["channels"]["wenku"]["requests"], 1)
        self.assertEqual(prov["channels"]["ima"]["requests"], 1)
        self.assertEqual(prov["filled"], 2)

    def test_w5_ac5_unavailable_channel_degrades(self):
        slots = make_slots()
        bp = mini_blueprint(slots)
        down = FakeAdapter("ima", self.metas(5), available=False, reason="无凭据")
        enr.enrich_blueprint(bp, [down], per_topic=12)
        self.assertEqual(down.calls, [])  # 不可用即零请求
        self.assertTrue(all("_core_" in s["name"] or "_" in s["name"] for s in slots))
        prov = bp["provenance"]["channel_enrichment"]
        self.assertEqual(prov["unavailable"], {"ima": "无凭据"})
        self.assertEqual(prov["placeholder_kept"], 10)

    def test_w5_ac5_vip_slot_badge_flows(self):
        slots = make_slots(n_core=1, n_field=0, n_guide=0)
        bp = mini_blueprint(slots)
        vip = FileMeta(title="VIP图纸库", fmt="pdf", pages=99, badge="wenku_vip",
                       perm="yellow", source_url="https://wenku.baidu.com/view/v.html",
                       extra={"doc_id": "v1"})
        enr.enrich_blueprint(bp, [FakeAdapter("wenku", [vip])], per_topic=3)
        s = slots[0]
        self.assertEqual((s["badge"], s["perm"], s["rights"]),
                         ("wenku_vip", "yellow", RIGHTS_BY_PERM["yellow"]))

    def test_w5_ac5_engine_blueprint_integration(self):
        """真蓝图（catalog_engine 产物）上跑回填：结构与引擎契约不破。"""
        from kb_factory.catalog_engine import build_blueprint
        bp = build_blueprint({"domain": "水利EPC工程", "keywords": ["EPC总承包"],
                              "intent": "施工与项目管理", "size_hint": "small"})
        fake = FakeAdapter("fake", self.metas(12))
        enr.enrich_blueprint(bp, [fake], per_topic=12, max_topics=3)
        prov = bp["provenance"]["channel_enrichment"]
        self.assertEqual(prov["groups_queried"], 3)
        self.assertEqual(len(fake.calls), 3)
        self.assertGreater(prov["filled"], 0)
        # 三组每组的占位名均被真实标题替换
        groups = []
        for l1 in bp["tree"]["l1"]:
            for l2 in l1["l2"]:
                if l2["files"] and l2["files"][0]["name"].startswith("真实文件"):
                    groups.append(l2["name"])
        self.assertGreaterEqual(len(groups), 3)

    def test_w5_ac5_split_dir_slots_enriched(self):
        slots = make_slots(n_core=2, n_field=1, n_guide=0)
        bp = mini_blueprint([])
        l2 = bp["tree"]["l1"][0]["l2"][0]
        l2["files"] = []
        l2["split_dirs"] = [{"name": "工程总承包-1", "path": "KN-01/01/工程总承包-1/",
                             "files": slots}]
        enr.enrich_blueprint(bp, [FakeAdapter("fake", self.metas(3))], per_topic=3)
        self.assertTrue(all(s["name"].startswith("真实文件") for s in slots))

    def test_w5_ac5_dry_run_zero_requests(self):
        slots = make_slots(n_core=2, n_field=1, n_guide=0)
        bp = mini_blueprint(slots)
        fake = FakeAdapter("fake", self.metas(3))
        plan = enr.plan_dry(bp, [fake], per_topic=12, max_topics=5)
        self.assertEqual(fake.calls, [])          # dry 零请求
        self.assertEqual(plan["groups_queried"], 1)
        self.assertEqual(plan["queries"], ["工程总承包"])
        self.assertEqual(plan["budget_requests"], 1)  # 组数×渠道数
        self.assertTrue(all(s["name"].endswith((".pdf", ".docx", ".xlsx", ".md"))
                            for s in slots))      # dry 不改蓝图


if __name__ == "__main__":
    unittest.main()
