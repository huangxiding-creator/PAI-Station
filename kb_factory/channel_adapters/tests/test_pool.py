# -*- coding: utf-8 -*-
"""渠道编排池（pool.py + dangdang/cnki 新适配器）测试 — 离线 mock 全绿，零真网络。

任务 DoD 对应（测试名前缀供追溯）：
  pool_*   harvest_pool：并发聚合（每渠道一线程）/超时降级（卡死渠道 [] 如实、
           收手渠道实得部分保留）/频控遵守（线程内串行 RateLimiter）/channels
           入参形态/空查询/审计照常（pool_start/pool_query/degrade/timeout/pool_end）
  pages_*  2.0 A1 pages 翻页倍率：有效 limit=per_q×pages 透传 metadata/缺省 1 零漂移/
           倍率下限 1 兜底/审计 pool_start 记 pages
  scale_*  2.0 A1 池规模目标账（在线渠道论）：七渠道全开缺省档 1008≥1000/
           pages=5 深挖档+渠道离线如实计 0 仍 4320≥1000
  scale24_* 5x 池扩容目标账 mock 钉死算术：24 词×36 条（per_q=12×pages=3）×
           3 渠道×~75% 保留率=1944≥1000（DupRetentionFake 精确模拟跨词保留）
  ndv_*    2.0 A1 wenku_ndview 池级透传：build_registry 缺省=env 自决（默认关）/
           True 显式开/只透传 wenku 他家零漂移/harvest_pool 透传到自建注册表
  expand_* expand_queries：6-12 词界/确定性/THUOCL 高 DF 命中扩展/词表缺席退化；
           2.0 A1 深化：缺省满额 12/二元组合腿/次关键词×高 DF 腿/词表缺席仍满额；
           5x 扩容：缺省满额 24/C(2,3) 二元+三元组合腿/高 DF 三路与自身腿/
           名词库两级兜底（词表缺席/零关键词仍满额 24）
  dangdang_* / cnki_* 新适配器离线 mock：契约映射/翻页/零题录/目录层 fail-soft/
           复刻件缺失降级/默认频控 2s300 与 4s200/连错熔断
  live_*   真网络腿一律 @skipUnless(KB_LIVE)（默认 skip 保底不炸 CI）
"""
import json
import os
import sys
import tempfile
import threading
import time
import unittest
from pathlib import Path
from types import SimpleNamespace

sys.path.insert(0, str(Path(__file__).resolve().parents[3]))  # 仓库根入 sys.path

from kb_factory.channel_adapters import cnki_meta, dangdang_meta, pool
from kb_factory.channel_adapters.base import (AuditLog, CircuitOpenError, ChannelAdapter,
                                              FileMeta, RateLimiter, RateLimitExceeded)
from kb_factory.channel_adapters.cnki_meta import CnkiAdapter
from kb_factory.channel_adapters.dangdang_meta import DangdangAdapter
from kb_factory.channel_adapters.pool import (DEFAULT_CHANNELS, META_KEYS, build_registry,
                                              expand_queries, harvest_pool)


def tmp_audit():
    fd, path = tempfile.mkstemp(suffix=".jsonl")
    os.close(fd)
    return AuditLog(path), path


def lines_of(audit):
    with open(audit.path, encoding="utf-8") as f:
        return [json.loads(x) for x in f if x.strip()]


class FakeClock:
    """确定性时钟：sleep 只记账推进假钟，零真实等待。"""

    def __init__(self):
        self.t = 1000.0
        self.sleeps = []

    def __call__(self):
        return self.t

    def sleep(self, d):
        self.sleeps.append(d)
        self.t += d


class RecordingFake(ChannelAdapter):
    """假渠道：按查询返回固定条数 FileMeta，记录线程名/入参；可注入睡眠与异常。"""

    def __init__(self, channel, per_call=2, sleep_s=0.0, fail_on=None, exc=None):
        self.channel = channel
        self.per_call = per_call
        self.sleep_s = sleep_s
        self.fail_on = set(fail_on or ())
        self.exc = exc or RateLimitExceeded("日上限熔断: test")
        self.calls = []        # (线程名, query, limit)
        self._reason = ""

    def metadata(self, query, limit=12):
        self.calls.append((threading.current_thread().name, query, limit))
        if self.sleep_s:
            time.sleep(self.sleep_s)
        if query in self.fail_on:
            raise self.exc
        return [FileMeta(title=f"{self.channel}-{query}-{i}", fmt="pdf", pages=10 + i,
                         source_url=f"https://t.example/{self.channel}/{i}",
                         extra={"q": query}) for i in range(min(self.per_call, limit))]


# ---------------- pool：并发聚合 / 线程模型 ----------------

