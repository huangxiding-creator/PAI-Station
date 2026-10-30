# -*- coding: utf-8 -*-
"""腿1修正版: SSE股年报标题带公司名前缀(中国核建2025年年度报告)→标题正则放宽;
中钢国际被serp_shape误拒→极简头重入池(内容同一PDF缓存, 零重复计数: 跳过manifest已有)."""
import io, json, re, subprocess, sys, time
from pathlib import Path
from urllib.parse import urlencode
import urllib.request
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
REPO = Path(r"E:\AI-Station")
SUP = REPO / "reforge_factory" / "epc_top50_supply"
CACHE = SUP / "pdf_cache"; CACHE.mkdir(parents=True, exist_ok=True)
AMMO = REPO / "reforge_factory" / "ammo_pool.py"
STAGE = REPO / "ammo_pool" / "EPC-TOP50" / "staging" / "cninfo_com_cn" / (time.strftime("%Y%m%d_%H%M%S") + "_fix")
STAGE.mkdir(parents=True, exist_ok=True)
LOG = SUP / "logs" / ("cninfo_ext_%s.log" % time.strftime("%Y%m%d_%H%M%S"))
VEHICLES = ["中国电建","中国能建","中国化学","中国中冶","中国铁建","中国交建","中国建筑",
"中国石油","中国石化","中材国际","明阳智能","中国核建","中国中铁","中材节能",
"上海建工","隧道股份","四川路桥","江河集团","精工钢构","安徽建工","中钢国际"]
HDRS = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)", "Referer": "http://www.cninfo.com.cn/"}
def http(url, data=None, headers=None, timeout=60):
    req = urllib.request.Request(url, data=data, headers={**HDRS, **(headers or {})})
    return urllib.request.urlopen(req, timeout=timeout)
def already_ingested():
    have = set()
    mf = REPO / "ammo_pool" / "EPC-TOP50" / "manifest.jsonl"
    for line in mf.read_text(encoding="utf-8", errors="replace").splitlines():
        try: d = json.loads(line)
        except Exception: continue
        if d.get("engine") == "cninfo_com_cn":
            import os
            b = os.path.basename(d.get("source_path") or "")
            m = re.match(r"(\d{6})_(\d{4})_annual\.md$", b)
            if m: have.add((m.group(1), m.group(2)))
    return have
def resolve_stocks():
    raw = http("http://www.cninfo.com.cn/new/data/szse_stock.json").read().decode("utf-8")
    m = {}
    for s in json.loads(raw).get("stockList", []):
        m.setdefault(s.get("zwjc", ""), (s.get("code"), s.get("orgId")))
    return m
def query_annuals(code, orgid):
    body = urlencode({"pageNum":"1","pageSize":"30","column":"szse","tabName":"fulltext",
        "plate":"","stock":f"{code},{orgid}","searchkey":"","secid":"",
        "category":"category_ndbg_szsh","trade":"","seDate":"2024-01-01~2024-12-31"}).encode()
    r = http("http://www.cninfo.com.cn/new/hisAnnouncement/query", data=body,
             headers={"Content-Type":"application/x-www-form-urlencoded"})
    return json.loads(r.read().decode("utf-8")).get("announcements") or []
def pick_reports(anns):
    best = {}
    for a in anns:
        t = (a.get("announcementTitle") or "").replace("<em>","").replace("</em>","")
        if any(x in t for x in ["摘要","英文","已取消","取消","提示性","说明","的公告"]): continue
        m = re.search(r"(20\d{2})\s*年\s*年\s*度\s*报\s*告", t)
        if not m: continue
        fy = m.group(1); ts = a.get("announcementTime") or 0
        if fy not in best or ts > best[fy][0]:
            best[fy] = (ts, t, a.get("adjunctUrl") or "", a.get("secName") or "")
    return [(fy, v[1], v[2], v[3]) for fy, v in sorted(best.items(), reverse=True)[:1]]
def pdf_text(pdf_path):
    import fitz
    doc = fitz.open(pdf_path); parts = [p.get_text() for p in doc]; n = doc.page_count; doc.close()
    return n, "\n".join(parts)
def main():
    out = open(LOG, "a", encoding="utf-8")
    def emit(line): print(line, flush=True); out.write(line + "\n"); out.flush()
    stocks = resolve_stocks(); have = already_ingested()
    emit("already_ingested=" + str(sorted(have)))
    tot = 0; totc = 0
    for name in VEHICLES:
        hit = stocks.get(name)
        if not hit:
            emit(json.dumps({"ok": False, "name": name, "why": "no_listed_match"}, ensure_ascii=False)); continue
        code, orgid = hit
        try: anns = query_annuals(code, orgid)
        except Exception as e:
            emit(json.dumps({"ok": False, "name": name, "why": f"query_fail:{e}"}, ensure_ascii=False)); continue
        time.sleep(1.2)
        for fy, title, adjunct, secname in pick_reports(anns):
            if (code, fy) in have:
                emit(json.dumps({"skip": "already_in_pool", "name": name, "fy": fy}, ensure_ascii=False)); continue
            if not adjunct:
                emit(json.dumps({"ok": False, "name": name, "fy": fy, "why": "no_pdf"}, ensure_ascii=False)); continue
            url = "http://static.cninfo.com.cn/" + adjunct
            pdf = CACHE / f"{code}_{fy}.pdf"
            try:
                if not pdf.exists() or pdf.stat().st_size < 10000:
                    pdf.write_bytes(http(url).read())
                pages, text = pdf_text(pdf)
            except Exception as e:
                emit(json.dumps({"ok": False, "name": name, "fy": fy, "why": f"pdf_fail:{e}"}, ensure_ascii=False)); time.sleep(1.2); continue
            text = re.sub(r"\n{3,}", "\n\n", text)
            if len(text) < 8000:
                emit(json.dumps({"ok": False, "name": name, "fy": fy, "why": f"thin:{len(text)}"}, ensure_ascii=False)); continue
            md = STAGE / f"{code}_{fy}_annual.md"
            head = (f"# {secname}{fy}年年度报告全文——经营分析与工程总承包业务\n\n"
                f"来源巨潮资讯网（cninfo.com.cn，engine=cninfo_com_cn）。公司：{secname}，代码：{code}，"
                f"公告：{title}。实测页数{pages}，PyMuPDF全文提取，数字零手填。"
                f"campaign EPC-TOP50，tree Q17-E1，cred official。原文链接：{url}\n\n")
            md.write_text(head + text, encoding="utf-8")
            cmd = ["py","-X","utf8",str(AMMO),"ingest","EPC-TOP50","--file",str(md),
                   "--engine","cninfo_com_cn","--url",url,"--cred","official","--tree","Q17-E1"]
            r = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="replace")
            ok = (r.returncode == 0) and ("硬拒" not in (r.stdout or ""))
            if ok: tot += 1; totc += len(text)
            emit(json.dumps({"ok": ok, "name": name, "code": code, "fy": fy, "pages": pages,
                "chars": len(text), "msg": ((r.stdout or "")+(r.stderr or "")).strip()[-150:]}, ensure_ascii=False))
            time.sleep(1.2)
    emit(json.dumps({"SUMMARY": True, "ingested": tot, "chars_sum": totc}, ensure_ascii=False))
if __name__ == "__main__":
    main()
