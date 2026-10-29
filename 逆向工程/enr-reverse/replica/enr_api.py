# -*- coding: utf-8 -*-
"""
enr_api.py - ENR Top250 International Contractors 榜单数据 纯 HTTP 客户端 (替代源复刻件)

定性 (2026-10-24 实测): enr.com 官方站 = Cloudflare managed challenge + Turnstile 人机验证
(cf-mitigated: challenge, cType:'managed', sitekey 0x4AAAAAAADnPIDROrmt1Wwj).
curl_cffi chrome 直探 403; 真 Chrome 155 headed 实弹 3 轮挑战环不放行, cf_clearance 从未签发.
-> 官方站需浏览器人机环节, 纯 HTTP 不通 (详见 逆向报告.md).

替代源主通道: chinca.org (中国对外承包工程商会 = ENR 榜中国区统一组织申报方) coc 栏目年度榜文:
  正文 = top10 名次+营收 + 国别统计 + 中企分析 (权威数字层)
  附图 = ENR 官方全榜表格截图 (RANK | FIRM | INT'L/TOTAL/NEW CONTRACTS $MIL | 9 专业领域)
链路: chinca WAF gate (复用 ../chinca-reverse/replica solver.js 本地执行) -> 榜文 -> 表图 -> RapidOCR
      -> 结构化 250 强数据 + 三道验证门 (text↔OCR top10 互验 / INT'L 单调性 / 中企计数)

用法:
  python enr_api.py --list
  python enr_api.py --year 2024
  python enr_api.py --year 2024 --out csv
  python enr_api.py --selftest

依赖: requests + ../chinca-reverse/replica/chinca_api.py (Node solver) + rapidocr-onnxruntime
"""
import argparse
import hashlib
import io
import json
import os
import re
import sys
import time

_HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.normpath(os.path.join(_HERE, "..", "..", "chinca-reverse", "replica")))
from chinca_api import ChincaClient  # noqa: E402

# 已实测收录的年度榜文 (chinca coc 栏目)
YEAR_ARTICLES = {
    2026: "/CICA/info/26082609115911",
    2025: "/CICA/info/25082215040911",
    2024: "/CICA/info/24091410422111",
}

_OCR_CACHE = {}


class ENRDataError(RuntimeError):
    pass


# ---------------- article layer ----------------
def fetch_article(c, year):
    """榜文: (article dict, 内容图URL列表). c = 已过闸的 ChincaClient."""
    if year not in YEAR_ARTICLES:
        raise ENRDataError("year %s not indexed; run --list" % year)
    url = YEAR_ARTICLES[year]
    art = c.get_article(url)
    r = c.get(url)
    imgs = re.findall(r'<img[^>]+src="(/upload/image/[^"]+)"', r.text or "")
    seen, uniq = set(), []
    for u in imgs:
        if u not in seen:
            seen.add(u)
            uniq.append(u)
    return art, uniq


def parse_text_facts(text):
    """正文权威数字层: top 名次+国际营收(亿美元), 中企数, 总量. OCR 验证门数据源."""
    facts = {"top": []}
    for m in re.finditer(r"[（(]\s*排名第?(\d{1,3})\s*位[，,]\s*国际营业额\s*([\d.]+)\s*亿美元[）)]", text):
        facts["top"].append({"rank": int(m.group(1)), "intl_rev_yi": float(m.group(2))})
    for m in re.finditer(r"以\s*([\d.]+)\s*亿美元(?:的)?国际营业额(?:蝉联|位居|排名)?(?:榜首|第\s*([1-9])\s*位)", text):
        rk = int(m.group(2)) if m.group(2) else 1
        facts["top"].append({"rank": rk, "intl_rev_yi": float(m.group(1))})
    cns = [int(x) for x in re.findall(r"共有\s*(\d{2,3})\s*家中国(?:内地)?企业", text)]
    cns += [int(x) for x in re.findall(r"共有\s*(\d{2,3})\s*家企业入围", text)]
    if cns:
        facts["cn_firms"] = max(cns)
    m = re.search(r"国际营业总额为\s*([\d.]+)\s*亿美元", text)
    if m:
        facts["total_intl_yi"] = float(m.group(1))
    dedup = {}
    for t in facts["top"]:
        dedup[t["rank"]] = t
    facts["top"] = [dedup[k] for k in sorted(dedup)]
    return facts