class PoolConcurrentTest(unittest.TestCase):
    def setUp(self):
        self.audit, self.audit_path = tmp_audit()
        self.addCleanup(os.unlink, self.audit_path)

    def test_pool_concurrent_aggregation_all_channels(self):
        a = RecordingFake("wenku", per_call=2)
        b = RecordingFake("cnki", per_call=3)
        queries = ["水利工程", "EPC 总承包", "造价管理"]
        out = harvest_pool(queries, channels=[a, b], per_q=12, audit=self.audit,
                           timeout=10, registry={})
        # 聚合：每渠道 查询数×per_call 条，键=渠道名
        self.assertEqual(set(out), {"wenku", "cnki"})
        self.assertEqual(len(out["wenku"]), 3 * 2)
        self.assertEqual(len(out["cnki"]), 3 * 3)
        # dict 化形状：FileMeta 七字段序
        m = out["wenku"][0]
        self.assertEqual(tuple(m.keys()), META_KEYS)
        self.assertEqual(m["fmt"], "pdf")
        self.assertEqual(m["extra"]["q"], "水利工程")
        # 每渠道每查询调一次 metadata（limit=per_q 透传）
        self.assertEqual([c[1:] for c in a.calls],
                         [(q, 12) for q in queries])
        # 审计照常：start/每查询一行/end
        ls = lines_of(self.audit)
        self.assertEqual(ls[0]["event"], "pool_start")
        self.assertEqual(ls[0]["count"], 3)
        self.assertTrue(any(l["event"] == "pool_query" and l["channel"] == "wenku"
                            and l["count"] == 2 for l in ls))
        self.assertEqual(ls[-1]["event"], "pool_end")
        self.assertEqual(ls[-1]["by_channel"], {"wenku": 6, "cnki": 9})

    def test_pool_one_thread_per_channel_not_main(self):
        a = RecordingFake("wenku")
        b = RecordingFake("dangdang")
        harvest_pool(["q1", "q2", "q3"], channels=[a, b], audit=self.audit,
                     timeout=10, registry={})
        for fake in (a, b):  # 每渠道全部调用来自同一工作线程（线程内串行）
            names = {c[0] for c in fake.calls}
            self.assertEqual(len(names), 1, f"{fake.channel} 应单线程串行")
            (name,) = names
            self.assertTrue(name.startswith("kbpool-"))
            self.assertNotEqual(name, threading.current_thread().name)
        # 渠道间线程互异（每渠道一线程）
        self.assertNotEqual(a.calls[0][0], b.calls[0][0])

    def test_pool_default_registry_offline_construction(self):
        reg = build_registry()  # 全家桶构造零网络（复刻件惰性加载）
        self.assertEqual(sorted(reg), sorted(DEFAULT_CHANNELS))
        self.assertTrue(all(isinstance(ad, ChannelAdapter) for ad in reg.values()))

    def test_pool_channels_param_forms(self):
        a = RecordingFake("wenku")
        b = RecordingFake("cnki")
        reg = {"wenku": a, "cnki": b}
        out = harvest_pool(["q"], channels=["cnki"], audit=self.audit,
                           timeout=10, registry=reg)
        self.assertEqual(set(out), {"cnki"})          # 名字子集
        self.assertEqual(a.calls, [])
        out2 = harvest_pool(["q"], channels=[a], audit=self.audit, timeout=10, registry=reg)
        self.assertEqual(set(out2), {"wenku"})        # 实例直用
        with self.assertRaises(ValueError):           # 未知渠道名=配置错误如实抛
            harvest_pool(["q"], channels=["nope"], audit=self.audit, timeout=10, registry=reg)
        with self.assertRaises(TypeError):            # 非法元素类型
            harvest_pool(["q"], channels=[123], audit=self.audit, timeout=10, registry=reg)

    def test_pool_empty_queries_zero_work(self):
        a = RecordingFake("wenku")
        out = harvest_pool([], channels=[a], audit=self.audit, timeout=5, registry={})
        self.assertEqual(out, {"wenku": []})
        self.assertEqual(a.calls, [])                 # 零查询零请求
        ls = lines_of(self.audit)
        self.assertEqual(ls[0]["event"], "pool_start")
        self.assertEqual(ls[0]["count"], 0)
        self.assertFalse(any(l["event"] == "pool_query" for l in ls))


# ---------------- pool：超时降级 / 异常降级 ----------------

