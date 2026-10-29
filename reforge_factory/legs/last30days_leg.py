# -*- coding: utf-8 -*-
"""last30days 腿 — 近30日多源社媒热度渠道接入弹药池 (1025 用户令: 接入
mvanhorn/last30days-skill 到研报调研搜集渠道; 引擎已克隆 vendors/last30days-skill).

渠道定位: 近30日真实人群信号/热度面 (零配置四源 reddit/hackernews/polymarket/
github 公共API免key; X/YouTube/TikTok 等需密钥源不配 — 如实记录, --diagnose 体检).
引擎: vendors/last30days-skill/skills/last30days/scripts/last30days.py (v3.30.0,
纯 Python 3.12+ 标准库零依赖; 专用 venv=vendors/last30days-skill/.venv py3.13;
纯HTTP零浏览器 — API优先令同构, 登录类源一律不跑).

1025 实测装定 (区别于初版冒烟件):
  - 深度档: 默认档不用 --quick (quick 档按 intent 截每子查询源数, 四源会丢
    github/polymarket — planner._trim_subqueries_for_depth 实证);
  - 代理: 候选按实测外网可达性排序, 7895 首选 (7890/7891/7893 TCP 在听但
    不载外网 HTTPS, 7892 未开 — 探活用真实 GET 请求非 TCP 握手);
  - Reddit: 本机全出口被拒 (直连000/7895出口403), 引擎如实 auth-failed,
    台账/note 记录, 不伪造命中;
  - md 形态: 散文式 (无编号结果行) — S2-1 snippet 硬门 serp_shape 规则
    (前4000字 ≥3 编号行 ∧ ≥3 URL) 拒编号清单面, 初版冒烟件实证被拒.

产出: ammo_pool/<campaign>/staging/last30days/<ts>/<slug>.md (+.json 原始面)
入池: engine=last30days cred=media; 台账 channel_invocations.jsonl 只增.
用法: py reforge_factory/legs/last30days_leg.py --campaign EPC-JIAGE
      --queries "construction cost estimation" "engineering cost index"
      [--search reddit,hackernews,polymarket,github] [--days 30]
      [--proxy auto|none|http://127.0.0.1:7895] [--max-per-source 5] [--no-ingest]
"""
from __future__ import annotations

import argparse
import http.client
import json
import os
import re
import socket
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
import api_replica_bridge as arb               # noqa: E402 (1025 CLI引擎登记)

REPO = Path(__file__).resolve().parents[2]          # E:\AI-Station
DEFAULT_SKILL_DIR = REPO / "vendors" / "last30days-skill" / "skills" / "last30days"
AMMO_POOL_PY = REPO / "reforge_factory" / "ammo_pool.py"
ENGINE = "last30days"
#: 候选序=1025实测外网可达性: 7895 实载 polymarket/github/algolia (200);
#: 7890/7891/7893 在听但不载 (000); 7892 未开。探测=真实 GET 非TCP握手。
PROXY_CANDIDATES = ["127.0.0.1:7895", "127.0.0.1:7890", "127.0.0.1:7891",
                    "127.0.0.1:7892"]
PROXY_PROBE_HOST = "gamma-api.polymarket.com"       # 零配置源真端点, 探活即体检
PROXY_PROBE_PATH = "/markets?limit=1"


def resolve_python() -> str:
    """引擎解释器: CLI_ENGINES 登记 venv 优先 (py3.13 专用) > env > py 启动器。"""
    ent = arb.CLI_ENGINES.get(ENGINE, {})
    venv_py = ent.get("python")
    if venv_py and Path(venv_py).is_file():
        return str(venv_py)
    if os.environ.get("LAST30DAYS_PYTHON"):
        return os.environ["LAST30DAYS_PYTHON"]
    for c in ["py", "python3.13", "python3.12", "python"]:
        try:
            r = subprocess.run([c, "-c",
                "import sys; raise SystemExit(0 if sys.version_info>=(3,12) else 1)"],
                capture_output=True, timeout=30)
            if r.returncode == 0:
                return c
        except (OSError, subprocess.TimeoutExpired):
            continue
    raise SystemExit("[leg] 未找到 Python>=3.12 (引擎硬门), 可设 LAST30DAYS_PYTHON")


