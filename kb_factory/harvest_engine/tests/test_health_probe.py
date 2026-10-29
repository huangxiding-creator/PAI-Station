# -*- coding: utf-8 -*-
"""FR1.AC3 单测：周健康探针（公共DNS直查+每域≤2请求+8s超时+停车页检测+GBK误报排除）
+ registry {site:{status,last_probe,reason}} 三键契约 + scheduler 周任务（probe 周/台账轮转）。

- 离线用例：确定性本地驱动（网络/时间注入桩——工人公约 §3 明示注入点），零网络零 mock 框架。
- 实弹用例（@pytest.mark.live）：FISH_PROBE 已判死站回放——wenku.it168.com(503 网关空壳) 与
  www.daokeyuedu.com(NXDOMAIN) 断言 registry 标记 dead，max.book118.com 断言 alive；
  探针总量 ≤6 请求（3 域 × 每域≤2）。KB_HARVEST_SKIP_LIVE=1 时跳过并在输出明示。
- 台账/registry/周报一律写 tests/fixtures/ 参数化路径（包内不落默认位）。
"""
import json
import os
import struct
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
    from kb_factory.harvest_engine.probe.health import (  # noqa: E402
        BODY_PREFIX_LIMIT, FISH_PROBE_VERDICTS, HTTP_TIMEOUT_S, MAX_REQUESTS_PER_SITE,
        PARKING_MARKERS, PUBLIC_RESOLVERS, PROBE_UA, STATUS_ALIVE, STATUS_DEAD,
        STATUS_REDIRECT, DnsResult, FetchResp, HealthRegistry, SiteHealth,
        build_dns_query, decode_page, detect_parking, parse_dns_response,
        probe_site, resolve_public)
    from kb_factory.harvest_engine.scheduler import (  # noqa: E402
        CRON_SCHEDULE, WeeklyRunner, iso_week, rotate_ledger)
except ImportError:
    from harvest_engine.probe.health import (  # noqa: E402
        BODY_PREFIX_LIMIT, FISH_PROBE_VERDICTS, HTTP_TIMEOUT_S, MAX_REQUESTS_PER_SITE,
        PARKING_MARKERS, PUBLIC_RESOLVERS, PROBE_UA, STATUS_ALIVE, STATUS_DEAD,
        STATUS_REDIRECT, DnsResult, FetchResp, HealthRegistry, SiteHealth,
        build_dns_query, decode_page, detect_parking, parse_dns_response,
        probe_site, resolve_public)
    from harvest_engine.scheduler import (  # noqa: E402
        CRON_SCHEDULE, WeeklyRunner, iso_week, rotate_ledger)

import socket  # noqa: E402  （放注入桩之后避免遮蔽被测件视角；仅测试内用 inet_aton）

_FIXTURES = Path(__file__).resolve().parent / "fixtures"
_REGISTRY_PATH = _FIXTURES / "health_registry_test.json"
_REPORT_PATH = _FIXTURES / "weekly_report_test.jsonl"
_LEDGER_PATH = _FIXTURES / "harvest_audit_rotate_test.jsonl"
_LIVE_REGISTRY_PATH = _FIXTURES / "health_registry_live.json"
_LIVE_REPORT_PATH = _FIXTURES / "weekly_report_live.jsonl"

# woc88 实样字节（engine/SPECS/_probe/b_www.woc88.com.html @3543 起，FISH_PROBE 总表 #16）：
# 原始字节流含 "sedo"（onmou·sedo·wn 内嵌），实为正常站内搜索框——停车页检测必须排除。
_WOC88_REAL_CTX = (
    b'\xe6\x9b\xb4\xe5\xa4\x9a\xe7\xb2\xbe\xe5\x93\x81\xe2\x80\xa6\xe2\x80\xa6" '
    b'onmousedown=\'document.getElementById("q").value')


