# -*- coding: utf-8 -*-
"""腿5: 商会复刻件翻栏目 (engine=chinca, 纯HTTP+WAF本地解题)."""
import io, json, re, subprocess, sys, time, html as H
from pathlib import Path
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\逆向工程\chinca-reverse\replica")
import chinca_api
REPO = Path(r"E:\AI-Station")
AMMO = REPO / "reforge_factory" / "ammo_pool.py"
STAGE = REPO / "ammo_pool" / "EPC-TOP50" / "staging" / "chinca" / time.strftime("%Y%m%d_%H%M%S")
STAGE.mkdir(parents=True, exist_ok=True)
LOG = (REPO / "reforge_factory" / "epc_top50_supply" / "logs" / ("chinca_%s.log" % time.strftime("%Y%m%d_%H%M%S")))
TOKENS = ["中建八局","中建二局","中建三局","中建五局","中建六局","成都勘测设计研究院","华东勘测设计研究院",
"昆明勘测设计研究院","中南勘测设计研究院","中南电力设计院","长江设计","中城科泽","中国石油工程建设",
"中交公路规划设计院","广西电力设计研究院","广州工程","华陆","中国寰球","湖南省建筑设计院","上海市政工程设计",
"中国联合工程","明阳","中冶南方","汽车工业工程","山东电力工程咨询院","中国天辰","中铁第四勘察设计院",
"中国五环","中亿国际","中材国际","中国电建","中国能建","中国化学","中国中冶","中国铁建","中国交建",
"中国建筑","中国石油","中国石化","中钢国际","中国核建","工程总承包"]
KEEP_COLS = {"member": 3, "notice": 3, "research": 4, "intl": 3, "stats": 3, "industry": 2}
def html2text(html):
    if not html: return ""
    h = re.sub(r"(?is)<(script|style|iframe|noscript)[^>]*>.*?</\1>", " ", html)
    h = re.sub(r"(?is)<br\s*/?>|</p>|</div>|</li>|</tr>|</h[1-6]>", "\n", h)
    t = re.sub(r"(?s)<[^>]+>", " ", h); t = H.unescape(t)
    t = re.sub(r"[ \t\r\xa0]+", " ", t); return re.sub(r"\n\s*\n+", "\n", t).strip()
def ingest(md, url):
    cmd = ["py","-X","utf8",str(AMMO),"ingest","EPC-TOP50","--file",str(md),
           "--engine","chinca","--url",url,"--cred","official","--tree","Q17-E1"]
    r = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="replace")
    return r.returncode, ((r.stdout or "") + (r.stderr or ""))
def main():
    out = open(LOG, "a", encoding="utf-8")
    def emit(s): print(s, flush=True); out.write(s + "\n"); out.flush()
    cli = chinca_api.ChincaClient()
    tot = 0; totc = 0; seen = set()
    for col, maxp in KEEP_COLS.items():
        page = 1
        while page <= maxp:
            try:
                items, pages = cli.list_column(column=col, page=page, limit=None)
            except Exception as e:
                emit(json.dumps({"ok": False, "col": col, "page": page, "why": f"list_fail:{e}"}, ensure_ascii=False)); break
            emit(f"[col {col} p{page}] items={len(items or [])} pages={pages}")
            for it in (items or []):
                url = it.get("url") or ""; title = it.get("title") or ""
                if not url or url in seen: continue
                seen.add(url)
                try:
                    art = cli.get_article(url)
                except Exception as e:
                    emit(json.dumps({"ok": False, "col": col, "url": url, "why": f"art_fail:{e}"}, ensure_ascii=False)); time.sleep(1.2); continue
                body_raw = art.get("content") or art.get("text") or art.get("html") or ""
                text = html2text(body_raw) if ("<" in body_raw[:200]) else (body_raw or "").strip()
                title = art.get("title") or title
                hit_toks = [t for t in TOKENS if t in title or t in text[:6000]]
                if col in ("member", "notice") and not hit_toks:
                    time.sleep(1.0); continue
                if len(text) < 500:
                    time.sleep(1.0); continue
                md = STAGE / (re.sub(r"\W+", "_", title)[:50] + ".md")
                head = (f"# {title}（{col}栏目·中国对外承包工程商会）\n\n"
                        f"来源: chinca.org {col} 栏目 (engine=chinca, 纯HTTP复刻件抓取, 正文零改动).\n"
                        f"日期: {art.get('date','')}  URL: {url}\n"
                        f"campaign EPC-TOP50, tree Q17-E1, cred official. 命中词: {'/'.join(hit_toks[:6])}\n\n---\n\n")
                md.write_text(head + text, encoding="utf-8")
                rc, msg = ingest(md, url)
                ok = rc == 0 and "硬拒" not in msg
                if ok: tot += 1; totc += len(text)
                emit(json.dumps({"ok": ok, "col": col, "title": title[:40], "chars": len(text),
                                 "msg": msg.strip()[-120:]}, ensure_ascii=False))
                time.sleep(1.2)
            page += 1; time.sleep(1.5)
    emit(json.dumps({"SUMMARY": True, "ingested": tot, "chars_sum": totc, "seen_urls": len(seen)}, ensure_ascii=False))
if __name__ == "__main__":
    main()
