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


def produced_recently(days: int = 90) -> list[str]:
    """近N天 m2 下有产出(含 final 或 out) 的战役目录名 → 已产主题."""
    out = []
    cutoff = time.time() - days * 86400
    if M2.is_dir():
        for d in M2.iterdir():
            if d.is_dir() and any(x.name.startswith("_ch12") or x.name == "out" for x in d.rglob("*") if x.is_file() and x.stat().st_mtime > cutoff):
                out.append(d.name)
    return out


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
    ledger = read_ledger_topics()
    titles = sku_titles()
    produced = produced_recently()
    vetoes = []
    if VETOES.is_file():
        try:
            vetoes = json.loads(VETOES.read_text(encoding="utf-8")).get("vetoed", [])
        except Exception:
            pass
    print(f"[demand] rss文章{len(articles)} | ledger族{len(ledger)} | 在架{len(titles)}SKU | 近90天已产{len(produced)} | 否决{len(vetoes)}")

    # 主题聚合 (rss全文 + ledger句)
    agg: dict[str, dict] = {}
    for art in articles:
        for theme in map_theme(art["title"] + " " + art["text"]):
            a = agg.setdefault(theme, {"heat": 0, "pain": 0, "buyer": 0, "fresh": 0, "arts": 0, "samples": []})
            a["arts"] += 1
            a["heat"] += 1
            txt = art["title"] + art["text"][:300]
            a["pain"] += sum(txt.count(k) for k in PAIN)
            a["buyer"] += sum(txt.count(k) for k in BUYER)
            a["fresh"] += sum(txt.count(k) for k in FRESH)
            if any(k in art["title"] + art["text"][:300] for k in ["工程","建筑","施工","设计院","总包","承包","造价","监理","招投标","EPC","基建","市政","水利","电力","公路","铁路"]):
                a["eng"] = a.get("eng", 0) + 1
            if len(a["samples"]) < 3:
                a["samples"].append(art["title"][:50])
    for sent, weight in ledger:
        for theme in map_theme(sent):
            a = agg.setdefault(theme, {"heat": 0, "pain": 0, "buyer": 0, "fresh": 0, "arts": 0, "samples": []})
            a["heat"] += weight
            a["pain"] += sum(sent.count(k) for k in PAIN) * weight
            if len(a["samples"]) < 3:
                a["samples"].append(sent[:50])

    # 归一化评分
    if not agg:
        print("[demand] 无主题命中")
        return 1
    mx = {k: max(1, max(a[k] for a in agg.values())) for k in ("heat", "pain", "buyer", "fresh")}
    rows = []
    ENG_KWS = ["工程", "建筑", "施工", "设计院", "总包", "承包", "造价", "监理",
               "招投标", "EPC", "基建", "市政", "水利", "电力", "公路", "铁路"]
    for theme, a in agg.items():
        heat = a["heat"] / mx["heat"]
        # 工程域纯度: 样例文中工程锚词覆盖 (泛科技/时政主题自动降权)
        pure = min(1.0, a.get("eng", 0) / max(3, a["arts"] * 0.25)) if a["arts"] else 1.0
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
                     "arts": a["arts"], "samples": a["samples"][:3]})
    # 剔除: 否决 / 近产 / 与在架强重叠(score惩罚在blank已计, 强重叠直接跳过)
    def culled(r):
        if any(v in r["theme"] for v in vetoes):
            return "vetoed"
        if any(similarity(r["theme"], t) >= 0.7 for t in titles):
            return "onshelf-dup"
        return None
    kept = []
    for r in sorted(rows, key=lambda x: -x["score"]):
        c = culled(r)
        if c:
            r["culled"] = c
            continue
        kept.append(r)
        if len(kept) >= ns.top:
            break
    OUT.parent.mkdir(parents=True, exist_ok=True)
    doc = {"ts": time.strftime("%Y-%m-%d %H:%M:%S"), "days": ns.days,
           "weights": ns.weights, "top": kept,
           "culled_count": len(rows) - len(kept)}
    OUT.write_text(json.dumps(doc, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"[demand] Top{len(kept)} → {OUT}")
    for i, r in enumerate(kept, 1):
        print(f"  {i:2d}. [{r['score']:5.2f}] {r['theme']} (热{r['heat']} 付{r['pay']} 空{r['blank']} 鲜{r['fresh']} 文{r['arts']})")
        print(f"       样例: {r['samples'][0][:46] if r['samples'] else '-'}")
    if ns.push:
        lines = [f"**{i}. [{r['score']}] {r['theme']}** (热{r['heat']}/付{r['pay']}/空{r['blank']}/鲜{r['fresh']})" for i, r in enumerate(kept[:3], 1)]
        body = "工厂需求塔Top3(全文见factory_top10.json, 否决请回复「否N号」):\\n" + "\\n".join(lines)
        import subprocess
        subprocess.run([sys.executable, "-X", "utf8", str(REPO / "tools" / "notify_wecom.py"),
                        "工厂需求塔日摘要", body], capture_output=True, timeout=60)
        print("[demand] 企微摘要已推")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