def _fresh(path: Path) -> Path:
    _FIXTURES.mkdir(parents=True, exist_ok=True)
    if path.exists():
        path.unlink()
    return path


# ---------------------------------------------------------------- DNS 原生查询包

def _make_dns_response(qid: int, rcode: int, ip: str | None) -> bytes:
    """手造 DNS 应答包：复用被测 build_dns_query 的 question 段（纯本地，零网络）。"""
    query = build_dns_query("probe.test", qid)
    flags = 0x8180 | (rcode & 0x0F)
    head = struct.pack(">HHHHHH", qid, flags, 1, 1 if rcode == 0 else 0, 0, 0)
    answer = b"\xc0\x0c" + struct.pack(">HHIH", 1, 1, 60, 4) + socket.inet_aton(ip or "0.0.0.0")
    return head + query[12:] + (answer if rcode == 0 else b"")


def test_fr1_ac3_dns_query_packet_and_rcode_parse():
    """FR1.AC3 前置：原生 DNS 查询包构造（A/IN+RD）+ 应答解析（NOERROR 取 A / NXDOMAIN=RCODE3）。"""
    q = build_dns_query("wenku.it168.com", 0x1234)
    assert struct.unpack(">HHHHHH", q[:12]) == (0x1234, 0x0100, 1, 0, 0, 0)
    assert b"\x05wenku\x05it168\x03com\x00" in q  # 标签编码：len 前缀域名
    assert q[-4:] == struct.pack(">HH", 1, 1)     # QTYPE=A, QCLASS=IN
    rcode, ips = parse_dns_response(_make_dns_response(0x1234, 0, "125.44.162.204"), 0x1234)
    assert rcode == 0 and ips == ("125.44.162.204",)
    rcode, ips = parse_dns_response(_make_dns_response(0x1234, 3, None), 0x1234)
    assert rcode == 3 and ips == ()               # NXDOMAIN：RCODE=3 无答案
    with pytest.raises(ValueError):
        parse_dns_response(_make_dns_response(0xBEEF, 0, "1.2.3.4"), 0x1234)  # 事务 ID 不匹配硬拒


def test_fr1_ac3_public_dns_direct_query_aggregation():
    """FR1.AC3 公共DNS直查：223.5.5.5/119.29.29.29 双解析器聚合——OK 优先/NXDOMAIN 死域/全超时不resolved。"""
    # 1) 首解析器 NOERROR → 即判存在
    def t_ok_first(resolver, query, timeout):
        assert resolver in PUBLIC_RESOLVERS and timeout == HTTP_TIMEOUT_S or True
        return _make_dns_response(struct.unpack(">H", query[:2])[0], 0, "222.141.28.140") \
            if resolver == PUBLIC_RESOLVERS[0] else b""
    r = resolve_public("max.book118.com", transport=t_ok_first)
    assert r.ok and r.detail == "ok" and r.rcode == 0 and r.resolver == PUBLIC_RESOLVERS[0]
    # 2) 双解析器一致 NXDOMAIN → 死域
    def t_nx_both(resolver, query, timeout):
        return _make_dns_response(struct.unpack(">H", query[:2])[0], 3, None)
    r = resolve_public("www.daokeyuedu.com", transport=t_nx_both)
    assert not r.ok and r.detail == "nxdomain" and r.rcode == 3
    # 3) 一 NX 一 OK → 以 OK 为准（公共解析器负缓存滞后不误杀）
    def t_nx_then_ok(resolver, query, timeout):
        rcode = 3 if resolver == PUBLIC_RESOLVERS[0] else 0
        return _make_dns_response(struct.unpack(">H", query[:2])[0], rcode, "8.8.8.8")
    r = resolve_public("lag.example", transport=t_nx_then_ok)
    assert r.ok and r.detail == "ok"
    # 4) 双解析器全超时 → dns_unresolved（不下死结论，交 HTTP 腿判定）
    r = resolve_public("slow.example", transport=lambda resolver, query, timeout: b"")
    assert not r.ok and r.detail == "dns_unresolved" and r.rcode == -1


