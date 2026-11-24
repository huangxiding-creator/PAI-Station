# -*- coding: utf-8 -*-
"""glaw — global-law 调研渠道接入器 (1124 用户令: 纳入研报产线调研渠道+保持动态联系).

双通道:
  L1 REST  免克隆免key搜索: global-law.lexifina.com/v1/search_law (引擎端实时)
  L2 本地  E:/AI-Station/global-law/repo 的 tools/law.py (log/blame/show/diff/world)
           + 已初始化的辖区子模块逐字原文 (china-law 等, In-force 日期史)

动态联系 (sync): 拉上游新commit + 子模块指针变动报告; 上游高频更新(pushed_at 常当日)。
调研用法 (S1/法规核验):
  - 法条逐字对照: glaw get china/national/acts 民法典 (本地零联网, 免撞限流峰)
  - 涉外调研:     glaw search "general contractor" --jurisdiction vietnam
  - 条文沿革:     glaw log <provision-path> (每一条是谁哪天写进去的)

用法:
  py -X utf8 glaw.py search <query> [--jurisdiction X] [--date YYYY-MM-DD] [--offset N]
  py -X utf8 glaw.py juris [filter]
  py -X utf8 glaw.py log|blame|show|diff|world ...   (转 tools/law.py, 需辖区子模块已 add)
  py -X utf8 glaw.py add <path>                      (初始化辖区子模块, 大库需时)
  py -X utf8 glaw.py sync [--pull]                   (动态联系: 上游体检+可选快进)
"""
from __future__ import annotations

import argparse
import json
import subprocess
import sys
import time
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(r"E:\AI-Station\global-law\repo")
API = "https://global-law.lexifina.com/v1/search_law"


def _rest(query: str, jurisdiction: str, date: str, offset: int) -> dict:
    q = urllib.parse.quote(query)
    url = f"{API}?query={q}&jurisdiction={urllib.parse.quote(jurisdiction)}"
    if date:
        url += f"&date={date}"
    if offset:
        url += f"&offset={offset}"
    with urllib.request.urlopen(url, timeout=30) as r:
        return json.loads(r.read().decode("utf-8"))


def cmd_search(ns) -> int:
    d = _rest(ns.query, ns.jurisdiction, ns.date, ns.offset)
    data = d.get("data", {})
    print(data.get("summary", "(无摘要)"))
    for p in data.get("provisions", []):
        print(" ", p)
    return 0


def cmd_juris(ns) -> int:
    m = json.loads((REPO / "manifest.json").read_text(encoding="utf-8"))
    cs = m if isinstance(m, list) else m.get("corpora", m.get("corpus", []))
    hits = [c for c in cs if ns.filt in c.get("path", "").lower()] if ns.filt else cs
    print(f"{len(hits)} 语料 (共{len(cs)})")
    for c in hits[:60]:
        print(" ", c.get("path", ""), "| history:", c.get("history"))
    if len(hits) > 60:
        print(f"  …其余 {len(hits) - 60} 条")
    return 0


def _law_py(args: list[str]) -> int:
    if not (REPO / "tools" / "law.py").is_file():
        print("[miss] 本地库不存在 — 先 git clone (见 CHANNEL.md)")
        return 1
    r = subprocess.run([sys.executable, "-X", "utf8", str(REPO / "tools" / "law.py"), *args],
                       cwd=str(REPO), capture_output=True, text=True,
                       encoding="utf-8", errors="replace")
    sys.stdout.write(r.stdout or "")
    if r.stderr:
        sys.stderr.write(r.stderr[-500:])
    return r.returncode


def cmd_sync(ns) -> int:
    if not (REPO / ".git").is_file() and not (REPO / ".git").is_dir():
        print("[miss] 本地库不存在")
        return 1
    head0 = subprocess.run(["git", "-C", str(REPO), "rev-parse", "HEAD"],
                           capture_output=True, text=True).stdout.strip()
    r = subprocess.run(["git", "-C", str(REPO), "fetch", "origin", "main", "--depth", "1"],
                       capture_output=True, text=True)
    if r.returncode != 0:
        print("[sync] fetch失败:", (r.stderr or "")[-200:])
        return 1
    head1 = subprocess.run(["git", "-C", str(REPO), "rev-parse", "FETCH_HEAD"],
                           capture_output=True, text=True).stdout.strip()
    print(f"[sync] 本地 {head0[:9]} → 上游 {head1[:9]}")
    if head0 == head1:
        print("[sync] 上游无新commit — 已是最新")
        return 0
    log = subprocess.run(
        ["git", "-C", str(REPO), "log", "--oneline", f"{head0}..{head1}"],
        capture_output=True, text=True, encoding="utf-8", errors="replace").stdout
    print("[sync] 上游新commit:")
    print("\n".join(("  " + ln) for ln in log.strip().splitlines()[:10]))
    # 子模块指针变动 (上游把哪些辖区推到了新版本)
    sub = subprocess.run(
        ["git", "-C", str(REPO), "diff", "--stat", head0, head1, "--", "*"],
        capture_output=True, text=True, encoding="utf-8", errors="replace").stdout
    if sub.strip():
        print("[sync] 子模块指针变动:")
        print("\n".join(("  " + ln) for ln in sub.strip().splitlines()[:20]))
    if ns.pull:
        subprocess.run(["git", "-C", str(REPO), "reset", "--hard", "FETCH_HEAD"],
                       capture_output=True, text=True)
        print("[sync] 已快进到上游 (子模块内容用 add 再拉)")
    else:
        print("[sync] 未快进 — 带 --pull 快进本地库")
    print(f"[sync] 完成时刻 {time.strftime('%Y-%m-%d %H:%M')}")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(prog="glaw")
    sub = ap.add_subparsers(dest="cmd", required=True)

    s = sub.add_parser("search")
    s.add_argument("query")
    s.add_argument("--jurisdiction", default="united-states")
    s.add_argument("--date", default="")
    s.add_argument("--offset", type=int, default=0)

    j = sub.add_parser("juris")
    j.add_argument("filt", nargs="?", default="")

    for name in ("log", "blame", "show", "diff", "world", "add"):
        p = sub.add_parser(name)
        p.add_argument("args", nargs="*")

    y = sub.add_parser("sync")
    y.add_argument("--pull", action="store_true")

    ns = ap.parse_args()
    if ns.cmd == "search":
        return cmd_search(ns)
    if ns.cmd == "juris":
        return cmd_juris(ns)
    if ns.cmd == "sync":
        return cmd_sync(ns)
    return _law_py([ns.cmd, *ns.args])


if __name__ == "__main__":
    raise SystemExit(main())
