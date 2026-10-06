# -*- coding: utf-8 -*-
"""S0 门卫判级器 (超级生产线 S0-1) — 报告名 → 战役准入/撤退判级.

泛化 reforge_factory/epc50_start_gate 的三门裁决为全战役通用件。
判级纪律 (验收判据三): 只读盘上账本 (弹药池/tiers 词表/渠道注册表/
战役目录), 全程零网络零付费渠道 — 判定源一律取 tier_report/池账本
数字, 不信模型自评 (superline 边界铁律)。

三门:
  A 弹药存量 (判级主腿): 池配 tiers.json → 分层门 (T1≥300万 ∧
    T1+T2≥3000万, 与 ammo_pool.tier_report 同源); 池在无词表 →
    旧总量门 (2亿); 无池有战役目录 → 02/04 语料回退扫描; 全无 →
    no-ammo。
  B 共性库存量仓 (平台级, 不随战役): 锚池 (默认 EPC49-SEPDC) 的
    stock:*/kb:* 键之和 (剔 stock:campaign_*) ≥ 3000万 — NB v2
    68卷/5960万口径的平台地板, 防「战役池厚但共性仓空」。
  C 渠道覆盖: 池 by_engine 有效引擎 (注册表 id∪ledger_keys∪
    by_engine∪engine_aliases 映射, 或 NN_ 编号目录腿, 或 own:*)
    ≥ 3 — 全渠道上阵原则的最小可产分母 (completeness_v2 同款归位)。

三腿全过 = PASS; 任一缺 = RETREAT, 每缺一腿记缺口 (RETREAT 缺口
非空 = 验收判据二)。回放模式只写 replay_out/, 绝不污染真实战役
目录, 绝不发通知。

用法:
  python superline/s0_gatekeeper.py --title "《X公司怎么干EPC总承包？》" \
      [--battle-dir D] [--pool CID] [--stock-pool EPC49-SEPDC] \
      [--registry P] [--notify]
  python superline/s0_gatekeeper.py --replay superline/replay_manifest.json
"""
from __future__ import annotations

import json
import re
import sys
import time
from pathlib import Path

_ROOT = str(Path(__file__).resolve().parents[1])   # reforge_factory 根
if _ROOT not in sys.path:
    sys.path.insert(0, _ROOT)

from superline.contracts import gate_defaults      # noqa: E402
import superline as _sl                            # noqa: E402

# ---------- 补丁口 (测试 monkeypatch 这五个) ----------
STATION = Path(r"E:\AI-Station")
POOL_ROOT = STATION / "ammo_pool"                  # 池数据根 (非模块)
RESEARCH_TOPICS = STATION / "ResearchFactory-Eng" / "ResearchTopics"
REGISTRY_PATH = (STATION / "ResearchFactory-Eng" / "EPC100" / "conductor"
                 / "v2" / "channels_v2.json")
STOCK_ANCHOR_POOL = "EPC49-SEPDC"
REPLAY_OUT = Path(__file__).resolve().parent / "replay_out"

VERDICTS = ("PASS", "RETREAT")
CORPUS_FLOOR_CHARS = 30_000_000      # 共性库存量仓地板 (NB v2 68卷口径)
COVERAGE_MIN_ENGINES = 3             # 最小有效引擎分母 (全渠道上阵)
CORPUS_SCAN_PREFIXES = ("02", "04")  # 战役语料腿扫描的子目录前缀
ZERO_PAID = True                     # 判级器结构性零付费 (机检锚)


def _tier_report(pool_id: str) -> dict:
    """真实分层账 — ammo_pool.tier_report 同源 (测试 monkeypatch 此口)."""
    import ammo_pool
    return ammo_pool.tier_report(pool_id)


def _load_json(p: Path, default):
    try:
        return json.loads(p.read_text(encoding="utf-8"))
    except Exception:
        return default


