# -*- coding: utf-8 -*-
"""T17 单测：页面签名器 signer/page_signer.py（paris_2030 通用化；支撑 FR2.2 补页签名腿）。

被测物 = kb_factory.harvest_engine.signer.page_signer（真 Playwright Chromium，sync API）：
- 离线单测零外网：page 级后注册路由本地 fulfill 合成 wenku 主文档（内含 paris_2030 桩——
  桩的是**目标站点运行时**这一外部依赖，非被测物本体；page 级后注册优先于 context 闸门）；
  埋点 img 不覆盖 page 路由 → 落 context 闸门被 abort（签名窗 route 闸门有效性证据）；
- 实弹用例（@pytest.mark.live）= 真实网络：隐藏页加载 wenku 首页 → 就绪轮询（500ms×40/20s）
  → getAcsToken 签出 token → 带 Acs-Token 头真调 ndocview/readerinfo → 信封三态判定，
  KB_HARVEST_SKIP_LIVE=1 时跳过（skip reason 明示，公约第 4 条）；
- 编制裁定（1022 预期管理）：匿名+签名下 readerinfo 仍可能 tri_cap——EnvelopeOK 与
  EnvelopeNeedVerify(tri_cap) 均算「信封路径被验证」；账号登录态归 T29，不在本件射程。
"""
import json
import os
import random
import re
import sys
import time
from pathlib import Path

import pytest
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
    from kb_factory.harvest_engine.browser.kit import BrowserKit
    from kb_factory.harvest_engine.envelope import (EnvelopeFail, EnvelopeNeedVerify,
                                                    EnvelopeOK)
    from kb_factory.harvest_engine.signer.page_signer import (GETACS_TIMEOUT_S,
                                                              POLL_INTERVAL_S,
                                                              READERINFO_RN, READY_EXPR,
                                                              READY_TIMEOUT_S,
                                                              WENKU_INIT_URL, AcsTokenError,
                                                              PageSigner, SignerReadyTimeout,
                                                              build_readerinfo_url,
                                                              build_sign_js,
                                                              judge_readerinfo)
except ImportError:
    from harvest_engine.browser.kit import BrowserKit
    from harvest_engine.envelope import EnvelopeFail, EnvelopeNeedVerify, EnvelopeOK
    from harvest_engine.signer.page_signer import (GETACS_TIMEOUT_S, POLL_INTERVAL_S,
                                                   READERINFO_RN, READY_EXPR,
                                                   READY_TIMEOUT_S, WENKU_INIT_URL,
                                                   AcsTokenError, PageSigner,
                                                   SignerReadyTimeout,
                                                   build_readerinfo_url, build_sign_js,
                                                   judge_readerinfo)

_LIVE_SKIP = os.environ.get("KB_HARVEST_SKIP_LIVE") == "1"

# ---------------------------------------------------------------- fixture（公约：禁并行多浏览器）


@pytest.fixture(scope="module")
def chromium():
    """module 级唯一浏览器：fixture 管 launch/close（公约：禁止测试并行开多浏览器）。

    launch 参数走 _launch_browser（缺省直连；离线用例全本地 fulfill/abort 不出网，
    live 用例国内腿直连——两口径同一浏览器，进程内唯一 sync_playwright）。
    """
    with sync_playwright() as pw:
        browser = _launch_browser(pw)
        yield browser
        browser.close()


@pytest.fixture
def kit(chromium):
    """每测一个 BrowserKit；种子固定=UA 确定性；teardown 收口断言零泄漏。"""
    k = BrowserKit(chromium, rng=random.Random(20261022))
    yield k
    k.close_all()
    assert chromium.contexts == [], "生命周期泄漏：kit 收口后浏览器仍有未关上下文"


# ---------------------------------------------------------------- 离线桩基建（零外网）


