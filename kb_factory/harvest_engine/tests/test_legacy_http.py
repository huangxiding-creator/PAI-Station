# -*- coding: utf-8 -*-
"""FR6.2 单测：legacy 适配器 per-site 强制 http + 禁自动升级（R19 https 强升被劫持防线）
+ 探针级注册表规则（transport 表特例落表 + HealthRegistry 死站硬拒）+ woc88 实弹实探。

- 离线用例（零网络零桩）：enforce_transport 纯函数——构造 http URL 断言不升级（原样返回、
  结构性无 scheme 改写路径）/ https 域白名单外硬拒（woc88 型 http-only 站，含裸域/子域
  政策区归并）/ 非 http(s) scheme 拒；site_base_url 构造向强制（http 型站产 http 基址）；
  LegacyDownloadAdapter.plan 策略门（registry 判死硬拒=FR1.3 口径；R19 硬拒与死活判定独立）；
  探针级骨架射程声明（search 不产 registry 站点占位 FileMeta——数字零造假，抛
  NotImplementedError，由 T34 起类适配器逐站实化）。
- 实弹用例（@pytest.mark.live）：woc88 实探（FISH_PROBE #16 现实依据复核）——probe_site
  真网络两击制：443 连接级失败 + 80 正常（200）→ alive/ok_http_only 签名，每域 HTTP ≤2
  请求（探针纪律）。KB_HARVEST_SKIP_LIVE=1 时跳过并在输出明示。
- registry 一律写 tests/fixtures/ 参数化路径（不落默认位，不修改 .gitignore）。
"""
import os
import sys
from datetime import datetime
from pathlib import Path

import pytest

_KB_DIR = Path(__file__).resolve().parents[2]  # kb_factory/
sys.path.insert(0, str(_KB_DIR))  # worktree 阶段 kb_factory 无 __init__.py：顶层导入 harvest_engine
if not (_KB_DIR / "channel_adapters" / "base.py").exists():
    # worker worktree：kb_factory 未入 git → channel_adapters 只读复用主仓真身（供 kb_factory. 前缀解析）
    for _anc in _KB_DIR.parents:
        if (_anc / "kb_factory" / "channel_adapters" / "base.py").exists():
            sys.path.insert(1, str(_anc))
            break

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名
    from kb_factory.channel_adapters.base import FileMeta  # noqa: E402
    from kb_factory.harvest_engine.adapters.base import (  # noqa: E402
        LADDER_ORDER, HarvestPlan, LadderResult)
    from kb_factory.harvest_engine.adapters.legacy import (  # noqa: E402
        DEFAULT_TRANSPORT, HTTPS_ALLOWED_TRANSPORTS, LEGACY_SITES, TRANSPORT_AUTO,
        TRANSPORT_HTTP, TRANSPORT_HTTPS, TRANSPORTS, LegacyPolicyError, LegacySiteDead,
        LegacyTransportViolation, LegacyDownloadAdapter, SiteTransport,
        enforce_transport, site_base_url, transport_for)
    from kb_factory.harvest_engine.probe.health import (  # noqa: E402
        MAX_REQUESTS_PER_SITE, STATUS_ALIVE, STATUS_DEAD, HealthRegistry, probe_site)
except ImportError:
    from channel_adapters.base import FileMeta  # noqa: E402
    from harvest_engine.adapters.base import (  # noqa: E402
        LADDER_ORDER, HarvestPlan, LadderResult)
    from harvest_engine.adapters.legacy import (  # noqa: E402
        DEFAULT_TRANSPORT, HTTPS_ALLOWED_TRANSPORTS, LEGACY_SITES, TRANSPORT_AUTO,
        TRANSPORT_HTTP, TRANSPORT_HTTPS, TRANSPORTS, LegacyPolicyError, LegacySiteDead,
        LegacyTransportViolation, LegacyDownloadAdapter, SiteTransport,
        enforce_transport, site_base_url, transport_for)
    from harvest_engine.probe.health import (  # noqa: E402
        MAX_REQUESTS_PER_SITE, STATUS_ALIVE, STATUS_DEAD, HealthRegistry, probe_site)

