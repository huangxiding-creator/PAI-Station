# -*- coding: utf-8 -*-
"""factory_demand — W1 需求塔: 三源信号 → 评分 → Top10 动态清单 (FACTORY-7x24).
用户令 1122 全批. 零LLM规则评分(透明可调), 输出 factory_top10.json + 企微摘要(可选).

三源:
  S1 微信洞察: data/demand_ledger/latest.md 热力表 (群聊/私聊/朋友圈语义归并族)
  S2 公众号全文: data/rss_harvest/articles/近N日/*.md (916源, 主题词频+痛点词)
  S3 销售回流: report_platform/funnel_events.jsonl (有数据即计权重, 无则该源0分不影响)

评分 = 热度40% + 付费画像25% + 在架空白度20% + 时效15%  (权重 --weights 可调)
剔除: report.json 90SKU 标题相似(>=0.6) + 近90天已产战役目录 + factory_vetoes.json 否决
用法: py -X utf8 tools/factory_demand.py [--days 3] [--top 10] [--push] [--weights 40,25,20,15]
"""
from __future__ import annotations

import argparse
import difflib
import json
import re
import sys
import time
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
RSS = REPO / "data" / "rss_harvest" / "articles"
LEDGER = REPO / "data" / "demand_ledger" / "latest.md"
FUNNEL = REPO / "report_platform" / "funnel_events.jsonl"
REPORTS = REPO / "report_platform" / "content" / "report.json"
M2 = REPO / "_proposals" / "flagship-paid-report-1007" / "work" / "m2"
OUT = REPO / "data" / "factory" / "factory_top10.json"
VETOES = REPO / "data" / "factory" / "factory_vetoes.json"

# 痛点/付费画像/时效词表 (可调; 先产线实战词, W5试产后按复盘迭代)
PAIN = ["怎么办", "怎么办？", "坑", "陷阱", "损失", "纠纷", "败诉", "风险", "争议", "维权",
        "索赔", "逾期", "拖欠", "无效", "推翻", "红线", "违规", "被罚", "教训", "血泪"]
BUYER = ["律师", "法务", "讲师", "培训", "课件", "咨询", "项目经理", "总包", "分包", "造价",
         "审计", "结算", "商务", "投标", "招标", "业主", "发包", "院长", "主任", "总监"]
FRESH = ["新规", "新政", "施行", "发布", "征求意见", "修订", "2026", "2027", "解释二",
         "最新", "开始实施", "即将", "截止", "窗口期", "过渡期"]
# 主题切词 (工程领域粗粒度主题锚——产线22份报告的主题域经验)
THEME_ANCHORS = [
    ("EPC工程总承包", ["EPC", "工程总承包", "总承包", "交钥匙"]),
    ("招投标与投标", ["招投标", "投标", "招标", "评标", "中标", "标书"]),
    ("合同与索赔", ["合同", "索赔", "签证", "变更", "违约金", "工期顺延"]),
    ("工程结算与造价", ["结算", "造价", "计价", "审计", "决算", "工程款", "审减"]),
    ("竣工验收与移交", ["竣工验收", "验收", "移交", "竣工", "缺陷责任", "质保金"]),
    ("分包与劳务", ["分包", "劳务", "实际施工人", "挂靠", "转包", "农民工"]),
    ("安全生产", ["安全生产", "安全事故", "安全责任", "事故追责", "隐患"]),
    ("保险与保函", ["保函", "保险", "履约担保", "见索即付", "IDI"]),
    ("融资与投资", ["融资", "投资", "PPP", "BOT", "REITs", "垫资", "EPC+F"]),
    ("税务", ["增值税", "发票", "税务", "预缴", "所得税", "退税"]),
    ("国际工程", ["国际工程", "出海", "一带一路", "FIDIC", "海外", "境外"]),
    ("新能源与储能", ["储能", "光伏", "风电", "新能源", "锂电池", "氢能"]),
    ("水利水电", ["水利", "水电", "枢纽", "大坝", "灌区"]),
    ("交通基建", ["公路", "桥梁", "隧道", "铁路", "机场", "港口"]),
    ("房建与市政", ["房建", "住宅", "市政", "管廊", "旧改", "保障房"]),
    ("数字化转型", ["数字化", "BIM", "智慧工地", "AI", "人工智能", "大模型"]),
    ("司法鉴定与诉讼", ["司法鉴定", "造价鉴定", "诉讼", "仲裁", "管辖", "证据"]),
    ("设计院转型", ["设计院", "设计施工一体化", "DB", "转型"]),
    ("企业研究", ["怎么干", "业务全景", "经营", "战略", "中標率"]),
    ("政策与法规", ["新规", "解释", "条例", "办法", "政策", "标准"]),
]


def cjk(t: str) -> int:
    return len(re.findall(r"[一-鿿]", t))


