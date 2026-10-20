# -*- coding: utf-8 -*-
"""P2 语料复挖器 — 三期逆向目标 (S3 源).

输入: Auto_Manus/analysis/{corpus_index,tool_usage,plan_chains}.json
输出: manus-reverse/p2/{p2_findings.md, p2_search.json, p2_plans.json, p2_rhythm.json}

三期目标 (methodology_reverse_2 待深挖):
  A. 搜索词工程: 结构聚类 + 失败(ok=0)→改写链
  B. 计划模板: 256 计划链的重复模式
  C. 搜写节奏: 每会话 burst 结构统计
"""
from __future__ import annotations

import json
import re
import sys
from collections import Counter, defaultdict
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

AM = Path(r"E:\AI-Station\Auto_Manus\analysis")
OUT = Path(__file__).resolve().parent.parent / "p2"
OUT.mkdir(exist_ok=True)


def load_all():
    ci = json.loads((AM / "corpus_index.json").read_text(encoding="utf-8"))
    tu = json.loads((AM / "tool_usage.json").read_text(encoding="utf-8"))
    pc = json.loads((AM / "plan_chains.json").read_text(encoding="utf-8"))
    return ci, tu, pc


# ---------------------------------------------------------- A. 搜索词工程
AUTHORITY_HINTS = ["统计局", "统计年鉴", "发改委", "住建", "政府", "官方", "公报",
                   "白皮书", "协会", "研究院", "公告", "政务", "财政部", "水利部",
                   "公共资源交易", "国务院", "省人民政府", "上市公司", "年报"]
TIME_RE = re.compile(r"20\d{2}")
QUANT_HINTS = ["市场规模", "产值", "增速", "占比", "投资额", "金额", "亿元",
               "增长率", "容量", "份额", "产量", "装机"]


def term_anatomy(q: str) -> dict:
    return {
        "len": len(q),
        "has_time": bool(TIME_RE.search(q)),
        "n_auth": sum(1 for h in AUTHORITY_HINTS if h in q),
        "n_quant": sum(1 for h in QUANT_HINTS if h in q),
        "n_tok": len(q.replace("，", " ").replace(",", " ").split()),
    }


def mine_search(tu: dict) -> dict:
    terms = tu["search_terms"]
    ok_terms = [t for t in terms if t.get("ok")]
    fail_terms = [t for t in terms if not t.get("ok")]
    anat = [term_anatomy(t["q"]) for t in terms]
    lens = sorted(a["len"] for a in anat)

    def pct(p):
        return lens[min(len(lens) - 1, int(len(lens) * p))] if lens else 0

    auth_counter = Counter()
    for t in terms:
        for h in AUTHORITY_HINTS:
            if h in t["q"]:
                auth_counter[h] += 1
    # 失败→改写链: 同一会话 (ts 相邻 <120s) 失败后 3 条内的成功词
    chain_hits = []
    ts_sorted = sorted(terms, key=lambda t: t.get("ts") or 0)
    for i, t in enumerate(ts_sorted):
        if t.get("ok"):
            continue
        for j in range(i + 1, min(i + 4, len(ts_sorted))):
            nxt = ts_sorted[j]
            if (nxt.get("ts") or 0) - (t.get("ts") or 0) > 180000:
                break
            if nxt.get("ok"):
                # 提取差异片段: 共同前缀长度
                a, b = t["q"], nxt["q"]
                k = 0
                while k < min(len(a), len(b)) and a[k] == b[k]:
                    k += 1
                chain_hits.append({
                    "fail": a[:80], "next_ok": b[:80],
                    "prefix_kept": k, "changed_tail": b[k:k + 60],
                })
                break
    return {
        "n_terms": len(terms),
        "ok_rate": round(len(ok_terms) / max(1, len(terms)), 3),
        "len_p10_p50_p90": [pct(.10), pct(.50), pct(.90)],
        "time_coverage": round(sum(a["has_time"] for a in anat) / max(1, len(anat)), 3),
        "authority_coverage": round(sum(1 for a in anat if a["n_auth"]) / max(1, len(anat)), 3),
        "quant_coverage": round(sum(1 for a in anat if a["n_quant"]) / max(1, len(anat)), 3),
        "top_authority_hints": auth_counter.most_common(15),
        "fail_rewrite_chains": chain_hits[:80],
        "fail_samples": [t["q"][:70] for t in fail_terms[:40]],
    }


