"""W8 夹具生成器：造一个合成交付包（不依赖 W7 的真实包）。

结构（W7 交付包契约）：
  根: manifest.json / 获取指引清单.md / 使用与来源说明.md / _INDEX.md
  2 个 L1 目录 x 各 2 个 L2 目录；内含 .md/.txt 真文 + 2 个最小合法 .docx
  + 1 个哑 .pdf（转换器应判占位）+ 1 个不可读的 .doc 老格式样本。

用法：
  py -3 -m kb_factory.convert.tests.make_fixture [dest_parent]
不指定 dest_parent 时写到系统临时目录（不污染仓库）。
"""
from __future__ import annotations

import json
import sys
import tempfile
import zipfile
from pathlib import Path
from xml.sax.saxutils import escape

LIB_NAME = "水利EPC资料夹具库"

# 每个最小合法 docx 的正文锚点（测试断言转换后的 md 含这些短语）
DOCX1_BODY = "夹具正文一：坝体填筑分层厚度不大于四十厘米，逐层碾压检测。"
DOCX2_BODY = "夹具正文二：隧洞衬砌混凝土养护周期不少于二十八天。"


def _docx_parts(title: str, body: str) -> dict[str, str]:
    """手工构造最小合法 docx（[Content_Types].xml + _rels + word/document.xml）。"""
    content_types = (
        '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n'
        '<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">'
        '<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>'
        '<Default Extension="xml" ContentType="application/xml"/>'
        '<Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>'
        "</Types>"
    )
    rels = (
        '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n'
        '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">'
        '<Relationship Id="rId1" '
        'Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" '
        'Target="word/document.xml"/>'
        "</Relationships>"
    )
    document = (
        '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n'
        '<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">'
        "<w:body>"
        f"<w:p><w:r><w:t>{escape(title)}</w:t></w:r></w:p>"
        f"<w:p><w:r><w:t>{escape(body)}</w:t></w:r></w:p>"
        "</w:body></w:document>"
    )
    return {
        "[Content_Types].xml": content_types,
        "_rels/.rels": rels,
        "word/document.xml": document,
    }


def write_docx(path: Path, title: str, body: str) -> None:
    with zipfile.ZipFile(path, "w", zipfile.ZIP_DEFLATED) as zf:
        for name, xml in _docx_parts(title, body).items():
            zf.writestr(name, xml)


def write_dummy_pdf(path: Path) -> None:
    """哑 PDF：只有 %PDF 头，无页面。转换器 v1 应判占位、页数未识别。"""
    path.write_bytes(b"%PDF-1.4\n1 0 obj\n<< /Type /Catalog >>\nendobj\ntrailer\n<< >>\n%%EOF\n")


def build_fixture(dest_parent: Path) -> Path:
    """在 dest_parent 下造合成交付包，返回包根目录。"""
    pkg = dest_parent / LIB_NAME
    l1a = pkg / "01_法规标准"
    l1b = pkg / "02_案例合同"
    dirs = [
        l1a / "国标全文",
        l1a / "地方规定",
        l1b / "施工组织",
        l1b / "合同范本",
    ]
    for d in dirs:
        d.mkdir(parents=True, exist_ok=True)

    (pkg / "manifest.json").write_text(
        json.dumps({"库名": LIB_NAME, "版本": "v1", "生成时间": "2026-10-22"}, ensure_ascii=False, indent=2),
        encoding="utf-8",
    )
    (pkg / "获取指引清单.md").write_text(
        f"# 获取指引清单\n\n本包已交付到您手中，全部资料在包内，按目录阅读即可。\n\n- 共 2 个一级目录、4 个二级目录\n- 资料以原文文件为准\n",
        encoding="utf-8",
    )
    (pkg / "使用与来源说明.md").write_text(
        f"# 使用与来源说明\n\n「{LIB_NAME}」仅供自用学习。\n\n## 来源\n\n公开资料整理。\n\n## 使用建议\n\n先读各目录 _INDEX.md 再读原文。\n",
        encoding="utf-8",
    )

    index_body = "# 本目录索引\n\n- 按文件名顺序阅读\n- 原文文件保真\n"
    for d in [pkg, l1a, l1b, *dirs]:
        (d / "_INDEX.md").write_text(index_body, encoding="utf-8")

    # L1A / 国标全文：md 真文 + docx（文件名带空格，考验改名规范）+ 哑 pdf
    g = l1a / "国标全文"
    (g / "标准A 说明.md").write_text(
        "# 标准A 使用说明\n\n本标准适用于土石坝施工。\n\n要点：分层填筑、逐层检测。\n",
        encoding="utf-8",
    )
    write_docx(g / "碾压式土石坝 施工规范.docx", "碾压式土石坝施工规范", DOCX1_BODY)
    write_dummy_pdf(g / "施工指南 图册.pdf")

    # L1A / 地方规定：txt 真文
    (l1a / "地方规定" / "地方规定 摘要.txt").write_text(
        "地方规定摘要：\n1. 汛期施工需报备。\n2. 度汛标准按五十年一遇。\n",
        encoding="utf-8",
    )

    # L1B / 施工组织：第二个 docx
    write_docx(l1b / "施工组织" / "导流洞施组 节选.docx", "导流洞施工组织设计节选", DOCX2_BODY)

    # L1B / 合同范本：md 真文 + 老格式 doc（不可读，转换器应占位）
    (l1b / "合同范本" / "合同 条款.md").write_text(
        "# 合同条款摘编\n\n工期、质量、安全三大板块。\n\n- 工期：按网络计划执行\n",
        encoding="utf-8",
    )
    junk_doc = l1b / "合同范本" / "扫描版 合同.doc"
    junk_doc.write_bytes(b"\xd0\xcf\x11\xe0\xa1\xb1\x1a\xe1" + b"junk-not-a-real-doc" * 8)

    return pkg


def main(argv: list[str] | None = None) -> int:
    args = argv if argv is not None else sys.argv[1:]
    dest = Path(args[0]).resolve() if args else Path(tempfile.mkdtemp(prefix="kb_w8_fixture_"))
    pkg = build_fixture(dest)
    print(pkg)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
