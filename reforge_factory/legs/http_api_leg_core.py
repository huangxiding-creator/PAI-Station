# -*- coding: utf-8 -*-
"""http_api_leg_core — A级 HTTP 直调引擎轻量采集腿共用芯 (1025 渠道普查纳管令).

模式 (照 last30days_leg.py: 引擎调用+staging+ingest骨架, 纯HTTP零浏览器):
  各 legs/<engine>_leg.py 定义 SPEC {engine, source, note, endpoint(query, rows),
  extract(data_or_text)} 后调本芯 run():
  ① 直连优先, 网络层失败按序落代理 (7895→7890→7891→7893, 1025 last30days 实测序;
     探活=真实请求非TCP握手);
  ② 命中 → 散文式 md (零编号结果行, 过 S2-1 serp_shape 硬门) + 原始JSON落 staging;
  ③ ammo_pool.py ingest (engine=渠道id 与 channel_matrix SURVEY_ALIASES 同名,
     cred=data) + channel_invocations.jsonl 只增 (api_replica_bridge 台账);
  ④ 零命中/失败如实记录不伪造 (数字零造假铁律); 代理细节写入 note 可审计。

用法(各薄腿): py reforge_factory/legs/<engine>_leg.py --campaign EPC-JIAGE
    --queries "construction cost index" [--rows 8] [--proxy auto|none|http://...]
    [--no-ingest]
"""
from __future__ import annotations

import argparse
import inspect
import json
import os
import re
import subprocess
import sys
import time
import urllib.error
import urllib.parse
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
import api_replica_bridge as arb               # noqa: E402 (台账/寻址共用)

REPO = Path(__file__).resolve().parents[2]          # E:\AI-Station
AMMO_POOL_PY = REPO / "reforge_factory" / "ammo_pool.py"
#: 1025 last30days 实测序: 7895 首选 (实载外网), 7890 次之 (21:47 实测也载)
PROXY_CANDIDATES = ["http://127.0.0.1:7895", "http://127.0.0.1:7890",
                    "http://127.0.0.1:7891", "http://127.0.0.1:7893"]
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) research-leg/1.0 "
      "(AI-Station channel-survey; +stdlib-urllib)")
TIMEOUT = 40


def fetch(url: str, *, params: dict | None = None, headers: dict | None = None,
          method: str = "GET", body: bytes | None = None,
          proxy: str = "auto") -> tuple[int, str, str]:
    """直连优先→代理兜底 → (status, text, used_proxy)。

    网络异常(URLError/超时)或 5xx 视为不通换下家; 4xx 视为已达(站方拒,
    换代理再试一次), 全败返回最后一家结果 (如实记录, 不伪造)。"""
    if params:
        url = url + ("&" if "?" in url else "?") + urllib.parse.urlencode(params)
    attempts = ([None] if proxy in ("none", "") else
                ([None] + PROXY_CANDIDATES) if proxy == "auto" else [proxy])
    last = (0, "", "none")
    hdrs = {"User-Agent": UA, "Accept": "application/json,text/*;q=0.9",
            "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8"}
    hdrs.update(headers or {})
    for p in attempts:
        try:
            if p:
                opener = urllib.request.build_opener(
                    urllib.request.ProxyHandler({"http": p, "https": p}))
            else:
                opener = urllib.request.build_opener(
                    urllib.request.ProxyHandler({}))     # 显式绕过环境代理
            req = urllib.request.Request(url, data=body, headers=hdrs, method=method)
            with opener.open(req, timeout=TIMEOUT) as resp:
                raw = resp.read()
                try:
                    text = raw.decode("utf-8")
                except UnicodeDecodeError:
                    text = raw.decode("utf-8", errors="replace")
                return resp.status, text, (p or "direct")
        except urllib.error.HTTPError as e:
            try:
                text = e.read().decode("utf-8", "replace")[:400]
            except Exception:
                text = ""
            last = (e.code, text, p or "direct")
            if e.code < 500 and p is attempts[-1]:       # 4xx 已是最后一家 → 如实回
                return last
        except (urllib.error.URLError, OSError, ValueError) as e:
            last = (0, f"{type(e).__name__}: {e}"[:300], p or "direct")
    return last


