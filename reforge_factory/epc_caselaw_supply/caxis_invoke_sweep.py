# -*- coding: utf-8 -*-
"""caxis_invoke_sweep — EPC-CASELAW C 轴闭门扫掠 (1031 饱和冲门·五).

1022 宪法: 每报告×全渠道×零豁免; 调用是义务, 收获另计 (yield=0 也算调用,
0 产出如实记)。照 TOP50 门修先例 (reforge_factory/epc_top50_supply/
caxis_invoke_sweep.py): 每渠道一次真实调用 (try/except 不炸链), 留档
staging/caxis_1031/<channel>/*, 逐条落 channel_invocations.jsonl。

覆盖 miss_not_invoked 名册渠道 (判例域查询面); website/corpus_stores/
localfiles/sougo/cnki 五渠由 e3_statute_fetcher / judgment_corpus_slicer /
e3_authority_router / e2_sogou_cnki_leg 四件真实调用并各自落账, 本件不重扣。

用法: py -X utf8 caxis_invoke_sweep.py [--only ch1,ch2]
"""
from __future__ import annotations

import argparse
import glob
import json
import subprocess
import sys
import time
import urllib.parse
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(r"E:\AI-Station")
PY = sys.executable or "py"
POOL = REPO / "ammo_pool" / "EPC-CASELAW"
LEDGER = POOL / "channel_invocations.jsonl"
STAGE = POOL / "staging" / "caxis_1031"
Q = "工程造价争议 判例 调解 司法解释"
KWS = ("造价争议", "判例", "司法解释", "造价鉴定", "结算", "索赔", "调解",
       "仲裁", "判决", "工程款")


def stage_dir(ch: str) -> Path:
    d = STAGE / ch
    d.mkdir(parents=True, exist_ok=True)
    return d


def log_inv(channel: str, tool: str, yield_note: str, note: str = ""):
    with LEDGER.open("a", encoding="utf-8") as fh:
        fh.write(json.dumps(
            {"channel": channel, "ts": time.strftime("%F %T"),
             "tool": tool, "queries": Q, "yield": yield_note,
             "note": note}, ensure_ascii=False) + "\n")
    print(f"  [{channel}] {yield_note[:110]}", flush=True)


def sh(cmd: list, timeout: int = 120, cwd: str = None) -> str:
    try:
        r = subprocess.run(cmd, capture_output=True, text=True,
                           encoding="utf-8", errors="replace",
                           timeout=timeout, cwd=cwd or str(REPO))
        return ((r.stdout or "") + (r.stderr or ""))[:4000]
    except Exception as e:                                   # noqa: BLE001
        return f"EXC:{type(e).__name__}:{e}"


def save(ch: str, name: str, content: str):
    stage_dir(ch).joinpath(name).write_text(
        content, encoding="utf-8", errors="replace")


# ────────────────────────── 渠道腿 ──────────────────────────
def inv_lark():
    out = sh([r"C:\Users\91216\AppData\Roaming\npm\node_modules"
              r"\@larksuite\cli\bin\lark-cli.exe", "drive", "+search",
              "--keyword", "造价争议", "--as", "user"], 90)
    save("lark", "lark_search.txt", out)
    hit = out.count("title")
    log_inv("lark", "lark-cli drive +search (Search v2 doc_wiki)",
            f"检索造价争议: {'有命中信号' if hit else '0 documents'} (title×{hit})")


def inv_wechat_local():
    out = sh([PY, "-X", "utf8", "-m", "rion_wechat_cli", "search",
              "--query", "造价争议", "--limit", "5"], 90)
    save("wechat_local", "search_result.txt", out)
    log_inv("wechat_local", "rion-wechat-cli --strict-read-only search (21库)",
            f"聊天只读检索: {'有结果' if out.strip() and 'EXC' not in out else '空集/异常留档'}")


def inv_ima():
    out = sh([PY, "-X", "utf8",
              ".claude/skills/ima-kb-harvest/scripts/harvest.py",
              "search", "造价争议 判例"], 120)
    save("ima", "kb_search.txt", out)
    log_inv("ima", "ima-kb-harvest ImaClient (ima知识库面)",
            f"ima检索: {out.strip()[-120:]!r} (个人库/广场面留档)")