# ---------- 腿A 弹药存量 (判级主腿) ----------
def _scan_corpus(battle_dir: Path) -> tuple[int, int]:
    """战役语料回退扫描: 02/04 前缀子目录递归 *.md/*.txt 计 len(text)."""
    chars = files = 0
    if not battle_dir.is_dir():
        return 0, 0
    for sub in sorted(battle_dir.iterdir()):
        if not (sub.is_dir() and sub.name.startswith(CORPUS_SCAN_PREFIXES)):
            continue
        for p in sub.rglob("*"):
            if p.suffix.lower() not in (".md", ".txt") or not p.is_file():
                continue
            try:
                chars += len(p.read_text(encoding="utf-8", errors="ignore"))
            except OSError:
                continue
            files += 1
    return chars, files


def _leg_ammo(pool_id: str, battle_dir: str) -> dict:
    """四模式: tiered / fallback / corpus-fallback / no-ammo."""
    gp = gate_defaults()
    gaps: list[str] = []
    pd = POOL_ROOT / pool_id if pool_id else None
    if pd is not None and (pd / "tiers.json").is_file():
        tr = _tier_report(pool_id)
        t1, t2 = int(tr.get("t1") or 0), int(tr.get("t2") or 0)
        t12 = t1 + t2
        ok = (tr.get("tiers_configured")
              and t1 >= gp["t1_min_chars"] and t12 >= gp["t12_min_chars"])
        if not ok:
            if t1 < gp["t1_min_chars"]:
                gaps.append(f"弹药分层门未过: T1={t1:,} < "
                            f"{gp['t1_min_chars']:,} "
                            f"(缺 {gp['t1_min_chars'] - t1:,} 字)")
            if t12 < gp["t12_min_chars"]:
                gaps.append(f"弹药分层门未过: T1+T2={t12:,} < "
                            f"{gp['t12_min_chars']:,} "
                            f"(缺 {gp['t12_min_chars'] - t12:,} 字)")
        return {"leg": "ammo", "mode": "tiered", "ok": bool(ok),
                "t1": t1, "t2": t2, "t12": t12, "gaps": gaps}
    if pd is not None and pd.is_dir():
        st = _load_json(pd / "pool_state.json", {})
        total = st.get("total_chars") or sum(
            (st.get("by_engine") or {}).values()) or 0
        ok = total >= gp["fallback_total_chars"]
        if not ok:
            gaps.append(f"弹药总量门未过: {total:,} < "
                        f"{gp['fallback_total_chars']:,} "
                        f"(缺 {gp['fallback_total_chars'] - total:,} 字)")
        return {"leg": "ammo", "mode": "fallback", "ok": bool(ok),
                "total_chars": total, "gaps": gaps}
    if battle_dir and Path(battle_dir).is_dir():
        chars, files = _scan_corpus(Path(battle_dir))
        ok = chars >= gp["fallback_total_chars"]
        if not ok:
            gaps.append(f"战役语料回退门未过: 语料 {chars:,} 字 "
                        f"(扫描 {files} 文件) < {gp['fallback_total_chars']:,} "
                        f"(缺 {gp['fallback_total_chars'] - chars:,} 字)")
        return {"leg": "ammo", "mode": "corpus-fallback", "ok": bool(ok),
                "corpus_chars": chars, "corpus_files": files, "gaps": gaps}
    gaps.append("无弹药证据: 池缺失且战役目录不可读")
    return {"leg": "ammo", "mode": "no-ammo", "ok": False, "gaps": gaps}


# ---------- 腿B 共性库存量仓 (平台级) ----------
def _leg_stock(stock_pool: str) -> dict:
    """锚池 stock:*/kb:* 共性键 (剔 stock:campaign_*) ≥ 3000万地板.

    战役存量键 (stock:campaign_*) 是一次性并入班遗留, 不算平台共性仓
    (弹药门语义: 存量可引用不计数); nb_library/zhiku/lark_zhiku_file/
    ima_public 才是多战役复用的共性底座。"""
    sid = stock_pool or STOCK_ANCHOR_POOL
    st = _load_json(POOL_ROOT / sid / "pool_state.json", {})
    be = st.get("by_engine") or {}
    keys = sorted(k for k in be
                  if (k.startswith("stock:") or k.startswith("kb:"))
                  and not k.startswith("stock:campaign_"))
    total = sum(int(be[k]) or 0 for k in keys)
    ok = total >= CORPUS_FLOOR_CHARS
    gaps = []
    if not ok:
        gaps.append(f"共性库存量仓未达标: 锚池 {sid} 共性键 {total:,} < "
                    f"{CORPUS_FLOOR_CHARS:,} "
                    f"(缺 {CORPUS_FLOOR_CHARS - total:,} 字)")
    return {"leg": "corpus_stock", "ok": bool(ok), "anchor": sid,
            "stock_chars": total, "floor": CORPUS_FLOOR_CHARS,
            "keys": keys, "gaps": gaps}


