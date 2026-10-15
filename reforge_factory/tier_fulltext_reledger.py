# -*- coding: utf-8 -*-
"""tier_fulltext_reledger — 全文级分层重落账 (百倍V3 / BID26 方案A, 用户已批).

终结 3295 万悬空 (t1_reconciliation.md 结论: 1014 明细在任何读法下无法复现
pool_state.t1_chars=32,951,068)。新宪法 (数字必须可由原始件复算) 之下, 唯一
正途 = 由在役脚本从**今日 manifest × 盘上全文**重跑一次分层, 全量明细落盘,
t1/t2 键按新口径重落 —— 本件即该在役脚本。

━━━ 全文级口径 v2 (fulltext_v2) 定义 ━━━

1. 遍历 ammo_pool/<campaign>/manifest.jsonl 的 judge==valid 行, 按
   dedup_key (退化 url_norm → source_path) 去重, 首行优先 —— 与
   reforge_factory/ammo_pool.py tier_report 同去重规则 (manifest 只读)。
2. 每件取全文: 优先读盘上源文件 (ammo_pool.read_text_safe: pdf/docx/
   pptx/多编码文本); 路径失联/不可读 → 以行内 text_head(500字) 作全文
   近似, 明细行记 caliber_note (判层依据降级, 如实留痕)。
3. 字数: 文件在盘 = count_chars(现读全文) —— 新宪法要求数字由原始件复算,
   不抄 manifest 行内 chars; 失联件 = manifest 行 chars (caliber_note 记
   chars_from_manifest_row, 该值无原始件可复算, 只作近似账)。
4. 分层 (全文词表匹配, 短路优先):
     T1 = tiers.json T1 词表任一词 ∈ 全文;
     未中 T1 → T2 = tiers.json T2 词表任一词;
     再未中 → T3 = pool_state.kws 任一词 (KWS=T3);
     全不中 → T0。
   matched_term = 词表序首个命中词 (全不中为 "")。
5. 明细: ammo_pool/<campaign>/tier_content_detail_v2.jsonl 每件一行
   {file, chars, tier, caliber:"fulltext_v2", matched_term, ts[, caliber_note]}
   —— 审计件按行级加总即可复算 (v3_number_audit ③字数类对拍依据)。
6. pool_state 更新 (只增并改本工具辖键, 其余键零改动):
     t1/t2/t3/t0 chars+items ← 新值; 旧 t1/t2 值存
     {t1,t2}_{chars,items}_legacy_1014 四键 (首写保留, 重跑不覆盖);
     tier_note ← 口径定义+脚本名+时间; last_tier_persist ← 落账时刻;
     tier_gate_v3 ← 按 gates.json t1_min_chars 用新值重判 (现读权威源)。
7. 旧明细 tier_content_detail.jsonl (含 _proposals 下历史件) 不动不读不删。

红线: manifest 只读; 旧字段不覆盖只并存 (legacy 四键); 写盘原子 (tmp+replace)
且持池锁 (ammo_pool._pool_lock); 真跑前先 --dry-run 看数。

用法:
    py reforge_factory/tier_fulltext_reledger.py EPC-BID26 --dry-run
    py reforge_factory/tier_fulltext_reledger.py EPC-BID26
    py reforge_factory/tier_fulltext_reledger.py <cid> --pool-root <dir> \
        [--limit N]     # 测试夹具 / 冒烟截断
"""
from __future__ import annotations

import argparse
import json
import sys
import time
from datetime import datetime
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import ammo_pool as AP                                    # noqa: E402
from ammo_pool import (_load_state, _pool_lock, _save_state,  # noqa: E402
                       count_chars, read_text_safe)

if sys.stdout:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

DEFAULT_POOL_ROOT = AP.POOL_ROOT
DETAIL_V2_NAME = "tier_content_detail_v2.jsonl"
CALIBER = "fulltext_v2"
SCRIPT_NAME = "reforge_factory/tier_fulltext_reledger.py"

_TIER_ORDER = ("T1", "T2", "T3", "T0")


def _camp_dir(pool_root: Path, campaign: str) -> Path:
    d = Path(pool_root) / campaign
    if not (d / "manifest.jsonl").is_file():
        raise FileNotFoundError(f"无 manifest: {d / 'manifest.jsonl'}")
    return d


