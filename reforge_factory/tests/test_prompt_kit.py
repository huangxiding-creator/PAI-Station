# -*- coding: utf-8 -*-
"""S0-4 解析腿标准件三件单测 — 全夹具隔离.

验收三项逐条 grep 可验: ①Charter 草案含复述栏 ②战役 04 指令含反例
问题文件 (≥3条) ③英文战役词表带扇出 ≥3 变体. 另覆盖: SYSTEM 提示词
焊死三条落盘/剥离表/内置术语表优先/中文战役诚实空.

跑法: python -X utf8 tests/test_prompt_kit.py   (pytest 兼容)
"""
import json
import re
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from superline import prompt_kit as PK            # noqa: E402
from superline import charter_gate as CG          # noqa: E402
from superline import tier_expander as TE         # noqa: E402

_TMP = Path(tempfile.mkdtemp(prefix="s04_test_"))
# 池根隔离: 否则 _prior_t2 扫真 ammo_pool, T2 竞对词 (如 EPC50 池的 SEI)
# 渗进夹具战役 → 断言随真池内容漂移 (S0-4 实测坑)
TE.POOL_ROOT = _TMP / "ammo_pool"
TE.POOL_ROOT.mkdir(parents=True, exist_ok=True)
_T = "《中石化南京工程有限公司怎么干EPC总承包？》"


def _battle(name):
    bd = _TMP / name
    (bd / "00 研究报告需求").mkdir(parents=True, exist_ok=True)
    return bd


# ------------------------------------------------ ① SYSTEM 提示词焊死三条
def test_system_prompt_pinned_three_rules():
    p = PK.ensure_system_prompt()
    assert p.is_file()
    txt = p.read_text(encoding="utf-8")
    for rule in ("首步复述", "反例问题必产", "英文意图词剥离"):
        assert rule in txt
    assert "restatement" in txt and "STRIP_EN" in txt


# ------------------------------------------------ ③ 剥离表 + 释义扇出
def test_en_strip_and_fanout():
    assert PK.en_core_terms("How to Understand EPC Contracts in LNG") == \
        ["EPC", "Contracts", "LNG"]                # 意图词全剥
    assert PK.en_core_terms("why FIDIC matters") == ["FIDIC"]
    assert PK.is_en_battle("How Company X wins EPC contracts") is True
    assert PK.is_en_battle(_T) is False
    v = PK.en_fanout("EPC")                        # 内置术语表优先
    assert len(v) >= 3 and any("工程总承包" in x for x in v) \
        and any("engineering" in x for x in v)
    v2 = PK.en_fanout("SNEI")                      # 未知词模板兜底
    assert len(v2) >= 3 and v2[0] == "SNEI"


# ------------------------------------------------ ②③ 战役 04 指令件
def test_emit_battle_prompts_cn_and_en():
    bd = _battle("b1")
    CG.build(_T, battle_dir=str(bd))               # charter 草案 (复述栏在)
    paths = PK.emit_battle_prompts(str(bd))
    assert paths["counter"].is_file() and paths["en_fanout"].is_file()
    ctext = paths["counter"].read_text(encoding="utf-8")
    assert len(re.findall(r"^\d+\. ", ctext, flags=re.M)) >= 3
    assert "反面" in ctext and "纠纷" in ctext     # 反面检索词组
    etext = paths["en_fanout"].read_text(encoding="utf-8")
    assert "查无英文词" in etext                   # 中文战役诚实空
    # 英文战役: T1 英文词带 ≥3 扇出
    bd2 = _battle("b2")
    (bd2 / "00 研究报告需求").mkdir(parents=True, exist_ok=True)
    draft = {"schema": "charter_v1", "report_title": "How SNEI wins EPC",
             "company": "SNEI",
             "restatement": "复述: 回答SNEI如何赢EPC合同。",
             "counter_questions": ["SNEI 为什么可能是错的？",
                                   "SNEI 被谁取代？", "SNEI 失败案例？"],
             "tiers": {"T1": ["SNEI", "EPC", "中石化南京工程"], "T2": []}}
    (bd2 / "00 研究报告需求" / CG.DRAFT).write_text(
        json.dumps(draft, ensure_ascii=False), encoding="utf-8")
    paths2 = PK.emit_battle_prompts(str(bd2))
    e2 = paths2["en_fanout"].read_text(encoding="utf-8")
    rows = re.findall(r"^- \*\*(\S+)\*\*: (.+)$", e2, flags=re.M)
    assert {r[0] for r in rows} >= {"SNEI", "EPC"}  # 英文词全入表
    assert all(len(r[1].split(" | ")) >= 3 for r in rows)   # 每词 ≥3 变体


# ------------------------------------------------ 验收 grep 三项一键
def test_verify_grep_all_three():
    bd = _battle("b3")
    CG.build(_T, battle_dir=str(bd))
    PK.emit_battle_prompts(str(bd))
    v = PK.verify_grep(str(bd))
    assert v["restatement"] and v["counter_file"] and v["en_fanout"]
    assert PK.verify_grep(str(_battle("empty")))["restatement"] is False


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
