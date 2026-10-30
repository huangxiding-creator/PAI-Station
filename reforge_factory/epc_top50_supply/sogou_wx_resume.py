# -*- coding: utf-8 -*-
"""腿6: 搜狗微信复刻件 - 50强企业公众号总承包业务文章 (engine=sogou_wechat)."""
import io, json, re, subprocess, sys, time
from pathlib import Path
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
REPO = Path(r"E:\AI-Station")
REPLICA = r"E:\AI-Station\逆向工程\sogou-weixin-reverse\replica\sogou_weixin_api.py"
AMMO = REPO / "reforge_factory" / "ammo_pool.py"
STAGE = REPO / "ammo_pool" / "EPC-TOP50" / "staging" / "sogou_wechat" / time.strftime("%Y%m%d_%H%M%S")
STAGE.mkdir(parents=True, exist_ok=True)
LOG = REPO / "reforge_factory" / "epc_top50_supply" / "logs" / ("sogouwx2_%s.log" % time.strftime("%Y%m%d_%H%M%S"))
REMAIN = True
QUERIES = [
 ("中建八局","工程总承包"),("成都勘测设计研究院","总承包"),("华东勘测设计研究院","总承包"),
 ("昆明勘测设计研究院","总承包"),("中南勘测设计研究院","总承包"),("中南电力设计院","总承包"),
 ("长江设计集团","总承包"),("中城科泽","总承包"),("中国石油工程建设","EPC"),("中交公路规划设计院","总承包"),
 ("广西电力设计研究院","总承包"),("中石化广州工程","总承包"),("华陆工程","总承包"),("中国寰球","EPC"),
 ("湖南省建筑设计院","总承包"),("上海市政工程设计研究总院","总承包"),("中建二局","工程总承包"),
 ("中建三局","工程总承包"),("中建五局","工程总承包"),("中建六局","工程总承包"),("中国联合工程","总承包"),
 ("明阳智能","EPC"),("中冶南方","总承包"),("中国汽车工业工程","总承包"),("山东电力工程咨询院","总承包"),
 ("中国天辰","总承包"),("铁四院","总承包"),("中国五环","总承包"),("中亿国际","总承包"),
 ("中材国际","工程总承包"),("中国电建","工程总承包"),("中国能建","工程总承包"),("中国化学","工程总承包"),
 ("中国中冶","工程总承包"),("中国铁建","工程总承包"),("中国交建","工程总承包"),("中国建筑","工程总承包"),
 ("中钢国际","工程总承包"),("中国核建","工程总承包"),
]
def run_query(name, kw, top=3):
    cmd = ["py","-X","utf8",REPLICA,name,kw,"--top",str(top),"--json"]
    r = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="replace", timeout=300)
    so = (r.stdout or "").strip()
    i = so.find("{")
    if i < 0:
        return None, f"no_json:{so[-120:]}|{(r.stderr or '')[-120:]}"
    try:
        return json.loads(so[i:]), None
    except Exception as e:
        return None, f"json_fail:{e}"
def ingest(md, url):
    cmd = ["py","-X","utf8",str(AMMO),"ingest","EPC-TOP50","--file",str(md),
           "--engine","sogou_wechat","--url",url,"--cred","media","--tree","Q17-E1"]
    r = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="replace")
    return r.returncode, ((r.stdout or "") + (r.stderr or ""))
def main():
    out = open(LOG, "a", encoding="utf-8")
    def emit(s): print(s, flush=True); out.write(s + "\n"); out.flush()
    tot = 0; totc = 0; blocked = 0
    for name, kw in QUERIES:
        data, err = run_query(name, kw)
        if data is None:
            emit(json.dumps({"ok": False, "q": name+" "+kw, "why": err}, ensure_ascii=False))
            if "antispider" in err or "Blocked" in err or "blocked" in err:
                blocked += 1; time.sleep(300)
                if blocked >= 3: emit(json.dumps({"abort": "3x_blocked"}, ensure_ascii=False)); break
            time.sleep(8); continue
        arts = data.get("full") or data.get("articles") or []
        if not arts and data.get("hits"):
            emit(json.dumps({"info": "list_only", "q": name, "hits": len(data["hits"])}, ensure_ascii=False))
        n = 0
        for a in arts[:3]:
            text = (a.get("text") or a.get("content") or "").strip()
            title = (a.get("title") or "").strip() or f"{name}微信文章"
            if len(text) < 800: continue
            md = STAGE / (re.sub(r"\W+", "_", title)[:60] + ".md")
            head = (f"# {title}——{name}工程总承包业务公众号文章\n\n"
                f"来源: 微信公众号 {a.get('account','')} (搜狗微信检索, engine=sogou_wechat, 纯HTTP复刻件).\n"
                f"发布: {a.get('publish_time','')}  链接: {a.get('url','')}\n"
                f"campaign EPC-TOP50, tree Q17-E1, cred media. 正文零改动, 实测{len(text)}字.\n\n---\n\n")
            md.write_text(head + text, encoding="utf-8")
            rc, msg = ingest(md, a.get("url", ""))
            ok = rc == 0 and "硬拒" not in msg
            if ok: tot += 1; totc += len(text); n += 1
            emit(json.dumps({"ok": ok, "q": name, "title": title[:40], "chars": len(text),
                             "msg": msg.strip()[-110:]}, ensure_ascii=False))
        time.sleep(6)
    emit(json.dumps({"SUMMARY": True, "ingested": tot, "chars_sum": totc, "blocked": blocked}, ensure_ascii=False))
if __name__ == "__main__":
    main()
