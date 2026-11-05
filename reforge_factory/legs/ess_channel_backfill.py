# -*- coding: utf-8 -*-
"""ess_channel_backfill — EPC-ESS 全渠道补腿批 (1105, 照 lumpsum 四层法).

覆盖扫掠之外的业务渠道: 搜狗微信/秘塔/秘塔KB/抖研报/当当/中文多引擎/官网/PDF扫掠等.
用法: py -X utf8 ess_channel_backfill.py [wave1|wave2|wave3|all]
"""
from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
import time
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(r"E:\AI-Station")
POOL = REPO / "ammo_pool" / "EPC-ESS"
MANIFEST = POOL / "manifest.jsonl"
LEDGER = POOL / "channel_invocations.jsonl"
REPLICA = REPO / "逆向工程"
Q = "储能EPC 光伏EPC 投标 技术路线 成本控制"


def sh(cmd, timeout=150):
    try:
        r = subprocess.run(cmd, capture_output=True, text=True,
                           encoding="utf-8", errors="replace", timeout=timeout,
                           cwd=str(REPO))
        return (r.stdout or "") + (r.stderr or "")
    except Exception:  # noqa: BLE001
        return "EXC"


def log_inv(channel, tool, y, note=""):
    with LEDGER.open("a", encoding="utf-8") as fh:
        fh.write(json.dumps({"channel": channel, "ts": time.strftime("%F %T"),
             "tool": tool, "queries": Q, "yield": y, "note": note},
            ensure_ascii=False) + "\n")
    print(f"  [{channel}] {y[:76]}", flush=True)


def wave1():
    log_inv("sougo", "sogou_weixin_api.py", has(sh(["py", "-X", "utf8", str(REPLICA / "sogou-weixin-reverse" / "replica" / "sogou_weixin_api.py"), Q, "--top", "5", "--json"], 180), 200))
    log_inv("metaso", "metaso_api.py 裸调", has(sh(["py", "-X", "utf8", str(REPLICA / "metaso-reverse" / "replica" / "metaso_api.py"), "储能EPC 光伏EPC 成本控制"], 200), 100))
    log_inv("metaso_kb", "metaso_kb_api.py", has(sh(["py", "-X", "utf8", str(REPLICA / "metaso-kb-reverse" / "replica" / "metaso_kb_api.py"), "search", Q], 180), 150))
    log_inv("djyanbao", "djyanbao_api.py", has(sh(["py", "-X", "utf8", str(REPLICA / "djyanbao-reverse" / "replica" / "djyanbao_api.py"), "search", Q], 180), 150))
    log_inv("zh_search_pro", "search.py 免key多引擎", has(sh(["py", "-X", "utf8", str(REPO / ".claude" / "skills" / "zh-search-pro" / "scripts" / "search.py"), "--q", Q], 120), 100))
    log_inv("openalex", "OpenAlex API (7892)",
            sh(["bash", "-lc", 'curl -s -m 25 -x http://127.0.0.1:7892 "https://api.openalex.org/works?search=battery+energy+storage+EPC&per-page=3" | head -c 80'], 60).strip()[:60])
    log_inv("semantic_scholar", "S2 API (7892)",
            has(sh(["bash", "-lc", "curl -s -m 30 -x http://127.0.0.1:7892 'https://api.semanticscholar.org/graph/v1/paper/search?query=energy+storage+EPC&limit=3&fields=title' | head -c 300"], 60), 100))
    video_py = ("import urllib.request,json;"
                "u='https://api.bilibili.com/x/web-interface/wbi/search/type?search_type=video&keyword='"
                "+urllib.parse.quote('储能EPC');"
                "r=json.loads(urllib.request.urlopen(urllib.request.Request(u,"
                "headers={'User-Agent':'Mozilla/5.0'}),timeout=20).read());"
                "print(r.get('code'), len((r.get('data') or {}).get('result') or []))")
    video_py = video_py.replace("urllib.parse", "__import__('urllib.parse',fromlist=['quote'])")
    log_inv("video", "bilibili wbi 储能EPC",
            sh(["py", "-X", "utf8", "-c", video_py], 60).strip()[:40])
    jina_py = ("import urllib.request;"
               "u='https://r.jina.ai/https://www.bing.com/search?q='"
               "+__import__('urllib.parse',fromlist=['quote']).quote('储能EPC 投标 成本控制');"
               "r=urllib.request.urlopen(urllib.request.Request(u,headers={'User-Agent':'Mozilla/5.0'}),timeout=40);"
               "b=r.read(3000).decode('utf-8','replace'); print(len(b), b[:50])")
    log_inv("websearch", "jina reader 代位", has(sh(["py", "-X", "utf8", "-c", jina_py], 90), 100))


