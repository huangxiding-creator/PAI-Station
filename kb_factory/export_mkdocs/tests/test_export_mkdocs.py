# -*- coding: utf-8 -*-
"""mkdocs 可预览导出器测试（v2.6 #5）——判据①③④＋真跑判据②。

  ① nav 层级=树结构：L1 分节 / L2 子目录（readme_slot→index.md 且置组首）/
     分拆目录再一级 / 导览层组（00-导览）置首 / 关于本库殿后
  ② 真跑验证：水利EPC域蓝图（medium 档, guided=True）导出物
     mkdocs build --strict 必零错误（缺 mkdocs 包时该用例 skip）
  ③ md 数=文件槽数（含 README 槽）＋about.md，一页不多一页不少
  ④ about.md 含报价真值＋来源徽章统计＋真实文件率（全实测）
其余门：占位页 YAML 头真值（缺真值不编造）/正文=目录行+「占位·付费解锁」；
带 content 槽按原文落盘；README 无 index_md 走占位、有则按原文；
确定性（同蓝图两导出逐字节一致）；非空 out_dir 拒收；空树拒收。
"""
import hashlib
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))  # kb_factory/ 入 sys.path

import pytest  # noqa: E402

from catalog_engine import build_blueprint  # noqa: E402
from export_mkdocs.exporter import (ABOUT_MD, ABOUT_TITLE, GUIDED_L1_NAME,  # noqa: E402
                                    PLACEHOLDER_NOTE, build_nav, export_mkdocs)

# 判据②钦定对象：水利EPC域 · medium 档 · guided=True
WATER_MEDIUM = {"domain": "水利EPC工程",
                "keywords": ["水利水电", "EPC总承包", "施工组织设计", "工程监理", "工程造价"],
                "intent": "施工与项目管理", "size_hint": "medium"}
WATER_SMALL = dict(WATER_MEDIUM, size_hint="small")  # schema=v2 变体用（省时）


# ── 合成小蓝图（快路径：readme 槽无 index_md / 真实件带 pages+url / content 槽 /
#    分拆目录 / 导览层故意排第二验证强制置首）──────────────────────────────

def _mini_bp() -> dict:
    return {
        "domain": "测试库",
        "tree": {"mode": "taxonomy", "root": "测试库", "l1": [
            {"code": "A-01", "dir": "A-01", "path": "A-01/", "name": "主题A",
             "theme": "主题A一句话", "source": "seed", "l2": [
                {"code": "A-01/01", "dir": "01", "path": "A-01/01/", "name": "堤防",
                 "theme": "堤防主题组", "file_count": 3,
                 "readme_slot": {"name": "00-README", "title": "00-README·堤防",
                                 "kind": "leaf", "fmt": "doc", "size_kb": 1,
                                 "position": 0.0, "path": "A-01/01/"},
                 "files": [
                     {"name": "堤防_core_001.pdf", "path": "A-01/01/", "tier": "core",
                      "ext": "pdf", "title": "堤防规范精选", "badge": "green_free", "perm": "green"},
                     {"name": "《水法》.pdf", "path": "A-01/01/", "fmt": "pdf",
                      "title": "《水法》", "pages": 50, "badge": "wenku_vip",
                      "url": "https://example.gov/shuifa.pdf", "perm": "yellow", "real": True},
                 ],
                 "split_dirs": [
                     {"name": "堤防-1", "path": "A-01/01/堤防-1/", "files": [
                         {"name": "案例_field_001.docx", "path": "A-01/01/堤防-1/",
                          "ext": "docx", "title": "堤防案例集", "badge": "gb_free", "perm": "green"}]}]},
            ]},
            {"code": "G-00", "dir": "00-导览", "path": "00-导览/", "name": "00-导览",
             "theme": "导览", "source": "guided_layer", "l2": [
                {"code": "G-00/00", "dir": "📥-收件箱", "path": "00-导览/📥-收件箱/",
                 "name": "📥-收件箱", "theme": "收件", "file_count": 1, "files": [
                     {"name": "📥-收件箱_INDEX.md", "path": "00-导览/📥-收件箱/",
                      "title": "收件箱页", "fmt": "md", "badge": "self_owned",
                      "perm": "green",
                      "content": "# 📥-收件箱 · 分型入口\n\n真实内容页（非占位）。\n"}]}]},
        ]},
        "ratio": {"core": 50, "field": 35, "guide": 15},
        "stats": {"files": 4, "gb": 0.01, "real_docs": 1},
        "quote": {"base": 29.0, "per_gb": 2.0, "total": 29.1, "md_factor": 1.5, "ima_add": 19.0},
        "provenance": {"engine_version": "kb-cat/1.0.0", "guided_layer": True},
    }


