# -*- coding: utf-8 -*-
"""T41P0 单测：doc88 PentAGI 研判 P0 五项清偿件（FR10.1 发布硬门）。

被测物 = kb_factory.harvest_engine.adapters.doc88 之 T41P0 增量件
（研判原文=PENTAGI/doc88_assessment.md，逐条对账）：
- P0-1（TLS 双态切换）+ P0-5（compress 谎报）：默认双腿显式 ``Accept-Encoding:
  identity``；curl(61) 走**同栈**低级 ``curl_cffi.Curl`` 兜底（impersonate 保留、
  关自动解码）——**绝不降级 urllib3**（原 plain requests 降级腿已删除：JA3
  Chrome↔Python-urllib3 切换=研判判定最直接封号触发点）。判件维持 R16 只认字节
  （真压缩体过不了魔数/长度/zlib 三重门，fail-closed 不落缓存）；
- P0-2（零间隔无频控）：``NetworkPacer`` 四层显式频控（单发抖动/info 独立 ≥2s/
  文档间冷却/会话冷却）+ 日配额熔断，接线**默认腿**（注入腿零接线零等待）；
- P0-3（info 双发）：``ConfigCache`` p_code 级会话缓存——plan/fetch_ladder 段间
  共享 1 发 info；WAF/404 不入缓存（fail-closed）；
- P0-4（free_probe 法律面）：``FREE_PROBE_DEFAULT=False`` 常量默认关。

测试纪律（WORKER_CONVENTIONS）：离线单测零网络——网络栈经 sys.modules 注入
curl_cffi 诱饵桩（桩=网络环境注入面，非 mock 被测物本体）；频控/缓存的时钟注入
点为确定性注入（clock/sleep/rng 注入）。
"""
import gzip
import sys
import types
from pathlib import Path

import pytest

_KB_DIR = Path(__file__).resolve().parents[2]  # kb_factory/
sys.path.insert(0, str(_KB_DIR))  # worktree 阶段 kb_factory 无 __init__.py：顶层导入 harvest_engine
if not (_KB_DIR / "channel_adapters" / "base.py").exists():
    for _anc in _KB_DIR.parents:  # worker worktree：channel_adapters 只读复用主仓真身
        if (_anc / "kb_factory" / "channel_adapters" / "base.py").exists():
            sys.path.insert(1, str(_anc))
            break

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名
    from kb_factory.channel_adapters.base import FileMeta
    from kb_factory.harvest_engine.adapters import doc88 as doc88_mod
    from kb_factory.harvest_engine.adapters.base import HarvestPlan
    from kb_factory.harvest_engine.adapters.doc88 import (
        ACCEPT_ENCODING_IDENTITY, CONFIG_CACHE_MAX_ENTRIES, DAILY_REQUEST_LIMIT,
        DOC_COOLDOWN_MAX_S, DOC_COOLDOWN_MIN_S, FREE_PROBE_DEFAULT,
        INFO_ENDPOINT_MIN_GAP_S, JITTER_FLOOR_S, JITTER_MAX_S, JITTER_MIN_S,
        SESSION_COOLDOWN_MAX_S, SESSION_COOLDOWN_MIN_S, SESSION_DOC_INTERVAL,
        ConfigCache, Doc88AssetError, Doc88DownloadAdapter, Doc88MirrorBlocked,
        Doc88RateBudgetError, Doc88WAFBlocked, NetworkPacer, PK_HEAD_LEN,
        _curl_cffi_get, _curl_cffi_get_bytes, discover_config, fetch_ebt_asset,
        fetch_free_download, info_url, page_url)
    from kb_factory.harvest_engine.codec import variant_b64 as vb
    from kb_factory.harvest_engine.codec.variant_b64 import DOC88_KEY2_NAME
    from kb_factory.harvest_engine.store.ledger import Store