_FIXTURES = Path(__file__).resolve().parent / "fixtures"
_REGISTRY_PATH = _FIXTURES / "legacy_registry_test.json"


def _fresh(path: Path) -> Path:
    _FIXTURES.mkdir(parents=True, exist_ok=True)
    if path.exists():
        path.unlink()
    return path


def _meta(url, title="帮帮文库某模板"):
    return FileMeta(title=title, fmt="doc", source_url=url)


def _registry_with(*marks):
    """构造 HealthRegistry（真符号）+ 指定 (site, status, reason) 标记行（fixtures 参数化路径）。"""
    reg = HealthRegistry(_fresh(_REGISTRY_PATH))
    for site, status, reason in marks:
        reg.mark(site, status, reason, now=datetime(2026, 10, 22, 12, 0, 0))
    return reg


# ---------------------------------------------------------------- transport 表：特例落表

def test_fr6_2_transport_table_special_cases_pinned():
    """FR6.2 特例落表：woc88=http-only（FISH_PROBE #16/R19）+ dq123=auto 转型站注记（#8）。"""
    assert set(LEGACY_SITES) == {"www.woc88.com", "www.dq123.com"}
    woc = LEGACY_SITES["www.woc88.com"]
    assert woc.transport == TRANSPORT_HTTP
    assert "FISH_PROBE #16" in woc.basis and "443" in woc.basis
    dq = LEGACY_SITES["www.dq123.com"]
    assert dq.transport == TRANSPORT_AUTO and "转型" in dq.note
    for entry in LEGACY_SITES.values():
        assert entry.transport in TRANSPORTS and entry.site and entry.basis
    # https 域白名单=transport 维度：https/auto 在册，http-only 站在白名单外
    assert HTTPS_ALLOWED_TRANSPORTS == (TRANSPORT_HTTPS, TRANSPORT_AUTO)
    assert TRANSPORT_HTTP not in HTTPS_ALLOWED_TRANSPORTS
    assert DEFAULT_TRANSPORT == TRANSPORT_AUTO  # 未落表站默认两 scheme 放行


# ---------------------------------------------------------------- R19 防线：禁自动升级（unit 层）

_HTTP_URLS = [
    "http://www.woc88.com/",
    "http://www.woc88.com/down-123456.html",
    "http://www.woc88.com:80/a/b.css?q=1",
    "http://img.woc88.com/a.png",      # 同政策区子域：http 原样放行
    "http://www.dq123.com/",           # auto 转型站：http 不升 https
    "http://www.docin.com/x.html",     # 未落表站（默认 auto）：同样不升
]


@pytest.mark.parametrize("url", _HTTP_URLS)
def test_fr6_2_http_url_never_upgraded(url):
    """FR6.2 构造 http URL 断言不升级：enforce_transport 原样返回（无任何 scheme 改写路径）。"""
    out = enforce_transport(url)
    assert out == url                       # 结构性零改写：返回值即输入
    assert out.startswith("http://")        # 不升 https（R19 劫持面关闭）


_HTTPS_OK = [
    ("https://www.dq123.com/", "auto 转型站在 https 白名单内（FISH_PROBE #8 SSL 正常）"),
    ("https://www.docin.com/x.html", "未落表站默认 auto：https 放行"),
]


_HTTPS_OK_IDS = [url.split("//")[1].split("/")[0] for url, _ in _HTTPS_OK]


@pytest.mark.parametrize("url,why", _HTTPS_OK, ids=_HTTPS_OK_IDS)
def test_fr6_2_https_inside_whitelist_passthrough(url, why):
    """https 域白名单内（auto/https 站）：https URL 原样放行，也不降级改写。"""
    assert enforce_transport(url) == url


_REJECTED = [
    ("https://www.woc88.com/", "woc88 http-only 特例：https 白名单外"),
    ("https://www.woc88.com/down-123.html", "深路径同拒"),
    ("https://woc88.com/", "裸域同政策区归并同拒"),
    ("https://img.woc88.com/a.png", "同政策区子域归并同拒（防线不因换子域旁路）"),
    ("ftp://www.woc88.com/x", "非 http(s) scheme"),
    ("file:///E:/x.html", "非 http(s) scheme"),
    ("www.woc88.com/x", "无 scheme"),
]


