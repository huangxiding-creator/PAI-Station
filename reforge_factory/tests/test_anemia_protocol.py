# -*- coding: utf-8 -*-
"""P1-2 S3 贫血章处置协议单测 (anemia_protocol).

覆盖: ①梯子纯函数三态+预算耗尽短路 ②观察轮记账 (基线/零增连击/增长
复位) + pivot 事件 ③4 轮升裁决全路径 (挂起→闸拦→continue 新窗口)
④85/15 分桶账+补扫闸 (预算耗尽拦截留痕/饱和章拒扫) ⑤裁决回执
(exempt 无 note 硬拒 / lock 终局停记轮) ⑥超期告警 (注入时钟, 至多一条)
⑦ast 零网络根模块机检.

跑法: python -X utf8 tests/test_anemia_protocol.py   (pytest 兼容)
"""
import ast
import json
import sys
import tempfile
import time
from pathlib import Path

_TMP = Path(tempfile.mkdtemp(prefix="p12_test_"))
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from superline import anemia_protocol as AN       # noqa: E402
from superline import chapter_matrix as MC        # noqa: E402

AN._push_wecom = lambda text: True                # 零真发 (注入)

_POOL = _TMP / "pool"
MC.AP.POOL_ROOT = _POOL                           # 池根隔离 (S0-4 教训)
_CAMP = "TEST-P12"


def _mk_battle(tag: str, rescan_queued: int = 0) -> Path:
    """夹具战役: ch01 饱和 (10件×3000字) / ch02 贫血 (3件×500字)."""
    bd = _TMP / f"battle_{tag}"
    out = bd / "00 研究报告需求"
    out.mkdir(parents=True)
    fw = {"schema": "framework_v1", "campaign_id": _CAMP,
          "report_title": "《甲公司怎么干EPC总承包？》", "family": "enterprise",
          "version": 1, "chapters": [
              {"id": "ch01", "title": "企业基本面", "description": "d",
               "tier_map": {"T1": ["甲公司"]}, "channels": ["stock_harvest"],
               "budget_band": "outline_wide", "evidence_density": "high"},
              {"id": "ch02", "title": "组织人才", "description": "d",
               "tier_map": {"T1": ["乙公司"], "T2": ["乙行业"]},
               "channels": ["current_increment"],
               "budget_band": "section_narrow", "evidence_density": "low"}],
          "volume_ref": {"chapters": 2, "sections": 20, "total_chars": 60000}}
    (out / "framework.json").write_text(
        json.dumps(fw, ensure_ascii=False), encoding="utf-8")
    # 池: ch01 词 10 件饱和 / ch02 词 3 件贫血
    mp = _POOL / _CAMP
    mp.mkdir(parents=True, exist_ok=True)
    rows = []
    for i in range(10):
        rows.append({"judge": "valid", "engine": f"e{i % 3}",
                     "source_path": f"D:/x/甲公司{i}.pdf",
                     "url_norm": f"http://a/{i}", "dedup_key": f"j{i}",
                     "chars": 3000, "ts": "2026-01-01T00:00:00",
                     "budget_band": "outline_wide"})
    for i in range(3):
        rows.append({"judge": "valid", "engine": "e0",
                     "source_path": f"D:/x/乙公司{i}.pdf",
                     "url_norm": f"http://b/{i}", "dedup_key": f"k{i}",
                     "chars": 500, "ts": "2026-01-01T00:00:00",
                     "budget_band": "gap"})
    (mp / "manifest.jsonl").write_text(
        "\n".join(json.dumps(r, ensure_ascii=False) for r in rows) + "\n",
        encoding="utf-8")
    if rescan_queued:
        rl = bd / "_pipeline" / "rescan_ledger.jsonl"
        rl.parent.mkdir(parents=True, exist_ok=True)
        rl.write_text(json.dumps({
            "ts": "2026-10-06T10:00:00", "battle": _CAMP, "chapter": "ch02",
            "tier": "T1", "words": ["乙公司"], "planned_chars": rescan_queued,
            "queued": True, "channel": "zh_search_pro", "cmd": "x",
            "note": "夹具补扫单"}, ensure_ascii=False) + "\n",
            encoding="utf-8")
    return bd


