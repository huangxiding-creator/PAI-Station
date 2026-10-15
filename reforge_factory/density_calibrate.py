# -*- coding: utf-8 -*-
"""density_calibrate — 密度门阈值黄金样板分位数标定 (百倍V3 待办三 /
REQ-014: 阈值表从临时基线升为黄金样板章全量分位数标定值).

黄金样板 = 已出版蓝皮书五卷章节 (490,422 字/65 章全过门成书, 用户令
「密度阈值黄金样板标定」所指语料)。标定法 (数字零造假):

  redundancy_ratio_max   = P95(样板冗余率)     — 尾部 5% 视为越线
  new_ngram_rate_min     = P5 (样板新 n-gram 率) — 底部 5% 视为词汇贫乏
  slop_density_per_kchar_max = P95(样板 slop 密度)

  分类型 (精编/融合/原创) 独立标定; 样本 <8 的类型并注 n 并对 defaults
  同法标定。标定后回验双门:
  A) 坏样本仍拒 — 合成复读文本 (repeat) 与 slop 堆砌文本必须 reject;
  B) 样板通过率报告 — P95 定律下预期 ≈95%, 实测如实打印 (不调数字凑).

落盘: density_thresholds.json 版本+1, note 记标定溯源 (语料/n/分位数/
旧值), 旧阈值表整体保存在 "superseded" 键 (只增不删, 可回看)。

用法: py reforge_factory/density_calibrate.py [--corpus 蓝皮书目录]
      [--config 阈值json] [--dry]
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from pathlib import Path
from statistics import quantiles

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
import density_gate as dg                                   # noqa: E402

DEFAULT_CORPUS = Path(
    r"E:\AI-Station\_proposals\flagship-paid-report-1007\bluebook")
DEFAULT_CONFIG = dg.DEFAULT_THRESHOLDS_PATH
_TYPE_RE = re.compile(          # 宽容: **三态**：[精编] / 三态＝［融合］ / 三态行：[精编+判断]
    r"三态[*＊=＝行]{0,3}\s*[：:=＝]?\s*[\[［]\s*(精编|融合|原创|补采)")
_TYPE_RE_FALLBACK = re.compile(  # 无三态前缀: **[精编]** / [融合+ACH]
    r"[\[［]\s*(精编|融合|原创|补采)\s*[\]］+＋]")
_CHAPTER_RE = re.compile(r"^\d")

# 坏样本回验语料 (与临时基线校准时同一族, 见 config note)
_BAD_REPEAT = ("招投标合规" * 400)          # 纯复读 → 冗余爆表
_BAD_SLOP = ("值得注意的是，综上所述，不难发现，由此可见，总而言之。" * 60
             + "工程项目管理实践" * 30)      # slop 堆砌


def infer_type(text: str) -> str | None:
    head = text[:800]
    m = _TYPE_RE.search(head) or _TYPE_RE_FALLBACK.search(head)
    return m.group(1) if m else None


def collect(corpus: Path) -> list[dict]:
    """黄金章样本: vol1..vol5 下章文件 (数字开头), 读文/推型/测指标."""
    out = []
    for vol in sorted(corpus.glob("vol*")):
        if not vol.is_dir():
            continue
        for md in sorted(vol.glob("*.md")):
            if not _CHAPTER_RE.match(md.name):
                continue
            try:
                text = md.read_text(encoding="utf-8")
            except OSError:
                continue
            ctype = infer_type(text)
            if not ctype:
                continue
            m = dg.metrics(text)
            out.append({"file": md.name, "vol": vol.name, "type": ctype,
                        **{k: m[k] for k in
                           ("redundancy_ratio", "new_ngram_rate",
                            "slop_density_per_kchar", "cjk_chars")}})
    return out


def _pct(vals: list[float], p: float) -> float:
    """线性插值分位数 (inclusive), 空列 0.0."""
    if not vals:
        return 0.0
    if len(vals) == 1:
        return vals[0]
    q = quantiles(vals, n=20, method="inclusive")   # 5% 步进 → 索引 p/5-1
    return q[min(len(q) - 1, max(0, int(p / 5) - 1))]


def calibrate(samples: list[dict]) -> dict:
    """样本 → 分类型阈值 + defaults (全样本) + 溯源."""
    def block(rows: list[dict]) -> dict:
        return {
            "redundancy_ratio_max": round(_pct(
                [r["redundancy_ratio"] for r in rows], 95), 3),
            "new_ngram_rate_min": round(_pct(
                [r["new_ngram_rate"] for r in rows], 5), 3),
            "slop_density_per_kchar_max": round(_pct(
                [r["slop_density_per_kchar"] for r in rows], 95), 3),
        }

    by_type: dict[str, list[dict]] = {}
    for s in samples:
        by_type.setdefault(s["type"], []).append(s)
    # 补采等杂型样本并入 defaults 池不单独立块 (n<8 过拟合; 门表无其块
    # 自然落 defaults — 同判据, 如实)
    minor = {t for t, rows in by_type.items() if len(rows) < 8}
    th = {"defaults": block(samples)}
    for t, rows in sorted(by_type.items()):
        if t not in minor:
            th[t] = block(rows)
    prov = {t: len(rows) for t, rows in sorted(by_type.items())}
    prov_in_defaults = sorted(minor)
    return {"thresholds": th, "n_by_type": prov,
            "minor_types_in_defaults": prov_in_defaults,
            "n_total": len(samples)}


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description="密度门黄金样板分位数标定")
    ap.add_argument("--corpus", default=str(DEFAULT_CORPUS))
    ap.add_argument("--config", default=str(DEFAULT_CONFIG))
    ap.add_argument("--dry", action="store_true")
    ns = ap.parse_args(argv)

    corpus, cfg_path = Path(ns.corpus), Path(ns.config)
    samples = collect(corpus)
    if len(samples) < 20:
        print(f"[calib] 黄金样板不足 20 章 ({len(samples)}), 拒标定",
              file=sys.stderr)
        return 2
    cal = calibrate(samples)
    old = json.loads(cfg_path.read_text(encoding="utf-8"))

    # 样板通过率回验 (新表写 tmp, chapter_verdict 指到 tmp)
    tmp_cfg = cfg_path.with_suffix(".json.tmp")
    tmp_cfg.write_text(json.dumps(
        {"thresholds": cal["thresholds"]}, ensure_ascii=False), encoding="utf-8")
    n_pass = 0
    fails = []
    for s in samples:
        text = (corpus / s["vol"] / s["file"]).read_text(encoding="utf-8")
        v = dg.chapter_verdict(text, s["type"], thresholds_path=str(tmp_cfg),
                               reject_log=False)
        if v["verdict"] == "pass":
            n_pass += 1
        else:
            fails.append(f"{s['vol']}/{s['file']}")
    # 坏样本回验: 两文本在三类章型下都必须 reject
    bad_ok = True
    for t in ("精编", "融合", "原创"):
        for label, txt in (("repeat", _BAD_REPEAT), ("slop", _BAD_SLOP)):
            v = dg.chapter_verdict(txt, t, thresholds_path=str(tmp_cfg),
                                   reject_log=False)
            if v["verdict"] != "reject":
                bad_ok = False
                print(f"[calib] ⚠ 坏样本未拒: {label}/{t}")
    tmp_cfg.unlink(missing_ok=True)

    print(f"[calib] 样板 {cal['n_total']} 章 {cal['n_by_type']} | "
          f"通过率 {n_pass}/{len(samples)}"
          f" ({n_pass / len(samples):.0%}) | 坏样本回验 "
          f"{'✅ 全拒' if bad_ok else '❌ 有漏拒'}")
    print(f"[calib] 新阈值: {json.dumps(cal['thresholds'], ensure_ascii=False)}")
    if fails:
        print(f"[calib] P95 尾部越线章 ({len(fails)}): {', '.join(fails[:6])}"
              f"{'…' if len(fails) > 6 else ''}")
    if not bad_ok:
        print("[calib] 标定值拒坏失守 — 不落盘, 人工复核", file=sys.stderr)
        return 2

    if not ns.dry:
        new_cfg = {
            "version": int(old.get("version", 1)) + 1,
            "note": (f"黄金样板分位数标定 ({time.strftime('%Y-%m-%d')}): "
                     f"蓝皮书五卷 {cal['n_total']} 章 (P95/P5/P95); "
                     f"回验坏样本全拒/样板通过率 {n_pass}/{len(samples)}; "
                     f"旧表见 superseded (v{old.get('version', 1)} 临时基线)"),
            "metric_notes": old.get("metric_notes", {}),
            "calibration": {"corpus": str(corpus), "method": "P95/P5/P95 inclusive",
                            "n_by_type": cal["n_by_type"],
                            "calibrated": time.strftime("%Y-%m-%dT%H:%M:%S")},
            "superseded": {"version": old.get("version", 1),
                           "note": old.get("note", ""),
                           "thresholds": old.get("thresholds", {})},
            "thresholds": cal["thresholds"],
        }
        tmp = cfg_path.with_suffix(".json.tmp")
        tmp.write_text(json.dumps(new_cfg, ensure_ascii=False, indent=1),
                       encoding="utf-8")
        tmp.replace(cfg_path)
        print(f"[calib] 落盘: {cfg_path} (v{new_cfg['version']})")
    else:
        print("[calib] DRY — 未落盘")
    return 0


if __name__ == "__main__":
    sys.exit(main())