@pytest.mark.parametrize("url,kind", _REJECTED, ids=[kind.split("：")[0] for _, kind in _REJECTED])
def test_fr6_2_https_outside_whitelist_and_bad_scheme_hard_rejected(url, kind):
    """FR6.2/R19 https 域白名单外硬拒：woc88（含裸域/子域政策区）https 一律硬拒，
    非法 scheme/无主机亦拒——不做静默降级（降级会掩盖劫持面）。"""
    with pytest.raises(LegacyTransportViolation) as ei:
        enforce_transport(url)
    assert isinstance(ei.value, LegacyPolicyError)  # 异常族归属


def test_fr6_2_https_pinned_site_rejects_http_symmetrically():
    """transport=https 强制站（对称分支，注入表验证）：http URL 不做「升级改写」而是硬拒。"""
    table = {"strict.example": SiteTransport("strict.example", TRANSPORT_HTTPS, "测试注入行")}
    ok = "https://strict.example/x"
    assert enforce_transport(ok, transports=table) == ok
    with pytest.raises(LegacyTransportViolation):
        enforce_transport("http://strict.example/x", transports=table)
    # 注入表未覆盖的 host → 默认 auto（两 scheme 放行）
    assert enforce_transport("http://other.example/y", transports=table) == "http://other.example/y"


def test_fr6_2_site_base_url_constructive_forcing():
    """构造向强制：http 型站基址=http://（woc88）；auto/https 型=https://（现代默认）；
    构造结果自通过 enforce_transport（两函数共享同一表，天然自洽）。"""
    assert site_base_url("www.woc88.com") == "http://www.woc88.com/"
    assert site_base_url("www.dq123.com") == "https://www.dq123.com/"
    assert site_base_url("www.docin.com") == "https://www.docin.com/"
    for site in ("www.woc88.com", "www.dq123.com", "www.docin.com"):
        base = site_base_url(site)
        assert enforce_transport(base) == base


def test_fr6_2_transport_for_zone_matching_and_default():
    """transport_for 政策区匹配：精确/裸域/子域同区命中 woc88 行；区外站默认 auto 行。"""
    assert transport_for("www.woc88.com").transport == TRANSPORT_HTTP
    assert transport_for("woc88.com").transport == TRANSPORT_HTTP
    assert transport_for("down.woc88.com").transport == TRANSPORT_HTTP
    assert transport_for("www.dq123.com").transport == TRANSPORT_AUTO
    # 区外：FISH_PROBE 存活站（docin 等）与任意未知站均落默认行，不为无据站点扩政策面
    unknown = transport_for("www.docin.com")
    assert unknown.transport == DEFAULT_TRANSPORT and unknown.site == "www.docin.com"
    assert transport_for("notwoc88.com").transport == TRANSPORT_AUTO  # 区名不同不误伤


# ---------------------------------------------------------------- adapter：registry 规则消费

def test_fr6_2_plan_dead_site_hard_refused_by_registry():
    """FR6.2+FR1.3 registry 规则：周探针判死站 plan 硬拒移出调度——含 FISH_PROBE #19
    「连通≠存活」型（doc.vsharing 200 应答但已转为他用，transport 层放行也照拒）。"""
    reg = _registry_with(
        ("doc.vsharing.com", STATUS_DEAD, "repurposed_portal"),   # #19：转为他用
        ("www.woc88.com", STATUS_ALIVE, "ok_http_only"))
    ad = LegacyDownloadAdapter(reg)
    with pytest.raises(LegacySiteDead):
        ad.plan(_meta("https://doc.vsharing.com/some.doc"))
    # 裸域归并同拒（www↔裸域互认）
    reg2 = _registry_with(("www.woc88.com", STATUS_DEAD, "http_4xx:404"))
    with pytest.raises(LegacySiteDead):
        LegacyDownloadAdapter(reg2).plan(_meta("http://woc88.com/x"))