def slugify(q: str) -> str:
    s = re.sub(r"[^0-9A-Za-z]+", "-", q).strip("-").lower()
    return s[:48] or "query"


def _quote(text: str, mark: str = "> ") -> list[str]:
    return [mark + ln if ln.strip() else "" for ln in str(text or "").splitlines()]


def _safe_title(t: str) -> str:
    """标题去前导编号 (防 '### 1. xxx' 触发 S2-1 serp_shape 编号行)。"""
    return re.sub(r"^\s*[\d]+[.、)]\s*", "", str(t or "").strip()) or "(无题)"


def build_md(engine: str, source: str, query: str, hits: list[dict],
             meta: str) -> tuple[str, str]:
    """hits[{title,url,meta[],excerpt}] → 散文式 md (零编号结果行)。返回 (md, 主URL)。"""
    lines = [
        "# %s 检索简报 | %s" % (source, query),
        "",
        "本件为渠道普查纳管 (1025令) 新接入的 %s 渠道一次引擎运行的实测收割面。"
        "内容=命中条目的标题、元信息与摘要/描述摘录 (cred=data, 结构化一手元数据面), "
        "数字均引擎实测零手填。" % source,
        "",
        "- 检索词: " + query,
        "- 引擎: %s (engine=%s) | 采集: %s" % (source, engine, time.strftime("%Y-%m-%d %H:%M")),
        "- 通道: %s" % meta,
        "",
        "---",
        "",
    ]
    primary = ""
    for i, h in enumerate(hits):
        title = _safe_title(h.get("title"))
        lines.append("## %s" % title)
        lines.append("")
        metas = [m for m in (h.get("meta") or []) if m]
        if metas:
            lines.append("*%s*" % " | ".join(str(m) for m in metas))
        url = str(h.get("url") or "").strip()
        if url:
            if not primary:
                primary = url
            lines.append("")
            lines.append("原文: " + url)
        exc = str(h.get("excerpt") or "").strip()
        if exc:
            lines.append("")
            lines.append("**摘要/描述摘录:**")
            lines.extend(_quote(exc[:1500]))
        lines.append("")
    lines += ["---", "", "合计 %d 条命中 (源状态与代理路径如实记录于台账; 零手填)。"
              % len(hits)]
    return "\n".join(lines), primary


def pool_ingest(campaign: str, md: Path, engine: str, url: str) -> tuple[int, int]:
    cmd = ["py", "-X", "utf8", str(AMMO_POOL_PY), "ingest", campaign,
           "--file", str(md), "--engine", engine, "--cred", "research"]
    if url:
        cmd += ["--url", url]
    r = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8",
                       errors="replace", timeout=180)
    out = (r.stdout or "") + (r.stderr or "")
    m = re.search(r"\+待审\s+([\d,]+)字", out)
    chars = int(m.group(1).replace(",", "")) if m else 0
    tail = out.strip().splitlines()[-1] if out.strip() else "(无输出)"
    print("    " + tail)
    return r.returncode, chars


