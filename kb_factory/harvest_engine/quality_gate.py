# -*- coding: utf-8 -*-
"""NFR-GATE 质检门（数值化，全站统一，REQ L69）——收割产物 PDF 四项门 + CLI 退出码两态。

四门（权威序，退出码 0=「质检门全过」的唯一定义）：
- ①页数 pages：实测页数 == 源声明页（manifest.expected_pages）或预览上限
  （manifest.preview_limit）——任一在场参照命中即过（预览上限=部分收割合法形态）。
- ②字数 chars：实测非空白字符数（全页文字层合并，pypdfium2 抽取）≥ 参照 ref_chars×90%。
  参照按型同源提取（SPEC_REVIEW 注记#5 落点）：type3=pageJson 文字层合并 / type2=OCR /
  type1=editor DOM / doc88=FFDec frame:text / book118=OCR——参照值由 planner 写入 manifest，
  本件只认五型词表（统一语言，词表外硬拒）；实测一律本件自算。
- ③水印抽帧 watermark：首/中/末 3 页渲染图非空白比例（ink 比）落在带内
  [INK_RATIO_MIN, INK_RATIO_MAX]——下界拦整页空白/糊没（内容丢失），上界拦整页水印遮盖。
- ④完整性 integrity：pypdfium2 可解析（≥1 页）且末页非空（有文字或页对象）。

manifest schema（参照值载体，实测不入 manifest）：{pdf_path, expected_pages|preview_limit,
ref_chars, ref_chars_source, pages_render_dir?}；相对路径按 manifest 所在目录解析；
pages_render_dir 可选=首/中/末抽帧 PNG 留档目录。

数字零造假（NFR2）：页数/字数/ink 比/对象数全部由 pypdfium2 从 PDF 实测。
GPL 隔离（NFR6）：零 fitz import，只用 pypdfium2。
命令行：py -3 -m kb_factory.harvest_engine.quality_gate <manifest.json>（退出码 0/1 两态）。
"""
from __future__ import annotations

import json
import re
import sys
from dataclasses import dataclass
from pathlib import Path

import pypdfium2

GATES = ("pages", "chars", "watermark", "integrity")  # 四门权威序（①②③④）

CHARS_RATIO_MIN = 0.90  # 门②：实测字数 ≥ 参照×90%

# 门②参照来源五型词表（SPEC_REVIEW 注记#5：wenku 类型2/1 参照经 manifest 字段承接）
REF_CHARS_SOURCES = frozenset({"type1", "type2", "type3", "doc88", "book118"})
REF_CHARS_SOURCE_DESC = {
    "type3": "wenku 类型3=pageJson 文字层合并字数",
    "type2": "wenku 类型2=OCR 全文",
    "type1": "wenku 类型1=editor DOM 文本",
    "doc88": "doc88=FFDec frame:text 提取",
    "book118": "book118=OCR 全文",
}

INK_RATIO_MIN = 0.001   # 门③下界：低于=整页空白（内容丢失/糊没）
INK_RATIO_MAX = 0.85    # 门③上界：高于=整页水印遮盖（近乎满版油墨）
RENDER_SCALE = 0.5      # 抽帧渲染比例（信号足、速度快）
WHITE_THRESHOLD = 245   # 灰度 <245 计为油墨像素

_WS_RE = re.compile(r"\s+")

_LABELS = {"pages": "①页数", "chars": "②字数", "watermark": "③水印抽帧", "integrity": "④完整性"}


@dataclass
class GateOutcome:
    """单门判定结果：name∈GATES + label（①-④）+ passed + detail（实测数字入账）。"""

    name: str
    label: str
    passed: bool
    detail: str