# ---------------- OCR layer ----------------
def ocr_image(png_bytes, use_cache=True):
    key = hashlib.sha256(png_bytes).hexdigest()
    if use_cache and key in _OCR_CACHE:
        return _OCR_CACHE[key]
    from rapidocr_onnxruntime import RapidOCR
    if not hasattr(ocr_image, "_engine"):
        ocr_image._engine = RapidOCR()
    import numpy as np
    import cv2
    arr = cv2.imdecode(np.frombuffer(png_bytes, dtype=np.uint8), cv2.IMREAD_COLOR)
    if arr is None:
        raise ENRDataError("image decode failed (%d bytes)" % len(png_bytes))
    res, _ = ocr_image._engine(arr)
    boxes = []
    for item in (res or []):
        box, txt, conf = item[0], item[1], float(item[2])
        boxes.append([(box[0][0] + box[2][0]) / 2.0, (box[0][1] + box[2][1]) / 2.0, txt])
    boxes.sort(key=lambda b: b[1])
    lines = []
    for b in boxes:
        if lines and abs(b[1] - lines[-1]["y"]) <= 12:
            lines[-1]["items"].append(b)
            lines[-1]["y"] = (lines[-1]["y"] + b[1]) / 2.0
        else:
            lines.append({"y": b[1], "items": [b]})
    rows = [[(round(b[0]), b[2]) for b in sorted(l["items"], key=lambda x: x[0])]
            for l in sorted(lines, key=lambda l: l["y"])]
    _OCR_CACHE[key] = rows
    return rows


def _num(tok):
    tok = tok.replace("。", "0").replace(" ", "").replace("$", "").rstrip(".")
    if not tok or tok in {"-", "NA", "N/A", "--"}:
        return None
    m = re.fullmatch(r"([\d,]+(?:\.\d+)?)", tok)
    if m:
        return float(tok.replace(",", ""))
    return None


def _split_merged(tok):
    """粘连双数 '4,109.25,717.4' -> (4109.2, 5717.4)"""
    parts = re.findall(r"\d{1,3}(?:,\d{3})*\.\d", tok)
    if len(parts) >= 2:
        return float(parts[0].replace(",", "")), float(parts[1].replace(",", ""))
    return None, None


FIRM_X0, FIRM_X1 = 152, 616
REV_X0, REV_X1 = 600, 790
BASE_W = 1280.0


def _img_w(png_bytes):
    try:
        import numpy as np
        import cv2
        arr = cv2.imdecode(np.frombuffer(png_bytes, dtype=np.uint8), cv2.IMREAD_COLOR)
        return float(arr.shape[1]) if arr is not None else BASE_W
    except Exception:
        return BASE_W


def _scaled(x0, x1, w):
    k = w / BASE_W
    return int(x0 * k), int(x1 * k)


def _money_ok(tok):
    ts = tok.strip().replace("$", "")
    if not re.fullmatch(r"[\d,.]+", ts):
        return False
    digits = re.sub(r"[,.]", "", ts)
    return len(digits) >= 3 and ("," in ts or "." in ts)


def _data_rows(rows, w=BASE_W):
    """ENR 国际榜截图行过滤: 有 firm token + 金额 token 的行"""
    fx0, fx1 = _scaled(FIRM_X0, FIRM_X1, w)
    rx0, rx1 = _scaled(REV_X0, REV_X1, w)
    out = []
    for line in rows:
        firm, revs, rank_toks = [], [], []
        for x, t in line:
            ts = t.strip()
            if fx0 <= x < fx1 and len(ts) > 4:
                firm.append((x, ts))
            elif rx0 <= x < rx1 and _money_ok(ts):
                revs.append((x, ts))
            elif x < fx0 and re.fullmatch(r"\d{1,3}", ts) and 1 <= int(ts) <= 250:
                rank_toks.append((x, int(ts)))
        if firm and revs:
            out.append({"firm": " ".join(t for _, t in firm),
                        "rev_toks": revs, "rank_toks": rank_toks})
    return out


