"""L1 提取：真格式夹具（在位库就地合成）+ 毒文件不崩批。"""
import email
import email.policy

from paistation.sense.localfiles.extract import (
    ExtractionError,
    extract,
    extract_eml,
    extract_pdf,
)
from paistation.sense.localfiles.triage import Triage


def _make_pdf(path):
    import pymupdf

    with pymupdf.open() as pdf:
        page = pdf.new_page()
        page.insert_text((72, 72), "PAI-Station 本地文件宇宙测试",
                         fontname="china-s")  # 内建简体字体（helv 写不了中文）
        pdf.save(str(path))


def _make_docx(path):
    import docx

    d = docx.Document()
    d.add_paragraph("项目周报：M2.6 连接器已落地")
    table = d.add_table(rows=1, cols=2)
    table.rows[0].cells[0].text = "任务"
    table.rows[0].cells[1].text = "状态"
    d.save(str(path))


def _make_xlsx(path):
    import openpyxl

    wb = openpyxl.Workbook()
    ws = wb.active
    ws.title = "台账"
    ws.append(["项目", "进度"])
    ws.append(["LocalFiles", "P1"])
    wb.save(str(path))


def test_pdf_roundtrip(tmp_path):
    f = tmp_path / "报告.pdf"
    _make_pdf(f)
    doc = extract(str(f), "pdf", "pymupdf")
    assert "本地文件宇宙" in doc.text
    assert doc.parser_id == "pymupdf" and doc.parser_ver[0].isdigit()


def test_docx_roundtrip(tmp_path):
    f = tmp_path / "周报.docx"
    _make_docx(f)
    doc = extract(str(f), "word", "python-docx")
    assert "M2.6" in doc.text and "任务\t状态" in doc.text  # 段落+表格都进文本层


def test_xlsx_roundtrip(tmp_path):
    f = tmp_path / "台账.xlsx"
    _make_xlsx(f)
    doc = extract(str(f), "excel", "openpyxl")
    assert "## Sheet: 台账" in doc.text and "LocalFiles" in doc.text


def test_plaintext_and_eml(tmp_path):
    txt = tmp_path / "note.md"
    txt.write_text("# 标题\n内容", encoding="utf-8")
    doc = extract(str(txt), "text", "plaintext")
    assert doc.text.startswith("# 标题")

    eml = tmp_path / "mail.eml"
    msg = email.message.EmailMessage(policy=email.policy.SMTP)
    msg["Subject"] = "合同评审提醒"
    msg["From"] = "a@x.com"
    msg["To"] = "b@y.com"
    msg.set_content("请本周内回复评审意见。")
    eml.write_bytes(msg.as_bytes())
    doc = extract_eml(str(eml))
    assert doc.title == "合同评审提醒"
    assert "评审意见" in doc.text
    assert doc.meta["from"] == "a@x.com"


def test_poison_file_raises_not_crashes(tmp_path):
    fake = tmp_path / "毒.pdf"
    fake.write_bytes(b"not a real pdf but has .pdf suffix")
    try:
        extract(str(fake), "pdf", "pymupdf")
        raise AssertionError("应抛 ExtractionError")
    except ExtractionError:
        pass  # 单文件失败绝不崩批


def test_empty_pdf_detected_as_scan_candidate(tmp_path):
    import pymupdf

    f = tmp_path / "扫描件.pdf"
    with pymupdf.open() as pdf:  # 有页无文本层 → 留给 OCR 阶段
        pdf.new_page()
        pdf.save(str(f))
    try:
        extract_pdf(str(f))
        raise AssertionError("空 PDF 应抛 OCR 候选")
    except ExtractionError as exc:
        assert "OCR" in str(exc)


def test_triage_routes(tmp_path):
    t = Triage()
    assert t.classify("a/b/报告.pdf") == ("pdf", "pymupdf")
    assert t.classify("a/b/x.DOCX") == ("word", "python-docx")
    assert t.classify("a/b/邮件.msg") == ("email_msg", "extract_msg")
    assert t.classify("a/b/note.md") == ("text", "plaintext")
    assert t.classify("a/b/照片.png") == ("image", "metadata-only")
    # 后缀撒谎：无后缀但 %PDF 头 → 仍走 pdf
    f = tmp_path / "noext"
    f.write_bytes(b"%PDF-1.7 fake")
    assert t.classify(str(f)) == ("pdf", "pymupdf")


def test_metadata_only_never_reads_content(tmp_path):
    f = tmp_path / "图.png"
    f.write_bytes(b"\x89PNG garbage")
    doc = extract(str(f), "image", "metadata-only")
    assert doc.text == "" and doc.meta["size"] > 0