# ---------- 腿C 渠道覆盖 ----------
def _engine_valid(e: str, known: set) -> bool:
    """注册表映射 ∪ 编号目录腿 ∪ own: 前缀 (completeness_v2 归位先例)."""
    return (e in known or e.split(":")[-1] in known
            or re.match(r"^\d+_", e) is not None or e.startswith("own:"))


def _leg_coverage(pool_id: str, registry: str) -> dict:
    reg = _load_json(Path(registry or REGISTRY_PATH), {}).get("channels", {})
    known = set(reg)
    for c in reg.values():
        known |= set(c.get("ledger_keys") or [])
        known |= set(c.get("by_engine") or [])
        known |= set(c.get("engine_aliases") or [])
    be = (_load_json(POOL_ROOT / pool_id / "pool_state.json", {})
          .get("by_engine") or {}) if pool_id else {}
    pool_engines = sorted(k for k, v in be.items()
                          if isinstance(v, int) and not isinstance(v, bool)
                          and v > 0)
    valid = [e for e in pool_engines if _engine_valid(e, known)]
    ok = len(valid) >= COVERAGE_MIN_ENGINES
    gaps = []
    if not ok:
        gaps.append(f"渠道覆盖不足: 有效引擎 {len(valid)} < "
                    f"{COVERAGE_MIN_ENGINES} ({', '.join(valid)})")
    return {"leg": "coverage", "ok": bool(ok), "n": len(valid),
            "engines": valid, "pool_engines": len(pool_engines),
            "gaps": gaps}


# ---------- 判级主口 ----------
def judge(title: str, battle: str = "", battle_dir: str = "",
          pool_id: str = "", stock_pool: str = "", registry: str = "") -> dict:
    """三腿判级, 返回 s0_gatekeeper_v1 报告 doc (纯读盘, 零网络)."""
    leg_a = _leg_ammo(pool_id, battle_dir)
    leg_b = _leg_stock(stock_pool)
    leg_c = _leg_coverage(pool_id, registry)
    gaps = [*leg_a["gaps"], *leg_b["gaps"], *leg_c["gaps"]]
    verdict = "PASS" if (leg_a["ok"] and leg_b["ok"] and leg_c["ok"]) \
        else "RETREAT"
    name = battle or pool_id or (Path(battle_dir).name if battle_dir else ""
                                 ) or title[:24]
    return {"schema": "s0_gatekeeper_v1", "battle": name, "title": title,
            "pool": pool_id, "battle_dir": battle_dir, "verdict": verdict,
            "legs": {"ammo": leg_a, "corpus_stock": leg_b,
                     "coverage": leg_c},
            "gaps": gaps, "gate_params": gate_defaults(),
            "zero_paid": ZERO_PAID,
            "generated": time.strftime("%Y-%m-%dT%H:%M:%S"),
            "version": _sl.__version__}


def _md(doc: dict) -> str:
    legs = doc["legs"]
    a, b, c = legs["ammo"], legs["corpus_stock"], legs["coverage"]
    mark = lambda ok: "✅" if ok else "❌"          # noqa: E731
    md = [f"# S0 门卫判级 — {doc['battle']}", "",
          f"- 报告名: {doc['title']}",
          f"- 判定: **{doc['verdict']}**",
          f"- 腿A 弹药 [{mark(a['ok'])}] {a['mode']}",
          f"- 腿B 共性库存量 [{mark(b['ok'])}] {b['stock_chars']:,} / "
          f"{b['floor']:,} 字 (锚池 {b['anchor']}, 剔 campaign 键)",
          f"- 腿C 渠道覆盖 [{mark(c['ok'])}] {c['n']} / "
          f"{COVERAGE_MIN_ENGINES} 有效引擎 {c['engines']}",
          f"- 零付费渠道: {doc['zero_paid']} | 门参数同源 "
          f"{doc['gate_params']} | v{doc['version']}", ""]
    if doc["gaps"]:
        md.append("## 缺口清单 (RETREAT 须非空 → 转采集/补弹工单)")
        md += [f"- {g}" for g in doc["gaps"]]
    return "\n".join(md) + "\n"


