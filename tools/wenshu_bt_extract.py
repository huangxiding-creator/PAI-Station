# -*- coding: utf-8 -*-
"""wenshu_bt_extract——95G 裁判文书语料（E:/wenshu_bt 37 个年度 zip 1985-2021）流式定向抽取。

设计事实（1006 实测）：
  - 每年度 zip = 12 个月度 CSV（UTF-8-BOM，15 列，末列=全文）+ 固定 PDF/HTML
  - 不解压落盘：zipfile 流式逐行；词面三级过滤；manifest 逐 CSV 记 done 断点续

三级词表（ammo-gate 语义）：
  T1 战役本体词（ammo_pool/<battle>/tiers.json T1）→ 全收，全文完整落盘
  T2 同业对标词（同文件 T2）→ 全收，全文截 30K
  T3 = 工程总承包族 × 能源电力族 AND 组合 → 全局封顶 DEFAULT_T3_CAP，全文截 30K
  T0 泛命中不收（judge 层职责，抽取层不凑数）

CLI:
  python wenshu_bt_extract.py --battle EPC49-SEPDC [--years 2013-2021]
      [--zips-dir E:/wenshu_bt/裁判文书全量数据（已完成）] [--out E:/wenshu_bt/extract]
      [--max-minutes 240] [--epc-cap N]
"""
import csv
import io
import json
import re
import sys
import time
import zipfile
from pathlib import Path

DEFAULT_T3_CAP = 5000
T23_FULL_KEEP = 30000  # T2/T3 全文截断字符数
EPC_A = ("工程总承包", "EPC", "设计采购施工", "DB总承包", "总承包合同")
ENERGY_B = ("电力", "风电", "光伏", "火电", "水电", "核电", "变电站", "输变电",
            "新能源", "勘测设计", "抽水蓄能")

AMMO_ROOT = Path("E:/AI-Station/ammo_pool")
DEFAULT_ZIPS = Path("E:/wenshu_bt/裁判文书全量数据（已完成）")
DEFAULT_OUT = Path("E:/wenshu_bt/extract")

# 15 列索引（1006 实测表头）
IX_NAME, IX_PARTIES, IX_CAUSE, IX_FULL = 2, 11, 12, 14


def _p(msg):
    """pythonw None.stdout 守卫——无控制台时不炸。"""
    try:
        print(msg, flush=True)
    except Exception:
        pass


def _year_of(name):
    m = re.search(r"(19|20)\d{2}", name)
    return int(m.group(0)) if m else None


def year_of(name):
    return _year_of(name)


def load_terms(battle):
    """读 ammo_pool/<battle>/tiers.json → (t1, t2)。词表变更须 RUN_LEDGER 留痕（1005 令）。"""
    f = AMMO_ROOT / battle / "tiers.json"
    t = json.loads(f.read_text(encoding="utf-8"))
    return (list(t.get("T1") or []), list(t.get("T2") or []), list(t.get("T3") or []))


def classify(row, terms, caps):
    """纯分类：T1/T2/T3 或 None。caps 为可变计数 dict（t3_used 封顶）。"""
    t1, t2, _t3 = terms
    try:
        name, parties, cause = row[IX_NAME], row[IX_PARTIES], row[IX_CAUSE]
        full = row[IX_FULL]
    except IndexError:
        return None
    brief = name + " " + parties + " " + cause
    for w in t1:
        if w in brief or w in full[:8192]:
            return "T1"
    for w in t2:
        if w in brief:
            return "T2"
    if caps.get("t3_used", 0) >= caps.get("t3_cap", DEFAULT_T3_CAP):
        return None
    has_a = any(w in brief for w in EPC_A) or any(w in full[:4096] for w in EPC_A)
    if not has_a:
        return None
    has_b = any(w in brief for w in ENERGY_B) or any(w in cause for w in ENERGY_B) \
        or any(w in full[:4096] for w in ENERGY_B)
    if has_b:
        caps["t3_used"] = caps.get("t3_used", 0) + 1
        return "T3"
    return None


def load_done(out_dir):
    """manifest.jsonl → 已完成 CSV 键集（断点续）。"""
    man = Path(out_dir) / "manifest.jsonl"
    done = set()
    if man.exists():
        for line in man.read_text(encoding="utf-8").splitlines():
            if line.strip():
                try:
                    r = json.loads(line)
                    if r.get("status") == "done":
                        done.add(f"{r['zip']}::{r['csv']}")
                except (json.JSONDecodeError, KeyError):
                    continue
    return done


