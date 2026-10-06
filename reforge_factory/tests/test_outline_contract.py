# -*- coding: utf-8 -*-
"""S3-2 大纲锁定合同化单测 (outline-as-contract + 章级4态状态机).

覆盖: ①establish 三态入合同+指纹锚 ②变更零静默 (锁章拒改/开放章可改/
每次尝试含拒全留痕, 指纹 before/after) ③绕过合同手改 framework.json →
reconcile 指纹失配检出 ④refresh 只进不退 (推进留痕/解锁后保持留痕/
remove 退场) ⑤三方对账 (章态失配检出) ⑥promote 双门 (门未全过拒/
全过→writing).

跑法: python -X utf8 tests/test_outline_contract.py   (pytest 兼容)
"""
import json
import sys
import tempfile
from pathlib import Path

_TMP = Path(tempfile.mkdtemp(prefix="s32_test_"))
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import ammo_pool as AP                                # noqa: E402
from superline import chapter_matrix as CX            # noqa: E402
from superline import outline_contract as OC          # noqa: E402

AP.POOL_ROOT = _TMP / "ammo_pool"
_CAMP = "TEST-S32"
_camp = AP.POOL_ROOT / _CAMP
_camp.mkdir(parents=True)
OC.COMPLETENESS_DIRS[_CAMP] = _TMP / "pipeline"
(OC.COMPLETENESS_DIRS[_CAMP]).mkdir(parents=True)
(OC.COMPLETENESS_DIRS[_CAMP] / "completeness_v2.json").write_text(
    json.dumps({"passed": True, "counts": {"present": 40, "exempt": 9,
                                           "absent-ticketed": 7,
                                           "absent": 0}}),
    encoding="utf-8")

_BD = _TMP / "battle"
_OUT = _BD / "00 研究报告需求"
_OUT.mkdir(parents=True)
_FW = {"schema": "framework_v1", "campaign_id": _CAMP,
       "report_title": "《甲公司怎么干EPC总承包？》", "family": "enterprise",
       "version": 1, "chapters": [
           {"id": "ch01", "title": "引言", "description": "d",
            "tier_map": {"T1": ["甲公司"]}, "channels": ["current_increment"],
            "budget_band": "outline_wide", "evidence_density": "low"},
           {"id": "ch02", "title": "企业基本面", "description": "d",
            "tier_map": {"T1": ["乙公司"]}, "channels": ["current_increment"],
            "budget_band": "section_narrow", "evidence_density": "low"},
           {"id": "ch03", "title": "案例深钻", "description": "d",
            "tier_map": {"T3": ["量子扎带"]}, "channels": ["current_increment"],
            "budget_band": "gap", "evidence_density": "low"}],
       "volume_ref": {"chapters": 3, "sections": 30, "total_chars": 100000}}
(_OUT / "framework.json").write_text(
    json.dumps(_FW, ensure_ascii=False), encoding="utf-8")


def _row(key, title, chars, engine="e1"):
    return {"ts": "2026-03-01T08:00:00", "engine": engine,
            "source_path": f"E:/x/{title}.md",
            "url_norm": f"https://{key}.example.com/x", "chars": chars,
            "judge": "valid", "dedup_key": key}


def _seed(rows):
    (_camp / "manifest.jsonl").write_text(
        "\n".join(json.dumps(r, ensure_ascii=False) for r in rows) + "\n",
        encoding="utf-8")


_seed([_row(f"k-a{i}", f"甲公司报告{i}", 3500, f"e{i % 3 + 1}")
       for i in range(1, 13)]                      # ch01 饱和
      + [_row(f"k-b{i}", f"乙公司对标{i}", 600) for i in range(1, 4)]
      + [_row("k-b4", "乙公司补充", 600)])          # ch02 贫血; ch03 缺口


def _changes():
    return [json.loads(x) for x in
            (_OUT / OC.CHANGES_F).read_text(encoding="utf-8").splitlines()
            if x.strip()]


# ------------------------------------------------ ① 建合同
def test_01_establish_states_and_fingerprint():
    con = OC.establish(str(_BD), _CAMP)
    assert con["chapters"]["ch01"]["state"] == "locked"
    assert con["chapters"]["ch02"]["state"] == "collecting"
    assert con["chapters"]["ch03"]["state"] == "gap_scan"
    fw = json.loads((_OUT / "framework.json").read_text(encoding="utf-8"))
    assert con["fingerprint"] == OC.fingerprint(fw)
    assert OC.fingerprint(fw) == OC.fingerprint(json.loads(json.dumps(fw)))
    assert _changes()[0]["op"] == "establish"


# ------------------------------------------------ ② 变更零静默
def test_02_edit_zero_silence():
    r1 = OC.apply_edit(str(_BD), _CAMP, "retitle", "ch01",
                       value="新引言", reason="测试")
    assert not r1["applied"] and "已 locked" in r1["detail"]["error"]
    fp0 = OC.fingerprint(json.loads(
        (_OUT / "framework.json").read_text(encoding="utf-8")))
    r2 = OC.apply_edit(str(_BD), _CAMP, "retitle", "ch02",
                       value="企业基本面与沿革", reason="复盘补正")
    assert r2["applied"]
    fw = json.loads((_OUT / "framework.json").read_text(encoding="utf-8"))
    assert next(c for c in fw["chapters"]
                if c["id"] == "ch02")["title"] == "企业基本面与沿革"
    assert r2["fingerprint_before"] == fp0
    assert r2["fingerprint_after"] != fp0              # 指纹锚必变
    chs = _changes()
    assert any(c["op"] == "retitle" and not c["applied"] for c in chs)
    assert any(c["op"] == "retitle" and c["applied"] for c in chs)