class PoolDegradeTest(unittest.TestCase):
    def setUp(self):
        self.audit, self.audit_path = tmp_audit()
        self.addCleanup(os.unlink, self.audit_path)

    def test_pool_timeout_stuck_channel_returns_empty(self):
        stuck = RecordingFake("chinca", per_call=1, sleep_s=0.5)  # 每查询睡 0.5s
        fast = RecordingFake("wenku", per_call=2)
        out = harvest_pool(["q1", "q2", "q3"], channels=[stuck, fast], audit=self.audit,
                           timeout=0.15, grace=0.05, registry={})
        self.assertEqual(out["chinca"], [])           # 卡死渠道 [] 如实
        self.assertEqual(len(out["wenku"]), 6)        # 快渠道不受牵连
        ls = lines_of(self.audit)
        to = [l for l in ls if l["event"] == "timeout" and l["channel"] == "chinca"]
        self.assertEqual(len(to), 1)                  # 超时一行：进度如实（0/3 或 1/3）
        self.assertIn(to[0]["detail"].split("/")[0].split("=")[1], ("0", "1"))
        self.assertFalse(any(l["event"] == "timeout" and l["channel"] == "wenku" for l in ls))
        self.assertEqual(ls[-1]["by_channel"]["wenku"], 6)

    def test_pool_stop_preserves_real_partial(self):
        slowish = RecordingFake("dangdang", per_call=1, sleep_s=0.01)  # 25 查询×10ms
        queries = [f"q{i}" for i in range(25)]
        out = harvest_pool(queries, channels=[slowish], audit=self.audit,
                           timeout=0.15, grace=1.5, registry={})
        n = len(out["dangdang"])
        self.assertGreater(n, 0)                      # 实得部分保留（零造假不弃真数据）
        self.assertLess(n, 25)
        ls = lines_of(self.audit)
        self.assertTrue(any(l["event"] == "stopped" and l["channel"] == "dangdang"
                            for l in ls))             # 收手审计一行：进度可对账
        self.assertFalse(any(l["event"] == "timeout" for l in ls))  # 宽限内收手≠卡死

    def test_pool_adapter_exception_keeps_partial(self):
        flaky = RecordingFake("wenku", per_call=2,
                              fail_on={"q2"}, exc=RateLimitExceeded("日上限熔断: test"))
        out = harvest_pool(["q1", "q2", "q3"], channels=[flaky], audit=self.audit,
                           timeout=10, registry={})
        self.assertEqual(len(out["wenku"]), 2)        # q1 实得保留；q2 抛→本渠道收工
        self.assertEqual(len(flaky.calls), 2)         # q3 不再发（熔断即停）
        ls = lines_of(self.audit)
        err = [l for l in ls if l["event"] == "pool_error"]
        self.assertEqual(len(err), 1)
        self.assertIn("RateLimitExceeded", err[0]["detail"])

    def test_pool_unavailable_channel_zero_requests(self):
        down = RecordingFake("ima")
        down.available = lambda: False
        down.reason = lambda: "无凭据: credentials.json 缺失"
        out = harvest_pool(["q1"], channels=[down], audit=self.audit, timeout=5, registry={})
        self.assertEqual(out["ima"], [])
        self.assertEqual(down.calls, [])              # 不可用即零请求
        ls = lines_of(self.audit)
        dg = [l for l in ls if l["event"] == "degrade" and l["channel"] == "ima"]
        self.assertEqual(len(dg), 1)
        self.assertIn("凭据", dg[0]["detail"])


# ---------------- pool：线程内串行频控 ----------------

class SerialLimiterFake(ChannelAdapter):
    """假渠道直连真 RateLimiter（注入假时钟）：验证线程内串行遵守频控。"""

    channel = "serial"

    def __init__(self, limiter):
        self.limiter = limiter
        self.threads = []

    def metadata(self, query, limit=12):
        self.threads.append(threading.current_thread().name)
        self.limiter.acquire()  # 串行取额度：间隔在此睡眠（假钟记账零真实等待）
        return []


class PoolRateLimitTest(unittest.TestCase):
    def test_pool_rate_limiter_serial_within_thread(self):
        clk = FakeClock()
        lim = RateLimiter(min_interval=3.0, daily_limit=500, name="serial",
                          clock=clk, sleep=clk.sleep, today=lambda: "d1")
        fake = SerialLimiterFake(lim)
        audit, path = tmp_audit()
        self.addCleanup(os.unlink, path)
        out = harvest_pool(["q1", "q2", "q3", "q4"], channels=[fake], audit=audit,
                           timeout=10, registry={})
        self.assertEqual(out, {"serial": []})
        self.assertEqual(clk.sleeps, [3.0, 3.0, 3.0])  # 4 次额度=3 次间隔等待
        self.assertEqual(lim.status()["count_today"], 4)
        # 全部额度取自同一工作线程（kbpool-serial），非主线程
        self.assertEqual(len(set(fake.threads)), 1)
        self.assertTrue(fake.threads[0].startswith("kbpool-serial"))


# ---------------- pages：2.0 A1 翻页倍率（池侧等价翻页） ----------------

class PoolPagesParamTest(unittest.TestCase):
    """harvest_pool 新参 pages：有效 limit=per_q×pages 透传 adapter.metadata；
    缺省 pages=1 行为与升级前逐字节一致（零漂移）；倍率下限 1 兜底。"""

    def setUp(self):
        self.audit, self.audit_path = tmp_audit()
        self.addCleanup(os.unlink, self.audit_path)

    def test_pages_default_one_zero_drift(self):
        a = RecordingFake("wenku", per_call=99)
        out = harvest_pool(["q1", "q2"], channels=[a], audit=self.audit,
                           timeout=10, registry={})
        self.assertEqual([c[2] for c in a.calls], [12, 12])  # 缺省=limit 12（原行为）
        self.assertEqual(len(out["wenku"]), 24)
        ls = lines_of(self.audit)
        self.assertEqual(ls[0]["event"], "pool_start")
        self.assertEqual((ls[0]["per_q"], ls[0]["pages"]), (12, 1))  # 审计如实记倍率

    def test_pages_multiplies_effective_limit(self):
        a = RecordingFake("wenku", per_call=99)
        out = harvest_pool(["q1"], channels=[a], per_q=12, pages=5, audit=self.audit,
                           timeout=10, registry={})
        self.assertEqual([c[2] for c in a.calls], [60])     # 12×5（任务口径 pages*12）
        self.assertEqual(len(out["wenku"]), 60)
        self.assertEqual(lines_of(self.audit)[0]["pages"], 5)

    def test_pages_floor_one(self):
        a = RecordingFake("doc88", per_call=99)
        harvest_pool(["q"], channels=[a], pages=0, audit=self.audit, timeout=10, registry={})
        self.assertEqual(a.calls[0][2], 12)                 # 倍率下限 1（不缩水不越界）