def parse_intl_image(rows, w=BASE_W):
    """-> [ {rank(explicit or None), rank_prev, firm_raw, rev_intl, rev_total} ]"""
    recs = []
    for dr in _data_rows(rows, w):
        rank = None
        rank_prev = None
        if dr["rank_toks"]:
            # 列带拆分: x<118 = 本年 rank; 118<=x<152 = 上年 rank (单 token 不得串列)
            rk0, _ = _scaled(118, 152, w)
            for x, v in dr["rank_toks"]:
                if x < rk0 and rank is None:
                    rank = v
                elif x >= 118 and rank_prev is None:
                    rank_prev = v
        rev_intl = rev_total = None
        toks = [t for _, t in dr["rev_toks"]]
        if len(toks) >= 2:
            rev_intl = _num(toks[0])
            rev_total = _num(toks[1])
        elif len(toks) == 1:
            a, b = _split_merged(toks[0])
            rev_intl, rev_total = a, b
        recs.append({"rank": rank, "rank_prev": rank_prev, "firm_raw": dr["firm"],
                     "firm": re.sub(r"\s+", " ", dr["firm"]).strip(" .,|tT"),
                     "rev_intl_musd": rev_intl, "rev_total_musd": rev_total})
    return recs


CN_BANDS = [("seq", 0, 160), ("rank", 160, 300), ("rank_prev", 300, 450), ("name", 450, 4000)]
CN_NAME_FIX = {"建改": "建设", "限份": "股份", "责托": "责任", "治金": "冶金", "新量": "新疆", "备源": "能源", "限资": "投资", "练化": "炼化", "限备": "投资"}


def parse_cn_image(rows, w=BASE_W):
    recs = []
    bands = [(k,) + _scaled(x0, x1, w) for k, x0, x1 in CN_BANDS]
    for line in rows:
        cells = {k: [] for k, _, _ in CN_BANDS}
        for x, t in line:
            ts = t.strip()
            for k, x0, x1 in bands:
                if x0 <= x < x1:
                    cells[k].append(ts)
                    break
        nm = " ".join(cells["name"]).strip()
        nm = re.sub(r"^[^一-龥A-Za-z]+\s*", "", nm)   # 前缀序号残渣
        for a, b in CN_NAME_FIX.items():
            nm = nm.replace(a, b)
        if not nm or len(nm) < 4:
            continue
        def _int(vals):
            for v in vals:
                v2 = re.sub(r"\D", "", v.replace("!", "1").replace("l", "1").replace("O", "0"))
                if v2 and len(v2) <= 3 and 1 <= int(v2) <= 250:
                    return int(v2)
            return None
        recs.append({"rank": _int(cells["rank"]), "rank_prev": _int(cells["rank_prev"]),
                     "firm_cn": nm})
    return recs


def classify_image(rows):
    head = " ".join(t for line in rows[:8] for _, t in line)
    if "企业名称" in head or "序号" in head:
        return "cn_list"
    head_u = head.upper()
    if "RANK" in head_u or "REVENUE" in head_u:
        return "intl"
    name_like = sum(1 for line in rows for x, t in line if FIRM_X0 <= x < FIRM_X1 and len(t) > 12)
    return "intl" if name_like >= 5 else "other"


