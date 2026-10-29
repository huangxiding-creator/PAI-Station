# -*- coding: utf-8 -*-
"""T25 单测+实弹挂账：csdn download/doc 分支 + paid_wall 合规门（FR5.1/FR5.AC1）。

被测物 = kb_factory.harvest_engine.adapters.csdn 的 download/doc 点击流（真 Playwright Chromium）：
- 离线单测零外网（data:/route 本地 fulfill，同 T07 手法；.invalid 域 RFC 2606 兜底）：
  ① URL 分类（download/doc/column_download 判序）；
  ② paid_wall 拒绝矩阵四形态（VIP免费/会员价/无按钮/column_download）——DOM 快照 fixture 真渲染
    + envelope.judge_csdn 真符号交叉核（原作 JS 闸门 isPaid||!isVipFree 与 judge_csdn 判定一致）；
  ③ 下载接管流程：先挂 expect_download 再点击 + 确认弹窗循环 10×1s（CSDN_SPEC §1.3 时序）+
    suggested_filename 落盘字节实测 + 30s 整体超时（时间注入点=download_timeout_ms）；
  ④ 凭据闸门：KB_CSDN_COOKIE/_credentials/csdn.secret.ini 均未供=如实挂账拒（零网络，不造假跳过）；
- 实弹（@pytest.mark.live）= FR5.AC1 五件（VIP 免费件 3 份成功 + 付费件 2 份拒绝断言 paid_wall）：
  挂账注记=2026-10-22 CSDN VIP cookie 未供（_credentials/ 仅 wenku.smtp 两 ini，无 csdn.secret.ini），
  测试内置 KB_CSDN_COOKIE 环境变量供给位——供给后同用例自动转 live（skipif 门即供给探测器）；
  五件候选 URL 的 VIP/付费分类待 cookie 供给后校准（候选标注见 _LIVE_* 表）；
  KB_HARVEST_SKIP_LIVE=1 时实弹整体跳过（skip reason 明示，公约第 4 条）。
- 禁止测试并行开多浏览器：全模块共用一个 module 级 chromium fixture（与 T07/T20 同）。
"""
import os
import random
import sys
import tempfile
from pathlib import Path
from urllib.parse import quote

import pytest
from playwright.sync_api import sync_playwright

_KB_DIR = Path(__file__).resolve().parents[2]  # kb_factory/
_REPO_ROOT = _KB_DIR.parent                    # 仓根（kb_factory.* 解析）
sys.path.insert(0, str(_KB_DIR))  # worktree 阶段 kb_factory 无 __init__.py：顶层导入 harvest_engine
if not (_KB_DIR / "channel_adapters" / "base.py").exists():
    for _anc in _KB_DIR.parents:
        if (_anc / "kb_factory" / "channel_adapters" / "base.py").exists():
            sys.path.insert(1, str(_anc))
            break

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名
    from kb_factory.harvest_engine.adapters.base import WALL_PAID, LadderResult
    from kb_factory.harvest_engine.adapters.csdn import (
        CONFIRM_DIALOG_INTERVAL_MS, CONFIRM_DIALOG_MAX_TRIES, DOWNLOAD_SETTLE_MS,
        KB_CSDN_COOKIE_ENV, CsdnAdapter, CsdnColumnDownloadError,
        CsdnDownloadTimeoutError, CsdnPaidWallError, CsdnUnsupportedUrlError,
        DEFAULT_CREDENTIALS_FILE, download_resource, download_resource_flow,
        load_csdn_cookie, parse_csdn_url, sniff_resource_dom)
    from kb_factory.harvest_engine.browser.kit import DOWNLOAD_TIMEOUT_MS, BrowserKit
    from kb_factory.harvest_engine.envelope import judge_csdn
except ImportError:
    from harvest_engine.adapters.base import WALL_PAID, LadderResult
    from harvest_engine.adapters.csdn import (
        CONFIRM_DIALOG_INTERVAL_MS, CONFIRM_DIALOG_MAX_TRIES, DOWNLOAD_SETTLE_MS,
        KB_CSDN_COOKIE_ENV, CsdnAdapter, CsdnColumnDownloadError,
        CsdnDownloadTimeoutError, CsdnPaidWallError, CsdnUnsupportedUrlError,
        DEFAULT_CREDENTIALS_FILE, download_resource, download_resource_flow,
        load_csdn_cookie, parse_csdn_url, sniff_resource_dom)
    from harvest_engine.browser.kit import DOWNLOAD_TIMEOUT_MS, BrowserKit
    from harvest_engine.envelope import judge_csdn

