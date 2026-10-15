# -*- coding: utf-8 -*-
"""T-007A / REQ-021 — T 轴传感器 entity_timeline: 全史时间轴账本.

数据源 = ammo_pool/<cid>/manifest.jsonl 每行, 读其 path/text 摘要字段
(source_path / url_norm / text_head); 仅 judge=valid 行, dedup_key 去重
(manifest 行=文件×问题对, 行累加=虚账 — 与 ammo_pool.tier_report 同约定).

  年份提取   (?<!\\d)((?:19|20)\\d{2})(?!\\d) 数字边界守卫 (2015 不命中
             12015/20155), 只收 1950..current_year;
  对象共现   行文本(text_head)或路径(source_path)含任一对象词才计数;
             对象词表缺位 → fail-soft: 降级出全池年谱并标
             object_terms_missing, 恒不判绿;
  里程碑     文件名或 text_head 头部含事件词(成立/注册/中标/签约/投产/
             收购/重组/上市/兼并/更名/改制)的命中行单列;
  founded    最早「成立/注册」里程碑年; 无从判断取最早证据年-1 并标
             founded_year_estimated=true;
  空窗年     founded_year..current_year 中 count=0 的年; gap_waivers
             空列表待人工/后续登记 (注明查无依据=三史+官网+年报均查无),
             apply_waivers 纯函数登记后重算 green; 重跑自动带上池内
             已有豁免, 不抹人工登记;
  green      无未豁免空窗年.

输出双落盘 (同内容):
  ammo_pool/<cid>/completeness/T_axis.json  — 五轴账本 T 轴节 (KB 规格)
  ammo_pool/<cid>/timeline.json             — REQ-021.AC1 正名

用法:
  py reforge_factory/completeness/entity_timeline.py --campaign EPC-BID26
"""
from __future__ import annotations

import argparse
import datetime as _dt
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

STATION = Path(__file__).resolve().parents[2]      # E:\\AI-Station (任意 checkout 可移)
DEFAULT_POOL_ROOT = STATION / "ammo_pool"          # 与 ammo_pool._camp_dir 同约定
YEAR_RE = re.compile(r"(?<!\d)((?:19|20)\d{2})(?!\d)")   # 数字边界守卫 (F1)
MIN_YEAR = 1950                                    # 近现代史下界, 防文本背景噪声
CID_RE = re.compile(r"[A-Za-z0-9_\\-]{3,40}")

# 事件词表 (REQ-021: 「成立/注册/中标/签约/投产/收购/重组/上市」等)
EVENT_WORDS = ("成立", "注册", "中标", "签约", "投产",
               "收购", "重组", "上市", "兼并", "更名", "改制")
FOUNDING_WORDS = ("成立", "注册")                   # founded_year 锚词
TITLE_HEAD = 200                                   # 里程碑「标题」判定窗 (字)
MILESTONE_CAP = 200                                # 账本里程碑条数上限


# ---------- 纯函数核心 (不可变: 读 → 新对象) ----------
def row_years(text: str, current_year: int) -> set[int]:
    """文本年谱: 数字边界守卫正则提年, 只收 [MIN_YEAR, current_year]."""
    ys = {int(m) for m in YEAR_RE.findall(text or "")}
    return {y for y in ys if MIN_YEAR <= y <= current_year}


def _is_milestone(blob: str) -> list[str]:
    """标题/文件名含事件词 → 命中的事件词列表 (去重保序)."""
    head = blob[:TITLE_HEAD]
    return [w for w in EVENT_WORDS if w in blob or w in head]


