# -*- coding: utf-8 -*-
"""FT-6 实体覆盖账本 — 检索穷举可证明 (对标 LDR#0: SimpleQA 96.51% 核心机制).

机制出处 (LDR#0): SimpleQA 高分靠的不是模型更聪明, 而是把课题拆成实体
维度后**程序化穷举检索** — 每个实体组合都被显式搜过一遍, 覆盖矩阵无
白格才算调研完成. 本件把该机制做成账本:

  五类实体   TEMPORAL(时间) / NUMERICAL(数字) / NAMES(主体名) /
             LOCATIONS(地点) / DESCRIPTORS(描述词);
  组合键     一次检索用到的实体集合 = 排序去重 tuple (跨顺序去重);
  程序化回填 NAMES×DESCRIPTORS 笛卡尔积 + NAMES×TEMPORAL(年份范围
             逐年展开, "2019-2023" → 5 年), 过滤已搜组合 → 建议清单;
  窄检索预警 连续 >=3 次零结果 → 提示放宽检索面 (减约束/换同义词/去维度).

与 question_tree (G1) / ammo_pool (F-2) 同战役目录共存 (ammo_pool/<cid>/),
状态文件 entity_matrix.json; 全操作不可变 (读 → 新对象 → 原子写回).

用法:
  python entity_coverage.py init --cid X --topic "..." [--entity NAMES=a,b ...]
  python entity_coverage.py record --cid X --query "..." [--hits N]
  python entity_coverage.py backfill --cid X --cap 20
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

STATION = Path(r"E:\AI-Station")
POOL_ROOT = STATION / "ammo_pool"   # 与 ammo_pool._camp_dir 同约定
STATE_NAME = "entity_matrix.json"

ENTITY_KINDS = ("TEMPORAL", "NUMERICAL", "NAMES", "LOCATIONS", "DESCRIPTORS")
NARROW_HINT = "检索太窄了: 减少约束词/换同义词/去掉一个实体维度"
CID_RE = re.compile(r"[A-Za-z0-9_\-]{3,40}")
YEAR_RANGE = re.compile(r"^\s*((?:19|20)\d{2})\s*[-–—~至]\s*((?:19|20)\d{2})\s*$")


# ---------- 账本核心 (纯函数, 不可变: 返回新对象) ----------
def new_ledger(topic: str) -> dict:
    """新账本: 五类实体空集 + 已搜查询/组合空账 + 零结果连击清零."""
    return {"topic": topic,
            "entities": {k: [] for k in ENTITY_KINDS},
            "searched": [], "combos": [],
            "zero_result_streak": 0,
            "ts": time.strftime("%Y-%m-%dT%H:%M:%S")}


def combo_key(entities_used: list[str]) -> list[str]:
    """组合键: 排序去重 (tuple 语义, JSON 落盘形态为 list)."""
    return sorted({str(e).strip() for e in entities_used if str(e).strip()})


def record_searched(ledger: dict, query: str, entities_used: list[str]) -> dict:
    """记账一次检索: query 入 searched, 组合键入 combos (去重) — 新对象."""
    key = combo_key(entities_used)
    combos = ledger.get("combos", [])
    if key not in combos:
        combos = [*combos, key]
    return {**ledger, "searched": [*ledger.get("searched", []), query],
            "combos": combos}


def expand_years(temporal: list[str]) -> list[str]:
    """时间范围展开: '2019-2023' → 逐年; 单年/其他原样透传."""
    out: list[str] = []
    for t in temporal:
        m = YEAR_RANGE.match(str(t))
        if not m:
            out.append(str(t).strip())
            continue
        a, b = int(m.group(1)), int(m.group(2))
        step = 1 if b >= a else -1
        out.extend(str(y) for y in range(a, b + step, step))
    return out


def _suggestions(pairs: list[tuple[str, str]], topic: str,
                 done: set, cap: int) -> list[dict]:
    """(name, other) 对 → 去重后的回填建议 (含 query 文本+组合键)."""
    out: list[dict] = []
    for n, other in pairs:
        key = tuple(sorted([n, other]))
        if key in done:
            continue
        done.add(key)
        out.append({"query": " ".join(x for x in (topic, n, other) if x),
                    "combo": list(key)})
        if len(out) >= cap:
            break
    return out


def unsearched_combos(ledger: dict, cap: int = 20) -> list[dict]:
    """程序化回填 (检索穷举): NAMES×DESCRIPTORS 笛卡尔积 +
    NAMES×TEMPORAL(年份范围逐年), 过滤已搜组合 → [{query, combo}],
    每条含回填 query 文本与组合键; 上限 cap 条."""
    ent = ledger.get("entities", {})
    names = [str(n) for n in ent.get("NAMES", [])]
    topic = str(ledger.get("topic", ""))
    done = {tuple(c) for c in ledger.get("combos", [])}
    cross = [(n, d) for n in names for d in ent.get("DESCRIPTORS", [])]
    yearly = [(n, y) for n in names
              for y in expand_years(ent.get("TEMPORAL", []))]
    return (_suggestions(cross, topic, done, cap)
            + _suggestions(yearly, topic, done, cap))[:cap]


def narrow_hint(ledger: dict) -> str | None:
    """连续 >=3 次零结果 → 返回放宽指令文本, 否则 None (LDR#0 召回面)."""
    return NARROW_HINT if ledger.get("zero_result_streak", 0) >= 3 else None


def record_result(ledger: dict, n_results: int) -> dict:
    """结果记账: n==0 → streak+1, 有结果 → 清零 — 新对象, 原 ledger 不动."""
    streak = (ledger.get("zero_result_streak", 0) + 1) if n_results == 0 else 0
    return {**ledger, "zero_result_streak": streak}


def detect_entities(ledger: dict, query: str) -> list[str]:
    """从查询文本反查用到的实体 (子串匹配 — CJK 无分词也稳).
    数字边界守卫 (F1): 含数字的实体值不得命中两侧还贴着数字的长数
    (2015 不命中 12015, 3500 不命中 35000); TEMPORAL 原值不在 generic
    分支裸配, 统一经 expand_years 走带守卫分支 (单年同样受保护);
    纯 CJK 值保持子串 (无分词也稳)."""
    ent = ledger.get("entities", {})

    def hit(value: str) -> bool:
        if any(ch.isdigit() for ch in value):
            return re.search(rf"(?<!\d){re.escape(value)}(?!\d)",
                             query) is not None
        return value in query

    used = [v for k in ENTITY_KINDS if k != "TEMPORAL"
            for v in ent.get(k, []) if str(v) and hit(str(v))]
    used += [y for y in expand_years(ent.get("TEMPORAL", []))
             if re.search(rf"(?<!\d){re.escape(y)}(?!\d)", query)]
    return used


# ---------- 战役目录定位 + 状态 IO (与 ammo_pool 同约定) ----------
def _camp_dir(cid: str) -> Path:
    """cid 校验 + ammo_pool/<cid>; 目录/账本找不到就报错, 绝不猜."""
    if not CID_RE.fullmatch(cid):
        raise ValueError(f"非法 campaign_id: {cid}")
    return POOL_ROOT / cid


def _load_ledger(d: Path) -> dict:
    p = d / STATE_NAME
    if not p.is_file():
        raise FileNotFoundError(f"战役无实体账本: {p} (先 init)")
    return json.loads(p.read_text(encoding="utf-8"))


def _save_ledger(d: Path, s: dict) -> None:
    d.mkdir(parents=True, exist_ok=True)
    tmp = d / "entity_matrix.tmp"
    tmp.write_text(json.dumps(s, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    tmp.replace(d / STATE_NAME)


# ---------- CLI ----------
def _parse_entity_specs(led: dict, specs: list[str]) -> dict:
    """--entity KIND=v1,v2 (可多次) → 种子实体 (非法 KIND 报错不猜)."""
    ents = led["entities"]
    for spec in specs:
        kind, _, vals = spec.partition("=")
        if kind not in ENTITY_KINDS or not vals:
            raise ValueError(f"非法 --entity (应为 KIND=v1,v2): {spec}")
        items = [v for v in re.split(r"[,，、]", vals) if v.strip()]
        ents = {**ents, kind: sorted({*ents[kind], *items})}
    return ents


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description="FT-6 实体覆盖账本 (检索穷举)")
    ap.add_argument("cmd", choices=["init", "record", "backfill"])
    ap.add_argument("--cid", required=True, help="campaign_id (如 EPC50-SNEI)")
    ap.add_argument("--topic", default="", help="课题 (init 配置)")
    ap.add_argument("--entity", action="append", default=[],
                    help="种子实体 KIND=v1,v2 (可多次, 如 NAMES=中建,中铁)")
    ap.add_argument("--query", default="", help="record: 检索查询文本")
    ap.add_argument("--hits", type=int, default=-1,
                    help="record: 结果数; 缺省不动零结果连击")
    ap.add_argument("--cap", type=int, default=20, help="backfill 上限")
    args = ap.parse_args(argv)
    try:
        d = _camp_dir(args.cid)
        if args.cmd == "init":
            led = new_ledger(args.topic)
            led = {**led, "entities": _parse_entity_specs(led, args.entity)}
            _save_ledger(d, led)
            n_ent = sum(len(v) for v in led["entities"].values())
            print(f"[entity] 账本就绪: {d / STATE_NAME} "
                  f"(实体 {n_ent} 个, 五类 {list(led['entities'])})")
        elif args.cmd == "record":
            if not args.query:
                print("--query 必填", file=sys.stderr)
                return 2
            led = _load_ledger(d)
            used = detect_entities(led, args.query)
            led = record_searched(led, args.query, used)
            if args.hits >= 0:
                led = record_result(led, args.hits)
            _save_ledger(d, led)
            print(f"[entity] 已记账: {args.query[:40]} "
                  f"(命中实体 {used} | 连击 {led['zero_result_streak']})")
        else:
            led = _load_ledger(d)
            sugg = unsearched_combos(led, args.cap)
            for s in sugg:
                print(f"[backfill] {s['query']}  combo={s['combo']}")
            print(f"[backfill] 未搜组合回填建议 {len(sugg)} 条 "
                  f"(cap {args.cap}) | 已搜 {len(led.get('combos', []))} 组合")
            hint = narrow_hint(led)
            if hint:
                print(f"[hint] {hint}")
    except (ValueError, OSError, json.JSONDecodeError) as e:
        print(f"[entity] 错误: {e}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
