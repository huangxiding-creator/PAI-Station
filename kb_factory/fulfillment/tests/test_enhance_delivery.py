# -*- coding: utf-8 -*-
"""enhance_delivery 测试（C2 轴④）：tmp 假库→真 BagIt 包→四段增强全链。
覆盖（对齐任务四条）：
1) 四件套入位：manifest 每文本件 catalog 五键全在（类号/净题名/提要/溯源/标签）；
   提要=QA 后文本实测（digest_from=text_qa），净题名剥站点前后缀+广告词
2) 清洗件生成：<stem>.cleaned.md 并排落盘且内容=清洗函数输出（原件字节不动）
3) 预览站生成：preview_site/ 骨架（mkdocs.yml+docs+about）随库进新包；
   mkdocs 缺席→skip 如实记；mkdocs 在装→strict 静态站真建（skipif 独立用例）
4) 对账绿：新包 verify_bagit 零坏（增强件逐件登记）+独立重算件数对账
负例/降级：qa_clean 缺席→清洗腿 0 件如实计账（digest_from=text_raw）；
蓝图缺席→独立档（类号 None 禁编造）；幂等二跑→全跳过+_enh2 新包；非包目录拒收。
"""
import json
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[3]))  # 仓库根入 sys.path

from kb_factory.catalog_engine.cataloging import CATALOG_KEYS
from kb_factory.fulfillment import bagit_export as bx
from kb_factory.fulfillment import enhance_delivery as ed

KB_NAME = "水利安全知识库C2假库"
MD_NAME = "安全责任制管理办法.md"
TXT_NAME = "隐患排查清单.txt"
MD_REL = f"TV-01/01/{MD_NAME}"
TXT_REL = f"TV-01/01/{TXT_NAME}"
MD_TITLE = "百度文库 - 安全生产责任制管理办法【精品】免费下载"
TXT_TITLE = "隐患排查治理清单道客巴巴"
MD_BODY = ("# 安全生产责任制管理办法\n\n"
           "安全生产责任制是水利工程施工安全管理的核心制度，覆盖项目经理到班组全员。\n"
           "【广告】买一送一立即抢购\n")
TXT_BODY = "隐患排查治理清单：\n大坝巡查每日一次，闸门启闭机每周润滑保养。\n"
MD_DIGEST = "安全生产责任制是水利工程施工安全管理的核心制度，覆盖项目经理到班组全员。"
TXT_DIGEST = "隐患排查治理清单： 大坝巡查每日一次，闸门启闭机每周润滑保养。"
_QUOTE = {"库域名": "水利EPC", "订单号": "C2-TEST-001", "价格": "0.01", "序号": 1}


def _fake_qa(text: str) -> str:
    """测试桩清洗器：剥「【广告】」行（确定性，无随机）。"""
    return "\n".join(l for l in text.splitlines() if "【广告】" not in l) + "\n"


def _make_blueprint() -> dict:
    """最小可用蓝图：tree.l1/l2/files + need（ensure_catalog/export_mkdocs 双可跑）。"""
    return {
        "domain": "水利EPC",
        "tree": {"root": KB_NAME, "l1": [
            {"name": "政策法规", "path": "TV-01/", "code": "D",
             "l2": [{"name": "安全生产管理", "dir": "01", "path": "TV-01/01/",
                     "code": "01",
                     "files": [
                         {"name": MD_NAME, "title": MD_TITLE, "ext": "md",
                          "tier": "core", "badge": "self_owned"},
                         {"name": TXT_NAME, "title": TXT_TITLE, "ext": "txt",
                          "tier": "field", "badge": "green_free"}]}]}]},
        "need": {"domain": "水利EPC", "keywords": ["安全生产", "隐患"]},
    }


