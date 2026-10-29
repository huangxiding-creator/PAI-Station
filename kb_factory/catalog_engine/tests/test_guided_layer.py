# -*- coding: utf-8 -*-
"""导览层测试（v2.6 #7，巨人 kepano-obsidian MIT——拥有感设计）。

口径（与 blueprint.GUIDED_* 同源）：
  导览层 = 「00-导览」首 L1 组（position 最前）：📥-收件箱（kind=inbox，
           kepano Inbox 分型律首目录）+ 五类实体索引 01-行业标准索引 /
           02-案例库索引 / 03-合同范本索引 / 04-机构名录 / 05-项目台账
           （kind=container 各带一句职责；内容槽=索引页 md）
  开关   = 【默认关】→ 输出与导览层落地前逐字节一致（sha256 钉死）；
           KB_GUIDED_LAYER=1 环境变量 或 build_blueprint(..., guided=True) 开启
  挂载   = engine.build_blueprint 统一出口（lint 门之后）；depth 各档（含
           standard）照常挂载——导览是标配交付物，非深度档位特权
"""
import hashlib
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))  # kb_factory/ 入 sys.path

import pytest  # noqa: E402

from catalog_engine import build_blueprint  # noqa: E402
from catalog_engine.blueprint import (GUIDED_ENTITIES, GUIDED_ENV, GUIDED_INBOX,  # noqa: E402
                                      GUIDED_L1, attach_guided_layer, build_guided_layer,
                                      canonical_json, guided_layer_enabled)
from catalog_engine.document_engine import DocFile, build_blueprint_document_driven  # noqa: E402
from catalog_engine.metadata import PERM_BY_BADGE  # noqa: E402

NEED = {"domain": "律师事务所知识库", "keywords": ["民法典", "诉讼", "合规", "尽职调查", "劳动争议"],
        "intent": "诉讼与合规", "size_hint": "medium"}
WATER = {"domain": "水利EPC工程", "keywords": ["水利水电", "EPC总承包", "施工组织设计", "工程监理", "工程造价"],
         "intent": "施工与项目管理", "size_hint": "large"}
ALL_DUTIES = [GUIDED_INBOX[1]] + [e[2] for e in GUIDED_ENTITIES]  # 六句职责（收件箱+五实体）

# 零漂移钉子：导览层落地【前】实测的 canonical_json sha256（1025 采集）。
# 若因导览层以外的引擎变更需更新，必须在提交说明注明变更来源（防静默漂移）。
PINNED = {
    "tax-law-None": "dc2f8e5488321748db48bbabfd52776c2a641cd750a990fe91fab93467ea8fd5",
    "tax-law-standard": "ca15ef42d5dec64f778e1276a7a4dfe399109b1906f5cf39d09c807a41de8dec",
    "tax-law-pro": "5f6e278f82341a2f02c1ccc74d7269428eb5bc4e3ec6b095e55f91606cfaf9d0",
    "tax-law-flagship": "7e0ceb51632a1eb0d4033bf5d5abba391cf53775bf984ca1ddb6161141caace7",
    "tax-water-None": "c666c0253dba9ff1b4ba39c36a4b433a38e9eaee63f80b469054b8f05553fc4c",
    "tax-water-standard": "5ae1aa254139aad005ae4c35503283e4be03e5ba514dcbb211359b469fa012e0",
    "tax-water-pro": "f5bdae49a08981bde1c3190758bd8346e1f49f972b210f7938b8b8954b11cbe1",
    "tax-water-flagship": "133bca6ecb3d08985b59bd0f11d8d1a1d002e6a6b0dc995d223e3f7953688bfe",
    # 【1025 钉子更新】tax-*-pro/flagship 四枚：v2.7 #13 STORM 多视角广度腿
    # （storm_breadth，depth=pro/flagship 自动启用——L2 组名增强+provenance.storm）
    # 落地后实测刷新；None/standard 六枚原值未动（默认路径零漂移实证）。
    # document_driven 档：provenance.sources/doc_types 用了 list(set(...))，
    # 跨进程序随哈希种子抖动（既有缺陷在案）——钉子按排序归一后取值（1025 实测）
    "doc-None": "83eb0c63468bd4a2242c2d74f4feee2bb36c7b6dc7c8886cd5d5b74633d45330",
    "doc-pro": "4491e502e5cd3ff3e518e2606d75b2801beda7c53d88737a74fee092b561153e",
    "doc-flagship": "a2b4670dfefd3327d6b61d93b5d48926ae3063303984ce2b1bb94f672dc6ee66",
}