def read_rss(days: int) -> list[dict]:
    """近N日 rss 文章: {title, text, feed}."""
    out = []
    for d in range(days):
        day = time.strftime("%Y-%m-%d", time.localtime(time.time() - d * 86400))
        p = RSS / day
        if not p.is_dir():
            continue
        for f in p.glob("*.md"):
            try:
                t = f.read_text(encoding="utf-8", errors="replace")[:8000]
            except OSError:
                continue
            m = re.match(r"([^_\n]+)_", f.stem)
            out.append({"feed": m.group(1) if m else "", "title": f.stem[:80], "text": t})
    return out


def read_ledger_topics() -> list[tuple[str, int]]:
    """demand_ledger 热力表 → [(主题句, 聚合数)]."""
    if not LEDGER.is_file():
        return []
    rows = []
    for ln in LEDGER.read_text(encoding="utf-8", errors="replace").splitlines():
        ln = ln.strip()
        if ln.startswith("|") and "×" in ln:
            parts = [p.strip() for p in ln.split("|")]
            # 表头: | # | 需求(代表句) | 聚合 | 面 | 频率 |
            # parts: ['', '1', '微信视频号运营规范', '×99', '视频号评论', '1', '']
            if len(parts) >= 5:
                sent = parts[2]
                mm = re.search(r"×(\d+)", parts[3])
                if mm and cjk(sent) >= 4 and sent != "需求（代表句）":
                    rows.append((sent, int(mm.group(1))))
    return rows


def map_theme(text: str) -> list[str]:
    hits = []
    for name, kws in THEME_ANCHORS:
        n = sum(text.count(k) for k in kws)
        if n >= 2:
            hits.append((name, n))
    hits.sort(key=lambda x: -x[1])
    return [h[0] for h in hits[:2]]


def sku_titles() -> list[str]:
    try:
        d = json.loads(REPORTS.read_text(encoding="utf-8"))
        return [r.get("title", "") for r in d.get("reports", [])]
    except Exception:
        return []


GROUP_SIG_DIR = REPO / "wechat-24h-ops" / "data" / "topic-signals"   # 微信群聊/朋友圈洞察 (社群直接需求源)
FACTORY_STATE = REPO / "data" / "factory" / "factory_state.json"

# 主题 → “在架 SKU 已覆盖该主题”的判定词. 命中任一在架报告标题即视为已做过, 不再重复选.
# (原先只比较主题名与长标题的整体相似度, 阈值几乎永远触发不了 — 1123 修)
COVER_WORDS = {
    "EPC工程总承包": ["总承包"], "招投标与投标": ["招投标", "投标", "招标"],
    "合同与索赔": ["合同", "索赔", "签证"], "工程结算与造价": ["结算", "造价", "计价", "审计", "决算"],
    "竣工验收与移交": ["竣工", "验收", "移交"], "分包与劳务": ["分包"],
    "安全生产": ["安全生产", "安全事故"], "保险与保函": ["保险", "保函"],
    "融资与投资": ["融资"], "税务": ["税务"], "国际工程": ["出海", "海外", "国际工程"],
    "新能源与储能": ["储能", "光伏"], "水利水电": ["水利"], "交通基建": ["公路", "桥梁", "隧道", "铁路"],
    "房建与市政": ["房建", "市政"], "数字化转型": ["数字化", "BIM"],
    "司法鉴定与诉讼": ["司法鉴定", "判例"], "设计院转型": ["设计院"],
    "企业研究": ["怎么干", "全景洞察"], "政策与法规": ["合规指南", "蓝皮书"],
}


def covered_by_sku(theme: str, titles: list[str]) -> str | None:
    for w in COVER_WORDS.get(theme, []):
        for t in titles:
            if w in t:
                return t
    return None


def taken_themes() -> list[dict]:
    """工厂已建过战役的主题 (在途或已上架都算占住 — 一份没做完不开下一份)."""
    try:
        st = json.loads(FACTORY_STATE.read_text(encoding="utf-8"))
        return [h for h in st.get("history", []) if h.get("theme")]
    except Exception:
        return []


def read_group_signals() -> list[dict]:
    """微信群聊原话 (用户的直接需求与分享). 按原话前 24 字去重."""
    out, seen = [], set()
    if not GROUP_SIG_DIR.is_dir():
        return out
    for fp in sorted(GROUP_SIG_DIR.glob("*.jsonl")):
        for ln in fp.read_text(encoding="utf-8", errors="replace").splitlines():
            try:
                d = json.loads(ln)
            except json.JSONDecodeError:
                continue
            q = str(d.get("demand_quote") or "").strip()
            if not q or str(d.get("source_face")) != "group":
                continue
            k = q[:24]
            if k in seen:
                continue
            seen.add(k)
            out.append({"quote": q, "face": "group", "score": d.get("score") or 0,
                        "urgency": str(d.get("urgency") or ""), "freq7": d.get("frequency_7d") or 0,
                        "trigger": str((d.get("jtbd") or {}).get("trigger") or ""),
                        # “分享/《…》”开头的是转发的文章标题(供给侧), 不是提问
                        "is_share": q.startswith("分享") or q.startswith("《") or q.startswith("转发")})
    return out


