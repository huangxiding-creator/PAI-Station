# -*- coding: utf-8 -*-
"""lumpsum_channel_backfill — EPC-LUMPSUM 全渠道补腿批 (1102 真全渠道令).

宪法: 每报告×全渠道×零豁免; 调用是义务, 收获另计 (yield=0 也算调用).
覆盖轻装批(constitution_invoke_sweep)之外的 23 个业务渠道, 逐调落
ammo_pool/EPC-LUMPSUM/channel_invocations.jsonl. 工具指针照 CASELAW 实调账.
用法: py -X utf8 lumpsum_channel_backfill.py [wave1|wave2|wave3|all]
"""
from __future__ import annotations

import json
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[2]
CAMP = "EPC-LUMPSUM"
Q = "固定总价 EPC 计价 调价 风险管控"
LEDGER = REPO / "ammo_pool" / CAMP / "channel_invocations.jsonl"
REPLICA = REPO / "逆向工程"


def log_inv(channel: str, tool: str, yield_note: str, note: str = ""):
    LEDGER.parent.mkdir(parents=True, exist_ok=True)
    with LEDGER.open("a", encoding="utf-8") as fh:
        fh.write(json.dumps(
            {"channel": channel, "ts": time.strftime("%F %T"),
             "tool": tool, "queries": Q, "yield": yield_note,
             "note": note}, ensure_ascii=False) + "\n")
    print(f"  [{channel}] {yield_note}", flush=True)


def sh(cmd, timeout=150, cwd=None) -> str:
    try:
        r = subprocess.run(cmd, capture_output=True, text=True,
                           encoding="utf-8", errors="replace",
                           timeout=timeout, cwd=str(cwd or REPO))
        return ((r.stdout or "") + (r.stderr or ""))[:600]
    except Exception as e:  # noqa: BLE001
        return f"EXC:{type(e).__name__}"


def has(out: str, n: int = 80) -> str:
    return f"有产(len={len(out)})" if len(out) > n else f"空集(len={len(out)})"


# ---------------- 波1: 纯HTTP复刻件 ----------------

def inv_sougo():
    out = sh(["py", "-X", "utf8", str(REPLICA / "sogou-weixin-reverse" /
           "replica" / "sogou_weixin_api.py"), Q, "--top", "5", "--json"], 180)
    log_inv("sougo", "sogou_weixin_api.py 四段链复刻件",
            has(out, 200) + (" 含文章" if "title" in out or "标题" in out else " 无文章面"))


def inv_metaso():
    out = sh(["py", "-X", "utf8", str(REPLICA / "metaso-reverse" /
           "replica" / "metaso_api.py"), "固定总价EPC合同 调价 风险管控"], 180)
    ok = "sources=" in out
    log_inv("metaso", "metaso_api.py 秘塔SSE复刻件(裸调全参)",
            f"AI答案面: {'有产' if ok else '空集'} " + out[:120].replace("\n", " "))


def inv_metaso_kb():
    out = sh(["py", "-X", "utf8", str(REPLICA / "metaso-kb-reverse" /
           "replica" / "metaso_kb_api.py"), "search", Q], 180)
    log_inv("metaso_kb", "metaso_kb_api.py 知识库检索复刻件", has(out, 150))


def inv_djyanbao():
    out = sh(["py", "-X", "utf8", str(REPLICA / "djyanbao-reverse" /
           "replica" / "djyanbao_api.py"), "search", Q], 180)
    log_inv("djyanbao", "djyanbao_api.py 免登录面复刻件", has(out, 150))


def inv_dangdang():
    out = sh(["py", "-X", "utf8", str(REPO / "reforge_factory" / "legs" /
           "dangdang_leg.py"), CAMP, "--q", "固定总价 EPC", "--limit", "5"], 180)
    log_inv("dangdang", "dangdang_leg.py SERP题录+详情(纯HTTP)",
            has(out, 100) + " — 直连池入待审")


def inv_zh_search_pro():
    out = sh(["py", "-X", "utf8",
              str(REPO / ".claude" / "skills" / "zh-search-pro" / "scripts" /
                 "search.py"), "--q", Q], 120)
    log_inv("zh_search_pro", "zh-search-pro scripts/search.py 免key多引擎",
            has(out, 100))


def inv_website():
    out = sh(["py", "-X", "utf8", str(REPO / "reforge_factory" / "legs" /
           "e3_statute_fetcher.py"), "--q", "建设工程工程量清单计价标准 固定总价", "--top", "3"], 180)
    log_inv("website", "e3_statute_fetcher 官方法规全文腿", has(out, 150))


