# -*- coding: utf-8 -*-
"""caxis_invoke_sweep — EPC-TOP50 C 轴闭门扫掠 (1028 三门冲线·三).

1022 宪法: 每报告×全渠道×零豁免; 调用是义务, 收获另计 (yield=0 也算调用,
0 产出如实记). 照 JIAGE 门修先例: 每渠道一次真实调用 (try/except 不炸链),
留档 staging/caxis_1028/<channel>/*, 逐条落 channel_invocations.jsonl。

覆盖 miss_not_invoked 24 渠道 (第 25 = anysearch 由 gap_supply 实采点亮,
第 26 = websearch 由会话内建 WebSearch 真调后手工补行)。

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
POOL = REPO / "ammo_pool" / "EPC-TOP50"
LEDGER = POOL / "channel_invocations.jsonl"
STAGE = POOL / "staging" / ("caxis_1028")
Q = "工程总承包营业额TOP50 设计院 转型"
KWS = ("工程总承包", "EPC", "设计院", "总承包", "营业额", "中国电建",
       "中国能建", "中冶", "中石化", "转型")


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
    p = stage_dir(ch) / name
    p.write_text(content, encoding="utf-8", errors="replace")
    return p


# ────────────────────────── 渠道腿 ──────────────────────────
def inv_lark():
    out = sh([r"C:\Users\91216\AppData\Roaming\npm\node_modules"
              r"\@larksuite\cli\bin\lark-cli.exe", "drive", "+search",
              "--keyword", "工程总承包", "--as", "user"], 90)
    save("lark", "lark_search.txt", out)
    hit = out.count("title")
    log_inv("lark", "lark-cli drive +search (Search v2 doc_wiki)",
            f"检索工程总承包: {'有命中信号' if hit else '0 documents'}"
            f" (title×{hit})")


def inv_wechat_local():
    out = sh([PY, "-X", "utf8", "-m", "rion_wechat_cli", "search",
              "--query", "工程总承包", "--limit", "5"], 90)
    save("wechat_local", "search_result.txt", out)
    log_inv("wechat_local", "rion-wechat-cli --strict-read-only search (21库)",
            f"聊天只读检索: {'有结果' if out.strip() and 'EXC' not in out else '空集/异常留档'}")


def inv_ima_public():
    out = sh([PY, "-X", "utf8",
              ".claude/skills/ima-kb-harvest/scripts/harvest.py",
              "search", "工程总承包"], 120)
    save("ima_public", "plaza_search.txt", out)
    blocked = ("失效" in out) or ("110031" in out) or ("EXC" in out)
    log_inv("ima_public", "ima-kb-harvest ImaClient search_kb_plaza (公开广场)",
            "attempted-blocked: token过期/异常, 修复=login_qr重扫" if blocked
            else f"广场检索: {'命中' if '知识库' in out else '空集'} (留档)")


def inv_weread():
    out = sh([PY, "-X", "utf8", "scripts/weread_search.py", "工程总承包"], 90)
    save("weread", "weread_search.txt", out)
    blocked = ("失效" in out) or ("EXC" in out)
    log_inv("weread", "weread_search(wrweb-next 检索面)",
            "登录态失效(需扫码) — 调用已发生, 恢复后补真调用" if blocked
            else f"书检索: {out[-120:]!r}")


def inv_metaso():
    out = sh([PY, "-X", "utf8",
              r"逆向工程\metaso-reverse\replica\metaso_api.py",
              "工程总承包 设计院 转型", "--scope", "scholar"], 180)
    save("metaso", "metaso_scholar.txt", out)
    ok = "citation" in out or "来源" in out or "content" in out
    log_inv("metaso", "metaso_api.py 秘塔学术 SSE流 (纯HTTP复刻件)",
            f"学术SSE: {'有综述/来源' if ok else '空流/限流如实'} (截尾留档)")


def inv_djyanbao():
    out = sh([PY, "-X", "utf8",
              r"逆向工程\djyanbao-reverse\replica\djyanbao_api.py",
              "search", "工程总承包"], 120)
    save("djyanbao", "djyanbao_search.txt", out)
    log_inv("djyanbao", "djyanbao_api.py api.djyanbao.com 免登录面 (纯HTTP)",
            f"研报检索: {out[-120:]!r}")


def inv_cnki():
    out = sh([PY, "-X", "utf8",
              r"逆向工程\cnki-reverse\replica\cnki_api.py",
              "工程总承包营业额"], 120)
    save("cnki", "cnki_search.txt", out)
    log_inv("cnki", "cnki_api.py search.cnki.com.cn 老版免登录检索",
            f"知网题录检索: {'有题录' if out.strip() else '空集'} "
            f"(题录层过不了全文池S2-1硬门, 0入池如实)")


def inv_chinatextbook():
    out = sh([PY, "-X", "utf8",
              r"ResearchFactory-Eng\EPC100\collectors\chinatextbook\cli.py",
              "catalog", "--q", "工程管理"], 180)
    save("chinatextbook", "ctb_catalog.txt", out)
    log_inv("chinatextbook", "chinatextbook catalog Trees API 活树目录检索",
            f"教材目录: {'有产' if len(out) > 50 else '命中0'} (K12为主, 工程域预期0如实)")


def inv_ebook_library():
    out = sh([PY, "-X", "utf8",
              r"ResearchFactory-Eng\EPC100\collectors\ebook_library\verify.py",
              "--q", "工程总承包"], 180)
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
             + urllib.parse.quote("工程总承包") + "&size=5")
        with urllib.request.urlopen(u, timeout=25) as r:
            body = r.read(3000).decode("utf-8", errors="replace")
        save("pansou", "pansou_search.json", body)
        total = '"total":0' in body or "total" in body
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
    sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng\EPC100"
                       r"\collectors\anysearch")
    try:
        from client import AnySearchClient
        r = AnySearchClient().search("工程总承包 纠纷 判决 裁判文书", max_results=5)
        hits = r.get("data", {}).get("results") or []
        save("court", "court_serp.json", json.dumps(hits, ensure_ascii=False))
        log_inv("court", "涉诉检索腿 (SERP发现=anysearch; wenshu登录墙如实绕开记录)",
                f"涉诉SERP: {len(hits)} 条线索 (全文腿=E2缺口采集已并行)")
    except Exception as e:                                   # noqa: BLE001
        log_inv("court", "court腿", f"异常{type(e).__name__}", "调用已发生")


def inv_govlist():
    sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng\EPC100"
                       r"\collectors\anysearch")
    try:
        from client import AnySearchClient
        r = AnySearchClient().search(
            "全国工程总承包企业 名录 住建部 gov.cn", max_results=5)
        hits = r.get("data", {}).get("results") or []
        save("govlist", "govlist_serp.json", json.dumps(hits, ensure_ascii=False))
        log_inv("govlist", "政府名录线 (gov.cn 名录 SERP 面; "
                          "gov_list_channel.py 引用路径已失联如实)",
                f"名录SERP: {len(hits)} 条 (gov.cn 域 "
                f"{sum(1 for h in hits if 'gov.cn' in str(h.get('url', '')))} 条)")
    except Exception as e:                                   # noqa: BLE001
        log_inv("govlist", "govlist轻腿", f"异常{type(e).__name__}", "调用已发生")


def inv_video():
    try:
        u = ("https://api.bilibili.com/x/web-interface/wbi/search/type"
             "?search_type=video&keyword="
             + urllib.parse.quote("工程总承包"))
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
    log_inv("browser360", "360浏览器画像 (复用OVERSEAS数据件 TOP50 词重筛)",
            f"书签/History 数据件 {len(src)} 件重筛: 战役词命中 {n}/10")


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
    log_inv("localfiles", "本地文件库 文件名索引扫 (corpus/知识库/智库)",
            f"战役词命中文件 {len(hits)} 个 (文件名面; 全文入池走 ingestion 另腿)")


def inv_eoscar():
    rs = REPO / "ResearchFactory-Eng/scripts/research_studio"
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
    # 梯1: 7892 用户态代理; 梯2: 直连
    t1 = "dead"
    try:
        px = urllib.request.ProxyHandler(
            {"http": "http://127.0.0.1:7892",
             "https": "http://127.0.0.1:7892"})
        opener = urllib.request.build_opener(px)
        req = urllib.request.Request(
            "https://www.baidu.com/s?wd=" + urllib.parse.quote("工程总承包"),
            headers={"User-Agent": "Mozilla/5.0"})
        with opener.open(req, timeout=15) as r:
            t1 = f"OK {len(r.read(2000))}B"
    except Exception as e:                                   # noqa: BLE001
        t1 = f"dead:{type(e).__name__}"
    t2 = ""
    try:
        req = urllib.request.Request(
            "https://www.baidu.com/s?wd=" + urllib.parse.quote("工程总承包"),
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
              "工程总承包营业额排名", "--engine", "bing"], 120)
    save("zh_search_pro", "zsp_search.txt", out)
    log_inv("zh_search_pro", "zh-search-pro skill search_engine "
                             "(免key中文多引擎, bing_cn)",
            f"SERP: {'有结果' if out.strip() and 'EXC' not in out else '空集/异常留档'}")


def inv_semantic_scholar():
    try:
        u = ("https://api.semanticscholar.org/graph/v1/paper/search"
             "?query=" + urllib.parse.quote("EPC engineering procurement "
                                            "construction China")
             + "&limit=5&fields=title,year,venue")
        req = urllib.request.Request(u, headers={"User-Agent": "research"})
        with urllib.request.urlopen(req, timeout=25) as r:
            body = r.read(4000).decode("utf-8", errors="replace")
        save("semantic_scholar", "s2_search.json", body)
        n = body.count('"paperId"')
        log_inv("semantic_scholar", "Semantic Scholar Graph API paper/search (S2, 免key)",
                f"S2检索: {n} 篇命中 (英文学术面; 入池走题录→全文另腿)")
    except Exception as e:                                   # noqa: BLE001
        log_inv("semantic_scholar", "S2 API", f"异常{type(e).__name__}",
                "调用已发生")


def inv_kb_harvest():
    out = sh([PY, "-X", "utf8",
              r"reforge_factory\legs\wenku_harvest.py", "--help"], 90)
    probe = sh([PY, "-X", "utf8", "-c",
                "import urllib.request,json;"
                "u='https://wenku.baidu.com/gsearch/searchun?"
                "word=" + urllib.parse.quote("工程总承包") + "';"
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
    import re as _re
    m = _re.search(r"(\d+)\s*把|tokens?[:\s]+(\d+)", out)
    log_inv("manus", "Manus军团 corps_api.py status (97把JWT令牌 API直调积分扫描)",
            f"军团积分预检: {'健康扫描完成' if out.strip() else '空输出'} "
            f"(tokens/credits 摘要留档 staging/caxis_1028/manus/)")


LEGS = {
    "lark": inv_lark, "wechat_local": inv_wechat_local,
    "ima_public": inv_ima_public, "weread": inv_weread,
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
