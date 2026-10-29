# -*- coding: utf-8 -*-
"""周健康探针（FR1.3 / FISH_PROBE 方法学，22 域 32 请求口径）：判死 → registry 标记 dead。

方法学（engine/SPECS/FISH_PROBE.md 方法注记）：
- 公共DNS直查：本机 fake-ip 代理下本地 nslookup 全返 198.18.x 无参考价值——用 stdlib
  socket 发原生 DNS 查询包（A/IN+RD）直查 223.5.5.5 / 119.29.29.29，RCODE=3(NXDOMAIN)
  判死域（dnspython 不在位，零新依赖）；双解析器一致 OK 优先、一 NX 一 OK 以 OK 为准。
- HTTP 口径：HEAD 优先、失败转 GET；每域 HTTP 请求硬预算 ≤2（连接级失败→http 降级第二击，
  woc88 仅 80 苟活型）；连接/读超时 8s；浏览器 UA（Chrome/124 Win10）；不登录不下载，
  仅取首页头 200KB 判停车页；3xx 不跟随（省预算）记 redirect 终点。
- 停车/卖域页：sedo/godaddy/afternic 等标记——按页面声明字符集解码后按 ASCII 词边界匹配，
  排除两类误报（FISH_PROBE 总表 #16）：①词内嵌（onmou*sedo*wn 搜索框事件句柄）
  ②GBK 双字节尾字节吞字（原始字节含 sedo、GBK 解码后不含）。
- 判定：NXDOMAIN→dead；全击 ≥400/连接失败→dead（it168 网关 503 空壳型）；停车页标记→dead；
  ≥1 击 2xx 且无标记→alive；3xx→redirect。registry 契约（任务书）：{site: {status,
  last_probe, reason}} 恰三键 JSON 持久化；更丰富实测字段（ip/http_code/requests）落周报行。

注入点（工人公约 §3）：fetch（HTTP 网络）/resolve（DNS 网络）/now（时钟）皆可参数化，
测试注入确定性替身，实弹用默认真实现（zero-mock）。
"""
from __future__ import annotations

import json
import os
import random
import re
import socket
import struct
from dataclasses import dataclass, field
from datetime import datetime
from pathlib import Path

import httpx

# ---------------------------------------------------------------- 协议口径常量（FISH_PROBE 方法学）

PUBLIC_RESOLVERS = ("223.5.5.5", "119.29.29.29")   # 阿里 / 腾讯公共解析器（fake-ip 旁路真解析）
DNS_PORT = 53
DNS_QTYPE_A = 1
DNS_TIMEOUT_S = 8.0
HTTP_TIMEOUT_S = 8.0
MAX_REQUESTS_PER_SITE = 2                          # 每域 HTTP 请求硬预算
BODY_PREFIX_LIMIT = 200 * 1024                     # 首页头截取上限（仅判停车页，不下载文件）
PROBE_UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
            "(KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36")

STATUS_ALIVE = "alive"
STATUS_DEAD = "dead"
STATUS_REDIRECT = "redirect"

PARKING_MARKERS = ("sedo", "godaddy", "afternic", "buy this domain", "domain for sale",
                   "此域名出售", "一口价")

# FISH_PROBE 总表（2026-10-22 实测，22 域）判定镜像：适配器优先级/回放锚点的程序化依据
FISH_PROBE_VERDICTS = {
    "www.bingdian001.com": "dead", "www.daokeyuedu.com": "dead",
    "max.book118.com": "alive", "openapi.book118.com": "alive",
    "www.docin.com": "alive", "www.doc88.com": "alive",
    "oss.dq123.com": "dead", "www.dq123.com": "alive",
    "www.dajudeng.com": "dead", "wenku.it168.com": "dead",
    "www.jztyx.com": "dead", "www.mbalib.com": "alive",
    "doc.vzkoo.com": "dead", "www.vzkoo.com": "alive",
    "www.taodocs.com": "dead", "www.woc88.com": "alive",
    "bbs.kaoshidian.com": "dead", "www.kaoshidian.com": "redirect",
    "doc.vsharing.com": "dead", "www.51fangan.com": "alive",
    "file.taodocs.com": "dead", "pics.wanlibo.com": "dead",
}


# ---------------------------------------------------------------- DNS：原生查询包（公共解析器直查）

@dataclass
class DnsResult:
    """公共解析器直查结果：detail ∈ {ok, nxdomain, dns_unresolved}。"""

    ok: bool
    rcode: int
    ips: tuple = ()
    resolver: str | None = None
    detail: str = ""


