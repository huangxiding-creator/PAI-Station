# -*- coding: utf-8 -*-
"""EPC-JIAGE 缺口定向收尾腿 — E3 权威判例槽 (court:anysearch) + Q2-E2 反证全文腿 (anysearch:web).
背景: 饱和门 61/78 (78.2%), 目标 63+. Q2-E2 需非 mp.weixin 域 +1; Q16-E3/Q19-E3 各需新域 +1;
Q18-E3 零源需 2 域 2 件; Q14-E3 加源. 纪律: 全文>=600字才收, 薄页如实skip; 域去重(同EEI不同host);
E3 stance=support(权威口径既定约定), E2 stance=against; 零造假."""
import json, re, sys, time, hashlib
from pathlib import Path
from urllib.parse import urlparse

sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng\EPC100")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from collectors.anysearch.client import AnySearchClient  # noqa: E402

STAGE_C = Path(r"E:\AI-Station\ammo_pool\EPC-JIAGE\staging\court_anysearch")
STAGE_W = Path(r"E:\AI-Station\ammo_pool\EPC-JIAGE\staging\anysearch_web")
MAP = Path(r"E:\AI-Station\ammo_pool\EPC-JIAGE\staging\_driver\map_court_e3.jsonl")

# (eei, engine_tag, stance, query, 排除host) — 排除host=已占用该EEI饱和名额的域
USED_HOST = {"Q16-E3": {"court.gov.cn"}, "Q19-E3": {"gongbao.court.gov.cn"},
             "Q14-E3": {"www.gov.cn"}, "Q2-E2": {"mp.weixin.qq.com"}}
PLAN = [
    ("Q16-E3", "court:anysearch", "support", "建设工程 合同解除 已完工程 价款 结算 判决"),
    ("Q16-E3", "court:anysearch", "support", "建设工程合同解除 损失赔偿 典型案例 裁判"),
    ("Q19-E3", "court:anysearch", "support", "最高法 建设工程 造价 纠纷 典型案例"),
    ("Q19-E3", "court:anysearch", "support", "工程造价 争议 裁判规则 判决书"),
    ("Q18-E3", "court:anysearch", "support", "建设工程施工合同司法解释 计价 条款"),
    ("Q18-E3", "court:anysearch", "support", "建工司法解释 计价依据 争议 条文"),
    ("Q14-E3", "court:anysearch", "support", "工程签证 计价 规则 规定"),
    ("Q2-E2",  "anysearch:web",   "against", "工程造价咨询 资质取消 乱象 恶性竞争"),
]
AUTH_RE = re.compile(r"判决|裁定|司法解释|典型案例|裁判|解释|办法|规定|规则|通知|公报|案例|结算")
DOM_RE = re.compile(r"造价|计价|结算|工程|定额|单价|签证|价差|报价|合同|纠纷")
AGN_RE = re.compile(r"乱象|恶性竞争|低价|问题|监管|取消|挂靠|竞争")
PER_EEI = {"Q16-E3": 2, "Q19-E3": 2, "Q18-E3": 2, "Q14-E3": 1, "Q2-E2": 2}

def slugify(t, n=28):
    return re.sub(r"[^\w一-鿿]+", "_", t).strip("_")[:n] or "doc"

def host(u):
    try: return urlparse(u).netloc.lower()
    except Exception: return ""

def main():
    cli = AnySearchClient()
    STAGE_C.mkdir(parents=True, exist_ok=True); STAGE_W.mkdir(parents=True, exist_ok=True)
    mf = open(MAP, "a", encoding="utf-8")
    got, hosts = {}, {}
    for eei, eng, stance, q in PLAN:
        if got.get(eei, 0) >= PER_EEI[eei]: continue
        try:
            resp = cli.search(q) or {}
            res = ((resp.get("data") or {}).get("results")) or []
        except Exception as e:
            print(f"[search-fail] '{q}': {str(e)[:70]}", file=sys.stderr); continue
        picked = 0
        for it in res:
            if got.get(eei, 0) + picked >= PER_EEI[eei]: break
            if not isinstance(it, dict): continue
            title = str(it.get("title") or it.get("name") or "").strip()
            url = str(it.get("url") or it.get("link") or "").strip()
            if not title or not url.startswith("http"): continue
            h = host(url)
            if not h or h in USED_HOST.get(eei, set()) or h in hosts.get(eei, set()): continue
            if not DOM_RE.search(title): continue
            if eei == "Q2-E2":
                if not AGN_RE.search(title): continue
            else:
                if not AUTH_RE.search(title): continue
            content = ""
            try:
                ex = cli.extract(url) or {}
                content = str(((ex.get("data") or {}).get("content")) or ex.get("content") or "")
            except Exception:
                pass
            if len(content) < 600:
                print(f"[thin] {eei} {title[:38]} len={len(content)}"); continue
            stage = STAGE_C if eng.startswith("court") else STAGE_W
            cred = "official" if (h.endswith(".gov.cn") or ".court.gov.cn" in h) else "research"
            fp = stage / f"{eei}_{slugify(title)}_{hashlib.md5(url.encode()).hexdigest()[:8]}.md"
            fp.write_text(f"# {title}\n\n> 缺口定向收尾腿 ({eng})\n> URL: {url}\n"
                          f"> 采集: {time.strftime('%Y-%m-%d %H:%M')}\n\n{content}", encoding="utf-8")
            mf.write(json.dumps({"file": str(fp), "engine": eng, "eei": eei, "stance": stance,
                                 "cred": cred, "url": url, "title": title,
                                 "chars": len(content)}, ensure_ascii=False) + "\n")
            mf.flush()
            hosts.setdefault(eei, set()).add(h); picked += 1; got[eei] = got.get(eei, 0) + 1
            print(f"[OK] {eei} {stance} {h} chars={len(content)} | {title[:44]}")
        print(f"---- '{q}' -> +{picked}")
        time.sleep(2)
    mf.close()
    print("SUMMARY:", json.dumps(got, ensure_ascii=False))

if __name__ == "__main__":
    main()