def assemble_intl(per_image_recs, cap=250):
    """v4 (2026-10-24 定稿): 行序=榜序 最强不变量; 段内若丢 1 行则偏移 +1 跳变.
    双偏移分段: 主模态偏移 + 次模态(count>=4, 相差 1) → 分界行 = 首个次偏移显式行;
    无显式段续接前段末尾. 掉位误读(count==1)被模态自然淘汰. >cap 丢弃, 缺口=inferred."""
    from collections import Counter
    merged = []
    for recs in per_image_recs:
        exp = [(i, r["rank"]) for i, r in enumerate(recs) if r["rank"] is not None]
        exp_offsets = {i: (v - i) for i, v in exp}
        offsets = Counter(exp_offsets.values())
        if offsets:
            primary = offsets.most_common(1)[0][0]
            secondary = None
            for o, c in offsets.most_common(5):
                if o != primary and c >= 4 and abs(o - primary) == 1:
                    secondary = o
                    break
            if secondary is not None:
                lo, hi = (primary, secondary) if primary < secondary else (secondary, primary)
                split = min(i for i, o in exp_offsets.items() if o == hi)
            else:
                lo = hi = primary
                split = len(recs)
            for i, r in enumerate(recs):
                off = lo if i < split else hi
                r["rank"] = i + off
                r["inferred"] = exp_offsets.get(i) != off
        else:
            base = merged[-1]["rank"] if merged else 0
            for i, r in enumerate(recs):
                r["rank"] = base + i + 1
                r["inferred"] = True
        merged += [r for r in recs if 1 <= r["rank"] <= cap]
    dedup = {}
    for r in merged:
        k = r["rank"]
        cur = dedup.get(k)
        if cur is None or (r.get("rev_intl_musd") and not cur.get("rev_intl_musd")):
            dedup[k] = r
    return [dedup[k] for k in sorted(dedup)]


# ---------------- client ----------------
class ENRClient:
    def __init__(self):
        self.cc = ChincaClient()

    def pull(self, year, use_cache=True):
        art, img_urls = fetch_article(self.cc, year)
        facts = parse_text_facts(art["content"])
        per_image = []
        cn_rows = []
        img_meta = []
        for u in img_urls:
            r = self.cc.get(u)
            if len(r.content) < 60000:
                continue
            rows = ocr_image(r.content, use_cache=use_cache)
            kind = classify_image(rows)
            iw = _img_w(r.content)
            img_meta.append({"url": u, "kind": kind, "lines": len(rows), "bytes": len(r.content), "width": int(iw)})
            if kind == "intl":
                per_image.append(parse_intl_image(rows, iw))
            elif kind == "cn_list":
                cn_rows += parse_cn_image(rows, iw)
        intl = assemble_intl(per_image)
        cn_dedup = {}
        for rec in cn_rows:
            cn_dedup.setdefault(rec.get("firm_cn"), rec)
        cn_list = [cn_dedup[k] for k in sorted(cn_dedup)]
        inferred = sum(1 for x in intl if x.get("inferred"))
        return {
            "year": year,
            "source": "chinca.org coc 栏目年度榜文 + ENR 官方全榜表格截图",
            "article": {"title": art["title"], "date": art["date"],
                        "url": "https://www.chinca.org" + YEAR_ARTICLES[year],
                        "content_len": art["content_len"]},
            "facts": facts,
            "images": img_meta,
            "intl_table": intl,
            "cn_list": cn_list,
            "coverage": {"intl_rows": len(intl),
                         "intl_with_rev": sum(1 for x in intl if x.get("rev_intl_musd")),
                         "ranks_inferred": inferred,
                         "cn_rows": len(cn_list),
                         "rank_range": [intl[0]["rank"], intl[-1]["rank"]] if intl else None},
        }

    def verify(self, result):
        facts = result["facts"]
        gates = {}
        pairs = []
        for t in facts.get("top", []):
            hit = next((x for x in result["intl_table"] if x["rank"] == t["rank"]), None)
            if hit and hit.get("rev_intl_musd") is not None:
                ocr_yi = round(hit["rev_intl_musd"] / 100.0, 1)
                pairs.append({"rank": t["rank"], "text_yi": t["intl_rev_yi"], "ocr_yi": ocr_yi,
                              "match": abs(ocr_yi - t["intl_rev_yi"]) <= max(1.0, t["intl_rev_yi"] * 0.005)})
        gates["g1_top_text_vs_ocr"] = {"pairs": len(pairs),
                                       "matched": sum(1 for p in pairs if p["match"]),
                                       "detail": pairs}
        revs = [x["rev_intl_musd"] for x in result["intl_table"] if x.get("rev_intl_musd") is not None]
        viol = sum(1 for a, b in zip(revs, revs[1:]) if b > a * 1.002)
        gates["g2_monotonic_intl_rev"] = {"n": len(revs), "violations": viol}
        if "cn_firms" in facts:
            gates["g3_cn_count"] = {"text": facts["cn_firms"],
                                    "image_list": result["coverage"]["cn_rows"],
                                    "match": result["coverage"]["cn_rows"] >= facts["cn_firms"] - 3}
        return gates