from kb_factory.channel_adapters.base import FileMeta  # 产线真符号（元数据层口径）

_LIVE_SKIP = os.environ.get("KB_HARVEST_SKIP_LIVE") == "1"
#: 实弹挂账探测器：env KB_CSDN_COOKIE 或 _credentials/csdn.secret.ini 任一供给即转 live
_CRED_SUPPLIED = bool(os.environ.get(KB_CSDN_COOKIE_ENV, "").strip()) or (
    DEFAULT_CREDENTIALS_FILE.is_file() and bool(load_csdn_cookie().strip()))
_LIVE_REASON = ("CSDN VIP cookie 未供：实弹挂账（%s 环境变量，或 %s 的 [csdn] cookie 段，"
                "任一供给后同用例自动转 live）" % (KB_CSDN_COOKIE_ENV, DEFAULT_CREDENTIALS_FILE))

_LIVE_DIR = Path(tempfile.gettempdir()) / "kb_t25_csdn_live"  # 运行时产物目录（不入 git，可复跑）

# FR5.AC1 实弹五件候选（格式=§1.1 正则；VIP/付费分类待 cookie 供给后校准——挂账，先给供给位）
LIVE_FREE_URLS = (
    "https://download.csdn.net/download/u_vipfree1/10385999",   # 候选1：VIP 免费件（待校准）
    "https://download.csdn.net/download/u_vipfree2/13123456",   # 候选2：VIP 免费件（待校准）
    "https://wenku.csdn.net/doc/9x2wk1tq",                      # 候选3：VIP 免费件（待校准）
)
LIVE_PAID_URLS = (
    "https://download.csdn.net/download/u_paid1/11887654",      # 候选4：付费件（待校准）
    "https://wenku.csdn.net/doc/paiddoc01",                     # 候选5：付费件（待校准）
)


@pytest.fixture(scope="module")
def chromium():
    """module 级唯一浏览器：fixture 管 launch/close（公约：禁止测试并行开多浏览器）。"""
    with sync_playwright() as pw:
        browser = pw.chromium.launch(headless=True, args=["--no-proxy-server"])
        yield browser
        browser.close()


@pytest.fixture
def kit(chromium):
    """每测一个 BrowserKit（同一浏览器内开上下文）；teardown 收口断言零泄漏。"""
    k = BrowserKit(chromium, rng=random.Random(20261022))
    yield k
    k.close_all()
    assert chromium.contexts == [], "生命周期泄漏：kit 收口后浏览器仍有未关上下文"


# ---------------------------------------------------------------- 离线 DOM 快照 fixture（四形态）

def _data_url(html: str) -> str:
    return "data:text/html;charset=utf-8," + quote(html)


_DL_HOST = "https://dl.offline.invalid"


def _resource_page(button_html: str, *, dialog: bool = False, direct: bool = False) -> str:
    """download/doc 资源页快照：h1/.dl-title 标题 + .el-button--warning 按钮（±二次确认弹窗）。

    dialog=True：点按钮先弹 .el-dialog__footer 确认框，确认后才发起下载（证 10×1s 弹窗循环）；
    direct=True：点按钮立即发起下载（无弹窗路径）。
    """
    dl_js = "location.href='%s/vip-free-asset.zip'" % _DL_HOST
    if dialog:
        return """<!DOCTYPE html><html><head><title>离线资源页 - CSDN下载</title></head><body>
<h1 class="dl-title">离线VIP免费资源</h1>
%s
<div class="el-dialog__footer" id="dlg" style="display:none"><button id="okbtn">确认</button></div>
<script>
document.querySelector('.el-button--warning').addEventListener('click', function(){
  document.getElementById('dlg').style.display='block';
});
document.getElementById('okbtn').addEventListener('click', function(){ %s });
</script></body></html>""" % (button_html, dl_js)
    return """<!DOCTYPE html><html><head><title>离线资源页 - CSDN下载</title></head><body>
<h1 class="dl-title">离线VIP免费资源</h1>
%s
<script>
document.querySelector('.el-button--warning').addEventListener('click', function(){ %s });
</script></body></html>""" % (button_html, dl_js if direct else "")