def load_wordlists(pool_dir: Path) -> tuple[list[str], list[str], list[str]]:
    """(T1 词表, T2 词表, KWS) — tiers.json × pool_state.kws."""
    t1k: list[str] = []
    t2k: list[str] = []
    tp = pool_dir / "tiers.json"
    if tp.is_file():
        cfg = json.loads(tp.read_text(encoding="utf-8"))
        t1k = [k for k in cfg.get("T1", []) if isinstance(k, str)]
        t2k = [k for k in cfg.get("T2", []) if isinstance(k, str)]
    kws: list[str] = []
    sp = pool_dir / "pool_state.json"
    if sp.is_file():
        kws = [k for k in (_load_state(pool_dir).get("kws") or [])
               if isinstance(k, str)]
    return t1k, t2k, kws


def iter_unique_valid(pool_dir: Path):
    """manifest valid 行流 (dedup 首行优先) — 与 tier_report 同去重规则."""
    seen: set[str] = set()
    for line in (pool_dir / "manifest.jsonl").read_text(
            encoding="utf-8", errors="replace").splitlines():
        line = line.strip()
        if not line:
            continue
        try:
            r = json.loads(line)
        except json.JSONDecodeError:
            continue
        if not isinstance(r, dict) or r.get("judge") != "valid":
            continue
        key = r.get("dedup_key") or r.get("url_norm") \
            or r.get("source_path") or ""
        if key:
            if key in seen:          # manifest 行=文件×问题对, 行累加=虚账
                continue
            seen.add(key)
        yield r


def classify_row(row: dict, t1k: list[str], t2k: list[str],
                 kws: list[str], ts: str) -> dict:
    """单件全文级归位 → 明细行 (口径见模块 docstring §2-4)."""
    fp = Path(row.get("source_path") or "")
    text = ""
    if fp.is_file():
        try:
            text = read_text_safe(fp)     # pdf/docx/pptx/多编码 (生产同源)
        except Exception:
            text = ""
    note = ""
    if text:
        chars = count_chars(text)         # 新宪法: 数字由原始件现读复算
    else:                                  # 路径失联/不可读 → text_head 近似
        text = row.get("text_head") or ""
        chars = row.get("chars") or 0
        note = ("file_missing:text_head(500字)词表近似;"
                "chars_from_manifest_row")
    tier, term = "T0", ""
    for words, tk in ((t1k, "T1"), (t2k, "T2"), (kws, "T3")):
        hit = next((k for k in words if k and k in text), "")
        if hit:
            tier, term = tk, hit
            break
    out = {"file": row.get("source_path") or row.get("url_norm") or "",
           "chars": chars, "tier": tier, "caliber": CALIBER,
           "matched_term": term, "ts": ts}
    if note:
        out["caliber_note"] = note
    return out


def _tier_note(ts_disp: str) -> str:
    return (f"全文级口径v2(fulltext_v2): 源文件全文(失联则text_head近似记"
            f"caliber_note)×tiers.json T1/T2词表→未中试KWS=T3→全不中T0; "
            f"字数=现读全文count_chars(失联取manifest行chars); "
            f"明细{DETAIL_V2_NAME}; 脚本{SCRIPT_NAME}; 落账 {ts_disp}")


def _gate_v3(t1: int, t2: int, t1_min: int, iso: str) -> dict:
    return {"t1_pass": bool(t1 >= t1_min),
            "rule": f"T1>={t1_min}, total gate removed (v3)",
            "computed_at": iso,
            "t1_chars": t1, "t2_chars": t2,
            "t1_t2_source": (f"fulltext_v2全文级重落账({DETAIL_V2_NAME}"
                             f"行级加总, {SCRIPT_NAME})")}