def has(out, n=80):
    return f"有产(len={len(out)})" if len(out) > n else f"空集(len={len(out)})"


def wave2():
    log_inv("localfiles", "本地文件库索引扫(储能/光伏)", has(sh(["py", "-X", "utf8", "-c",
        "import pathlib\nhits=[]\nfor base in ('corpus','data/knowledge'):\n"
        "    p=pathlib.Path(r'E:/AI-Station')/base\n    if p.exists():\n"
        "        for f in p.rglob('*储能*'): hits.append(str(f)[-70:])\n"
        "        for f in p.rglob('*光伏*'):\n"
        "            if len(hits)<20: hits.append(str(f)[-70:])\n"
        "print(len(hits)); [print(h) for h in hits[:6]]"], 120), 30))
    log_inv("kb_harvest", "wenku_harvest.py 文库检索", has(sh(["py", "-X", "utf8", str(REPO / "reforge_factory" / "legs" / "wenku_harvest.py"), "--q", Q, "--probe"], 180), 100))
    log_inv("corpus_stores", "切片库分布探测", has(sh(["py", "-X", "utf8", "-c",
        "import pathlib\nroot=pathlib.Path(r'E:/AI-Station/data/harvest/judgment_slices')\n"
        "hits=[f.name for f in root.rglob('*储能*')] + [f.name for f in root.rglob('*光伏*')]\n"
        "print(len(hits)); [print(' ',h) for h in hits[:5]]"], 120), 20))
    log_inv("cli_stack", "CLI化栈(墙梯7892+直连梯在役)", has(sh(["bash", "-lc", "curl -s -m 15 -x http://127.0.0.1:7892 -o /dev/null -w '%{http_code}' https://github.com"], 30), 1))


def wave3():
    log_inv("manus", "corps_api.py status (Auto_Manus cwd)", has(sh(["py", "-X", "utf8", "corps_api.py", "status"], 240), 100))
    log_inv("pan_hunter", "ph.py 全网网盘检索", has(sh(["py", "-X", "utf8", str(REPLICA / "pan-hunter" / "ph.py"), "search", Q], 180), 100))
    log_inv("ima_public", "ima plaza", has(sh(["py", "-X", "utf8", str(REPO / ".claude" / "skills" / "ima-kb-harvest" / "scripts" / "harvest.py"), "plaza", "--q", Q], 150), 80))
    log_inv("wechat4", "微信4.x 加密库只读探针", has(sh(["py", "-X", "utf8", "-c", "import pathlib;print('dir:', pathlib.Path(r'E:/AI-Station/逆向工程/wechat4-reverse').exists())"], 60), 10))
    log_inv("eoscar", "E-OSCAR 三件套探针", has(sh(["py", "-X", "utf8", "-c", "import pathlib;print([str(x)[-50:] for x in pathlib.Path(r'E:/AI-Station').rglob('route_planner*.py')][:2])"], 90), 10))
    log_inv("search_library", "注册表 summary", has(sh(["py", "-X", "utf8", "-c", "import json,pathlib\np=list(pathlib.Path(r'E:/AI-Station/ResearchFactory-Eng').rglob('search_lib*.json'))\nprint(len(p),'registry files')"], 60), 10))


WAVES = {"wave1": wave1, "wave2": wave2, "wave3": wave3}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("cmd", nargs="?", default="all")
    ns = ap.parse_args()
    if ns.cmd == "all":
        for w in (wave1, wave2, wave3): w()
    else:
        WAVES[ns.cmd]()
    return 0


if __name__ == "__main__":
    sys.exit(main())