def _probe_proxy(hostport: str, timeout: float = 4.0) -> bool:
    """真实 HTTP 探活: 经代理 GET polymarket 端点, 2xx/3xx/403/404 皆算载流
    (403/404=单站拒或路径异, 代理本身通)。超时/5xx/连接拒=不载。"""
    host, _, port = hostport.partition(":")
    try:
        conn = http.client.HTTPConnection(host, int(port), timeout=timeout)
        conn.request("GET", f"http://{PROXY_PROBE_HOST}{PROXY_PROBE_PATH}",
                     headers={"Host": PROXY_PROBE_HOST,
                              "User-Agent": "last30days-leg-probe/1.0"})
        resp = conn.getresponse()
        ok = resp.status < 500
        resp.read()
        conn.close()
        return ok
    except (OSError, ValueError):
        return False


def resolve_proxy(spec: str):
    if spec in ("none", ""):
        return None
    if spec != "auto":
        return spec
    for hp in PROXY_CANDIDATES:
        host, _, port = hp.partition(":")
        try:
            with socket.create_connection((host, int(port)), timeout=0.4):
                pass
        except OSError:
            continue
        if _probe_proxy(hp):
            return "http://" + hp
    return None


def run_engine(python: str, skill_dir: Path, query: str, sources: str,
               days: int, proxy, max_per_source: int):
    """跑引擎 (默认档, 宿主免规划通道) → 原始 JSON dict; 失败返回 None。
    默认档 (非quick) 会把请求源展开进每个子查询 — 四源全覆盖实证。"""
    script = skill_dir / "scripts" / "last30days.py"
    env = dict(os.environ)
    env["LAST30DAYS_ALLOW_ENGINE_PLAN"] = "1"   # 无人值守合法通道 (引擎自规划)
    env["NO_PROXY"] = "localhost,127.0.0.1"
    env["NO_COLOR"] = "1"
    env["PYTHONIOENCODING"] = "utf-8"
    if proxy:
        env["HTTP_PROXY"] = proxy
        env["HTTPS_PROXY"] = proxy
    cmd = [python, "-X", "utf8", str(script), query,
           "--search", sources, "--emit", "json", "--json-profile", "raw",
           "--days", str(days), "--max-per-source", str(max_per_source),
           "--no-browser-cookies"]
    r = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8",
                       errors="replace", env=env, timeout=420, cwd=str(skill_dir))
    out = (r.stdout or "") + (r.stderr or "")
    idx = out.find("{")
    while idx >= 0:                              # 找 raw 报告 JSON 对象
        try:
            data, _ = json.JSONDecoder().raw_decode(out, idx)
        except json.JSONDecodeError:
            idx = out.find("{", idx + 1)
            continue
        if "items_by_source" in data or "source_status" in data:
            return data
        idx = out.find("{", idx + 1)
    print("[leg] 引擎零JSON面 (rc=%s): %s" % (r.returncode, out[:300]))
    return None


def slugify(q: str) -> str:
    s = re.sub(r"[^0-9A-Za-z]+", "-", q).strip("-").lower()
    return s[:48] or "query"


def _quote(text: str, mark: str = "> ") -> list[str]:
    """散文引述行 (逐行前缀 — 兼防 SERP 编号行误判, 全文保真)。"""
    return [mark + ln if ln.strip() else "" for ln in str(text or "").splitlines()]