MINI_MD_SET = {  # 合成蓝图的期望 md 全集（4 文件槽 + 1 README 槽 + about）
    "A-01/01/index.md",
    "A-01/01/堤防_core_001.md",
    "A-01/01/《水法》.md",
    "A-01/01/堤防-1/案例_field_001.md",
    "00-导览/📥-收件箱/📥-收件箱_INDEX.md",
    ABOUT_MD,
}


def _scan_slots(bpd: dict):
    """独立清点（不抄导出器实现）：返回 (文件槽数, README 槽数)。"""
    slots = readmes = 0
    for l1 in bpd["tree"]["l1"]:
        for l2 in l1.get("l2") or []:
            readmes += 1 if l2.get("readme_slot") else 0
            slots += len(l2.get("files") or [])
            slots += sum(len(sd.get("files") or []) for sd in l2.get("split_dirs") or [])
    return slots, readmes


def _md_rels(docs_dir: Path) -> set:
    return {p.relative_to(docs_dir).as_posix() for p in docs_dir.rglob("*.md")}


def _yaml_leaf_paths(nav_item) -> list:
    """【解析后的 mkdocs.yml nav 专用】nav 项 → 叶路径列表
    （兼容 dict 形态：{"名": "路径"} 平铺 / {"名": [子]} 嵌套；str=路径，list=子项）。"""
    if isinstance(nav_item, str):
        return [nav_item]
    if isinstance(nav_item, list):
        out = []
        for x in nav_item:
            out += _yaml_leaf_paths(x)
        return out
    if isinstance(nav_item, dict):
        out = []
        for v in nav_item.values():
            out += _yaml_leaf_paths(v)
        return out
    return []


def _nav_leaves(section: dict) -> list:
    """【build_nav 结构专用】section → 叶路径列表（pages 直取，children 递归）。"""
    out = [p["path"] for p in section.get("pages") or []]
    for ch in section.get("children") or []:
        out += _nav_leaves(ch)
    return out


# ── 一、nav 层级=树结构（判据①）───────────────────────────────────────────

def test_nav_hierarchy_on_synthetic_tree():
    nav = build_nav(_mini_bp())
    assert [s["name"] for s in nav] == ["00-导览", "主题A", ABOUT_TITLE]  # 导览强制置首+关于殿后
    guided, topic = nav[0], nav[1]
    assert [p["path"] for p in guided["children"][0]["pages"]] == \
        ["00-导览/📥-收件箱/📥-收件箱_INDEX.md"]
    grp = topic["children"][0]
    assert grp["name"] == "堤防"
    assert [p["path"] for p in grp["pages"]] == ["A-01/01/index.md",     # README 槽置组首
                                                 "A-01/01/堤防_core_001.md",
                                                 "A-01/01/《水法》.md"]
    assert [p["title"] for p in grp["pages"]][1:] == ["堤防规范精选", "《水法》"]  # 标题=真值
    assert [c["name"] for c in grp["children"]] == ["堤防-1"]            # 分拆目录再一级
    assert [p["path"] for p in grp["children"][0]["pages"]] == ["A-01/01/堤防-1/案例_field_001.md"]


