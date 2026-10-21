"""W8 交付包转换层测试：md_convert（Markdown版）+ import_pack（随身导入包）。

对应 W8 验收：docx→md 成功含正文、pdf/doc/xlsx→占位、报告计数一致、
目录树镜像、文件名规范、导入包结构与说明、pandoc 缺失诚实降级。
"""
from __future__ import annotations

import re
import subprocess
import sys
import zipfile
from pathlib import Path, PurePosixPath

import pytest

from kb_factory.convert.import_pack import make_import_pack
from kb_factory.convert.md_convert import (
    CONVERTED_MARK,
    PLACEHOLDER_MARK,
    convert_package,
    dst_relpath,
)
from kb_factory.convert.tests.make_fixture import DOCX1_BODY, DOCX2_BODY, LIB_NAME, build_fixture

# 占位/导入说明文案禁词（纪律：零渠道名零技术词；守门词表只许扩不许收窄）
FORBIDDEN_WORDS = ["逆向", "渠道", "爬虫", "收割", "镜像", "逆向工程", "ima"]


@pytest.fixture()
def pkg(tmp_path: Path) -> Path:
    return build_fixture(tmp_path / "fixture_root")


def _md_root(pkg: Path) -> Path:
    return pkg.parent / f"{pkg.name}_md"


def _md_for(dst_root: Path, src_name: str) -> Path:
    """按源文件名（可在任意子目录）找 dst 中的对应产物。"""
    want = dst_relpath(src_name)
    hits = [p for p in dst_root.rglob(want) if p.is_file()]
    assert len(hits) == 1, f"对应产物应恰好 1 个 {want}，实得 {hits}"
    return hits[0]


def _map_rel(rel: str) -> str:
    """相对路径逐级映射到 dst：仅替换文件名部分。"""
    p = PurePosixPath(rel)
    return p.with_name(dst_relpath(p.name)).as_posix()


def _summary(dst_root: Path) -> tuple[int, int, int, int]:
    """解析 转换报告.md 末行机器可读汇总。"""
    line = (dst_root / "转换报告.md").read_text("utf-8").strip().splitlines()[-1]
    m = re.search(r"成功转换 (\d+)｜原样复制 (\d+)｜占位 (\d+)｜合计 (\d+)", line)
    assert m, f"报告末行缺汇总: {line!r}"
    return tuple(int(x) for x in m.groups())  # type: ignore[return-value]


# ---------- 夹具形状（W7 契约） ----------

def test_req_w8_fixture_shape(pkg: Path):
    """夹具按 W7 契约造：2 L1 x 2 L2 + manifest + 每目录 _INDEX + docx/pdf/doc/md/txt。"""
    l1 = [d for d in pkg.iterdir() if d.is_dir()]
    assert len(l1) == 2
    for d in l1:
        assert len([x for x in d.iterdir() if x.is_dir()]) == 2
    manifest = pkg / "manifest.json"
    assert manifest.is_file()
    assert (pkg / "_INDEX.md").is_file()
    for d in pkg.rglob("*"):
        if d.is_dir():
            assert (d / "_INDEX.md").is_file(), f"{d} 缺 _INDEX.md"
    assert len(list(pkg.rglob("*.docx"))) == 2
    assert len(list(pkg.rglob("*.pdf"))) == 1


# ---------- Markdown 版转换 ----------

def test_req_w8_docx_to_md_success(pkg: Path):
    """docx→md 成功：正文短语完整落入 md，标记为转换件而非占位。"""
    dst = convert_package(pkg)
    md1 = _md_for(dst, "碾压式土石坝 施工规范.docx")
    text = md1.read_text("utf-8")
    assert text.startswith(CONVERTED_MARK)
    assert DOCX1_BODY in text
    assert PLACEHOLDER_MARK not in text
    md2 = _md_for(dst, "导流洞施组 节选.docx")
    assert DOCX2_BODY in md2.read_text("utf-8")


def test_req_w8_pdf_placeholder_honest(pkg: Path):
    """pdf→占位：保真提示+建议原文阅读+页数行+v1 限制如实标注（哑 pdf 页数未识别）。"""
    dst = convert_package(pkg)
    text = _md_for(dst, "施工指南 图册.pdf").read_text("utf-8")
    assert text.startswith(PLACEHOLDER_MARK)
    assert "PDF原文保真" in text
    assert "建议原文阅读" in text
    assert "页数" in text
    assert "未识别" in text  # 哑 pdf 无页面 → 不编造页数
    assert "v1" in text  # 诚实标注版本限制