def test_fr6_2_plan_alive_http_ok_https_refused_unknown_status_not_guessed_dead():
    """woc88 存活态：http URL 过策略门产 HarvestPlan（政策事实落 extra）；https URL 即便
    站活也 R19 硬拒；未入 registry（状态未知）不猜死照常过门。"""
    ad = LegacyDownloadAdapter(_registry_with(("www.woc88.com", STATUS_ALIVE, "ok_http_only")))
    plan = ad.plan(_meta("http://www.woc88.com/down-123456.html"))
    assert isinstance(plan, HarvestPlan)
    assert plan.meta.extra["legacy_transport"] == TRANSPORT_HTTP
    assert plan.meta.extra["legacy_site"] == "www.woc88.com"
    assert plan.ladder_try == LADDER_ORDER and plan.red_check is True
    with pytest.raises(LegacyTransportViolation):
        ad.plan(_meta("https://www.woc88.com/down-123456.html"))
    plan2 = LegacyDownloadAdapter(_registry_with()).plan(
        _meta("http://www.dq123.com/ziliao/1.html"))
    assert plan2.meta.extra["legacy_transport"] == TRANSPORT_AUTO


def test_fr6_2_plan_source_url_required():
    """FileMeta 无站点 URL（source_url 空/无主机）：探针级无法按站定策，如实硬拒。"""
    with pytest.raises(LegacyPolicyError):
        LegacyDownloadAdapter(_registry_with()).plan(_meta(None))
    with pytest.raises(LegacyPolicyError):
        LegacyDownloadAdapter(_registry_with()).plan(_meta("not-a-url"))


def test_fr6_2_probe_level_skeleton_scope_honest():
    """探针级射程声明：channel=legacy；search 不产 registry 站点占位 FileMeta（数字零造假）
    抛 NotImplementedError；fetch_ladder/verify 属类适配器（T34 docin 起）实化。"""
    ad = LegacyDownloadAdapter(_registry_with())
    assert ad.channel == "legacy" and ad.site == "legacy"
    with pytest.raises(NotImplementedError):
        ad.search("模板", 10)
    plan = ad.plan(_meta("http://www.woc88.com/x.html"))
    with pytest.raises(NotImplementedError):
        ad.fetch_ladder(plan)
    with pytest.raises(NotImplementedError):
        ad.verify(LadderResult(ok=True))


# ---------------------------------------------------------------- 实弹实探（真实网络）

@pytest.mark.live
def test_fr6_2_live_woc88_http_only_evidence():
    """FR6.2 实弹实探（zero-mock）：woc88 443 连接级失败 + 80 正常（200）——per-site 强制
    http 的现实依据（FISH_PROBE #16 复核）；每域 HTTP ≤2 请求（探针纪律）。"""
    if os.environ.get("KB_HARVEST_SKIP_LIVE") == "1":
        print("[live-skip] KB_HARVEST_SKIP_LIVE=1：woc88 实探用例跳过（CI 场景明示）")
        pytest.skip("[live-skip] KB_HARVEST_SKIP_LIVE=1 实探跳过")
    health = probe_site("www.woc88.com")  # 默认真 fetch：https HEAD 失败自动降 http GET（两击制）
    print(f"[live] woc88 实探：status={health.status} reason={health.reason} "
          f"http_code={health.http_code} requests={health.requests} detail={health.detail}")
    assert health.requests <= MAX_REQUESTS_PER_SITE == 2  # 探针纪律：每域 HTTP ≤2
    assert health.status == STATUS_ALIVE
    assert health.reason == "ok_http_only"   # 「https 击连接级失败 + http 击 2xx」唯一签名
    assert health.http_code == 200           # 80 端口正常
    # 现实依据 ↔ 政策表自洽：实测 http-only ⇒ 表钉 transport=http（R19）
    assert LEGACY_SITES["www.woc88.com"].transport == TRANSPORT_HTTP
    assert transport_for("www.woc88.com").transport == TRANSPORT_HTTP


def teardown_module(module):
    """运行时产物不留仓：清理 fixtures 下本件临时 registry。"""
    if _REGISTRY_PATH.exists():
        _REGISTRY_PATH.unlink()
