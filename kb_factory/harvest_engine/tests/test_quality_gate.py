# -*- coding: utf-8 -*-
"""NFR-GATE 单测：质检门 quality_gate 四项数值化门 + CLI 退出码两态。

- 驱动体=手搓最小 PDF（纯标准库 xref 构造，零网络/零 mock 框架/零字体依赖），
  好/坏样张与产线口径同构：文字层可抽、空白页 ink=0、损坏件 pypdfium2 拒开。
- 数字零造假（NFR2）：一切 measured 由 pypdfium2 从 PDF 实测；manifest 只带参照值。
- 坏样张逐门触发失败（验收原文）；好样张四门全过 + CLI 退出码 0/1 两态实弹（子进程真跑
  `py -3 -m kb_factory.harvest_engine.quality_gate`）。
- fixtures：好/坏 manifest 为仓内静态件；配套 PDF 由本件确定性生成器按缺重建（幂等）。
"""
import json
import re
import subprocess
import sys
from pathlib import Path

import pytest

_KB_DIR = Path(__file__).resolve().parents[2]  # kb_factory/
sys.path.insert(0, str(_KB_DIR))  # worktree 阶段 kb_factory 无 __init__.py：顶层导入 harvest_engine
if not (_KB_DIR / "channel_adapters" / "base.py").exists():
    # worker worktree：kb_factory 未入 git → 只读复用主仓真身（供 kb_factory. 前缀解析）
    for _anc in _KB_DIR.parents:
        if (_anc / "kb_factory" / "channel_adapters" / "base.py").exists():
            sys.path.insert(1, str(_anc))
            break

import pypdfium2  # noqa: E402

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名
    from kb_factory.harvest_engine import quality_gate as qg  # noqa: E402
except ImportError:
    from harvest_engine import quality_gate as qg  # noqa: E402

_ROOT = _KB_DIR.parent                       # 仓根（CLI 子进程 cwd）
_FIXTURES = Path(__file__).resolve().parent / "fixtures"
_GOOD_MANIFEST = _FIXTURES / "gate_manifest_sample.json"
_BAD_MANIFEST = _FIXTURES / "gate_manifest_bad.json"
_GOOD_PDF = _FIXTURES / "gate_sample_good.pdf"
_BAD_PDF = _FIXTURES / "gate_sample_bad.pdf"

_LINE_TWO = "HARVEST ENGINE NFR GATE DETERMINISTIC FIXTURE LINE TWO"


# ---------------------------------------------------------------- 确定性 PDF 生成器
def _build_minimal_pdf(path: Path, page_lines: list) -> Path:
    """手搓最小 PDF：每页一页对象；page_lines 元素=None→空白页（无内容流），list[str]→文字层。

    Helvetica Type1 标准字体（pdfium 内建度量），ASCII 内容流；xref 偏移逐对象实算。
    """
    page_w, page_h = 595, 842
    n = len(page_lines)
    font_num = 3 + 2 * n
    objs = [(1, b"<< /Type /Catalog /Pages 2 0 R >>")]
    kids = " ".join("%d 0 R" % (3 + 2 * i) for i in range(n))
    objs.append((2, ("<< /Type /Pages /Count %d /Kids [%s] >>" % (n, kids)).encode()))
    for i, lines in enumerate(page_lines):
        num_p, num_c = 3 + 2 * i, 4 + 2 * i
        if lines is None:
            objs.append((num_p, ("<< /Type /Page /Parent 2 0 R /MediaBox [0 0 %d %d] >>"
                                 % (page_w, page_h)).encode()))
            objs.append((num_c, b""))
            continue
        ops = ["BT", "/F1 12 Tf", "72 720 Td"]
        for j, line in enumerate(lines):
            if j:
                ops.append("0 -18 Td")
            esc = line.replace("\\", "\\\\").replace("(", "\\(").replace(")", "\\)")
            ops.append("(%s) Tj" % esc)
        ops.append("ET")
        content = " ".join(ops).encode("ascii")
        objs.append((num_p, ("<< /Type /Page /Parent 2 0 R /MediaBox [0 0 %d %d] /Resources "
                             "<< /Font << /F1 %d 0 R >> >> /Contents %d 0 R >>"
                             % (page_w, page_h, font_num, num_c)).encode()))
        objs.append((num_c, b"<< /Length %d >>\nstream\n" % len(content) + content + b"\nendstream"))
    objs.append((font_num, b"<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>"))

    out = bytearray(b"%PDF-1.4\n")
    offsets = {}
    for num, body in sorted(objs):
        offsets[num] = len(out)
        out += ("%d 0 obj\n" % num).encode() + body + b"\nendobj\n"
    max_num = max(offsets)
    xref_pos = len(out)
    out += ("xref\n0 %d\n" % (max_num + 1)).encode() + b"0000000000 65535 f \n"
    for num in range(1, max_num + 1):
        out += (b"%010d 00000 n \n" % offsets[num]) if num in offsets else b"0000000000 00000 f \n"
    out += ("trailer\n<< /Size %d /Root 1 0 R >>\nstartxref\n%d\n%%%%EOF"
            % (max_num + 1, xref_pos)).encode()
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_bytes(bytes(out))
    return path


