# -*- coding: utf-8 -*-
"""PAN-HUNTER L1 源中枢执行器（W0 · 2026-10-30）

铁律落地（任务书 2026-10-30）：
  单源并发=1（源内关键词串行）｜同源请求间隔≥2s 随机抖动｜全源并发≤4｜代理仅重试路径用完即关。

判定分类学（verdict，审计与 doctor 共用词表）：
  LIVE_JSON   200 + JSON 解析成功且命中>0（关键词可入参的真活源）
  LIVE_HTML   200 + HTML 内盘链命中>0
  LIVE_SSE    200 + SSE data 行命中>0
  ALIVE_EMPTY 200 且解析成功但命中=0（源活，该词无货）
  ALIVE_SHELL 200 SPA 壳（首响应无数据，需 JS/API 二次取数——引擎级不算活）
  CF_CHALLENGE 403/质询页（Cloudflare 托管质询，TLS 指纹免疫，需浏览器栈）
  WALL_PROXY  直连网络层失败 + 代理重试成功（站活，直连被墙）
  ANTICRAWL   5xx/567 自定义反爬码或 SSE 风控消息
  DEAD        4xx/5xx/DNS 失败/代理重试仍网络层失败

HTTP 层定案（本日实测，analysis/SOURCE_AUDIT_1030.md §2）：
  curl_cffi impersonate=chrome124 直连可过 requests 直连超时/重置的源（指纹墙）；
  代理可解路径墙；CF 托管质询三层（指纹/路径/浏览器栈）需 DrissionPage（W1+）。
"""
from __future__ import annotations

import base64
import json
import random
import re
import sys
import threading
import time
from concurrent.futures import ThreadPoolExecutor
from dataclasses import dataclass, field, asdict

sys.stdout.reconfigure(encoding="utf-8")

# --- 频控三律常量（铁律数值，不得放宽）---
MAX_GLOBAL_CONCURRENCY = 4
PER_SOURCE_INTERVAL_S = (2.0, 3.5)   # 同源相邻请求间隔（≥2s + 随机抖动）
REQUEST_TIMEOUT_S = 12
PROXY = "http://127.0.0.1:7892"
PROXIES = {"http": PROXY, "https": PROXY}
IMPERSONATE = "chrome124"
BUDGET_TOTAL = 600                    # 本日对外请求总额硬顶

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36")

PAN_LINK_RE = re.compile(
    r"(?:pan\.baidu\.com/s/|alipan\.com/s/|aliyundrive\.com/s/|pan\.quark\.cn/s/|"
    r"123pan\.com/s/|115\.com/s/|cloud\.189\.cn/t/|mypikpak\.com/s/|xunlei\.com/s/|"
    r"caiyun\.139\.com|drive\.uc\.cn/s/|magnet:\?xt=|ed2k://)", re.I)
NAME_KEYS = ("name", "title", "file_name", "filename", "fileType", "content")
CF_MARKERS = ("cf-browser-verification", "challenge-platform", "Just a moment",
              "Attention Required", "oldie", "__cf_chl", "cf_chl_")

_request_count = 0
_count_lock = threading.Lock()


def spent() -> int:
    with _count_lock:
        return _request_count


def _tick(n: int = 1) -> bool:
    """预算门：超 600 发硬拒（返回 False）。"""
    global _request_count
    with _count_lock:
        if _request_count + n > BUDGET_TOTAL:
            return False
        _request_count += n
        return True


@dataclass
class ProbeResult:
    """单源×单关键词审计记录（JSONL 台账行）。"""
    source: str
    keyword: str
    verdict: str
    http_status: int = 0
    hits: int = 0
    elapsed_s: float = 0.0
    path: str = "direct"            # direct / proxy_retry
    evidence: str = ""
    ts: str = field(default_factory=lambda: time.strftime("%H:%M:%S"))


LINK_KEYS = ("url", "link", "share_url", "res_url", "pan_url", "url_short", "url_link")


