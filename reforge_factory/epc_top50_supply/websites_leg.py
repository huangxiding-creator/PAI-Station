# -*- coding: utf-8 -*-
"""腿2: 50强企业官网资料汇编 (engine=website, 纯HTTP零浏览器, Bing定位官网+栏目页爬取)."""
import io, json, re, subprocess, sys, time, html as H
from pathlib import Path
from urllib.parse import quote_plus, urljoin, urlparse
import urllib.request
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
REPO = Path(r"E:\AI-Station")
SUP = REPO / "reforge_factory" / "epc_top50_supply"
AMMO = REPO / "reforge_factory" / "ammo_pool.py"
STAGE = REPO / "ammo_pool" / "EPC-TOP50" / "staging" / "website" / time.strftime("%Y%m%d_%H%M%S")
STAGE.mkdir(parents=True, exist_ok=True)
LOG = SUP / "logs" / ("websites_%s.log" % time.strftime("%Y%m%d_%H%M%S"))
ROSTER = {
 "baju":"中建八局","cdyuan":"中国电建成都勘测设计研究院","ckz":"中城科泽工程设计集团",
 "cpcec":"中国石油工程建设有限公司","gonglu":"中交公路规划设计院","gxdy":"广西电力设计研究院",
 "gzgc":"中石化广州工程有限公司","huadong":"中国电建集团华东勘测设计研究院",
 "hualu":"华陆工程科技","huanqiu":"中国寰球工程","hunanyuan":"湖南省电力设计院",
 "jianerju":"中建二局","kmyuan":"中国电建昆明勘测设计研究院","lianhe":"中国联合工程",
 "liuju":"中建六局","mingyang":"明阳智慧能源集团","nanfang":"中冶南方工程技术",
 "qiche":"中国汽车工业工程有限公司","sanju":"中建三局","sdyuan":"山东电力工程咨询院",
 "shizheng":"市政设计研究总院","tianchen":"中国天辰工程","tiesi":"中铁第四勘察设计院",
 "wuhuan":"中国五环工程","wuju":"中建五局","zhongyi":"中亿国际设计集团",
 "zndianli":"中国能源建设集团中南电力设计院","znyuan":"中国电建集团中南勘测设计研究院",
}
BAD_HOST = ("baike.baidu","zhidao.baidu","weibo.","zhihu.com","qcc.com","tianyancha","sogou",
 "163.com","sohu.com","sina.","baidu.com","bing.com","qq.com","douyin","toutiao","wikipedia",
 "mohurd","gov.cn","enr.com","hkexnews","cninfo","eastmoney","10jqka","xueqiu")
ANCHOR_KW = re.compile(r"关于我们|公司简介|集团简介|企业简介|概况|总承包|主营业务|业务板块|业务领域|"
 r"工程业绩|经典工程|项目案例|业绩展示|新闻动态|新闻中心|公司新闻|行业动态")
UA = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/126 Safari/537.36"}
def fetch(url, timeout=15):
    req = urllib.request.Request(url, headers=UA)
    r = urllib.request.urlopen(req, timeout=timeout)
    ct = r.headers.get("Content-Type", "")
    raw = r.read(2_000_000)
    enc = "utf-8"
    m = re.search(rb"charset=([\w-]+)", raw[:2000])
    if m: enc = m.group(1).decode("ascii", "ignore")
    elif "gb2312" in ct.lower() or "gbk" in ct.lower(): enc = "gb18030"
    try: return raw.decode(enc, "replace")
    except Exception: return raw.decode("utf-8", "replace")
def bing_find_official(name):
    try:
        html = fetch("https://www.bing.com/search?q=" + quote_plus(name + " 官网"), 12)
    except Exception:
        return None, []
    items = re.findall(r'<h2><a[^>]+href="(http[^"]+)"[^>]*>(.*?)</a>', html)
    cands = []
    for u, t in items[:10]:
        t = re.sub(r"<[^>]+>", "", t)
        host = urlparse(u).netloc.lower()
        if any(b in host for b in BAD_HOST): continue
        cands.append((host, u, t))
    if not cands: return None, []
    return cands[0][0], cands
