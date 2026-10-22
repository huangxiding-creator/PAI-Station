# -*- coding: utf-8 -*-
"""Schema 先行合成器测试（AutoSchemaKG 模式：概念化→三层schema→类型化抽取）。

AC 编号即测试名后缀（供追溯矩阵引用）：
  ac1 三层结构：upper 四层概念 + 领域概念(名称/父层/术语) + 应用类型五词汇 + JSON-LD raw
  ac2 30 份模拟 DocFile 合成 schema 后覆盖率 > 0.8，unclassified 可点名
  ac3 schema 是独立可评审 JSON 工件（save/load 往返一致，非内嵌蓝图）
  ac4 空语料/缺字段鲁棒（不崩、coverage=0.0）
"""
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[3]))

try:  # 兄弟件就位后自动用真 DocFile；隔离 worktree 内退回同形桩
    from kb_factory.catalog_engine.document_engine import DocFile
except Exception:  # pragma: no cover - 合并前
    from dataclasses import dataclass
    from typing import Optional

    @dataclass
    class DocFile:  # 与 document_engine.DocFile 同字段签名
        title: str
        source: str = "wenku"
        fmt: str = "pdf"
        pages: Optional[int] = None
        badge: str = "green_free"
        perm: str = "green"
        url: Optional[str] = None
        doc_type: str = "其他"
        size_kb: int = 500

from kb_factory.catalog_engine.schema_synth import (
    DomainSchema,
    synthesize_schema,
    validate_schema,
    save_schema,
    load_schema,
)

# ── 30 份模拟 DocFile（水利水电×EPC 编目域语料，末 3 件为不可分类噪音）──
_MOCKS = [
    ("《中华人民共和国水法》", "法律法规"),
    ("《中华人民共和国防洪法》", "法律法规"),
    ("《建设工程质量管理条例》", "法律法规"),
    ("《中华人民共和国安全生产法》", "法律法规"),
    ("《招标投标法实施条例》", "法律法规"),
    ("GB/T 50358 建设项目工程总承包管理规范", "国家标准"),
    ("GB 50500 建设工程工程量清单计价规范", "国家标准"),
    ("GB/T 50326 建设工程项目管理规范", "国家标准"),
    ("SL 274 碾压式土石坝设计规范", "行业标准"),
    ("SL 319 混凝土重力坝设计规范", "行业标准"),
    ("SL 253 溢洪道设计规范", "行业标准"),
    ("DL/T 5144 水工混凝土施工规范", "行业标准"),
    ("SL 398 水利水电工程施工通用安全技术规程", "行业标准"),
    ("水电站厂房设计规范", "技术规范"),
    ("水利水电工程施工组织设计规范", "技术规范"),
    ("水利水电工程地质勘察规范", "技术规范"),
    ("水利水电工程EPC总承包实战案例", "案例实务"),
    ("大坝安全监测案例分析", "案例实务"),
    ("水电站施工导流实务", "案例实务"),
    ("工程总承包合同纠纷案例精解", "案例实务"),
    ("水利水电工程施工组织设计模板", "模板范本"),
    ("EPC项目总承包合同范本", "模板范本"),
    ("水库大坝应急预案模板", "模板范本"),
    ("工程量清单计价表格模板", "模板范本"),
    ("水利水电工程师实用手册", "工具书"),
    ("水工设计手册", "工具书"),
    ("EPC工程总承包管理工具书", "工具书"),
    ("星际旅行漫谈", "其他"),
    ("都市生活随笔", "其他"),
    ("咖啡品鉴入门", "其他"),
]
DOCS = [DocFile(title=t, doc_type=dt) for t, dt in _MOCKS]
NOISE = [t for t, dt in _MOCKS if dt == "其他"]


def test_ac1_three_layer_schema_structure():
    schema = synthesize_schema(DOCS)
    assert isinstance(schema, DomainSchema)
    assert schema.upper == ["合规底线", "技术标准", "操作实务", "参考工具"]
    assert schema.application_types == ["标准项", "法规", "案例", "模板", "工具书"]
    assert schema.version == "1.0"
    # 领域概念：名称/父层/术语三件套齐备，且出现任务样例中的「水利水电」
    assert schema.domain_concepts, "领域概念不应为空"
    shuili = next(c for c in schema.domain_concepts if c["name"] == "水利水电")
    assert shuili["parent"] == "技术标准"
    assert shuili["terms"] and shuili["terms"][0] == "水利水电"
    for c in schema.domain_concepts:
        assert set(c) >= {"name", "parent", "terms"}
        assert c["parent"] in schema.upper
    # raw 为 JSON-LD 兼容结构（@context 前缀 + @type/@id），可序列化
    assert schema.raw["@context"]["kb"] and schema.raw["@type"] == "kb:DomainSchema"
    assert json.loads(json.dumps(schema.raw, ensure_ascii=False)) == schema.raw


def test_ac2_coverage_above_080_with_30_docs():
    schema = synthesize_schema(DOCS)
    report = validate_schema(schema, DOCS)
    assert report["coverage"] > 0.8, report
    assert report["coverage"] == 0.9  # 27/30，三件噪音不可分类
    assert report["unclassified"] == NOISE
    assert report["schema_nodes"] == len(schema.upper) + len(schema.domain_concepts) + len(schema.application_types)


def test_ac3_standalone_json_artifact_roundtrip(tmp_path):
    schema = synthesize_schema(DOCS)
    path = tmp_path / "schema.json"
    saved = save_schema(schema, path)
    text = path.read_text(encoding="utf-8")
    assert '"@type"' in text and json.loads(text) == schema.raw  # 独立工件可评审
    loaded = load_schema(saved)
    assert loaded == schema


def test_ac4_empty_and_partial_corpus_robust():
    empty = synthesize_schema([])
    assert empty.upper == [] and empty.domain_concepts == [] and empty.application_types == []
    assert validate_schema(empty, []) == {"coverage": 0.0, "unclassified": [], "schema_nodes": 0}
    # duck-typing：仅 title 的裸对象亦可（doc_type 缺省回退「其他」，靠概念术语覆盖）
    bare = [type("Bare", (), {"title": t})() for t in ("水库大坝应急预案模板", "水库大坝安全监测细则")]
    bare_schema = synthesize_schema(bare)
    assert bare_schema.upper == []  # 全「其他」→ 无上层概念，但仍可提炼领域概念
    assert validate_schema(bare_schema, bare)["coverage"] == 1.0  # 命中「水库/大坝」术语