def _count_json_hits(node) -> int:
    """泛型 JSON 命中计数：walk 全树，数「盘链对象（链接字段直计）或 名字段+链接值对象」。

    命中单元=一条分享（naspt links[].url 对象、melost list[] 的 link 字段均计入）。
    """
    n = 0
    if isinstance(node, dict):
        linkish = any(isinstance(v, str) and (v.startswith(("http", "magnet", "ed2k")) or "pan." in v)
                      for k, v in node.items() if k in LINK_KEYS)
        has_name = any(k in NAME_KEYS or k.endswith("name") or k.endswith("title")
                       for k in node)
        has_url_val = any(isinstance(v, str) and ("http" in v or v.startswith("magnet"))
                          for v in node.values())
        if linkish or (has_name and has_url_val):
            n += 1
        for v in node.values():
            n += _count_json_hits(v)
    elif isinstance(node, list):
        for v in node:
            n += _count_json_hits(v)
    return n


def _classify(kind: str, status: int, body: str, ct: str) -> tuple[str, int, str]:
    """响应 → (verdict, hits, evidence)。数字零造假：hits 全实测计数。"""
    if status == 403 or any(m in body[:4000] for m in CF_MARKERS):
        return "CF_CHALLENGE", 0, f"status={status} ct={ct[:30]}"
    if status == 404:
        return "DEAD", 0, "404（站转型/路径失效）"
    if status >= 400:
        return ("ANTICRAWL" if status in (567, 429) else "DEAD"), 0, f"status={status}"

    if kind == "tg":
        blocks = re.findall(r'tgme_widget_message_text[^>]*>(.*?)</div>', body, re.S)
        hits = sum(1 for b in blocks if PAN_LINK_RE.search(b))
        return ("LIVE_HTML", hits, f"msg_blocks={len(blocks)}") if hits else ("ALIVE_EMPTY", 0, f"msg_blocks={len(blocks)}")

    if kind == "base64":
        try:
            data = json.loads(base64.b64decode(body.strip()))
            hits = _count_json_hits(data)
            return ("LIVE_JSON", hits, "base64→JSON") if hits else ("ALIVE_EMPTY", 0, "base64→JSON 0命中")
        except Exception as e:
            return "DEAD", 0, f"base64 解码失败 {type(e).__name__}"

    if "json" in ct or body.lstrip()[:1] in "[{":
        try:
            data = json.loads(body)
            hits = _count_json_hits(data)
            if hits == 0:  # JSON 内嵌 HTML/纯文本链接兜底（yunso 型：data=HTML 字符串）
                hits = len(set(PAN_LINK_RE.findall(body)))
            return ("LIVE_JSON", hits, "JSON") if hits else ("ALIVE_EMPTY", 0, "JSON 0命中")
        except Exception:
            pass  # 非 JSON 落到 HTML 判定
    if "text/event-stream" in ct or kind == "sse":
        lines = [l[5:] for l in body.splitlines() if l.startswith("data:")]
        hits = sum(1 for l in lines if PAN_LINK_RE.search(l) or '"name"' in l or '"title"' in l)
        if any("验证" in l or "安全" in l for l in lines) and hits == 0:
            return "ANTICRAWL", 0, f"sse_lines={len(lines)} 风控消息"
        return ("LIVE_SSE", hits, f"sse_lines={len(lines)}") if hits else ("ALIVE_SHELL", 0, f"sse_lines={len(lines)} 0命中")
    # HTML
    links = set(PAN_LINK_RE.findall(body))
    hits = len(links)
    if hits:
        return "LIVE_HTML", hits, f"盘链去重={hits}"
    if re.search(r'id="root"|id="app"|__NUXT__|__NEXT_DATA__', body) and len(body) < 400000:
        return "ALIVE_SHELL", 0, "SPA 壳无首屏数据"
    return "ALIVE_EMPTY", 0, "HTML 0 命中"


def _fetch(method, url, headers, jb, fb, proxies):
    """单发（curl_cffi impersonate）。网络层异常抛出，HTTP 层返回 (status, body, ct)。"""
    from curl_cffi import requests as creq
    h = {"User-Agent": UA, "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8"}
    h.update(headers)
    kw = dict(headers=h, timeout=REQUEST_TIMEOUT_S, impersonate=IMPERSONATE)
    if proxies:
        kw["proxies"] = proxies
    if method == "POST":
        if jb is not None:
            kw["json"] = jb
        elif fb is not None:
            kw["data"] = fb
    r = (creq.post(url, **kw) if method == "POST" else creq.get(url, **kw))
    return r.status_code, r.text, r.headers.get("content-type", "")