def render(doc: dict, battle_dir: str = "", battle: str = "",
           replay_mode: bool = False) -> Path:
    """JSON+MD 落盘: 正式模式 → 战役目录首个 00 前缀子目录 (无则战役根);
    回放模式 → 仅 replay_out/<battle>/ (绝不污染真实战役目录)."""
    if replay_mode:
        out = REPLAY_OUT / (battle or doc["battle"])
    else:
        bd = Path(battle_dir) if battle_dir else None
        out = None
        if bd is not None and bd.is_dir():
            out = next((s for s in sorted(bd.iterdir())
                        if s.is_dir() and s.name.startswith("00")), bd)
        out = out or bd or Path(".")
    out.mkdir(parents=True, exist_ok=True)
    (out / "s0_gatekeeper.json").write_text(
        json.dumps(doc, ensure_ascii=False, indent=1), encoding="utf-8")
    (out / "s0_gatekeeper.md").write_text(_md(doc), encoding="utf-8")
    return out


def notify_retreat(doc: dict) -> None:
    """RETREAT 企微推送 (opt-in; 免费通道, best-effort 绝不阻断判级).

    仅 CLI --notify 显式触发; 判级/replay 路径永不调用 (测试以 raise
    探针证之)。wecom-cli 个人 OAuth aibot send 形态见 wecom-channel 记忆。"""
    import subprocess
    msg = (f"[S0门卫] {doc['battle']} → RETREAT\n"
           + "\n".join(doc["gaps"][:5]))
    try:
        subprocess.run(
            ["wecom-cli", "message", "aibot", "send", "--text", msg],
            capture_output=True, timeout=30, check=False,
            creationflags=getattr(subprocess, "CREATE_NO_WINDOW", 0))
    except Exception as e:                       # best-effort: 推不出不炸
        print(f"[s0] 企微通知未送出 (best-effort): {e}")