# ---------------------------------------------------------------- 停车页检测

def test_fr1_ac3_parking_markers_and_gbk_false_positive_exclusion():
    """FR1.AC3 停车页检测：sedo/godaddy 标记命中 + GBK 双字节/词内嵌误报排除（FISH_PROBE #16）。"""
    assert b"sedo" in _WOC88_REAL_CTX  # 原始字节确含 sedo（onmousedown 内嵌）——真误报现场
    assert detect_parking(_WOC88_REAL_CTX, {}) is None  # 解码+词边界后不命中
    gbk_trail = b"\x81\x73edo"  # GBK 双字节字符(主 U+4E7B)尾字节 0x73 吞掉 's'：原始字节含 sedo
    assert b"sedo" in gbk_trail and "sedo" not in gbk_trail.decode("gbk")
    assert detect_parking(gbk_trail, {}) is None        # 按声明/探测字符集解码后搜——不误报
    assert detect_parking(
        b"<html><body>This page is parked: <b>sedo</b> marketplace.</body></html>", {}) == "sedo"
    assert detect_parking(
        b"<html><head><title>example.com is for sale | GoDaddy</title></head></html>", {}) == "godaddy"
    gbk_sale = '<html><head><meta charset="gbk"><title>域名出售</title></head><body>此域名出售，欢迎一口价洽谈</body></html>'.encode("gbk")
    assert detect_parking(gbk_sale, {}) == "此域名出售"  # GBK 页声明解码后中文标记命中
    clean = "<html><head><title>帮帮文库</title></head><body>办公模板 免费下载</body></html>".encode("gbk")
    assert detect_parking(clean, {"content-type": "text/html; charset=GBK"}) is None
    # 字符集解码：header 声明优先（GBK），其次 meta，最后 utf-8 严格试探→gbk 兜底
    assert decode_page("更多精品".encode("gbk"), {"content-type": "text/html; charset=GBK"}) == "更多精品"
    assert decode_page("更多精品".encode("gbk"), {}) == "更多精品"


# ---------------------------------------------------------------- probe_site 判定矩阵

class ScriptedFetch:
    """网络注入桩（公约 §3 网络故障注入点）：按序消费 (url片段, method) → FetchResp；耗尽=连接失败。"""

    def __init__(self, script):
        self.script = list(script)
        self.calls: list[dict] = []

    def __call__(self, url, *, method, timeout, headers):
        self.calls.append({"url": url, "method": method, "timeout": timeout,
                           "ua": headers.get("User-Agent", "")})
        for i, (frag, want, resp) in enumerate(self.script):
            if frag in url and want in (None, method):
                self.script.pop(i)
                return resp
        return FetchResp(code=None, err="脚本耗尽（未预期请求）")


def _dns_ok(ips=("222.141.28.140",)):
    return lambda site, **kw: DnsResult(ok=True, rcode=0, ips=ips, resolver="223.5.5.5", detail="ok")


def _dns_nx(site, **kw):
    return DnsResult(ok=False, rcode=3, ips=(), resolver=None, detail="nxdomain")


def test_fr1_ac3_probe_protocol_constants():
    """FR1.AC3 协议口径=FISH_PROBE 方法学：公共解析器对/每域≤2请求/8s 超时/首页头 200KB/Chrome124 UA。"""
    assert PUBLIC_RESOLVERS == ("223.5.5.5", "119.29.29.29")
    assert MAX_REQUESTS_PER_SITE == 2
    assert HTTP_TIMEOUT_S == 8.0
    assert BODY_PREFIX_LIMIT == 200 * 1024
    assert "Chrome/124" in PROBE_UA and "Windows NT 10.0" in PROBE_UA
    assert {"sedo", "godaddy"} <= set(PARKING_MARKERS)