def run(spec: dict, argv: list[str] | None = None) -> int:
    engine, source = spec["engine"], spec["source"]
    # 薄腿件 endpoint/extract 为腿模块级函数 (SPEC 可覆盖 — 供编程式调用)
    caller = inspect.currentframe().f_back
    gl = caller.f_globals if caller else {}
    endpoint_fn = spec.get("endpoint") or gl.get("endpoint")
    extract_fn = spec.get("extract") or gl.get("extract")
    if endpoint_fn is None or extract_fn is None:
        raise RuntimeError("腿件缺 endpoint/extract 函数 (SPEC 或模块级)")
    ap = argparse.ArgumentParser(
        description="%s 渠道腿 (%s→弹药池)" % (engine, source))
    ap.add_argument("--campaign", default="EPC-JIAGE")
    ap.add_argument("--queries", nargs="+", required=True)
    ap.add_argument("--rows", type=int, default=spec.get("rows_default", 8))
    ap.add_argument("--proxy", default="auto")
    ap.add_argument("--no-ingest", action="store_true")
    ns = ap.parse_args(argv)
    print("[leg] engine=%s | 源=%s | proxy=%s" % (engine, source, ns.proxy))

    ts = time.strftime("%Y%m%d_%H%M%S")
    stage = REPO / "ammo_pool" / ns.campaign / "staging" / engine / ts
    stage.mkdir(parents=True, exist_ok=True)

    tot_hits = tot_items = tot_chars = 0
    fails, per_q = [], []
    for q in ns.queries:
        print("[leg] 查询: " + q)
        url, params, headers, method, body = endpoint_fn(q, ns.rows)
        status, text, via = fetch(url, params=params, headers=headers,
                                  method=method, body=body, proxy=ns.proxy)
        if status < 200 or status >= 400 or not text:
            fails.append({"query": q, "status": status,
                          "err": (text or "")[:200], "via": via})
            print("    如实失败: HTTP %s via %s: %s" % (status, via, (text or "")[:120]))
            per_q.append({"query": q, "hits": 0, "ingested": 0, "chars": 0,
                          "status": status})
            continue
        try:
            data = json.loads(text)
        except json.JSONDecodeError:
            data = text
        try:
            hits = extract_fn(data)[:ns.rows]
        except Exception as e:                    # 解析面异常如实记
            fails.append({"query": q, "status": status,
                          "err": "extract失败 %s: %s" % (type(e).__name__, e),
                          "via": via})
            print("    如实失败: extract %s: %s" % (type(e).__name__, e))
            per_q.append({"query": q, "hits": 0, "ingested": 0, "chars": 0,
                          "status": status})
            continue
        tot_hits += len(hits)
        if not hits:
            print("    如实: 零命中 (不伪造)")
            per_q.append({"query": q, "hits": 0, "ingested": 0, "chars": 0,
                          "status": status})
            continue
        md_text, url0 = build_md(engine, source, q, hits,
                                 "HTTP %s via %s | %s" % (status, via, url[:160]))
        slug = slugify(q)
        (stage / (slug + ".json")).write_text(
            data if isinstance(data, str) else json.dumps(
                data, ensure_ascii=False, indent=1), encoding="utf-8")
        md_path = stage / (slug + ".md")
        md_path.write_text(md_text, encoding="utf-8")
        print("    引擎命中 %d 条 -> %s (%d字面, via %s)"
              % (len(hits), md_path.name, len(md_text), via))
        ing = ch = 0
        if not ns.no_ingest and len(md_text) >= 300:
            rc, ch = pool_ingest(ns.campaign, md_path, engine, url0)
            if rc == 0 and ch > 0:
                ing = 1
        elif not ns.no_ingest:
            print("    如实: 面太短 -> 不入池 (数字零造假)")
        tot_items += ing
        tot_chars += ch
        per_q.append({"query": q, "hits": len(hits), "ingested": ing,
                      "chars": ch, "status": status})
        time.sleep(spec.get("sleep", 1.5))   # 1028 P0-3: SPEC 可调节流 (GDELT>=3s)

    if not ns.no_ingest:
        yld = "%d查询%d命中/%d件%s字入池" % (
            len(ns.queries), tot_hits, tot_items, format(tot_chars, ","))
        if fails:
            yld += " | 失败%d: %s" % (len(fails), json.dumps(
                [{"q": f["query"], "status": f["status"]} for f in fails],
                ensure_ascii=False))
        arb.append_invocation(
            engine, "http_api_leg:%s (纯HTTP零浏览器, stdlib-urllib)" % source,
            "; ".join(ns.queries), yld,
            note="1025 渠道普查纳管令 A级接入 (channels_survey_2026/MASTER_REGISTRY); "
                 + spec.get("note", "") + "; proxy=%s" % ns.proxy,
            campaign=ns.campaign)
    print(json.dumps({"campaign": ns.campaign, "engine": engine,
                      "queries": len(ns.queries), "hits": tot_hits,
                      "ingested": tot_items, "chars": tot_chars,
                      "fails": fails, "staging": str(stage), "per_query": per_q},
                     ensure_ascii=False, indent=1))
    return 0
