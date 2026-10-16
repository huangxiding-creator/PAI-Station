# -*- coding: utf-8 -*-
"""demand_signals_aggregate — 需求信号汇聚·意图分类·选题评分 (L2-L3, TOPIC_FRAMEWORK).

读 data/demand_signals/raw_*.jsonl 全源 → 六分类 (规则 v1: 关键词启发,
LLM 升级位留接口) → 主题聚合 (工程域实体词) → 评分卡 v2 (
强度×支付×空缺×复用×时效) → radar_signals.jsonl + radar_topics.md 排行。

用法: py -X utf8 tools/demand_signals_aggregate.py [--top 12]
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from collections import Counter, defaultdict
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]
SIG = REPO / "data" / "demand_signals"

# L2 意图分类 (规则 v1)
INTENTS = {
    "痛点陈述": ("太难|麻烦|踩坑|被坑|亏了|罚款|处罚|风险|背锅|甩锅|扯皮|拿不到|要不回|乱|痛"),
    "具体问题": ("怎么|如何|怎么办|请问|哪里|多少|什么流程|条件|要求|能不能|可以吗|？|？"),
    "比价犹豫": ("多少钱|价格|收费|贵|划算|值不值|预算|报价|费用|成本"),
    "资源求助": ("求|有没有|谁有|模板|清单|表格|资料|发我|分享|下载"),
    "否定抱怨": ("没用|不靠谱|假的|骗|水|不值|退|后悔"),
}
# 工程域主题词 (聚合键)
TOPIC_KWS = {
    "EPC模式与转型": "EPC|工程总承包|总承包|转型|设计院|施工单位转型",
    "招投标合规": "招标|投标|围标|串标|评标|中标|标书|合规",
    "合同与结算": "合同|结算|计价|索赔|变更|签证|调价|总价",
    "项目管理系统": "项目管理|项目经理|进度|工期|WBS|计划管理",
    "人才与培训": "人才|培训|建造师|造价|资质|取证|培养|课程",
    "数字化与AI": "AI|数字化|BIM|智能|数据|软件|系统",
    "区域与出海": "海外|国际|出海|区域|省份|一带|FIDIC",
    "风险与纠纷": "纠纷|诉讼|仲裁|败诉|风险|事故|安全",
    "政策与补贴": "政策|补贴|新规|办法|文件|补贴政策|资质改革",
    "市场与价格": "市场|规模|行情|价格|趋势|增速|份额",
}


def classify(text: str) -> str:
    for intent, kws in INTENTS.items():
        if any(k in text for k in kws.split("|")):
            return intent
    return "无关噪声"


def topic_of(text: str) -> str | None:
    hits = Counter()
    for topic, kws in TOPIC_KWS.items():
        if any(k in text for k in kws.split("|")):
            hits[topic] += 1
    return hits.most_common(1)[0][0] if hits else None


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--top", type=int, default=12)
    ns = ap.parse_args()
    rows = []
    for f in sorted(SIG.glob("raw_*.jsonl")):
        for ln in f.open(encoding="utf-8"):
            if ln.strip():
                try:
                    rows.append(json.loads(ln))
                except json.JSONDecodeError:
                    continue
    print(f"[agg] 读 {len(rows)} 条信号")
    topic_stats: dict[str, Counter] = defaultdict(Counter)
    SIGGER = SIG / "radar_signals.jsonl"
    with SIGGER.open("a", encoding="utf-8") as f:
        for r in rows:
            intent = classify(r["text"])
            topic = topic_of(r["text"])
            r["intent"], r["topic"] = intent, topic
            f.write(json.dumps(r, ensure_ascii=False) + "\n")
            if topic and intent != "无关噪声":
                topic_stats[topic][intent] += 1
                topic_stats[topic]["_n"] += 1
                if any(k in r["text"] for k in INTENTS["比价犹豫"].split("|")):
                    topic_stats[topic]["_pay"] += 1
                if any(k in r["text"] for k in INTENTS["资源求助"].split("|")):
                    topic_stats[topic]["_res"] += 1
    # 评分 v2: 强度(5) × 支付(3) × 空缺(2, 人工位) × 复用(2, 池命中位) × 时效(2)
    scored = []
    for topic, st in topic_stats.items():
        strength = min(5, 1 + st["_n"] // 3)
        pay = min(5, 1 + st.get("_pay", 0) + st.get("_res", 0) // 2)
        gap, reuse, window = 2, 2, 2        # v1 常数位 (djaynbao 空转/池命中待接线)
        score = strength * pay * gap * reuse * window
        scored.append((score, topic, dict(st)))
    scored.sort(reverse=True)
    md = [f"# 需求信号·选题排行 (v1 {time.strftime('%Y-%m-%d %H:%M')})",
          "", f"> 信号 {len(rows)} 条 → 主题 {len(scored)} 个 (意图六分类+评分卡v2)",
          "", "| 分 | 主题 | 信号 | 痛点 | 问题 | 比价 | 求资源 |", "|----|------|------|------|------|------|--------|"]
    for score, topic, st in scored[:ns.top]:
        md.append(f"| {score} | {topic} | {st['_n']} | {st.get('痛点陈述',0)} | "
                  f"{st.get('具体问题',0)} | {st.get('比价犹豫',0)} | {st.get('资源求助',0)} |")
    md += ["", "> 空(竞争)/复用(池命中) 两维为常数位, djyanbao 空转探测与弹药池命中待接线; LLM 意图分类升级位在案。"]
    out = SIG / "radar_topics.md"
    out.write_text("\n".join(md), encoding="utf-8")
    print(f"[agg] 排行落 {out.name}")
    print("\n".join(md[:9]))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