_M503_HEAD = FetchResp(code=503, headers={})
_M503_GET = FetchResp(code=503, body=b"<html>ERROR: CANNOT FORWARD</html>", headers={})
_M200_HEAD = FetchResp(code=200, headers={"content-type": "text/html; charset=utf-8"})
_M200_BODY = (b"<html><head><title>\xe6\x96\x87\xe5\xba\x93\xe9\xa6\x96\xe9\xa1\xb5</title></head>"
              b"<body>\xe6\x96\x87\xe6\xa1\xa3\xe9\xa2\x84\xe8\xa7\x88</body></html>")

_MATRIX = [
    # (id, script, resolve, 期望status, 期望reason前缀, 期望requests)
    ("it168_503_gateway_shell",
     [("wenku.it168.com", "HEAD", _M503_HEAD), ("wenku.it168.com", "GET", _M503_GET)],
     _dns_ok(("125.44.162.204",)), STATUS_DEAD, "http_5xx:503", 2),
    ("daokeyuedu_nxdomain_no_http",
     [], _dns_nx, STATUS_DEAD, "nxdomain", 0),
    ("book118_alive_head_get",
     [("max.book118.com", "HEAD", _M200_HEAD), ("max.book118.com", "GET", FetchResp(code=200, body=_M200_BODY, headers={"content-type": "text/html; charset=utf-8"}))],
     _dns_ok(), STATUS_ALIVE, "ok", 2),
    ("woc88_https_dead_http_alive",
     [("https://www.woc88.com", "HEAD", FetchResp(code=None, err="https 连接超时")),
      ("http://www.woc88.com", "GET", FetchResp(code=200, body=_M200_BODY, headers={}))],
     _dns_ok(("218.65.178.41",)), STATUS_ALIVE, "ok_http_only", 2),
    ("kaoshidian_301_http_downgrade",
     [("www.kaoshidian.com", "HEAD", FetchResp(code=301, headers={"location": "http://www.kaoshidian.com/"}))],
     _dns_ok(("122.114.17.16",)), STATUS_REDIRECT, "redirect", 1),
    ("parked_sedo_page",
     [("x.test", "HEAD", _M200_HEAD),
      ("x.test", "GET", FetchResp(code=200, body=b"<html>This page is parked: sedo marketplace.</html>", headers={}))],
     _dns_ok(), STATUS_DEAD, "parked:sedo", 2),
    ("connect_double_fail",
     [("https://dead.test", "HEAD", FetchResp(code=None, err="TLS 握手重置")),
      ("http://dead.test", "GET", FetchResp(code=None, err="连接超时"))],
     _dns_ok(), STATUS_DEAD, "connect_fail", 2),
    ("head_405_fallback_get",
     [("y.test", "HEAD", FetchResp(code=405, headers={})),
      ("y.test", "GET", FetchResp(code=200, body=_M200_BODY, headers={}))],
     _dns_ok(), STATUS_ALIVE, "ok", 2),
]


@pytest.mark.parametrize("case_id,script,resolve,exp_status,exp_reason,exp_requests", _MATRIX,
                         ids=[c[0] for c in _MATRIX])
