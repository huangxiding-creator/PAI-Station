# -*- coding: utf-8 -*-
"""tier_gate_v3 三池并行重算工具 (百倍V3 / T-004, REQ-012).

REQ-012: 历史战役池 (EPC-BID26 / F1-BLUEBOOK / EPC50-SNEI) 按新口径
(gates.json v3: T1>=t1_min_chars=1000万, T1+T2 总门=null 已撤) 重算,
**增量落盘** tier_gate_v3 字段到各 pool_state.json —— 只加键, 绝不改/
不删任何既有键; 写前把原文件字节备份到同目录 pool_state.pre-v3.bak.json
(备份只增: 已存在则保留首份, 不覆盖)。并生成新旧口径对照报告。

门参数单一权威源: reforge_factory/config/gates.json (经 gates_loader,
现读无缓存) —— 本工具零硬编码门值, 改 json 即时生效 (REQ-010.AC2)。

t1/t2 取值顺位 (诚实溯源, 落 tier_gate_v3.t1_t2_source):
    1. pool_state.json 原值 t1_chars/t2_chars (BID26/F1-BLUEBOOK 已有);
    2. 池缺失该两键时 (EPC50-SNEI 从未落盘分层账) → 按 manifest.jsonl
       重算, 口径与 reforge_factory/ammo_pool.tier_report 生产线逐行一致:
       judge==valid 过滤 + dedup_key 去重 + 标题×tiers.json T1/T2 词表
       标题级下界 (2026-10-15 对拍: t1/t2 与生产版完全一致)。

红线 (T-004 任务令): pool_state.json 只加键不删键不改旧值;
.bak 备份是新文件不算删除; 不碰 EPC49-SEPDC 等其他池 (默认池表封闭)。

用法:
    py reforge_factory/tier_gate_v3_recompute.py            # 真三池+对照报告
    py reforge_factory/tier_gate_v3_recompute.py --dry-run  # 只算不写
    py reforge_factory/tier_gate_v3_recompute.py --pool-root <dir> \
        --pools A,B --report <md>   # 测试夹具用
"""
from __future__ import annotations

import argparse
import json
import os
import sys
from datetime import datetime
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import gates_loader  # noqa: E402  门参数单一权威源 (T-002 地基件)

# ---------- 常量 (非门参数: 路径与池表是本工具的封闭作业面) ----------
DEFAULT_POOL_ROOT = Path(r"E:\AI-Station\ammo_pool")
DEFAULT_POOLS: tuple[str, ...] = ("EPC-BID26", "F1-BLUEBOOK", "EPC50-SNEI")
DEFAULT_REPORT = Path(
    r"E:\AI-Station\ResearchFactory-Eng\06 迭代优化\百倍V3_极致调研变现计划"
    r"\work\tier_gate_v3_compare.md")
STATE_NAME = "pool_state.json"
BACKUP_NAME = "pool_state.pre-v3.bak.json"
V3_KEY = "tier_gate_v3"


# ---------- 门参数 (权威源, 零硬编码) ----------
def load_t1_min(gates: dict | None = None) -> int:
    """T1 门 = gates.json v3 t1_min_chars; 非正整数回退 DEFAULTS (不炸产线)."""
    g = gates if gates is not None else gates_loader.load_gates()
    v = g.get("t1_min_chars")
    return v if isinstance(v, int) and isinstance(v, bool) is False and v > 0 \
        else gates_loader.DEFAULTS["t1_min_chars"]


# ---------- manifest 重算 (与 ammo_pool.tier_report 同口径镜像) ----------
def classify_pool_tiers(pool_dir: Path) -> tuple[int, int, str]:
    """manifest.jsonl × tiers.json 重算 t1/t2 字数.

    逐行复刻 reforge_factory/ammo_pool.py tier_report 的分类规则:
    judge==valid 才计; dedup_key(退化 url_norm/source_path) 去重;
    标题 basename 命中 T1 词表优先, 次 T2 词表 (标题级下界)。
    返回 (t1_chars, t2_chars, source 说明)。
    """
    t1k: list[str] = []
    t2k: list[str] = []
    tp = pool_dir / "tiers.json"
    if tp.is_file():
        try:
            cfg = json.loads(tp.read_text(encoding="utf-8"))
            t1k, t2k = cfg.get("T1", []), cfg.get("T2", [])
        except (OSError, ValueError):
            t1k, t2k = [], []
    t1 = t2 = 0
    seen: set[str] = set()
    mp = pool_dir / "manifest.jsonl"
    if mp.is_file():
        for line in mp.read_text(encoding="utf-8").splitlines():
            line = line.strip()
            if not line:
                continue
            try:
                r = json.loads(line)
            except json.JSONDecodeError:
                continue
            if r.get("judge") != "valid":
                continue
            key = r.get("dedup_key") or r.get("url_norm") \
                or r.get("source_path") or ""
            if key:
                if key in seen:            # manifest 行=文件×问题对, 行累加=虚账
                    continue
                seen.add(key)
            title = os.path.basename(
                r.get("source_path") or r.get("url_norm") or "")
            ch = r.get("chars") or 0
            if t1k and any(k in title for k in t1k):
                t1 += ch
            elif t2k and any(k in title for k in t2k):
                t2 += ch
    src = ("manifest重算(valid×dedup×tiers.json标题匹配, "
           "口径对拍 ammo_pool.tier_report 一致)")
    return t1, t2, src