def scan(campaign: str, object_names: list[str],
         pool_root: Path | None = None, current_year: int | None = None,
         gap_waivers: list[dict] | None = None) -> dict:
    """扫池出 T 轴账本节 (纯读, 不落盘).

    campaign        战役 id (ammo_pool/<cid>);
    object_names    对象词表 (CLI 缺省读 tiers.json T1 键);
    current_year    账本右端年, 缺省=今年;
    gap_waivers     已登记豁免 [{year, reason}] (重跑保留人工登记用).
    fail-soft: 对象词表缺位 → 降级全池年谱 + object_terms_missing, 恒不绿;
    池无 manifest → FileNotFoundError (调用方/CLI 兜底).
    """
    if not CID_RE.fullmatch(campaign):
        raise ValueError(f"非法 campaign_id: {campaign}")
    root = Path(pool_root) if pool_root else DEFAULT_POOL_ROOT
    cur = int(current_year) if current_year else _dt.date.today().year
    camp = root / campaign
    mp = camp / "manifest.jsonl"
    if not mp.is_file():
        raise FileNotFoundError(f"战役无 manifest: {mp}")

    terms = [str(t) for t in (object_names or []) if str(t).strip()]
    degraded = not terms
    year_counts: dict[int, int] = {}
    milestones: list[dict] = []
    founding_years: list[int] = []
    seen: set[str] = set()
    rows = matched = 0
    for line in mp.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line:
            continue
        try:
            r = json.loads(line)
        except json.JSONDecodeError:
            continue
        if r.get("judge") != "valid":              # 只认 valid 行
            continue
        key = r.get("dedup_key") or r.get("url_norm") or r.get("source_path") or ""
        if key:
            if key in seen:                        # 行累加=虚账 (G-014 同判)
                continue
            seen.add(key)
        rows += 1
        blob = " ".join((r.get("text_head") or "", r.get("source_path") or ""))
        if not degraded and not any(t in blob for t in terms):
            continue                               # 对象不共现 → 不计数
        matched += 1
        ys = row_years(blob + " " + (r.get("url_norm") or ""), cur)
        for y in ys:
            year_counts[y] = year_counts.get(y, 0) + 1
        hits = _is_milestone(blob)
        if hits:
            title = Path(r.get("source_path") or "").name or (r.get("text_head") or "")[:80]
            for w in hits:
                if w in FOUNDING_WORDS:
                    founding_years.extend(ys)
                for y in sorted(ys):
                    milestones.append({"year": y, "keyword": w,
                                       "title": str(title)[:80],
                                       "source_path": r.get("source_path") or ""})

    evid_years = sorted(y for y, c in year_counts.items() if c > 0)
    if not evid_years:
        # 池内无可定位年代证据 → 账本空, 恒不绿 (交人工/后续补采集)
        rec = _record(campaign, terms, None, True, cur, {}, [], [], gap_waivers or [],
                      rows, matched, degraded, no_evidence=True)
        return rec
    if founding_years:
        founded, estimated = min(founding_years), False
    else:
        founded, estimated = evid_years[0] - 1, True   # 无从判断 → 最早证据年-1
    span = {y: year_counts.get(y, 0) for y in range(founded, cur + 1)}  # 缺年零填
    milestones.sort(key=lambda m: (m["year"], m["keyword"]))
    rec = _record(campaign, terms, founded, estimated, cur, span,
                  milestones[:MILESTONE_CAP], evid_years, gap_waivers or [],
                  rows, matched, degraded,
                  truncated=len(milestones) > MILESTONE_CAP)
    return rec


def _record(campaign: str, terms: list[str], founded: int | None, estimated: bool,
            cur: int, span: dict[int, int], milestones: list[dict],
            evid_years: list[int], waivers: list[dict], rows: int, matched: int,
            degraded: bool, *, truncated: bool = False,
            no_evidence: bool = False) -> dict:
    """组装账本节 + green 判定 (green = 无未豁免空窗年; 词表缺位恒不绿)."""
    gap = [y for y in sorted(span) if span[y] == 0]
    good_waivers = [w for w in waivers
                    if isinstance(w, dict) and w.get("year") and str(w.get("reason") or "").strip()]
    waived = {int(w["year"]) for w in good_waivers}
    green = (not degraded) and (not no_evidence) and all(y in waived for y in gap)
    rec: dict = {
        "axis": "T", "sensor": "entity_timeline",
        "object": terms[0] if len(terms) == 1 else campaign,
        "object_terms": terms,
        "object_source": "tiers.json:T1",
        "founded_year": founded,
        "founded_year_estimated": estimated,
        "current_year": cur,
        "year_counts": {str(y): span[y] for y in sorted(span)},
        "milestones": milestones,
        "milestones_truncated": truncated,
        "gap_years": gap,
        "gap_waivers": good_waivers,
        "green": green,
        "rows_scanned": rows, "rows_matched": matched,
        "campaign": campaign,
        "generated_at": time.strftime("%Y-%m-%dT%H:%M:%S"),
    }
    if degraded:
        rec["object_terms_missing"] = True       # fail-soft 标记 (恒不绿)
    if no_evidence:
        rec["no_evidence_years"] = True
    return rec


def apply_waivers(record: dict, waivers: list[dict]) -> dict:
    """登记豁免 (纯函数, 新对象): 只收带非空 reason 的条目, 重算 green.

    REQ-021: 空窗年须显式豁免登记且注明查无依据 — 无 reason 的条目
    不算豁免; 原 record 分毫不动.
    """
    good = [w for w in waivers
            if isinstance(w, dict) and w.get("year") and str(w.get("reason") or "").strip()]
    rec = {**record, "gap_waivers": good}
    waived = {int(w["year"]) for w in good}
    rec["green"] = all(y in waived for y in rec.get("gap_years", []))
    return rec