def make_bag(tmp: Path, *, blueprint_ref=None) -> Path:
    """tmp 造假库（内容件+簿记+manifest）→ 真 BagIt 包（bagit_export 出厂）。"""
    bp_path = tmp / "bp.json"
    bp_path.write_text(json.dumps(_make_blueprint(), ensure_ascii=False, indent=1),
                       encoding="utf-8")
    # 产线口径：src=含 kb 镜像树的订单目录 → 包载荷 data/<库名>/…（path 前缀对齐 manifest）
    kb = tmp / "prep" / "C2-TEST-001" / KB_NAME
    for rel, body in ((MD_REL, MD_BODY), (TXT_REL, TXT_BODY),
                      ("TV-01/01/_INDEX.md", "# _INDEX\n正文说明\n"),
                      ("获取指引清单.md", "# 获取指引清单\n槽位 2｜已交付 2\n"),
                      ("使用与来源说明.md", "# 使用与来源说明\n免责声明\n")):
        dst = kb.joinpath(*rel.split("/"))
        dst.parent.mkdir(parents=True, exist_ok=True)
        dst.write_text(body, encoding="utf-8")
    manifest = {
        "order": {"id": "C2-TEST-001"},
        "kb": {"name": KB_NAME, "domain": "水利EPC",
               "blueprint_ref": str(blueprint_ref or bp_path)},
        "stats": {"slots": 2, "delivered": 2, "guide": 0},
        "channels": [],
        "files": [
            {"slot": MD_NAME, "slot_title": MD_TITLE,
             "path": f"{KB_NAME}/{MD_REL}", "dir": "TV-01/01/",
             "status": "delivered", "badge": "self_owned", "perm": "green"},
            {"slot": TXT_NAME, "slot_title": TXT_TITLE,
             "path": f"{KB_NAME}/{TXT_REL}", "dir": "TV-01/01/",
             "status": "delivered", "badge": "green_free", "perm": "green"},
        ],
    }
    (kb / "manifest.json").write_text(
        json.dumps(manifest, ensure_ascii=False, indent=1), encoding="utf-8")
    bag = tmp / "outbox" / bx.suggest_bag_name("水利EPC", 1)
    bx.export_bagit(kb.parent, bag, _QUOTE)
    return bag


def _payload_files(bag: Path) -> int:
    return sum(1 for p in (bag / "data").rglob("*") if p.is_file())


def _manifest_rels(bag: Path) -> set:
    txt = (bag / "manifest-sha256.txt").read_text(encoding="utf-8")
    return {ln.split("  ", 1)[1].strip() for ln in txt.splitlines() if ln.strip()}


def _ledger_lines(bag: Path) -> list:
    data = bag / "data"
    hits = list(data.rglob(ed.LEDGER_NAME))
    assert hits, "ops 账未随载荷入包"
    return [json.loads(l) for l in hits[0].read_text(encoding="utf-8").splitlines() if l]


