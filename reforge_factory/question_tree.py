# -*- coding: utf-8 -*-
"""G1 问题树/EEI 生成器 — 证据饱和引擎第一件 (用户 2026-09-22 批准).

情报循环内核 (CIA/麦肯锡/Cochrane 三参照系合成):
  课题 → 竞争假设层(ACH 种子) → 子问题层 → EEI 叶子 (Essential Elements
  of Information: 每叶=一条"什么证据能回答它"的需求单, 含信源等级/正反
  需求/渠道提示/查询词弹药).

Manus 调研方法论整合 (用户 09-22 令: 把 Manus 如何调研收集资料的能力焊进引擎):
  M1 四维查询公式 (8412 词实测: 地域×行业细分×主题×时间窗+漏斗改写+权威源
     直捣, Auto_Manus/search_query_generator.py) → 每个 EEI 自动挂查询词集;
  M2 首步盘家底 (870 会话第一条) → generate 先读战役池现状+全站相关存量
     (仅防重扫参考, 不计门槛 — 弹药门槛铁律);
  M3 77%写/10%搜增量生长 → 缺口闭环节奏: 小批采→即时判挂树→按仪表补
     (写在树 meta, 由 G4 闭环执行);
  M4 contextTransfer 传承 → prompt 子命令产军团参谋升级包 (网络恢复后
     Manus 参谋按四维公式拆深树, 本地 v0 树是底盘).

用法:
  python question_tree.py generate <cid> --topic "四川省 EPC总承包市场" [--region 四川省] [--pool]
  python question_tree.py show <cid>
  python question_tree.py prompt <cid>          # 输出军团参谋升级任务包
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\Auto_Manus")
import search_query_generator as sqg  # noqa: E402  (M1 四维查询公式)

POOL_ROOT = Path(r"E:\AI-Station\ammo_pool")

# ---------- 子问题模板库 (工程研究域 v0; 军团参谋网络后扩充) ----------
SUBQ_TEMPLATES: dict[str, list[str]] = {
    "政策监管": [
        "{r} {s} 主管部门与监管框架",
        "{s} 国家层面政策文件与五年规划定位",
        "{s} 准入资质与招投标制度改革动向",
    ],
    "市场规模": [
        "{r} {s} 市场规模与近三年新签合同额趋势",
        "{s} 全国统计口径与权威数据源清单",
        "{r} {s} 增速驱动因素与天花板研判",
    ],
    "竞争格局": [
        "{s} 头部企业排名与市场份额",
        "央企/地方国企/民企在 {s} 的竞争分层",
        "{s} 主要玩家近三年重大战略动作",
    ],
    "项目案例": [
        "{s} 标志性项目清单 (业主/金额/工期)",
        "{s} 典型合同模式与计价方式",
        "{s} 重大失败或超概算案例",
    ],
    "风险事件": [
        "{s} 重大质量安全事故与行政处罚",
        "{s} 合同纠纷判例与败诉原因",
        "{s} 主要风险因子与对冲实践",
    ],
    "财务经营": [
        "{s} 头部企业营收/毛利率趋势",
        "{s} 应收账款与现金流风险信号",
    ],
}

# 竞争假设种子 (ACH 用: 每课题先立 3 个对立判断, 证据进场后排除)
HYPOTHESIS_SEEDS = [
    {"id": "H1", "text": "{s} 处于扩张周期, 机会大于风险",
     "prior": 0.4},
    {"id": "H2", "text": "{s} 已过峰值/竞争恶化, 风险大于机会",
     "prior": 0.3},
    {"id": "H3", "text": "{s} 结构性分化: 细分领域机会与风险并存",
     "prior": 0.3},
]

# 可证伪性审查词面 (Jev 接线前的启发式位; 纯议论词=不可证伪须改写)
FALSIFY_SIGNALS = ("规模", "排名", "金额", "清单", "趋势", "增速", "份额",
                   "案例", "判例", "事故", "处罚", "政策", "合同额", "口径",
                   "企业", "项目", "数据", "主管", "监管", "框架", "动向",
                   "制度", "分层", "模式", "驱动", "改革", "资质")
UNFALSIFY_WORDS = ("意义", "重要性", "价值探讨", "概述", "浅析")


def falsifiable_check(text: str) -> tuple[bool, str]:
    """可证伪性启发式审查: 能否用证据回答/反驳."""
    if any(w in text for w in UNFALSIFY_WORDS):
        return False, "议论型表述, 无法用证据证伪 — 须改写为可验证问句"
    if any(w in text for w in FALSIFY_SIGNALS):
        return True, "含可验证指标/实体词, 证据可回答亦可反驳"
    return False, "未见指标/实体词 — 建议点名数字、机构、时间窗"


def eei_for(subq: str, region: str, subject: str) -> list[dict]:
    """每个子问题 → 3 条 EEI (正/反/权威口径 — ACH 反证需求内建).
    查询词用 M1 四维公式 (region × subject × EEI 主题 × 时间窗), 不重复拼地域."""
    short = re.sub(r"[（()，,。.?？]", "", subq).replace(region, "")
    short = short.replace(subject, "").strip()[:20]   # 防查询词双拼
    core = f"{region} {subject}".strip()
    return [
        {"id": "", "need": f"正面证据: {short} 的数据/清单/案例",
         "grades": ["A", "B"], "stance": "support",
         "channels_hint": ["opencli", "rss", "metaso"],
         "queries": [f"{core} {short} {sqg.YEAR_WINDOW}",
                     f"{core} {short} 官方数据"]},
        {"id": "", "need": f"反面证据: {short} 的风险/反例/对立观点",
         "grades": ["B", "C"], "stance": "against",
         "channels_hint": ["sogou_wechat", "manus_corps", "websearch"],
         "queries": [f"{core} {short} 风险 纠纷 处罚",
                     f"{core} {short} 失败案例 质疑"]},
        {"id": "", "need": f"权威口径: {short} 的官方统计/公报原文",
         "grades": ["A"], "stance": "support",
         "channels_hint": ["govlist", "cnki", "opencli"],
         "queries": [s.format(region=region) for s in sqg.AUTHORITY_SITES[:3]]},
    ]


def context_pack(cid: str) -> dict:
    """M2 首步盘家底: 战役池现状 + 相关存量提示 (仅防重扫, 不计门槛)."""
    d = POOL_ROOT / cid
    state = {}
    p = d / "pool_state.json"
    if p.is_file():
        state = json.loads(p.read_text(encoding="utf-8"))
    return {
        "pool_items": state.get("items", 0),
        "pool_valid_chars": state.get("total_chars", 0),
        "pool_kws": state.get("kws", []),
        "note": "存量仅防重扫参考; 门槛只算本次新增有效弹药 (用户铁律)",
    }


def generate(cid: str, topic: str, region: str) -> Path:
    out = POOL_ROOT / cid / "question_tree.json"
    # topic 常已含地域前缀 — 剥离防重复拼接 (四川省 EPC总承包市场 → EPC总承包市场)
    subject = topic[len(region):].strip() if topic.startswith(region) else topic
    subqs, n_unfalsifiable = [], 0
    sid = 0
    for dim, templates in SUBQ_TEMPLATES.items():
        for t in templates:
            text = t.format(r=region, s=subject)
            ok, note = falsifiable_check(text)
            n_unfalsifiable += 0 if ok else 1
            sid += 1
            eeis = eei_for(text, region, subject)
            for i, e in enumerate(eeis, 1):
                e["id"] = f"Q{sid}-E{i}"
                e["status"] = "zero"   # 运行时由 coverage 更新
            subqs.append({"id": f"Q{sid}", "dim": dim, "text": text,
                          "falsifiable": ok, "falsify_note": note,
                          "eeis": eeis})
    tree = {
        "campaign": cid, "topic": topic, "region": region,
        "generated": time.strftime("%Y-%m-%d %H:%M"),
        "engine": "v0-heuristic (军团参谋网络恢复后升级 — M4)",
        "context_pack": context_pack(cid),
        "loop_policy": "M3 增量生长: 小批采→即时判挂树→按 coverage 缺口补下批",
        "hypotheses": [{"id": h["id"],
                        "text": h["text"].format(s=topic),
                        "prior": h["prior"]} for h in HYPOTHESIS_SEEDS],
        "subquestions": subqs,
        "stats": {"subquestions": len(subqs),
                  "unfalsifiable": n_unfalsifiable,
                  "eeis": sum(len(q["eeis"]) for q in subqs),
                  "queries": sum(len(e["queries"]) for q in subqs
                                 for e in q["eeis"])},
    }
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps(tree, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    print(f"[tree] {cid}: {len(subqs)} 子问题 | "
          f"{tree['stats']['eeis']} EEI | "
          f"{tree['stats']['queries']} 条四维查询词 | "
          f"不可证伪 {n_unfalsifiable} (已标记待改写)")
    print(f"[tree] 家底: 池内 {tree['context_pack']['pool_items']} 条 | "
          f"{out}")
    return out


def show(cid: str) -> int:
    p = POOL_ROOT / cid / "question_tree.json"
    if not p.is_file():
        print(f"[tree] 不存在, 先 generate: {cid}", file=sys.stderr)
        return 1
    t = json.loads(p.read_text(encoding="utf-8"))
    print(f"\n╔═ 问题树 ═ {t['campaign']} ═ {t['topic']} ({t['region']})")
    print(f"║ 竞争假设 (ACH 种子):")
    for h in t["hypotheses"]:
        print(f"║   {h['id']} ({h['prior']:.0%}) {h['text'][:44]}")
    for q in t["subquestions"]:
        flag = "✓" if q["falsifiable"] else "✗"
        print(f"║ {q['id']} [{q['dim']}] {flag} {q['text'][:46]}")
        for e in q["eeis"]:
            print(f"║    {e['id']} ({e['stance']:<7} "
                  f"{'/'.join(e['grades'])}) {e['need'][:40]}")
            if e["queries"]:
                print(f"║        ↳ {'; '.join(e['queries'][:2])[:66]}")
    return 0


def prompt(cid: str) -> int:
    """M4: 军团参谋升级包 — Manus 参谋会话任务 prompt (网络恢复后派发)."""
    p = POOL_ROOT / cid / "question_tree.json"
    if not p.is_file():
        print(f"[tree] 不存在, 先 generate: {cid}", file=sys.stderr)
        return 1
    t = json.loads(p.read_text(encoding="utf-8"))
    print(f"""# 军团参谋任务包 — {t['campaign']} 问题树升级