def _good_pages() -> list:
    return [["WATER EPC QUALITY GATE SAMPLE PAGE %02d LINE ONE" % i, _LINE_TWO] for i in (1, 2, 3)]


def _ensure_commit_fixtures() -> None:
    """配套 PDF 按缺重建（幂等、字节确定性）；manifest 为受测静态件，不在重建范围。"""
    if not _GOOD_PDF.exists():
        _build_minimal_pdf(_GOOD_PDF, _good_pages())
    if not _BAD_PDF.exists():
        _build_minimal_pdf(_BAD_PDF, ["WATER EPC QUALITY GATE BAD SAMPLE PAGE 01", None, None])


def _measure_chars(pdf: Path) -> int:
    doc = pypdfium2.PdfDocument(str(pdf))
    try:
        return qg.count_chars(doc)
    finally:
        doc.close()


def _manifest(pdf: Path, *, expected_pages=None, preview_limit=None, ref_chars=1000,
              ref_chars_source="type3") -> dict:
    m = {"pdf_path": str(pdf), "ref_chars": ref_chars, "ref_chars_source": ref_chars_source}
    if expected_pages is not None:
        m["expected_pages"] = expected_pages
    if preview_limit is not None:
        m["preview_limit"] = preview_limit
    return m


# ---------------------------------------------------------------- 四门语义（逐门隔离）
def test_nfr_gate_good_sample_all_four_gates_pass():
    """好样张：四门权威序全 PASS + 实测字数==manifest 参照（fixture 自洽，数字零造假）。"""
    _ensure_commit_fixtures()
    manifest = qg.load_manifest(_GOOD_MANIFEST)
    outcomes = qg.run_gate(manifest)
    assert [o.name for o in outcomes] == ["pages", "chars", "watermark", "integrity"]
    assert all(o.passed for o in outcomes), [o.detail for o in outcomes]
    assert _measure_chars(_GOOD_PDF) == manifest["ref_chars"]  # 参照=同源全量 ⇒ 覆盖率 100%
    assert qg.main([str(_GOOD_MANIFEST)]) == 0


def test_nfr_gate_bad_sample_fails_gate_by_gate():
    """坏样张逐门触发失败：①实测 3≠参照 5 ②实测字数<90%×5000 ③中/末空白页 ink=0 ④末页空。"""
    _ensure_commit_fixtures()
    manifest = qg.load_manifest(_BAD_MANIFEST)
    outcomes = qg.run_gate(manifest)
    assert len(outcomes) == 4 and not any(o.passed for o in outcomes)
    by_name = {o.name: o for o in outcomes}
    assert "3" in by_name["pages"].detail and "5" in by_name["pages"].detail
    assert "5000" in by_name["chars"].detail and "90%" in by_name["chars"].detail
    assert "0.0000" in by_name["watermark"].detail          # 中/末页 ink=0.0000 实测入账
    assert "末页" in by_name["integrity"].detail
    assert qg.main([str(_BAD_MANIFEST)]) == 1