def build_dns_query(domain: str, qid: int) -> bytes:
    """构造 A/IN 递归查询包（stdlib 原生，不依赖 dnspython）。"""
    labels = domain.rstrip(".").split(".")
    qname = b"".join(bytes([len(p)]) + p.encode("ascii") for p in labels) + b"\x00"
    header = struct.pack(">HHHHHH", qid & 0xFFFF, 0x0100, 1, 0, 0, 0)  # RD=1
    return header + qname + struct.pack(">HH", DNS_QTYPE_A, 1)


def _skip_name(data: bytes, off: int) -> int:
    """跳过一个 DNS name（含 0xC0 压缩指针），返回新偏移。"""
    while True:
        if off >= len(data):
            raise ValueError("响应截断于 name 段")
        length = data[off]
        if length == 0:
            return off + 1
        if length & 0xC0 == 0xC0:  # 压缩指针：两字节，不再后随
            return off + 2
        off += 1 + length


def parse_dns_response(data: bytes, qid: int) -> tuple[int, tuple]:
    """解析应答 → (rcode, A记录IP 元组)；事务 ID 不匹配/截断硬拒 ValueError。"""
    if len(data) < 12:
        raise ValueError(f"响应截断: {len(data)}B < 12B 头")
    rid, flags, qdcount, ancount, _ns, _ar = struct.unpack(">HHHHHH", data[:12])
    if rid != qid:
        raise ValueError(f"事务 ID 不匹配: {rid}!={qid}")
    rcode = flags & 0x0F
    off = 12
    for _ in range(qdcount):
        off = _skip_name(data, off)
        off += 4  # QTYPE + QCLASS
    ips: list[str] = []
    for _ in range(ancount):
        off = _skip_name(data, off)
        rtype, _rclass, _ttl, rdlength = struct.unpack(">HHIH", data[off:off + 10])
        off += 10
        rdata = data[off:off + rdlength]
        off += rdlength
        if rtype == DNS_QTYPE_A and rdlength == 4:
            ips.append(socket.inet_ntoa(rdata))
    return rcode, tuple(ips)


def _udp_dns_transport(resolver: str, query: bytes, timeout: float) -> bytes:
    """默认传输腿：UDP 直查公共解析器；任何 OSError→b''（超时/不可达，不抛出）。"""
    try:
        with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:
            s.settimeout(timeout)
            s.sendto(query, (resolver, DNS_PORT))
            data, _addr = s.recvfrom(4096)
            return data
    except OSError:
        return b""


def resolve_public(domain: str, *, resolvers: tuple = PUBLIC_RESOLVERS,
                   timeout: float = DNS_TIMEOUT_S, transport=None) -> DnsResult:
    """公共解析器直查聚合：任一 NOERROR→ok；NXDOMAIN（无 OK 反证）→nxdomain；全败→dns_unresolved。"""
    transport = transport or _udp_dns_transport
    saw_nxdomain = False
    for resolver in resolvers:
        qid = random.getrandbits(16)
        resp = transport(resolver, build_dns_query(domain, qid), timeout)
        if not resp:
            continue  # 超时/不可达 → 换下一解析器
        try:
            rcode, ips = parse_dns_response(resp, qid)
        except ValueError:
            continue  # 损包/ID 错 → 换下一解析器
        if rcode == 0:
            return DnsResult(ok=True, rcode=0, ips=ips, resolver=resolver, detail="ok")
        if rcode == 3:
            saw_nxdomain = True  # 负缓存滞后可能：继续问下一家，有 OK 反证则翻案
        # SERVFAIL/REFUSED 等 → 换下一解析器
    if saw_nxdomain:
        return DnsResult(ok=False, rcode=3, ips=(), resolver=None, detail="nxdomain")
    return DnsResult(ok=False, rcode=-1, ips=(), resolver=None, detail="dns_unresolved")


# ---------------------------------------------------------------- 停车/卖域页检测（GBK 误报排除）

_CHARSET_RE = re.compile(rb"charset=[\"']?([\w-]+)", re.IGNORECASE)


@dataclass
class FetchResp:
    """单次 HTTP 探测结果：code=None 表示连接级失败（err 载原始错误事实）。"""

    code: int | None
    err: str = ""
    body: bytes = b""
    headers: dict = field(default_factory=dict)


def decode_page(body: bytes, headers: dict | None = None) -> str:
    """页面解码：header 声明 > meta 声明 > utf-8 严格试探 > gbk 兜底（中文遗产站默认）。"""
    declared = None
    ctype = ""
    for key in ("content-type", "Content-Type"):
        ctype = (headers or {}).get(key, "") or ctype
    m = re.search(r"charset=[\"']?([\w-]+)", ctype, re.IGNORECASE)
    if m:
        declared = m.group(1).lower()
    if not declared:
        m = _CHARSET_RE.search(body[:2048])
        if m:
            declared = m.group(1).decode("ascii", "replace").lower()
    if declared:
        try:
            return body.decode(declared, errors="replace")
        except LookupError:
            pass  # 未知字符集名 → 落探测
    try:
        return body.decode("utf-8")  # 严格试探：纯 ASCII/UTF-8 页在此消化
    except UnicodeDecodeError:
        return body.decode("gbk", errors="replace")