def _led(bd: Path) -> list[dict]:
    p = bd / "_pipeline" / AN.LEDGER
    if not p.is_file():
        return []
    return [json.loads(x) for x in
            p.read_text(encoding="utf-8").splitlines() if x.strip()]


def _grow_ch02(n: int = 2) -> None:
    mp = _POOL / _CAMP
    with (mp / "manifest.jsonl").open("a", encoding="utf-8") as f:
        for i in range(n):
            f.write(json.dumps({"judge": "valid", "engine": "e1",
                                "source_path": f"D:/x/乙公司新{i}.pdf",
                                "url_norm": f"http://c/{i}",
                                "dedup_key": f"new{i}", "chars": 800,
                                "ts": "2026-01-02T00:00:00",
                                "budget_band": "gap"},
                               ensure_ascii=False) + "\n")


# ------------------------------------------------ ① 梯子纯函数
def test_01_ladder_pure():
    assert AN.ladder(0) == "CONTINUE" and AN.ladder(1) == "CONTINUE"
    assert AN.ladder(2) == "PIVOT" and AN.ladder(3) == "PIVOT"
    assert AN.ladder(4) == "ESCALATE" and AN.ladder(9) == "ESCALATE"
    assert AN.ladder(0, budget_exhausted=True) == "PIVOT"   # 死法一短路
    assert AN.ladder(9, budget_exhausted=True) == "ESCALATE"  # 梯子仍最高


# ------------------------------------------------ ② 观察轮+pivot
_B2 = _mk_battle("rounds")


def test_02_rounds_and_pivot():
    r = AN.observe(str(_B2), _CAMP)
    assert r["anemic_now"] == ["ch02"]                    # ch01 饱和不入册
    led = _led(_B2)
    assert led[-1]["event"] == "round" and led[-1]["delta_valid"] is None \
        and led[-1]["zero_streak"] == 0                   # 基线轮
    AN.observe(str(_B2), _CAMP)
    assert _led(_B2)[-1]["zero_streak"] == 1              # 零增第 1 连击
    _grow_ch02(2)
    AN.observe(str(_B2), _CAMP)
    r3 = _led(_B2)[-1]
    assert r3["delta_valid"] > 0 and r3["zero_streak"] == 0   # 增长复位
    AN.observe(str(_B2), _CAMP)                           # streak 1
    r = AN.observe(str(_B2), _CAMP)                       # streak 2 → pivot
    pivots = [e for e in _led(_B2) if e["event"] == "pivot"]
    assert len(pivots) == 1 and pivots[0]["rounds"] == 2
    assert "换维" in pivots[0]["suggestion"]              # 扩写章 → 换维建议
    assert {"chapter": "ch02", "to": "PIVOT"} in r["transitions"]


# ------------------------------------------------ ③ 4 轮升裁决全路径
def test_03_escalate_path():
    AN.observe(str(_B2), _CAMP)                           # streak 3 (仍 PIVOT)
    assert len([e for e in _led(_B2) if e["event"] == "pivot"]) == 1  # 不重复
    r = AN.observe(str(_B2), _CAMP)                       # streak 4 → escalate
    esc = [e for e in _led(_B2) if e["event"] == "escalate"]
    assert len(esc) == 1 and esc[0]["rounds"] == 4 and esc[0]["push_ok"]
    assert {"chapter": "ch02", "to": "ESCALATE"} in r["transitions"]
    g = AN.may_rescan(str(_B2), _CAMP, "ch02")
    assert not g["ok"] and "resolve" in g["why"]          # 挂起期禁补扫
    assert _led(_B2)[-1]["event"] == "rescan_blocked"     # 拦截入账
    AN.resolve(str(_B2), _CAMP, "ch02", "continue", note="再给一轮")
    AN.observe(str(_B2), _CAMP)                           # 新窗口 streak 1
    assert _led(_B2)[-1]["zero_streak"] == 1 \
        and _led(_B2)[-1]["verdict"] == "CONTINUE"


