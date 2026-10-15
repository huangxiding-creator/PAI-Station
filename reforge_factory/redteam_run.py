# -*- coding: utf-8 -*-
"""redteam_run — 红队轮战役级 runner (T-013 / REQ-043 / KB-REDTEAM-SPEC).

V2 遗产 superline/redteam_gate.py 已有 premortem 条数带 + ICD 203 七档表 +
KAC 部件 (本件只读复用其纯函数, 不改它); 本件把红队轮做成**可独立运行的
战役级 runner**, 供成稿门禁 (REQ-028) 前置调用:

  ① Premortem (Klein 协议): 从战役框架/章清单模板化生成「这份报告为什么
     全错」候选失败路径 3-5 条 — 五族 (数据时效失效/单一信源垄断/口径错配/
     反证缺失/样本偏差) + 战役定制位; 每条 {path, probability_band(ICD 203
     七档), affected_chapters, response_status: unanswered|responded,
     response_note}; 概率由池实测推导 (陈旧行占比/Top 引擎垄断占比/反证
     计数/引擎多样性联动 — 数字零造假, 禁手拍)。framework_md 缺 → 失败路径
     按池维度模板生成并标 degraded, 自动降级回应 (REQ-043: 回应不了的
     章节降级或补采)。
  ② KAC 关键假设检查 (CIA Tradecraft): 读 question_tree.json 根假设
     (树内 hypotheses 节; 缺席以 HYPOTHESIS_SEEDS 种子兜底 — 口径同
     question_tree.py, 本地副本避免拖入 Auto_Manus 依赖), 每根假设查挂树
     against 计数 (valid & tree_node≠空 & stance 含 against/contradict),
     >0 标 ⚠, 0 标「未经反证检验」。
  ③ 落盘 work/redteam_<campaign>.json (V3 work/ 目录) + 退出码:
     有 unanswered 失败路径 → 2 (门禁阻塞, 逐条回应或降级后重跑); 否则 0。
     material_diff 记录 ≥1 条实质修改 (降级/补采登记) 在案 (REQ-043.AC1)。

用法 (repo 根):
  py reforge_factory/redteam_run.py --campaign EPC-BID26 [--framework fw.md]
      [--responses resp.json] [--dry] [--pool-root X] [--work-dir Y]

真实池只读; 输出只增不删。
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from datetime import datetime, timedelta
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

_HERE = Path(__file__).resolve().parent
if str(_HERE) not in sys.path:
    sys.path.insert(0, str(_HERE))
from superline.redteam_gate import (          # noqa: E402  (V2 遗产, 只读复用)
    LIKELIHOOD_BANDS, MAX_PREMORTEM_ITEMS, MIN_PREMORTEM_ITEMS, likelihood_band)

POOL_ROOT = Path(r"E:\AI-Station\ammo_pool")
WORK_DIR = Path(
    r"E:\AI-Station\ResearchFactory-Eng\06 迭代优化\百倍V3_极致调研变现计划\work")
CID_RE = re.compile(r"[A-Za-z0-9_\-]{3,40}")
TREE_NAMES = ("question_tree_v2.json", "question_tree.json")   # v2 优先 v1 兜底
STALE_DAYS = 180                      # 数据时效: 早于今日-180d 记陈旧行
AGAINST_MARKS = ("against", "contradict")

# 失败路径五族 (模板化) + 战役定制位
FAMILIES = ("数据时效失效", "单一信源垄断", "口径错配", "反证缺失", "样本偏差")
CUSTOM_FAMILY = "战役定制"

# 根假设种子 — 口径同 question_tree.HYPOTHESIS_SEEDS (ACH 三竞争假设)。
# 本地副本: question_tree 顶层 import Auto_Manus.search_query_generator,
# 战役级 runner 不应拖该依赖; 树在场时优先读树内 hypotheses 节。
_SEED_TEMPLATES = (
    ("H1", "{s} 处于扩张周期, 机会大于风险", 0.4),
    ("H2", "{s} 已过峰值/竞争恶化, 风险大于机会", 0.3),
    ("H3", "{s} 结构性分化: 细分领域机会与风险并存", 0.3),
)

# 各族 affected_chapters 章名关键词定向 (过滤为空 → 回退全章, 保证非空)
_CHAPTER_FILTERS = {
    "数据时效失效": ("时间", "趋势", "沿革", "年", "现状", "动态", "历程"),
    "单一信源垄断": ("数据", "规模", "市场", "统计", "格局", "份额"),
    "口径错配": ("口径", "政策", "法规", "标准", "统计", "定义", "制度"),
    "反证缺失": ("风险", "竞争", "格局", "反例", "挑战", "争议", "瓶颈"),
    "样本偏差": ("案例", "样本", "企业", "项目", "主体", "名录"),
}

# 降级模式 (framework 缺) 每族补采项 — 降级回应的实质内容
_SUPPLEMENTS = {
    "数据时效失效": "补采: 近 %dd 增量弹药入池后重评时效占比" % STALE_DAYS,
    "单一信源垄断": "补采: 独立第二源渠道入建渠队列 (REQ-029 四步法)",
    "口径错配": "补采: 权威口径原文比对 (govlist/cnki 直采)",
    "反证缺失": "补采: 反证腿查询 (风险/纠纷/处罚词面) 挂树",
    "样本偏差": "补采: 缺口渠道扩样 (C 轴 miss_list 对接)",
    "战役定制": "补采: 战役框架 framework_md 补齐后重跑红队轮",
}

_RESPONSE_ACTION_WORDS = ("补采", "降级", "修改", "重写", "删除", "改写")


# ---------- 纯函数 (不改入参, 无 IO) ----------------------------------------

def extract_chapters(framework_md: str) -> tuple[list[str], str]:
    """框架 md → (章名清单, 主题). 章 = 1-3 级标题; 主题 = 首个一级标题."""
    heads = [h.strip() for h in
             re.findall(r"^#{1,3}\s+(.+?)\s*$", str(framework_md or ""), re.M)
             if h.strip()]
    topic = heads[0] if heads else ""
    return heads[:24], topic


def _is_against(row: dict) -> bool:
    s = str(row.get("stance") or "").lower()
    return any(m in s for m in AGAINST_MARKS)


def pool_stats(rows: list[dict], today: datetime | None = None) -> dict:
    """manifest 行 → 概率推导用实测统计 (纯函数).

    stale_share: valid 行 chars 加权陈旧行占比 (ts 解析失败/缺失记新鲜但在
    ts_missing 计数显形, 不静默); top_engine_share: Top 引擎 valid chars 占比;
    n_engines: valid 行去重引擎数; against_linked: 挂树反证行数 (valid &
    tree_node 非空 & stance against).
    """
    now = today or datetime.now()
    cutoff = now - timedelta(days=STALE_DAYS)
    valid = [r for r in rows if r.get("judge") == "valid"]
    total = sum(int(r.get("chars") or 0) for r in valid)
    stale_chars = ts_missing = 0
    by_engine: dict[str, int] = {}
    for r in valid:
        c = int(r.get("chars") or 0)
        by_engine[str(r.get("engine") or "?")] = \
            by_engine.get(str(r.get("engine") or "?"), 0) + c
        ts = str(r.get("ts") or "")
        try:
            dt = datetime.fromisoformat(ts) if ts else None
        except ValueError:
            dt = None
        if dt is None:
            ts_missing += 1
        elif dt < cutoff:
            stale_chars += c
    top_engine, top_chars = (max(by_engine.items(), key=lambda kv: kv[1])
                             if by_engine else ("", 0))
    against = [r for r in valid
               if str(r.get("tree_node") or "").strip() and _is_against(r)]
    return {
        "valid_rows": len(valid), "valid_chars": total,
        "stale_chars": stale_chars,
        "stale_share": round(stale_chars / total, 4) if total else 0.0,
        "ts_missing": ts_missing,
        "top_engine": top_engine,
        "top_engine_share": round(top_chars / total, 4) if total else 0.0,
        "n_engines": len(by_engine),
        "against_linked_rows": len(against),
        "against_linked_nodes": sorted(
            {str(r.get("tree_node")) for r in against}),
    }


def family_probability(family: str, st: dict, has_tree: bool) -> float:
    """族 → 失败概率百分数 (池实测联动; ICD 带由 likelihood_band 落档)."""
    if family == "数据时效失效":
        pct = 35 + 40 * st.get("stale_share", 0.0)
    elif family == "单一信源垄断":
        pct = 30 + 45 * st.get("top_engine_share", 0.0)
    elif family == "口径错配":
        pct = 45          # 口径证据池内不可直接测得 — 先验档, 显式注明
    elif family == "反证缺失":
        n = st.get("against_linked_rows", 0)
        if not has_tree:
            pct = 85      # 树缺位 → 反证检验本身不可能发生
        elif n == 0:
            pct = 80
        else:
            pct = max(25, 80 - 15 * min(n, 4))
    elif family == "样本偏差":
        pct = 25 + 40 * (1 - min(st.get("n_engines", 0), 10) / 10)
    else:                                 # 战役定制位
        pct = 55
    return round(max(2.0, min(98.0, pct)), 1)


def _target_chapters(family: str, chapters: list[str]) -> list[str]:
    """族定向章 (关键词过滤为空 → 回退全章; 始终非空有底)."""
    if not chapters:
        return []
    kws = _CHAPTER_FILTERS.get(family, ())
    if family == CUSTOM_FAMILY:
        return chapters[:2] if len(chapters) > 2 else list(chapters)
    hit = [c for c in chapters if any(k in c for k in kws)]
    return hit or list(chapters)


def build_failure_paths(campaign: str, chapters: list[str], topic: str,
                        st: dict, has_tree: bool, framework_degraded: bool,
                        kws: list[str]) -> list[dict]:
    """五族+定制位 → 候选 → 概率降序裁剪至 3-5 条 (确定性)."""
    pool_dims = [f"(降级) 池维度: {k}" for k in (kws or [])[:3]] or \
        [f"(降级) 池维度: {campaign}"]
    cutoff_note = f"早于今日-{STALE_DAYS}d"
    texts = {
        "数据时效失效": (
            f"池内 valid 弹药陈旧行占比 {st.get('stale_share', 0):.1%} "
            f"({st.get('stale_chars', 0):,}/{st.get('valid_chars', 0):,} 字符"
            f" {cutoff_note}); 市场与政策数据时效失效后, 报告发布即过期, "
            "全篇量级判断被新数据推翻"),
        "单一信源垄断": (
            f"Top 引擎 {st.get('top_engine') or '-'} 供给占比 "
            f"{st.get('top_engine_share', 0):.1%}; 该渠道口径系统性偏差"
            " (收录偏置/截断) 时, 「多源交叉」实为同源复读, 全篇数字连带失真"),
        "口径错配": (
            "各章引用数据的统计口径 (含/不含口径、注册地vs备案地、年度vs财年)"
            "与结论口径错配, 量级判断整体漂移 (池内不可直接测得, 按先验档警戒)"),
        "反证缺失": (
            f"挂树反证行 {st.get('against_linked_rows', 0)} 条; 反证腿缺位时"
            " 幸存者偏差主导, 「机会大于风险」类根假设未经检验即出厂"),
        "样本偏差": (
            f"有效弹药引擎仅 {st.get('n_engines', 0)} 个; 渠道覆盖偏样本"
            " (如只采存量库不采增量舆情), 整体画像向已收录样本偏斜"),
    }
    base_topic = topic or (kws[0] if kws else campaign)
    texts[CUSTOM_FAMILY] = (
        f"战役定制: 「{base_topic}」框架以 {len(chapters)} 章承载核心判断, "
        "若框架族假设 (增长/格局/对策) 与实际市场阶段错位, 全篇对策建议失效"
        + ("; 战役框架缺席, 本条按战役主题模板生成 (degraded)"
           if framework_degraded else ""))

    order = [CUSTOM_FAMILY] + list(FAMILIES)
    cands = []
    for i, fam in enumerate(order):
        pct = family_probability(fam, st, has_tree)
        word, band = likelihood_band(pct)
        aff = _target_chapters(fam, chapters) if not framework_degraded \
            else pool_dims
        cands.append({
            "id": f"FP-{i + 1}", "family": fam,
            "path": "「这份报告为什么全错」候选: " + texts[fam],
            "probability_pct": pct,
            "probability_band": f"{word} {band}",
            "affected_chapters": aff,
            "degraded": framework_degraded,
            "response_status": "unanswered", "response": "", "response_note": "",
        })
    cands.sort(key=lambda p: (-p["probability_pct"], order.index(p["family"])))
    keep = cands[:MAX_PREMORTEM_ITEMS]
    assert MIN_PREMORTEM_ITEMS <= len(keep) <= MAX_PREMORTEM_ITEMS
    return keep


def degrade_response(path: dict, campaign: str) -> str:
    """framework 缺席时的自动降级回应 (REQ-043: 降级或补采)."""
    fam = path["family"]
    return (f"降级回应: 战役 {campaign} 无框架, 该失败路径按池维度模板生成 "
            f"(degraded); {_SUPPLEMENTS.get(fam, _SUPPLEMENTS[CUSTOM_FAMILY])}")


def apply_responses(paths: list[dict], responses: dict | None,
                    campaign: str, framework_degraded: bool) -> None:
    """逐条登记回应 (键认 family 或 id); degraded 模式未答路径自动降级回应."""
    resp = {str(k): str(v) for k, v in (responses or {}).items()}
    for p in paths:
        note = resp.get(p["family"]) or resp.get(p["id"]) or ""
        if not note and framework_degraded:
            note = degrade_response(p, campaign)
        if note:
            p["response_status"] = "responded"
            p["response"] = note
            p["response_note"] = note
        else:
            p["response_status"] = "unanswered"
            p["response"] = ""
            p["response_note"] = ""


def build_kac(pool_dir: Path, rows: list[dict],
              campaign: str, kws: list[str]) -> dict:
    """根假设 × 挂树 against 计数. 树缺 → 种子假设兜底 + degraded."""
    tree, tree_src = {}, ""
    for name in TREE_NAMES:
        p = pool_dir / name
        if p.is_file():
            try:
                tree = json.loads(p.read_text(encoding="utf-8"))
                tree_src = str(p)
            except json.JSONDecodeError:
                tree, tree_src = {}, ""
            break
    hyps = [h for h in (tree.get("hypotheses") or [])
            if isinstance(h, dict) and str(h.get("text") or "").strip()]
    topic = str(tree.get("topic") or "") or (kws[0] if kws else campaign)
    degraded = not tree
    degraded_note = ""
    if not hyps:                       # 树缺 或 树无 hypotheses 节 → 种子兜底
        if tree:
            degraded_note = "树在档但无 hypotheses 节, 以 HYPOTHESIS_SEEDS 种子兜底"
        hyps = [{"id": hid, "text": tpl.format(s=topic), "prior": prior}
                for hid, tpl, prior in _SEED_TEMPLATES]
        degraded = True
    st = pool_stats(rows)
    n_against = st["against_linked_rows"]
    roots = []
    for h in hyps:
        roots.append({
            "id": str(h.get("id") or ""), "text": str(h.get("text")),
            "prior": h.get("prior"),
            "against_count": n_against,
            "flag": (f"⚠ 反证在树({n_against}条)" if n_against > 0
                     else "未经反证检验"),
        })
    return {
        "source": tree_src or None,
        "degraded": degraded,
        "note": "; ".join(x for x in (
            "question_tree 缺席, 根假设以种子模板兜底 (未经实测挂树)"
            if not tree else "",
            degraded_note,
            "树未提供 假设↔EEI 显式挂接, against 计数为战役级挂树口径 "
            f"(valid & tree_node≠空 & stance 含 {'/'.join(AGAINST_MARKS)})",
        ) if x),
        "root_hypotheses": roots,
        "against_linked_rows": n_against,
        "against_linked_nodes": st["against_linked_nodes"],
    }


def material_diffs(paths: list[dict], campaign: str,
                   out_path: Path) -> list[dict]:
    """实质修改在案 (REQ-043.AC1): 回应声明降级/补采/修改动作的路径入册."""
    out = []
    for p in paths:
        if p["response_status"] != "responded":
            continue
        note = p["response_note"]
        if any(w in note for w in _RESPONSE_ACTION_WORDS):
            out.append({"failure_path": p["id"], "family": p["family"],
                        "change": note, "recorded_in": str(out_path)})
    return out


# ---------- 战役 IO (真实池只读; 输出只增) -----------------------------------

def _load_jsonl(path: Path) -> list[dict]:
    rows = []
    if path.is_file():
        for ln in path.read_text(encoding="utf-8").splitlines():
            ln = ln.strip()
            if ln:
                try:
                    rows.append(json.loads(ln))
                except json.JSONDecodeError:
                    continue
    return rows


def _load_json(path: Path) -> dict:
    if path.is_file():
        try:
            return json.loads(path.read_text(encoding="utf-8"))
        except json.JSONDecodeError:
            return {}
    return {}


def run(campaign: str, framework_md: str | None = None,
        responses: dict | None = None, pool_root: Path = POOL_ROOT,
        work_dir: Path = WORK_DIR, dry: bool = False) -> dict:
    """红队轮一战役一跑: premortem + KAC → work/redteam_<campaign>.json.

    退出码语义: 有 unanswered 失败路径 → 2 (阻塞成稿门禁); 否则 0。
    """
    if not CID_RE.fullmatch(campaign or ""):
        raise ValueError(f"campaign 非法: {campaign!r} (须匹配 {CID_RE.pattern})")
    pool_dir = Path(pool_root) / campaign
    rows = _load_jsonl(pool_dir / "manifest.jsonl")
    state = _load_json(pool_dir / "pool_state.json")
    kws = [str(k) for k in (state.get("kws") or [])]

    framework_degraded = not str(framework_md or "").strip()
    chapters, topic = ([], "") if framework_degraded \
        else extract_chapters(framework_md)
    st = pool_stats(rows)
    kac = build_kac(pool_dir, rows, campaign, kws)
    paths = build_failure_paths(campaign, chapters, topic, st,
                                has_tree=bool(kac["source"]),
                                framework_degraded=framework_degraded,
                                kws=kws)
    apply_responses(paths, responses, campaign, framework_degraded)

    out_dir = Path(work_dir)
    out_path = out_dir / f"redteam_{campaign}.json"
    diffs = material_diffs(paths, campaign, out_path)
    unanswered = [p["id"] for p in paths if p["response_status"] == "unanswered"]
    report = {
        "campaign": campaign,
        "engine": "redteam_run v3 (T-013, REQ-043)",
        "generated": time.strftime("%Y-%m-%d %H:%M"),
        "framework_degraded": framework_degraded,
        "framework": {
            "degraded": framework_degraded,
            "n_chapters": len(chapters),
            "topic": topic or None,
            "note": ("战役框架 framework_md 缺席 — 失败路径按池维度模板生成 "
                     "并标 degraded (如实)" if framework_degraded
                     else "失败路径 affected_chapters 定自战役框架章清单"),
        },
        "pool_stats": st,
        "failure_paths": paths,
        "kac": kac,
        "unanswered": unanswered,
        "material_diff": diffs,
        "exit_code": 2 if unanswered else 0,
        "output_path": str(out_path),
    }
    if not dry:
        out_dir.mkdir(parents=True, exist_ok=True)
        out_path.write_text(json.dumps(report, ensure_ascii=False, indent=1),
                            encoding="utf-8")
    return report


# ---------- CLI --------------------------------------------------------------

def _main(argv: list[str]) -> int:
    ap = argparse.ArgumentParser(
        description="红队轮战役级 runner: premortem 失败路径 3-5 条 + KAC 根假设检验 (REQ-043)")
    ap.add_argument("--campaign", required=True)
    ap.add_argument("--framework", help="战役框架 md 路径 (缺席 → degraded)")
    ap.add_argument("--responses", help="回应登记 json 路径 ({family|id: note})")
    ap.add_argument("--pool-root", default=str(POOL_ROOT))
    ap.add_argument("--work-dir", default=str(WORK_DIR))
    ap.add_argument("--dry", action="store_true", help="只跑不落盘")
    ns = ap.parse_args(argv)
    fw = Path(ns.framework).read_text(encoding="utf-8") if ns.framework else None
    resp = _load_json(Path(ns.responses)) if ns.responses else None
    rep = run(ns.campaign, framework_md=fw, responses=resp,
              pool_root=Path(ns.pool_root), work_dir=Path(ns.work_dir),
              dry=ns.dry)
    for p in rep["failure_paths"]:
        mark = {"responded": "✓ 已回应", "unanswered": "✗ 未回应"}[
            p["response_status"]]
        print(f"[redteam] {p['id']} {p['family']} "
              f"[{p['probability_band']}] {mark} → "
              f"受影响章 {len(p['affected_chapters'])}")
    for h in rep["kac"]["root_hypotheses"]:
        print(f"[redteam] KAC {h['id']} {h['flag']}: {h['text'][:40]}")
    if rep["kac"]["degraded"]:
        print(f"[redteam] KAC degraded: {rep['kac']['note']}")
    print(f"[redteam] material_diff {len(rep['material_diff'])} 条在案 | "
          f"unanswered {len(rep['unanswered'])} | exit {rep['exit_code']} → "
          f"{rep['output_path']}")
    return rep["exit_code"]


if __name__ == "__main__":
    sys.exit(_main(sys.argv[1:]))