def test_nav_hierarchy_on_real_blueprint():
    bpd = build_blueprint(dict(WATER_MEDIUM), mode="taxonomy", guided=True)
    nav = build_nav(bpd)
    assert nav[0]["name"] == GUIDED_L1_NAME                    # 导览层置首
    assert [s["name"] for s in nav] == [x["name"] for x in bpd["tree"]["l1"]] + [ABOUT_TITLE]
    leaf_n = sum(len(_nav_leaves(s)) for s in nav)
    slots, readmes = _scan_slots(bpd)
    assert leaf_n == slots + readmes + 1                       # nav 叶数=槽数+README+about


def test_mkdocs_yml_nav_equals_disk(tmp_path):
    """mkdocs.yml 手写 yaml 可解析，且 nav 叶路径集=docs/ 实际 md 集（层级↔磁盘一致）。"""
    yaml = pytest.importorskip("yaml")  # mkdocs 安装时自带 PyYAML；缺则 skip
    bpd = build_blueprint(dict(WATER_MEDIUM), mode="taxonomy", guided=True)
    out = tmp_path / "water_medium"
    export_mkdocs(bpd, out)
    cfg = yaml.safe_load((out / "mkdocs.yml").read_text(encoding="utf-8"))
    assert "水利EPC工程" in cfg["site_name"]
    nav_paths = set(_yaml_leaf_paths(cfg["nav"]))
    disk_paths = _md_rels(out / "docs")
    assert nav_paths == disk_paths                              # 一页不多一页不少
    assert ABOUT_MD in nav_paths
    top_names = [next(iter(x)) for x in cfg["nav"]]
    assert top_names[0] == GUIDED_L1_NAME and top_names[-1] == ABOUT_TITLE


# ── 二、md 数=文件槽数（含 README 槽）＋about（判据③）────────────────────

def test_md_count_on_synthetic_tree(tmp_path):
    out = tmp_path / "mini"
    receipt = export_mkdocs(_mini_bp(), out)
    assert _md_rels(out / "docs") == MINI_MD_SET                # 全集逐一命中
    assert receipt["slot_pages"] == 4 and receipt["readme_pages"] == 1
    assert receipt["md_pages"] == len(MINI_MD_SET) == 6         # 4 槽+1 README+about


def test_md_count_on_real_blueprints(tmp_path):
    # medium+guided（判据②同款）：README 槽=0
    bpd = build_blueprint(dict(WATER_MEDIUM), mode="taxonomy", guided=True)
    slots, readmes = _scan_slots(bpd)
    out = tmp_path / "water_medium"
    receipt = export_mkdocs(bpd, out)
    assert receipt["md_pages"] == len(_md_rels(out / "docs")) == slots + readmes + 1
    # schema=v2 变体（small 省时）：每域内 L2 组一粒 README→index.md
    bpd2 = build_blueprint(dict(WATER_SMALL), mode="taxonomy", guided=True, schema="v2")
    slots2, readmes2 = _scan_slots(bpd2)
    assert readmes2 > 0
    out2 = tmp_path / "water_v2"
    receipt2 = export_mkdocs(bpd2, out2)
    assert receipt2["md_pages"] == len(_md_rels(out2 / "docs")) == slots2 + readmes2 + 1


# ── 三、占位页真值纪律 / content 槽原文 / README 两分支 ────────────────────

def test_placeholder_yaml_truthful(tmp_path):
    out = tmp_path / "mini"
    export_mkdocs(_mini_bp(), out)
    core = (out / "docs" / "A-01/01/堤防_core_001.md").read_text(encoding="utf-8")
    assert core.startswith("---\n")
    assert 'title: "堤防规范精选"' in core and 'fmt: "pdf"' in core
    assert "pages:" not in core and "source_url:" not in core   # 缺真值不编造
    assert "- 目录行：主题A / 堤防 / 堤防_core_001.pdf" in core
    assert PLACEHOLDER_NOTE in core                             # 占位句必现
    real = (out / "docs" / "A-01/01/《水法》.md").read_text(encoding="utf-8")
    assert "pages: 50" in real                                  # 真值如实
    assert 'source_url: "https://example.gov/shuifa.pdf"' in real
    split = (out / "docs" / "A-01/01/堤防-1/案例_field_001.md").read_text(encoding="utf-8")
    assert "- 目录行：主题A / 堤防 / 堤防-1 / 案例_field_001.docx" in split


