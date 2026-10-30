# -*- coding: utf-8 -*-
"""腿8: AnySearch 免费企查面 - 50强企业基础工商信息 (engine=anysearch:web).
复用 EPC100 AnySearchClient (限流/熔断/日限四件套), query=企业名, extract全文入池."""
import io, json, re, subprocess, sys, time
from pathlib import Path
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng\EPC100")
from collectors.anysearch.client import AnySearchClient, AnySearchError
REPO = Path(r"E:\AI-Station")
AMMO = REPO / "reforge_factory" / "ammo_pool.py"
STAGE = REPO / "ammo_pool" / "EPC-TOP50" / "staging" / "anysearch_web" / time.strftime("%Y%m%d_%H%M%S")
STAGE.mkdir(parents=True, exist_ok=True)
LOG = REPO / "reforge_factory" / "epc_top50_supply" / "logs" / ("anysearch_%s.log" % time.strftime("%Y%m%d_%H%M%S"))
NAMES = ["中国电建集团华东勘测设计研究院有限公司","中国电建集团成都勘测设计研究院有限公司",
"中国电建集团昆明勘测设计研究院有限公司","中国电建集团中南勘测设计研究院有限公司","中建八局",
"中建二局","中建三局","中建五局","中建六局","长江设计集团有限公司","中城科泽工程设计集团有限责任公司",
"中国石油工程建设有限公司","中交公路规划设计院有限公司","中国能源建设集团广西电力设计研究院有限公司",
"中石化广州工程有限公司","华陆工程科技集团有限公司","中国寰球工程有限公司","湖南省建筑设计院集团有限公司",
"上海市政工程设计研究总院(集团)有限公司","中国联合工程有限公司","明阳智慧能源集团股份公司",
"中冶南方工程技术有限公司","中国汽车工业工程有限公司","山东电力工程咨询院有限公司","中国天辰工程有限公司",
"中铁第四勘察设计院集团有限公司","中国五环工程有限公司","中亿国际设计集团有限公司",
"中国能源建设集团规划设计有限公司","中材国际工程股份有限公司","中钢国际工程技术股份有限公司"]
def ingest(md, url):
    cmd = ["py","-X","utf8",str(AMMO),"ingest","EPC-TOP50","--file",str(md),
           "--engine","anysearch:web","--url",url,"--cred","media","--tree","Q17-E1"]
    r = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="replace")
    return r.returncode, ((r.stdout or "") + (r.stderr or ""))
def main():
    out = open(LOG, "a", encoding="utf-8")
    def emit(s): print(s, flush=True); out.write(s + "\n"); out.flush()
    cli = AnySearchClient()
    tot = 0; totc = 0
    for name in NAMES:
        try:
            res = cli.search(name, max_results=3)
        except AnySearchError as e:
            emit(json.dumps({"ok": False, "name": name, "why": f"search_err:{e}"}, ensure_ascii=False)); time.sleep(10); continue
        hits = ((res.get("data") or {}).get("results") or []) if isinstance(res, dict) else (res if isinstance(res, list) else [])
        picked = []
        for h in hits[:3]:
            u = h.get("url") or h.get("link") or ""
            t = h.get("title") or ""
            if not u or any(x in u for x in ("baike.baidu","qcc.com","tianyancha","zhihu.com","weibo")): continue
            if not (name[:6] in t + u or "公司" in t or "集团" in t): continue
            picked.append((t, u)); 
            if len(picked) >= 1: break
        if not picked:
            emit(json.dumps({"ok": False, "name": name, "why": "no_relevant_hit"}, ensure_ascii=False)); time.sleep(6); continue
        title, u = picked[0]
        try:
            doc = cli.extract(u)
        except AnySearchError as e:
            emit(json.dumps({"ok": False, "name": name, "why": f"extract_err:{e}"}, ensure_ascii=False)); time.sleep(6); continue
        text = (doc.get("markdown") or doc.get("text") or doc.get("content") or "") if isinstance(doc, dict) else str(doc)
        text = re.sub(r"\n{3,}", "\n\n", text).strip()
        if len(text) < 600:
            emit(json.dumps({"ok": False, "name": name, "why": f"thin:{len(text)}"}, ensure_ascii=False)); time.sleep(6); continue
        md = STAGE / (re.sub(r"\W+", "_", name)[:40] + ".md")
        head = (f"# {name}——企业基础信息与工商面(AnySearch免费企查)\n\n"
            f"来源: AnySearch 检索面 (engine=anysearch:web), 页面: {title} / {u}\n"
            f"campaign EPC-TOP50, tree Q17-E1, cred media. 全文提取零改动, 实测{len(text)}字.\n\n---\n\n")
        md.write_text(head + text, encoding="utf-8")
        rc, msg = ingest(md, u)
        ok = rc == 0 and "硬拒" not in msg
        if ok: tot += 1; totc += len(text)
        emit(json.dumps({"ok": ok, "name": name, "chars": len(text), "msg": msg.strip()[-110:]}, ensure_ascii=False))
        time.sleep(6)
    emit(json.dumps({"SUMMARY": True, "ingested": tot, "chars_sum": totc}, ensure_ascii=False))
if __name__ == "__main__":
    main()
