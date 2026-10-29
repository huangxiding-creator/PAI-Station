# -*- coding: utf-8 -*-
"""T07 单测：无头浏览器生命周期四合一件 browser/kit.py（支撑 FR2/FR3/FR5/FR7）。

被测物 = kb_factory.harvest_engine.browser.kit（真 Playwright Chromium，sync API）：
- 离线单测零外网：走 about:blank / data: URL / 本机拒连端口 / page 级本地 fulfill，
  屏蔽闸门在连接前被 abort，全程不触外网（.invalid 域 RFC 2606 兜底）；
- 实弹烟测（@pytest.mark.live）= 真实网络任一公开页加载 + UA 断言，
  KB_HARVEST_SKIP_LIVE=1 时跳过（跳过原因在 skip reason 里明示，公约第 4 条）；
- 禁止测试并行开多浏览器：全模块共用一个 module 级 chromium fixture（launch/close 由 fixture 管）。

三策略口径（SYNTHESIS §2-9 + 任务卡）：
- wenku：随机桌面 UA 全程复用 + cookie 串逐条注入 .baidu.com（domain 带点）+ 闸门三组正则屏蔽；
- csdn：硬编码伪装 UA + persist 分区（storage_state 持久化）+ 广告域 substring 屏蔽 + expect_download；
- book118：仅首跳（真浏览器过指纹墙取首跳 HTML），数据层纯 http 不进本件。
"""
import json
import os
import random
import sys
import time
from pathlib import Path

import pytest
from playwright.sync_api import Error as PlaywrightError
from playwright.sync_api import sync_playwright

_KB_DIR = Path(__file__).resolve().parents[2]  # kb_factory/
sys.path.insert(0, str(_KB_DIR))  # worktree 阶段 kb_factory 无 __init__.py：顶层导入 harvest_engine
if not (_KB_DIR / "channel_adapters" / "base.py").exists():
    # worker worktree：kb_factory 未入 git → channel_adapters 只读复用主仓真身（供 kb_factory. 前缀解析）
    for _anc in _KB_DIR.parents:
        if (_anc / "kb_factory" / "channel_adapters" / "base.py").exists():
            sys.path.insert(1, str(_anc))
            break

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名
    from kb_factory.harvest_engine.browser.kit import (  # noqa: E402
        CSDN_AD_DOMAINS, CSDN_COOKIE_DOMAIN, CSDN_COOKIE_TTL_SECONDS, CSDN_UA, CSDN_VIEWPORT,
        DESKTOP_UA_POOL, DOWNLOAD_TIMEOUT_MS, WENKU_BLOCKLIST_GROUPS, WENKU_BLOCKLIST_REGEXES,
        WENKU_COOKIE_DOMAIN, WENKU_VIEWPORT, BrowserKit, capture_download, inject_cookies,
        is_url_blocked, parse_cookie_str, pick_desktop_ua, save_download)
except ImportError:
    from harvest_engine.browser.kit import (  # noqa: E402
        CSDN_AD_DOMAINS, CSDN_COOKIE_DOMAIN, CSDN_COOKIE_TTL_SECONDS, CSDN_UA, CSDN_VIEWPORT,
        DESKTOP_UA_POOL, DOWNLOAD_TIMEOUT_MS, WENKU_BLOCKLIST_GROUPS, WENKU_BLOCKLIST_REGEXES,
        WENKU_COOKIE_DOMAIN, WENKU_VIEWPORT, BrowserKit, capture_download, inject_cookies,
        is_url_blocked, parse_cookie_str, pick_desktop_ua, save_download)

_LIVE_SKIP = os.environ.get("KB_HARVEST_SKIP_LIVE") == "1"


@pytest.fixture(scope="module")
def chromium():
    """module 级唯一浏览器：fixture 管 launch/close（公约：禁止测试并行开多浏览器）。"""
    with sync_playwright() as pw:
        browser = pw.chromium.launch(headless=True)
        yield browser
        browser.close()


@pytest.fixture
def kit(chromium):
    """每测一个 BrowserKit（同一浏览器内开上下文）；种子固定=UA 确定性；teardown 收口断言零泄漏。"""
    k = BrowserKit(chromium, rng=random.Random(20261022))
    yield k
    k.close_all()
    assert chromium.contexts == [], "生命周期泄漏：kit 收口后浏览器仍有未关上下文"


# ---------------------------------------------------------------- FR2 wenku 策略