_FIX_VIP_FREE = '<button class="el-button el-button--warning">VIP专享下载</button>'
_FIX_FREE_NOW = '<button class="el-button el-button--warning">立即下载</button>'
_FIX_MEMBER_PRICE = '<button class="el-button el-button--warning">VIP专享下载（会员价：30C币）</button>'

_DL_PAYLOAD = b"OFFLINE_VIP_ASSET_PAYLOAD_12345"


def _dl_hook(page):
    """离线下载注入位（T07 手法）：route 本地 fulfill 触发真下载事件（Content-Disposition 附件）。"""

    def _fulfill(route):
        route.fulfill(status=200, content_type="application/octet-stream",
                      headers={"Content-Disposition": 'attachment; filename="vip_free_report.zip"'},
                      body=_DL_PAYLOAD)
    page.route(_DL_HOST + "/vip-free-asset.zip", _fulfill)


# ---------------------------------------------------------------- ① URL 分类

def test_fr5_ac1_url_classification_download_doc_and_priority():
    """FR5.AC1/CSDN_SPEC §1.1：download/doc 两形态分类 + column_download 判序优先（不被误吃）。"""
    assert parse_csdn_url("https://download.csdn.net/download/u1/10385999") == {
        "type": "download", "url": "https://download.csdn.net/download/u1/10385999"}
    assert parse_csdn_url("https://wenku.csdn.net/doc/9x2wk1tq") == {
        "type": "doc", "url": "https://wenku.csdn.net/doc/9x2wk1tq"}
    # 判序：download.csdn.net/blog/column/... 必须落 column_download（PDF 形态 column 不得误吃）
    assert parse_csdn_url("https://download.csdn.net/blog/column/abc123")["type"] == "column_download"
    for bad in ("", "https://example.com/a", "https://download.csdn.net/other/1"):
        assert parse_csdn_url(bad) is None, bad


# ---------------------------------------------------------------- ② paid_wall 拒绝矩阵（judge_csdn 真符号）

def test_fr5_ac1_paid_wall_matrix_via_judge_csdn_true_symbol():
    """FR5.AC1：四形态矩阵经 envelope.judge_csdn 判定 + 原作 JS 闸门（isPaid||!isVipFree）交叉核一致。"""
    matrix = {  # (url_type, title, button_text) → 期望 kind（None=放行 OK）
        "vip_free":   ("download", "VIP免费件", "VIP专享下载", None),
        "free_now":   ("doc", "立即下载件", "立即下载", None),
        "member":     ("download", "会员价件", "VIP专享下载（会员价：30C币）", "paid_wall"),
        "no_button":  ("doc", "无按钮件", "", "paid_wall"),
    }
    for name, (url_type, title, btn, expect_kind) in matrix.items():
        v = judge_csdn({"url_type": url_type, "title": title, "button_text": btn})
        if expect_kind is None:
            assert v.state == "ok" and v.facts["is_vip_free"] is True, name
        else:
            assert v.state == "fail" and v.kind == expect_kind, name
            assert v.wall_status == WALL_PAID, name
        # 原作 JS 闸门交叉核（isPaid || !isVipFree 与 judge_csdn 拒/放一致）
        js_vip = bool(btn) and ("VIP专享下载" in btn or "立即下载" in btn) and "会员价" not in btn
        js_reject = ("会员价" in btn) or (not js_vip)
        assert js_reject == (expect_kind == "paid_wall"), name
    # column_download：URL 分类即拒（§4 合规门；页面都不开）
    col = judge_csdn({"url_type": "column_download"})
    assert col.state == "fail" and col.kind == "column"


def test_fr5_ac1_offline_member_price_rejected_as_paid_wall(kit, tmp_path):
    """FR5.AC1：DOM 快照「会员价」→ 硬拒（原文文案）+ facts 实证；不开下载、不落产物。"""
    with pytest.raises(CsdnPaidWallError, match="该资源需要额外收费，暂不支持下载") as ei:
        download_resource_flow(kit, _data_url(_resource_page(_FIX_MEMBER_PRICE)),
                               url_type="download", out_dir=tmp_path, page_hook=_dl_hook)
    assert ei.value.facts["is_paid"] is True and ei.value.wall_status == WALL_PAID
    assert list(tmp_path.rglob("*")) == [] or not any(p.is_file() for p in tmp_path.rglob("*"))