你是调研参谋。现有 v0 启发式问题树 ({t['stats']['subquestions']} 子问题/
{t['stats']['eeis']} EEI), 请按四维公式 (地域×行业细分×主题×时间窗,
漏斗改写: 泛→官方数据→点名权威源) 升级:
1. 补齐不可证伪子问题 ({t['stats']['unfalsifiable']} 条已标记 ✗) 的可验证改写;
2. 每个行业细分维度 ({len(sqg.INDUSTRY_DIMS)} 维) 生成矩阵式子问题;
3. 对 3 个竞争假设各补 2 条 EEI (正反各一);
4. 输出 JSON schema 同 question_tree.json (subquestions/hypotheses).
课题: {t['topic']} | 地域: {t['region']}
当前树摘要: {json.dumps(t['stats'], ensure_ascii=False)}""")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description="G1 问题树/EEI 生成器")
    ap.add_argument("cmd", choices=["generate", "show", "prompt"])
    ap.add_argument("cid")
    ap.add_argument("--topic", default="")
    ap.add_argument("--region", default="全国")
    args = ap.parse_args()
    if args.cmd == "generate":
        if not args.topic:
            print("--topic 必填", file=sys.stderr)
            return 2
        generate(args.cid, args.topic, args.region)
        return 0
    return show(args.cid) if args.cmd == "show" else prompt(args.cid)


if __name__ == "__main__":
    sys.exit(main())