# ---------------- scale：2.0 A1 池规模目标账（在线渠道论 ≥1000） ----------------

class PoolScaleTargetTest(unittest.TestCase):
    """目标账 mock 算术断言：在线渠道数×12 词×per_q×pages ≥ 1000。
    离线渠道如实计 0（degrade 审计一行），绝不冒充在线。"""

    def setUp(self):
        self.audit, self.audit_path = tmp_audit()
        self.addCleanup(os.unlink, self.audit_path)

    def test_scale_default_full_fleet_meets_1000(self):
        # 七渠道全开缺省档：7×12 词×12 条=1008（压线达标=目标账下限定得刚硬）
        fakes = [RecordingFake(ch, per_call=999) for ch in DEFAULT_CHANNELS]
        queries = [f"q{i}" for i in range(12)]
        out = harvest_pool(queries, channels=fakes, audit=self.audit, timeout=30,
                           registry={})
        total = sum(len(v) for v in out.values())
        self.assertEqual(total, 7 * 12 * 12)
        self.assertGreaterEqual(total, 1000)
        self.assertEqual(lines_of(self.audit)[-1]["by_channel"],
                         {ch: 12 * 12 for ch in DEFAULT_CHANNELS})  # 实数对账

    def test_scale_deep_dive_one_channel_down_still_meets_1000(self):
        # pages=5 深挖档 + ima 离线（零请求零网络）：在线 6×12×60=4320 ≥ 1000
        fakes = [RecordingFake(ch, per_call=999) for ch in DEFAULT_CHANNELS if ch != "ima"]
        down = RecordingFake("ima")
        down.available = lambda: False
        down.reason = lambda: "无凭据: credentials.json 缺失"
        queries = [f"q{i}" for i in range(12)]
        out = harvest_pool(queries, channels=fakes + [down], pages=5, audit=self.audit,
                           timeout=30, registry={})
        self.assertEqual(out["ima"], [])                    # 离线如实计 0
        self.assertEqual(down.calls, [])
        total = sum(len(v) for v in out.values())
        self.assertEqual(total, 6 * 12 * 60)
        self.assertGreaterEqual(total, 1000)
        ls = lines_of(self.audit)
        self.assertTrue(any(l["event"] == "degrade" and l["channel"] == "ima" for l in ls))
        self.assertEqual(ls[-1]["by_channel"]["ima"], 0)    # pool_end 实数口径


# ---------------- scale24：5x 池扩容目标账（24 词×36 条×3 渠道×~75% ≥1000） ----------------

class DupRetentionFake(ChannelAdapter):
    """目标账假渠道：每查询回 min(36,limit) 条 = 27 条本查询独有 + 9 条复读本渠道
    首查询头 9 条——精确模拟 ~75% 跨词保留率（不同查询词命中同一批文件的真实形态）。"""

    def __init__(self, channel):
        self.channel = channel
        self.calls = []
        self._reason = ""

    def metadata(self, query, limit=12):
        self.calls.append((query, limit))
        n = min(36, max(0, int(limit)))
        anchor = self.calls[0][0]                    # 本渠道首查询（复读锚点）
        uniq = [FileMeta(title=f"{self.channel}::{query}::{j}", fmt="pdf")
                for j in range(n - 9)]
        dup = [FileMeta(title=f"{self.channel}::{anchor}::{j}", fmt="pdf")
               for j in range(min(9, n))]
        return uniq + dup


class PoolScale24x36x3Test(unittest.TestCase):
    """5x 目标账 mock 钉死算术：24 词 × 36 条（per_q=12×pages=3）× 3 渠道 ×
    ~75% 保留率 = 1944 ≥ 1000（用户令：池 1000+）；实数对账零造假。"""

    def setUp(self):
        self.audit, self.audit_path = tmp_audit()
        self.addCleanup(os.unlink, self.audit_path)

    def test_scale24_36x3_retention75_meets_1000(self):
        self.assertEqual(24 * 36 * 3 * 0.75, 1944.0)   # 目标账算术先钉死
        fakes = [DupRetentionFake(ch) for ch in ("wenku", "djyanbao", "doc88")]
        queries = [f"q{i}" for i in range(24)]
        out = harvest_pool(queries, channels=fakes, per_q=12, pages=3,
                           audit=self.audit, timeout=30, registry={})
        for f in fakes:                                # 有效 limit=per_q×pages=36 透传
            self.assertEqual([c[1] for c in f.calls], [36] * 24)
        raw = sum(len(v) for v in out.values())
        uniq = {m["title"] for v in out.values() for m in v}
        self.assertEqual(raw, 24 * 36 * 3)             # 原始面 2592（audit 可对账）
        self.assertEqual(len(uniq), 1944)              # 75% 保留率后净面（跨词去重）
        self.assertGreaterEqual(len(uniq), 1000)       # 用户令：池 1000+
        self.assertEqual(lines_of(self.audit)[-1]["by_channel"],
                         {ch: 24 * 36 for ch in ("wenku", "djyanbao", "doc88")})


# ---------------- ndv：2.0 A1 wenku_ndview 池级透传 ----------------