def _norm_doc_json(bpd):
    """document_driven 归一：provenance 两处 set 序列表排序后再规范化
    （既有跨进程抖动隔离在测试侧，不改引擎行为）。"""
    import json as _json
    bpd = _json.loads(canonical_json(bpd))
    prov = bpd.get("provenance", {})
    for k in ("doc_types", "sources"):
        if isinstance(prov.get(k), list):
            prov[k] = sorted(prov[k])
    return canonical_json(bpd)


def _docs():
    """4 件真实文件（与 test_depth_modes 同款样本，钉子哈希口径一致）。"""
    titles = ["《中华人民共和国水法》", "《建设工程质量管理条例》",
              "《水利工程建设项目验收管理规定》", "水利水电工程手册"]
    return [DocFile(title=t, source="wenku", fmt="pdf", pages=50,
                    badge="green_free", perm="green") for t in titles]


def _doc_need():
    return {"domain": "水利水电知识库", "keywords": ["EPC", "施工"],
            "intent": "技术管理", "size_hint": "small"}


def _sha(bpd):
    return hashlib.sha256(canonical_json(bpd).encode("utf-8")).hexdigest()


def _count_slots(tree):
    """全树文件槽总数（L2 files + 分拆组拍平；含导览页）。"""
    n = 0
    for l1 in tree["l1"]:
        for l2 in l1["l2"]:
            n += len(l2.get("files") or [])
            n += sum(len(sd.get("files") or []) for sd in l2.get("split_dirs") or [])
    return n


# ── 一、默认关：输出与现状逐字节一致（零漂移硬门）──────────────────────────

def test_default_off_byte_identical_to_pre_guided(monkeypatch):
    """默认关（环境变量清空）→ taxonomy 四档 × 双域 + document_driven 三档，
    canonical_json sha256 与落地前钉子逐一相等。"""
    monkeypatch.delenv(GUIDED_ENV, raising=False)
    for key, need in (("law", NEED), ("water", WATER)):
        for depth in (None, "standard", "pro", "flagship"):
            bpd = build_blueprint(need, mode="taxonomy", depth=depth)
            assert _sha(bpd) == PINNED[f"tax-{key}-{depth}"], f"{key}/{depth} 默认输出漂移"
    for depth in (None, "pro", "flagship"):
        bpd = build_blueprint_document_driven(_doc_need(), _docs(), depth=depth)
        got = hashlib.sha256(_norm_doc_json(bpd).encode("utf-8")).hexdigest()
        assert got == PINNED[f"doc-{depth}"], f"doc/{depth} 默认输出漂移"


def test_default_off_no_guided_keys(monkeypatch):
    """默认关：无 00-导览、无 guided_layer 溯源键；显式 guided=False 与默认逐字节一致。"""
    monkeypatch.delenv(GUIDED_ENV, raising=False)
    base = build_blueprint(NEED, mode="taxonomy")
    assert base["tree"]["l1"][0]["name"] != GUIDED_L1[0]
    assert "guided_layer" not in base["provenance"]
    off = build_blueprint(NEED, mode="taxonomy", guided=False)
    assert canonical_json(off) == canonical_json(base)


# ── 二、开关矩阵：env / 参数 / 优先级 ──────────────────────────────────────

def test_flag_truthy_and_enabled(monkeypatch):
    monkeypatch.delenv(GUIDED_ENV, raising=False)
    assert guided_layer_enabled(True) and guided_layer_enabled("1") and guided_layer_enabled("ON")
    assert not guided_layer_enabled(False) and not guided_layer_enabled("0")
    assert not guided_layer_enabled("") and not guided_layer_enabled("yes?")
    assert not guided_layer_enabled(None)  # 无参无环境变量 → 默认关


def test_switch_env_and_param(monkeypatch):
    monkeypatch.delenv(GUIDED_ENV, raising=False)
    assert "guided_layer" not in build_blueprint(NEED, mode="taxonomy")["provenance"]
    for bad in ("0", "false", "off", "", "2", "yes?"):
        monkeypatch.setenv(GUIDED_ENV, bad)
        assert "guided_layer" not in build_blueprint(NEED, mode="taxonomy")["provenance"], bad
    for good in ("1", "true", "on", "YES", "On"):
        monkeypatch.setenv(GUIDED_ENV, good)
        assert build_blueprint(NEED, mode="taxonomy")["provenance"]["guided_layer"] is True, good
    # 参数优先于环境变量：guided=False 压过 KB_GUIDED_LAYER=1
    monkeypatch.setenv(GUIDED_ENV, "1")
    assert "guided_layer" not in build_blueprint(NEED, mode="taxonomy", guided=False)["provenance"]
    # 环境变量关闭时参数可显式开启
    monkeypatch.delenv(GUIDED_ENV, raising=False)
    on = build_blueprint(NEED, mode="taxonomy", guided=True)
    assert on["provenance"]["guided_layer"] is True
    assert build_blueprint(NEED, mode="taxonomy", guided="1")["provenance"]["guided_layer"] is True