def probe_keyword(recipe, kw: str) -> ProbeResult:
    """直连一发 → 网络层失败则 2s 后代理重试一发（代理即用即弃）。"""
    from recipes import build_request
    method, url, headers, jb, fb = build_request(recipe, kw)

    # signflow 源：先取首页抓 sign，再打搜索（关键词不入参，命中=流内盘链）
    if recipe["kind"] == "signflow":
        return _probe_signflow(recipe, kw)

    for path in ("direct", "proxy_retry"):
        if not _tick():
            return ProbeResult(recipe["name"], kw, "BUDGET_EXHAUSTED", evidence="600 发硬顶")
        try:
            t0 = time.time()
            status, body, ct = _fetch(method, url, headers, jb, fb,
                                      PROXIES if path == "proxy_retry" else None)
            v, hits, ev = _classify(recipe["kind"], status, body, ct)
            return ProbeResult(recipe["name"], kw, v, status, hits,
                               round(time.time() - t0, 1), path, ev)
        except Exception as e:
            if path == "direct":
                time.sleep(2)   # 重试前保同源间隔
                continue
            return ProbeResult(recipe["name"], kw, "DEAD", 0, 0, 0, path,
                               f"直连+代理均网络层失败: {type(e).__name__}: {str(e)[:60]}")
    return ProbeResult(recipe["name"], kw, "DEAD", evidence="unreachable")


_SIGN_RE = re.compile(r'"sign":"([^"]+)"')


def _probe_signflow(recipe, kw: str) -> ProbeResult:
    """panyq 形态：GET 首页 → 正则抓 sign → GET /api/search?sign&page=1。"""
    try:
        if not _tick():
            return ProbeResult(recipe["name"], kw, "BUDGET_EXHAUSTED")
        t0 = time.time()
        status, body, ct = _fetch("GET", recipe["url"], {}, None, None, None)
        m = _SIGN_RE.search(body)
        if not m:
            return ProbeResult(recipe["name"], kw, "ALIVE_SHELL" if status == 200 else "DEAD",
                               status, 0, round(time.time() - t0, 1), "direct",
                               f"首页{status}但未抓到sign（模板变）")
        time.sleep(2)
        if not _tick():
            return ProbeResult(recipe["name"], kw, "BUDGET_EXHAUSTED")
        status2, body2, ct2 = _fetch("GET", f"https://panyq.com/api/search?sign={m.group(1)}&page=1",
                                     {"Referer": "https://panyq.com"}, None, None, None)
        v, hits, ev = _classify("json", status2, body2, ct2)
        return ProbeResult(recipe["name"], kw, v, status2, hits, round(time.time() - t0, 1),
                           "direct", f"sign门票OK; {ev}")
    except Exception as e:
        return ProbeResult(recipe["name"], kw, "DEAD", evidence=f"{type(e).__name__}: {str(e)[:60]}")


def run_source(recipe, keywords) -> list[ProbeResult]:
    """单源串行跑全部关键词（间隔≥2s 抖动）。"""
    out = []
    kws = keywords if recipe["kw_mode"] == "all" else keywords[:1]
    for i, kw in enumerate(kws):
        if i:
            time.sleep(random.uniform(*PER_SOURCE_INTERVAL_S))
        out.append(probe_keyword(recipe, kw))
    return out


def run_audit(recipes, keywords, jsonl_path: str) -> list[ProbeResult]:
    """全源审计：并发≤4（铁律），结果追加落 JSONL。"""
    results: list[ProbeResult] = []
    lock = threading.Lock()
    with open(jsonl_path, "a", encoding="utf-8") as sink, \
         ThreadPoolExecutor(max_workers=MAX_GLOBAL_CONCURRENCY) as pool:
        def _job(rc):
            rows = run_source(rc, keywords)
            with lock:
                for row in rows:
                    sink.write(json.dumps(asdict(row), ensure_ascii=False) + "\n")
                sink.flush()
                results.extend(rows)
                live = sum(1 for r in rows if r.verdict.startswith("LIVE"))
                print(f"[{rc['name']:14s}] " + " | ".join(
                    f"{r.keyword[:6]}:{r.verdict}({r.hits})" for r in rows)
                      + (f"  *{live}LIVE*" if live else ""), flush=True)
            return rows
        list(pool.map(_job, recipes))
    return results