# ---------------------------------------------------------------- manifest（参照值载体）
def load_manifest(path: str | Path) -> dict:
    """读并校验 manifest（只承载参照值；实测一律由 run_gate 现场产出）。

    :raises ValueError: schema 不合格（缺必填/类型不对/ref_chars_source 词表外/页参照双缺）。
    """
    p = Path(path)
    raw = json.loads(p.read_text(encoding="utf-8"))
    if not isinstance(raw, dict):
        raise ValueError(f"manifest 须为 JSON 对象，当前={type(raw).__name__}")
    base = p.resolve().parent

    pdf_path = raw.get("pdf_path")
    if not isinstance(pdf_path, str) or not pdf_path.strip():
        raise ValueError("manifest.pdf_path 必填（非空 str，指向收割产物 PDF）")
    pp = Path(pdf_path)
    raw["pdf_path"] = str(pp if pp.is_absolute() else base / pp)

    ref_chars = raw.get("ref_chars")
    if isinstance(ref_chars, bool) or not isinstance(ref_chars, int) or ref_chars < 1:
        raise ValueError(f"manifest.ref_chars 必填（正整数参照字数，口径见 ref_chars_source），当前={ref_chars!r}")

    src = raw.get("ref_chars_source")
    if src not in REF_CHARS_SOURCES:
        raise ValueError(f"manifest.ref_chars_source 须为五型词表 {sorted(REF_CHARS_SOURCES)} 之一，当前={src!r}")

    refs = [(k, raw[k]) for k in ("expected_pages", "preview_limit") if raw.get(k) is not None]
    for k, v in refs:
        if isinstance(v, bool) or not isinstance(v, int) or v < 1:
            raise ValueError(f"manifest.{k} 须为正整数，当前={v!r}")
    if not refs:
        raise ValueError("manifest 缺页数参照：expected_pages（源声明页）/ preview_limit（预览上限）至少其一")

    render_dir = raw.get("pages_render_dir")
    if render_dir is not None:
        rd = Path(render_dir)
        raw["pages_render_dir"] = str(rd if rd.is_absolute() else base / rd)
    return raw


# ---------------------------------------------------------------- 实测（NFR2：全 pypdfium2）
def _page_text(page: "pypdfium2.PdfPage") -> str:
    tp = page.get_textpage()
    try:
        return tp.get_text_range()
    finally:
        tp.close()


def count_chars(doc: "pypdfium2.PdfDocument") -> int:
    """全页文字层合并的非空白字符数（门②实测口径；页与文字页句柄逐个关净）。"""
    total = 0
    for i in range(len(doc)):
        page = doc[i]
        try:
            total += len(_WS_RE.sub("", _page_text(page)))
        finally:
            page.close()
    return total


def _page_payload(doc: "pypdfium2.PdfDocument", idx: int) -> tuple[int, int]:
    """单页实测载荷：(非空白字符数, 页对象数)。"""
    page = doc[idx]
    try:
        chars = len(_WS_RE.sub("", _page_text(page)))
        objs = sum(1 for _ in page.get_objects())
    finally:
        page.close()
    return chars, objs