def _compile_parking_regexes() -> tuple:
    """标记词→正则：纯 ASCII 词加 [0-9A-Za-z] 词边界（拒 onmousedown 内嵌）；中文短语原样子串。"""
    compiled = []
    for marker in PARKING_MARKERS:
        if marker.isascii():
            rx = re.compile(r"(?<![0-9A-Za-z])" + re.escape(marker) + r"(?![0-9A-Za-z])",
                            re.IGNORECASE)
        else:
            rx = re.compile(re.escape(marker))
        compiled.append((marker, rx))
    return tuple(compiled)


_PARKING_RES = _compile_parking_regexes()


def detect_parking(body: bytes, headers: dict | None = None) -> str | None:
    """停车/卖域页判定：解码后按词边界搜标记——命中返回标记名（PARKING_MARKERS 序），否则 None。"""
    if not body:
        return None
    text = decode_page(body, headers)
    for marker, rx in _PARKING_RES:
        if rx.search(text):
            return marker
    return None


# ---------------------------------------------------------------- 单域探针

@dataclass
class SiteHealth:
    """单域健康判定产物：status=alive|dead|redirect；requests=实测 HTTP 请求数（零造假）。"""

    site: str
    status: str
    reason: str
    http_code: int | None = None
    requests: int = 0
    ip: str | None = None
    redirect_to: str | None = None
    detail: str = ""


def default_fetch(url: str, *, method: str, timeout: float, headers: dict) -> FetchResp:
    """默认 HTTP 腿（httpx，实弹）：不跟随重定向、不校验证书（存活探针口径：vsharing rc60 类
    证书 CN 不匹配不误杀）、读流截 BODY_PREFIX_LIMIT——不登录、不下载文件。"""
    try:
        with httpx.Client(verify=False, follow_redirects=False,
                          timeout=httpx.Timeout(timeout, connect=timeout)) as client:
            with client.stream(method, url, headers=headers) as resp:
                body = b""
                for chunk in resp.iter_bytes():
                    body += chunk
                    if len(body) >= BODY_PREFIX_LIMIT:
                        body = body[:BODY_PREFIX_LIMIT]
                        break
                return FetchResp(code=resp.status_code, body=body, headers=dict(resp.headers))
    except httpx.HTTPError as exc:
        return FetchResp(code=None, err=f"{type(exc).__name__}: {exc}")


def _hdr(headers: dict | None, name: str) -> str:
    lowered = {str(k).lower(): v for k, v in (headers or {}).items()}
    return lowered.get(name.lower(), "")


def _judge(site: str, calls: list, ip: str | None, scheme_note: str) -> SiteHealth:
    """两击终判：全击连接失败/≥400 → dead；停车页标记 → dead；≥1 击 2xx 无标记 → alive。"""
    requests = len(calls)
    r1, r2 = calls[0], calls[-1]

    def bad(r: FetchResp) -> bool:
        return r.code is None or r.code >= 400

    if all(bad(r) for r in calls):
        final = r2 if r2.code is not None else r1
        if final.code is None:
            return SiteHealth(site, STATUS_DEAD, "connect_fail", requests=requests, ip=ip,
                              detail=f"两击连接级失败：[{r1.err or 'https HEAD 无响应'}；"
                                     f"{r2.err or 'http GET 无响应'}]")
        cls = "http_5xx" if final.code >= 500 else "http_4xx"
        return SiteHealth(site, STATUS_DEAD, f"{cls}:{final.code}", http_code=final.code,
                          requests=requests, ip=ip,
                          detail=f"两击均 ≥400（网关空壳/拒绝型）：HEAD={r1.code} GET={r2.code}")
    # 至少一击 2xx：取携带 body 的最佳击判停车页（GET 优先，HEAD 无 body 只能跳过页级检测）
    good = r2 if (r2.code is not None and r2.code < 400 and r2.body) else (
        r1 if (r1.code is not None and r1.code < 400) else r2)
    marker = detect_parking(good.body, good.headers)
    if marker:
        return SiteHealth(site, STATUS_DEAD, f"parked:{marker}", http_code=good.code,
                          requests=requests, ip=ip, detail=f"停车/卖域页标记命中：{marker}")
    reason = "ok" if not scheme_note else f"ok_{scheme_note}"
    detail = f"HEAD={r1.code} GET={r2.code}" + ("（https 挂、http 降级存活）" if scheme_note else "")
    return SiteHealth(site, STATUS_ALIVE, reason, http_code=good.code, requests=requests,
                      ip=ip, detail=detail)