# ---------------- selftest / cli ----------------
def selftest(rounds=5, year=2024):
    """5 次独立会话全链贯通: 新 ChincaClient(过闸) -> 榜文 -> 图下载 -> 全量 OCR(不缓存) -> 验证门"""
    results = []
    for i in range(rounds):
        t0 = time.time()
        rec = {"round": i + 1}
        try:
            c = ENRClient()
            data = c.pull(year, use_cache=False)
            gates = c.verify(data)
            rec["rows"] = data["coverage"]["intl_rows"]
            rec["rows_with_rev"] = data["coverage"]["intl_with_rev"]
            rec["ranks_inferred"] = data["coverage"]["ranks_inferred"]
            g1 = gates["g1_top_text_vs_ocr"]
            rec["g1"] = "%d/%d" % (g1["matched"], g1["pairs"])
            rec["g2_viol"] = gates["g2_monotonic_intl_rev"]["violations"]
            rec["ok"] = bool(rec["rows"] >= 240 and g1["pairs"] >= 5
                             and g1["matched"] == g1["pairs"]
                             and gates["g2_monotonic_intl_rev"]["violations"] <= 3)
        except Exception as e:
            rec["ok"] = False
            rec["error"] = repr(e)[:200]
        rec["secs"] = round(time.time() - t0, 1)
        results.append(rec)
        print(json.dumps(rec, ensure_ascii=False))
        time.sleep(1.0)
    passed = sum(1 for r in results if r.get("ok"))
    print(json.dumps({"selftest": "PASS %d/%d" % (passed, rounds)}, ensure_ascii=False))
    return results


def main():
    ap = argparse.ArgumentParser(description="ENR Top250 榜单数据客户端 (chinca 替代源)")
    ap.add_argument("--year", type=int)
    ap.add_argument("--list", action="store_true")
    ap.add_argument("--out", choices=["json", "csv"], default="json")
    ap.add_argument("--selftest", action="store_true")
    args = ap.parse_args()
    try:
        sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
    except Exception:
        pass
    if args.selftest:
        selftest()
        return
    if args.list:
        c = ENRClient()
        for y, u in sorted(YEAR_ARTICLES.items(), reverse=True):
            art, imgs = fetch_article(c.cc, y)
            print(json.dumps({"year": y, "url": u, "title": art["title"], "date": art["date"],
                              "content_len": art["content_len"], "content_imgs": len(imgs)},
                             ensure_ascii=False))
        return
    if not args.year:
        ap.error("need --year or --list or --selftest")
    c = ENRClient()
    data = c.pull(args.year)
    gates = c.verify(data)
    if args.out == "csv":
        w = sys.stdout
        w.write("year,rank,rank_prev,firm,rev_intl_musd,rev_total_musd,inferred\n")
        for x in data["intl_table"]:
            w.write("%s,%s,%s,%s,%s,%s,%s\n" % (
                args.year, x["rank"], x.get("rank_prev") or "",
                (x["firm"].replace(",", ";")), x.get("rev_intl_musd") or "",
                x.get("rev_total_musd") or "", x.get("inferred")))
    else:
        payload = dict(data)
        payload["verify"] = gates
        print(json.dumps(payload, ensure_ascii=False, indent=1)[:30000])


if __name__ == "__main__":
    main()