# ---------------------------------------------------------- B. 计划模板
def mine_plans(pc: dict) -> dict:
    # 原始结构: {sid: [{s,title}, ...], ...} — 每值即一条计划步序列
    chains = list(pc.values()) if isinstance(pc, dict) else pc
    step_counter = Counter()
    verb_counter = Counter()
    n_steps = []
    for steps in chains:
        if not isinstance(steps, list):
            continue
        n_steps.append(len(steps))
        for st in steps:
            title = st.get("title") if isinstance(st, dict) else str(st)
            if not title:
                continue
            step_counter[title[:60]] += 1
            for v in ["检查", "创建", "整合", "补充", "撰写", "确保", "搜索", "分析",
                      "转换", "验证", "优化", "更新", "生成", "下载", "收集", "完善"]:
                if v in title:
                    verb_counter[v] += 1
    n_steps = sorted(x for x in n_steps if x)
    return {
        "n_chains": len(chains),
        "steps_p50": n_steps[len(n_steps) // 2] if n_steps else 0,
        "steps_p90": n_steps[int(len(n_steps) * .9)] if n_steps else 0,
        "top_steps": step_counter.most_common(40),
        "verb_dist": verb_counter.most_common(),
    }


# ---------------------------------------------------------- C. 搜写节奏
def mine_rhythm(ci: dict) -> dict:
    sessions = ci["sessions"]
    per_sess = []
    for key, s in sessions.items():
        seq = s.get("tool_seq") or []
        if len(seq) < 10:
            continue
        n = len(seq)
        n_search = sum(1 for t in seq if t and str(t).startswith("search"))
        n_write = sum(1 for t in seq if t == "text_editor")
        n_term = sum(1 for t in seq if t == "terminal")
        n_browser = sum(1 for t in seq if t == "browser")
        # burst 分析: 连续同类工具的最长段
        bursts, cur_t, cur_n = [], None, 0
        for t in seq:
            t = t or "?"
            if t == cur_t:
                cur_n += 1
            else:
                if cur_t:
                    bursts.append((cur_t, cur_n))
                cur_t, cur_n = t, 1
        if cur_t:
            bursts.append((cur_t, cur_n))
        write_bursts = [b[1] for b in bursts if b[0] == "text_editor"]
        search_bursts = [b[1] for b in bursts if b[0] == "search"]
        per_sess.append({
            "sid": s.get("sid"), "title": (s.get("title") or "")[:40],
            "dur_min": s.get("dur_min"), "n_tools": n,
            "search": n_search, "write": n_write, "terminal": n_term,
            "browser": n_browser,
            "write_ratio": round(n_write / n, 3),
            "max_write_burst": max(write_bursts) if write_bursts else 0,
            "avg_write_burst": round(sum(write_bursts) / len(write_bursts), 1) if write_bursts else 0,
            "max_search_burst": max(search_bursts) if search_bursts else 0,
        })
    wr = sorted(p["write_ratio"] for p in per_sess)
    return {
        "n_sessions": len(per_sess),
        "write_ratio_p50": wr[len(wr) // 2] if wr else 0,
        "write_ratio_p10": wr[len(wr) // 10] if wr else 0,
        "write_ratio_p90": wr[int(len(wr) * .9)] if wr else 0,
        "sample_top_write": sorted(per_sess, key=lambda p: -p["n_tools"])[:30],
    }


def main():
    ci, tu, pc = load_all()
    search = mine_search(tu)
    plans = mine_plans(pc)
    rhythm = mine_rhythm(ci)
    (OUT / "p2_search.json").write_text(json.dumps(search, ensure_ascii=False, indent=1), encoding="utf-8")
    (OUT / "p2_plans.json").write_text(json.dumps(plans, ensure_ascii=False, indent=1), encoding="utf-8")
    (OUT / "p2_rhythm.json").write_text(json.dumps(rhythm, ensure_ascii=False, indent=1), encoding="utf-8")

    md = ["# P2 语料复挖产物 (S3 源·自动生成)", "",
          f"- 搜索词: {search['n_terms']} 条, 成功率 {search['ok_rate']}, "
          f"长度 P10/50/90 = {search['len_p10_p50_p90']}",
          f"- 带年份词占比 {search['time_coverage']}, 点名权威源占比 {search['authority_coverage']}, "
          f"量化词占比 {search['quant_coverage']}",
          f"- 权威源词频 Top: {search['top_authority_hints'][:8]}",
          f"- 失败→改写链样本 {len(search['fail_rewrite_chains'])} 条 (见 p2_search.json)",
          f"- 计划链: {plans['n_chains']} 条, 步数 P50/P90 = {plans['steps_p50']}/{plans['steps_p90']}",
          f"- 动词分布: {plans['verb_dist'][:10]}",
          f"- 节奏: {rhythm['n_sessions']} 会话, 写占比 P10/50/90 = "
          f"{rhythm['write_ratio_p10']}/{rhythm['write_ratio_p50']}/{rhythm['write_ratio_p90']}",
          ""]
    (OUT / "p2_findings.md").write_text("\n".join(md), encoding="utf-8")
    print("\n".join(md))


if __name__ == "__main__":
    main()
