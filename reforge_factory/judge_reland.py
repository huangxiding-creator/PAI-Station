# -*- coding: utf-8 -*-
"""judge_reland — off_topic 复判腿 (1015 补采配套).

场景: 战役 kws 扩容后 (树十面获用户批准 → kws 14→26), 旧判 off_topic 的
行按**当前** kws 复判 — 判据升级后的正当复评, 非翻案工具:
  1. 只翻 judge_reason=="off_topic" 一类 (garbage/substance 拒绝不碰);
  2. 复判结果原样三态 (valid/rejected/pending), 复判后仍拒=维持拒绝
     (新判据也救不回, 如实); judge_reason 加 reland 前缀留痕;
  3. 池锁内重写 manifest (与 _judge_locked 同机械) + rebuild 重算台账;
  4. 备份 manifest.pre-reland.bak.jsonl 一次 (只增)。

用法: py reforge_factory/judge_reland.py --campaign EPC-BID26 [--dry]
"""
from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
import ammo_pool as ap                                   # noqa: E402


def run(cid: str, dry: bool = False) -> int:
    d = ap._camp_dir(cid)
    mp = d / "manifest.jsonl"
    if not mp.is_file():
        print(f"[reland] 无 manifest: {cid}", file=sys.stderr)
        return 2
    with ap._pool_lock(d):
        rows = [json.loads(x) for x in
                mp.read_text(encoding="utf-8").splitlines() if x.strip()]
        kws = ap._load_state(d).get("kws", [])
        n_flipped_valid = n_keep_rej = n_missing = 0
        for row in rows:
            if row.get("judge") != "rejected":
                continue
            reason = str(row.get("judge_reason") or "")
            if reason != "off_topic" and not reason.startswith(
                    "reland_still_off_topic"):
                continue                      # 只翻 off_topic 一族 (含复判后仍off的)
            fp = Path(row["source_path"])
            if not fp.is_file():
                n_missing += 1
                continue
            text = ap.read_text_safe(fp)
            verdict, reason = ap.judge_heuristic(text, kws)
            old = f"{row['judge']}/{row['judge_reason']}"
            if verdict == "valid":
                row.update(judge="valid", judge_reason=f"reland:{reason}",
                           judge_engine="heuristic-v2-kws26")
                n_flipped_valid += 1
            else:
                row.update(judge_reason=f"reland_still_{reason}")
                n_keep_rej += 1
        if dry:
            print(f"[reland] DRY: 可复判行 processed | 翻 valid "
                  f"{n_flipped_valid} | 维持拒 {n_keep_rej} | 文件缺失 "
                  f"{n_missing} | 当前 kws {len(kws)}")
            return 0
        bak = d / "manifest.pre-reland.bak.jsonl"
        if not bak.is_file():
            mp.replace(bak)
        mp.write_text(
            "".join(json.dumps(r, ensure_ascii=False) + "\n" for r in rows),
            encoding="utf-8")
    ap.rebuild(cid)                       # 台账按行重算 (valid 账恢复)
    print(f"[reland] 翻 valid {n_flipped_valid} | 维持拒 {n_keep_rej} | "
          f"文件缺失 {n_missing} | 备份 {bak.name}")
    return 0


def main() -> int:
    apx = argparse.ArgumentParser(description="off_topic 复判 (kws 扩容配套)")
    apx.add_argument("--campaign", required=True)
    apx.add_argument("--dry", action="store_true")
    ns = apx.parse_args()
    return run(ns.campaign, ns.dry)


if __name__ == "__main__":
    sys.exit(main())