def stub_wenku_html(*, paris: str = "immediate") -> str:
    """合成 wenku 主文档：paris_2030 桩（目标站点运行时的确定性替身，非被测物）。

    paris=immediate（_acsInited:true）/delayed（300ms 后 true，验轮询真循环）/none（无 paris，
    验超时）；埋点 img（hm.baidu.com）不进 page 路由 → 落 context 闸门被 abort（闸门证据）。
    getAcsToken 桩语义：URL 含 BAD → cb(对象)（§8-12 回调非 string）；含 NEVER → 永不回调
    （验防御位超时）；其余 → cb('TOKEN_'+长度)。
    """
    img = ('<img src="https://hm.baidu.com/hm.gif?stub" '
           'onerror="window.__imgBlocked=true">')
    if paris == "none":
        return f"<!DOCTYPE html><html><body>{img}<p>no paris here</p></body></html>"
    inited = "true" if paris == "immediate" else "false"
    delayed = ("setTimeout(function(){window.paris_2030._acsInited=true;}, 300);"
               if paris == "delayed" else "")
    script = (
        "window.__signLog = [];\n"
        "window.paris_2030 = {\n"
        f"  _acsInited: {inited},\n"
        "  getAcsToken: function (urlStr, cb) {\n"
        "    window.__lastPayload = urlStr;\n"
        "    window.__signLog.push(urlStr);\n"
        "    if (urlStr.indexOf('BAD') >= 0) { cb({errCode: 99}); return; }\n"
        "    if (urlStr.indexOf('NEVER') >= 0) { return; }\n"
        "    cb('TOKEN_' + urlStr.length);\n"
        "  }\n"
        "};\n" + delayed)
    return ("<!DOCTYPE html><html><head><meta charset='utf-8'></head><body>"
            f"{img}<script>{script}</script></body></html>")


def make_local_router(html: str, *, readerinfo_status: int = 200,
                      readerinfo_body: str = "", abort_readerinfo: bool = False):
    """page 级本地路由钩子（page_hook 注入点）：主文档/readerinfo 本地应答，零外网。

    page 级后注册优先于 context 闸门 → 两 pattern 内的请求不出网；未覆盖请求（埋点 img）
    落 context 闸门。返回 (hook, captured)：captured 如实记录 readerinfo 请求 URL/头。
    """
    captured: dict = {"main_urls": [], "readerinfo_urls": [], "readerinfo_headers": {}}

    def hook(page) -> None:
        def handle_main(route):
            captured["main_urls"].append(route.request.url)
            route.fulfill(status=200, content_type="text/html; charset=utf-8", body=html)

        def handle_readerinfo(route):
            req = route.request
            captured["readerinfo_urls"].append(req.url)
            captured["readerinfo_headers"] = {k.lower(): v for k, v in req.headers.items()}
            if abort_readerinfo:
                route.abort()
            else:
                route.fulfill(status=readerinfo_status,
                              content_type="application/json", body=readerinfo_body)

        page.route("https://wenku.baidu.com/", handle_main)
        page.route("**/ndocview/readerinfo*", handle_readerinfo)

    return hook, captured


def _wait_js_true(page, expr: str, *, attempts: int = 20, interval: float = 0.1) -> bool:
    """轮询 page 内表达式转真（onerror 异步落位的确定性等待）。"""
    for _ in range(attempts):
        if page.evaluate(expr):
            return True
        time.sleep(interval)
    return False


# ---------------------------------------------------------------- 纯函数（无浏览器）