def build_md(query: str, data: dict, sources: str, days: int) -> tuple[str, str]:
    """原始 items_by_source → 散文式热度简报 md (过 S2-1 硬门: 零编号结果行,
    正文=引擎实测 body/评论摘录, 数字全引擎原值零手填)。返回 (md, 主URL)。"""
    ss = data.get("source_status") or {}
    by_src = data.get("items_by_source") or {}
    rng = "%s~%s" % (data.get("range_from", "?"), data.get("range_to", "?"))
    health = ", ".join(
        "%s=%s%s" % (s, o.get("state"),
                     "(%s)" % str(o.get("detail"))[:60] if o.get("detail") else "")
        for s, o in sorted(ss.items())) or "(引擎未报)"
    lines = [
        "# 近30日社媒热度简报 | " + query,
        "",
        "本件为 last30days 渠道 (v3.30.0, 零配置公共API: Reddit/HackerNews/"
        "Polymarket/GitHub) 一次引擎运行的实测收割面。内容=命中帖文的标题、"
        "互动计数与正文/高赞评论摘录, 反映近30日英文技术社区对该主题的真实"
        "讨论热度与观点样本 (cred=media, 热度信号面)。",
        "",
        "- 检索词: " + query,
        "- 源: %s | 窗口: %d天 (%s) | 采集: %s" % (
            sources, days, rng, time.strftime("%Y-%m-%d %H:%M")),
        "- 源健康: " + health,
        "",
        "---",
        "",
    ]
    primary_url = ""
    n = 0
    for src in sorted(by_src):
        items = by_src.get(src) or []
        if not items:
            continue
        lines.append("## %s 命中 (%d 条)" % (src, len(items)))
        lines.append("")
        for it in items:
            n += 1
            url = it.get("url") or str(it.get("item_id") or "")
            if not primary_url and url:
                primary_url = url
            eng = it.get("engagement") or {}
            meta = it.get("metadata") or {}
            lines.append("### %s" % ((it.get("title") or "(无题)").strip()))
            desc = []
            if it.get("author"):
                desc.append("作者 %s" % it["author"])
            if it.get("published_at"):
                desc.append("发布 %s" % it["published_at"])
            pts = eng.get("points") or eng.get("upvotes")
            cms = eng.get("comments")
            if pts is not None or cms is not None:
                desc.append("互动 %s分/%s评" % (pts if pts is not None else "-",
                                               cms if cms is not None else "-"))
            if it.get("engagement_score") is not None:
                desc.append("热度分 %s" % it["engagement_score"])
            if it.get("source_quality") is not None:
                desc.append("源质 %s" % it["source_quality"])
            if desc:
                lines.append("*%s*" % " | ".join(desc))
            if url:
                lines.append("")
                lines.append("原文: %s" % url)
            body = (it.get("body") or it.get("snippet") or "").strip()
            if body:
                lines.append("")
                lines.append("**正文/摘要摘录:**")
                lines.extend(_quote(body[:2000]))
            top = meta.get("top_comments") or []
            if top:
                lines.append("")
                lines.append("**高赞评论摘录 (前%d条):**" % min(3, len(top)))
                for c in top[:3]:
                    ex = (c.get("excerpt") or "").strip()
                    if not ex:
                        continue
                    lines.append("")
                    lines.append("> — %s:" % (c.get("author") or "匿名"))
                    lines.extend(_quote(ex[:900]))
            lines.append("")
    lines.append("---")
    lines.append("")
    lines.append("合计 %d 条命中 (源状态如实记录于上; 数字均引擎实测, 零手填)。" % n)
    return "\n".join(lines), primary_url


def pool_ingest(python: str, campaign: str, md: Path, url: str):
    cmd = [python, "-X", "utf8", str(AMMO_POOL_PY), "ingest", campaign,
           "--file", str(md), "--engine", ENGINE, "--cred", "media"]
    if url:
        cmd += ["--url", url]
    r = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8",
                       errors="replace", timeout=120)
    out = (r.stdout or "") + (r.stderr or "")
    m = re.search(r"\+待审\s+([\d,]+)字", out)
    chars = int(m.group(1).replace(",", "")) if m else 0
    tail = out.strip().splitlines()[-1] if out.strip() else "(无输出)"
    print("    " + tail)
    return r.returncode, chars