def test_fr1_ac3_probe_site_verdict_matrix_and_request_budget(
        case_id, script, resolve, exp_status, exp_reason, exp_requests):
    """FR1.AC3 判定矩阵（离线注入）：每域 HTTP 请求硬预算≤2 + HEAD 优先 + 连接级失败转 http 降级。"""
    fetch = ScriptedFetch(script)
    site = "wenku.it168.com" if "it168" in case_id else (
        "www.daokeyuedu.com" if "daokeyuedu" in case_id else (
            "max.book118.com" if "book118" in case_id else (
                "www.woc88.com" if "woc88" in case_id else (
                    "www.kaoshidian.com" if "kaoshidian" in case_id else
                    ("x.test" if "parked" in case_id else ("dead.test" if "connect" in case_id else "y.test"))))))
    h = probe_site(site, fetch=fetch, resolve=resolve, timeout=HTTP_TIMEOUT_S)
    assert isinstance(h, SiteHealth)
    assert h.status == exp_status, (case_id, h)
    assert h.reason.startswith(exp_reason), (case_id, h.reason)
    assert h.requests == exp_requests == len(fetch.calls)  # 实测请求数=fetch 调用数（零造假）
    assert h.requests <= MAX_REQUESTS_PER_SITE
    if exp_requests:
        assert fetch.calls[0]["timeout"] == HTTP_TIMEOUT_S          # 8s 超时口径
        assert "Chrome/124" in fetch.calls[0]["ua"]                 # 浏览器 UA
        assert fetch.calls[0]["method"] == "HEAD"                   # HEAD 优先
    if case_id == "it168_503_gateway_shell":
        assert h.http_code == 503
    if case_id == "woc88_https_dead_http_alive":
        assert fetch.calls[1]["url"].startswith("http://") and fetch.calls[1]["method"] == "GET"
    if case_id == "kaoshidian_301_http_downgrade":
        assert h.redirect_to == "http://www.kaoshidian.com/" and h.http_code == 301
    if case_id == "daokeyuedu_nxdomain_no_http":
        assert fetch.calls == []                                    # NXDOMAIN 不发 HTTP


# ---------------------------------------------------------------- registry 三键契约

def test_fr1_ac3_registry_three_key_contract_and_dead_marking():
    """FR1.AC3 registry 契约：{site:{status,last_probe,reason}} 恰三键持久化 + dead 标记/移出调度。"""
    reg = HealthRegistry(_fresh(_REGISTRY_PATH))
    ts = datetime(2026, 10, 22, 12, 0, 0)
    h_dead = SiteHealth(site="wenku.it168.com", status=STATUS_DEAD, reason="http_5xx:503",
                        http_code=503, requests=2, ip="125.44.162.204")
    reg.upsert(h_dead, now=ts)
    reg.upsert(SiteHealth(site="www.daokeyuedu.com", status=STATUS_DEAD, reason="nxdomain",
                          http_code=None, requests=0, ip=None), now=ts)
    reg.upsert(SiteHealth(site="max.book118.com", status=STATUS_ALIVE, reason="ok",
                          http_code=200, requests=2, ip="222.141.28.140"), now=ts)
    on_disk = json.loads(_REGISTRY_PATH.read_text(encoding="utf-8"))
    assert set(on_disk) == {"wenku.it168.com", "www.daokeyuedu.com", "max.book118.com"}
    for site, v in on_disk.items():  # 恰三键（任务书契约），键序固定
        assert list(v) == ["status", "last_probe", "reason"]
        assert v["last_probe"] == "2026-10-22T12:00:00"
    assert on_disk["wenku.it168.com"]["status"] == "dead"
    assert on_disk["www.daokeyuedu.com"]["reason"] == "nxdomain"
    assert reg.dead_sites() == ["wenku.it168.com", "www.daokeyuedu.com"]     # dead 标记
    assert reg.scheduled_sites() == ["max.book118.com"]                      # 移出调度语义
    # 持久化往返：新实例重载一致
    assert HealthRegistry(_REGISTRY_PATH).load() == on_disk
    # 复活路径：alive upsert 覆盖 dead
    reg.upsert(SiteHealth(site="wenku.it168.com", status=STATUS_ALIVE, reason="ok"), now=ts)
    assert reg.dead_sites() == ["www.daokeyuedu.com"]


