# -*- coding: utf-8 -*-
"""T28 单测：L3 渲染兜底 render/fallback.py（FR7.1 渲染链 + FR7.AC1 实弹口径）。

离线单测零外网（数据面=data: URL / 本机拒连端口 / PIL 本地图——同 test_browser_kit 口径）：
- 纯函数切片：整页截图按视口高切页（像素几何逐页锁死）+ max_pages 截窗封顶；
- 入口契约（检测→降级门）：failure_history 空 / 无 FR1.2 数值化降级信号 → fail-fast；
- data: URL 全链：懒加载滚动→整页截图→切片→像素拼 PDF→OCR 文字层→质检门（CLI 同判定函数）；
- 不可达边界：本机拒连端口 → unreachable 如实报（零页零字、不产 0 页 PDF、audit 记 fail）。

实弹（@pytest.mark.live，zero-mock 真网络；KB_HARVEST_SKIP_LIVE=1 跳过并在 reason 明示）：
- FR7.AC1① 死站：www.dajudeng.com（FISH_PROBE #9，443 应答但 TLS 瘫痪）作 L1/L2 失效源
  → fallback 入口自然走「检测→降级→兜底」，兜底腿不可达如实报 unreachable（L3 边界行为）；
- FR7.AC1② 存活站：wenku.baidu.com 公开文档页（任务卡候选①；阅读器=内滚容器、body
  ~904px≈单视口 → 恰为「expected_pages=1 单页文档」最简形态，2026-10-22 实测墨比
  0.2681 带内）走 L3 全链，质检门 CLI 退出码 0。
  口径注记：裸 goto 撞「百度安全验证」行为墙 → 走引擎暖启动参数（warmup_url=baidu.com
  落 cookie + referer）；任务卡候选② mbalib.com 词条页已实测弃用——wiki.mbalib.com 现
  深色皮肤（页底灰度~100），首/末带 ink 0.86-0.89 越门③上带 0.85（门按文档页口径判
  定正确，属目标页观感不匹配，非引擎缺陷）。

浏览器纪律：全模块共用一个 module 级 Chromium fixture（launch/close 由 fixture 管，
禁止测试并行开多浏览器）；本机系统代理 127.0.0.1:7892 死口而引擎数据层 httpx 全程
直连——fixture 经 launch_l3_browser 以 direct:// 直连启动，口径一致。
"""
import json
import os
import re
import socket
import subprocess
import sys
import urllib.parse
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
    from kb_factory.harvest_engine.adapters.base import AttemptEvent  # noqa: E402
    from kb_factory.harvest_engine.browser.kit import BrowserKit  # noqa: E402
    from kb_factory.harvest_engine.render.fallback import (  # noqa: E402
        L3_VIEWPORT, FallbackOutcome, launch_l3_browser, render_fallback, slice_full_page)
except ImportError:
    from harvest_engine.adapters.base import AttemptEvent  # noqa: E402
    from harvest_engine.browser.kit import BrowserKit  # noqa: E402
    from harvest_engine.render.fallback import (  # noqa: E402
        L3_VIEWPORT, FallbackOutcome, launch_l3_browser, render_fallback, slice_full_page)

from PIL import Image  # noqa: E402

_LIVE_SKIP = os.environ.get("KB_HARVEST_SKIP_LIVE") == "1"
_ROOT = _KB_DIR.parent if _KB_DIR.name == "kb_factory" else _KB_DIR  # CLI 子进程 cwd=仓根

# L1/L2 失效事件流（死站口径：协议直连/站内渲染均超 30s/页 预算 → FR1.2 超时形态）
_DEAD_SITE_HISTORY = (AttemptEvent(elapsed_s=35.0, pages=1),   # L1 协议直连超时
                      AttemptEvent(elapsed_s=33.0, pages=1))   # L2 站内JS签名渲染超时