def test_fr5_ac1_offline_no_button_rejected_as_paid_wall(kit, tmp_path):
    """FR5.AC1：无 .el-button--warning 按钮 → 非 isVipFree → paid_wall 硬拒（facts is_vip_free=False）。"""
    html = """<!DOCTYPE html><html><head><title>无按钮资源页</title></head><body>
<h1 class="dl-title">无按钮件</h1><button class="el-button el-button--primary">登录后下载</button>
</body></html>"""
    with pytest.raises(CsdnPaidWallError, match="该资源需要额外收费") as ei:
        download_resource_flow(kit, _data_url(html), url_type="doc", out_dir=tmp_path)
    assert ei.value.facts["is_paid"] is False and ei.value.facts["is_vip_free"] is False


def test_fr5_ac1_offline_column_download_compliance_gate(kit, tmp_path):
    """FR5.AC1：column_download 一律拒（付费闸门原样移植为合规门）——开任何上下文之前。"""
    url = "https://download.csdn.net/blog/column/abc123"
    with pytest.raises(CsdnColumnDownloadError, match="图文专栏暂不支持下载"):
        download_resource(kit, url, out_dir=tmp_path)
    adapter = CsdnAdapter(kit, download_dir=tmp_path, cookie_str="sessionid=demo")
    res = adapter.fetch_ladder(adapter.plan(FileMeta(title="专栏", fmt="zip", source_url=url)))
    assert res.ok is False and res.detail == "图文专栏暂不支持下载" and res.wall_status is None
    assert kit.open_context_count == 0  # 合规拒不烧任何页面加载
    with pytest.raises(CsdnUnsupportedUrlError, match="无法识别"):
        download_resource(kit, "https://example.com/a", out_dir=tmp_path)


# ---------------------------------------------------------------- ③ 下载接管流程（expect_download）

def test_fr5_ac1_offline_vip_free_takeover_with_confirm_dialog(kit, tmp_path):
    """FR5.AC1 全链离线：嗅探→闸门放行→点击→10×1s 确认弹窗循环→expect_download 接管→落盘字节实测。"""
    assert (CONFIRM_DIALOG_MAX_TRIES, CONFIRM_DIALOG_INTERVAL_MS, DOWNLOAD_SETTLE_MS) == (10, 1000, 2000)
    assert DOWNLOAD_TIMEOUT_MS == 30_000  # §1.3-10 整体 30s 超时（0x7530）
    outcome = download_resource_flow(kit, _data_url(_resource_page(_FIX_VIP_FREE, dialog=True)),
                                     url_type="download", out_dir=tmp_path,
                                     download_timeout_ms=8000, page_hook=_dl_hook)
    assert outcome.title == "离线VIP免费资源"   # h1,.resource-title,.dl-title 优先
    assert outcome.url_type == "download"
    assert outcome.filename == "vip_free_report.zip"  # 服务器 suggested_filename（本地不重命名）
    assert outcome.file_path.name == "vip_free_report.zip"
    assert outcome.file_size == len(_DL_PAYLOAD)
    assert outcome.file_path.read_bytes() == _DL_PAYLOAD  # 落盘字节实测（零造假）
    assert outcome.file_path.parent == tmp_path           # flow 级调用：产物目录=调用方原样


def test_fr5_ac1_offline_free_now_mark_direct_download(kit, tmp_path):
    """FR5.AC1：「立即下载」第二免费判据 + 无弹窗直达路径（confirm_interval_ms=时间注入位）。"""
    outcome = download_resource_flow(kit, _data_url(_resource_page(_FIX_FREE_NOW, direct=True)),
                                     url_type="doc", out_dir=tmp_path,
                                     download_timeout_ms=8000,
                                     confirm_interval_ms=50,  # 时间注入点（公约第 3 条允许的确定性注入）
                                     page_hook=_dl_hook)
    assert outcome.filename == "vip_free_report.zip" and outcome.file_path.read_bytes() == _DL_PAYLOAD


def test_fr5_ac1_offline_download_timeout_mapped(kit, tmp_path):
    """FR5.AC1：点击后无下载事件 → 30s 语义超时（注入 1200ms）→ 原作文案映射。"""
    html = """<!DOCTYPE html><html><head><title>超时资源页</title></head><body>
<h1 class="dl-title">点了没反应</h1>
<button class="el-button el-button--warning">VIP专享下载</button>
<script>document.querySelector('.el-button--warning')
.addEventListener('click', function(){});</script></body></html>"""
    with pytest.raises(CsdnDownloadTimeoutError, match="下载超时，请检查 VIP 权限"):
        download_resource_flow(kit, _data_url(html), url_type="download", out_dir=tmp_path,
                               download_timeout_ms=1200, confirm_interval_ms=50)