def test_fish_probe_verdict_table_contract():
    """FISH_PROBE 总表程序化镜像（22 域）：回放锚点三站与规格一致。"""
    assert len(FISH_PROBE_VERDICTS) == 22
    assert set(FISH_PROBE_VERDICTS.values()) == {"alive", "dead", "redirect"}
    assert FISH_PROBE_VERDICTS["wenku.it168.com"] == "dead"
    assert FISH_PROBE_VERDICTS["www.daokeyuedu.com"] == "dead"
    assert FISH_PROBE_VERDICTS["max.book118.com"] == "alive"
    assert FISH_PROBE_VERDICTS["www.kaoshidian.com"] == "redirect"
    assert FISH_PROBE_VERDICTS["www.woc88.com"] == "alive"


# ---------------------------------------------------------------- scheduler 周任务

def _fake_prober(site):
    """确定性 prober（注入替身，替网络腿）：三站固定判——it168 死/daokeyuedu 死/book118 活。"""
    table = {
        "wenku.it168.com": SiteHealth(site=site, status=STATUS_DEAD, reason="http_5xx:503",
                                      http_code=503, requests=2, ip="125.44.162.204"),
        "www.daokeyuedu.com": SiteHealth(site=site, status=STATUS_DEAD, reason="nxdomain",
                                         http_code=None, requests=0, ip=None),
        "max.book118.com": SiteHealth(site=site, status=STATUS_ALIVE, reason="ok",
                                      http_code=200, requests=2, ip="222.141.28.140"),
    }
    return table[site]


def test_fr1_ac3_scheduler_weekly_report_and_ledger_rotation():
    """FR1.AC3 周任务：cron 序 probe@weekly→ledger_rotate@weekly；周报行 JSONL + dead 入报 + 台账轮转零删除。"""
    assert CRON_SCHEDULE == ("probe@weekly", "ledger_rotate@weekly")
    _fresh(_REGISTRY_PATH); _fresh(_REPORT_PATH); _fresh(_LEDGER_PATH)
    audit_lines = [json.dumps({"ts": f"2026-10-2{i}T10:00:00", "site": f"s{i}", "event": "search",
                               "query_or_docid": f"q{i}", "count": i, "status": "ok", "detail": "x"})
                   for i in (0, 1, 2)]
    _LEDGER_PATH.write_text("\n".join(audit_lines) + "\n", encoding="utf-8")
    fixed_now = lambda: datetime(2026, 10, 22, 12, 0, 0)  # noqa: E731 时间注入点
    runner = WeeklyRunner(registry_path=_REGISTRY_PATH, report_path=_REPORT_PATH,
                          ledger_path=_LEDGER_PATH, prober=_fake_prober, now=fixed_now)
    assert iso_week(fixed_now) == "2026-W43"
    summary = runner.run_week(["wenku.it168.com", "www.daokeyuedu.com", "max.book118.com"])
    # 周探针汇总（数字零造假：counts=实测注入值）
    assert summary["week"] == "2026-W43" and summary["cron_run"] == list(CRON_SCHEDULE)
    assert (summary["probed"], summary["alive"], summary["dead"], summary["redirect"]) == (3, 1, 2, 0)
    assert summary["requests"] == 4  # 2+0+2
    assert summary["dead_sites"] == ["wenku.it168.com", "www.daokeyuedu.com"]
    # registry：dead 标记落盘（三键契约见上用例）
    on_disk = json.loads(_REGISTRY_PATH.read_text(encoding="utf-8"))
    assert on_disk["wenku.it168.com"]["status"] == "dead"
    assert on_disk["max.book118.com"]["status"] == "alive"
    # 周报行：每站一行 JSONL，字段序固定；dead 站入报
    rows = [json.loads(x) for x in _REPORT_PATH.read_text(encoding="utf-8").splitlines()]
    assert len(rows) == 3
    for row in rows:
        assert list(row) == ["week", "site", "status", "reason", "http_code", "requests", "ip", "ts"]
        assert row["week"] == "2026-W43"
    dead_rows = {r["site"] for r in rows if r["status"] == "dead"}
    assert dead_rows == {"wenku.it168.com", "www.daokeyuedu.com"}
    # 台账轮转：改名归档保数据（零删除纪律）；原位消失=已轮转；再跑一周无文件 no-op
    rotated = Path(summary["rotated_to"])
    assert rotated.name == "harvest_audit_rotate_test.2026-W43.jsonl" and rotated.exists()
    assert rotated.read_text(encoding="utf-8").splitlines() == audit_lines  # 内容原样
    assert not _LEDGER_PATH.exists()
    assert runner.run_ledger_rotate("2026-W43") is None      # 无可轮转 → no-op
    # 归档位占用不覆盖：再造台账同周轮转 → 序号后缀
    _LEDGER_PATH.write_text("x\n", encoding="utf-8")
    rotated2 = runner.run_ledger_rotate("2026-W43")
    assert rotated2 is not None and rotated2.name.endswith(".2026-W43.jsonl.1") and rotated2.exists()
    assert rotate_ledger(_LEDGER_PATH, rotated2) is None     # 源已不存在 → no-op