def test_fr2_random_desktop_ua_pool_and_whole_life_reuse(kit):
    """FR2/WENKU_SPEC §4.1-1：随机桌面 UA 池 + 每生命周期随机一个、全程复用（csdn 例外=硬编码）。"""
    assert len(DESKTOP_UA_POOL) >= 6 and len(set(DESKTOP_UA_POOL)) == len(DESKTOP_UA_POOL)
    for ua in DESKTOP_UA_POOL:
        assert ua.startswith("Mozilla/5.0") and "Mobile" not in ua  # 仅桌面
    assert any("Windows NT" in ua for ua in DESKTOP_UA_POOL)
    assert any("Macintosh" in ua for ua in DESKTOP_UA_POOL)
    rng = random.Random(0)
    picks = {pick_desktop_ua(rng) for _ in range(200)}
    assert picks <= set(DESKTOP_UA_POOL) and len(picks) >= 3  # 随机但只出自桌面池
    assert kit.user_agent in DESKTOP_UA_POOL
    assert WENKU_VIEWPORT == {"width": 1400, "height": 900}  # A:92 隐藏窗尺寸
    ua_seen = []
    for _ in range(2):
        ctx = kit.wenku_context("BDUSS=demo; STOKEN=demo2")
        page = ctx.new_page()
        page.goto("about:blank")
        ua_seen.append(page.evaluate("navigator.userAgent"))
    assert ua_seen == [kit.user_agent, kit.user_agent]  # 跨上下文/跨页全程复用同一随机桌面 UA
    k2 = BrowserKit(kit.browser, rng=random.Random(1))
    assert k2.user_agent in DESKTOP_UA_POOL and k2.open_context_count == 0


def test_fr2_wenku_cookie_string_injected_per_cookie_on_dotted_domain(kit):
    """FR2/WENKU_SPEC §4.1-2：cookie 串按 ';' 拆、逐条注入，domain 带点 .baidu.com、会话期。"""
    raw = "BDUSS=abc123==; STOKEN=zzz; PSTM=1690000000"
    ctx = kit.wenku_context(raw)
    got = ctx.cookies("https://wenku.baidu.com/")
    by_name = {c["name"]: c for c in got}
    assert set(by_name) == {"BDUSS", "STOKEN", "PSTM"}  # 逐条注入=每对独立成条
    assert by_name["BDUSS"]["value"] == "abc123=="  # 值含 '=' 仅按第一个 '=' 拆（base64 安全）
    assert by_name["STOKEN"]["value"] == "zzz"
    assert WENKU_COOKIE_DOMAIN == ".baidu.com"
    assert all(c["domain"] == ".baidu.com" and c["path"] == "/" for c in got)  # domain 带点
    assert all(c["expires"] == -1 for c in got)  # 原作 cookieStrToArray 无 expires=会话 cookie
    assert inject_cookies(ctx, "EXTRA1=1; EXTRA2=2", domain=WENKU_COOKIE_DOMAIN) == 2
    assert len(ctx.cookies()) == 5
    with pytest.raises(ValueError) as ei:  # 畸形段 fail-fast，且错误信息不回显段内容（防凭据入日志）
        parse_cookie_str("ok=1; SECRETSEGMENT")
    assert "SECRETSEGMENT" not in str(ei.value)
    assert parse_cookie_str("") == [] and parse_cookie_str("a=1;;b=2") == [("a", "1"), ("b", "2")]


def test_fr2_wenku_route_gate_three_groups(kit):
    """FR2/WENKU_SPEC §4.1-3 闸门三组（静态/埋点/业务噪声）：清单参数化 + 真浏览器 abort 集成。"""
    assert set(WENKU_BLOCKLIST_GROUPS) == {"static", "tracking", "business_noise"}  # 闸门三组齐
    assert WENKU_BLOCKLIST_GROUPS["static"] == (
        r"\.(png|jpg|jpeg|gif|svg|woff|woff2|ttf|css)(\?|$)",)
    assert WENKU_BLOCKLIST_GROUPS["tracking"] == (
        r"click\.gif|hmlog|fclog|sclog|pbslog|wkctj|hm\.baidu|hectorstatic",)
    assert WENKU_BLOCKLIST_GROUPS["business_noise"] == (
        r"wenku\.baidu\.com/(gsula|gdoc|goods|user|customer|ndocview/(geteditedbydocids|incrview|interface))",)
    assert len(WENKU_BLOCKLIST_REGEXES) == sum(len(v) for v in WENKU_BLOCKLIST_GROUPS.values())
    blocked = [
        "https://ss1.bdstatic.com/font/icon.svg",                       # 静态组
        "https://ss0.baidu.com/css/base.css?v=2026",                    # 静态组（带 query）
        "https://hm.baidu.com/hm.js?abcdef",                            # 埋点组
        "https://wenku.baidu.com/static/track/click.gif?t=1",           # 埋点组
        "https://hectorstatic.baidu.com/a.js",                          # 埋点组
        "https://wenku.baidu.com/gdoc/preview?x=1",                     # 业务噪声组
        "https://wenku.baidu.com/user/center",                          # 业务噪声组
        "https://wenku.baidu.com/ndocview/geteditedbydocids?doc_id=1",  # 业务噪声组
        "https://wenku.baidu.com/ndocview/incrview",                    # 业务噪声组
    ]
    allowed = [
        "https://wenku.baidu.com/view/abc123DEfg.html",        # view 页（首跳）
        "https://wenku.baidu.com/ndocview/readerinfo?doc_id=abc&pn=1",  # 补页关键端点必须放行
        "https://wkretype.bdimg.com/retype/pipe/123?pn=1",     # 字体 CSS（数据层直连）
        "https://wkrtcs.bdimg.com/rtcs/getbdjson?bucketNum=2",  # XML 降级端点
    ]
    for url in blocked:
        assert is_url_blocked(url, regexes=WENKU_BLOCKLIST_REGEXES), url
    for url in allowed:
        assert not is_url_blocked(url, regexes=WENKU_BLOCKLIST_REGEXES), url
    # 真浏览器集成（零外网）：三组各取一例，主帧导航在连接前被 abort
    for url in ("https://ss0.baidu.com/base.css",               # 静态组
                "https://hm.baidu.com/hm.js?x=1",               # 埋点组
                "https://wenku.baidu.com/gdoc/x"):              # 业务噪声组
        ctx = kit.wenku_context()
        page = ctx.new_page()
        with pytest.raises(PlaywrightError, match="net::ERR_FAILED"):
            page.goto(url, timeout=8000)
    # 放行路径的 continue 证据由实弹烟测覆盖（离线 continue_ 必然出网，此处不造桩）