class RegistryNdviewPassthroughTest(unittest.TestCase):
    """build_registry/harvest_pool 的 wenku_ndview 透传（目录层 tags/类目开关）。"""

    def setUp(self):
        for k in ("KB_WENKU_NDVIEW",):
            os.environ.pop(k, None)                        # env 钉死：缺省态可断言
            self.addCleanup(os.environ.pop, k, None)

    def test_ndv_registry_default_env_driven_off(self):
        reg = build_registry()                             # wenku_ndview=None=env 自决
        self.assertFalse(reg["wenku"].ndview)              # 默认关（零网络纪律不变）
        self.assertIsNone(reg["wenku"].ndview_limiter)

    def test_ndv_registry_explicit_true_and_others_untouched(self):
        reg = build_registry(wenku_ndview=True)
        self.assertTrue(reg["wenku"].ndview)               # 显式开：tags/类目进 extra
        self.assertIsNotNone(reg["wenku"].ndview_limiter)  # 子配额限流器就位
        for ch in ("djyanbao", "doc88", "chinca", "dangdang", "cnki", "ima"):
            self.assertFalse(hasattr(reg[ch], "ndview"))   # 只透传 wenku，他家零漂移
        self.assertIs(build_registry(wenku_ndview=False)["wenku"].ndview, False)

    def test_ndv_harvest_pool_passes_to_self_built_registry(self):
        captured = {}
        orig = pool.build_registry

        def fake_registry(audit=None, wenku_ndview=None):
            captured["wenku_ndview"] = wenku_ndview
            return orig(audit, wenku_ndview=wenku_ndview)
        pool.build_registry = fake_registry
        self.addCleanup(setattr, pool, "build_registry", orig)
        audit, path = tmp_audit()
        self.addCleanup(os.unlink, path)
        harvest_pool([], wenku_ndview=True, audit=audit, timeout=5)  # 空查询零请求
        self.assertEqual(captured["wenku_ndview"], True)   # 透传到自建注册表


# ---------------- expand_queries ----------------

class ExpandQueriesTest(unittest.TestCase):
    TEXTS = ("给水利工程公司建一个EPC行业知识库",
             "整理医疗行业的临床指南和药典资料",
             "跨境电商店铺运营合规法规合集",
             "法律诉讼仲裁案例汇编")

    def test_expand_bounds_and_deterministic(self):
        for t in self.TEXTS:
            q1 = expand_queries(t)
            q2 = expand_queries(t)
            self.assertEqual(q1, q2, f"同输入必同输出: {t}")   # 纯本地确定性
            self.assertGreaterEqual(len(q1), 6, t)
            self.assertLessEqual(len(q1), 24, t)
            self.assertTrue(all(isinstance(q, str) and q.strip() for q in q1))
            self.assertEqual(len(set(q1)), len(q1))            # 无重复
        # 主查询=前 3 关键词合体（检索面最锐利的一腿）
        q = expand_queries(self.TEXTS[0])
        self.assertEqual(q[0], "水利 工程 EPC")

    def test_expand_thuocl_high_df_hits(self):
        # 注入微型词表（纯本地确定性）：公司(DF 大) > 行业(DF 小)
        idx = {"公司": {"caijing": 1000}, "行业": {"caijing": 100}}
        q = expand_queries(self.TEXTS[0], index=idx)
        joined = " | ".join(q)
        self.assertIn("水利 公司", q)                # 首关键词 × 高 DF 命中词
        self.assertIn("水利 行业", q)
        self.assertLess(q.index("水利 公司"), q.index("水利 行业"))  # DF 降序
        self.assertGreaterEqual(len(q), 6)

    def test_expand_real_lexicon_hits(self):
        q = expand_queries("法律诉讼仲裁案例汇编")  # 真词表命中：案例/仲裁（law 域高 DF）
        self.assertTrue(any("案例" in x or "仲裁" in x for x in q[1:]),
                        f"THUOCL 命中词应进扩展腿: {q}")

    def test_expand_lexicon_missing_degrades(self):
        original = pool._word_df_index
        pool._word_df_index.cache_clear()
        pool._word_df_index = lambda: {}             # 词表缺席如实退化
        try:
            for t in self.TEXTS:
                q = expand_queries(t)
                self.assertGreaterEqual(len(q), 6, t)  # 名词库兜底下限仍在
                self.assertLessEqual(len(q), 24, t)
        finally:
            pool._word_df_index = original
            pool._word_df_index.cache_clear()

    def test_expand_zero_keywords_fallback(self):
        q = expand_queries("。。！")                  # 零关键词零命中：原文+名词库路径
        self.assertEqual(q[0], "。。！")
        self.assertGreaterEqual(len(q), 6)


# ---------------- expand：5x 扩容（出词 12 → 24） ----------------