# ---------------------------------------------------------------- 实弹回放（真实网络）

@pytest.mark.live
def test_fr1_ac3_live_replay_fish_probe_dead_and_alive():
    """FR1.AC3 实弹回放（zero-mock 真网络）：it168(503)/daokeyuedu(NXDOMAIN)→registry dead；book118→alive。"""
    if os.environ.get("KB_HARVEST_SKIP_LIVE") == "1":
        print("[live-skip] KB_HARVEST_SKIP_LIVE=1：实弹回放用例跳过（CI 场景明示）")
        pytest.skip("[live-skip] KB_HARVEST_SKIP_LIVE=1 实弹回放跳过")
    sites = ("wenku.it168.com", "www.daokeyuedu.com", "max.book118.com")
    runner = WeeklyRunner(registry_path=_fresh(_LIVE_REGISTRY_PATH),
                          report_path=_fresh(_LIVE_REPORT_PATH))  # 默认真 probe_site
    summary = runner.run_probe(sites)
    # 预算硬门：探针总量 ≤6 请求（3 域 × 每域≤2）
    assert summary["requests"] <= 6, summary
    on_disk = json.loads(_LIVE_REGISTRY_PATH.read_text(encoding="utf-8"))
    assert on_disk["wenku.it168.com"]["status"] == "dead"      # 网关空壳 503（FISH_PROBE #10）
    assert on_disk["wenku.it168.com"]["reason"].startswith("http_5xx")
    assert on_disk["www.daokeyuedu.com"]["status"] == "dead"   # 域名注销 NXDOMAIN（FISH_PROBE #2）
    assert on_disk["www.daokeyuedu.com"]["reason"] == "nxdomain"
    assert on_disk["max.book118.com"]["status"] == "alive"     # 原创力文库存活（FISH_PROBE #3）
    assert on_disk["max.book118.com"]["reason"].startswith("ok")
    # 判定与 FISH_PROBE 总表（2026-10-22 实测）一致
    for site in sites:
        assert on_disk[site]["status"] == FISH_PROBE_VERDICTS[site], (site, on_disk[site])
    # 周报行产出（dead 站入报）
    rows = [json.loads(x) for x in _LIVE_REPORT_PATH.read_text(encoding="utf-8").splitlines()]
    assert len(rows) == 3 and {r["site"] for r in rows if r["status"] == "dead"} == set(sites[:2])


def teardown_module(module):
    """运行时产物不留仓：清理 fixtures 下本件临时 registry/周报/台账（默认位未 ignore，只写 fixtures）。"""
    for p in (_REGISTRY_PATH, _REPORT_PATH, _LEDGER_PATH,
              _FIXTURES / "harvest_audit_rotate_test.2026-W43.jsonl",
              _FIXTURES / "harvest_audit_rotate_test.2026-W43.jsonl.1",
              _LIVE_REGISTRY_PATH, _LIVE_REPORT_PATH):
        if p.exists():
            p.unlink()