def test_fr5_ac1_offline_sniff_null_on_closed_page(kit):
    """FR5.AC1：嗅探脚本执行不了（页面没起来）→ None → 页面加载失败（原作 .catch(()=>null) 等价）。"""
    ctx = kit.csdn_context()
    page = ctx.new_page()
    page.goto("about:blank")
    page.close()
    assert sniff_resource_dom(page) is None  # 关闭页 evaluate 真抛 PlaywrightError → 吞为 None


# ---------------------------------------------------------------- ④ 凭据闸门（挂账如实）

def test_fr5_ac1_credential_loader_env_ini_missing_order(tmp_path, monkeypatch):
    """FR5.AC1：凭据单源解析——env 优先 > secret.ini [csdn] cookie > 未供=如实 ""；凭据不入异常。"""
    monkeypatch.delenv(KB_CSDN_COOKIE_ENV, raising=False)
    assert load_csdn_cookie(tmp_path / "nope.ini") == ""           # 文件不存在=如实空
    ini = tmp_path / "csdn.secret.ini"
    ini.write_text("[csdn]\ncookie = UserName-Token=demo; p_uid=7\n", encoding="utf-8")
    got = load_csdn_cookie(ini)
    assert got == "UserName-Token=demo; p_uid=7"                   # 整串原样（不过滤字段）
    assert load_csdn_cookie(ini, env={KB_CSDN_COOKIE_ENV: "env=first"}) == "env=first"  # env 优先
    assert load_csdn_cookie(tmp_path / "nope.ini",
                            env={KB_CSDN_COOKIE_ENV: "env=only"}) == "env=only"
    no_section = tmp_path / "other.secret.ini"
    no_section.write_text("[other]\nx = 1\n", encoding="utf-8")
    assert load_csdn_cookie(no_section) == ""                      # 无 [csdn] 段=未供


def test_fr5_ac1_adapter_credential_gate_zero_network(kit, tmp_path, monkeypatch):
    """FR5.AC1：凭据未供 → download/doc 如实挂账拒（零上下文/零网络，不造假跳过）。"""
    monkeypatch.delenv(KB_CSDN_COOKIE_ENV, raising=False)
    adapter = CsdnAdapter(kit, download_dir=tmp_path,
                          credentials_file=tmp_path / "nope.ini")  # 强制未供（免环境串扰）
    assert adapter.cookie_str == ""
    plan = adapter.plan(FileMeta(title="资源", fmt="zip",
                                 source_url="https://download.csdn.net/download/u1/10385999"))
    res = adapter.fetch_ladder(plan)
    assert res.ok is False and "凭据未供" in res.detail and KB_CSDN_COOKIE_ENV in res.detail
    assert "挂账" in res.detail and res.wall_status is None
    assert kit.open_context_count == 0  # 未触任何网络/未开上下文（挂账=零成本如实报）