# ------------------------------------------------ ③ 绕合同手改 → 指纹失配
def test_03_silent_mutation_detected():
    r = OC.reconcile(str(_BD), _CAMP)
    assert r["ok"] and r["fingerprint_ok"]             # 正门变更后账平
    fw = json.loads((_OUT / "framework.json").read_text(encoding="utf-8"))
    fw["chapters"][2]["title"] = "手改黑题"            # 绕过 apply_change
    (_OUT / "framework.json").write_text(
        json.dumps(fw, ensure_ascii=False), encoding="utf-8")
    r2 = OC.reconcile(str(_BD), _CAMP)
    assert not r2["fingerprint_ok"] and not r2["ok"]
    fw["chapters"][2]["title"] = "案例深钻"            # 还原
    (_OUT / "framework.json").write_text(
        json.dumps(fw, ensure_ascii=False), encoding="utf-8")
    assert OC.reconcile(str(_BD), _CAMP)["ok"]


# ------------------------------------------------ ④ refresh 只进不退
def test_04_refresh_advance_and_hold():
    _seed([_row(f"k-a{i}", f"甲公司报告{i}", 3500, f"e{i % 3 + 1}")
           for i in range(1, 13)]
          + [_row(f"k-b{i}", f"乙公司对标{i}", 600) for i in range(1, 4)]
          + [_row("k-b4", "乙公司补充", 600)]
          + [_row(f"k-q{i}", f"量子扎带应用{i}", 600) for i in range(1, 4)])
    con = OC.refresh(str(_BD), _CAMP)                  # ch03 缺口→贫血
    assert con["chapters"]["ch03"]["state"] == "collecting"
    assert any("ch03" in (c["detail"].get("moves") or {})
               for c in _changes() if c["op"] == "refresh")
    r = OC.apply_edit(str(_BD), _CAMP, "unlock", "ch01",
                      reason="章题重梳需重采")          # locked→collecting
    assert r["applied"]
    con = OC.refresh(str(_BD), _CAMP)                  # 矩阵仍饱和→钉住不回升
    assert con["chapters"]["ch01"]["state"] == "collecting"
    assert any("ch01" in (c["detail"].get("held") or {})
               for c in _changes() if c["op"] == "refresh")
    r2 = OC.apply_edit(str(_BD), _CAMP, "relock", "ch01")
    assert r2["applied"]                              # 矩阵饱和→解钉回升
    assert OC._load_contract(str(_BD))["chapters"]["ch01"][
        "state"] == "locked"
    # remove: 合同同步退场 (不留孤儿)
    r2 = OC.apply_edit(str(_BD), _CAMP, "remove", "ch02", reason="并入他章")
    assert r2["applied"]
    rec = OC.reconcile(str(_BD), _CAMP)
    assert rec["ok"] and not rec["orphan_in_contract"]


# ------------------------------------------------ ⑤ 章态失配检出
def test_05_reconcile_state_mismatch():
    con = OC._load_contract(str(_BD))
    con["chapters"]["ch03"]["state"] = "locked"        # 伪造账 (矩阵=collecting)
    OC._write(str(_BD), con)
    r = OC.reconcile(str(_BD), _CAMP)
    assert not r["ok"]
    assert any(m["chapter"] == "ch03" and m["contract"] == "locked"
               and m["matrix"] == "collecting"
               for m in r["state_mismatches"])


# ------------------------------------------------ ⑥ promote 双门
def test_06_promote_gates():
    con = OC._load_contract(str(_BD))                  # 还原 ch03
    con["chapters"]["ch03"]["state"] = "collecting"
    OC._write(str(_BD), con)
    r = OC.apply_edit(str(_BD), _CAMP, "promote", "ch01")
    assert not r["applied"]                            # ch01 现 collecting
    _orig = OC._read_gates
    try:
        OC._read_gates = lambda cid: {
            "ammo_gate_ok": True, "completeness_passed": True,
            "completeness_counts": {}, "snapshot_at": ""}
        con = OC._load_contract(str(_BD))
        con["chapters"]["ch01"]["state"] = "locked"    # 回 locked 供门测
        OC._write(str(_BD), con)
        r2 = OC.apply_edit(str(_BD), _CAMP, "promote", "ch01")
        assert r2["applied"]
        assert OC._load_contract(str(_BD))["chapters"]["ch01"][
            "state"] == "writing"
        assert any(c["op"] == "promote" and c["applied"] for c in _changes())
        # 门未全过 → 拒 (真实 _read_gates: 弹药门 42k<300万)
        OC._read_gates = _orig
        con["chapters"]["ch03"]["state"] = "locked"
        OC._write(str(_BD), con)
        r3 = OC.apply_edit(str(_BD), _CAMP, "promote", "ch03")
        assert not r3["applied"] and "门未全过" in r3["detail"]["error"]
    finally:
        OC._read_gates = _orig


if __name__ == "__main__":
    fns = [v for k, v in sorted(globals().items())
           if k.startswith("test_") and callable(v)]
    fail = 0
    for fn in fns:
        try:
            fn()
            print(f"  PASS {fn.__name__}")
        except Exception as e:
            fail += 1
            print(f"  FAIL {fn.__name__}: {type(e).__name__}: {e}")
    print(f"\n{len(fns) - fail}/{len(fns)} passed")
    sys.exit(1 if fail else 0)
