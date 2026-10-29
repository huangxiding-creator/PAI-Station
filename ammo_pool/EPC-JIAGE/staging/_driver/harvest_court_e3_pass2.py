# -*- coding: utf-8 -*-
"""收尾二跑: Q18-E3/Q14-E3 各补 1 件新域全文 (同 harvest_court_e3.py 机制, 更换查询+域排除)."""
import json, re, sys, time, hashlib
from pathlib import Path
from urllib.parse import urlparse
sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng\EPC100")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from collectors.anysearch.client import AnySearchClient  # noqa: E402

STAGE_C = Path(r"E:\AI-Station\ammo_pool\EPC-JIAGE\staging\court_anysearch")
MAP = Path(r"E:\AI-Station\ammo_pool\EPC-JIAGE\staging\_driver\map_court_e3.jsonl")
USED = {"Q18-E3": {"meritsandtree.com", "society.people.com.cn", "people.com.cn"},
        "Q14-E3": {"www.gov.cn", "sjc.kmu.edu.cn"}}
PLAN = [
    ("Q18-E3", "建设工程施工合同纠纷司法解释 二 全文 工程价款 计价"),
    ("Q18-E3", "建工解释二 第十条 价款结算 条文 解读"),
    ("Q14-E3", "现场签证 工程价款 计价 管理办法"),
    ("Q14-E3", "工程变更 估价 计价 依据 标准"),
]
DOM_RE = re.compile(r"造价|计价|结算|工程|签证|变更|价款|司法解释")
KW_RE  = re.compile(r"签证|变更|价款|计价|结算|解释|办法|规定|规则")
def host(u):
    try: return urlparse(u).netloc.lower()
    except Exception: return ""
def slugify(t, n=28):
    return re.sub(r"[^\w一-鿿]+", "_", t).strip("_")[:n] or "doc"
def main():
    cli = AnySearchClient(); mf = open(MAP, "a", encoding="utf-8")
    got, hosts = {}, {}
    for eei, q in PLAN:
        if got.get(eei, 0) >= 1: continue
        try:
            res = ((cli.search(q) or {}).get("data") or {}).get("results") or []
        except Exception as e:
            print(f"[search-fail] {q}: {str(e)[:60]}", file=sys.stderr); continue
        picked = 0
        for it in res:
            if not isinstance(it, dict): continue
            title = str(it.get("title") or "").strip(); url = str(it.get("url") or it.get("link") or "").strip()
            h = host(url)
            if not title or not url.startswith("http") or not h: continue
            if h in USED.get(eei, set()) or h in hosts.get(eei, set()): continue
            if not (DOM_RE.search(title) and KW_RE.search(title)): continue
            content = ""
            try:
                ex = cli.extract(url) or {}
                content = str(((ex.get("data") or {}).get("content")) or ex.get("content") or "")
            except Exception: pass
            # 全文须真正含计价/签证实质词, 防 nav 噪声页
            if len(content) < 800 or not re.search(r"签证|价款|计价|结算|估价", content):
                print(f"[thin] {eei} {title[:36]} len={len(content)}"); continue
            cred = "official" if h.endswith(".gov.cn") else "research"
            fp = STAGE_C / f"{eei}_{slugify(title)}_{hashlib.md5(url.encode()).hexdigest()[:8]}.md"
            fp.write_text(f"# {title}\n\n> 缺口定向收尾腿二跑 (court:anysearch)\n> URL: {url}\n"
                          f"> 采集: {time.strftime('%Y-%m-%d %H:%M')}\n\n{content}", encoding="utf-8")
            mf.write(json.dumps({"file": str(fp), "engine": "court:anysearch", "eei": eei, "stance": "support",
                                 "cred": cred, "url": url, "title": title, "chars": len(content)}, ensure_ascii=False) + "\n")
            mf.flush(); hosts.setdefault(eei, set()).add(h); picked += 1; got[eei] = got.get(eei, 0) + 1
            print(f"[OK] {eei} {h} chars={len(content)} | {title[:46]}")
            break
        time.sleep(2)
    mf.close(); print("SUMMARY:", json.dumps(got, ensure_ascii=False))
if __name__ == "__main__":
    main()