def test_fr5_ac1_adapter_offline_full_chain_via_route_fulfill(kit, tmp_path, monkeypatch):
    """FR5.AC1 适配器全链离线（route 本地 fulfill 整页）：paid_wall LadderResult 双落 + VIP 件 ok+verify。"""
    monkeypatch.delenv(KB_CSDN_COOKIE_ENV, raising=False)
    page_url = "https://download.csdn.net/download/u_paid1/11887654"
    dl_url = "https://dl2.offline.invalid/paid-page.bin"

    def hook(page):
        def _page(route):
            route.fulfill(status=200, content_type="text/html; charset=utf-8",
                          body=_resource_page(_FIX_MEMBER_PRICE, direct=True).replace(
                              _DL_HOST + "/vip-free-asset.zip", dl_url))
        page.route(page_url, _page)

    adapter = CsdnAdapter(kit, download_dir=tmp_path, cookie_str="sessionid=demo", page_hook=hook)
    plan = adapter.plan(FileMeta(title="付费件", fmt="zip", source_url=page_url))
    assert plan.ladder_try == ("L2",)  # download/doc 点击流=纯 L2（无 L1 协议直连语义）
    res = adapter.fetch_ladder(plan)
    assert res.ok is False and res.wall_status == WALL_PAID          # 结果位墙标
    assert plan.meta.extra["wall_status"] == "paid_wall"             # NFR1 统一落点（mark_wall_status 真符号）
    assert "该资源需要额外收费" in res.detail
    assert adapter.verify(res) is False

    # VIP 免费件同链路：ok=True + artifact 落盘 + verify 过（zip=在盘+非空口径）
    ok_url = "https://download.csdn.net/download/u_vip1/10385999"

    def ok_hook(page):
        def _page(route):
            route.fulfill(status=200, content_type="text/html; charset=utf-8",
                          body=_resource_page(_FIX_VIP_FREE, dialog=True))
        page.route(ok_url, _page)
        _dl_hook(page)

    adapter2 = CsdnAdapter(kit, download_dir=tmp_path, cookie_str="sessionid=demo", page_hook=ok_hook)
    plan2 = adapter2.plan(FileMeta(title="免费件", fmt="zip", source_url=ok_url))
    res2 = adapter2.fetch_ladder(plan2)
    assert res2.ok is True and res2.ladder_used == "L2" and res2.artifact_path
    assert "10385999" in res2.artifact_path and res2.artifact_path.endswith("vip_free_report.zip")
    assert Path(res2.artifact_path).read_bytes() == _DL_PAYLOAD
    assert adapter2.verify(res2) is True


def test_fr5_ac1_verify_binary_vs_missing(tmp_path):
    """FR5.AC1：verify 口径——二进制产物在盘+非空即过；缺产物/空文件/ok=False 不过（真 LadderResult）。"""
    adapter = CsdnAdapter(None, download_dir=tmp_path, cookie_str="")  # verify 纯产物判定，不触浏览器
    zip_path = tmp_path / "asset.zip"
    zip_path.write_bytes(b"PK\x03\x04payload")
    assert adapter.verify(LadderResult(ok=True, artifact_path=str(zip_path))) is True
    empty = tmp_path / "empty.bin"
    empty.write_bytes(b"")
    assert adapter.verify(LadderResult(ok=True, artifact_path=str(empty))) is False
    assert adapter.verify(LadderResult(ok=True, artifact_path=str(tmp_path / "nope.zip"))) is False
    assert adapter.verify(LadderResult(ok=False, artifact_path=str(zip_path))) is False


# ---------------------------------------------------------------- 实弹挂账（FR5.AC1 五件；真实网络）

@pytest.fixture
def live_adapter(kit):
    """实弹适配器：凭据走单源解析（env KB_CSDN_COOKIE / _credentials/csdn.secret.ini）。"""
    adapter = CsdnAdapter(kit, download_dir=_LIVE_DIR)
    assert adapter.cookie_str, "凭据探测器已过但解析为空（供给位与解析源不一致，查 KB_CSDN_COOKIE）"
    return adapter


@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP or not _CRED_SUPPLIED, reason=_LIVE_REASON)
@pytest.mark.parametrize("url", LIVE_FREE_URLS)
def test_fr5_ac1_live_vip_free_download_succeeds(live_adapter, url):
    """FR5.AC1 实弹（挂账 1-3/5）：VIP 免费件 3 份 → ok=True + 产物在盘 + verify 过（候选待校准）。"""
    plan = live_adapter.plan(FileMeta(title="实弹VIP件", fmt="bin", source_url=url))
    res = live_adapter.fetch_ladder(plan)
    assert res.ok is True and res.artifact_path, res.detail
    assert Path(res.artifact_path).stat().st_size > 0  # 落盘字节实测（数字零造假）
    assert live_adapter.verify(res) is True


@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP or not _CRED_SUPPLIED, reason=_LIVE_REASON)
@pytest.mark.parametrize("url", LIVE_PAID_URLS)
def test_fr5_ac1_live_paid_rejected_with_paid_wall_marker(live_adapter, url):
    """FR5.AC1 实弹（挂账 4-5/5）：付费件 2 份 → ok=False + wall_status=paid_wall 断言（候选待校准）。"""
    plan = live_adapter.plan(FileMeta(title="实弹付费件", fmt="bin", source_url=url))
    res = live_adapter.fetch_ladder(plan)
    assert res.ok is False, "候选分类待校准：若实为 VIP 免费件请换 URL（挂账校准注记）"
    assert res.wall_status == WALL_PAID
    assert plan.meta.extra["wall_status"] == "paid_wall"