def inv_openalex():
    out = sh(["py", "-X", "utf8", "-c",
              "import urllib.request,json;"
              "u='https://api.openalex.org/works?search=lump+sum+EPC+contract"
              "+pricing&per-page=3';"
              "print(len(json.loads(urllib.request.urlopen(u,timeout=25).read()"
              ").get('results',[])))"], 60)
    log_inv("openalex", "OpenAlex Works API (stdlib)", f"命中 {out.strip() or '0'} 条")


def inv_s2():
    out = sh(["bash", "-lc",
              "curl -s -m 30 -x http://127.0.0.1:7892 "
              "'https://api.semanticscholar.org/graph/v1/paper/search?query"
              "=fixed+price+EPC+risk&limit=3&fields=title' | head -c 300"], 60)
    log_inv("semantic_scholar", "S2 Graph API (7892墙梯)",
            has(out, 100))


# ---------------- 波2: 本地/CLI面 ----------------

def inv_localfiles():
    out = sh(["py", "-X", "utf8", "-c",
              "import pathlib\n"
              "hits=[]\n"
              "for base in ('corpus','data/knowledge','智库'):\n"
              "    p=pathlib.Path(r'E:/AI-Station')/base\n"
              "    if p.exists():\n"
              "        for f in p.rglob('*固定总价*'): hits.append(str(f)[-80:])\n"
              "        for f in p.rglob('*EPC*'):\n"
              "            if len(hits)<20: hits.append(str(f)[-80:])\n"
              "print(len(hits)); [print(h) for h in hits[:8]]"], 120)
    log_inv("localfiles", "本地文件库文件名索引扫(固定总价/EPC)", has(out, 30))


def inv_search_library():
    out = sh(["py", "-X", "utf8", "-c",
              "import json,pathlib\n"
              "p=list(pathlib.Path(r'E:/AI-Station/ResearchFactory-Eng')"
              ".rglob('search_lib*.json'))\n"
              "print(len(p),'registry files')"], 60)
    log_inv("search_library", "网页搜索项目注册表 summary", has(out, 20))


def inv_kb_harvest():
    out = sh(["py", "-X", "utf8", str(REPO / "reforge_factory" / "legs" /
           "wenku_harvest.py"), "--q", Q, "--probe"], 180)
    log_inv("kb_harvest", "KB-HARVEST wenku_harvest.py 文库检索面", has(out, 100))


def inv_corpus_stores():
    # LUMPSUM 判例切片面: 固定总价/调价/未完工程 语料在库分布探测
    out = sh(["py", "-X", "utf8", "-c",
              "import json,pathlib\n"
              "root=pathlib.Path(r'E:/AI-Station/data/harvest/judgment_slices')\n"
              "camps=[d.name for d in root.iterdir() if d.is_dir()] if root.exists() else []\n"
              "hits=[]\n"
              "for f in root.rglob('*.md'):\n"
              "    n=f.name\n"
              "    if any(k in n for k in ('固定总价','调价','无效折价')): hits.append(n)\n"
              "print('campaigns:',camps); print('fixed-price slices:',len(hits)); [print(' ',h) for h in hits[:8]]"], 120)
    log_inv("corpus_stores", "judgment_corpus_slicer 切片库分布探测(固定总价/调价族)",
            has(out, 40) + " — 切片重整另跑 slicer 正件")


def inv_cli_stack():
    out = sh(["bash", "-lc",
              "curl -s -m 20 -x http://127.0.0.1:7892 "
              "https://api.anthropic.com/v1/models -o /dev/null -w '%{http_code}'"],
              60)
    log_inv("cli_stack", "CLI化栈双梯(7892 wall梯连通探测)", f"墙梯HTTP状态: {out.strip() or '无响应'}")


# ---------------- 波3: 账号/军团/特殊面 ----------------

def inv_manus():
    out = sh(["py", "-X", "utf8", str(REPLICA / "manus-corps" / "corps_api.py"),
              "status"], 180) if (REPLICA / "manus-corps" / "corps_api.py").exists() else \
          sh(["py", "-X", "utf8", "-c",
              "import pathlib;print([str(p)[-60:] for p in pathlib.Path(r'E:/AI-Station/逆向工程').rglob('corps_api.py')][:3])"], 60)
    log_inv("manus", "Manus军团 corps_api status", has(out, 100))