def test_content_slot_verbatim_and_readme_branches(tmp_path):
    bp = _mini_bp()
    out = tmp_path / "mini"
    export_mkdocs(bp, out)
    inbox = (out / "docs" / "00-导览/📥-收件箱/📥-收件箱_INDEX.md").read_text(encoding="utf-8")
    assert inbox == bp["tree"]["l1"][1]["l2"][0]["files"][0]["content"]  # content 槽按原文
    index = (out / "docs" / "A-01/01/index.md").read_text(encoding="utf-8")
    assert 'title: "00-README·堤防"' in index                     # 无 index_md→占位模板
    assert PLACEHOLDER_NOTE in index


def test_v2_readme_uses_real_index_md(tmp_path):
    """schema=v2 引擎件：L2 自带 index_md（枢纽卡）→ index.md 按原文（非占位）。"""
    bpd = build_blueprint(dict(WATER_SMALL), mode="taxonomy", guided=True, schema="v2")
    out = tmp_path / "water_v2"
    export_mkdocs(bpd, out)
    sample = bpd["tree"]["l1"][1]["l2"][0]
    index = (out / "docs" / sample["path"] / "index.md").read_text(encoding="utf-8")
    assert index == sample["index_md"] and "下级条目表" in index
    assert PLACEHOLDER_NOTE not in index


# ── 四、about.md：报价真值+徽章统计+真实文件率（判据④）────────────────────

def test_about_contains_quote_and_stats(tmp_path):
    out = tmp_path / "mini"
    export_mkdocs(_mini_bp(), out)
    about = (out / "docs" / ABOUT_MD).read_text(encoding="utf-8")
    for token in ("报价（真值）", "base: 29.0", "per_gb: 2.0", "total: 29.1"):
        assert token in about, token
    for badge, n in (("green_free", 1), ("wenku_vip", 1), ("gb_free", 1), ("self_owned", 1)):
        assert f"| {badge} | {n} |" in about, badge              # 来源徽章统计（实测）
    assert "真实检索文件: 1 / 4（25.00%" in about                # 真实文件率（实测）
    assert "kb-cat/1.0.0" in about                              # 溯源摘要


def test_about_badges_match_tree_scan(tmp_path):
    bpd = build_blueprint(dict(WATER_MEDIUM), mode="taxonomy", guided=True)
    out = tmp_path / "water_medium"
    receipt = export_mkdocs(bpd, out)
    assert sum(receipt["badges"].values()) == receipt["slot_pages"]  # 徽章计数=槽总数
    about = (out / "docs" / ABOUT_MD).read_text(encoding="utf-8")
    assert f"合计 | {receipt['slot_pages']}" in about


# ── 五、纪律门：确定性 / 拒覆盖 / 拒空树 ───────────────────────────────────

def test_deterministic(tmp_path):
    bp = _mini_bp()
    a, b = tmp_path / "a", tmp_path / "b"
    export_mkdocs(bp, a)
    export_mkdocs(bp, b)

    def _sig(root: Path) -> dict:
        return {p.relative_to(root).as_posix():
                hashlib.sha256(p.read_bytes()).hexdigest()
                for p in sorted(root.rglob("*")) if p.is_file()}

    assert _sig(a) == _sig(b)                                   # 同蓝图两导出逐字节一致


def test_refuses_nonempty_out_dir(tmp_path):
    out = tmp_path / "occupied"
    out.mkdir()
    (out / "keep.txt").write_text("既有产物", encoding="utf-8")
    with pytest.raises(ValueError, match="拒绝覆盖"):
        export_mkdocs(_mini_bp(), out)
    assert (out / "keep.txt").read_text(encoding="utf-8") == "既有产物"  # 既有件分毫未动