except ImportError:  # pragma: no cover - worktree 阶段回退导入
    from channel_adapters.base import FileMeta
    from harvest_engine.adapters import doc88 as doc88_mod
    from harvest_engine.adapters.base import HarvestPlan
    from harvest_engine.adapters.doc88 import (
        ACCEPT_ENCODING_IDENTITY, CONFIG_CACHE_MAX_ENTRIES, DAILY_REQUEST_LIMIT,
        DOC_COOLDOWN_MAX_S, DOC_COOLDOWN_MIN_S, FREE_PROBE_DEFAULT,
        INFO_ENDPOINT_MIN_GAP_S, JITTER_FLOOR_S, JITTER_MAX_S, JITTER_MIN_S,
        SESSION_COOLDOWN_MAX_S, SESSION_COOLDOWN_MIN_S, SESSION_DOC_INTERVAL,
        ConfigCache, Doc88AssetError, Doc88DownloadAdapter, Doc88MirrorBlocked,
        Doc88RateBudgetError, Doc88WAFBlocked, NetworkPacer, PK_HEAD_LEN,
        _curl_cffi_get, _curl_cffi_get_bytes, discover_config, fetch_ebt_asset,
        fetch_free_download, info_url, page_url)
    from harvest_engine.codec import variant_b64 as vb
    from harvest_engine.codec.variant_b64 import DOC88_KEY2_NAME
    from harvest_engine.store.ledger import Store

WAF_BODY = "<html><body>网络环境安全验证，请稍后再试。</body></html>"
P0_P_CODE = "123456"


# ---------------------------------------------------------------- 确定性注入件

class _Recorder:
    """确定性文本网络注入件（Fetch 注入点）：URL 前缀→(status, body)；记录全部请求。"""

    def __init__(self, routes, default=(404, "")):
        self.routes = routes
        self.default = default
        self.urls = []

    def __call__(self, url, timeout):
        self.urls.append(url)
        for prefix, resp in self.routes.items():
            if url.startswith(prefix):
                return resp
        return self.default


class _BytesRecorder:
    """确定性二进制网络注入件（BytesFetch 注入点）：完整 URL→(200, bytes)；未登记 404。"""

    def __init__(self, routes):
        self.routes = dict(routes)
        self.calls = []

    def __call__(self, url, timeout):
        self.calls.append(url)
        if url in self.routes:
            return 200, self.routes[url]
        return 404, b""


class FakeClock:
    """可推进单调钟（pacer/缓存 TTL 判定的确定性注入点）。"""

    def __init__(self, start: float = 1000.0):
        self.now = float(start)

    def __call__(self) -> float:
        return self.now

    def advance(self, seconds: float) -> None:
        self.now += float(seconds)


class _SeqRng:
    """uniform 预置序列（耗尽后重复末值）——频控抽值的确定性注入。"""

    def __init__(self, draws):
        self._draws = list(draws)
        self._last = self._draws[-1]

    def uniform(self, low: float, high: float) -> float:
        return self._draws.pop(0) if self._draws else self._last


class _RangeRng:
    """按 uniform 调用区间给值的确定性 rng（会话冷却档特写：high=60 恒 45.0，余恒 1.0）。"""

    def uniform(self, low: float, high: float) -> float:
        return 45.0 if high == SESSION_COOLDOWN_MAX_S else 1.0


def _world_xml(p_code: str = P0_P_CODE, pages: int = 2,
               ebthost: str = "https://ebt999.doc88.com") -> str:
    """P0 离线世界 info XML（info 路注入物；key2 加密由用例做）。"""
    rows = "".join('<p n="%d"><e>1</e><w>595</w><h>841</h><p>%d</p><l>100</l></p>'
                   % (i, 1000 + i * 100) for i in range(1, pages + 1))
    return ('<?xml version="1.0" encoding="UTF-8"?><doc>'
            f'<p_code><![CDATA[{p_code}]]></p_code><p_name><![CDATA[P0 离线件]]></p_name>'
            f'<p_pagecount><![CDATA[{pages}]]></p_pagecount><p_swf><![CDATA[63-p0]]></p_swf>'
            f'<p_ebthost><![CDATA[{ebthost}]]></p_ebthost><p_404><![CDATA[0]]></p_404>'
            f'<p_struct><h n="1">1000</h>{rows}</p_struct></doc>')