# ---------------------------------------------------------------- FR5 csdn 策略

def test_fr5_csdn_persist_partition_storage_state_roundtrip(kit, tmp_path):
    """FR5/CSDN_SPEC §1.2-2：persist 分区=storage_state 持久化，cookie 域 .csdn.net + 30 天 expires。"""
    assert CSDN_COOKIE_DOMAIN == ".csdn.net" and CSDN_COOKIE_TTL_SECONDS == 30 * 86400
    assert CSDN_VIEWPORT == {"width": 1280, "height": 900}
    storage = tmp_path / "csdn_state.json"
    ctx = kit.csdn_context("UserName-Token=tok123; p_uid=7", storage_path=storage)
    page = ctx.new_page()
    page.goto("about:blank")
    assert page.evaluate("navigator.userAgent") == CSDN_UA  # csdn 策略=硬编码伪装 UA（SPEC §3）
    got = {c["name"]: c for c in ctx.cookies("https://download.csdn.net/")}
    assert set(got) == {"UserName-Token", "p_uid"}
    assert all(c["domain"] == ".csdn.net" for c in got.values())  # 带点域覆盖全部子域
    ttl = got["UserName-Token"]["expires"] - time.time()
    assert 29 * 86400 < ttl <= 30 * 86400 + 120  # expires=now+30 天（SPEC §1.3-2）
    assert kit.persist_storage_state(ctx, storage) == storage and storage.exists()
    assert {"cookies", "origins"} <= set(json.loads(storage.read_text(encoding="utf-8")))
    # 第二次打开（不再注入 cookie）：纯靠持久分区复用登录态
    ctx2 = kit.csdn_context(storage_path=storage)
    resumed = {c["name"]: c for c in ctx2.cookies("https://wenku.csdn.net/")}
    assert set(resumed) == {"UserName-Token", "p_uid"}  # .csdn.net 对 wenku 子域同样生效
    # 同名 upsert 不产生重复条目
    inject_cookies(ctx2, "UserName-Token=tok456", domain=CSDN_COOKIE_DOMAIN,
                   ttl_seconds=CSDN_COOKIE_TTL_SECONDS)
    entries = [c for c in ctx2.cookies() if c["name"] == "UserName-Token"]
    assert len(entries) == 1 and entries[0]["value"] == "tok456"


def test_fr5_csdn_ad_domain_route_abort(kit):
    """FR5/CSDN_SPEC §1.2-4：广告/追踪域 substring 屏蔽清单（URL 包含即拦）+ 真浏览器 abort。"""
    assert CSDN_AD_DOMAINS == ("clarity.ms", "dup.baidustatic.com", "push.zhanzhang.baidu.com",
                               "toutiao.com", "googlesyndication", "doubleclick")
    for url in ("https://c.clarity.ms/collect",
                "https://dup.baidustatic.com/v1/x.js",
                "https://push.zhanzhang.baidu.com/push.js",
                "https://www.toutiao.com/ads/a.js",
                "https://pagead2.googlesyndication.com/pagead/js",
                "https://stats.g.doubleclick.net/r.gif"):
        assert is_url_blocked(url, substrings=CSDN_AD_DOMAINS), url  # substring 语义=包含即拦
    for url in ("https://blog.csdn.net/u/a/article/details/123",
                "https://download.csdn.net/download/u/123",
                "https://wenku.csdn.net/doc/slug-abc"):
        assert not is_url_blocked(url, substrings=CSDN_AD_DOMAINS), url
    ctx = kit.csdn_context()
    page = ctx.new_page()
    with pytest.raises(PlaywrightError, match="net::ERR_FAILED"):
        page.goto("https://c.clarity.ms/collect", timeout=8000)