def probe_site(site: str, *, fetch=None, resolve=None, timeout: float = HTTP_TIMEOUT_S) -> SiteHealth:
    """单域健康探针（FISH_PROBE 全口径）：DNS 直查 → HTTP ≤2 击 → SiteHealth 判定。"""
    fetch = fetch or default_fetch
    resolve = resolve or resolve_public
    headers = {"User-Agent": PROBE_UA, "Accept": "*/*"}
    dns = resolve(site)
    ip = dns.ips[0] if dns.ips else None
    if dns.detail == "nxdomain":
        return SiteHealth(site, STATUS_DEAD, "nxdomain", requests=0, ip=None,
                          detail="公共DNS解析 NXDOMAIN：域名已注销（FISH_PROBE 型死域）")
    calls: list[FetchResp] = []

    def hit(url: str, method: str) -> FetchResp:
        resp = fetch(url, method=method, timeout=timeout, headers=dict(headers))
        calls.append(resp)
        return resp

    https_url = f"https://{site}/"
    r1 = hit(https_url, "HEAD")  # 第 1 击：HEAD 优先（FISH_PROBE 口径）
    if r1.code is not None and 300 <= r1.code < 400:
        # 3xx 不跟随（省预算），记终点（kaoshidian https→http 降级型）
        location = _hdr(r1.headers, "location")
        return SiteHealth(site, STATUS_REDIRECT, "redirect", http_code=r1.code,
                          requests=len(calls), ip=ip, redirect_to=location,
                          detail=f"3xx 终点：{location or '（无 location 头）'}")
    if r1.code is not None:
        # 拿到了 HTTP 应答 → 第 2 击同 scheme GET（补 body/二击确认 5xx）
        hit(https_url, "GET")
        return _judge(site, calls, ip, scheme_note="")
    # 第 1 击连接级失败 → 第 2 击 http 降级 GET（woc88 仅 80 苟活型；TLS 瘫痪型再败即死）
    hit(f"http://{site}/", "GET")
    return _judge(site, calls, ip, scheme_note="http_only")


# ---------------------------------------------------------------- registry：{site:{status,last_probe,reason}}

class HealthRegistry:
    """站点健康登记表（任务书契约）：{site: {status, last_probe, reason}} 恰三键 JSON 持久化。

    dead_sites()=死站清单（移出调度）；scheduled_sites()=在调站（status != dead）。
    路径必填参数化（不落仓库默认位；测试写 tests/fixtures/）。
    """

    SCHEMA_KEYS = ("status", "last_probe", "reason")

    def __init__(self, path):
        self.path = Path(path)
        self._data: dict = {}

    def load(self) -> dict:
        if self.path.exists():
            self._data = json.loads(self.path.read_text(encoding="utf-8"))
        else:
            self._data = {}
        return self._data

    def save(self) -> None:
        self.path.parent.mkdir(parents=True, exist_ok=True)
        tmp = self.path.with_name(self.path.name + ".tmp")
        tmp.write_text(json.dumps(self._data, ensure_ascii=False, indent=1), encoding="utf-8")
        os.replace(tmp, self.path)  # 原子写

    def upsert(self, health: SiteHealth, now=None) -> dict:
        """探针结果落表：恰三键（更丰富字段归周报行，不塞 registry）。"""
        stamp = now if now is not None else datetime.now()
        if callable(stamp):
            stamp = stamp()
        self._data[health.site] = {
            "status": health.status,
            "last_probe": stamp.isoformat(timespec="seconds"),
            "reason": health.reason,
        }
        self.save()
        return self._data[health.site]

    def mark(self, site: str, status: str, reason: str, now=None) -> dict:
        """手动/回放标记入口（不依赖 SiteHealth）。"""
        stamp = now if now is not None else datetime.now()
        if callable(stamp):
            stamp = stamp()
        self._data[site] = {"status": status,
                            "last_probe": stamp.isoformat(timespec="seconds"),
                            "reason": reason}
        self.save()
        return self._data[site]

    def dead_sites(self) -> list:
        return sorted(s for s, v in self._data.items() if v.get("status") == STATUS_DEAD)

    def scheduled_sites(self) -> list:
        return sorted(s for s, v in self._data.items() if v.get("status") != STATUS_DEAD)

    def sites(self) -> dict:
        return dict(self._data)

    def __getitem__(self, site: str) -> dict:
        return self._data[site]
