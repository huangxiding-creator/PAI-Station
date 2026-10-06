# -*- coding: utf-8 -*-
"""manus_outline_adapter 单测 (框架驱动调研摄取件).

覆盖: ①JSON 块抽取 (合法/缺失硬拒) ②转换映射与 framework_gen 同构
(分档/渠道/T1 轮转∪实体槽/T3 行为词兜底) + validate 零错 ③密度纪律
(high 无侦察 URL 强制降 low + 绝不静默入账; 带 URL 保持 high 带
scout_hits) ④坏件拒收不落盘 ⑤ast 零网络根模块机检。

跑法: python -X utf8 tests/test_manus_outline_adapter.py   (pytest 兼容)
"""
import ast
import json
import sys
import tempfile
from pathlib import Path

_TMP = Path(tempfile.mkdtemp(prefix="moa_test_"))
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from superline import contracts as C                      # noqa: E402
from superline import manus_outline_adapter as MOA        # noqa: E402


def _outline_md(chapters: list[dict]) -> str:
    body = {"schema": "manus_outline_v1",
            "report_title": "《测试公司怎么干EPC总承包？》",
            "enterprise": {"full": "测试工程技术有限公司", "short": "测试工程",
                           "industry": "测试行业", "group": ""},
            "scqa": "s", "recon_summary": {"sources_n": 1,
                                           "key_findings": []},
            "chapters": chapters}
    return "# 目录框架\n\n```json\n" + json.dumps(
        body, ensure_ascii=False, indent=1) + "\n```\n"


def _ch(no: int, title: str, *, density: str = "high", sources: int = 2,
        terms: list[str] | None = None, role: str = "") -> dict:
    d = {"no": no, "title": title, "question": f"Q{no}",
         "sub_questions": [f"q{no}a"], "sections": [
             {"title": f"{no}.1 a", "chars": 5000},
             {"title": f"{no}.2 b", "chars": 5000}],
         "target_chars": 10000,
         "search_terms": {"zh": terms or ["测试工程 中标"], "en": []},
         "source_types": ["年报"],
         "recon_sources": [f"https://ex.com/{no}-{i}"
                           for i in range(sources)],
         "evidence_density": density, "differentiation": "d"}
    if role:
        d["role"] = role
    return d


_TIERS = {"T1": ["测试工程技术有限公司", "测试工程", "甲变体", "乙变体",
                 "丙变体", "丁变体", "戊变体"],
          "T2": ["竞对一", "竞对二"], "T3": ["EPC总承包", "工程总承包"]}


# ------------------------------------------------ ① 抽取
def test_01_extract():
    md = _outline_md([_ch(1, "引言章")])
    obj = MOA.extract_outline(md)
    assert obj["schema"] == "manus_outline_v1"
    try:
        MOA.extract_outline("# 无 JSON 块的输出\n正文")
        raise AssertionError("缺块应硬拒")
    except ValueError as e:
        assert "回炉" in str(e)


# ------------------------------------------------ ② 转换同构
_MD2 = _outline_md([
    _ch(1, "引言与研究框架", role="intro"),
    _ch(2, "企业基本面", terms=["测试工程 年报", "测试工程 EPC 中标"]),
    _ch(3, "生态位之问章", role="benchmark", terms=["测试工程 竞争"]),
    _ch(4, "市场与对标格局", terms=["测试工程 竞争"]),
    _ch(5, "结论与行动清单", role="outro"),
])
_OBJ2 = MOA.extract_outline(_MD2)


def test_02_convert_mapping():
    fw, warns = MOA.convert(_OBJ2, "TEST-MOA", "《测试公司怎么干EPC总承包？》",
                            _TIERS)
    assert not warns
    assert [c["budget_band"] for c in fw["chapters"]] == \
        ["outline_wide", "section_narrow", "gap", "gap", "outline_wide"]
    assert fw["chapters"][0]["channels"] == MOA.CHANNELS_BY_BAND["outline_wide"]
    assert fw["chapters"][2]["channels"] == MOA.CHANNELS_BY_BAND["gap"]
    # T1 = 轮转切片 ∪ 实体槽; 首章拿头部词
    assert fw["chapters"][0]["tier_map"]["T1"][:2] == \
        ["测试工程技术有限公司", "测试工程"]
    assert "测试工程技术有限公司" in fw["chapters"][1]["tier_map"]["T1"]
    # 对标章带 T2 (role 显式声明与标题关键词双路生效); 行为词入 T3;
    # 无行为词兜底
    assert fw["chapters"][2]["tier_map"]["T2"] == ["竞对一", "竞对二"]
    assert fw["chapters"][3]["tier_map"]["T2"] == ["竞对一", "竞对二"]
    assert fw["chapters"][1]["tier_map"]["T3"] == ["测试工程 EPC 中标"]
    assert fw["chapters"][0]["tier_map"]["T3"] == MOA.T3_FALLBACK
    assert fw["volume_ref"] == {"chapters": 5, "sections": 10,
                                "total_chars": 50000}
    errs = C.validate_framework(fw)
    assert not errs, errs
    assert C.route_completeness(fw) == (5, 5)


# ------------------------------------------------ ③ 密度纪律
def test_03_density_discipline():
    md = _outline_md([
        _ch(1, "引言章"),
        _ch(2, "无侦察却标high章", density="high", sources=0),   # 应降级
        _ch(3, "带侦察high章", density="high", sources=2),        # 应保持
    ])
    out = _TMP / "battle_d" / "00 研究报告需求" / "framework.json"
    r = MOA.ingest(_write(md, "in_d.md"), "TEST-MOA-D",
                   "《测试公司怎么干EPC总承包？》", None, str(out))
    assert r["ok"], r["errors"]
    ch2, ch3 = r["framework"]["chapters"][1], r["framework"]["chapters"][2]
    assert ch2["evidence_density"] == "low" and not ch2["scout_hits"]
    assert ch3["evidence_density"] == "high" and len(ch3["scout_hits"]) == 2
    assert any("强制降 low" in w for w in r["warnings"])
    led = out.parent.parent / "_pipeline" / "moa_ledger.jsonl"
    assert led.is_file() and "ingested" in led.read_text(encoding="utf-8")
    assert C.validate_framework(r["framework"]) == []


def _write(text: str, name: str) -> str:
    p = _TMP / name
    p.write_text(text, encoding="utf-8")
    return str(p)


# ------------------------------------------------ ④ 坏件拒收
def test_04_reject_bad():
    md = _outline_md([dict(_ch(1, ""))])          # 空标题 → 校验错
    out = _TMP / "battle_bad" / "00 研究报告需求" / "framework.json"
    r = MOA.ingest(_write(md, "in_bad.md"), "TEST-MOA-BAD", "《t》",
                   None, str(out))
    assert not r["ok"] and any("title" in e for e in r["errors"])
    assert not out.is_file()                       # 拒收不落盘
    led = out.parent.parent / "_pipeline" / "moa_ledger.jsonl"
    assert "rejected" in led.read_text(encoding="utf-8")


# ------------------------------------------------ ⑤ ast 零网络机检
def test_05_ast_no_network():
    tree = ast.parse(Path(MOA.__file__).read_text(encoding="utf-8"))
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