# ---------------------------------------------------------------- curl_cffi 诱饵桩（网络栈注入，非 mock 被测物）

class _FakeCurl:
    """低级 Curl 诱饵桩：记录 setopt/impersonate；perform 经 WRITEFUNCTION 回灌预置体。"""

    def __init__(self, body: bytes = b"RAW-BYTES", status: int = 200):
        self._body, self._status = body, status
        self.opts: dict = {}
        self.impersonated = None
        self.closed = False

    def setopt(self, opt, val):
        self.opts[opt] = val

    def impersonate(self, target, default_headers=True):
        self.impersonated = (target, default_headers)

    def perform(self):
        self.opts["WRITEFUNCTION"](self._body)

    def getinfo(self, info):
        return self._status

    def close(self):
        self.closed = True


class _FakeResp:
    def __init__(self, status: int, content: bytes):
        self.status_code = status
        self.content = content


def _fake_curl_cffi(monkeypatch, *, get=None, curl_body: bytes = b"RAW-BYTES",
                    curl_status: int = 200):
    """sys.modules 注入 curl_cffi 诱饵模块（零网络）：requests.get=get（缺省 200 应答）、
    Curl/CurlOpt/CurlInfo=记录桩——回填 (curl_instances, get_calls)。"""
    curls = []
    get_calls = []

    def _curl_factory():
        c = _FakeCurl(body=curl_body, status=curl_status)
        curls.append(c)
        return c

    def _default_get(url, **kw):
        get_calls.append((url, kw))
        return _FakeResp(200, b"<html>ok</html>")

    def _recording_get(url, **kw):
        get_calls.append((url, kw))
        return get(url, **kw)

    fake = types.ModuleType("curl_cffi")
    fake.requests = types.SimpleNamespace(get=_recording_get if get else _default_get)
    fake.Curl = _curl_factory
    fake.CurlOpt = types.SimpleNamespace(
        URL="URL", WRITEFUNCTION="WRITEFUNCTION", TIMEOUT_MS="TIMEOUT_MS",
        FOLLOWLOCATION="FOLLOWLOCATION", MAXREDIRS="MAXREDIRS", HTTPHEADER="HTTPHEADER")
    fake.CurlInfo = types.SimpleNamespace(RESPONSE_CODE="RESPONSE_CODE")
    monkeypatch.setitem(sys.modules, "curl_cffi", fake)
    return curls, get_calls


def _no_pace(monkeypatch):
    """模块 pacer 替换为计数桩（离线零等待；计数供 P0-2 接线断言）。"""
    paced = []

    class _PacedStub:
        def pace(self, url):
            paced.append(url)

    monkeypatch.setattr(doc88_mod, "_PACER", _PacedStub())
    return paced


# ================================ P0-2 参数锚（研判 ②/⑤ 建议值逐字落位） ================================

def test_p02_research_thresholds_anchor():
    """P0-2 参数锚（漂移即红）：单发抖动 800~1500ms·下限 500ms；info ≥2s；文档间
    5~15s；每 8 文档会话冷却 30~60s；日配额 2000（研判 ⑤ 建议区间 1000~2000 取上限）。"""
    assert (JITTER_MIN_S, JITTER_MAX_S, JITTER_FLOOR_S) == (0.8, 1.5, 0.5)
    assert INFO_ENDPOINT_MIN_GAP_S == 2.0
    assert (DOC_COOLDOWN_MIN_S, DOC_COOLDOWN_MAX_S) == (5.0, 15.0)
    assert SESSION_DOC_INTERVAL == 8
    assert (SESSION_COOLDOWN_MIN_S, SESSION_COOLDOWN_MAX_S) == (30.0, 60.0)
    assert DAILY_REQUEST_LIMIT == 2000