# ── 三、开启时：导览结构断言 ────────────────────────────────────────────────

def test_guided_layer_structure():
    bpd = build_blueprint(NEED, mode="taxonomy", guided=True)
    l1s = bpd["tree"]["l1"]
    g = l1s[0]
    assert g["name"] == GUIDED_L1[0] and g["path"] == "00-导览/"
    assert g["code"] == "G-00" and g["source"] == "guided_layer"
    assert [l2["name"] for l2 in g["l2"]] == [GUIDED_INBOX[0]] + [e[0] for e in GUIDED_ENTITIES]
    kinds = [l2["kind"] for l2 in g["l2"]]
    assert kinds[0] == "inbox" and set(kinds[1:]) == {"container"}
    for l2 in g["l2"]:
        assert l2["file_count"] == 1 and len(l2["files"]) == 1
        assert l2["path"] == f"00-导览/{l2['name']}/"
        slot = l2["files"][0]
        assert slot["name"] == f"{l2['name']}_INDEX.md"   # 文件名全库唯一（防重复文件反模式）
        assert (slot["ext"], slot["fmt"], slot["tier"]) == ("md", "md", "guide")
        assert slot["kind"] in ("inbox_page", "index_page")
        assert slot["badge"] == "self_owned" and slot["perm"] == PERM_BY_BADGE["self_owned"]
        assert slot["bytes"] == len(slot["content"].encode("utf-8"))  # 数字零造假
        assert slot["size_kb"] == max(1, slot["bytes"] // 1024)
    all_names = [f["name"] for l1 in l1s for l2 in l1["l2"] for f in (l2.get("files") or [])]
    assert len(all_names) == len(set(all_names)), "导览页与域内槽位撞名"


def test_guided_position_first_domain_untouched():
    """导览只前插：域内 L1 节点（含序）原样保留，首 L1 即导览。"""
    off = build_blueprint(NEED, mode="taxonomy")
    on = build_blueprint(NEED, mode="taxonomy", guided=True)
    assert on["tree"]["l1"][1:] == off["tree"]["l1"]


def test_guided_at_all_depths():
    """导览是标配非档位特权：standard（含缺参）与 pro/flagship 均挂载。"""
    for depth in (None, "standard", "pro", "flagship"):
        bpd = build_blueprint(NEED, mode="taxonomy", depth=depth, guided=True)
        assert bpd["tree"]["l1"][0]["name"] == GUIDED_L1[0], depth
        assert bpd["provenance"]["guided_layer"] is True, depth
        assert bpd["provenance"].get("depth", "standard") in ("standard", depth or "standard")


# ── 四、索引页职责句齐全 ───────────────────────────────────────────────────

def test_duty_sentences_complete():
    """六句职责：节点字段、索引页正文、L1 枢纽卡三处齐全且互不重复。"""
    bpd = build_blueprint(NEED, mode="taxonomy", guided=True)
    g = bpd["tree"]["l1"][0]
    assert len(set(ALL_DUTIES)) == 6 and all(d.strip() for d in ALL_DUTIES)
    for l2, duty in zip(g["l2"], ALL_DUTIES):
        assert l2["duty"] == duty
        assert l2["theme"] == duty
        assert duty in l2["files"][0]["content"], f"{l2['name']} 索引页缺职责句"
        assert l2["index_md"] == l2["files"][0]["content"]  # 内容槽=索引页 md（同源一致）
        assert duty in g["index_md"], f"L1 枢纽卡职责表缺 {l2['name']}"
    # 枢纽卡口径同 render_l1_index（编号/主题/条目数齐备）
    for token in ("_INDEX.md", "路径编号", "一句话主题", "下级条目表", "条目数"):
        assert token in g["index_md"]


# ── 五、溯源与统计如实 ─────────────────────────────────────────────────────

def test_guided_provenance_truthful():
    bpd = build_blueprint(NEED, mode="taxonomy", guided=True)
    p = bpd["provenance"]
    assert p["guided_layer"] is True
    assert any("S8 导览层" in line for line in p["stage_log"])
    info = p["guided_layer_info"]
    assert info["design_origin"] == "kepano-obsidian (MIT)"
    assert info["page_count"] == 6
    assert info["pages"] == [GUIDED_INBOX[0]] + [e[0] for e in GUIDED_ENTITIES]


def test_guided_stats_honest():
    off = build_blueprint(NEED, mode="taxonomy")
    on = build_blueprint(NEED, mode="taxonomy", guided=True)
    s, pages = on["stats"], on["tree"]["l1"][0]["l2"]
    guided_bytes = sum(f["bytes"] for l2 in pages for f in l2["files"])
    assert s["files"] == _count_slots(on["tree"]) == off["stats"]["files"] + 6
    assert s["l1_count"] == len(on["tree"]["l1"]) == off["stats"]["l1_count"] + 1
    assert s["l2_count"] == off["stats"]["l2_count"] + 6
    assert s["dir_count"] == off["stats"]["dir_count"] + 6
    assert s["by_ext"]["md"] == off["stats"]["by_ext"]["md"] + 6
    assert s["by_tier"]["guide"] == off["stats"]["by_tier"]["guide"] + 6
    assert s["bytes"] == off["stats"]["bytes"] + guided_bytes
    assert s["gb"] == round(s["bytes"] / 1024 ** 3, 2)
    assert on["quote"]["total"] == round(on["quote"]["base"] + s["gb"] * on["quote"]["per_gb"], 1)


def test_document_driven_shape_attach():
    """document_driven 形态挂载：gb 按 size_kb 求和重算，real_docs 不虚增。"""
    bpd = build_blueprint_document_driven(_doc_need(), _docs())
    out = attach_guided_layer(bpd, True)
    assert out is bpd  # 就地修改并返回同一 dict
    g = out["tree"]["l1"][0]
    assert g["name"] == GUIDED_L1[0] and g["l2"][0]["kind"] == "inbox"
    assert out["provenance"]["guided_layer"] is True
    assert out["stats"]["files"] == 4 + 6
    assert out["stats"]["real_docs"] == 4  # 导览页为工厂自产模板页，非渠道检索文件
    kb = sum(f.get("size_kb") or 0 for l1 in out["tree"]["l1"]
             for l2 in l1["l2"] for f in l2["files"])
    assert out["stats"]["gb"] == round(kb / 1024 / 1024, 2)
    assert out["quote"]["total"] == round(29.0 + out["stats"]["gb"] * 2.0, 1)


# ── 六、幂等 / 确定性 / 受控扇出律不破 ──────────────────────────────────────

def test_attach_idempotent():
    bpd = build_blueprint(NEED, mode="taxonomy", guided=True)
    once = canonical_json(bpd)
    assert attach_guided_layer(bpd, True) is bpd  # 二次挂载幂等，不重插
    assert canonical_json(bpd) == once


def test_attach_defensive():
    assert attach_guided_layer({"tree": {}}, True) == {"tree": {}}  # 空树不动
    assert attach_guided_layer({}, True) == {}


def test_guided_deterministic():
    a = build_blueprint(NEED, mode="taxonomy", guided=True)
    b = build_blueprint(dict(NEED), mode="taxonomy", guided=True)
    assert canonical_json(a) == canonical_json(b)


def test_fanout_law_still_holds_with_guided():
    """medium 12+1=13 个 L1 仍在 [8,22]；导览 L2=6 是导览标配结构（非主题层
    扇出口径），域内 L1 的 L2 扇出 10-20 不变。"""
    bpd = build_blueprint(NEED, mode="taxonomy", guided=True)
    l1s = bpd["tree"]["l1"]
    assert 8 <= len(l1s) <= 22
    assert len(l1s[0]["l2"]) == 6
    for l1 in l1s[1:]:
        assert 10 <= len(l1["l2"]) <= 20


def test_build_guided_layer_pure():
    """纯函数：同域两次构造逐字节一致；内容含收件箱分型五问与同层索引表。"""
    a, b = build_guided_layer("测试域"), build_guided_layer("测试域")
    assert canonical_json(a) == canonical_json(b)
    inbox_md = a["l2"][0]["files"][0]["content"]
    for name, _short, _duty in GUIDED_ENTITIES:
        assert name in inbox_md  # 分型五问表五实体齐备
    assert "测试域" in a["l2"][1]["files"][0]["content"]


if __name__ == "__main__":
    import inspect

    mp = pytest.MonkeyPatch()
    for fn in [test_default_off_byte_identical_to_pre_guided, test_default_off_no_guided_keys,
               test_flag_truthy_and_enabled, test_switch_env_and_param,
               test_guided_layer_structure, test_guided_position_first_domain_untouched,
               test_guided_at_all_depths, test_duty_sentences_complete,
               test_guided_provenance_truthful, test_guided_stats_honest,
               test_document_driven_shape_attach, test_attach_idempotent,
               test_attach_defensive, test_guided_deterministic,
               test_fanout_law_still_holds_with_guided, test_build_guided_layer_pure]:
        mp.delenv(GUIDED_ENV, raising=False)
        fn(mp) if "monkeypatch" in inspect.signature(fn).parameters else fn()
        print(f"  PASS {fn.__name__}")
    mp.undo()
    print("ALL PASS")
