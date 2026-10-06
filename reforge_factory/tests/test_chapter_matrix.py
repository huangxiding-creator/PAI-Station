# -*- coding: utf-8 -*-
"""S3-1 章节×证据双向对账器单测.

覆盖: ①build 三态/处置判定 (饱和锁定·贫血扩写/合并/降级·缺口补扫) ②四权
口径 (同 epc-deep-research 阈值, 手算锚) ③权威度分布+独立源 ④load_rows
valid×dedup 同 tier_report 语义 ⑤audit_sample 抽样零漂移+漂移可检出 ⑥
dispatch_rescan 真实入队 (CONDUCTOR_STATE 测试态闸隔离) + rescan_ledger
留痕.

跑法: python -X utf8 tests/test_chapter_matrix.py   (pytest 兼容)
"""
import json
import os
import sys
import tempfile
from pathlib import Path

_TMP = Path(tempfile.mkdtemp(prefix="s31_test_"))
# 测试态闸先立 (cc.STATE 在 import 时读 env; dispatch 惰性 import → 先到先得)
os.environ["CONDUCTOR_STATE"] = str(_TMP / "conductor_state.json")
os.environ["ROUTER_STATE"] = str(_TMP / "router_state.json")
_REGF = _TMP / "channels_v2.json"
_REGF.write_text(json.dumps({"channels": {
    "fake_fulltext": {
        "disposition": "dispatch", "auto_dispatch": True,
        "tier_fit": "T1,T2,T3,泛", "content_types": ["全文"],
        "cmd_template": "python E:/tmp/fake_collector.py --kw {K} "
                        "--battle {battle_dir}"}
}}, ensure_ascii=False), encoding="utf-8")
os.environ["CHANNELS_V2"] = str(_REGF)

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import ammo_pool as AP                                # noqa: E402
from superline import chapter_matrix as CM            # noqa: E402

AP.POOL_ROOT = _TMP / "ammo_pool"
_CAMP = "TEST-S31"
_camp = AP.POOL_ROOT / _CAMP
_camp.mkdir(parents=True)

_FW = {"schema": "framework_v1", "campaign_id": _CAMP,
       "report_title": "《乙公司怎么干EPC总承包？》", "family": "enterprise",
       "chapters": [
           {"id": "ch01", "title": "引言与研究框架",
            "tier_map": {"T1": ["甲公司"]}, "budget_band": "outline_wide",
            "evidence_density": "high"},
           {"id": "ch02", "title": "企业基本面",
            "tier_map": {"T1": ["乙公司"]}, "budget_band": "section_narrow",
            "evidence_density": "medium"},
           {"id": "ch03", "title": "案例深钻",
            "tier_map": {"T3": ["量子扎带"]}, "budget_band": "gap",
            "evidence_density": "low"},
           {"id": "ch04", "title": "企业基本面续",
            "tier_map": {"T1": ["乙公司"]}, "budget_band": "section_narrow",
            "evidence_density": "medium"},
           {"id": "ch05", "title": "风险管控",
            "tier_map": {"T1": ["戊公司"]}, "budget_band": "section_narrow",
            "evidence_density": "medium"},
           {"id": "ch06", "title": "技术前沿",
            "tier_map": {"T3": ["墨子技术"]}, "budget_band": "gap",
            "evidence_density": "low"}]}


def _row(key: str, title: str, chars: int, engine: str, grade: str = "B",
         ts: str = "2026-03-01T08:00:00", judge: str = "valid") -> dict:
    return {"ts": ts, "engine": engine,
            "source_path": f"E:/x/{title}.md",
            "url_norm": f"https://{key}.example.com/x", "chars": chars,
            "judge": judge, "dedup_key": key, "authority_grade": grade}


_ROWS = (
    [_row(f"k-a{i}", f"甲公司报告{i}", 3500, f"e{i % 3 + 1}",
          grade="ABC"[i % 3]) for i in range(1, 13)]      # ch01 饱和: 100
    + [_row(f"k-b{i}", f"乙公司对标研究{i}", 600, "e1") for i in range(1, 4)]
    + [_row("k-d1", "乙公司补充专题", 600, "e1")]          # ch02/ch04 同证据
    + [_row(f"k-e{i}", f"戊公司观察{i}", 600, "e1") for i in range(1, 4)]
    + [_row(f"k-f{i}", f"墨子技术展望{i}", 600, "e1") for i in range(1, 4)]
    + [_row("k-pend", "甲公司待审件", 900, "e2", judge="pending")])
(_camp / "manifest.jsonl").write_text(
    "\n".join(json.dumps(r, ensure_ascii=False) for r in _ROWS) + "\n",
    encoding="utf-8")