def test_enhance_full_chain(tmp_path):
    """全链主干：四件套入位/清洗件生成/预览站骨架/重打包对账绿（build_site=False 定骨架件数）。"""
    bag = make_bag(tmp_path)
    old_tag = (bag / "tagmanifest-sha256.txt").read_bytes()      # 原包 tag 快照
    md_src = bag.joinpath("data", KB_NAME, *MD_REL.split("/"))
    old_md_bytes = md_src.read_bytes()

    r = ed.enhance(bag, qa_clean=_fake_qa, build_site=False)

    # ── 回执全实测：清洗 2/四件套 2/预览站骨架/重打包自检绿 ──────────────
    assert r["qa_clean"] == "injected"
    assert r["clean"] == {"text_files": 2, "cleaned": 2, "skipped_existing": 0,
                          "failed": 0, "notes": []}
    assert r["catalog"]["filled"] == 2 and r["catalog"]["kept_existing"] == 0
    assert r["catalog"]["source"] == "blueprint"
    assert r["preview_site"]["md_pages"] == 3          # 2 槽位页 + about
    assert r["preview_site"]["build"]["skipped"]       # 显式禁建站→如实 skip
    assert r["repack"]["self_check"][1] == 0
    assert r["repack"]["old_bag_note"]

    # ── ② 清洗件：并排落盘、内容=桩输出（广告行已剥）、原件字节不动 ──────
    md_clean = md_src.with_name("安全责任制管理办法.cleaned.md")
    assert md_clean.is_file()
    assert "【广告】" not in md_clean.read_text(encoding="utf-8")
    assert md_clean.read_text(encoding="utf-8").startswith("# 安全生产责任制管理办法")
    assert (bag.joinpath("data", KB_NAME, *MD_REL.split("/"))).read_bytes() == old_md_bytes

    # ── ① 四件套（新包 manifest 实读）：五键全在+提要=QA 后文本+净题名真剥 ─
    new_bag = Path(r["repack"]["bag_dir"])
    mf = json.loads((new_bag / "data" / KB_NAME / "manifest.json")
                    .read_text(encoding="utf-8"))
    entries = {e["slot"]: e for e in mf["files"]}
    md_cat = entries[MD_NAME]["catalog"]
    assert all(k in md_cat for k in CATALOG_KEYS)
    assert md_cat["clc_no"] == "D"                       # 蓝图 L1 code 直用
    assert md_cat["clean_title"] == "安全生产责任制管理办法"   # 站点头+【精品】+尾广告全剥
    assert md_cat["digest"] == MD_DIGEST
    assert md_cat["digest_from"] == "text_qa"
    assert "安全生产管理" in md_cat["tags"] and "主干教材级" in md_cat["tags"]
    txt_cat = entries[TXT_NAME]["catalog"]
    assert txt_cat["clean_title"] == "隐患排查治理清单"    # 站点尾「道客巴巴」剥
    assert txt_cat["digest"] == TXT_DIGEST
    assert mf["enhance"]["ops_ledger"] == ed.LEDGER_NAME

    # ── ③ 预览站骨架随库：mkdocs.yml + 两槽位页 + about.md ────────────────
    site = new_bag / "data" / KB_NAME / ed.PREVIEW_DIR
    assert (site / "mkdocs.yml").is_file()
    assert (site / "docs" / "TV-01" / "01" / MD_NAME).is_file()
    assert (site / "docs" / "TV-01" / "01" / "隐患排查清单.md").is_file()
    assert (site / "docs" / "about.md").is_file()

    # ── ④ 对账绿：独立重算件数=manifest 行数；verify 零坏；增强件逐件登记 ─
    n = _payload_files(new_bag)
    assert n == len(_manifest_rels(new_bag))
    ok, bad = bx.verify_bagit(new_bag)
    assert bad == 0 and ok == n + 4                       # 4=tagmanifest 登记的 tag 件
    rels = _manifest_rels(new_bag)
    assert f"data/{KB_NAME}/安全责任制管理办法.cleaned.md".replace(
        "安全责任制管理办法.cleaned.md", "TV-01/01/安全责任制管理办法.cleaned.md") in rels
    assert f"data/{KB_NAME}/ops-enhance.jsonl" in rels
    assert f"data/{KB_NAME}/preview_site/mkdocs.yml" in rels
    # 原包保留（禁删）且 tag 四件一字节未动
    assert bag.is_dir()
    assert (bag / "tagmanifest-sha256.txt").read_bytes() == old_tag
    # ops 账：新包载 enhance 行（repack 回执在后、只进旧包尾行——分层如实）
    lines = _ledger_lines(new_bag)
    assert [l["event"] for l in lines] == ["enhance"]
    assert _ledger_lines(bag)[-1]["event"] == "repack"


def test_qa_clean_absent_degrades_honestly(tmp_path, monkeypatch):
    """qa_clean 缺席：清洗腿 0 件如实计账；提要回退原文实测（digest_from=text_raw）。"""
    monkeypatch.setattr(ed, "_resolve_qa_clean", lambda: (None, "absent"))
    bag = make_bag(tmp_path)
    r = ed.enhance(bag, build_site=False)
    assert r["qa_clean"] == "absent"
    assert r["clean"]["cleaned"] == 0 and r["clean"]["failed"] == 0
    assert r["clean"]["text_files"] == 2
    assert not list((bag / "data").rglob("*.cleaned.md"))   # 绝不伪造清洗件
    new_bag = Path(r["repack"]["bag_dir"])
    mf = json.loads((new_bag / "data" / KB_NAME / "manifest.json")
                    .read_text(encoding="utf-8"))
    cat = {e["slot"]: e["catalog"] for e in mf["files"]}[MD_NAME]
    assert cat["digest_from"] == "text_raw"                  # 原文提要如实标源
    assert cat["digest"].startswith("安全生产责任制是")
    assert bx.verify_bagit(new_bag)[1] == 0                  # 降级链对账仍绿


def test_blueprint_missing_standalone_catalog(tmp_path):
    """蓝图引用失效：四件套走独立档（类号 None 禁编造）；预览站如实 skip；重打包仍绿。"""
    bag = make_bag(tmp_path, blueprint_ref=tmp_path / "nope.json")
    r = ed.enhance(bag, qa_clean=_fake_qa, build_site=False)
    assert r["blueprint"]["loaded"] is False
    assert "蓝图" in r["preview_site"]["skipped"]
    assert r["catalog"]["source"] == "standalone"
    new_bag = Path(r["repack"]["bag_dir"])
    mf = json.loads((new_bag / "data" / KB_NAME / "manifest.json")
                    .read_text(encoding="utf-8"))
    cat = {e["slot"]: e["catalog"] for e in mf["files"]}[MD_NAME]
    assert cat["clc_no"] is None                             # 无分组上下文=如实 None
    assert cat["digest_from"] == "text_qa"
    assert cat["tags"] == ["合成导读"]                        # 独立档仅 tier 标签，禁编造
    assert bx.verify_bagit(new_bag)[1] == 0