def process_csv(zip_path, csv_name, terms, out_dir, caps, full_keep_t1=True):
    """流式处理单个月度 CSV → 写 <yyyy>_<mm>.jsonl + manifest 行。幂等：.part 原子 rename。"""
    out = Path(out_dir)
    out.mkdir(parents=True, exist_ok=True)
    m = re.search(r"((19|20)\d{2})年(\d{2})月", csv_name)
    stem = f"{m.group(1)}_{m.group(3)}" if m else re.sub(r"\W+", "_", csv_name)[:40]
    jf = out / f"{stem}.jsonl"
    part = jf.with_suffix(".jsonl.part")
    stats = {"scanned": 0, "t1": 0, "t2": 0, "t3": 0}
    csv.field_size_limit(16 * 2 ** 20)
    with zipfile.ZipFile(zip_path) as z:
        with z.open(csv_name) as f:
            text = io.TextIOWrapper(f, encoding="utf-8-sig", errors="replace", newline="")
            reader = csv.reader(text)
            next(reader, None)  # header
            with open(part, "w", encoding="utf-8", newline="\n") as w:
                for row in reader:
                    stats["scanned"] += 1
                    tier = classify(row, terms, caps)
                    if tier is None:
                        continue
                    stats["t1" if tier == "T1" else "t2" if tier == "T2" else "t3"] += 1
                    full = row[IX_FULL]
                    if tier != "T1" and len(full) > T23_FULL_KEEP:
                        full = full[:T23_FULL_KEEP]
                    rec = {
                        "tier": tier,
                        "case": {k: row[i] for i, k in
                                 ((1, "案号"), (IX_NAME, "案件名称"), (3, "法院"),
                                  (9, "裁判日期"), (IX_CAUSE, "案由"))},
                        "全文": full,
                        "meta": {"zip": Path(zip_path).name, "csv": csv_name,
                                 "row": stats["scanned"]},
                    }
                    w.write(json.dumps(rec, ensure_ascii=False) + "\n")
    part.rename(jf)
    with open(out / "manifest.jsonl", "a", encoding="utf-8") as w:
        w.write(json.dumps({
            "zip": Path(zip_path).name, "csv": csv_name, "status": "done",
            "scanned": stats["scanned"], "t1": stats["t1"], "t2": stats["t2"],
            "t3": stats["t3"], "ts": time.strftime("%Y-%m-%d %H:%M:%S"),
        }, ensure_ascii=False) + "\n")
    return stats


def main(argv=None):
    import argparse
    ap = argparse.ArgumentParser(description="wenshu BT 语料流式定向抽取")
    ap.add_argument("--battle", required=True, help="ammo_pool 战役名，如 EPC49-SEPDC")
    ap.add_argument("--zips-dir", default=str(DEFAULT_ZIPS))
    ap.add_argument("--out", default=None, help="默认 E:/wenshu_bt/extract/<battle>")
    ap.add_argument("--years", default=None, help="如 2013-2021 或 2019")
    ap.add_argument("--max-minutes", type=float, default=240.0)
    ap.add_argument("--epc-cap", type=int, default=DEFAULT_T3_CAP)
    ap.add_argument("--limit-csv", type=int, default=0, help="冒烟：只跑前 N 个 CSV")
    a = ap.parse_args(argv)

    t1, t2, _ = load_terms(a.battle)
    if not t1:
        _p(f"[FATAL] {a.battle} tiers.json 无 T1 词，拒绝全泛匹配跑批")
        return 2
    terms = (t1, t2, [])
    out_dir = Path(a.out) if a.out else DEFAULT_OUT / a.battle
    caps = {"t3_used": 0, "t3_cap": a.epc_cap}

    if a.years:
        if "-" in a.years:
            y0, y1 = (int(x) for x in a.years.split("-", 1))
        else:
            y0 = y1 = int(a.years)
    else:
        y0, y1 = 0, 9999

    zips = sorted((p for p in Path(a.zips_dir).glob("*.zip")
                   if y0 <= (year_of(p.name) or 0) <= y1), key=lambda p: p.name)
    if not zips:
        _p(f"[FATAL] {a.zips_dir} 无 {y0}-{y1} 年 zip")
        return 2
    done = load_done(out_dir)
    _p(f"[wenshu-extract] battle={a.battle} zips={len(zips)} 已done={len(done)} "
       f"out={out_dir} epccap={a.epc_cap}")

    t0 = time.time()
    total = {"scanned": 0, "t1": 0, "t2": 0, "t3": 0, "csv": 0}
    stop_reason = ""
    budget_stop = False
    for zp in zips:
        if budget_stop:
            break
        with zipfile.ZipFile(zp) as z:
            csvs = [n for n in z.namelist() if n.endswith(".csv")]
            for cn in csvs:
                key = f"{zp.name}::{cn}"
                if key in done:
                    continue
                if a.limit_csv and total["csv"] >= a.limit_csv:
                    stop_reason, budget_stop = "limit_csv", True
                    break
                if (time.time() - t0) / 60 > a.max_minutes:
                    stop_reason, budget_stop = "max_minutes", True
                    break
                st = process_csv(str(zp), cn, terms, str(out_dir), caps)
                for k in ("scanned", "t1", "t2", "t3"):
                    total[k] += st[k]
                total["csv"] += 1
                _p(f"  [{zp.name}::{cn.split('/')[-1]}] scanned={st['scanned']} "
                   f"T1={st['t1']} T2={st['t2']} T3={st['t3']} "
                   f"elapsed={time.time()-t0:.0f}s")
    summary = {"battle": a.battle, **total, "t3_used": caps["t3_used"],
               "stop_reason": stop_reason, "minutes": round((time.time() - t0) / 60, 1)}
    (out_dir / "summary.json").write_text(
        json.dumps(summary, ensure_ascii=False, indent=2), encoding="utf-8")
    _p("[SUMMARY] " + json.dumps(summary, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    sys.exit(main())
