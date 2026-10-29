# -*- coding: utf-8 -*-
"""poster_swap_draft — 海报位新规执行件 (promo_poster_rule.md §三.4, 1027 用户令).

纯 API 链路: draft/get → media/uploadimg(海报) → draft/update.
把草稿文末「归因二维码图 + 长按识别说明行」替换为报告海报图(width:70%居中)
+ 小字「长按识别海报中小程序码 · 免费试读」。不改 push_article, 不碰浏览器.
"""
from __future__ import annotations
import argparse, io, json, re, sys, time
from pathlib import Path

sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng\scripts")
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
from research_studio.promotion.wechat_publisher import (  # noqa: E402
    _session, _API, load_account, get_access_token)

PROMO = Path(__file__).resolve().parent
POSTER_DIR = PROMO / "posters"
LEDGER = PROMO / "poster_fetch_ledger.jsonl"
RE_QR_BLOCK = re.compile(
    r'<p style="text-align:center"><img [^>]*style="width:70%\s*"\s*/?></p>'
    r'<p style="text-align:center;font-size:14px;color:#888">长按识别 · 总包智库报告平台'
    r'（试读免费）</p>')


def swap(account: str, title_match: str, poster: Path) -> dict:
    s = _session()
    acc = load_account(account)
    token = get_access_token(acc, s)
    # 海报 → 微信素材 URL
    with poster.open("rb") as f:
        r = s.post(f"{_API}/media/uploadimg",
                   params={"access_token": token},
                   files={"media": (poster.name, f, "image/png")}, timeout=60)
    d = r.json()
    purl = d.get("url", "")
    if not purl:
        return {"ok": False, "step": "uploadimg", "err": d}
    repl = ('<p style="text-align:center"><img src="%s" style="width:70%%"/></p>'
            '<p style="text-align:center;font-size:14px;color:#888">'
            '长按识别海报中小程序码 · 免费试读</p>' % purl)
    # 找该号草稿箱里的目标草稿 (标题含 title_match)
    r = s.post(f"{_API}/draft/batchget",
               params={"access_token": token},
               data=json.dumps({"offset": 0, "count": 10, "no_content": 1},
                               ensure_ascii=False).encode("utf-8"),
               headers={"Content-Type": "application/json; charset=utf-8"}, timeout=30)
    total = json.loads(r.content.decode("utf-8")).get("total_count", 0)
    hit = None
    for off in range(0, min(total, 40), 5):
        r = s.post(f"{_API}/draft/batchget",
                   params={"access_token": token},
                   data=json.dumps({"offset": off, "count": 5, "no_content": 0},
                                   ensure_ascii=False).encode("utf-8"),
                   headers={"Content-Type": "application/json; charset=utf-8"}, timeout=30)
        for it in json.loads(r.content.decode("utf-8")).get("item", []) or []:
            arts = it.get("content", {}).get("news_item", []) or []
            if any(title_match in (a.get("title") or "") for a in arts):
                hit = (it.get("media_id"), arts)
                break
        if hit:
            break
    if not hit:
        return {"ok": False, "step": "find_draft", "err": f"未找到含『{title_match}』的草稿"}
    media_id, arts = hit
    idx = next(i for i, a in enumerate(arts) if title_match in (a.get("title") or ""))
    # 拿全文 content (batchget no_content=0 已含)
    art = arts[idx]
    html = art.get("content", "")
    if purl in html:
        return {"ok": True, "step": "idempotent", "media_id": media_id, "index": idx}
    if not RE_QR_BLOCK.search(html):
        return {"ok": False, "step": "locate_block", "err": "未匹配到文末二维码块",
                "tail": html[-260:]}
    html2 = RE_QR_BLOCK.sub(repl, html, count=1)
    upd = {k: art.get(k, "") for k in ("title", "author", "digest", "content",
                                       "thumb_media_id", "need_open_comment",
                                       "only_fans_can_comment")}
    upd["content"] = html2
    if not upd.get("thumb_media_id"):
        upd["thumb_media_id"] = art.get("thumb_media_id")
    body = json.dumps({"media_id": media_id, "index": idx, "articles": upd},
                      ensure_ascii=False).encode("utf-8")
    r = s.post(f"{_API}/draft/update", params={"access_token": token},
               data=body, headers={"Content-Type": "application/json; charset=utf-8"},
               timeout=30)
    d = r.json()
    ok = d.get("errcode", 0) == 0
    return {"ok": ok, "step": "draft/update", "media_id": media_id, "index": idx,
            "resp": d, "poster_url": purl, "html_len": len(html2)}


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--sku", required=True)
    ap.add_argument("--account", required=True)
    ap.add_argument("--title", required=True, help="草稿标题包含片段")
    ns = ap.parse_args()
    poster = POSTER_DIR / f"{ns.sku}.png"
    if not poster.is_file():
        print(f"[swap] 海报缺失: {poster}")
        return 1
    out = swap(ns.account, ns.title, poster)
    print("[swap]", ns.account, json.dumps(out, ensure_ascii=False)[:420])
    if out.get("ok"):
        rec = {"ts": time.strftime("%Y-%m-%d %H:%M:%S"), "sku": ns.sku,
               "account": ns.account, "title": ns.title, "media_id": out.get("media_id"),
               "index": out.get("index"), "poster_url": out.get("poster_url", "")}
        with LEDGER.open("a", encoding="utf-8") as f:
            f.write(json.dumps(rec, ensure_ascii=False) + chr(10))
        print("[swap] ledger 过账 poster_fetch_ledger.jsonl")
    return 0 if out.get("ok") else 1


if __name__ == "__main__":
    raise SystemExit(main())