def reledger(campaign: str, dry_run: bool = False,
             pool_root: Path | str = DEFAULT_POOL_ROOT,
             limit: int | None = None, now: str | None = None
             ) -> dict:
    """全文级重落账主入口: 算 (无锁, manifest 只读) → dry_run 外 落明细+账.

    返回 summary: {campaign, dry_run, unique_items, new{t1..t0 chars/items},
    legacy{...原值...}, gate{t1_min,t1_pass}, detail_path, approximated,
    t1_min}. 写盘段持池锁 + 原子替换; pool_state 除本工具辖键外零改动。
    """
    d = _camp_dir(Path(pool_root), campaign)
    ts = now or time.strftime("%Y-%m-%dT%H:%M:%S")
    ts_disp = ts.replace("T", " ")
    t1k, t2k, kws = load_wordlists(d)
    if not t1k and not t2k:
        raise ValueError(f"{campaign}: tiers.json 无 T1/T2 词表, 无从分层")

    details: list[dict] = []
    agg = {t: {"chars": 0, "items": 0} for t in _TIER_ORDER}
    n = 0
    for row in iter_unique_valid(d):
        if limit is not None and n >= limit:
            break
        rec = classify_row(row, t1k, t2k, kws, ts)
        details.append(rec)
        agg[rec["tier"]]["chars"] += rec["chars"]
        agg[rec["tier"]]["items"] += 1
        n += 1
        if n % 500 == 0:
            print(f"[reledger] {n:,} 件已归位 "
                  f"(T1 {agg['T1']['chars']:,})", flush=True)

    pre_state = _load_state(d)
    old = {f"{k}_legacy_src": pre_state.get(f"{k}", None)
           for k in ("t1_chars", "t1_items", "t2_chars", "t2_items")}
    t1_min = AP.gate_t1_min_chars()          # gates.json 现读 (无缓存)
    gate = _gate_v3(agg["T1"]["chars"], agg["T2"]["chars"], t1_min,
                    datetime.now().astimezone().isoformat(timespec="seconds"))

    detail_path: Path | None = None
    if not dry_run:
        with _pool_lock(d):
            detail_path = d / DETAIL_V2_NAME
            tmp = detail_path.with_suffix(".jsonl.tmp")
            tmp.write_text(
                "\n".join(json.dumps(r, ensure_ascii=False)
                          for r in details) + "\n", encoding="utf-8")
            tmp.replace(detail_path)
            ns = dict(pre_state)             # 其余键原样保留
            for t in _TIER_ORDER:
                ns[f"{t.lower()}_chars"] = agg[t]["chars"]
                ns[f"{t.lower()}_items"] = agg[t]["items"]
            for k, v in old.items():          # legacy 四键: 首写保留 (只增)
                kk = k.replace("_legacy_src", "_legacy_1014")
                if v is not None and kk not in ns:
                    ns[kk] = v
            ns["tier_note"] = _tier_note(ts_disp)
            ns["last_tier_persist"] = ts_disp[:16]
            ns["tier_gate_v3"] = gate
            _save_state(d, ns)                # 原子写 + WinError5 有界重试

    return {"campaign": campaign, "dry_run": dry_run, "unique_items": n,
            "new": {t: dict(agg[t]) for t in _TIER_ORDER},
            "legacy": old, "gate": {"t1_min": t1_min,
                                    "t1_pass": gate["t1_pass"]},
            "detail_path": str(detail_path) if detail_path else None,
            "approximated": sum(1 for r in details if r.get("caliber_note")),
            "t1_min": t1_min}


def _fmt_i(v) -> str:
    return f"{v:,}" if isinstance(v, int) else str(v)


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(
        description="全文级分层重落账 (fulltext_v2) — 终结 1014 悬空账")
    ap.add_argument("campaign", help="战役池目录名 (如 EPC-BID26)")
    ap.add_argument("--dry-run", action="store_true", help="只算不写")
    ap.add_argument("--pool-root", default=str(DEFAULT_POOL_ROOT))
    ap.add_argument("--limit", type=int, default=None,
                    help="只处理前 N 件 (冒烟用)")
    a = ap.parse_args(argv)
    s = reledger(a.campaign, dry_run=a.dry_run, pool_root=a.pool_root,
                 limit=a.limit)
    tag = "DRY-RUN" if s["dry_run"] else "已落账"
    print(f"\n[reledger] {s['campaign']} 全文级口径v2 {tag} — "
          f"唯一 valid 件 {s['unique_items']:,} "
          f"(失联近似 {s['approximated']:,})")
    print(f"{'层':<4}{'件数':>10}{'字符':>14}   (旧值: 件/字符)")
    legacy_items = {"T1": s["legacy"].get("t1_items_legacy_src"),
                    "T2": s["legacy"].get("t2_items_legacy_src")}
    legacy_chars = {"T1": s["legacy"].get("t1_chars_legacy_src"),
                    "T2": s["legacy"].get("t2_chars_legacy_src")}
    for t in _TIER_ORDER:
        old_s = ""
        if t in ("T1", "T2") and legacy_chars[t] is not None:
            old_s = (f"   (旧: {legacy_items[t]:,} 件 / "
                     f"{legacy_chars[t]:,} 字)")
        print(f"{t:<4}{s['new'][t]['items']:>10,}"
              f"{s['new'][t]['chars']:>14,}{old_s}")
    g = s["gate"]
    print(f"v3 门判定: T1={s['new']['T1']['chars']:,} ≥ {g['t1_min']:,} "
          f"→ {'PASS' if g['t1_pass'] else 'FAIL'} (如实, 不修饰)")
    if s["detail_path"]:
        print(f"明细: {s['detail_path']}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
