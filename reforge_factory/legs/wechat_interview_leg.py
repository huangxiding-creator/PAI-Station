# -*- coding: utf-8 -*-
"""wechat_interview_leg — P1-4 微信访谈腿 (专家网络免费平替, 终极提案 P1-4, 1028 用户已批).

思想来源: GLG/Third Bridge 访谈前调研包模式 (付费件仅入附录H) +
AlphaSights 合规防火墙机制 → 用自有微信生态 (总包之声矩阵 470+ 群) 做
体系化一手情报获取, 成本 ¥0 (免费宪法)。

三段链:
  experts  ① 从 mission-engine/ledger/signals.jsonl 的 wechat_insight 信号中
              识别领域专家候选 (高频高质量发言者: 频次×专业面板×需求分, 启发式);
  package  ② 基于战役 question_tree 的 E2 反证位 + E3 权威位缺口生成结构化
              访谈任务包 (问题+背景+预期产出格式+合规门) → staging, 用户自发微信;
  recycle  ④ 用户交回访谈记录 (文字/录音转写 md) → 入池 engine=wechat_interview
              (cred=research 一手证据, 挂树 EEI)。

用法:
  py reforge_factory/legs/wechat_interview_leg.py experts [--top 10]
  py reforge_factory/legs/wechat_interview_leg.py package --campaign EPC-TOP50 --question Q1
  py reforge_factory/legs/wechat_interview_leg.py recycle --campaign EPC-TOP50 \
      --file <访谈记录.md> --tree Q1-E2
铁律: 只增不删 / 数字零造假 (专家评分与缺口状态全取实测账本) / 浏览器零开
      (纯文件+入池, 不碰微信客户端) / 密钥不进仓。
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[2]              # E:\AI-Station
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import ammo_pool                                        # noqa: E402

SIGNALS = REPO / "mission-engine" / "ledger" / "signals.jsonl"
#: 自有机器人/系统号不入专家账 (1028 实测在册名)
BOT_NAMES = {"总包ai顾问", "总包君", "vision", "未知", "分享者", "未提及",
             "所有人", ""}


def _panel_passes(panel) -> int:
    if not isinstance(panel, dict):
        return 0
    return sum(1 for v in panel.values() if str(v).strip() in ("过", "是", "True"))


def cmd_experts(ns) -> int:
    if not SIGNALS.is_file():
        print("[interview] signals.jsonl 不存在: %s" % SIGNALS, file=sys.stderr)
        return 2
    tally: dict[str, dict] = {}
    n_sig = 0
    for line in SIGNALS.read_text(encoding="utf-8", errors="replace").splitlines():
        try:
            d = json.loads(line)
        except json.JSONDecodeError:
            continue
        sig = d.get("signal", {})
        if sig.get("source_type") != "wechat_insight":
            continue
        n_sig += 1
        p = sig.get("payload", {})
        ref = (sig.get("evidence") or {}).get("source_ref", {})
        name = str(ref.get("wxid", "") or "").strip()
        if name.lower() in BOT_NAMES or any(
                ch in name for ch in "[]【】、") or name.startswith("["):
            continue                                  # 伪署名(转分享标签等)不入账
        if not name:                                    # 无署名信号不入专家账
            continue
        t = tally.setdefault(name, {"signals": 0, "freq_max": 0, "score_sum": 0,
                                    "panel_pass": 0, "groups": set(),
                                    "quotes": []})
        t["signals"] += 1
        t["freq_max"] = max(t["freq_max"], int(p.get("frequency_7d") or 0))
        t["score_sum"] += int(p.get("score") or 0)
        t["panel_pass"] += _panel_passes(p.get("expert_panel"))
        g = str(ref.get("group", "") or "").strip()
        if g and g not in ("None",):
            t["groups"].add(g)
        if len(t["quotes"]) < 2 and p.get("demand_quote"):
            t["quotes"].append(str(p["demand_quote"])[:80])
    rows = []
    for name, t in tally.items():
        rank = t["score_sum"] + 5 * t["panel_pass"] + 2 * t["freq_max"]
        rows.append({"expert": name, "signals": t["signals"],
                     "freq_7d_max": t["freq_max"],
                     "score_sum": t["score_sum"], "panel_pass_total": t["panel_pass"],
                     "groups": sorted(t["groups"])[:6],
                     "recent_quotes": t["quotes"], "rank_score": rank})
    rows.sort(key=lambda x: -x["rank_score"])
    out = Path(__file__).resolve().parent / "wechat_interview_experts.json"
    out.write_text(json.dumps({"ts": time.strftime("%Y-%m-%d %H:%M"),
                               "wechat_insight_signals": n_sig,
                               "speakers": len(rows),
                               "note": "启发式专家识别: 频次×专业面板×需求分; "
                                       "署名来自微信洞察账本, 无外部专家库; 如实不虚构职称",
                               "candidates": rows[:50]},
                              ensure_ascii=False, indent=1), encoding="utf-8")
    print("[interview] wechat_insight 信号 %d | 有署名发言者 %d | top%d:"
          % (n_sig, len(rows), ns.top))
    for r in rows[:ns.top]:
        print("  %-12s 信号%3d 峰频%2d/7d 面板过%2d 分%4d | 群: %s"
              % (r["expert"], r["signals"], r["freq_7d_max"],
                 r["panel_pass_total"], r["score_sum"],
                 ",".join(r["groups"][:2]) or "-"))
    print("  明细: %s" % out)
    return 0


def _camp(cid: str) -> Path:
    return REPO / "ammo_pool" / cid


def cmd_package(ns) -> int:
    cdir = _camp(ns.campaign)
    tree_p = cdir / "question_tree.json"
    if not tree_p.is_file():
        print("[interview] question_tree 不存在: %s" % tree_p, file=sys.stderr)
        return 2
    tree = json.loads(tree_p.read_text(encoding="utf-8"))
    q = next((x for x in tree.get("subquestions", [])
              if x.get("id") == ns.question), None)
    if q is None:
        print("[interview] 无此问题 id: %s" % ns.question, file=sys.stderr)
        return 2
    gap_eeis = [e for e in q.get("eeis", [])
                if e.get("id", "").endswith(("-E2", "-E3"))]
    state = {}
    sp = cdir / "pool_state.json"
    if sp.is_file():
        state = json.loads(sp.read_text(encoding="utf-8"))
    experts_p = Path(__file__).resolve().parent / "wechat_interview_experts.json"
    experts = []
    if experts_p.is_file():
        experts = json.loads(experts_p.read_text(
            encoding="utf-8")).get("candidates", [])[:5]
    ts = time.strftime("%Y%m%d_%H%M%S")
    stage = cdir / "staging" / "wechat_interview"
    stage.mkdir(parents=True, exist_ok=True)

    md = ["# 微信访谈任务包 | %s · %s" % (ns.campaign, q["id"]), "",
          "> 生成: %s | 引擎: wechat_interview (P1-4, 专家网络免费平替)"
          % time.strftime("%Y-%m-%d %H:%M"), "",
          "## 一、访谈对象画像 (candidates 来自微信洞察专家账, 启发式, 如实)",
          ""]
    if experts:
        for e in experts:
            md.append("- **%s**: 近期高信号 %d 条 (峰频 %d/7d, 专业面板过 %d) — "
                      "近期话题: %s" % (e["expert"], e["signals"], e["freq_7d_max"],
                                        e["panel_pass_total"],
                                        e["recent_quotes"][0] if e["recent_quotes"] else "-"))
    else:
        md.append("- (专家账为空: 先跑 `experts` 子命令生成候选)")
    md += ["", "## 二、背景资料 (访谈前调研包, Third Bridge prep-pack 式)", "",
           "- **战役课题**: %s" % tree.get("topic", ns.campaign),
           "- **本次问题**: %s — %s" % (q["id"], q.get("text", "")),
           "- **可证伪性**: %s (%s)" % (q.get("falsifiable"), q.get("falsify_note", "")),
           "- **已有弹药**: 池 %s 件 / %s 字 (含跨战役存量); 本问题证据位状态: %s"
           % (state.get("items", "?"), format(state.get("total_chars", 0), ","),
              ", ".join("%s=%s" % (e["id"], e.get("status", "?"))
                        for e in q.get("eeis", []))),
           "- **已搜到什么**: 榜单口径类公开材料已备 (支持位 E1); 本次访谈专攻"
           "**反证位与权威位** — 公开渠道拿不到的一手判断。", "",
           "## 三、结构化问题清单 (基于 E2 反证位 + E3 权威位缺口)", ""]
    qi = 0
    for e in gap_eeis:
        slot = "反证位" if e["id"].endswith("-E2") else "权威位"
        md.append("### %s — %s (缺口状态: %s)" % (e["id"], slot, e.get("status", "?")))
        md.append("- 需求: %s" % e.get("need", ""))
        md.append("- 公开检索线索(已用尽): %s" % " / ".join(e.get("queries", [])[:2]))
        if slot == "反证位":
            qs = ["您在实际业务中见过/听过与「%s」主流结论相反的案例或质疑吗? 具体是什么?"
                  % q.get("text", "")[:30],
                  "这些反证里, 哪一条您认为最站得住脚? 依据是什么?",
                  "如果榜单口径确有水分, 您估计偏差主要出在哪个环节(申报/统计/口径)?"]
        else:
            qs = ["关于「%s」, 您所知最权威的官方口径/文件出自哪里? 如何表述?"
                  % q.get("text", "")[:30],
                  "官方口径与市场通行做法之间有哪些已知差异或争议?",
                  "未来12个月, 该权威口径最可能的变化方向是什么? 触发因素?"]
        for qtxt in qs:
            qi += 1
            md.append("%d. %s" % (qi, qtxt))
        md.append("")
    md += ["## 四、预期产出格式 (纪要回收后入池 engine=wechat_interview)", "",
           "每问回收三件套:",
           "1. **一手判断**: 受访者的直接结论 (1-2 句, 标注其身份视角, 不加AI润色);",
           "2. **数据点**: 具体数字+口径+时间 (受访者给的数字如实记, 不换算不补零);",
           "3. **可引用表述**: 可进报告的一句原话 (≥20字, 带受访者定位如「某央企设计院经营部长」)。",
           "",
           "纪要文件体例: `# 访谈纪要|<战役>|<问题id>|<日期>` + 逐问回答 + 末尾`一手判断清单`。",
           "",
           "## 五、合规门 (AlphaSights 防火墙机制移植, 触发即停)", "",
           "- 不问内幕信息 (未公开并购/在审项目报价/个股信息); 触及即换话题并记录;",
           "- 不问竞业限制内的前雇主机密;",
           "- 受访者要求匿名 → 纪要只留身份定位不留姓名;",
           "- 访谈全程自愿, 单次 ≤30 分钟; 任何犹豫即收口。",
           "",
           "---", "",
           "> 回收: `py reforge_factory/legs/wechat_interview_leg.py recycle "
           "--campaign %s --file <纪要.md> --tree %s-E2`"
           % (ns.campaign, ns.question)]
    pkg = stage / ("%s_%s_package.md" % (ts, ns.question))
    pkg.write_text("\n".join(md), encoding="utf-8")
    meta = {"ts": ts, "campaign": ns.campaign, "question": ns.question,
            "gap_eeis": [e["id"] for e in gap_eeis], "questions": qi,
            "package": str(pkg)}
    (stage / ("%s_%s_package.json" % (ts, ns.question))).write_text(
        json.dumps(meta, ensure_ascii=False, indent=1), encoding="utf-8")
    print("[interview] 任务包落 staging: %s (问题%d条, 缺口位%s)"
          % (pkg, qi, ",".join(e["id"] for e in gap_eeis)))
    return 0


def cmd_recycle(ns) -> int:
    fp = Path(ns.file)
    if not fp.is_file():
        print("[interview] 访谈记录不存在: %s" % fp, file=sys.stderr)
        return 2
    cdir = _camp(ns.campaign)
    tree_p = cdir / "question_tree.json"
    tree_ids: set[str] = set()
    if tree_p.is_file():
        t = json.loads(tree_p.read_text(encoding="utf-8"))
        tree_ids = {str(e["id"]) for x in t.get("subquestions", [])
                    for e in x.get("eeis", [])}
    if ns.tree and tree_ids and ns.tree not in tree_ids:
        print("[interview] 树外 EEI: %s (合法: %s…)" % (ns.tree,
              sorted(tree_ids)[:6]), file=sys.stderr)
        return 2
    items = [{"file": str(fp), "engine": "wechat_interview",
              "cred": "research", "tree": ns.tree}]
    added, skipped = ammo_pool.ingest_files(ns.campaign, items)
    print("[interview] 入池 +%d / 跳过 %d (engine=wechat_interview, tree=%s) "
          "→ 下一步: ammo_pool.py judge %s" % (added, skipped, ns.tree, ns.campaign))
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description="微信访谈腿 (P1-4)")
    sub = ap.add_subparsers(dest="cmd", required=True)
    e = sub.add_parser("experts")
    e.add_argument("--top", type=int, default=10)
    p = sub.add_parser("package")
    p.add_argument("--campaign", required=True)
    p.add_argument("--question", required=True)
    r = sub.add_parser("recycle")
    r.add_argument("--campaign", required=True)
    r.add_argument("--file", required=True)
    r.add_argument("--tree", default="", help="挂树 EEI id (如 Q1-E2)")
    ns = ap.parse_args()
    return {"experts": cmd_experts, "package": cmd_package,
            "recycle": cmd_recycle}[ns.cmd](ns)


if __name__ == "__main__":
    raise SystemExit(main())