def test_rejects_bad_blueprint(tmp_path):
    with pytest.raises(ValueError, match="tree.l1"):
        export_mkdocs({"domain": "空树", "tree": {"l1": []}}, tmp_path / "x1")
    with pytest.raises(ValueError, match="bp 必须是蓝图 dict"):
        export_mkdocs([1, 2], tmp_path / "x2")


# ── 六、真跑判据②：mkdocs build --strict 必零错误（缺包 skip）──────────────

def _strict_build(out_dir: Path, site_dir: Path):
    return subprocess.run([sys.executable, "-m", "mkdocs", "build", "--strict",
                           "--site-dir", str(site_dir)],
                          cwd=str(out_dir), capture_output=True, text=True,
                          encoding="utf-8", errors="replace")


def _assert_site_built(site_dir: Path, md_pages: int):
    """构建产物门：site 目录在位、页页有着落（use_directory_urls 下每 md → */index.html，
    库根无 index.md 故无根 index.html——属预期，不强造根着陆页破坏判据③计数）。"""
    assert site_dir.is_dir()
    htmls = [p for p in site_dir.rglob("index.html")]
    assert len(htmls) == md_pages                          # 每个 md 页都构建成页
    assert (site_dir / "about" / "index.html").is_file()   # about 真值页可直达


def test_mkdocs_strict_build_synthetic(tmp_path):
    pytest.importorskip("mkdocs")
    out = tmp_path / "mini"
    receipt = export_mkdocs(_mini_bp(), out)
    r = _strict_build(out, tmp_path / "site_mini")
    assert r.returncode == 0, r.stdout + r.stderr
    _assert_site_built(tmp_path / "site_mini", receipt["md_pages"])


def test_mkdocs_strict_build_water_epc_medium(tmp_path):
    """判据②钦定用例：水利EPC域蓝图（medium 档, guided=True）→ strict 零错误。"""
    pytest.importorskip("mkdocs")
    bpd = build_blueprint(dict(WATER_MEDIUM), mode="taxonomy", guided=True)
    out = tmp_path / "water_medium"
    receipt = export_mkdocs(bpd, out)
    r = _strict_build(out, tmp_path / "site_water")
    assert r.returncode == 0, r.stdout + r.stderr
    _assert_site_built(tmp_path / "site_water", receipt["md_pages"])


def test_mkdocs_strict_build_water_epc_v2(tmp_path):
    """判据②扩测：schema=v2（README→index.md 真实件）同样 strict 零错误。"""
    pytest.importorskip("mkdocs")
    bpd = build_blueprint(dict(WATER_SMALL), mode="taxonomy", guided=True, schema="v2")
    out = tmp_path / "water_v2"
    export_mkdocs(bpd, out)
    r = _strict_build(out, tmp_path / "site_water_v2")
    assert r.returncode == 0, r.stdout + r.stderr


if __name__ == "__main__":
    import inspect
    import tempfile

    for fn in [test_nav_hierarchy_on_synthetic_tree, test_nav_hierarchy_on_real_blueprint,
               test_mkdocs_yml_nav_equals_disk, test_md_count_on_synthetic_tree,
               test_md_count_on_real_blueprints, test_placeholder_yaml_truthful,
               test_content_slot_verbatim_and_readme_branches,
               test_v2_readme_uses_real_index_md, test_about_contains_quote_and_stats,
               test_about_badges_match_tree_scan, test_deterministic,
               test_refuses_nonempty_out_dir, test_rejects_bad_blueprint,
               test_mkdocs_strict_build_synthetic, test_mkdocs_strict_build_water_epc_medium,
               test_mkdocs_strict_build_water_epc_v2]:
        if "tmp_path" in inspect.signature(fn).parameters:
            with tempfile.TemporaryDirectory() as td:  # 直跑兜底：免 pytest 也可全绿
                fn(Path(td))
        else:
            fn()
        print(f"  PASS {fn.__name__}")
    print("ALL PASS")