def main():
    ap = argparse.ArgumentParser(description="last30days 渠道腿 (近30日社媒热度→弹药池)")
    ap.add_argument("--campaign", default="EPC-JIAGE")
    ap.add_argument("--queries", nargs="+", required=True)
    ap.add_argument("--search", default="reddit,hackernews,polymarket,github")
    ap.add_argument("--days", type=int, default=30)
    ap.add_argument("--max-per-source", type=int, default=5)
    ap.add_argument("--proxy", default="auto")
    ap.add_argument("--no-ingest", action="store_true")
    ap.add_argument("--skill-dir", default=os.environ.get(
        "LAST30DAYS_SKILL_DIR", str(DEFAULT_SKILL_DIR)))
    ns = ap.parse_args()

    skill_dir = Path(ns.skill_dir)
    if not (skill_dir / "scripts" / "last30days.py").is_file():
        raise SystemExit("[leg] 引擎缺失: %s" % skill_dir)
    python = resolve_python()
    proxy = resolve_proxy(ns.proxy)
    print("[leg] python=%s | 引擎=%s | proxy=%s" % (
        python, skill_dir, proxy or "无(直连)"))

    ts = time.strftime("%Y%m%d_%H%M%S")
    stage = REPO / "ammo_pool" / ns.campaign / "staging" / ENGINE / ts
    stage.mkdir(parents=True, exist_ok=True)

    tot_items, tot_chars, tot_hits = 0, 0, 0
    per_q, health_acc = [], {}
    for q in ns.queries:
        print("[leg] 查询: " + q)
        data = run_engine(python, skill_dir, q, ns.search, ns.days, proxy,
                          ns.max_per_source)
        if not data:
            per_q.append({"query": q, "hits": 0, "ingested": 0, "chars": 0})
            continue
        for s, o in (data.get("source_status") or {}).items():
            health_acc.setdefault(s, set()).add(str(o.get("state")))
        md_text, url = build_md(q, data, ns.search, ns.days)
        slug = slugify(q)
        (stage / (slug + ".json")).write_text(
            json.dumps(data, ensure_ascii=False, indent=1), encoding="utf-8")
        md_path = stage / (slug + ".md")
        md_path.write_text(md_text, encoding="utf-8")
        n_hits = sum(len(v) for v in (data.get("items_by_source") or {}).values())
        tot_hits += n_hits
        print("    引擎命中 %d 条 -> %s (%d字面)" % (n_hits, md_path.name, len(md_text)))
        ing, ch = 0, 0
        if not ns.no_ingest and n_hits > 0 and len(md_text) >= 300:
            rc, ch = pool_ingest(python, ns.campaign, md_path, url)
            if rc == 0 and ch > 0:
                ing = 1
        elif not ns.no_ingest:
            print("    如实: 零结果/面太短 -> 不入池 (数字零造假)")
        tot_items += ing
        tot_chars += ch
        per_q.append({"query": q, "hits": n_hits, "ingested": ing, "chars": ch})
        time.sleep(2)                            # 引擎内部有节流, 腿间再让一拍

    health = {s: "+".join(sorted(v)) for s, v in health_acc.items()}
    if not ns.no_ingest:
        arb.append_invocation(
            ENGINE, "last30days_engine:v3.30.0 (默认档/raw JSON, 纯HTTP零浏览器)",
            "; ".join(ns.queries),
            "%d查询%d命中/%d件%d字入池 | 源状态: %s | proxy=%s" % (
                len(ns.queries), tot_hits, tot_items, tot_chars,
                json.dumps(health, ensure_ascii=False), proxy or "直连"),
            note="1025 用户令接入 mvanhorn/last30days-skill (vendors引擎+专用venv "
                 "py3.13零依赖); 免密四源=%s; Reddit本机全出口被拒(直连000/7895出"
                 "口403)=引擎如实auth-failed非伪命中" % ns.search,
            campaign=ns.campaign)
    print(json.dumps({"campaign": ns.campaign, "engine": ENGINE,
                      "queries": len(ns.queries), "hits": tot_hits,
                      "ingested": tot_items, "chars": tot_chars,
                      "source_health": health,
                      "staging": str(stage), "per_query": per_q},
                     ensure_ascii=False, indent=1))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