class ExpandDeep24Test(unittest.TestCase):
    """缺省满额 24 词：C(2,3) 二元+三元组合腿/THUOCL 高 DF 三路与自身腿/
    名词库两级兜底；确定性/无重复/主查询位契约钉全部不变。"""

    TEXTS = ExpandQueriesTest.TEXTS

    def test_expand_default_exactly_24_for_all_texts(self):
        for t in self.TEXTS:
            q = expand_queries(t)
            self.assertEqual(len(q), 24, f"缺省应满额 24: {t}")
            self.assertEqual(len(set(q)), len(q))          # 无重复
            self.assertEqual(expand_queries(t), q)         # 确定性不变
        # 主查询位契约钉（升级前后一致）
        self.assertEqual(expand_queries(self.TEXTS[0])[0], "水利 工程 EPC")

    def test_expand_c23_combo_leg(self):
        idx = {"公司": {"caijing": 1000}, "行业": {"caijing": 100}}
        q = expand_queries(self.TEXTS[0], index=idx)
        for bigram in ("水利 工程", "水利 EPC", "工程 EPC"):  # ④ C(3,2) 二元组合
            self.assertIn(bigram, q)
        # C(3,3) 三元组合与主查询同串：语义入队自然去重，不虚占词位
        self.assertEqual(q[0], "水利 工程 EPC")
        self.assertEqual(len(set(q)), len(q))

    def test_expand_high_df_three_keyword_legs_and_own_leg(self):
        idx = {"公司": {"caijing": 1000}, "行业": {"caijing": 100}}
        q = expand_queries(self.TEXTS[0], index=idx)
        for leg in ("水利 公司", "水利 行业",              # ③ 首关键词 × 高 DF
                    "工程 公司", "工程 行业",              # ⑤ 次关键词 × 高 DF
                    "EPC 公司",                            # ⑥ 第三关键词 × 高 DF
                    "公司", "行业"):                       # ⑦ 命中词自身精确腿
            self.assertIn(leg, q)

    def test_expand_missing_lexicon_still_reaches_24(self):
        original = pool._word_df_index
        pool._word_df_index.cache_clear()
        pool._word_df_index = lambda: {}                   # 词表缺席：组合腿+两级兜底仍满额
        try:
            for t in self.TEXTS:
                q = expand_queries(t)
                self.assertEqual(len(q), 24, t)
        finally:
            pool._word_df_index = original
            pool._word_df_index.cache_clear()

    def test_expand_zero_keywords_fallback_reaches_24(self):
        q = expand_queries("。。！")          # 零关键词路径：名词库 22 词+组合垫腿保满额
        self.assertEqual(len(q), 24)
        self.assertEqual(q[0], "。。！")
        self.assertEqual(len(set(q)), len(q))


# ---------------- dangdang 适配器（离线 mock） ----------------

def _dd_item(i, pid=None):
    return {"pid": pid or f"2849364{i}", "title": f"国际工程EPC总承包实务{i}",
            "url": f"http://product.dangdang.com/{pid or f'2849364{i}'}.html",
            "price": "59.00", "orig_price": "88.00", "discount": "6.7折",
            "comments": 120 + i, "authors": ["张水波"], "author_line": "张水波 何伯森编著",
            "publisher": "中国建筑工业出版社", "pubdate": "2021-06-01",
            "cover": None}


class _DdFakeClient:
    def __init__(self, items=None, zero=False, error=None, detail_error=False,
                 detail=None):
        self.items = items if items is not None else [_dd_item(1), _dd_item(2)]
        self.zero = zero
        self.error = error
        self.detail_error = detail_error
        self._detail = detail
        self.searches = []
        self.details = []

    def search(self, key, page=1):
        self.searches.append((key, page))
        if self.error:
            raise self.error
        if self.zero or page >= 2:
            # 复刻件口径：无更多结果即抛「search 零题录」（单页查询的真实翻页行为）
            raise RuntimeError(f"search 零题录 key={key!r} (SERP len=12000)")
        return list(self.items)

    def detail(self, pid):
        self.details.append(pid)
        if self.detail_error:
            raise RuntimeError(f"detail 形变 pid={pid} (len=800), 疑挑战/下架")
        d = dict(self._detail or {})
        d.setdefault("title", "书名")
        d.setdefault("toc_lines", ["第一章 绪论", "第二章 合同", "第三章 造价"])
        d.setdefault("toc_missing", False)
        d.setdefault("isbn", "9787112248001")
        d.setdefault("pages", "456")
        d.update(pid=pid)
        return d


class _DdBase(unittest.TestCase):
    def make(self, client, limiter=None, toc_top=None):
        self.audit, self.audit_path = tmp_audit()
        self.addCleanup(os.unlink, self.audit_path)
        return DangdangAdapter(
            limiter=limiter or RateLimiter(min_interval=0, daily_limit=500,
                                           name="dangdang-test", today=lambda: "d1"),
            audit=self.audit, toc_top=toc_top,
            client_factory=lambda timeout: client)