def load_object_terms(campaign: str, pool_root: Path | None = None) -> list[str]:
    """对象词表 = 战役 tiers.json 的 T1 键 (实测为词表 list); 缺位 → []."""
    root = Path(pool_root) if pool_root else DEFAULT_POOL_ROOT
    tp = root / campaign / "tiers.json"
    if not tp.is_file():
        return []
    try:
        cfg = json.loads(tp.read_text(encoding="utf-8"))
    except json.JSONDecodeError:
        return []
    return [str(t) for t in (cfg.get("T1") or []) if str(t).strip()]


def load_existing_waivers(campaign: str, pool_root: Path | None = None) -> list[dict]:
    """重跑保留: 读池内已有 timeline.json / T_axis.json 的 gap_waivers."""
    root = Path(pool_root) if pool_root else DEFAULT_POOL_ROOT
    for name in ("timeline.json", "completeness/T_axis.json"):
        p = root / campaign / name
        if p.is_file():
            try:
                w = json.loads(p.read_text(encoding="utf-8")).get("gap_waivers")
            except json.JSONDecodeError:
                continue
            if isinstance(w, list):
                return w
    return []


# ---------- 落盘 (原子写, 只增自己的轴文件) ----------
def write_axis(record: dict, campaign: str,
               pool_root: Path | None = None) -> list[Path]:
    """双落盘同内容: completeness/T_axis.json (五轴账本) +
    timeline.json (REQ-021.AC1 正名). 原子替换, 返回写入路径列表."""
    root = Path(pool_root) if pool_root else DEFAULT_POOL_ROOT
    camp = root / campaign
    outs = [camp / "completeness" / "T_axis.json", camp / "timeline.json"]
    payload = json.dumps(record, ensure_ascii=False, indent=1)
    for p in outs:
        p.parent.mkdir(parents=True, exist_ok=True)
        tmp = p.with_suffix(p.suffix + ".tmp")
        tmp.write_text(payload, encoding="utf-8")
        tmp.replace(p)
    return outs


# ---------- CLI ----------
def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(
        description="T-007A T轴传感器 entity_timeline — 全史时间轴账本 (REQ-021)")
    ap.add_argument("--campaign", required=True, help="campaign_id (如 EPC-BID26)")
    ap.add_argument("--pool-root", default=None,
                    help="ammo_pool 根 (缺省 E:\\AI-Station\\ammo_pool)")
    ap.add_argument("--current-year", type=int, default=None,
                    help="账本右端年 (缺省=今年; 测试注入用)")
    ap.add_argument("--object", action="append", default=[],
                    help="覆盖对象词 (可多次; 缺省读 tiers.json T1)")
    args = ap.parse_args(argv)

    pool_root = Path(args.pool_root) if args.pool_root else None
    try:
        terms = args.object or load_object_terms(args.campaign, pool_root)
        if not terms:
            print(f"[T-axis] ⚠ 对象词表缺失 (tiers.json T1) — fail-soft 降级全池年谱, "
                  f"恒不判绿: {args.campaign}", file=sys.stderr)
        waivers = load_existing_waivers(args.campaign, pool_root)
        rec = scan(args.campaign, terms, pool_root=pool_root,
                   current_year=args.current_year, gap_waivers=waivers)
        outs = write_axis(rec, args.campaign, pool_root=pool_root)
    except (ValueError, OSError, json.JSONDecodeError) as e:
        print(f"[T-axis] 错误: {e}", file=sys.stderr)
        return 1
    print(f"[T-axis] 对象={rec['object']} (词表 {len(rec['object_terms'])} 词) "
          f"founded={rec['founded_year']}"
          f"{'(estimated)' if rec['founded_year_estimated'] else ''} "
          f"→ {rec['current_year']} | 证据行 {rec['rows_matched']}/"
          f"{rec['rows_scanned']} | 里程碑 {len(rec['milestones'])}"
          f"{'(截断)' if rec['milestones_truncated'] else ''} | "
          f"空窗年 {len(rec['gap_years'])} | 豁免 {len(rec['gap_waivers'])} | "
          f"green={rec['green']}")
    for p in outs:
        print(f"[T-axis] 已写: {p}")
    if rec["gap_years"] and not rec["green"]:
        print(f"[T-axis] 待登记豁免年 (三史+官网+年报查无依据, 人工/后续填): "
              f"{rec['gap_years'][:30]}{'…' if len(rec['gap_years']) > 30 else ''}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