# ================================ P0-1/P0-5：TLS 单态 + 显式编码声明 ================================

def test_p01_default_legs_declare_identity_encoding(monkeypatch):
    """P0-1/P0-5：默认双腿显式 ``Accept-Encoding: identity``（覆写 impersonate 默认
    gzip/deflate/br/zstd——本地 0.16.3 实测服务端收到的即 identity）+ impersonate=chrome。"""
    _no_pace(monkeypatch)
    _, get_calls = _fake_curl_cffi(monkeypatch)
    url = info_url(P0_P_CODE)
    status, text = _curl_cffi_get(url, 5.0)
    assert (status, text) == (200, "<html>ok</html>") and len(get_calls) == 1
    got_url, kw = get_calls[0]
    assert got_url == url and kw["impersonate"] == "chrome"
    assert kw["headers"]["Accept-Encoding"] == "identity"      # 主动声明（P0-5 修法）
    assert kw["headers"]["User-Agent"] == doc88_mod.DOC88_UA
    assert kw["headers"]["Referer"] == doc88_mod.DOC88_REFERER
    # 二进制腿同口径
    status2, data = _curl_cffi_get_bytes("https://ebt999.doc88.com/getebt-x.ebt", 5.0)
    assert (status2, data) == (200, b"<html>ok</html>")
    assert get_calls[1][1]["headers"]["Accept-Encoding"] == "identity"


def test_p01_curl61_falls_back_same_stack_never_urllib3(monkeypatch):
    """P0-1 主断言：curl(61)（CDN 谎报 compress）→ 同栈低级 Curl 兜底（impersonate
    保留、关自动解码原样收字节）——**plain requests/urllib3 降级腿不存在**（研判判定
    JA3 双态切换=最直接封号触发点；非 curl 栈零触碰）。"""
    _no_pace(monkeypatch)

    def _boom_61(url, **kw):
        raise RuntimeError("Failed to perform, curl: (61) Unrecognized content "
                           "encoding type. See https://curl.se/libcurl/")

    curls, get_calls = _fake_curl_cffi(
        monkeypatch, get=_boom_61, curl_body=b"YBD\x02-raw-asset-bytes")
    status, data = _curl_cffi_get_bytes("https://ebt999.doc88.com/getebt-x.ebt", 5.0)
    assert (status, data) == (200, b"YBD\x02-raw-asset-bytes")   # 原样字节（关自动解码）
    assert len(get_calls) == 1 and len(curls) == 1               # requests 腿一次+低级兜底一次
    c = curls[0]
    assert c.impersonated == ("chrome", False)                   # TLS 栈保留；头自管（default_headers=False）
    assert b"Accept-Encoding: identity" in c.opts["HTTPHEADER"]  # 兜底腿同样显式 identity
    assert any(h.startswith(b"User-Agent: ") for h in c.opts["HTTPHEADER"])
    assert c.closed
    # 文本腿同口径：curl(61) → 同栈兜底 → utf-8 文本（\x02 为合法 ASCII 控制符原样解出）
    status2, text = _curl_cffi_get(page_url(P0_P_CODE), 5.0)
    assert (status2, text) == (200, "YBD\x02-raw-asset-bytes")
    assert len(curls) == 2


def test_p01_non_content_encoding_errors_propagate_no_fallback(monkeypatch):
    """P0-1 边界：非 curl(61) 错（如 28 超时）原样上抛，不走兜底腿（兜底=内容编码谎报
    专用，不吞网络故障）。"""
    _no_pace(monkeypatch)

    def _boom_28(url, **kw):
        raise RuntimeError("Failed to perform, curl: (28) Timeout was reached")

    curls, _ = _fake_curl_cffi(monkeypatch, get=_boom_28)
    with pytest.raises(RuntimeError, match=r"\(28\)"):
        _curl_cffi_get_bytes("https://ebt999.doc88.com/getebt-x.ebt", 5.0)
    with pytest.raises(RuntimeError, match=r"\(28\)"):
        _curl_cffi_get(info_url(P0_P_CODE), 5.0)
    assert curls == []                                    # 低级 Curl 零触碰