def read_buyer_feedback() -> list[dict]:
    """已售报告的买家反馈 (公众号留言面), 按反馈编号去重. 这是“回到用户中去”最直接的信号,
    单独呈现, 不并入主题评分."""
    out, seen = [], set()
    p = REPO / "data" / "demand_ledger" / "signals.jsonl"
    if not p.is_file():
        return out
    for ln in p.read_text(encoding="utf-8", errors="replace").splitlines():
        try:
            d = json.loads(ln)
        except json.JSONDecodeError:
            continue
        if d.get("source_face") != "mp_feedback":
            continue
        ref = str(d.get("source_ref") or "")
        if ref in seen:
            continue
        seen.add(ref)
        out.append({"ref": ref[-22:], "sku": ref.split("_")[-1][:12] if "_" in ref else "",
                    "quote": str(d.get("demand_quote") or "")[:160],
                    "score": d.get("score") or 0, "ts": str(d.get("ts") or "")[:10]})
    return out


def read_sales_signal() -> dict:
    """销售回流: 漏斗事件按 SKU 与层级计数. 数据有多少算多少 (没有就如实是空)."""
    res: dict[str, dict] = {}
    if not FUNNEL.is_file():
        return {"n_events": 0, "by_sku": {}}
    n = 0
    for ln in FUNNEL.read_text(encoding="utf-8", errors="replace").splitlines():
        try:
            d = json.loads(ln)
        except json.JSONDecodeError:
            continue
        n += 1
        res.setdefault(str(d.get("sku")), {})[str(d.get("level"))] = \
            res.setdefault(str(d.get("sku")), {}).get(str(d.get("level")), 0) + 1
    return {"n_events": n, "by_sku": res}