def test_fr22_protocol_constants_and_sign_js_verbatim():
    """FR2.2/WENKU_SPEC §4.1 协议常量逐项 + sign in-page 脚本关键片段（原文照抄位）。"""
    assert WENKU_INIT_URL == "https://wenku.baidu.com/"       # §4.1-4 initUrl 缺省
    assert POLL_INTERVAL_S == 0.5 and READY_TIMEOUT_S == 20.0  # §4.1-5 500ms/20s
    assert round(READY_TIMEOUT_S / POLL_INTERVAL_S) == 40      # 500ms×40 轮
    assert READY_EXPR == "!!(window.paris_2030 && window.paris_2030._acsInited)"
    assert READERINFO_RN == 50                                 # §3.2 rn=50
    assert GETACS_TIMEOUT_S == 15.0                            # 防御位（原作无超时）
    js = build_sign_js(5000)
    assert "window.paris_2030.getAcsToken(JSON.parse(urlJson)" in js  # payload=URL 原串
    assert "typeof tokenOrErr === 'string'" in js
    assert "'getAcsToken err: ' + JSON.stringify(tokenOrErr)" in js  # §8-12 原文
    assert "5000" in js


def test_fr22_readerinfo_url_assembly_per_spec():
    """FR2.2/WENKU_SPEC §3.2：补页 URL 逐段组装（模板原文）+ t_ms 注入 + 非法参数硬拒。"""
    got = build_readerinfo_url("d0c4b2f9a1", pn=51, t_ms=1690000000000)
    assert got == ("https://wenku.baidu.com/ndocview/readerinfo?doc_id=d0c4b2f9a1"
                   "&docId=d0c4b2f9a1&type=html&clientType=1&pn=51&t=1690000000000"
                   "&isFromBdSearch=0&srcRef=&rn=50&powerId=2&bizName=mainPc")
    auto = build_readerinfo_url("abc", pn=1, rn=30)
    assert "&rn=30&powerId=2" in auto and "doc_id=abc&docId=abc" in auto  # rn 可参数化
    now_ms = int(time.time() * 1000)
    t_seen = int(auto.split("&t=")[1].split("&")[0])
    assert abs(t_seen - now_ms) < 10_000  # 缺省 t=Date.now() 同型（毫秒）
    for bad in ({"doc_id": "", "pn": 1}, {"doc_id": "x", "pn": 0}, {"doc_id": "x", "pn": -1},
                {"doc_id": "x", "pn": 1, "rn": 0}):
        with pytest.raises(ValueError):
            build_readerinfo_url(**bad)


def test_fr22_judge_readerinfo_null_maps_to_fetch_null():
    """FR2.2/WENKU_SPEC §8-4：payload None（非 2xx/连接失败/坏体）→ EnvelopeFail(fetch_null)。"""
    from kb_factory.harvest_engine.signer.page_signer import SignedFetch
    v = judge_readerinfo(SignedFetch(url="u", token="t", ok=False, status=500,
                                     payload=None, body_head="BOOM"))
    assert isinstance(v, EnvelopeFail) and v.kind == "fetch_null" and v.site == "wenku"
    assert v.facts["http_status"] == 500
    v2 = judge_readerinfo(SignedFetch(url="u", token="t", ok=False, status=None,
                                      payload=None, detail="net::ERR_FAILED"))
    assert v2.kind == "fetch_null" and v2.facts["http_status"] is None


# ---------------------------------------------------------------- 开窗/就绪轮询（离线）

def test_fr22_ready_poll_immediate_gate_evidence_and_offline_zero_net(kit):
    """FR2.2/§4.1-5：就绪即第 1 轮命中 + 签名窗 route 闸门有效（埋点 img 被 context 闸门 abort）。"""
    hook, captured = make_local_router(stub_wenku_html(paris="immediate"))
    signer = PageSigner(kit, page_hook=hook)
    try:
        assert signer.ready and signer.ready_polls == 1 and signer.ready_elapsed_s >= 0
        assert captured["main_urls"] == ["https://wenku.baidu.com/"]  # 主文档本地应答=零外网
        assert signer.page.url == "https://wenku.baidu.com/"
        # 闸门证据：埋点 img 未被 page 路由覆盖 → context 闸门 abort → onerror 落位
        assert _wait_js_true(signer.page, "!!window.__imgBlocked"), \
            "埋点 img 未被签名窗闸门拦截（hm.baidu.com 应 abort）"
    finally:
        assert signer.close() is True
    assert kit.open_context_count == 0


