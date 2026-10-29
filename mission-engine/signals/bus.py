# -*- coding: utf-8 -*-
"""signals/bus.py — SignalBus 信号总线内核（W3.1）。

pull 链：discover → normalize → 契约校验 → 去重 → 落账。
账本 ledger/signals.jsonl 只增不删（站规）；去重=全量扫描既有 dedup_key，
无第二状态文件（append-only 单一事实源，天然免一致性问题；万行级毫秒扫）。
拒收/异常均留痕（reject 行 seq=None），单条/单源故障不拖垮总线。

适配器注册：signals/adapters/__init__.py:ADAPTERS——新源=新文件+注册一行。

CLI（cwd=mission-engine）：
  py -X utf8 -m signals.bus --pull [--adapter 名]      拉取→落账（单行JSON/源）
  py -X utf8 -m signals.bus --read [起点seq] [--source x] [--limit n]
退出码：0=全部完成  2=存在源级错误/未注册源  1=自身错误（无注册源等）
"""
from __future__ import annotations

import argparse
import json
import sys
import time
from pathlib import Path

from .adapters import ADAPTERS, build
from .adapters.base import Adapter
from .contract import ContractError, Signal

ROOT = Path(__file__).resolve().parents[1]     # mission-engine/


def _now() -> str:
    return time.strftime("%Y-%m-%d %H:%M:%S")


class SignalBus:
    def __init__(self, ledger_dir: Path | str | None = None):
        self.ledger_dir = Path(ledger_dir) if ledger_dir else ROOT / "ledger"
        self.ledger_file = self.ledger_dir / "signals.jsonl"

    def _scan(self) -> tuple[set[str], int]:
        """全量扫账本 → (已见 dedup_key 集, 最大 seq)。撕裂尾行容忍。"""
        keys, max_seq = set(), 0
        if not self.ledger_file.is_file():
            return keys, max_seq
        for raw in self.ledger_file.read_text(encoding="utf-8",
                                              errors="replace").splitlines():
            raw = raw.strip()
            if not raw:
                continue
            try:
                rec = json.loads(raw)
            except ValueError:
                continue
            if not isinstance(rec, dict):
                continue
            if rec.get("dedup_key"):
                keys.add(rec["dedup_key"])
            if isinstance(rec.get("seq"), int) and rec["seq"] > max_seq:
                max_seq = rec["seq"]
        return keys, max_seq

    def _append(self, rec: dict) -> None:
        self.ledger_dir.mkdir(parents=True, exist_ok=True)
        with open(self.ledger_file, "a", encoding="utf-8") as f:
            f.write(json.dumps(rec, ensure_ascii=False, separators=(",", ":")) + "\n")

    def _reject(self, source_type: str, reason: str, raw) -> None:
        self._append({"seq": None, "reject": True, "source_type": source_type,
                      "reason": reason[:200], "raw_excerpt": str(raw)[:200],
                      "ingested_at": _now()})

    def pull(self, adapter: Adapter) -> dict:
        """拉一个源：好信号落账，重复跳过，坏信号拒收留痕，源崩隔离。"""
        out = {"adapter": getattr(adapter, "source_type", type(adapter).__name__),
               "emitted": 0, "dup": 0, "rejected": 0, "errors": 0, "skipped": 0}
        try:
            raws = adapter.discover()
        except Exception as e:                  # noqa: BLE001 — 源级崩溃隔离
            out["errors"], out["err"] = 1, f"discover: {e}"[:200]
            self._reject(out["adapter"], f"discover: {e}", "«discover无raw»")
            return out
        keys, seq = self._scan()
        for raw in raws:
            try:
                norm = adapter.normalize(raw)
            except Exception as e:              # noqa: BLE001 — 单条崩不拖垮整源
                out["errors"] += 1
                self._reject(out["adapter"], f"normalize: {e}", raw)
                continue
            if norm is None:                 # 顶层 None=显式跳过该条
                out["skipped"] += 1
                continue
            items = norm if isinstance(norm, list) else [norm]
            for sig in items:
                if sig is None:              # 列表内 None=跳过该子信号
                    out["skipped"] += 1
                    continue
                try:
                    sig.validate()
                except ContractError as e:
                    out["rejected"] += 1
                    self._reject(out["adapter"], str(e), raw)
                    continue
                k = sig.dedup_key()
                if k in keys:
                    out["dup"] += 1
                    continue
                keys.add(k)
                seq += 1
                self._append({"seq": seq, "ingested_at": _now(),
                              "dedup_key": k, "signal": sig.to_dict()})
                out["emitted"] += 1
        return out

    def read(self, source_type: str | None = None,
             since_seq: int = 0, limit: int = 200) -> list[dict]:
        """读已落账信号（正序，seq>since_seq；reject 行天然被 int 过滤）。"""
        out: list[dict] = []
        if not self.ledger_file.is_file():
            return out
        for raw in self.ledger_file.read_text(encoding="utf-8",
                                              errors="replace").splitlines():
            raw = raw.strip()
            if not raw:
                continue
            try:
                rec = json.loads(raw)
            except ValueError:
                continue
            if not isinstance(rec, dict) or not isinstance(rec.get("seq"), int):
                continue
            if rec["seq"] <= since_seq:
                continue
            if source_type and rec["signal"].get("source_type") != source_type:
                continue
            out.append(rec)
            if len(out) >= limit:
                break
        return out


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(
        prog="signals.bus", description="SignalBus 信号总线内核（W3.1）")
    g = ap.add_mutually_exclusive_group(required=True)
    g.add_argument("--pull", action="store_true", help="拉取已注册适配器信号→落账")
    g.add_argument("--read", type=int, nargs="?", const=0, default=None,
                   metavar="起点SEQ", help="读信号账本（缺省从头，只读信号行）")
    ap.add_argument("--adapter", action="append",
                    help="--pull 只拉指定源（可重复；默认全部注册源）")
    ap.add_argument("--source", help="--read 按 source_type 过滤")
    ap.add_argument("--limit", type=int, default=200)
    ap.add_argument("--ledger-dir", default=None, help="私有账本目录（测试/旁路用）")
    args = ap.parse_args(argv)
    if args.pull:
        names = args.adapter or list(ADAPTERS)
        if not names:
            print(json.dumps({"pull_error": "无注册适配器（ADAPTERS 为空，W3.2 起注册）"},
                             ensure_ascii=False))
            return 1
        bus = SignalBus(args.ledger_dir)
        worst = 0
        for n in names:
            try:
                adapter = build(n)
            except KeyError as e:
                print(json.dumps({"adapter": n, "errors": 1, "err": str(e)},
                                 ensure_ascii=False, separators=(",", ":")))
                worst = 2
                continue
            r = bus.pull(adapter)
            if r.get("errors"):
                worst = 2
            print(json.dumps(r, ensure_ascii=False, separators=(",", ":")))
        return worst
    bus = SignalBus(args.ledger_dir)
    recs = bus.read(source_type=args.source,
                    since_seq=args.read or 0, limit=args.limit)
    print(json.dumps(recs, ensure_ascii=False, separators=(",", ":")))
    return 0


if __name__ == "__main__":
    sys.exit(main())