def test_preview_site_skips_when_mkdocs_absent(tmp_path, monkeypatch):
    """mkdocs 缺席：自动档只出骨架（build skip 如实记），不建站不失败。"""
    monkeypatch.setattr(ed, "_mkdocs_available", lambda: False)
    bag = make_bag(tmp_path)
    r = ed.enhance(bag, qa_clean=_fake_qa)                   # build_site=None→自动
    assert "skipped" in r["preview_site"]["build"]
    assert not (bag / "data" / KB_NAME / ed.PREVIEW_DIR / "site").exists()
    assert (bag / "data" / KB_NAME / ed.PREVIEW_DIR / "mkdocs.yml").is_file()
    assert bx.verify_bagit(Path(r["repack"]["bag_dir"]))[1] == 0


@pytest.mark.skipif(not ed._mkdocs_available(), reason="本机未装 mkdocs（缺席=skip 腿已另有用例）")
def test_preview_site_builds_when_mkdocs_present(tmp_path):
    """mkdocs 在装：--strict 静态站真建（site/index.html）并随库进新包。"""
    bag = make_bag(tmp_path)
    r = ed.enhance(bag, qa_clean=_fake_qa)                   # build_site=None→自动建
    b = r["preview_site"]["build"]
    assert b["ok"] is True and b["returncode"] == 0 and b["html_pages"] > 0
    new_bag = Path(r["repack"]["bag_dir"])
    site = new_bag / "data" / KB_NAME / ed.PREVIEW_DIR / "site"
    # 目录式 URL：无根 index.html，about/ 落 site/about/index.html（实测产物）
    assert (site / "about" / "index.html").is_file()
    assert bx.verify_bagit(new_bag)[1] == 0


def test_enhance_idempotent_second_run(tmp_path):
    """幂等二跑：清洗跳过/四件套保留/预览站不覆盖→_enh2 新包，对账仍绿。"""
    bag = make_bag(tmp_path)
    r1 = ed.enhance(bag, qa_clean=_fake_qa, build_site=False)
    r2 = ed.enhance(bag, qa_clean=_fake_qa, build_site=False)
    assert r2["clean"] == {"text_files": 2, "cleaned": 0, "skipped_existing": 2,
                           "failed": 0, "notes": []}
    assert r2["catalog"]["filled"] == 0 and r2["catalog"]["kept_existing"] == 2
    assert "已存在不覆盖" in r2["preview_site"]["skipped"]
    assert r2["repack"]["bag_dir"].endswith("_enh2")
    n = _payload_files(Path(r2["repack"]["bag_dir"]))
    ok, bad = bx.verify_bagit(Path(r2["repack"]["bag_dir"]))
    assert bad == 0 and ok == n + 4
    # 旧包 ops 账 4 行=两轮 enhance+repack；_enh2 载前 3 行（repack 行后补）
    assert [l["event"] for l in _ledger_lines(bag)] == ["enhance", "repack"] * 2
    assert [l["event"] for l in _ledger_lines(Path(r2["repack"]["bag_dir"]))] == \
        ["enhance", "repack", "enhance"]


def test_rejects_non_bag_dir(tmp_path):
    """非 BagIt 包目录（缺 data/）拒收：ValueError 先验后写。"""
    d = tmp_path / "not_a_bag"
    d.mkdir()
    with pytest.raises(ValueError):
        ed.enhance(d)


@pytest.mark.skipif(ed._resolve_qa_clean()[0] is None,
                    reason="harvest_engine.qa_clean 缺席（缺席降级腿已另有用例）")
def test_enhance_with_real_qa_clean_module(tmp_path):
    """真件联调：harvest_engine.qa_clean 在仓→import 期自动探测接管（零注入零改动）。"""
    bag = make_bag(tmp_path)
    r = ed.enhance(bag, build_site=False)
    assert r["qa_clean"] in ("clean_text", "qa_clean")
    assert r["clean"]["cleaned"] == 2 and r["clean"]["failed"] == 0
    assert list((bag / "data").rglob("*.cleaned.md"))          # 清洗件真落盘
    assert bx.verify_bagit(Path(r["repack"]["bag_dir"]))[1] == 0