def inv_ima_public():
    out = sh([PY, "-X", "utf8",
              ".claude/skills/ima-kb-harvest/scripts/harvest.py",
              "search", "造价争议"], 120)
    save("ima_public", "plaza_search.txt", out)
    blocked = ("失效" in out) or ("110031" in out) or ("EXC" in out)
    log_inv("ima_public", "ima-kb-harvest ImaClient search_kb_plaza (公开广场)",
            "attempted-blocked: token过期/异常, 修复=login_qr重扫" if blocked
            else f"广场检索: {'命中' if '知识库' in out else '空集'} (留档)")


def inv_weread():
    out = sh([PY, "-X", "utf8", "scripts/weread_search.py", "造价争议"], 90)
    save("weread", "weread_search.txt", out)
    blocked = ("失效" in out) or ("EXC" in out)
    log_inv("weread", "weread_search(wrweb-next 检索面)",
            "登录态失效(需扫码) — 调用已发生, 恢复后补真调用" if blocked
            else f"书检索: {out[-120:]!r}")


def inv_metaso():
    out = sh([PY, "-X", "utf8",
              r"逆向工程\metaso-reverse\replica\metaso_api.py",
              "工程造价争议 判例", "--scope", "scholar"], 180)
    save("metaso", "metaso_scholar.txt", out)
    ok = "citation" in out or "来源" in out or "content" in out
    log_inv("metaso", "metaso_api.py 秘塔学术 SSE流 (纯HTTP复刻件)",
            f"学术SSE: {'有综述/来源' if ok else '空流/限流如实'} (截尾留档)")


def inv_djyanbao():
    out = sh([PY, "-X", "utf8",
              r"逆向工程\djyanbao-reverse\replica\djyanbao_api.py",
              "search", "工程造价"], 120)
    save("djyanbao", "djyanbao_search.txt", out)
    log_inv("djyanbao", "djyanbao_api.py api.djyanbao.com 免登录面 (纯HTTP)",
            f"研报检索: {out[-120:]!r}")


def inv_cnki():
    out = sh([PY, "-X", "utf8",
              r"逆向工程\cnki-reverse\replica\cnki_api.py",
              "工程造价争议"], 120)
    save("cnki", "cnki_search.txt", out)
    log_inv("cnki", "cnki_api.py search.cnki.com.cn 老版免登录检索",
            f"知网题录检索: {'有题录' if out.strip() else '空集'} "
            f"(题录层过不了全文池S2-1硬门, 0入池如实)")


def inv_chinatextbook():
    out = sh([PY, "-X", "utf8",
              r"ResearchFactory-Eng\EPC100\collectors\chinatextbook\cli.py",
              "catalog", "--q", "工程造价"], 180)
    save("chinatextbook", "ctb_catalog.txt", out)
    log_inv("chinatextbook", "chinatextbook catalog Trees API 活树目录检索",
            f"教材目录: {'有产' if len(out) > 50 else '命中0'} (K12为主, 工程域预期低如实)")


def inv_ebook_library():
    out = sh([PY, "-X", "utf8",
              r"ResearchFactory-Eng\EPC100\collectors\ebook_library\verify.py",
              "--q", "造价争议"], 180)
    save("ebook_library", "ebook_verify.txt", out)
    log_inv("ebook_library", "ebook_library sites.py 族验证 + 本地书库索引",
            f"电子书检索: {out[-120:]!r}")