# ------------------------------------------------ ④ 85/15 分桶账+闸
def test_04_budget_and_gate():
    cap = int(AN.C.gate_defaults()["t12_min_chars"] * AN.RESCAN_SHARE)
    bd = _mk_battle("budget", rescan_queued=cap)          # 出队恰打满帽
    b = AN.budget(str(bd), _CAMP)
    assert b["rescan_cap"] == cap and b["rescan_planned"] == cap
    assert b["budget_exhausted"] and b["rescan_execution_rate"] == 1.0
    assert b["rescan_ingested"] == 3 * 500                # gap 桶真实到账
    assert b["production_ingested"] == 10 * 3000          # 生产桶分列
    g = AN.may_rescan(str(bd), _CAMP, "ch02")
    assert not g["ok"] and g["verdict"] == "PIVOT" and "预算耗尽" in g["why"]
    g2 = AN.may_rescan(str(bd), _CAMP, "ch01")
    assert not g2["ok"] and "饱和章" in g2["why"]         # 饱和章拒扫
    try:
        AN.may_rescan(str(bd), _CAMP, "ch99")
        raise AssertionError("章不存在应抛")
    except KeyError:
        pass


# ------------------------------------------------ ⑤ 裁决回执
def test_05_resolve_receipts():
    bd = _mk_battle("resolve")
    try:
        AN.resolve(str(bd), _CAMP, "ch02", "exempt", note="")
        raise AssertionError("无 note 豁免应拒")
    except ValueError as e:
        assert "绝不静默" in str(e)
    assert _led(bd)[-1]["event"] == "resolve_blocked"
    AN.resolve(str(bd), _CAMP, "ch02", "exempt", note="用户裁决豁免演练")
    assert any(e["event"] == "resolve" and e["decision"] == "exempt"
               and e["note"] for e in _led(bd))
    bd2 = _mk_battle("lock")
    AN.observe(str(bd2), _CAMP)
    AN.resolve(str(bd2), _CAMP, "ch02", "lock", note="按现状进写作")
    n0 = len(_led(bd2))
    AN.observe(str(bd2), _CAMP)                           # 终局后停记轮
    assert len(_led(bd2)) == n0


# ------------------------------------------------ ⑥ 超期告警
def test_06_overdue_warn():
    bd = _mk_battle("overdue")
    AN.observe(str(bd), _CAMP)                            # 首见=now
    day = 86400
    t0 = time.time()
    AN.observe(str(bd), _CAMP, now=t0 + 4 * day + 60)     # 滞留 4 天 → 告警
    warns = [e for e in _led(bd) if e["event"] == "overdue_warn"]
    assert len(warns) == 1 and warns[0]["days"] > AN.OVERDUE_DAYS
    assert warns[0]["push_ok"]                            # 呈报在案
    AN.observe(str(bd), _CAMP, now=t0 + 6 * day)          # 不重复告警
    assert len([e for e in _led(bd) if e["event"] == "overdue_warn"]) == 1


# ------------------------------------------------ ⑦ ast 零付费机检
def test_07_ast_no_network():
    tree = ast.parse(Path(AN.__file__).read_text(encoding="utf-8"))
    mods = set()
    for n in ast.walk(tree):
        if isinstance(n, ast.Import):
            mods.update(a.name.split(".")[0] for a in n.names)
        elif isinstance(n, ast.ImportFrom) and n.module:
            mods.add(n.module.split(".")[0])
    assert not (mods & {"urllib", "requests", "httpx", "curl_cffi",
                        "socket"}), f"网络根模块混入: {mods}"


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