def test_fr22_ready_poll_loops_until_delayed_init(kit):
    """FR2.2/§4.1-5：轮询真循环——延迟 300ms 就绪须多轮 evaluate（ready_polls≥2）+ 实测耗时。"""
    hook, _ = make_local_router(stub_wenku_html(paris="delayed"))
    signer = PageSigner(kit, page_hook=hook, poll_interval_s=0.06, ready_timeout_s=6.0)
    try:
        assert signer.ready and signer.ready_polls >= 2  # 首轮必未就绪 → 真轮询
        assert signer.ready_elapsed_s >= 0.25            # 墙钟实测 ≥300ms 桩延迟
    finally:
        signer.close()
    assert kit.open_context_count == 0


def test_fr22_ready_poll_timeout_raises_and_closes_context(kit):
    """FR2.2/§8-11：20s 超时语义（缩比参数）抛「ACS 初始化超时」+ 开窗失败即收口零残留。"""
    hook, _ = make_local_router(stub_wenku_html(paris="none"))
    with pytest.raises(SignerReadyTimeout, match="ACS 初始化超时"):
        PageSigner(kit, page_hook=hook, poll_interval_s=0.05, ready_timeout_s=0.3)
    assert kit.open_context_count == 0  # 开窗失败即收口（不留半开上下文）


# ---------------------------------------------------------------- sign（离线）

def test_fr22_sign_promise_wrap_string_token_and_error_paths(kit):
    """FR2.2/calls 偏移 7396：getAcsToken 包 Promise——string→token；对象→getAcsToken err；无回调→超时。"""
    hook, _ = make_local_router(stub_wenku_html(paris="immediate"))
    signer = PageSigner(kit, page_hook=hook)
    try:
        url = build_readerinfo_url("docX1", pn=1, t_ms=1690000000001)
        token = signer.sign(url)
        assert token == f"TOKEN_{len(url)}"                    # 非空 string（桩=长度编码）
        assert signer.page.evaluate("window.__lastPayload") == url  # payload=完整 URL 原串
        with pytest.raises(AcsTokenError, match="getAcsToken err"):
            signer.sign("https://wenku.baidu.com/BAD")          # §8-12 回调非 string
        with pytest.raises(AcsTokenError, match="getAcsToken timeout"):
            signer.sign("https://wenku.baidu.com/NEVER", timeout_s=0.5)  # 防御位超时
        assert signer.sign_calls == 3                            # 实测计数（含两次失败）
    finally:
        signer.close()


# ---------------------------------------------------------------- 带签 fetch + 信封分派（离线）

_TRI_CAP_BODY = ('{"status":{"code":0,"msg":"need to verify pop-up window!"},'
                 '"data":{"tri_reason":"ymg","tri_cap":true,'
                 '"svcp_url":"https://seccaptcha.baidu.com/v1/webapi/verint/svcp.html'
                 '?ak=demo&subid=wenku_pc_readerinfo_bfe&ts=1&sign=demo"}}')  # §6.3 实测留档
_OK_BODY = ('{"status":{"code":0,"msg":"success"},"data":{"showPage":50,"htmlUrls":'
            '{"json":[{"pageIndex":1,"pageLoadUrl":"https://wkrtcs.bdimg.com/rtcs?pn=1"}],'
            '"png":[],"ttf":[]}}}')
_NO_PAGE_BODY = '{"status":{"code":0,"msg":"ok"},"data":{}}'


