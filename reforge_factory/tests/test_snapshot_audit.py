# -*- coding: utf-8 -*-
"""REQ-044.AC1 snapshot_audit 审计器单测 (T-019).

tmp 池手搓 manifest 行验证分桶与 exit 码:
  covered (三字段+快照体在盘) / pending (snapshot_pending 单列豁免) /
  missing (字段缺或快照体丢 → exit 2) / 存量行豁免 / 非法行忽略 /
  全池扫描与 --campaign 过滤 / main() CLI exit 码.

跑法: py -m pytest reforge_factory/tests/test_snapshot_audit.py -q
"""
import hashlib
import json
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import snapshot_audit as SA                           # noqa: E402

_TMP = Path(tempfile.mkdtemp(prefix="t019_audit_")) / "pool"
_SINCE = "2026-10-15"                                 # REQ-044 W0 生效日


def _camp(cid: str) -> Path:
    d = _TMP / cid
    d.mkdir(parents=True, exist_ok=True)
    return d


def _write(cid: str, rows: list[dict]) -> Path:
    d = _camp(cid)
    (d / "manifest.jsonl").write_text(
        "\n".join(json.dumps(r, ensure_ascii=False) for r in rows) + "\n",
        encoding="utf-8")
    return d


def _covered(cid: str, ts: str, n: int = 1) -> dict:
    """带真实快照体的 covered 行 (内容模式: 战役目录内相对路径)."""
    body = f"EPC 总承包快照体 {cid} #{n}。" * 30
    h = hashlib.sha256(body.encode("utf-8")).hexdigest()
    d = _camp(cid)
    sdir = d / "snapshots" / h[:16]
    sdir.mkdir(parents=True, exist_ok=True)
    (sdir / "content.txt").write_text(body, encoding="utf-8")
    (sdir / "meta.json").write_text(json.dumps(
        {"mode": "content", "sha256": h, "snapshot_ts": ts},
        ensure_ascii=False), encoding="utf-8")
    return {"ts": ts, "judge": "valid", "chars": 100, "engine": "own:web",
            "source_path": f"x{n}.md", "dedup_key": f"c{cid}{n}",
            "snapshot_hash": h, "snapshot_ts": ts,
            "snapshot_url": f"snapshots/{h[:16]}/content.txt"}


def _bare(ts: str, judge: str = "valid", **over) -> dict:
    r = {"ts": ts, "judge": judge, "chars": 100, "engine": "own:web",
         "source_path": "y.md", "dedup_key": "k" + ts + judge}
    r.update(over)
    return r


# ------------------------------------------------ 分桶 + exit 2 (有缺)
def test_audit_buckets_and_exit2_on_missing():
    _write("C1", [
        _covered("C1", "2026-10-16T08:00:00"),
        _bare("2026-10-16T08:01:00", snapshot_pending=True,
              snapshot_error="OSError: x"),           # pending 单列豁免
        _bare("2026-10-16T08:02:00"),                 # 无三字段 → missing
        _bare("2026-10-14T08:03:00"),                 # 存量 (cutoff 前) 豁免
        _bare("2026-10-16T08:04:00", judge="rejected"),   # 非 valid 忽略
        _bare("2026-10-16T08:05:00", judge="pending"),    # 待审忽略
    ])
    reps, code = SA.run_audit(_TMP, "C1", _SINCE)
    r = reps[0]
    assert r["incremental_valid"] == 3                # covered+pending+missing
    assert r["covered"] == 1
    assert r["pending"] == 1                          # 单列, 不计缺
    assert r["missing"] == 1
    assert r["fields"] == {"hash": 1, "ts": 1, "url": 1}
    assert code == 2                                  # 有缺 → exit 2


# ------------------------------------------------ 全覆盖 exit 0
def test_audit_exit0_when_full_coverage():
    _write("C2", [
        _covered("C2", "2026-10-16T09:00:00", 1),
        _covered("C2", "2026-10-16T09:00:01", 2),
        _bare("2026-10-15T23:59:59"),                 # 生效日当天=基线豁免
        _bare("2026-10-16T09:01:00", judge="rejected"),
    ])
    reps, code = SA.run_audit(_TMP, "C2", _SINCE)
    r = reps[0]
    assert r["incremental_valid"] == 2 and r["covered"] == 2
    assert r["missing"] == 0 and r["pending"] == 0
    assert code == 0


# ------------------------------------------------ 三字段齐但快照体丢
def test_audit_artifact_missing_counts_missing():
    row = _covered("C3", "2026-10-16T10:00:00")
    row["snapshot_url"] = "snapshots/deadbeefdeadbeef/content.txt"  # 体被删
    _write("C3", [row])
    reps, code = SA.run_audit(_TMP, "C3", _SINCE)
    r = reps[0]
    assert r["covered"] == 0 and r["missing"] == 1
    assert r["artifact_missing"] == 1                # 单列提示体丢
    assert code == 2


# ------------------------------------------------ 指针模式体=本地原文件
def test_audit_pointer_mode_artifact():
    fp = _TMP / "off.pdf"
    fp.write_bytes(b"%PDF-fake-official")
    h = hashlib.sha256(fp.read_bytes()).hexdigest()
    _write("C4", [{"ts": "2026-10-16T11:00:00", "judge": "valid",
                   "chars": 100, "engine": "own:web", "source_path": str(fp),
                   "dedup_key": "ptr1", "snapshot_hash": h,
                   "snapshot_ts": "2026-10-16T11:00:01",
                   "snapshot_url": str(fp), "snapshot_mode": "pointer"}])
    reps, code = SA.run_audit(_TMP, "C4", _SINCE)
    assert reps[0]["covered"] == 1 and code == 0


# ------------------------------------------------ 全池扫描 + 过滤 + 汇总
def test_audit_all_campaigns_and_filter():
    _write("C5", [_covered("C5", "2026-10-16T12:00:00")])
    _write("C6", [_bare("2026-10-16T12:01:00")])      # 缺快照
    reps_all, code_all = SA.run_audit(_TMP, "", _SINCE)
    names = {r["campaign"] for r in reps_all}
    assert {"C5", "C6"} <= names and code_all == 2    # 任一池缺 → 汇总 2
    reps_one, code_one = SA.run_audit(_TMP, "C5", _SINCE)
    assert [r["campaign"] for r in reps_one] == ["C5"] and code_one == 0


# ------------------------------------------------ 指定池无 manifest → exit 1
def test_audit_missing_manifest_exit1():
    _camp("C7")                                       # 空目录无 manifest
    _, code = SA.run_audit(_TMP, "C7", _SINCE)
    assert code == 1


# ------------------------------------------------ main() CLI exit 码
def test_main_cli_exit_codes(monkeypatch, capsys):
    monkeypatch.setattr(sys, "argv", ["snapshot_audit.py",
                                      "--campaign", "C2",
                                      "--since", _SINCE,
                                      "--pool-root", str(_TMP)])
    assert SA.main() == 0
    out = capsys.readouterr().out
    assert "100.0%" in out and "C2" in out
    monkeypatch.setattr(sys, "argv", ["snapshot_audit.py",
                                      "--campaign", "C3",
                                      "--since", _SINCE,
                                      "--pool-root", str(_TMP)])
    assert SA.main() == 2
    assert "有缺" in capsys.readouterr().out
