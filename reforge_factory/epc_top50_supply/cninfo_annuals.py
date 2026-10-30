# -*- coding: utf-8 -*-
"""EPC-TOP50 T1 定向补采·腿1: 巨潮资讯网上市公司年报全文 (engine=cninfo_com_cn).
纪律: 数字零造假 (chars/页数全部实测), 纯HTTP零浏览器, 节流1.2s, 只增不删.
流程: szse_stock.json解析code/orgId → hisAnnouncement/query年报清单 →
static.cninfo PDF下载 → PyMuPDF全文提取 → 散文md → ammo_pool ingest.
"""
import io, json, re, subprocess, sys, time
from pathlib import Path
from urllib.parse import urlencode
import urllib.request
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
REPO = Path(r"E:\AI-Station")
SUP = REPO / "reforge_factory" / "epc_top50_supply"
CACHE = SUP / "pdf_cache"
AMMO = REPO / "reforge_factory" / "ammo_pool.py"
STAGE = REPO / "ammo_pool" / "EPC-TOP50" / "staging" / "cninfo_com_cn" / time.strftime("%Y%m%d_%H%M%S")
CACHE.mkdir(parents=True, exist_ok=True); STAGE.mkdir(parents=True, exist_ok=True)
LOG = SUP / "logs" / ("cninfo_%s.log" % time.strftime("%Y%m%d_%H%M%S"))
# 上市载体 (TOP50 roster 对应上市主体 + 任务书点名: 华东院/中材国际/中冶系/中国电建等)
VEHICLES = ["中国电建","中国能建","中国化学","中国中冶","中国铁建","中国交建","中国建筑",
"中国石油","中国石化","中材国际","中钢国际","明阳智能","中国核建","中国中铁",
"东华科技","中工国际","北方国际","中国海诚","中材节能","上海建工","隧道股份",
"四川路桥","江河集团","精工钢构","山东路桥","安徽建工"]
FY_KEEP = 2
HDRS = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)",
        "Referer": "http://www.cninfo.com.cn/"}
def http(url, data=None, headers=None, timeout=40):
    req = urllib.request.Request(url, data=data, headers={**HDRS, **(headers or {})})
    return urllib.request.urlopen(req, timeout=timeout)
def resolve_stocks():
    raw = http("http://www.cninfo.com.cn/new/data/szse_stock.json").read().decode("utf-8")
    lst = json.loads(raw).get("stockList", [])
    m = {}
    for s in lst:
        m.setdefault(s.get("zwjc", ""), (s.get("code"), s.get("orgId")))
    return m
def query_annuals(code, orgid):
    col = "sse" if str(code).startswith(("6", "9")) else "szse"
    body = urlencode({"pageNum":"1","pageSize":"30","column":col,"tabName":"fulltext",
        "plate":"","stock":f"{code},{orgid}","searchkey":"","secid":"","category":
        "category_ndbg_szsh","trade":"","seDate":"2025-01-01~2026-10-28"}).encode()
    r = http("http://www.cninfo.com.cn/new/hisAnnouncement/query", data=body,
             headers={"Content-Type":"application/x-www-form-urlencoded",
                      "Referer":"http://www.cninfo.com.cn/new/commonUrl/pageOfSearch?url=disclosure/list/company"})
    return json.loads(r.read().decode("utf-8")).get("announcements") or []
def pick_reports(anns):
    best = {}
    for a in anns:
        t = (a.get("announcementTitle") or "").replace("<em>","").replace("</em>","")
        if "年度报告" not in t: continue
        if any(x in t for x in ["摘要","英文","已取消","取消","提示性","披露","公告》"]): continue
        m = re.match(r"^(\d{4})年年度报告", t)
        if not m: continue
        fy = m.group(1)
        ts = a.get("announcementTime") or 0
        if fy not in best or ts > best[fy][0]:
            best[fy] = (ts, t, a.get("adjunctUrl") or "", a.get("secName") or "")
    return [(fy, v[1], v[2], v[3]) for fy, v in sorted(best.items(), reverse=True)[:FY_KEEP]]