# ------------------------------------------------ ①②③ 三态/处置/四权/权威度
def test_build_states_actions_and_scores():
    m = CM.build(_FW, CM.load_rows(_CAMP), cur_year=2026)
    assert m["state_dist"] == {"饱和": 1, "贫血": 4, "缺口": 1}
    by = {c["id"]: c for c in m["chapters"]}
    assert by["ch01"]["state"] == "饱和" and by["ch01"]["action"] == "锁定"
    # 四权手算锚: 12件=30 + 均3500=30 + 3引擎=20 + 当年=20 → 100
    assert by["ch01"]["union"]["score"] == {
        "count": 30, "depth": 30, "diversity": 20, "recency": 20, "total": 100}
    # 权威度分布 A/B/C 轮转 4/4/4
    assert by["ch01"]["union"]["authority"] == {
        "A": 4, "B": 4, "C": 4, "未分级": 0}
    assert by["ch01"]["union"]["domains"] == 12        # 12 独立源
    assert by["ch02"]["state"] == "贫血"
    assert by["ch02"]["action"] == "合并"              # 与 ch04 证据全同
    assert by["ch02"]["max_overlap"] == 1.0
    assert by["ch03"]["state"] == "缺口"
    assert by["ch03"]["action"] == "补扫"
    assert by["ch03"]["cells"]["T3"]["items"] == 0     # 零证据格在账
    assert by["ch05"]["action"] == "扩写"              # 贫血+独占证据+有T1
    assert by["ch06"]["action"] == "降级"              # 贫血+仅T3词


# ------------------------------------------------ ④ valid×dedup 同语义
def test_load_rows_valid_dedup():
    rows = CM.load_rows(_CAMP)
    assert len(rows) == 22                              # pending 不计
    assert not any(r["dedup_key"] == "k-pend" for r in rows)
    with (_camp / "manifest.jsonl").open("a", encoding="utf-8") as f:
        f.write(json.dumps(_row("k-a1", "甲公司报告1重复", 3500, "e1"),
                           ensure_ascii=False) + "\n")
    assert len(CM.load_rows(_CAMP)) == 22               # dedup_key 二次不计


# ------------------------------------------------ ⑤ 抽样对账零漂移
def test_audit_sample_zero_drift_and_detection():
    rows = CM.load_rows(_CAMP)
    m = CM.build(_FW, rows, cur_year=2026)
    a = CM.audit_sample(m, rows, n=10)                  # 非空格 5 个
    assert a["sampled"] == 5 and a["drift_cells"] == 0 and a["ok"]
    assert CM.audit_sample(m, rows, n=2)["sampled"] == 2
    tampered = [{**r, "chars": r["chars"] + 7} if r["dedup_key"] == "k-a7"
                else r for r in rows]                   # 模拟账本漂移
    a2 = CM.audit_sample(m, tampered, n=10)
    assert a2["drift_cells"] == 1 and not a2["ok"]      # 漂移可检出


# ------------------------------------------------ ⑥ 补扫单真实出队留痕
def test_dispatch_rescan_real_enqueue():
    bd = _TMP / "battle"
    out = bd / "00 研究报告需求"
    out.mkdir(parents=True)
    (out / "framework.json").write_text(
        json.dumps(_FW, ensure_ascii=False), encoding="utf-8")
    rec = CM.dispatch_rescan(str(bd), _CAMP, "ch03", planned_chars=12345)
    assert rec["tier"] == "T3" and rec["words"] == ["量子扎带"]
    assert rec["queued"] and rec["channel"] == "fake_fulltext"
    assert "量子扎带" in rec["cmd"] and "[gap]" in rec["note"]
    st = json.loads(Path(os.environ["CONDUCTOR_STATE"])
                    .read_text(encoding="utf-8"))
    job = next(j for j in st["jobs"] if j["battle"] == _CAMP)
    assert job["channel"] == "fake_fulltext" and job["state"] == "queued"
    assert job["priority"] == "P3" and job["window"] == "heavy"  # T3 档
    led = [json.loads(x) for x in
           (bd / "_pipeline" / "rescan_ledger.jsonl")
           .read_text(encoding="utf-8").splitlines() if x.strip()]
    assert len(led) == 1 and led[0]["queued"] and led[0]["chapter"] == "ch03"
    # 操作员显式指定层: ch01 (T1 量厚仍可定向补) → T1 档 P0/窗口非 heavy
    rec2 = CM.dispatch_rescan(str(bd), _CAMP, "ch01", planned_chars=999,
                              tier_override="T1")
    assert rec2["tier"] == "T1" and rec2["queued"]
    st2 = json.loads(Path(os.environ["CONDUCTOR_STATE"])
                     .read_text(encoding="utf-8"))
    j2 = next(j for j in st2["jobs"] if "甲公司" in j["cmd"])
    assert j2["priority"] == "P0" and j2["window"] != "heavy"
    # 显式层无词表 → 硬拒
    try:
        CM.dispatch_rescan(str(bd), _CAMP, "ch01", tier_override="T2")
        raise AssertionError("T2 无词表应硬拒")
    except ValueError:
        pass


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