def test_fr22_signed_readerinfo_tri_cap_envelope_and_acs_token_header(kit):
    """FR2.2/§3.2+§6.3：Acs-Token 进请求头（不进 query）+ tri_cap 信封正确分派 NeedVerify。"""
    hook, captured = make_local_router(stub_wenku_html(paris="immediate"),
                                       readerinfo_body=_TRI_CAP_BODY)
    signer = PageSigner(kit, page_hook=hook)
    try:
        result = signer.fetch_readerinfo("d0c4b2f9a1", pn=51, t_ms=1690000000000)
        # —— 请求侧事实：URL 逐段 + Acs-Token 头 + 同源自然 Referer ——
        assert captured["readerinfo_urls"] == [result.url]
        assert result.url == build_readerinfo_url("d0c4b2f9a1", pn=51, t_ms=1690000000000)
        headers = captured["readerinfo_headers"]
        assert headers.get("acs-token") == result.token == f"TOKEN_{len(result.url)}"
        assert headers.get("referer", "").startswith("https://wenku.baidu.com/")
        assert "acs-token" not in result.url.split("?", 1)[1]      # token 只进头不进 query
        # —— 响应侧事实 + 信封分派 ——
        assert result.fetch.ok and result.fetch.status == 200 and result.fetch.payload
        assert isinstance(result.verdict, EnvelopeNeedVerify)
        assert result.verdict.kind == "tri_cap"                    # R12 主陷阱
        assert result.verdict.facts["tri_reason"] == "ymg"
        assert str(result.verdict.facts["svcp_url"]).startswith("https://seccaptcha.baidu.com/")
        assert signer.sign_calls == 1 and signer.fetch_calls == 1  # fetch_readerinfo 内含一次 sign
    finally:
        signer.close()


def test_fr22_signed_readerinfo_ok_envelope_carries_html_urls(kit):
    """FR2.2/§3.2：htmlUrls 在场 → EnvelopeOK（facts 带 show_page 游标，补页链可续）。"""
    hook, _ = make_local_router(stub_wenku_html(paris="immediate"), readerinfo_body=_OK_BODY)
    signer = PageSigner(kit, page_hook=hook)
    try:
        result = signer.fetch_readerinfo("docOK", pn=1, t_ms=1690000000002)
        assert isinstance(result.verdict, EnvelopeOK)
        assert result.verdict.facts["show_page"] == 50
        assert result.verdict.facts["html_urls"]["json"][0]["pageIndex"] == 1
    finally:
        signer.close()


def test_fr22_signed_readerinfo_fetch_null_on_http_500_and_connection_abort(kit):
    """FR2.2/§8-4：非 2xx 与连接级失败（网络故障注入）→ payload None → fetch_null 信封。"""
    hook, _ = make_local_router(stub_wenku_html(paris="immediate"),
                                readerinfo_status=500, readerinfo_body="BOOM")
    signer = PageSigner(kit, page_hook=hook)
    try:
        result = signer.fetch_readerinfo("doc500", pn=1, t_ms=1690000000003)
        assert result.fetch.ok is False and result.fetch.status == 500
        assert result.fetch.payload is None and result.fetch.body_head == "BOOM"
        assert isinstance(result.verdict, EnvelopeFail) and result.verdict.kind == "fetch_null"
    finally:
        signer.close()
    hook2, _ = make_local_router(stub_wenku_html(paris="immediate"), abort_readerinfo=True)
    signer2 = PageSigner(kit, page_hook=hook2)
    try:
        result2 = signer2.fetch_readerinfo("docAbort", pn=1, t_ms=1690000000004)
        assert result2.fetch.status is None and result2.fetch.payload is None  # 连接级失败
        assert isinstance(result2.verdict, EnvelopeFail) and result2.verdict.kind == "fetch_null"
    finally:
        signer2.close()


# ---------------------------------------------------------------- ADR-2 常驻窗生命周期

