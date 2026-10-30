# -*- coding: utf-8 -*-
"""腿2v2: 官网定向核验版 — 候选域名逐个试, 首页正文必须含公司核名词才采用 (零臆测)."""
import io, json, re, subprocess, sys, time, html as H
from pathlib import Path
from urllib.parse import urljoin, urlparse
import urllib.request
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
REPO = Path(r"E:\AI-Station")
AMMO = REPO / "reforge_factory" / "ammo_pool.py"
STAGE = REPO / "ammo_pool" / "EPC-TOP50" / "staging" / "website" / (time.strftime("%Y%m%d_%H%M%S") + "_v2")
STAGE.mkdir(parents=True, exist_ok=True)
LOG = REPO / "reforge_factory" / "epc_top50_supply" / "logs" / ("websites_v2_%s.log" % time.strftime("%Y%m%d_%H%M%S"))
# key: (公司名, 核名词[首页必含], 候选域列表)
CANDS = {
 "huadong": ("中国电建集团华东勘测设计研究院", ["华东勘测设计研究院","华东院"], ["www.ecidi.com","ecidi.com"]),
 "cdyuan": ("中国电建集团成都勘测设计研究院", ["成都勘测设计研究院","成都院"], ["www.hidro.cn","hidro.cn"]),
 "kmyuan": ("中国电建集团昆明勘测设计研究院", ["昆明勘测设计研究院","昆明院"], ["www.khidi.cn"]),
 "znyuan": ("中南勘测设计研究院", ["中南勘测设计研究院","中南院"], ["www.zsjy.com"]),
 "zndianli": ("中国能源建设集团中南电力设计院", ["中南电力设计院"], ["www.csepdi.com","csepdi.com"]),
 "tiesi": ("中铁第四勘察设计院", ["第四勘察设计院","铁四院"], ["www.crfsdi.com","crfsdi.com"]),
 "tianchen": ("中国天辰工程有限公司", ["天辰"], ["www.cntcc.cn","cntcc.cn"]),
 "huanqiu": ("中国寰球工程有限公司", ["寰球"], ["hqcec.cnpc.com.cn","www.hqcec.com"]),
 "wuhuan": ("中国五环工程有限公司", ["五环"], ["www.cwce.com.cn","cwce.com.cn"]),
 "hualu": ("华陆工程科技集团有限公司", ["华陆"], ["www.hlcec.com","www.hualu.com.cn"]),
 "gonglu": ("中交公路规划设计院", ["公路规划设计院","公规院"], ["www.hpdi.com.cn","hpdi.com.cn"]),
 "cpcec": ("中国石油工程建设有限公司", ["工程建设有限公司","CPECC"], ["cpecc.cnpc.com.cn","www.cpecc.com.cn"]),
 "nanfang": ("中冶南方工程技术有限公司", ["中冶南方","WISDRI"], ["www.wisdri.com","wisdri.com"]),
 "shizheng": ("上海市政工程设计研究总院", ["市政工程设计研究总院","SMEDI"], ["www.smedi.com","smedi.com"]),
 "hunanyuan": ("湖南省建筑设计院", ["湖南省建筑设计院"], ["www.hnsjy.com"]),
 "sdyuan": ("山东电力工程咨询院", ["山东电力工程咨询院"], ["www.sdepci.com"]),
 "lianhe": ("中国联合工程有限公司", ["中国联合工程"], ["www.chinacuc.com"]),
 "qiche": ("中国汽车工业工程有限公司", ["汽车工业工程"], ["www.caechina.com"]),
 "gzgc": ("中石化广州工程有限公司", ["广州工程"], ["gzecc.sei.com.cn","www.gzecc.com"]),
 "mingyang": ("明阳智慧能源集团", ["明阳"], ["www.myse.com.cn","myse.com.cn"]),
 "ckz": ("中城科泽工程设计集团", ["中城科泽"], ["www.zckz.com.cn"]),
 "gxdy": ("广西电力设计研究院", ["广西电力设计研究院","广西院"], ["www.gxedi.com.cn"]),
 "sanju": ("中建三局", ["三局"], ["3bur.cscec.com"]),
 "jianerju": ("中建二局", ["二局"], ["2bur.cscec.com"]),
}
UA = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/126 Safari/537.36"}
def fetch(url, timeout=15):
    req = urllib.request.Request(url, headers=UA)
    r = urllib.request.urlopen(req, timeout=timeout)
    raw = r.read(2_000_000)
    enc = "utf-8"
    m = re.search(rb"charset=([\w-]+)", raw[:2000])
    if m: enc = m.group(1).decode("ascii", "ignore")
    elif "gb2312" in (r.headers.get("Content-Type") or "").lower(): enc = "gb18030"
    try: return raw.decode(enc, "replace")
    except Exception: return raw.decode("utf-8", "replace")