class DangdangMetaTest(_DdBase):
    def test_dangdang_mapping_and_toc_layer(self):
        ad = self.make(_DdFakeClient())
        metas = ad.metadata("国际工程 EPC", 12)
        self.assertEqual(len(metas), 2)
        m = metas[0]
        self.assertEqual(m.title, "国际工程EPC总承包实务1")
        self.assertEqual(m.fmt, "ebook")                     # 图书一律 ebook
        self.assertEqual((m.badge, m.perm), ("green_free", "green"))
        self.assertEqual(m.source_url, "http://product.dangdang.com/28493641.html")
        self.assertEqual(m.pages, 456)                       # m 站出版信息「页数」补强
        self.assertEqual(m.extra["toc_lines"][:2], ["第一章 绪论", "第二章 合同"])
        self.assertFalse(m.extra["toc_missing"])
        self.assertEqual(m.extra["isbn"], "9787112248001")
        self.assertEqual(m.extra["price"], "59.00")
        # 频控记账：1 搜索 + 2 目录层 = 3 额度；审计 request/toc 各如实一行
        self.assertEqual(ad.limiter.status()["count_today"], 3)
        ls = lines_of(self.audit)
        self.assertTrue(any(l["event"] == "request" and l["count"] == 2 for l in ls))
        self.assertEqual(sum(1 for l in ls if l["event"] == "toc"), 2)

    def test_dangdang_zero_results_honest_empty(self):
        ad = self.make(_DdFakeClient(zero=True))
        self.assertEqual(ad.metadata("量子纠缠占卜", 12), [])  # 零题录=合法空结果
        self.assertEqual(ad.limiter.status()["consecutive_errors"], 0)  # 不计连错
        ls = lines_of(self.audit)
        self.assertTrue(any(l["event"] == "request" and l["count"] == 0
                            and "zero" in l["detail"] for l in ls))

    def test_dangdang_detail_failsoft_keeps_records(self):
        ad = self.make(_DdFakeClient(detail_error=True))
        metas = ad.metadata("国际工程 EPC", 12)
        self.assertEqual(len(metas), 2)                      # 题录照常返回
        self.assertNotIn("toc_lines", metas[0].extra)        # 目录层缺席不造假
        self.assertIsNone(metas[0].pages)
        ls = lines_of(self.audit)
        self.assertEqual(sum(1 for l in ls if l["event"] == "toc_error"), 2)

    def test_dangdang_toc_top_zero(self):
        ad = self.make(_DdFakeClient(), toc_top=0)
        metas = ad.metadata("国际工程 EPC", 12)
        self.assertEqual(len(metas), 2)
        self.assertEqual(ad.limiter.status()["count_today"], 1)  # 只搜索腿
        self.assertNotIn("toc_lines", metas[0].extra)

    def test_dangdang_replica_missing_degrades(self):
        self.audit, self.audit_path = tmp_audit()
        self.addCleanup(os.unlink, self.audit_path)
        saved = dangdang_meta._REPLICA_PATH
        dangdang_meta._REPLICA_PATH = os.path.join(tempfile.gettempdir(), "no", "such.py")
        self.addCleanup(setattr, dangdang_meta, "_REPLICA_PATH", saved)
        ad = DangdangAdapter(limiter=RateLimiter(min_interval=0, today=lambda: "d1"),
                             audit=self.audit)
        self.assertFalse(ad.available())                     # 复刻件缺失=不可用
        self.assertEqual(ad.metadata("FIDIC", 12), [])       # fail-soft 不崩溃
        ls = lines_of(self.audit)
        self.assertTrue(any(l["event"] == "error" and "replica" in l["detail"] for l in ls))

    def test_dangdang_default_limiter_2s_300(self):
        for k in ("KB_DANGDANG_MIN_INTERVAL", "KB_DANGDANG_DAILY_LIMIT"):
            if k in os.environ:
                del os.environ[k]
        ad = DangdangAdapter()
        s = ad.limiter.status()
        self.assertEqual((s["min_interval"], s["daily_limit"]), (2.0, 300))

    def test_dangdang_consecutive_error_circuit(self):
        lim = RateLimiter(min_interval=0, daily_limit=500, error_threshold=2,
                          today=lambda: "d1", name="dangdang-test")
        ad = self.make(_DdFakeClient(error=RuntimeError("search SERP 形变 (len=300)")), limiter=lim)
        self.assertEqual(ad.metadata("q1", 12), [])          # 连错 1
        self.assertEqual(ad.metadata("q2", 12), [])          # 连错 2 → 熔断开
        self.assertTrue(ad.limiter.status()["circuit_open"])
        self.assertEqual(ad.metadata("q3", 12), [])          # 契约不崩溃
        self.assertIn("CircuitOpenError", ad.reason())
        ls = lines_of(self.audit)
        self.assertTrue(any(l["event"] == "degraded" and "CircuitOpenError" in l["detail"]
                            for l in ls))


# ---------------- cnki 适配器（离线 mock） ----------------

def _cnki_rec(i):
    return SimpleNamespace(
        title=f"国际工程EPC模式风险管理研究{i}", authors=["李四", "王五"],
        journal="建筑经济", year_issue="2024年5期", doc_type="期刊",
        keywords=["EPC", "风险管理"], snippet="针对国际工程EPC项目的风险识别与分配机制……",
        detail_url=f"https://www.cnki.com.cn/Article/CJFDTOTAL-JZJJ{i:04d}.htm",
        abstract="")


class _CnkiFakeClient:
    def __init__(self, pages=None, error=None):
        self.pages = pages if pages is not None else {1: [_cnki_rec(i) for i in range(10)]}
        self.error = error
        self.calls = []

    def search(self, keyword, page=1, order=2, warm=True):
        self.calls.append({"kw": keyword, "page": page, "warm": warm})
        if self.error:
            raise self.error
        recs = list(self.pages.get(page, []))
        return SimpleNamespace(keyword=keyword, page=page, total_count=57,
                               total_pages=20, records=recs)


class _CnkiBase(unittest.TestCase):
    def make(self, client, limiter=None):
        self.audit, self.audit_path = tmp_audit()
        self.addCleanup(os.unlink, self.audit_path)
        return CnkiAdapter(
            limiter=limiter or RateLimiter(min_interval=0, daily_limit=500,
                                           name="cnki-test", today=lambda: "d1"),
            audit=self.audit, client_factory=lambda timeout: client)