def resolve_t1_t2(state: dict, pool_dir: Path) -> tuple[int, int, str]:
    """t1/t2 取值: pool_state 原值优先, 缺失则 manifest 重算 (溯源记录)."""
    t1 = state.get("t1_chars")
    t2 = state.get("t2_chars")
    if isinstance(t1, int) and not isinstance(t1, bool):
        t2v = t2 if isinstance(t2, int) and not isinstance(t2, bool) else 0
        return t1, t2v, "pool_state.t1_chars/t2_chars 原值"
    r1, r2, src = classify_pool_tiers(pool_dir)
    return r1, r2, src


# ---------- v3 判定 ----------
def compute_v3(state: dict, pool_dir: Path, t1_min: int,
               now: str | None = None) -> dict:
    """按 v3 口径算 tier_gate_v3 dict (T1>=t1_min 单门, 总门已撤)."""
    t1, t2, source = resolve_t1_t2(state, pool_dir)
    ts = now or datetime.now().astimezone().isoformat(timespec="seconds")
    return {
        "t1_pass": bool(t1 >= t1_min),
        "rule": f"T1>={t1_min}, total gate removed (v3)",
        "computed_at": ts,
        "t1_chars": t1,
        "t2_chars": t2,
        "t1_t2_source": source,
    }


# ---------- 增量写回 (红线: 只加键) ----------
def _fmt(obj: dict, trailing_newline: bool) -> str:
    s = json.dumps(obj, ensure_ascii=False, indent=1)
    return s + "\n" if trailing_newline else s


def write_back_incremental(pool_dir: Path, v3: dict) -> dict:
    """增量写回: 加/更 tier_gate_v3 一键, 既有键值与顺序零改动.

    写前字节级备份到 pool_state.pre-v3.bak.json (已存在则保留首份不覆盖);
    原子落盘 (tmp + os.replace); 写前断言既有键值 deep-equal 不变, 违反即抛。
    """
    sp = pool_dir / STATE_NAME
    raw = sp.read_text(encoding="utf-8")
    state = json.loads(raw)
    bak = pool_dir / BACKUP_NAME
    if not bak.exists():                     # 备份只增: 保首份原始字节
        bak.write_text(raw, encoding="utf-8")

    new = dict(state)                        # 保留既有键的插入顺序
    new[V3_KEY] = v3                         # 唯一允许新增/更新的键
    for k, v in state.items():               # 写前红线自检: 旧值零改动
        if k == V3_KEY:
            continue
        if new.get(k) != v:
            raise RuntimeError(f"红线违约: 既有键 {k} 值被改动, 拒绝写盘")
    if not set(state.keys()) <= set(new.keys()):
        raise RuntimeError("红线违约: 既有键缺失, 拒绝写盘")

    tmp = sp.with_suffix(".json.tmpv3")
    tmp.write_text(_fmt(new, raw.endswith("\n")), encoding="utf-8")
    os.replace(tmp, sp)
    return {"backup": bak, "state": sp,
            "keys_before": len(state), "keys_after": len(new),
            "preserved": [k for k in state if k != V3_KEY]}


# ---------- 单池流水 ----------
def recompute_pool(pool_dir: Path, t1_min: int, apply: bool = True,
                   now: str | None = None) -> dict:
    """读 pool_state → 算 v3 → (可选)增量写回; 返回结果行 (含旧判字段)."""
    sp = pool_dir / STATE_NAME
    if not sp.is_file():
        return {"pool": pool_dir.name, "error": f"{STATE_NAME} 不存在"}
    state = json.loads(sp.read_text(encoding="utf-8"))
    v3 = compute_v3(state, pool_dir, t1_min, now)
    wb = None
    if apply:
        wb = write_back_incremental(pool_dir, v3)
        # 回读验证: 落盘后旧键值仍与写前一致 (双保险)
        after = json.loads(sp.read_text(encoding="utf-8"))
        for k, v in state.items():
            if k != V3_KEY:
                assert after.get(k) == v, f"回读违约: {k} 落盘后被改"
        assert after.get(V3_KEY) == v3
    return {
        "pool": pool_dir.name,
        "old": {
            "tier_gate_ok": state.get("tier_gate_ok", None),
            "gate_chars": state.get("gate_chars", None),
            "t1_chars": state.get("t1_chars", None),
            "t2_chars": state.get("t2_chars", None),
            "last_tier_persist": state.get("last_tier_persist", None),
        },
        "v3": v3,
        "write_back": wb,
    }