def html2text(html):
    h = re.sub(r"(?is)<(script|style|iframe|svg|noscript)[^>]*>.*?</\1>", " ", html)
    h = re.sub(r"(?is)<br\s*/?>|</p>|</div>|</li>|</tr>|</h[1-6]>", "\n", h)
    t = re.sub(r"(?s)<[^>]+>", " ", h); t = H.unescape(t)
    t = re.sub(r"[ \t\r\xa0]+", " ", t); return re.sub(r"\n\s*\n+", "\n", t).strip()
ANCHOR_KW = re.compile(r"关于我们|公司简介|集团简介|企业简介|概况|总承包|主营业务|业务板块|业务领域|工程业绩|经典工程|项目案例|业绩展示|新闻动态|新闻中心|公司新闻|行业动态")
def try_home(dom):
    for scheme in ("https://", "http://"):
        try:
            h = fetch(scheme + dom, 12); time.sleep(0.8)
            return h
        except Exception:
            continue
    return None
def crawl(key, name, verify, doms):
    for dom in doms:
        h = try_home(dom)
        if not h: continue
        plain = re.sub(r"\s+", "", html2text(h))[:20000]
        if not any(v in plain for v in verify):
            continue
        home = "https://" + dom + "/"
        anchors = re.findall(r'<a[^>]+href="([^"#]+)"[^>]*>([^<]{2,40})</a>', h)
        scored, seen = [], set()
        for href, text in anchors:
            text = H.unescape(text.strip())
            if not ANCHOR_KW.search(text): continue
            full = urljoin(home, href)
            p = urlparse(full).path.lower()
            if any(x in p for x in (".jpg",".png",".pdf",".zip",".rar","javascript")): continue
            if full.rstrip("/") in seen: continue
            seen.add(full.rstrip("/")); scored.append((text, full))
        picked, pseen = [], set()
        for text, full in scored:
            sig = re.sub(r"\d+", "", urlparse(full).path)
            if sig in pseen: continue
            pseen.add(sig); picked.append((text, full))
            if len(picked) >= 4: break
        pages = [("首页", home, html2text(h))]
        for text, full in picked:
            try:
                t = html2text(fetch(full)); time.sleep(0.8)
                if len(t) >= 500: pages.append((text, full, t))
            except Exception:
                continue
        total = sum(len(t) for _, _, t in pages)
        if total < 1500: return None, f"thin:{dom}:{total}"
        return (dom, pages), None
    return None, "no_verified_domain"
def ingest(md, url):
    cmd = ["py","-X","utf8",str(AMMO),"ingest","EPC-TOP50","--file",str(md),
           "--engine","website","--url",url,"--cred","official","--tree","Q17-E1"]
    r = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="replace")
    return r.returncode, ((r.stdout or "") + (r.stderr or ""))
def main():
    out = open(LOG, "a", encoding="utf-8")
    def emit(s): print(s, flush=True); out.write(s + "\n"); out.flush()
    tot = 0; totc = 0
    for key, (name, verify, doms) in CANDS.items():
        try: res, err = crawl(key, name, verify, doms)
        except Exception as e: res, err = None, f"exc:{e}"
        if not res:
            emit(json.dumps({"ok": False, "key": key, "name": name, "why": err}, ensure_ascii=False)); continue
        dom, pages = res
        md = STAGE / f"site_{key}.md"
        parts = [f"# {name}官网资料汇编——公司简介·工程总承包业务·工程业绩动态", "",
                 f"来源: 企业官网 {dom} (engine=website, 域名经首页正文含公司核名词实证, 逐页纯HTTP抓取, 正文零改动).",
                 f"campaign EPC-TOP50, tree Q17-E1, cred official. 收录页数: {len(pages)} (实测).", ""]
        for label, url, text in pages:
            parts.append(f"## {label} {url}"); parts.append(text); parts.append("")
        body = "\n".join(parts); md.write_text(body, encoding="utf-8")
        rc, msg = ingest(md, "https://" + dom + "/")
        ok = rc == 0 and "硬拒" not in msg
        if ok: tot += 1; totc += len(body)
        emit(json.dumps({"ok": ok, "key": key, "name": name, "host": dom,
            "pages": len(pages), "chars": len(body), "msg": msg.strip()[-130:]}, ensure_ascii=False))
    emit(json.dumps({"SUMMARY": True, "ingested": tot, "chars_sum": totc}, ensure_ascii=False))
if __name__ == "__main__":
    main()