def test_adr2_signing_window_persistent_reuse_and_close_idempotent(kit):
    """ADR-2：签名窗常驻——同窗多次 sign/fetch 复用（上下文不重开）；close 幂等且出 kit 台账。"""
    hook, _ = make_local_router(stub_wenku_html(paris="immediate"), readerinfo_body=_OK_BODY)
    signer = PageSigner(kit, page_hook=hook)
    ctx = signer.context
    try:
        assert signer.sign("https://wenku.baidu.com/view/aaa.html")
        assert signer.fetch_readerinfo("docA", pn=1, t_ms=1690000000005).verdict.state == "ok"
        assert signer.sign("https://wenku.baidu.com/view/bbb.html")
        assert signer.sign_calls == 3 and signer.fetch_calls == 1
        assert kit.open_context_count == 1                    # 常驻：三次调用仍一个上下文
        assert ctx.pages == [signer.page] and len(ctx.pages) == 1  # 仍同一张页（不重开窗）
    finally:
        assert signer.close() is True
    assert signer.close() is False                            # 幂等
    assert signer.closed and kit.open_context_count == 0      # 出 kit 台账
    with pytest.raises(RuntimeError, match="签名窗已收口"):
        signer.sign("https://wenku.baidu.com/view/ccc.html")  # 收口后拒签


# ---------------------------------------------------------------- 实弹（真实网络）


def _launch_browser(pw):
    """测试浏览器：缺省直连（--no-proxy-server）。

    让路收窄令（1018）：wenku 属国内腿，24h 不间断、不依赖国外网代理——本机系统代理
    （fake-ip，供国外网）实测整窗宕机（1022 实测 10061 拒连，同期直连 TCP/TLS 正常：
    urllib 直连得 WAF 403 应答=链路通）。KB_HARVEST_KEEP_PROXY=1 保留环境代理（回归口径）。
    进程内唯一浏览器（module fixture），live 不得另开 sync_playwright（Sync API 单实例纪律）。
    """
    args = [] if os.environ.get("KB_HARVEST_KEEP_PROXY") == "1" else ["--no-proxy-server"]
    return pw.chromium.launch(headless=True, args=args)


_SYNCMRECALL_JS = """async (bodyJson) => {
  try {
    const r = await fetch("/gsula/sula/syncmrecall", {
      method: "POST",
      headers: {"Content-Type": "application/json;charset=utf-8"},
      body: JSON.parse(bodyJson)});
    const j = await r.json();
    const items = ((((j || {}).data || {}).items || {}).PCSearch || {}).result || {};
    const out = [];
    for (const it of (items.items || [])) {
      const d = it.data || {};
      if (d.docID) out.push([String(d.docID), d.sellType]);
    }
    return out.slice(0, 20);
  } catch (e) { return []; }
}"""


def _discover_doc_id(kit, signer):
    """live doc_id 发现腿（三级降级，源如实记）：①产线 WenkuMetaAdapter（syncmrecall 免登录，
    FR2.1 2026-10-22 实测存活；stdlib 腿随环境代理）②同浏览器**无闸门** generic 页 in-page
    syncmrecall（配方照抄 wenku_meta：PCSearch 场景；签名窗自身闸门按规格拦 gsula=业务噪声，
    故发现腿必须用独立页）③就绪首页 HTML /view/ 正则兜底（WENKU_SPEC §2）。

    搜索页现渲染知识库卡片——经典 view 锚点实测 0（开发期三轮探针），不走锚点。
    sellType∈{2,5}=VIP（wenku_meta 启发式），优先非 VIP 免费件。
    """
    src = ""
    try:
        from kb_factory.channel_adapters.wenku_meta import WenkuMetaAdapter
        metas = WenkuMetaAdapter().metadata("施工方案", limit=12)
        with_id = [m for m in metas if m.extra.get("doc_id")]
        free = [m for m in with_id if m.perm == "green"]
        if free or with_id:
            return ((free or with_id)[0].extra["doc_id"],
                    "syncmrecall(stdlib):" + ("免费件优先" if free else "任意件"))
        src = "syncmrecall(stdlib)空结果"
    except Exception as exc:  # 发现腿降级如实记（不打断）
        src = f"syncmrecall(stdlib)失败({type(exc).__name__})"
    try:
        page = kit.generic_context().new_page()
        try:
            page.goto(WENKU_INIT_URL, timeout=45_000)
            body = {"requests": [{"sceneID": "PCSearch", "params": {
                "word": "施工方案", "pn": 1, "noCacheMembershipCard": True}}]}
            rows = page.evaluate(_SYNCMRECALL_JS, json.dumps(body, ensure_ascii=False))
            non_vip = [r for r in rows if r[1] not in (2, 5)]
            if non_vip or rows:
                pick = non_vip or rows
                return pick[0][0], f"syncmrecall(in-page):" + ("免费件优先" if non_vip else "任意件")
            src += " + in-page 空"
        finally:
            page.context.close()
    except Exception as exc:
        src += f" + in-page 失败({type(exc).__name__})"
    m = re.search(r"view/([0-9A-Za-z_-]{6,})\.html", signer.page.content())
    if m:
        return m.group(1), src + " → 首页 HTML 正则兜底"
    raise AssertionError(f"doc_id 发现腿全败（{src}；搜索页/首页 view 锚点=0 均实测）")