def test_req_w8_doc_old_format_placeholder(pkg: Path):
    """.doc 老格式：pandoc 直试失败 → 占位并如实标注为 doc。"""
    dst = convert_package(pkg)
    text = _md_for(dst, "扫描版 合同.doc").read_text("utf-8")
    assert text.startswith(PLACEHOLDER_MARK)
    assert "doc" in text
    assert "建议原文阅读" in text


def test_req_w8_md_txt_copied_with_normalized_names(pkg: Path):
    """.md/.txt 原样复制且文件名规范（去空格）：内容逐字不变。"""
    src_md = pkg / "01_法规标准" / "国标全文" / "标准A 说明.md"
    original = src_md.read_text("utf-8")
    dst = convert_package(pkg)
    copied = _md_for(dst, "标准A 说明.md")
    assert copied.name == "标准A_说明.md"
    assert copied.read_text("utf-8") == original  # 原样复制：内容零改动
    txt = _md_for(dst, "地方规定 摘要.txt")
    assert txt.suffix == ".txt" and txt.name == "地方规定_摘要.txt"
    for f in dst.rglob("*"):
        if f.is_file():
            assert " " not in f.name, f"文件名未规范: {f.name}"


def test_req_w8_tree_mirror_and_report_counts(pkg: Path):
    """目录树镜像：源每个文件在 dst 有对应产物、目录一一对应；报告计数与产物一致。"""
    src_files = sorted(p.relative_to(pkg).as_posix() for p in pkg.rglob("*") if p.is_file())
    src_dirs = sorted(d.relative_to(pkg).as_posix() for d in pkg.rglob("*") if d.is_dir())
    dst = convert_package(pkg)

    for d in src_dirs:
        assert (dst / d).is_dir(), f"目录未镜像: {d}"
    dst_files = sorted(p.relative_to(dst).as_posix() for p in dst.rglob("*") if p.is_file())
    expected = sorted(_map_rel(f) for f in src_files) + ["转换报告.md"]
    assert dst_files == expected

    converted, copied, placeholder, total = _summary(dst)
    assert total == len(src_files)
    n_converted = sum(1 for f in dst.rglob("*.md") if f.read_text("utf-8").startswith(CONVERTED_MARK))
    n_placeholder = sum(1 for f in dst.rglob("*.md") if f.read_text("utf-8").startswith(PLACEHOLDER_MARK))
    assert converted == n_converted == 2  # 2 个真 docx
    assert placeholder == n_placeholder == 2  # 哑 pdf + 老 doc
    assert copied == total - converted - placeholder
    # 报告逐文件明细行数 = 文件总数（绝不静默漏报）
    detail = (dst / "转换报告.md").read_text("utf-8").split("## 逐文件明细")[-1]
    rows = [
        ln for ln in detail.splitlines()
        if ln.startswith("| ") and not ln.startswith("| 文件") and "---" not in ln
    ]
    assert len(rows) == total


def test_req_w8_placeholder_copy_no_channel_no_jargon(pkg: Path):
    """占位文案纪律：全部占位 md 零渠道名零技术词。"""
    dst = convert_package(pkg)
    for f in dst.rglob("*.md"):
        text = f.read_text("utf-8")
        if text.startswith(PLACEHOLDER_MARK):
            for w in FORBIDDEN_WORDS:
                assert w not in text, f"{f.name} 含禁词 {w}"


def test_req_w8_pandoc_missing_degrades_honestly(pkg: Path, monkeypatch):
    """pandoc 缺失（KB_PANDOC 指向不存在）→ docx/doc 全占位，报告如实，其余不受影响。"""
    monkeypatch.setenv("KB_PANDOC", r"Z:\no\such\pandoc.exe")
    dst = convert_package(pkg)
    for name in ("碾压式土石坝 施工规范.docx", "导流洞施组 节选.docx", "扫描版 合同.doc"):
        text = _md_for(dst, name).read_text("utf-8")
        assert text.startswith(PLACEHOLDER_MARK), f"{name} 未降级为占位"
        assert "建议原文阅读" in text
    converted, copied, placeholder, total = _summary(dst)
    assert converted == 0  # 绝不静默假装转换成功
    assert placeholder == 4  # 2 docx + 1 doc + 1 哑 pdf（pdf 本就占位）
    report = (dst / "转换报告.md").read_text("utf-8")
    assert "转换工具不可用" in report
    _md_for(dst, "标准A 说明.md")  # md/txt 照常复制