# 离线全链用大字词组（44px 屏显级，两视口均有墨——质检门③ ink 带内）
_TALL_WORDS = ["溢洪道", "施工导流", "混凝土重力坝", "质量检测评定", "闸门启闭机",
               "围堰工程", "灌浆施工", "边坡支护", "隧洞衬砌", "基础处理",
               "金属结构", "安全监测"]


def _tall_data_url() -> str:
    """data: URL 双视口高（1800px）中文页：零外网 + 懒加载滚动/切片/OCR 全链可跑。"""
    paras = "".join(
        '<p style="font-size:44px;line-height:120px;margin:0;font-family:simhei,serif">%s</p>' % w
        for w in _TALL_WORDS)
    html = ('<!DOCTYPE html><html><head><meta charset="utf-8"><title>L3 fallback 离线全链</title>'
            '</head><body style="margin:0"><div style="height:1800px;width:1280px">%s</div>'
            "</body></html>" % paras)
    return "data:text/html;charset=utf-8," + urllib.parse.quote(html)


def _refused_port() -> int:
    """取一个必然拒连的本机端口（bind 后立即 close → 无监听）。"""
    s = socket.socket()
    s.bind(("127.0.0.1", 0))
    port = s.getsockname()[1]
    s.close()
    return port


@pytest.fixture(scope="module")
def chromium():
    """module 级唯一浏览器：fixture 管 launch/close（公约：禁止测试并行开多浏览器）。"""
    with sync_playwright() as pw:
        browser = launch_l3_browser(pw)
        yield browser
        browser.close()


@pytest.fixture
def kit(chromium):
    """每测一个 BrowserKit（同一浏览器内开上下文）；teardown 收口断言零泄漏。"""
    import random
    k = BrowserKit(chromium, rng=random.Random(20261022))
    yield k
    k.close_all()
    assert chromium.contexts == [], "生命周期泄漏：kit 收口后浏览器仍有未关上下文"


# ---------------------------------------------------------------- 离线：纯函数切片

def test_fr7_slice_full_page_pixel_geometry(tmp_path):
    """FR7.1④ 切片纯函数：整页截图按视口高切页——页几何=像素逐页锁死，末页保留余高。"""
    full = tmp_path / "full.png"
    Image.new("RGB", (1280, 2500), (250, 250, 250)).save(full, format="PNG")
    slices = slice_full_page(full, tmp_path / "slices", page_height_px=900, max_pages=8)
    assert [p.name for p in slices] == ["l3_page_001.png", "l3_page_002.png", "l3_page_003.png"]
    sizes = [Image.open(p).size for p in slices]
    assert sizes == [(1280, 900), (1280, 900), (1280, 700)], f"像素几何被改动: {sizes}"
    # max_pages 截窗封顶：2500px 只取前 2 页（1800px），余高不产第 3 页
    capped = slice_full_page(full, tmp_path / "capped", page_height_px=900, max_pages=2)
    assert len(capped) == 2 and Image.open(capped[-1]).size == (1280, 900)


def test_fr7_slice_rejects_degenerate_param_and_keeps_1px_page(tmp_path):
    """FR7.1④ 边界：page_height_px<1 显式拒（fail-fast 而非除零/静默）；1px 高图诚实切 1 页。

    0×0 退化 PNG 本体 PIL 拒写（"cannot write empty image"，2026-10-22 实测）——物理不可
    产出，故几何门以参数门形式验收；1×N 真图则按实际余高产 1 页（几何零造假）。
    """
    normal = tmp_path / "normal.png"
    Image.new("RGB", (1280, 1), (10, 10, 10)).save(normal, format="PNG")
    with pytest.raises(ValueError, match="page_height_px"):
        slice_full_page(normal, tmp_path / "o0", page_height_px=0)
    slices = slice_full_page(normal, tmp_path / "o1", page_height_px=900)
    assert len(slices) == 1 and Image.open(slices[0]).size == (1280, 1)


# ---------------------------------------------------------------- 离线：入口契约（检测→降级门）