# ---------- 回放 (验收判据一: ≥8/10 一致 + RETREAT 缺口非空 + 零付费) ----------
def replay(manifest_path: str) -> int:
    try:
        mf = _load_json(Path(manifest_path), None)
        entries = (mf or {}).get("battles") or []
    except Exception as e:
        print(f"[s0-replay] 清单不可读: {e}", file=sys.stderr)
        return 2
    if not entries:
        print("[s0-replay] 清单为空", file=sys.stderr)
        return 2
    bar = ((mf or {}).get("bar") or {}).get("min_consistency", 8)
    rows, ok_n, gaps_all_ok = [], 0, True
    for e in entries:
        doc = judge(title=e.get("title", ""), battle=e.get("battle", ""),
                    battle_dir=e.get("battle_dir", ""),
                    pool_id=e.get("pool", ""))
        met = bool(e.get("ground_truth", {}).get("ammo_met"))
        consistent = (doc["verdict"] == "PASS") == met
        gaps_ok = doc["verdict"] == "PASS" or len(doc["gaps"]) > 0
        ok_n += consistent
        gaps_all_ok = gaps_all_ok and gaps_ok
        render(doc, battle=e.get("battle", ""), replay_mode=True)
        rows.append({"battle": e.get("battle"), "verdict": doc["verdict"],
                     "expected_met": met, "consistent": consistent,
                     "gaps_n": len(doc["gaps"]),
                     "ammo_mode": doc["legs"]["ammo"]["mode"]})
        print(f"[s0-replay] {e.get('battle')}: {doc['verdict']} "
              f"(期望 met={met}) {'✓ 一致' if consistent else '✗ 不一致'}"
              f" | 缺口 {len(doc['gaps'])} 条 [{doc['legs']['ammo']['mode']}]")
    rc = 0 if (ok_n >= bar and gaps_all_ok) else 1
    summary = {"schema": "s0_replay_summary_v1", "n": len(entries),
               "consistent": ok_n, "bar": bar, "retreat_gaps_ok": gaps_all_ok,
               "zero_paid": ZERO_PAID, "rows": rows, "rc": rc,
               "generated": time.strftime("%Y-%m-%dT%H:%M:%S")}
    REPLAY_OUT.mkdir(parents=True, exist_ok=True)
    (REPLAY_OUT / "replay_summary.json").write_text(
        json.dumps(summary, ensure_ascii=False, indent=1), encoding="utf-8")
    md = ["# S0 门卫判级回放", "",
          f"- 一致率: **{ok_n}/{len(entries)}** (bar ≥{bar}) "
          f"{'✓' if ok_n >= bar else '✗'}",
          f"- RETREAT 缺口全非空: {'✓' if gaps_all_ok else '✗'}",
          f"- 零付费渠道: {ZERO_PAID} | rc={rc}", "",
          "| 战役 | 判级 | 期望 met | 一致 | 缺口 | 弹药模式 |",
          "|---|---|---|---|---|---|"]
    md += [f"| {r['battle']} | {r['verdict']} | {r['expected_met']} | "
           f"{'✓' if r['consistent'] else '✗'} | {r['gaps_n']} | "
           f"{r['ammo_mode']} |" for r in rows]
    (REPLAY_OUT / "replay_summary.md").write_text(
        "\n".join(md) + "\n", encoding="utf-8")
    print(f"[s0-replay] 一致率 {ok_n}/{len(entries)} "
          f"(bar ≥{bar}) {'✓' if ok_n >= bar else '✗'} | "
          f"RETREAT 缺口全非空 {'✓' if gaps_all_ok else '✗'} | "
          f"零付费 ✓ → rc={rc}")
    return rc


def main(argv: list[str] | None = None) -> int:
    import argparse
    ap = argparse.ArgumentParser(description="S0 门卫判级器 (零付费)")
    ap.add_argument("--title", default="", help="报告名")
    ap.add_argument("--battle-dir", default="", help="战役目录")
    ap.add_argument("--pool", default="", help="弹药池 campaign_id")
    ap.add_argument("--stock-pool", default="",
                    help="共性库存量锚池 (默认 EPC49-SEPDC)")
    ap.add_argument("--registry", default="", help="渠道注册表 JSON 路径")
    ap.add_argument("--notify", action="store_true",
                    help="RETREAT 企微推送 (opt-in, 免费通道)")
    ap.add_argument("--replay", default="",
                    help="回放清单 JSON (10 历史战役)")
    args = ap.parse_args(argv)
    print(f"[s0] superline {_sl.__version__} 门卫判级器 "
          f"(判定同源·零付费渠道)")
    if args.replay:
        return replay(args.replay)
    if not args.title:
        print("[s0] --title 必填 (或走 --replay)", file=sys.stderr)
        return 2
    doc = judge(args.title, battle_dir=args.battle_dir, pool_id=args.pool,
                stock_pool=args.stock_pool, registry=args.registry)
    out = render(doc, battle_dir=args.battle_dir)
    b = doc["legs"]["corpus_stock"]
    print(f"[s0] 判定 {doc['verdict']} | 弹药[{doc['legs']['ammo']['mode']}] "
          f"共性仓 {b['stock_chars']:,}/{b['floor']:,} "
          f"引擎 {doc['legs']['coverage']['n']} | 缺口 {len(doc['gaps'])} 条")
    for g in doc["gaps"]:
        print(f"  - {g}")
    print(f"[s0] 报告落盘: {out / 's0_gatekeeper.md'}")
    if doc["verdict"] == "RETREAT" and args.notify:
        notify_retreat(doc)
    return 0 if doc["verdict"] == "PASS" else 1


if __name__ == "__main__":
    sys.exit(main())