# ---------- 对照报告 ----------
_OLD_BASIS = {  # 旧判所依口径 (人工核账, 报告引用)
    "EPC-BID26": ("代码v2双门 T1≥300万∧T1+T2≥3000万 (ammo_pool.py 旧常量; "
                  "KB-GATES-SPEC :7); 账面 gate_chars=200,000,000 恰等于 "
                  "gates.json legacy_total_budget_reference(2亿总门)"),
    "F1-BLUEBOOK": ("代码v2双门 T1≥300万∧T1+T2≥3000万 (t1=16,730,119≥300万 ✓ "
                    "∧ t1+t2=45,317,338≥3000万 ✓, 与 True 自洽); "
                    "gate_chars=51,610,024=t1+t2+t3 精确和(合成门槛账)"),
    "EPC50-SNEI": ("无旧判: pool_state 从未落盘 tier_gate_ok/t1/t2 分层账; "
                   "仅建池 gate_chars=10,000,000 一手门槛账(0925)"),
}
_DIFF = {
    "EPC-BID26": ("旧 False → 新 True: T1=32,951,068 远超 v3 门 1000万, "
                  "且 T1+T2 总门已撤。两案诚实记录之一见下文【案二】。"),
    "F1-BLUEBOOK": ("旧 True → 新 True (维持过门): T1=16,730,119≥1000万。"
                    "但 v5 口径(2000万/5000万)下会翻车, 见下文【案一】。"),
    "EPC50-SNEI": ("无旧判 → 新 True (首次判定): t1=47,640,193 由 manifest "
                   "重算(池无 t1/t2 原值), 溯源记于 t1_t2_source。"),
}


def _fmt_i(n) -> str:
    return f"{n:,}" if isinstance(n, int) else str(n)


def build_report(results: list[dict], t1_min: int, now: str) -> str:
    lines: list[str] = []
    ap = lines.append
    ap("# tier_gate_v3 新旧口径对照报告 (REQ-012 / T-004)")
    ap("")
    ap(f"- 生成: {now}  工具: `reforge_factory/tier_gate_v3_recompute.py`")
    ap("- 新口径权威源: `reforge_factory/config/gates.json` v3 "
       f"(t1_min_chars={_fmt_i(t1_min)}, t12_total_gate=null 总门已撤)")
    ap("- 写回纪律: 三池 pool_state.json **仅新增** tier_gate_v3 键, 既有键值"
       "与顺序零改动 (工具写前+回读双断言); 写前字节备份 "
       "`pool_state.pre-v3.bak.json` (只增文件, 重跑保首份)。")
    ap("")
    ap("## 口径谱系 (旧口径三套并存现状, KB-GATES-SPEC)")
    ap("")
    ap("| 口径 | 判据 | 出处 | 状态 |")
    ap("|---|---|---|---|")
    ap("| 代码 v2 双门 | T1≥300万 ∧ T1+T2≥3000万 (T3封顶5000万/无词表回退2亿) | "
       "reforge_factory/ammo_pool.py 旧常量 (T-002R 起退役为注释, 现读 gates.json) | 退役 |")
    ap("| BID26 v5 硬编码 | 2000万/5000万 | "
       "_proposals/flagship-paid-report-1007/work/collection_gate.py :39-40 | "
       "存量待迁移 (T-002B) |")
    ap("| 蓝皮书池历史 gate_chars | 51,610,024 合成门槛账 (=t1+t2+t3_capped) | "
       "ammo_pool/F1-BLUEBOOK/pool_state.json | 存量字段不动 |")
    ap(f"| **gates.json v3 (在役)** | **T1≥{_fmt_i(t1_min)} ∧ 总门=null (撤)** | "
       "reforge_factory/config/gates.json | **在役** |")
    ap("")
    ap("## 逐池对照")
    ap("")
    ap("| 池 | 旧判 tier_gate_ok | 旧判所依口径 | t1_chars | t2_chars | "
       "新判 t1_pass | 差异说明 |")
    ap("|---|---|---|---|---|---|---|")
    for r in results:
        pool = r["pool"]
        old_ok = r["old"]["tier_gate_ok"]
        old_ok_s = "（无, 从未落盘）" if old_ok is None else str(old_ok)
        t1s = _fmt_i(r["v3"]["t1_chars"])
        t2s = _fmt_i(r["v3"]["t2_chars"])
        t1s += " (manifest重算)" if "重算" in r["v3"].get("t1_t2_source", "") else ""
        ap(f"| {pool} | {old_ok_s} | {_OLD_BASIS.get(pool, '—')} | {t1s} "
           f"| {t2s} | **{r['v3']['t1_pass']}** | {_DIFF.get(pool, '')} |")
    ap("")
    ap("## 两案诚实记录")
    ap("")
    ap("1. **【案一】F1-BLUEBOOK 旧 true 在 v5 口径会翻车**: v5 判据 "
       "T1≥2000万, 而 t1=16,730,119 < 20,000,000 → 若按 v5 判将 **FAIL**。"
       "按代码 v2 (300万/3000万) 与 v3 (1000万) 均过。旧 True 与代码 v2 "
       "口径自洽 (16,730,119≥300万 ✓ ∧ 45,317,338≥3000万 ✓); gate_chars="
       "51,610,024 恰为 t1+t2+t3 精确和, 证明其出自 tier_report 合成门槛账。")
    ap("2. **【案二】BID26 旧 false 按代码 3000万 判** (任务口径记录): 旧判 "
       "False 落盘于 last_tier_persist=2026-10-14 08:42。账面矛盾如实记录: "
       "今日持久化 t1+t2=71,263,401 已超 3000万, 若按当前账面+代码 v2 双门 "
       "应判 True → 旧 False 更可能出自落盘时刻分层账更低, 或当时实走 "
       "gate_chars=200,000,000 的 2亿总门 (恰等于 gates.json "
       "legacy_total_budget_reference); tier_note 在盘上为乱码, 仅 "
       "\"3000万\"/\"tier_content_detail.jsonl\" 片段可辨。**旧值一律不改, "
       "仅记录矛盾供审计**。")
    ap("")
    ap("## 落盘核验")
    ap("")
    for r in results:
        wb = r.get("write_back")
        if wb:
            ap(f"- {r['pool']}: 键 {wb['keys_before']}→{wb['keys_after']} "
               f"(仅+{V3_KEY}), 既有键 {len(wb['preserved'])} 个原样保留, "
               f"备份 {BACKUP_NAME} 已落; 回读断言通过。")
        else:
            ap(f"- {r['pool']}: dry-run 未写盘。")
    ap("")
    return "\n".join(lines)