def test_fr7_entry_failfast_without_degrade_signal(kit, tmp_path):
    """FR7.1① 入口检测门：failure_history 空/全界内 → ValueError fail-fast（不该进 L3）。"""
    with pytest.raises(ValueError, match="failure_history"):
        render_fallback("https://example.invalid/", tmp_path / "o1", kit=kit, failure_history=[])
    with pytest.raises(ValueError, match="降级信号"):
        render_fallback("https://example.invalid/", tmp_path / "o2", kit=kit,
                        failure_history=[AttemptEvent(elapsed_s=5.0, pages=1, http_status=200)])


# ---------------------------------------------------------------- 离线：data: URL 全链

def test_fr7_data_url_full_chain_to_gate(tmp_path, kit):
    """FR7.1 全链（零外网）：滚动→整页截图→切片→像素拼 PDF→OCR 文字层→质检门全过。"""
    audit = tmp_path / "audit.jsonl"
    url = _tall_data_url()
    outcome = render_fallback(url, tmp_path / "chain", kit=kit,
                              failure_history=_DEAD_SITE_HISTORY, audit_path=audit)
    assert isinstance(outcome, FallbackOutcome)
    assert outcome.ok and outcome.reason == "rendered", outcome.detail
    assert outcome.pages == 2, f"1800px@900 视口应切 2 页: pages={outcome.pages}"
    assert outcome.chars >= 10, f"OCR 实测字数异常: chars={outcome.chars}"
    assert outcome.gate_exit == 0
    assert outcome.pdf_path and Path(outcome.pdf_path).exists()
    assert Path(outcome.pdf_path).name == "l3_searchable.pdf"
    assert outcome.coverage is None  # 1800px 全量截窗（未触 max_pages/16k 上限）
    # LadderResult 转换（产线契约字段；成功记 ladder_used=L3）
    ladder = outcome.to_ladder_result()
    assert ladder.ok and ladder.ladder_used == "L3"
    assert ladder.pages == 2 and ladder.chars == outcome.chars
    assert ladder.artifact_path == outcome.pdf_path and ladder.wall_status is None
    # 台账一行如实（ok 行、count=实测页数）
    lines = [json.loads(x) for x in audit.read_text(encoding="utf-8").splitlines()]
    assert len(lines) == 1 and lines[0]["status"] == "ok"
    assert lines[0]["count"] == 2 and lines[0]["event"] == "fetch_ladder_L3"


# ---------------------------------------------------------------- 离线：不可达边界

def test_fr7_unreachable_reports_zero_pages_honestly(tmp_path, kit):
    """FR7.AC1① 边界（离线腿=本机拒连端口）：不可达如实报 unreachable，零页零字不产 PDF。"""
    audit = tmp_path / "audit.jsonl"
    url = "http://127.0.0.1:%d/" % _refused_port()
    outcome = render_fallback(url, tmp_path / "dead", kit=kit,
                              failure_history=_DEAD_SITE_HISTORY,
                              nav_timeout_ms=8000, audit_path=audit)
    assert not outcome.ok and outcome.reason == "unreachable"
    assert outcome.pages == 0 and outcome.chars == 0
    assert outcome.pdf_path is None and outcome.gate_exit is None
    assert outcome.detail  # 异常事实原样入账（截首行）
    ladder = outcome.to_ladder_result()
    assert not ladder.ok and ladder.ladder_used is None  # 梯队全败=None（产线契约）
    assert ladder.pages is None and ladder.artifact_path is None
    lines = [json.loads(x) for x in audit.read_text(encoding="utf-8").splitlines()]
    assert len(lines) == 1 and lines[0]["status"] == "fail" and lines[0]["count"] == 0


# ---------------------------------------------------------------- 实弹（真实网络）