@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP, reason="KB_HARVEST_SKIP_LIVE=1：实弹用例跳过（公约第 4 条，CI 场景明示）")
def test_live_wenku_paris_ready_sign_readerinfo_envelope(chromium):
    """实弹验收（编制裁定三判据）：①隐藏页加载+就绪轮询过 ②getAcsToken 签出非空 string
    ③带 Acs-Token 头真调 readerinfo 且信封正确分派（OK 或 NeedVerify(tri_cap) 均算验证）。

    匿名（无登录 cookie）下预期仍可能 tri_cap（WENKU_SPEC §6.3 活探针实证）——如实现测
    即为「匿名+签名仍触发验证码」的如实记录；账号登录态获取归 T29 账号池，不在本件射程。
    浏览器=module 唯一 fixture（进程内 Sync API 单实例纪律），直连口径见 _launch_browser。
    """
    kit = BrowserKit(chromium)  # 每次运行随机一个桌面 UA（WENKU_SPEC §4.1-1）
    try:
        signer = PageSigner(kit)  # ① 隐藏页加载 https://wenku.baidu.com/ + 就绪轮询 500ms×40/20s
        assert signer.ready, "①就绪轮询未通过（20s 内 paris_2030._acsInited 未就绪）"
        doc_id, doc_src = _discover_doc_id(kit, signer)  # doc_id 任取真实文档（三级发现腿）
        url = build_readerinfo_url(doc_id, pn=1, rn=50)
        token = signer.sign(url)  # ② getAcsToken(urlStr, cb) 包 Promise 签出
        assert isinstance(token, str) and token, f"②token 非非空字符串: {str(token)[:60]!r}"
        result = signer.fetch_readerinfo(doc_id, pn=1, rn=50)  # ③ Acs-Token 头真请求+信封分派
        verdict = result.verdict
        assert isinstance(verdict, (EnvelopeOK, EnvelopeNeedVerify)), (
            f"③信封路径未被验证: state={verdict.state} kind={getattr(verdict, 'kind', '')} "
            f"http={result.fetch.status} bodyHead={result.fetch.body_head[:120]!r}")
        note = ("匿名+签名仍触发验证码（tri_cap，§6.3 实证；账号登录态归 T29）"
                if isinstance(verdict, EnvelopeNeedVerify) else
                f"信封过（show_page={verdict.facts.get('show_page')}）")
        print(f"\n[live] doc_id={doc_id}（{doc_src}）| ready={signer.ready_polls}轮/"
              f"{signer.ready_elapsed_s:.2f}s | UA={kit.user_agent[:48]}… | "
              f"token_len={len(token)} | http={result.fetch.status} | "
              f"verdict={verdict.state}/{getattr(verdict, 'kind', '')} | {note}")
        kit.close_all()
        assert chromium.contexts == [], "live 收口后浏览器仍有未关上下文"
    finally:
        kit.close_all()