def test_p05_compressed_bodies_fail_closed_byte_gates(tmp_path):
    """P0-5：字节判件不依赖 header——CDN 若真回压缩体（而非谎报），魔数/zlib 门
    fail-closed 拒收不落缓存（研判工人注③「坏编码走 fail-closed」的用例固化）。"""
    assert ACCEPT_ENCODING_IDENTITY == "identity"          # 显式声明常量锚
    # PH：真 gzip 体（长度对上配置口径）→ 魔数门拒（gzip 1f8b ∉ YBD 前缀族）
    gzip_ph = gzip.compress(b"YBD-fake-payload" * 10)
    ph_url = "https://ebt999.doc88.com/getebt-ph-gzip.ebt"
    with pytest.raises(Doc88AssetError, match="魔数"):
        fetch_ebt_asset(name="ph-gzip", url=ph_url, kind="ph", level=1,
                        expected_bytes=len(gzip_ph), p_code=P0_P_CODE,
                        store=Store(str(tmp_path / "s1")),
                        fetch=_BytesRecorder({ph_url: gzip_ph}))
    assert Store(str(tmp_path / "s1")).get_asset("ph-gzip") is None   # 坏字节不进库
    # PK：真 gzip 体（长度对上）→ zlib 成流门拒
    gzip_pk = bytes(range(PK_HEAD_LEN)) + gzip.compress(b"page-body" * 8)
    pk_url = "https://ebt999.doc88.com/getebt-pk-gzip.ebt"
    with pytest.raises(Doc88AssetError, match="zlib"):
        fetch_ebt_asset(name="pk-gzip", url=pk_url, kind="pk", level=1,
                        expected_bytes=len(gzip_pk), p_code=P0_P_CODE,
                        page_no=1, store=Store(str(tmp_path / "s2")),
                        fetch=_BytesRecorder({pk_url: gzip_pk}))
    assert Store(str(tmp_path / "s2")).get_asset("pk-gzip") is None


# ================================ P0-2：NetworkPacer 显式频控 ================================

def test_p02_pacer_jitter_doc_cooldown_and_info_gap_deterministic():
    """P0-2：单发抖动/文档间冷却/info 独立间隔三层的确定性算术（clock/sleep/rng 注入）。"""
    clock = FakeClock(start=1000.0)
    waits: list[float] = []

    def _sleep(seconds: float) -> None:
        waits.append(round(seconds, 6))
        clock.advance(seconds)                     # sleep 推进注入钟（真实世界等价）

    pacer = NetworkPacer(clock=clock, sleep=_sleep, rng=_SeqRng([1.0]))
    pacer.pace(info_url("1111111111"))             # 首发：零等待
    assert waits == [] and pacer.stats()["count_today"] == 1
    pacer.pace("https://ebt999.doc88.com/getebt-cipher.ebt")   # ebt 名密文无 p_code：只吃抖动
    assert waits == [1.0]                          # clock=1001
    pacer.pace(page_url("2222222222"))             # 文档切换：抖动 1.0 与冷却 1.0 同值 → 1.0
    assert waits == [1.0, 1.0]                     # clock=1002；docs_seen=2
    pacer.pace(info_url("2222222222"))             # 同文档 info：抖动 1.0 生效（info 基准=1000 已远）
    assert waits == [1.0, 1.0, 1.0]                # clock=1003；last_info=1003
    pacer.pace(info_url("2222222222"))             # 紧接第二发 info：间隔 ≥2s 胜过抖动 1.0
    assert waits == [1.0, 1.0, 1.0, 2.0]
    assert pacer.stats() == {"count_today": 5, "daily_limit": DAILY_REQUEST_LIMIT,
                             "docs_seen": 2, "last_doc": "2222222222"}