def test_nfr_gate_pages_gate_source_declared_or_preview_cap(tmp_path):
    """门①：实测页数==源声明页或预览上限（任一在场参照命中即过）；两参照皆缺=manifest 不合格。"""
    pdf = _build_minimal_pdf(tmp_path / "p.pdf", [["PAGE ONE LINE", "PAGE ONE SECOND LINE"]])
    measured = _measure_chars(pdf)
    ok_full = qg.run_gate(_manifest(pdf, expected_pages=1, ref_chars=measured))
    ok_preview = qg.run_gate(_manifest(pdf, preview_limit=1, ref_chars=measured,
                                       ref_chars_source="book118"))
    ok_both = qg.run_gate(_manifest(pdf, expected_pages=5, preview_limit=1, ref_chars=measured))
    assert all(o.passed for o in ok_full) and all(o.passed for o in ok_preview)
    assert all(o.passed for o in ok_both)                    # ==预览上限形态（部分收割 1/5）
    fail = qg.run_gate(_manifest(pdf, expected_pages=5, ref_chars=measured))
    assert not fail[0].passed and fail[0].name == "pages"    # 其余三门仍过 ⇒ 门①隔离
    assert all(o.passed for o in fail[1:])
    bad = _manifest(pdf, ref_chars=measured)  # 既无 expected_pages 也无 preview_limit
    assert "expected_pages" not in bad and "preview_limit" not in bad
    no_ref = tmp_path / "no_pages_ref.json"
    no_ref.write_text(json.dumps(bad), encoding="utf-8")
    with pytest.raises(ValueError):
        qg.load_manifest(no_ref)


def test_nfr_gate_chars_ratio_90pct_boundary(tmp_path):
    """门②：字数≥参照 90% 边界——实测 90 字：参照 100 过（90≥90.0）、参照 102 不过（90<91.8）。"""
    pdf = _build_minimal_pdf(tmp_path / "c.pdf", [["A" * 90]])
    assert _measure_chars(pdf) == 90
    just = qg.run_gate(_manifest(pdf, expected_pages=1, ref_chars=100, ref_chars_source="doc88"))
    assert just[1].passed and "90" in just[1].detail
    over = qg.run_gate(_manifest(pdf, expected_pages=1, ref_chars=102, ref_chars_source="doc88"))
    assert not over[1].passed and over[1].name == "chars"
    assert all(o.passed for o in over[:1] + over[2:])       # 其余三门不受牵连


def test_nfr_gate_watermark_band_and_blank_middle_page(tmp_path):
    """门③：ink 带两侧（全白=0.0 / 全黑=1.0 越上界）；中页整页空白→FAIL 且四门中仅此门由空白页定性。"""
    from PIL import Image
    assert qg.image_ink_ratio(Image.new("L", (100, 100), 255)) == 0.0
    assert qg.image_ink_ratio(Image.new("L", (100, 100), 0)) == 1.0
    assert 0 < qg.INK_RATIO_MIN < qg.INK_RATIO_MAX < 1
    pdf = _build_minimal_pdf(tmp_path / "w.pdf",
                             [["FIRST PAGE LINE", "FIRST PAGE SECOND"], None,
                              ["LAST PAGE LINE", "LAST PAGE SECOND"]])
    measured = _measure_chars(pdf)
    outcomes = qg.run_gate(_manifest(pdf, expected_pages=3, ref_chars=measured))
    assert not outcomes[2].passed and outcomes[2].name == "watermark"
    assert all(o.passed for o in outcomes[:2] + outcomes[3:])  # ①②④仍过 ⇒ 门③隔离


def test_nfr_gate_integrity_parse_and_last_page_non_empty(tmp_path):
    """门④：坏字节流 pypdfium2 拒开→四门全 FAIL 且④报不可解析；可解析+末页有字/对象→过。"""
    corrupt = tmp_path / "corrupt.pdf"
    corrupt.write_bytes(b"this is not a pdf at all")
    outcomes = qg.run_gate(_manifest(corrupt, expected_pages=1, ref_chars=10))
    assert not any(o.passed for o in outcomes)
    assert "不可解析" in outcomes[3].detail and outcomes[3].name == "integrity"
    pdf = _build_minimal_pdf(tmp_path / "ok.pdf", [["A", "B"], ["C"], ["D"]])
    measured = _measure_chars(pdf)
    tail_blank = _build_minimal_pdf(tmp_path / "tail.pdf", [["A"], ["B"], None])
    outcomes_tb = qg.run_gate(_manifest(tail_blank, expected_pages=3, ref_chars=_measure_chars(tail_blank)))
    assert not outcomes_tb[3].passed and "末页" in outcomes_tb[3].detail
    outcomes_ok = qg.run_gate(_manifest(pdf, expected_pages=3, ref_chars=measured))
    assert outcomes_ok[3].passed and "3" in outcomes_ok[3].detail  # 可解析 3 页 + 末页非空