def test_fr5_expect_download_capture_and_save(kit, tmp_path):
    """FR5/CSDN_SPEC §1.3/§5：expect_download 四合一之下载捕获（30s 默认+超时抛错+落盘字节实测）。"""
    assert DOWNLOAD_TIMEOUT_MS == 30_000  # SPEC §1.3-10 整体 30s 超时
    ctx = kit.csdn_context()  # accept_downloads=True
    page = ctx.new_page()
    # page 级后注册 route 优先级最高 → 本地 fulfill 离线触发真下载（.invalid 域 RFC 2606 兜底零外网）
    page.route("**/file.bin", lambda r: r.fulfill(
        status=200, content_type="application/octet-stream",
        headers={"Content-Disposition": 'attachment; filename="sample.bin"'},
        body=b"BINPAYLOAD-123"))
    page.set_content('<a id="dl" href="https://dl.offline.invalid/file.bin">dl</a>')
    download = capture_download(page, lambda: page.click("#dl"), timeout_ms=8000)
    assert download.suggested_filename == "sample.bin"  # 等价 Electron item.getFilename()
    saved = save_download(download, tmp_path)
    assert saved.name == "sample.bin" and saved.read_bytes() == b"BINPAYLOAD-123"  # 落盘字节实测
    with pytest.raises(PlaywrightError, match="Timeout"):  # 空触发必超时（时间注入点=timeout_ms）
        capture_download(page, lambda: None, timeout_ms=700)


# ---------------------------------------------------------------- FR3 book118 策略

def test_fr3_book118_first_hop_only_lifecycle(kit):
    """FR3/BOOK118_SPEC §5：仅首跳——真浏览器取首跳 HTML 后立即收口，失败路径同样不留上下文。"""
    html = kit.book118_first_hop("data:text/html,<div id='pd'>PREVIEW_DATA_MARKER</div>")
    assert "PREVIEW_DATA_MARKER" in html
    assert kit.open_context_count == 0  # 仅首跳即关，不留常驻上下文（数据层纯 http 不进本件）
    with pytest.raises(PlaywrightError):  # 本机拒连端口（零外网快速失败）
        kit.book118_first_hop("https://127.0.0.1:1/x", timeout_ms=8000)
    assert kit.open_context_count == 0  # 失败路径 finally 同样收口


# ---------------------------------------------------------------- FR7 通用策略

def test_fr7_generic_context_supports_headless_render_lifecycle(kit):
    """FR7：通用上下文承载 L3 无头渲染（viewport 定制 + 截图字节实测 PNG 魔数）。"""
    ctx = kit.generic_context(viewport={"width": 800, "height": 600})
    page = ctx.new_page()
    page.set_content("<h1>L3 render</h1>")
    shot = page.screenshot(type="png")
    assert shot[:4] == b"\x89PNG"  # PNG 魔数实测（数字零造假）
    assert ctx.pages == [page]
    assert kit.close_all() == 1 and kit.close_all() == 0  # 收口幂等


# ---------------------------------------------------------------- 实弹烟测（真实网络）

@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP, reason="KB_HARVEST_SKIP_LIVE=1：实弹烟测跳过（公约第 4 条，CI 场景明示）")
def test_live_public_page_load_and_ua_assert(chromium):
    """实弹烟测：任一公开页（baidu 首页）真实加载 + 随机桌面 UA 断言 + 放行路径 continue 证据。"""
    kit = BrowserKit(chromium)  # 每次运行随机一个桌面 UA（WENKU_SPEC §4.1-1）
    try:
        ctx = kit.wenku_context()  # 挂闸门三组：放行请求须 continue_ 到真实网络才可能 200
        aborted = []
        page = ctx.new_page()
        page.on("requestfailed", lambda r: aborted.append(r.url))
        resp = page.goto("https://www.baidu.com/", timeout=45_000)
        assert resp is not None and resp.ok  # 主文档放行+出网成功=continue 路径实弹证据
        assert page.evaluate("navigator.userAgent") == kit.user_agent  # UA 全程复用实弹复核
        print(f"\n[live] 随机桌面UA={kit.user_agent} | 闸门拦截请求数={len(aborted)}")
    finally:
        kit.close_all()
    assert chromium.contexts == []