def pdf_text(pdf_path):
    import fitz
    doc = fitz.open(pdf_path)
    parts = [p.get_text() for p in doc]
    n = doc.page_count; doc.close()
    return n, "\n".join(parts)
def ingest(md, url):
    cmd = ["py","-X","utf8",str(AMMO),"ingest","EPC-TOP50","--file",str(md),
           "--engine","cninfo_com_cn","--url",url,"--cred","official","--tree","Q17-E1"]
    r = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="replace")
    return r.returncode, (r.stdout or "") + (r.stderr or "")
def main():
    out = open(LOG, "a", encoding="utf-8")
    def emit(line):
        print(line, flush=True); out.write(line + "\n"); out.flush()
    stocks = resolve_stocks()
    total_chars = 0; total_ing = 0; fails = []
    for name in VEHICLES:
        hit = stocks.get(name)
        if not hit:
            emit(json.dumps({"ok": False, "name": name, "why": "no_listed_match"}, ensure_ascii=False)); continue
        code, orgid = hit
        try:
            anns = query_annuals(code, orgid)
        except Exception as e:
            emit(json.dumps({"ok": False, "name": name, "why": f"query_fail:{e}"}, ensure_ascii=False)); continue
        reports = pick_reports(anns)
        time.sleep(1.2)
        if not reports:
            emit(json.dumps({"ok": False, "name": name, "code": code, "why": "no_annual_found"}, ensure_ascii=False)); continue
        for fy, title, adjunct, secname in reports:
            if not adjunct:
                fails.append((name, fy, "no_pdf")); continue
            url = "http://static.cninfo.com.cn/" + adjunct
            pdf = CACHE / f"{code}_{fy}.pdf"
            try:
                if not pdf.exists() or pdf.stat().st_size < 10000:
                    pdf.write_bytes(http(url).read())
                pages, text = pdf_text(pdf)
            except Exception as e:
                emit(json.dumps({"ok": False, "name": name, "fy": fy, "why": f"pdf_fail:{e}"}, ensure_ascii=False))
                fails.append((name, fy, str(e))); time.sleep(1.2); continue
            text = re.sub(r"\n{3,}", "\n\n", text)
            if len(text) < 8000:
                emit(json.dumps({"ok": False, "name": name, "fy": fy, "why": f"thin_text:{len(text)}"}, ensure_ascii=False))
                fails.append((name, fy, "thin")); time.sleep(1.2); continue
            md = STAGE / f"{code}_{fy}_annual.md"
            head = (f"# {secname}{fy}年年度报告全文——经营分析与工程总承包业务\n\n"
                f"- 来源: 巨潮资讯网 cninfo.com.cn (engine=cninfo_com_cn)\n"
                f"- 公司: {secname}  代码: {code}\n- 公告标题: {title}\n"
                f"- PDF: {url}\n- 实测页数: {pages}  提取: PyMuPDF全文 (零手填)\n"
                f"- campaign: EPC-TOP50  tree: Q17-E1  cred: official\n\n---\n\n")
            md.write_text(head + text, encoding="utf-8")
            rc, so = ingest(md, url)
            ing = rc == 0
            if ing: total_ing += 1; total_chars += len(text)
            emit(json.dumps({"ok": ing, "name": name, "code": code, "fy": fy,
                "pages": pages, "chars": len(text), "rc": rc, "msg": so.strip()[-160:]}, ensure_ascii=False))
            time.sleep(1.2)
    emit(json.dumps({"SUMMARY": True, "vehicles": len(VEHICLES), "ingested": total_ing,
        "chars_sum": total_chars, "fails": len(fails), "fail_list": [list(x) for x in fails[:12]]}, ensure_ascii=False))
if __name__ == "__main__":
    main()