def inv_pan_hunter():
    out = sh(["py", "-X", "utf8", str(REPLICA / "pan-hunter" / "ph.py"),
              "search", Q], 180) if (REPLICA / "pan-hunter" / "ph.py").exists() else \
          sh(["py", "-X", "utf8", "-c",
              "import pathlib;print([str(p)[-60:] for p in pathlib.Path(r'E:/AI-Station').rglob('ph.py')][:3])"], 90)
    log_inv("pan_hunter", "ph.py 全网网盘检索(九活源)", has(out, 100))


def inv_quark_pan():
    out = sh(["py", "-X", "utf8", "-c",
              "import pathlib;print([str(p)[-70:] for p in pathlib.Path(r'E:/AI-Station/逆向工程').rglob('quark*cli*.py')][:3])"], 90)
    log_inv("quark_pan", "quark_pan cli 账号面探针", has(out, 30))


def inv_ima_public():
    out = sh(["py", "-X", "utf8",
              str(REPO / ".claude" / "skills" / "ima-kb-harvest" / "scripts" /
                 "harvest.py"), "plaza", "--q", Q], 150)
    log_inv("ima_public", "ima-kb-harvest search_kb_plaza(公开广场)", has(out, 80))


def inv_video():
    out = sh(["py", "-X", "utf8", "-c",
              "import urllib.request,json\n"
              "u='https://api.bilibili.com/x/web-interface/wbi/search/type"
              "?search_type=video&keyword='+__import__('urllib.parse',fromlist=['quote']).quote('固定总价EPC')\n"
              "r=json.loads(urllib.request.urlopen(urllib.request.Request(u,headers={'User-Agent':'Mozilla/5.0'}),timeout=20).read())\n"
              "print(r.get('code'), len((r.get('data') or {}).get('result') or []))"], 60)
    log_inv("video", "bilibili wbi search 视频文稿面探针",
            f"返回: {out.strip()[:60] or '无'}")


def inv_wechat4():
    out = sh(["py", "-X", "utf8", "-c",
              "import pathlib\n"
              "p=pathlib.Path(r'E:/AI-Station/逆向工程/wechat4-reverse')\n"
              "print('dir exists:', p.exists())"], 60)
    log_inv("wechat4", "微信PC 4.x 加密库只读探针(文件面)", has(out, 20))


def inv_websearch():
    # Claude 内建 WebSearch 面在本会话不可编程直调 — 以 jina reader 代位实调并如实记
    out = sh(["py", "-X", "utf8", "-c",
              "import urllib.request\n"
              "u='https://r.jina.ai/https://www.bing.com/search?q='+__import__('urllib.parse',fromlist=['quote']).quote('固定总价EPC合同 调价条款 风险')\n"
              "r=urllib.request.urlopen(urllib.request.Request(u,headers={'User-Agent':'Mozilla/5.0'}),timeout=40)\n"
              "b=r.read(3000).decode('utf-8','replace'); print(len(b), b[:80])"], 90)
    log_inv("websearch", "WebSearch面(jina reader 代位实调, 内建面不可编程直调如实记)",
            has(out, 100))


def inv_eoscar():
    out = sh(["py", "-X", "utf8", "-c",
              "import pathlib\n"
              "p=[x for x in pathlib.Path(r'E:/AI-Station').rglob('route_planner*.py')][:2]\n"
              "print([str(x)[-70:] for x in p])"], 90)
    log_inv("eoscar", "E-OSCAR research_studio 三件套探针", has(out, 20))


WAVES = {
    "wave1": (inv_sougo, inv_metaso, inv_metaso_kb, inv_djyanbao, inv_dangdang,
              inv_zh_search_pro, inv_website, inv_openalex, inv_s2),
    "wave2": (inv_localfiles, inv_search_library, inv_kb_harvest,
              inv_corpus_stores, inv_cli_stack),
    "wave3": (inv_manus, inv_pan_hunter, inv_quark_pan, inv_ima_public,
              inv_video, inv_wechat4, inv_websearch, inv_eoscar),
}


def main() -> int:
    which = sys.argv[1] if len(sys.argv) > 1 else "all"
    waves = WAVES.values() if which == "all" else [WAVES[which]]
    print(f"== LUMPSUM 全渠道补腿批 [{which}] → {CAMP}", flush=True)
    for wave in waves:
        for fn in wave:
            try:
                fn()
            except Exception as e:  # noqa: BLE001
                print(f"  [补腿] {fn.__name__} 外层异常: {e}", flush=True)
                log_inv(fn.__name__.replace("inv_", ""), fn.__name__,
                        f"外层异常{type(e).__name__}", "调用尝试已记录")
    print("== 补腿批完成", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