def test_p02_pacer_jitter_floor_and_quota_circuit():
    """P0-2：抖动抽取值低于 500ms 下限抬到 0.5；日配额超限熔断（Doc88RateBudgetError，
    fail-closed 发不出去）。"""
    clock = FakeClock()
    waits = []

    def _sleep(seconds: float) -> None:
        waits.append(seconds)
        clock.advance(seconds)

    pacer = NetworkPacer(clock=clock, sleep=_sleep, rng=_SeqRng([0.3]), daily_limit=2)
    pacer.pace(page_url("1111111111"))             # 首发
    pacer.pace(page_url("1111111111"))             # 同文档页面：抖动 0.3 → 下限 0.5 生效
    assert waits == [0.5]
    with pytest.raises(Doc88RateBudgetError, match="日请求配额"):
        pacer.pace(page_url("1111111111"))         # 第 3 发 > 日配额 2 → 熔断
    assert pacer.stats()["count_today"] == 2       # 熔断发不计（发不出去）


def test_p02_pacer_session_cooldown_every_n_docs():
    """P0-2：会话冷却——每 SESSION_DOC_INTERVAL=8 文档加一档 30~60s 长歇（打破长会话
    连续流量特征；研判 ② 关键结论 3）。"""
    clock = FakeClock()
    waits = []

    def _sleep(seconds: float) -> None:
        waits.append(round(seconds, 3))
        clock.advance(seconds)

    pacer = NetworkPacer(clock=clock, sleep=_sleep, rng=_RangeRng())
    for i in range(SESSION_DOC_INTERVAL):
        pacer.pace(page_url(f"{1111111111 + i:011d}"))
    # 首 6 个文档边界只吃抖动/文档冷却（恒 1.0）；第 8 个文档边界恰触发一档 45.0 会话冷却
    assert waits == [1.0] * (SESSION_DOC_INTERVAL - 2) + [45.0]
    assert pacer.stats()["docs_seen"] == SESSION_DOC_INTERVAL


def test_p02_default_legs_paced_injected_legs_untouched(monkeypatch):
    """P0-2 接线面：默认双腿每发先过 pacer（镜像硬拒在频控之前——零触碰零等待）；
    注入腿（discover_config 传入 Fetch）零接线零等待（确定性测试面不受频控影响）。"""
    paced = _no_pace(monkeypatch)
    _fake_curl_cffi(monkeypatch)
    _curl_cffi_get(info_url(P0_P_CODE), 5.0)
    _curl_cffi_get_bytes("https://ebt999.doc88.com/getebt-x.ebt", 5.0)
    assert paced == [info_url(P0_P_CODE), "https://ebt999.doc88.com/getebt-x.ebt"]
    with pytest.raises(Doc88MirrorBlocked):        # 镜像域：请求前硬拒先于频控
        _curl_cffi_get("https://doc88.piglin.eu.org/p-123456.html", 5.0)
    assert len(paced) == 2
    cfg = discover_config(P0_P_CODE, fetch=_Recorder(
        {"https://www.doc88.com/doc.php?act=info":
         (200, vb.encode(DOC88_KEY2_NAME, _world_xml()))}), timeout=5.0)
    assert cfg.source == "info_xml" and len(paced) == 2    # 注入腿零触碰模块 pacer


# ================================ P0-3：ConfigCache 段间共享 ================================