# ---------- 随身导入包 ----------

def test_req_w8_import_pack_structure(pkg: Path):
    """导入包：zip 可开、原包文件全量在、顶层双说明 txt、命名 {库名}_import_pack.zip。"""
    zip_path = make_import_pack(pkg)
    assert zip_path.name == f"{LIB_NAME}_import_pack.zip"
    assert zip_path.is_file()
    with zipfile.ZipFile(zip_path) as zf:
        assert zf.testzip() is None  # zip 完整可开
        names = zf.namelist()
    assert "如何导入.txt" in names
    assert "目录速览.txt" in names
    for f in pkg.rglob("*"):
        if f.is_file():
            assert f.relative_to(pkg).as_posix() in names, f"导入包缺 {f}"


def test_req_w8_import_guide_three_steps(pkg: Path):
    """如何导入.txt：知识库类App/Coze/通用三节，各含 建库→按目录上传→开问 三步，零禁词。"""
    zip_path = make_import_pack(pkg)
    with zipfile.ZipFile(zip_path) as zf:
        guide = zf.read("如何导入.txt").decode("utf-8")
    for section in ("主流AI知识库应用", "Coze", "知识库类App"):
        assert section in guide
    for step in ("建库", "按目录上传", "开问"):
        assert step in guide
    for w in FORBIDDEN_WORDS:
        assert w not in guide, f"如何导入.txt 含禁词 {w}"
    with zipfile.ZipFile(zip_path) as zf:
        overview = zf.read("目录速览.txt").decode("utf-8")
    assert "施工组织" in overview and "manifest.json" in overview


def test_req_w8_convert_and_import_coexist(pkg: Path):
    """全链共存：先出 Markdown 版再出导入包，互不污染源包。"""
    before = sorted(p.relative_to(pkg).as_posix() for p in pkg.rglob("*"))
    dst = convert_package(pkg)
    zip_path = make_import_pack(pkg)
    after = sorted(p.relative_to(pkg).as_posix() for p in pkg.rglob("*"))
    assert before == after  # 源包零改动
    assert dst.is_dir() and zip_path.is_file()


# ---------- 撞名兜底与 CLI 真入口 ----------

def test_req_w8_name_collision_dedup(tmp_path: Path):
    """规范化撞名：'A B.md' 与 'A_B.md' 同目录 → dst 产出 _2 兜底，两者俱在。"""
    pkg = tmp_path / "撞名包"
    pkg.mkdir()
    (pkg / "A B.md").write_text("# 甲\n", encoding="utf-8")
    (pkg / "A_B.md").write_text("# 乙\n", encoding="utf-8")
    (pkg / "A  C.md").write_text("# 丙\n", encoding="utf-8")
    dst = convert_package(pkg)
    names = sorted(f.name for f in dst.glob("*.md"))
    assert "A_B.md" in names and "A_B_2.md" in names and "A_C.md" in names
    assert "# 甲" in (dst / "A_B.md").read_text("utf-8")
    assert "# 乙" in (dst / "A_B_2.md").read_text("utf-8")


REPO_ROOT = Path(__file__).resolve().parents[3]


def test_req_w8_cli_subprocess_md_rc0(pkg: Path):
    """CLI 真入口（judge 堵点）：subprocess 跑 py -m kb_factory.convert --md，rc=0 且产物落地。"""
    r = subprocess.run(
        [sys.executable, "-X", "utf8", "-m", "kb_factory.convert", "--md", str(pkg)],
        cwd=REPO_ROOT, capture_output=True, text=True, timeout=300,
    )
    assert r.returncode == 0, f"rc={r.returncode}\nstdout={r.stdout}\nstderr={r.stderr}"
    dst = pkg.parent / f"{pkg.name}_md"
    assert (dst / "转换报告.md").is_file()


def test_req_w8_cli_missing_dir_friendly_exit2(tmp_path: Path):
    """CLI 对不存在目录：友好报错 + 退出码 2，不裸 traceback。"""
    r = subprocess.run(
        [sys.executable, "-X", "utf8", "-m", "kb_factory.convert",
         "--md", str(tmp_path / "不存在的包")],
        cwd=REPO_ROOT, capture_output=True, text=True, timeout=60,
    )
    assert r.returncode == 2
    combined = r.stdout + r.stderr
    assert "目录不存在" in combined
    assert "Traceback" not in combined