def similarity(a: str, b: str) -> float:
    return difflib.SequenceMatcher(None, a[:40], b[:40]).ratio()


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser()
    ap.add_argument("--days", type=int, default=3)
    ap.add_argument("--top", type=int, default=10)
    ap.add_argument("--push", action="store_true")
    ap.add_argument("--weights", default="40,25,20,15")
    ns = ap.parse_args()
    W = [float(x) for x in ns.weights.split(",")]
    W = [x / sum(W) for x in W]

    articles = read_rss(ns.days)
    group = read_group_signals()
    feedback = read_buyer_feedback()
    sales = read_sales_signal()
    titles = sku_titles()
    taken = taken_themes()
    taken_themes_set = {h["theme"] for h in taken}
    vetoes = []
    if VETOES.is_file():
        try:
            vetoes = json.loads(VETOES.read_text(encoding="utf-8")).get("vetoed", [])
        except Exception:
            pass
    n_ask = sum(1 for g in group if not g["is_share"])
    print(f"[demand] 公众号文章 {len(articles)} 篇 | 社群原话 {len(group)} 条 "
          f"(提问/原生 {n_ask}, 转发文章 {len(group) - n_ask}) | 在架 {len(titles)} SKU | "
          f"工厂已占主题 {len(taken_themes_set)} | 否决 {len(vetoes)} | 漏斗事件 {sales['n_events']} | "
          f"买家反馈(去重) {len(feedback)}")

    # 主题聚合: 公众号文章 + 社群原话 (提问/原生发言权重高于转发的文章标题)
    agg: dict[str, dict] = {}
    ENG = ["工程", "建筑", "施工", "设计院", "总包", "承包", "造价", "监理",
           "招投标", "EPC", "基建", "市政", "水利", "电力", "公路", "铁路"]

    def bucket(theme: str) -> dict:
        return agg.setdefault(theme, {"heat": 0, "pain": 0, "buyer": 0, "fresh": 0,
                                      "arts": 0, "eng": 0, "asks": 0, "samples": [], "asks_samples": []})

    for art in articles:
        for theme in map_theme(art["title"] + " " + art["text"]):
            a = bucket(theme)
            a["arts"] += 1
            a["heat"] += 1
            txt = art["title"] + art["text"][:300]
            a["pain"] += sum(txt.count(k) for k in PAIN)
            a["buyer"] += sum(txt.count(k) for k in BUYER)
            a["fresh"] += sum(txt.count(k) for k in FRESH)
            if any(k in txt for k in ENG):
                a["eng"] += 1
            if len(a["samples"]) < 3:
                a["samples"].append(art["title"][:50])
    for g in group:
        for theme in map_theme(g["quote"]):
            a = bucket(theme)
            if g["is_share"]:
                a["heat"] += 1
            else:
                # 直接需求: 一条真实提问抵得上多篇转发文章
                w = 6 + (4 if g["urgency"] == "high" else 0) + min(4, int(g["freq7"] or 0))
                a["heat"] += w
                a["asks"] += 1
                a["pain"] += 2
                a["eng"] += 1
                if len(a["asks_samples"]) < 4:
                    a["asks_samples"].append(g["quote"][:70])

    # 归一化评分
    if not agg:
        print("[demand] 无主题命中")
        return 1
    mx = {k: max(1, max(a[k] for a in agg.values())) for k in ("heat", "pain", "buyer", "fresh")}
    rows = []
    for theme, a in agg.items():
        heat = a["heat"] / mx["heat"]
        # 工程域纯度: 命中工程锚词的条数占比 (泛科技/时政主题自动降权)
        denom = max(3, (a["arts"] + a["asks"]) * 0.25)
        pure = min(1.0, a["eng"] / denom) if (a["arts"] or a["asks"]) else 1.0
        pain = min(1.0, a["pain"] / 30)
        buyer = min(1.0, a["buyer"] / 20)
        fresh = min(1.0, a["fresh"] / 15)
        pay = 0.6 * pain + 0.4 * buyer
        # 空白度: 与在架SKU最大相似度 → 越低越空白
        blank = 1.0
        for t in titles:
            s = similarity(theme, t)
            if s >= 0.55:
                blank = min(blank, 1 - s)
        timeliness = fresh
        score = (W[0] * heat + W[1] * pay + W[2] * blank + W[3] * timeliness) * (0.35 + 0.65 * pure)
        rows.append({"theme": theme, "score": round(score * 10, 2),  # 0-10
                     "heat": round(heat * 10, 1), "pay": round(pay * 10, 1),
                     "blank": round(blank * 10, 1), "fresh": round(timeliness * 10, 1),
                     "arts": a["arts"], "asks": a["asks"],
                     "samples": a["samples"][:3], "asks_samples": a["asks_samples"][:4]})

    # 剔除: 否决 / 工厂已占(在途或已上架) / 在架SKU已覆盖该主题
    def culled(r):
        if any(v in r["theme"] for v in vetoes):
            return "vetoed"
        if r["theme"] in taken_themes_set:
            return "factory-taken"
        if covered_by_sku(r["theme"], titles):
            return "onshelf-covered"
        return None

    kept, culled_rows = [], []
    for r in sorted(rows, key=lambda x: -x["score"]):
        c = culled(r)
        if c:
            r["culled"] = c
            culled_rows.append(r)
            continue
        kept.append(r)
        if len(kept) >= ns.top:
            break
    OUT.parent.mkdir(parents=True, exist_ok=True)
    doc = {"ts": time.strftime("%Y-%m-%d %H:%M:%S"), "days": ns.days,
           "weights": ns.weights, "top": kept,
           "culled": [{"theme": r["theme"], "score": r["score"], "why": r["culled"]} for r in culled_rows],
           "sources": {"rss_articles": len(articles), "group_quotes": len(group),
                       "group_asks": n_ask, "skus": len(titles), "funnel_events": sales["n_events"],
                       "funnel_by_sku": sales["by_sku"]},
           "buyer_feedback": sorted(feedback, key=lambda x: -x["score"])[:20]}
    OUT.write_text(json.dumps(doc, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"[demand] 可选主题 {len(kept)} 个 → {OUT} | 已剔除 {len(culled_rows)} 个:")
    bywhy = {}
    for r in culled_rows:
        bywhy.setdefault(r["culled"], []).append(f"{r['theme']}({r['score']})")
    for why, lst in bywhy.items():
        print(f"   剔除·{why}: {'、'.join(lst)}")
    for i, r in enumerate(kept, 1):
        print(f"  {i:2d}. [{r['score']:5.2f}] {r['theme']} (热{r['heat']} 付{r['pay']} 空{r['blank']} 鲜{r['fresh']} "
              f"文章{r['arts']} 提问{r['asks']})")
        if r["asks_samples"]:
            print(f"       社群提问: {r['asks_samples'][0][:64]}")
    if ns.push:
        lines = [f"**{i}. [{r['score']}] {r['theme']}** (社群提问{r['asks']}条, 文章{r['arts']}篇)"
                 for i, r in enumerate(kept[:3], 1)]
        body = "研究工厂·需求清单前3 (完整清单见 factory_top10.json; 否决某方向请回复「否N号\"):\n" + "\n".join(lines)
        subprocess.run([sys.executable, "-X", "utf8", str(REPO / "tools" / "notify_wecom.py"),
                        "研究工厂需求清单", body], capture_output=True, timeout=60)
        print("[demand] 企微摘要已推")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