def test_p03_adapter_plan_and_fetch_ladder_share_one_info(tmp_path):
    """P0-3 主断言：plan → fetch_ladder 段间共享缓存——同 p_code 会话内 info 端点
    恰 1 发（研判实测 3.5 发/文档 → 1 发/文档）。"""
    txt = _Recorder({"https://www.doc88.com/doc.php?act=info":
                     (200, vb.encode(DOC88_KEY2_NAME, _world_xml()))})
    adapter = Doc88DownloadAdapter(fetch=txt, fetch_bytes=_BytesRecorder({}),
                                   store=Store(str(tmp_path / "store")),
                                   work_dir=str(tmp_path / "work"))
    meta = FileMeta(title="P0 件", fmt="pdf")
    meta.extra["p_code"] = P0_P_CODE
    adapter.plan(meta)
    assert txt.urls == [info_url(P0_P_CODE)]
    result = adapter.fetch_ladder(HarvestPlan(meta=meta))       # ebt 资产缺→ok=False（无关紧要）
    assert result.ok is False
    assert txt.urls == [info_url(P0_P_CODE)]                    # 段间缓存命中：零追加 info
    assert adapter._config_cache.stats()["hits"] == 1


def test_p03_config_cache_ttl_expiry_and_fifo_bound():
    """P0-3 边界：TTL 过期如实 miss 重取；条目上限 FIFO 逐出（有界防长跑膨胀）。"""
    clock = FakeClock()
    cache = ConfigCache(ttl_s=10.0, clock=clock)
    cfg = discover_config(P0_P_CODE, fetch=_Recorder(
        {"https://www.doc88.com/doc.php?act=info":
         (200, vb.encode(DOC88_KEY2_NAME, _world_xml()))}))
    cache.put(P0_P_CODE, cfg)
    assert cache.get(P0_P_CODE) is cfg
    clock.advance(10.5)                                         # TTL 外
    assert cache.get(P0_P_CODE) is None
    assert cache.stats() == {"hits": 1, "misses": 1, "entries": 0, "ttl_s": 10.0}
    bounded = ConfigCache(clock=clock)
    for i in range(CONFIG_CACHE_MAX_ENTRIES + 3):
        bounded.put(f"{90000000000 + i}", cfg)
    assert bounded.stats()["entries"] == CONFIG_CACHE_MAX_ENTRIES
    assert bounded.get("90000000000") is None                   # 最老条目已 FIFO 逐出


def test_p03_waf_and_failures_never_cached(tmp_path):
    """P0-3 fail-closed：WAF 不入缓存——下次如实重探双路（不固化瞬态故障）。"""
    txt = _Recorder({"https://www.doc88.com/": (200, WAF_BODY)})
    adapter = Doc88DownloadAdapter(fetch=txt, fetch_bytes=_BytesRecorder({}),
                                   store=Store(str(tmp_path / "s")),
                                   work_dir=str(tmp_path / "w"))
    meta = FileMeta(title="被墙件", fmt="pdf")
    meta.extra["p_code"] = P0_P_CODE
    with pytest.raises(Doc88WAFBlocked):
        adapter.plan(meta)
    with pytest.raises(Doc88WAFBlocked):                        # 不缓存坏态：双路重探
        adapter.plan(meta)
    assert len(txt.urls) == 4                                   # 两轮 × 双路各一发
    assert adapter._config_cache.stats()["entries"] == 0


# ================================ P0-4：free_probe 默认关（法律面） ================================

def test_p04_free_probe_default_off_and_compliance_note():
    """P0-4：``FREE_PROBE_DEFAULT=False`` 常量默认关（生产保持关闭）；显式 opt-in 才开；
    免费直下「登录态需求未验证=挂账」注记在案（上线前合规验证腿的文档锚）。"""
    assert FREE_PROBE_DEFAULT is False
    assert Doc88DownloadAdapter()._free_probe is False
    assert Doc88DownloadAdapter(free_probe=True)._free_probe is True
    assert "挂账" in fetch_free_download.__doc__                # 合规挂账文档锚（docstring）
    assert "鉴权门槛" in Doc88DownloadAdapter.__init__.__doc__  # 选通件合规注记锚