def html2text(html):
    html = re.sub(r"(?is)<(script|style|iframe|svg|noscript)[^>]*>.*?</\1>", " ", html)
    html = re.sub(r"(?is)<br\s*/?>|</p>|</div>|</li>|</tr>|</h[1-6]>", "\n", html)
    txt = re.sub(r"(?s)<[^>]+>", " ", html)
    txt = H.unescape(txt)
    txt = re.sub(r"[ \t\r\xa0]+", " ", txt)
    txt = re.sub(r"\n\s*\n+", "\n", txt)
    return txt.strip()
def crawl_company(key, name):
    host, cands = bing_find_official(name)
    if not host:
        return None, f"bing_no_official:{name}"
    # 首页
    pages = []
    try:
        idx = fetch(cands[0][1]); time.sleep(1.0)
    except Exception as e:
        return None, f"home_fail:{host}:{e}"
    home = ("https://" + host + "/")
    anchors = re.findall(r'<a[^>]+href="([^"#]+)"[^>]*>([^<]{2,40})</a>', idx)
    scored = []
    seen = set()
    for href, text in anchors:
        text = H.unescape(text.strip())
        if not ANCHOR_KW.search(text): continue
        full = urljoin(home, href)
        if urlparse(full).netloc and host not in full: continue
        p = urlparse(full).path.lower()
        if any(x in p for x in (".jpg", ".png", ".pdf", ".zip", ".rar", "javascript")): continue
        if full.rstrip("/") in seen: continue
        seen.add(full.rstrip("/")); scored.append((text, full))
    picked, pseen = [], set()
    for text, full in scored:
        sig = re.sub(r"\d+", "", urlparse(full).path)
        if sig in pseen: continue
        pseen.add(sig); picked.append((text, full))
        if len(picked) >= 4: break
    pages.append(("首页", home, html2text(idx)))
    for text, full in picked:
        try:
            ph = fetch(full); time.sleep(1.0)
            t = html2text(ph)
            if len(t) >= 500: pages.append((text, full, t))
        except Exception:
            continue
    total = sum(len(t) for _, _, t in pages)
    if total < 1500:
        return None, f"thin:{host}:{total}"
    return (host, pages), None
def ingest(md, url):
    cmd = ["py","-X","utf8",str(AMMO),"ingest","EPC-TOP50","--file",str(md),
           "--engine","website","--url",url,"--cred","official","--tree","Q17-E1"]
    r = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="replace")
    return r.returncode, ((r.stdout or "") + (r.stderr or ""))
def main():
    out = open(LOG, "a", encoding="utf-8")
    def emit(s): print(s, flush=True); out.write(s + "\n"); out.flush()
    tot = 0; totc = 0
    for key, name in ROSTER.items():
        try:
            res, err = crawl_company(key, name)
        except Exception as e:
            res, err = None, f"exc:{e}"
        if not res:
            emit(json.dumps({"ok": False, "key": key, "name": name, "why": err}, ensure_ascii=False)); continue
        host, pages = res
        md = STAGE / f"site_{key}.md"
        parts = [f"# {name}官网资料汇编——公司简介·工程总承包业务·工程业绩动态", "",
                 f"来源: 企业官网 {host} (engine=website, 逐页纯HTTP抓取, 正文零改动).",
                 f"campaign EPC-TOP50, tree Q17-E1, cred official. 收录页数: {len(pages)} (实测).", ""]
        for label, url, text in pages:
            parts.append(f"## {label} {url}"); parts.append(text); parts.append("")
        body = "\n".join(parts)
        md.write_text(body, encoding="utf-8")
        rc, msg = ingest(md, "https://" + host + "/")
        ok = rc == 0 and "硬拒" not in msg
        if ok: tot += 1; totc += len(body)
        emit(json.dumps({"ok": ok, "key": key, "name": name, "host": host,
            "pages": len(pages), "chars": len(body), "msg": msg.strip()[-140:]}, ensure_ascii=False))
    emit(json.dumps({"SUMMARY": True, "companies_ingested": tot, "chars_sum": totc}, ensure_ascii=False))
if __name__ == "__main__":
    main()