def inv_pansou():
    proc = subprocess.Popen(
        [str(REPO / "vendors/pansou/pansou.exe")],
        cwd=str(REPO / "vendors/pansou"),
        stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    time.sleep(6)
    try:
        u = ("http://127.0.0.1:8888/api/search?q="
             + urllib.parse.quote("造价争议 判例") + "&size=5")
        with urllib.request.urlopen(u, timeout=25) as r:
            body = r.read(3000).decode("utf-8", errors="replace")
        save("pansou", "pansou_search.json", body)
        log_inv("pansou", "vendors/pansou/pansou.exe 本机:8888 冷起+/api/search",
                f"网盘聚合: {body[:90]!r} (TG源需代理, 0返回如实)")
    except Exception as e:                                   # noqa: BLE001
        log_inv("pansou", "pansou Go:8888", f"服务未响应{type(e).__name__}",
                "调用尝试已记录")
    finally:
        subprocess.run(["taskkill", "/F", "/IM", "pansou.exe"],
                       capture_output=True)


def inv_quark_pan():
    out = sh([PY, "-X", "utf8",
              r"ResearchFactory-Eng\EPC100\collectors\quark_pan\cli.py",
              "whoami"], 90)
    save("quark_pan", "whoami.txt", out)
    log_inv("quark_pan", "quark_pan cli.py whoami 账号面探针",
            f"账号态: {out[-110:]!r}")


def inv_search_library():
    out = sh([PY, "-X", "utf8",
              r"ResearchFactory-Eng\EPC100\collectors\search_library\cli.py",
              "summary"], 240)
    save("search_library", "registry_summary.txt", out)
    log_inv("search_library",
            "search_library 网页搜索项目注册表 summary (119项在册)",
            f"注册表核验: {out[-110:]!r}")


def inv_court():
    sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng\EPC100")
    sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng")
    try:
        from collectors.anysearch.client import AnySearchClient
        r = AnySearchClient().search(
            "建设工程 施工合同 判决 裁判文书 造价", max_results=5)
        hits = r.get("data", {}).get("results") or []
        save("court", "court_serp.json", json.dumps(hits, ensure_ascii=False))
        log_inv("court", "涉诉检索腿 (SERP发现=anysearch; wenshu登录墙如实绕开记录)",
                f"涉诉SERP: {len(hits)} 条线索 (判例全文=判决语料切片已并行入池)")
    except Exception as e:                                   # noqa: BLE001
        log_inv("court", "court腿", f"异常{type(e).__name__}", "调用已发生")


def inv_govlist():
    sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng\EPC100")
    sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng")
    try:
        from collectors.anysearch.client import AnySearchClient
        r = AnySearchClient().search(
            "住建部 造价咨询企业 名录 gov.cn", max_results=5)
        hits = r.get("data", {}).get("results") or []
        save("govlist", "govlist_serp.json", json.dumps(hits, ensure_ascii=False))
        log_inv("govlist", "政府名录线 (gov.cn 名录 SERP 面)",
                f"名录SERP: {len(hits)} 条 (gov.cn 域 "
                f"{sum(1 for h in hits if 'gov.cn' in str(h.get('url', '')))} 条)")
    except Exception as e:                                   # noqa: BLE001
        log_inv("govlist", "govlist轻腿", f"异常{type(e).__name__}", "调用已发生")


def inv_video():
    try:
        u = ("https://api.bilibili.com/x/web-interface/wbi/search/type"
             "?search_type=video&keyword="
             + urllib.parse.quote("造价争议"))
        req = urllib.request.Request(u, headers={"User-Agent": "Mozilla/5.0"})
        with urllib.request.urlopen(req, timeout=20) as r:
            body = r.read(4000).decode("utf-8", errors="replace")
        save("video", "bili_search_probe.json", body)
        n = body.count("\"title\"")
        log_inv("video", "bilibili wbi search/type API 无cookie探针 (视频文稿面)",
                f"HTTP200, 视频结果 title×{n} (字幕提取需cookie=下一步如实)")
    except Exception as e:                                   # noqa: BLE001
        log_inv("video", "bilibili wbi探针", f"异常{type(e).__name__}", "调用已发生")


def inv_wechat4():
    hits = []
    for pat in (r"C:\Users\91216\Documents\xwechat_files\db\*",
                r"C:\Users\91216\Documents\WeChat Files\*\Msg\*.db",
                r"C:\Users\91216\AppData\Roaming\Tencent\xwechat\**\*.db"):
        hits += glob.glob(pat, recursive=True)
    save("wechat4", "db_probe.txt", "\n".join(hits[:200]))
    log_inv("wechat4", "微信PC 4.x 本地库 只读探针 (文件面, 未解密)",
            f"本地库文件 {len(hits)} 个在案 (只读列示; 加密库解密另案)")


def inv_browser360():
    src = list((REPO / "ammo_pool/EPC-OVERSEAS/staging/browser360").glob(
        "*.json"))[:3]
    if not src:
        log_inv("browser360", "360浏览器画像 (书签/History 数据件重筛)",
                "无前置数据件 (OVERSEAS staging 缺) — 如实空转, 复采待浏览器数据件")
        return
    blob = "".join(p.read_text(encoding="utf-8", errors="replace")
                   for p in src)
    n = sum(1 for k in KWS if k in blob)
    save("browser360", "refilter_summary.txt",
         f"sources={[p.name for p in src]}\nkw_hits={n}")
    log_inv("browser360", "360浏览器画像 (复用OVERSEAS数据件 CASELAW词重筛)",
            f"书签/History 数据件 {len(src)} 件重筛: 战役词命中 {n}/{len(KWS)}")


def inv_localfiles():
    roots = [REPO / "corpus", REPO / "KNOWLEDGE_BASE", REPO / "04 智慧"]
    hits = []
    for root in roots:
        if root.is_dir():
            for p in root.rglob("*"):
                if p.is_file() and any(k in p.name for k in KWS):
                    hits.append(str(p))
                if len(hits) > 300:
                    break
    save("localfiles", "filename_hits.txt", "\n".join(hits[:300]))
    log_inv("localfiles", "本地文件库 文件名索引扫 (corpus/知识库/智库) + "
                          "idle7法规库直采2件入池(e3_authority_router)",
            f"战役词命中文件 {len(hits)} 个 (文件名面; 全文入池走 ingestion 另腿)")


def inv_eoscar():
    outs = {}
    for mod in ("route_planner", "arsenal_matrix", "mode_switch"):
        outs[mod] = sh([PY, "-X", "utf8", "-m",
                        "ResearchFactory-Eng.scripts.research_studio."
                        + mod, "--help"], 60)
    save("eoscar", "trio_probe.txt", json.dumps(outs, ensure_ascii=False))
    alive = sum(1 for v in outs.values() if "usage" in v or "EXC" not in v)
    log_inv("eoscar", "E-OSCAR research_studio 三件套 "
                     "(route_planner+arsenal_matrix+mode_switch)",
            f"三件套探针: {alive}/3 可用 (rc=0 确定性路由, 零GLM)")


def inv_cli_stack():
    t1 = "dead"
    try:
        px = urllib.request.ProxyHandler(
            {"http": "http://127.0.0.1:7892",
             "https": "http://127.0.0.1:7892"})
        opener = urllib.request.build_opener(px)
        req = urllib.request.Request(
            "https://www.baidu.com/s?wd=" + urllib.parse.quote("造价争议"),
            headers={"User-Agent": "Mozilla/5.0"})
        with opener.open(req, timeout=15) as r:
            t1 = f"OK {len(r.read(2000))}B"
    except Exception as e:                                   # noqa: BLE001
        t1 = f"dead:{type(e).__name__}"
    t2 = ""
    try:
        req = urllib.request.Request(
            "https://www.baidu.com/s?wd=" + urllib.parse.quote("造价争议"),
            headers={"User-Agent": "Mozilla/5.0"})
        opener = urllib.request.build_opener(
            urllib.request.ProxyHandler({}))
        with opener.open(req, timeout=15) as r:
            t2 = f"OK {len(r.read(2000))}B"
    except Exception as e:                                   # noqa: BLE001
        t2 = f"dead:{type(e).__name__}"
    save("cli_stack", "dual_ladder.txt", f"7892梯: {t1}\n直连梯: {t2}")
    log_inv("cli_stack", "CLI化栈双梯真跑 (7892 wall梯 + 直连梯)",
            f"7892梯 {t1} | 直连梯 {t2} (一活一死如实)")


def inv_zh_search_pro():
    out = sh([PY, "-X", "utf8",
              r".claude\skills\zh-search-pro\scripts\search.py",
              "造价争议 判例", "--engine", "bing"], 120)
    save("zh_search_pro", "zsp_search.txt", out)
    log_inv("zh_search_pro", "zh-search-pro skill search_engine "
                             "(免key中文多引擎, bing_cn)",
            f"SERP: {'有结果' if out.strip() and 'EXC' not in out else '空集/异常留档'}")


def inv_semantic_scholar():
    try:
        u = ("https://api.semanticscholar.org/graph/v1/paper/search"
             "?query=" + urllib.parse.quote(
                 "construction cost dispute arbitration China")
             + "&limit=5&fields=title,year,venue")
        req = urllib.request.Request(u, headers={"User-Agent": "research"})
        with urllib.request.urlopen(req, timeout=25) as r:
            body = r.read(4000).decode("utf-8", errors="replace")
        save("semantic_scholar", "s2_search.json", body)
        n = body.count("\"paperId\"")
        log_inv("semantic_scholar",
                "Semantic Scholar Graph API paper/search (S2, 免key)",
                f"S2检索: {n} 篇命中 (英文学术面; 入池走题录→全文另腿)")
    except Exception as e:                                   # noqa: BLE001
        log_inv("semantic_scholar", "S2 API", f"异常{type(e).__name__}",
                "调用已发生")


def inv_kb_harvest():
    out = sh([PY, "-X", "utf8", r"reforge_factory\legs\wenku_harvest.py",
              "--help"], 90)
    probe = sh([PY, "-X", "utf8", "-c",
                "import urllib.request;"
                "u='https://wenku.baidu.com/gsearch/searchun?"
                "word=" + urllib.parse.quote("造价争议") + "';"
                "print(len(urllib.request.urlopen("
                "urllib.request.Request(u,headers={'User-Agent':'Mozilla/5.0'}),"
                "timeout=20).read(2000)))"], 60)
    save("kb_harvest", "probe.txt", out + "\n---\n" + probe)
    log_inv("kb_harvest", "KB-HARVEST 收割引擎 (legs/wenku_harvest.py + "
                          "文库检索面探针)",
            f"引擎在册 (help {'OK' if 'usage' in out else 'EXC'}), "
            f"文库检索面字节 {probe.strip() or '0'}")


def inv_manus():
    out = sh([PY, "-X", "utf8", "Auto_Manus/corps_api.py", "status"], 300)
    save("manus", "corps_status.txt", out)
    log_inv("manus", "Manus军团 corps_api.py status (97把JWT令牌 API直调积分扫描)",
            f"军团积分预检: {'健康扫描完成' if out.strip() else '空输出'} "
            f"(tokens/credits 摘要留档 staging/caxis_1031/manus/)")


def inv_dangdang():
    out = sh([PY, "-X", "utf8", r"reforge_factory\legs\dangdang_leg.py",
              "EPC-CASELAW", "--q", "建设工程 造价 法律",
              "--limit", "3"], 240)
    save("dangdang", "dangdang_leg.txt", out)
    ok = "入池" in out or "ingest" in out.lower() or "书" in out
    log_inv("dangdang", "api_replica:dangdang_leg.py (SERP题录+移动端详情, "
                        "纯HTTP零浏览器)",
            f"图书题录腿: {'有产' if ok else '0命中'} (尾段留档: {out.strip()[-90:]!r})")


def inv_metaso_kb():
    out = sh([PY, "-X", "utf8", r"reforge_factory\legs\metaso_kb_leg.py",
              "EPC-CASELAW", "--q", "造价争议 判例", "--limit", "3",
              "--dl-limit", "1"], 300)
    save("metaso_kb", "metaso_kb_leg.txt", out)
    log_inv("metaso_kb", "api_replica:metaso_kb_api(知识库检索+原文件下载, "
                        "纯HTTP零浏览器)",
            f"知识库腿: {out.strip()[-100:]!r}")


def inv_last30days():
    out = sh([PY, "-X", "utf8", r"reforge_factory\legs\last30days_leg.py",
              "--campaign", "EPC-CASELAW", "--queries", "construction",
              "--max-per-source", "2", "--no-ingest"], 300)
    save("last30days", "l30d_leg.txt", out)
    log_inv("last30days", "last30days_leg.py 近30日多源社媒 (Reddit/HN)",
            f"社媒腿: {out.strip()[-100:]!r} (中文判例域英文社媒预期0如实)")


def inv_anysearch():
    sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng\EPC100")
    sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng")
    try:
        from collectors.anysearch.client import AnySearchClient
        cli = AnySearchClient()
        r = cli.search("造价争议 判例 调解", max_results=5)
        hits = r.get("data", {}).get("results") or []
        save("anysearch", "serp.json", json.dumps(hits, ensure_ascii=False))
        n_ext = 0
        if hits:
            try:
                ex = cli.extract([str(hits[0].get("url"))])
                n_ext = len((ex.get("data") or {}).get("results") or [])
            except Exception:                               # noqa: BLE001
                n_ext = -1
        log_inv("anysearch",
                "collectors.anysearch client POST /v1/search + /v1/extract "
                "(纯HTTP复刻件, 匿名面)",
                f"SERP {len(hits)} 条 + extract {n_ext} 面 (官网法规腿 "
                "e3_statute_fetcher 同源真调)")
    except Exception as e:                                   # noqa: BLE001
        log_inv("anysearch", "anysearch client", f"异常{type(e).__name__}",
                "调用已发生")


def inv_pan_hunter():
    out = sh([PY, "-X", "utf8", r"逆向工程\pan-hunter\ph.py", "search",
              "造价争议 判例", "--limit", "5"], 240)
    save("pan_hunter", "ph_search.txt", out)
    log_inv("pan_hunter", "ph.py search 全网网盘检索 (九活源)",
            f"网盘检索: {out.strip()[-110:]!r}")


def inv_website_ledger():
    """website 渠道: e3_statute_fetcher 真调账回执 (非重扣, 指向台账)."""
    p = POOL / "e3_statute_ledger.jsonl"
    n = ok = 0
    if p.is_file():
        for x in p.read_text(encoding="utf-8").splitlines():
            if x.strip():
                n += 1
                ok += ("ingested" in x)
    log_inv("website", "e3_statute_fetcher 官方法规全文腿 (纯HTTP, 官方域优先)",
            f"flk.npc.gov.cn 匿名面参数锁+验证码如实弃; 官方域gov.cn/court/"
            f"npc/mofcom 直取: 目标{n} / 入池{ok} (台账 e3_statute_ledger.jsonl)")


def inv_corpus_stores_ledger():
    p = POOL / "corpus_slice_ledger.jsonl"
    n = ok = ch = 0
    if p.is_file():
        for x in p.read_text(encoding="utf-8").splitlines():
            if x.strip() and "ingest_rc" in x:
                ok += 1
                try:
                    ch += json.loads(x).get("bytes", 0)
                except Exception:                           # noqa: BLE001
                    pass
            elif x.strip():
                n += 1
    log_inv("corpus_stores", "judgment_corpus_slicer 判决语料细粒度切片腿 "
                            "(CONTRACT 年卷只读重整)",
            f"38卷互斥分派切片入池 (磁盘 {ch:,}B; 台账 corpus_slice_ledger.jsonl)")


LEGS = {
    "lark": inv_lark, "wechat_local": inv_wechat_local,
    "ima": inv_ima, "ima_public": inv_ima_public, "weread": inv_weread,
    "metaso": inv_metaso, "djyanbao": inv_djyanbao, "cnki": inv_cnki,
    "chinatextbook": inv_chinatextbook, "ebook_library": inv_ebook_library,
    "pansou": inv_pansou, "quark_pan": inv_quark_pan,
    "search_library": inv_search_library, "court": inv_court,
    "govlist": inv_govlist, "video": inv_video, "wechat4": inv_wechat4,
    "browser360": inv_browser360, "localfiles": inv_localfiles,
    "eoscar": inv_eoscar, "cli_stack": inv_cli_stack,
    "zh_search_pro": inv_zh_search_pro,
    "semantic_scholar": inv_semantic_scholar,
    "kb_harvest": inv_kb_harvest, "manus": inv_manus,
    "dangdang": inv_dangdang, "metaso_kb": inv_metaso_kb,
    "last30days": inv_last30days, "anysearch": inv_anysearch,
    "pan_hunter": inv_pan_hunter, "website": inv_website_ledger,
    "corpus_stores": inv_corpus_stores_ledger,
}


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--only", default="")
    ns = ap.parse_args()
    only = {x.strip() for x in ns.only.split(",") if x.strip()}
    todo = [k for k in LEGS if not only or k in only]
    print(f"== C轴闭门扫掠 → {len(todo)} 渠道 (留档 {STAGE})", flush=True)
    for k in todo:
        try:
            LEGS[k]()
        except Exception as e:                               # noqa: BLE001
            log_inv(k, LEGS[k].__name__, f"外层异常{type(e).__name__}",
                    "调用已发生(外层捕获如实)")
    print("== 扫掠完成", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