class CnkiMetaTest(_CnkiBase):
    def test_cnki_mapping_yellow_and_cautious(self):
        ad = self.make(_CnkiFakeClient())
        metas = ad.metadata("国际工程 EPC", 10)   # 恰一页：10 条收满不再翻页
        self.assertEqual(len(metas), 10)
        m = metas[0]
        self.assertEqual(m.title, "国际工程EPC模式风险管理研究0")
        self.assertEqual(m.fmt, "pdf")
        self.assertEqual(m.perm, "yellow")                   # 学术付费墙源铁律
        self.assertEqual(m.badge, "cnki_academic")           # 渠道显式徽章（防误路由）
        self.assertIsNone(m.pages)                           # 题录无页数如实 None
        self.assertTrue(m.source_url.startswith("https://www.cnki.com.cn/Article/"))
        self.assertIn("付费墙", m.extra["cautious"])         # 谨慎标注进 extra
        self.assertEqual(m.extra["journal"], "建筑经济")
        self.assertEqual(m.extra["doc_type"], "期刊")
        # 频控记账：预热腿+POST 腿=2 额度（腿数=请求口径）
        self.assertEqual(ad.limiter.status()["count_today"], 2)
        ls = lines_of(self.audit)
        self.assertTrue(any(l["event"] == "request" and l["count"] == 10
                            and "total=57" in l["detail"] for l in ls))

    def test_cnki_pagination_warm_once(self):
        client = _CnkiFakeClient(pages={1: [_cnki_rec(i) for i in range(10)],
                                        2: [_cnki_rec(10 + i) for i in range(10)]})
        ad = self.make(client)
        metas = ad.metadata("EPC", 15)
        self.assertEqual(len(metas), 15)
        self.assertEqual([c["warm"] for c in client.calls], [True, False])  # 仅首页预热
        self.assertEqual(ad.limiter.status()["count_today"], 3)             # 2+1 腿

    def test_cnki_blocked_degrades_empty(self):
        ad = self.make(_CnkiFakeClient(error=RuntimeError("listresult 403 (openresty)")))
        self.assertEqual(ad.metadata("EPC", 12), [])
        ls = lines_of(self.audit)
        self.assertTrue(any(l["event"] == "error" and "403" in l["detail"] for l in ls))
        self.assertEqual(ad.limiter.status()["consecutive_errors"], 1)

    def test_cnki_consecutive_error_circuit(self):
        lim = RateLimiter(min_interval=0, daily_limit=500, error_threshold=2,
                          today=lambda: "d1", name="cnki-test")
        ad = self.make(_CnkiFakeClient(error=RuntimeError("listresult 403")), limiter=lim)
        self.assertEqual(ad.metadata("q1", 12), [])
        self.assertEqual(ad.metadata("q2", 12), [])
        self.assertTrue(ad.limiter.status()["circuit_open"])
        self.assertEqual(ad.metadata("q3", 12), [])
        self.assertIn("CircuitOpenError", ad.reason())

    def test_cnki_replica_missing_degrades(self):
        self.audit, self.audit_path = tmp_audit()
        self.addCleanup(os.unlink, self.audit_path)
        saved = cnki_meta._REPLICA_PATH
        cnki_meta._REPLICA_PATH = os.path.join(tempfile.gettempdir(), "no", "such.py")
        self.addCleanup(setattr, cnki_meta, "_REPLICA_PATH", saved)
        ad = CnkiAdapter(limiter=RateLimiter(min_interval=0, today=lambda: "d1"),
                         audit=self.audit)
        self.assertFalse(ad.available())
        self.assertEqual(ad.metadata("EPC", 12), [])
        ls = lines_of(self.audit)
        self.assertTrue(any(l["event"] == "error" and "replica" in l["detail"] for l in ls))

    def test_cnki_default_limiter_4s_200(self):
        for k in ("KB_CNKI_MIN_INTERVAL", "KB_CNKI_DAILY_LIMIT"):
            if k in os.environ:
                del os.environ[k]
        ad = CnkiAdapter()
        s = ad.limiter.status()
        self.assertEqual((s["min_interval"], s["daily_limit"]), (4.0, 200))


# ---------------- 真网络腿（默认 skip，KB_LIVE=1 才跑） ----------------

@unittest.skipUnless(os.environ.get("KB_LIVE"), "live: set KB_LIVE=1 to run")
class LiveReplicaSmoke(unittest.TestCase):
    def test_live_dangdang_search_with_toc(self):
        audit, path = tmp_audit()
        self.addCleanup(os.unlink, path)
        ad = DangdangAdapter(audit=audit)
        self.assertTrue(ad.available())
        metas = ad.metadata("FIDIC", 6)
        self.assertGreaterEqual(len(metas), 1, "当当免登录搜索应至少命中 1 条")
        self.assertTrue(all(m.fmt == "ebook" for m in metas))

    def test_live_cnki_search_records(self):
        audit, path = tmp_audit()
        self.addCleanup(os.unlink, path)
        ad = CnkiAdapter(audit=audit)
        self.assertTrue(ad.available())
        metas = ad.metadata("国际工程 EPC", 10)
        self.assertGreaterEqual(len(metas), 1, "知网老端点免登录应至少命中 1 条")
        self.assertTrue(all(m.perm == "yellow" for m in metas))


if __name__ == "__main__":
    unittest.main()