@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP, reason="KB_HARVEST_SKIP_LIVE=1：实弹用例跳过（CI 场景明示）")
def test_fr7_ac1_live_dead_site_dajudeng_unreachable(tmp_path, kit):
    """FR7.AC1① 实弹：FISH_PROBE 死站 dajudeng（TLS 瘫痪）作 L1/L2 失效源→L3 兜底不可达如实报。"""
    audit = tmp_path / "audit_dajudeng.jsonl"
    outcome = render_fallback("https://www.dajudeng.com/", tmp_path / "dajudeng", kit=kit,
                              failure_history=_DEAD_SITE_HISTORY,
                              nav_timeout_ms=20000, audit_path=audit)
    assert not outcome.ok and outcome.reason == "unreachable", (
        f"dajudeng 已被 FISH_PROBE 判死（443 TLS 握手失败 rc35），L3 兜底腿必须如实报不可达: "
        f"{outcome.reason} {outcome.detail}")
    assert outcome.pages == 0 and outcome.pdf_path is None
    assert outcome.to_ladder_result().ladder_used is None
    lines = [json.loads(x) for x in audit.read_text(encoding="utf-8").splitlines()]
    assert len(lines) == 1 and lines[0]["site"] == "www.dajudeng.com"
    assert lines[0]["status"] == "fail"


@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP, reason="KB_HARVEST_SKIP_LIVE=1：实弹用例跳过（CI 场景明示）")
def test_fr7_ac1_live_alive_page_l3_full_chain_gate_cli_zero(tmp_path, kit):
    """FR7.AC1② 实弹：wenku 公开文档页走 L3 全链，质检门 CLI 退出码 0（zero-mock）。"""
    audit = tmp_path / "audit_wenku.jsonl"
    url = "https://wenku.baidu.com/view/f660af0a26c52cc58bd63186bceb19e8b8f6ecd1.html"
    out_dir = tmp_path / "wenku"
    outcome = render_fallback(url, out_dir, kit=kit, failure_history=_DEAD_SITE_HISTORY,
                              max_pages=1, warmup_url="https://www.baidu.com/",
                              referer="https://www.baidu.com/", audit_path=audit)
    # 注：failure_history=注入式 L1/L2 超时失效信号（本页健康，信号仅用于驱动入口
    # 「检测→降级→兜底」路径进入 L3——FR7.AC1 口径；对死站用例则为真实 L1/L2 形态）
    assert outcome.ok and outcome.reason == "rendered", outcome.detail
    # 阅读器=内滚容器，body ~904px≈单视口 → max_pages=1 恰 900px 截窗=单页文档最简形态
    # （expected_pages=1；full_page 截图可越 scrollHeight 数十 px，故走截窗口径拿整 1 页）
    assert outcome.pages == 1, f"900px 截窗应产 1 页: {outcome.pages}"
    assert outcome.chars >= 50, f"文档页 OCR 实测字数异常: {outcome.chars}"
    assert outcome.pdf_path and Path(outcome.pdf_path).exists()
    # 截窗部分收割形态（900/904px 级，如实记 captured/total px）
    assert outcome.coverage is not None and re.fullmatch(r"\d+/\d+px", outcome.coverage)
    # 质检门 manifest CLI（验收口径=命令行两态退出码）：0=质检门全过
    manifest = out_dir / "l3_manifest.json"
    assert manifest.exists()
    proc = subprocess.run([sys.executable, "-m", "kb_factory.harvest_engine.quality_gate",
                           str(manifest)], cwd=str(_ROOT), capture_output=True, text=True,
                          encoding="utf-8", errors="replace", timeout=300)
    print(proc.stdout)
    assert proc.returncode == 0, f"质检门 CLI 退出码 {proc.returncode}:\n{proc.stdout}"
    # 台账一行如实
    lines = [json.loads(x) for x in audit.read_text(encoding="utf-8").splitlines()]
    assert len(lines) == 1 and lines[0]["site"] == "wenku.baidu.com"
    assert lines[0]["status"] == "ok" and lines[0]["count"] == 1