def sample_indices(n_pages: int) -> tuple[int, ...]:
    """门③抽样页号：首/中/末（去重保序；中位=(n-1)//2）。"""
    if n_pages < 1:
        return ()
    return tuple(sorted({0, n_pages - 1, (n_pages - 1) // 2}))


def image_ink_ratio(im) -> float:
    """渲染图非空白比例：灰度 <WHITE_THRESHOLD 的像素占比（0.0=全白，1.0=全油墨）。"""
    hist = im.convert("L").histogram()
    total = sum(hist)
    if total == 0:
        return 0.0
    return sum(hist[:WHITE_THRESHOLD]) / total


def _sampled_ink(doc: "pypdfium2.PdfDocument", render_dir: Path | None = None) -> dict[int, float]:
    """首/中/末抽帧实测 ink 比；render_dir 在场则同步留档 PNG（审计留痕）。"""
    out: dict[int, float] = {}
    if render_dir is not None:
        render_dir = Path(render_dir)
        render_dir.mkdir(parents=True, exist_ok=True)
    for idx in sample_indices(len(doc)):
        page = doc[idx]
        try:
            im = page.render(scale=RENDER_SCALE).to_pil()
        finally:
            page.close()
        if render_dir is not None:
            im.save(render_dir / ("page_%04d.png" % idx))
        out[idx] = image_ink_ratio(im)
    return out


# ---------------------------------------------------------------- 四门判定
def run_gate(manifest: dict, render_dir: Path | None = None) -> list[GateOutcome]:
    """按 NFR-GATE 四门判定产物 PDF，返回 GateOutcome 列表（序=GATES）。

    manifest 由 load_manifest 产出（或同构 dict：绝对 pdf_path + 已校验参照字段）。
    不可解析时四门全 FAIL（实测不可得≠过门）。
    """
    pdf_path = Path(manifest["pdf_path"])
    page_refs = tuple(sorted((k, manifest[k]) for k in ("expected_pages", "preview_limit")
                             if manifest.get(k) is not None))
    ref_chars = manifest["ref_chars"]
    ref_src = manifest["ref_chars_source"]

    doc = None
    parse_error: Exception | None = None
    try:
        doc = pypdfium2.PdfDocument(str(pdf_path))
        n_pages = len(doc)
    except Exception as exc:  # 缺文件/坏字节流/加密等一律落门④，不打断两态退出码
        parse_error = exc
    try:
        if doc is None:
            why = f"pypdfium2 不可解析（{type(parse_error).__name__}: {parse_error}）"
            return [GateOutcome(g, _LABELS[g], False, f"实测不可得——{why}") for g in GATES]

        chars_total = count_chars(doc)
        ink = _sampled_ink(doc, render_dir=Path(render_dir) if render_dir else None)
        last_chars, last_objs = _page_payload(doc, n_pages - 1)

        # ①页数：==源声明页或预览上限（任一在场参照命中即过）
        hit = [f"{k}={v}" for k, v in page_refs if v == n_pages]
        gate_pages = GateOutcome(
            "pages", _LABELS["pages"], bool(hit),
            f"实测 {n_pages} 页；参照 {' / '.join(f'{k}={v}' for k, v in page_refs)}"
            + (f" → 命中 {','.join(hit)}" if hit else " → 未命中"))

        # ②字数：实测 ≥ 参照×90%
        need = ref_chars * CHARS_RATIO_MIN
        gate_chars = GateOutcome(
            "chars", _LABELS["chars"], chars_total >= need,
            f"实测 {chars_total} 字（非空白字符·全页合并）≥ 90%×参照 {ref_chars}"
            f"（ref_chars_source={ref_src}：{REF_CHARS_SOURCE_DESC[ref_src]}）= {need:.1f}"
            f" → {'过' if chars_total >= need else '不过'}")

        # ③水印抽帧：首/中/末 ink 比全落带内
        ink_str = "/".join(f"{ink[i]:.4f}" for i in sorted(ink))
        idx_str = ",".join(str(i) for i in sorted(ink))
        in_band = all(INK_RATIO_MIN <= v <= INK_RATIO_MAX for v in ink.values()) and bool(ink)
        gate_wm = GateOutcome(
            "watermark", _LABELS["watermark"], in_band,
            f"首/中/末（页 {idx_str}）ink={ink_str}，带=[{INK_RATIO_MIN}, {INK_RATIO_MAX}]"
            + ("" if in_band else " → 整页空白或水印遮盖（越带）"))

        # ④完整性：可解析（走到此即已过）+ 末页非空
        last_ok = last_chars > 0 or last_objs > 0
        gate_int = GateOutcome(
            "integrity", _LABELS["integrity"], last_ok,
            f"pypdfium2 可解析 {n_pages} 页；末页实测 文字 {last_chars} 字/对象 {last_objs} 个"
            + ("→ 非空" if last_ok else "→ 空"))

        return [gate_pages, gate_chars, gate_wm, gate_int]
    finally:
        if doc is not None:
            doc.close()


def main(argv: list[str] | None = None) -> int:
    """CLI 入口：py -3 -m kb_factory.harvest_engine.quality_gate <manifest.json>。"""
    args = list(sys.argv[1:] if argv is None else argv)
    if len(args) != 1:
        print("用法: py -3 -m kb_factory.harvest_engine.quality_gate <manifest.json>"
              "（退出码 0=质检门全过 / 1=不过）")
        return 1
    try:
        manifest = load_manifest(args[0])
    except (ValueError, OSError) as exc:
        print(f"manifest 不合格：{exc}")
        return 1
    render_dir = manifest.get("pages_render_dir")
    outcomes = run_gate(manifest, render_dir=Path(render_dir) if render_dir else None)
    print(f"NFR-GATE 质检门：{args[0]}")
    for o in outcomes:
        print(f"[{'PASS' if o.passed else 'FAIL'}] {o.label} {o.detail}")
    failed = [o for o in outcomes if not o.passed]
    if failed:
        print(f"质检门未过（{len(outcomes) - len(failed)}/{len(outcomes)}）："
              + "、".join(o.label for o in failed))
        return 1
    print(f"质检门全过（{len(outcomes)}/{len(outcomes)}）")
    return 0


if __name__ == "__main__":
    sys.exit(main())