# ---------- 批量入口 ----------
def run(pool_root: Path | str = DEFAULT_POOL_ROOT,
        pools: tuple[str, ...] | list[str] = DEFAULT_POOLS,
        report_path: Path | str | None = DEFAULT_REPORT,
        apply: bool = True) -> dict:
    """三池并行重算主入口: 算→写回→对照报告; 返回 {results, report, t1_min}."""
    t1_min = load_t1_min()
    now = datetime.now().astimezone().isoformat(timespec="seconds")
    root = Path(pool_root)
    results = [recompute_pool(root / p, t1_min, apply=apply, now=now)
               for p in pools]
    if report_path is not None:
        rp = Path(report_path)
        rp.parent.mkdir(parents=True, exist_ok=True)
        rp.write_text(build_report(results, t1_min, now), encoding="utf-8")
    return {"results": results, "t1_min": t1_min,
            "report": str(report_path) if report_path else None}


def main(argv: list[str] | None = None) -> int:
    p = argparse.ArgumentParser(description="REQ-012 三池 tier_gate_v3 并行重算")
    p.add_argument("--pool-root", default=str(DEFAULT_POOL_ROOT))
    p.add_argument("--pools", default=",".join(DEFAULT_POOLS),
                   help="逗号分隔池目录名 (默认封闭三池, 不碰其他池)")
    p.add_argument("--report", default=str(DEFAULT_REPORT),
                   help="对照报告落盘路径 (空串=不出报告)")
    p.add_argument("--dry-run", action="store_true", help="只算不写不落报告")
    a = p.parse_args(argv)
    out = run(pool_root=a.pool_root, pools=tuple(x for x in a.pools.split(",") if x),
              report_path=None if a.dry_run or a.report == "" else a.report,
              apply=not a.dry_run)
    print(f"[tier_gate_v3] t1_min={out['t1_min']:,} "
          f"total_gate=null(撤) pools={len(out['results'])}")
    for r in out["results"]:
        if "error" in r:
            print(f"  {r['pool']}: ERROR {r['error']}")
            continue
        old_ok = r["old"]["tier_gate_ok"]
        old_ok_s = "无旧判" if old_ok is None else f"旧判 tier_gate_ok={old_ok}"
        src = "原值" if "原值" in r["v3"]["t1_t2_source"] else "重算"
        print(f"  {r['pool']}: {old_ok_s} → v3 t1_pass={r['v3']['t1_pass']} "
              f"(t1={r['v3']['t1_chars']:,} [{src}], "
              f"t2={r['v3']['t2_chars']:,})")
    if out["report"]:
        print(f"  报告: {out['report']}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