def test_nfr_gate_ref_chars_source_vocab(tmp_path):
    """SPEC_REVIEW 注记#5 落点：ref_chars_source 五型词表（统一语言，禁同义词）外硬拒。"""
    assert qg.REF_CHARS_SOURCES == frozenset({"type1", "type2", "type3", "doc88", "book118"})
    assert set(qg.REF_CHARS_SOURCE_DESC) == set(qg.REF_CHARS_SOURCES)
    for token in qg.REF_CHARS_SOURCES:
        path = tmp_path / ("m_%s.json" % token)
        path.write_text(json.dumps(_manifest(_GOOD_PDF, expected_pages=3, ref_chars=10,
                                             ref_chars_source=token)), encoding="utf-8")
        assert qg.load_manifest(path)["ref_chars_source"] == token
    for alien in ("type4", "pageJson", "editor", ""):
        path = tmp_path / "alien.json"
        path.write_text(json.dumps(_manifest(_GOOD_PDF, expected_pages=3, ref_chars=10,
                                             ref_chars_source=alien)), encoding="utf-8")
        with pytest.raises(ValueError):
            qg.load_manifest(path)
    # CLI 对不合格 manifest 亦退出码 1（两态不破）
    assert qg.main([str(path)]) == 1


def test_nfr_gate_manifest_schema_hard_gates(tmp_path):
    """manifest 必填硬门：缺 pdf_path / ref_chars≤0 / 页参照非正整数 → ValueError。"""
    base = _manifest(_GOOD_PDF, expected_pages=3)
    for key in ("pdf_path", "ref_chars", "ref_chars_source"):
        broken = dict(base)
        broken.pop(key)
        p = tmp_path / "broken.json"
        p.write_text(json.dumps(broken), encoding="utf-8")
        with pytest.raises(ValueError, match=key):
            qg.load_manifest(p)
    for bad_ref in (0, -5, "300"):
        p = tmp_path / "badref.json"
        p.write_text(json.dumps(_manifest(_GOOD_PDF, expected_pages=3, ref_chars=bad_ref)),
                     encoding="utf-8")
        with pytest.raises(ValueError):
            qg.load_manifest(p)
    p = tmp_path / "badpages.json"
    p.write_text(json.dumps(_manifest(_GOOD_PDF, expected_pages=0)), encoding="utf-8")
    with pytest.raises(ValueError):
        qg.load_manifest(p)


def test_nfr_gate_pages_render_dir_writes_sample_frames(tmp_path):
    """pages_render_dir 可选承接：首/中/末抽帧 PNG 落档（审计留痕），缺省不落盘。"""
    _ensure_commit_fixtures()
    frames = tmp_path / "frames"
    manifest = qg.load_manifest(_GOOD_MANIFEST)
    outcomes = qg.run_gate(manifest, render_dir=frames)
    assert all(o.passed for o in outcomes)
    names = sorted(q.name for q in frames.iterdir())
    assert names == ["page_0000.png", "page_0001.png", "page_0002.png"]
    assert all((frames / n).stat().st_size > 0 for n in names)
    assert qg.run_gate(manifest)  # 缺省不依赖该字段


def test_nfr_gate_cli_exit_codes_subprocess():
    """验收命令实弹：py -3 -m …quality_gate 好件退出码 0 / 坏件退出码 1（真子进程）。"""
    import os
    _ensure_commit_fixtures()
    env = dict(os.environ, PYTHONIOENCODING="utf-8")  # 管道下默认 cp936，钉 utf-8 保断言确定性
    for manifest, expected_rc in ((_GOOD_MANIFEST, 0), (_BAD_MANIFEST, 1)):
        proc = subprocess.run(["py", "-3", "-m", "kb_factory.harvest_engine.quality_gate",
                               str(manifest)], cwd=str(_ROOT), capture_output=True, text=True,
                              encoding="utf-8", errors="replace", timeout=120, env=env)
        assert proc.returncode == expected_rc, (proc.returncode, proc.stdout, proc.stderr)
        assert proc.stdout.count("[PASS]") + proc.stdout.count("[FAIL]") == 4
        assert ("质检门全过" in proc.stdout) if expected_rc == 0 else ("质检门未过" in proc.stdout)
