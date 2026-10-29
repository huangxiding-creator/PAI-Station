# -*- coding: utf-8 -*-
"""SWF 工具链单测（FR4.1 FFDec 子进程提取 + 工具链自举；NFR6 GPL 隔离）。

任务卡四验收锚点（DOC88_SPEC §1.6/§1.7/§6-4/§6-7）：
① 工具链定位器/自举：FFDec+JDK 本机已落位（rea-tools）则直用，缺 presse 时才拉；
   gh 代理前缀可配（KB_HARVEST_GH_PROXY，国内加速）。
② 帧 RECT 修正 + 帧数 0 检测——§1.6 实锤：帧数 0 不修则 FFDec 静默零输出
   （实测 returncode 仍为 0，零产物）。
③ FFDec 子进程封装：engine/SPECS/_repos/doc88/_probe/page1_synthesized.swf
   真实件过链——帧数>0、导出产物在（pypdfium2 实测页数与页几何）。
④ 许可证核对表在 tools/LICENSES.md（NFR6：FFDec/presse=GPL-3.0 仅子进程调用
   不进仓；本测试以静态扫描钉「零 GPL import」）。

实弹口径：FFDec/presse 子进程=本机真实工具（非网络），未落位则 skip 并在
reason 明示补救命令；纯网络腿（ensure 幂等自举）=@pytest.mark.live，
KB_HARVEST_SKIP_LIVE=1 跳过（公约第 4 条）。
"""
from __future__ import annotations

import ast
import os
import re
import struct
import sys
from pathlib import Path

import pytest

_KB_DIR = Path(__file__).resolve().parents[2]  # kb_factory/
sys.path.insert(0, str(_KB_DIR))  # worktree 阶段 kb_factory 无 __init__.py：顶层导入回退
_REPO_ROOT = _KB_DIR.parent
for _anc in _KB_DIR.parents:  # 主树/worktree 双兼容：找到含 kb_factory 真身的根
    if (_anc / "kb_factory" / "channel_adapters" / "base.py").exists():
        _REPO_ROOT = _anc
        sys.path.insert(1, str(_anc))
        break

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名
    from kb_factory.harvest_engine.assets.magic_check import check_swf
    from kb_factory.harvest_engine.pdf.swf_toolchain import (
        PIXEL_TO_TWIP, REASON_FRAME_COUNT_ZERO, REASON_RECT_MISMATCH, FramePdfRun,
        SwfError, SwfHeader, build_ffdec_cmd, export_frame_pdf, parse_swf_header,
        presse_merge, run_ffdec_frame_pdf, swf_needs_fix, swf_resize,
        swf_resize_if_needed)
    from kb_factory.harvest_engine.tools import fetch_toolchain as ft
    from kb_factory.harvest_engine.tools.fetch_toolchain import (
        FFDEC_REPO, GH_PROXY_ENV, PRESSE_REPO, TOOLCHAIN_ROOT_ENV, ToolchainError,
        ToolchainReport, default_toolchain_root, ensure_toolchain, ffdec_banner,
        locate_ffdec, locate_java, locate_presse, parse_ffdec_banner,
        pick_ffdec_asset, pick_presse_asset, probe_toolchain, proxied_url)
except ImportError:
    from harvest_engine.assets.magic_check import check_swf
    from harvest_engine.pdf.swf_toolchain import (
        PIXEL_TO_TWIP, REASON_FRAME_COUNT_ZERO, REASON_RECT_MISMATCH, FramePdfRun,
        SwfError, SwfHeader, build_ffdec_cmd, export_frame_pdf, parse_swf_header,
        presse_merge, run_ffdec_frame_pdf, swf_needs_fix, swf_resize,
        swf_resize_if_needed)
    from harvest_engine.tools import fetch_toolchain as ft
    from harvest_engine.tools.fetch_toolchain import (
        FFDEC_REPO, GH_PROXY_ENV, PRESSE_REPO, TOOLCHAIN_ROOT_ENV, ToolchainError,
        ToolchainReport, default_toolchain_root, ensure_toolchain, ffdec_banner,
        locate_ffdec, locate_java, locate_presse, parse_ffdec_banner,
        pick_ffdec_asset, pick_presse_asset, probe_toolchain, proxied_url)

# 真实合成件（DOC88_SPEC §1.6 实测：FWS v9 / 495770B / RECT 595×841px / 帧数 0）——只读
_REAL_SWF = (_REPO_ROOT / "07 任务" / "自动建库Agent" / "engine" / "SPECS"
             / "_repos" / "doc88" / "_probe" / "page1_synthesized.swf")

_LIVE_SKIP = os.environ.get("KB_HARVEST_SKIP_LIVE") == "1"

# 本机工具链在位性（rea-tools 约定目录或 KB_HARVEST_* 环境变量）——落位才跑子进程腿
_ROOT = default_toolchain_root()
_FFDEC_READY = bool(locate_java(_ROOT) and locate_ffdec(_ROOT))
_PRESSE_READY = bool(locate_presse(_ROOT))
_SKIP_FFDEC = ("FFDec/JDK 未落位（rea-tools 或 KB_HARVEST_JAVA/KB_HARVEST_FFDEC_JAR）："
               "先 py -3 -m kb_factory.harvest_engine.tools.fetch_toolchain --ensure ffdec")
_SKIP_PRESSE = ("presse 未落位（rea-tools 或 KB_HARVEST_PRESSE）："
                "先 py -3 -m kb_factory.harvest_engine.tools.fetch_toolchain --ensure presse")


@pytest.fixture(scope="module")
def probe_swf() -> bytes:
    """真实合成件整读（module 级缓存，全程只读）。"""
    return _REAL_SWF.read_bytes()


# ---------------------------------------------------------------------------
# ② 帧 RECT 读取/修正 + 帧数 0 检测（纯字节，零子进程）
# ---------------------------------------------------------------------------

def test_fr4_1_probe_header_truth(probe_swf: bytes):
    """真实件头事实（数字零造假锚点）：FWS v9 / 495770B / 595×841px / 帧数 0。"""
    h = parse_swf_header(probe_swf)
    assert isinstance(h, SwfHeader)
    assert h.signature == "FWS" and h.version == 9
    assert h.declared_len == 495770 and len(probe_swf) == 495770
    assert h.length_ok and check_swf(probe_swf).length_ok  # 兄弟件同口径复核
    assert (h.xmin, h.xmax, h.ymin, h.ymax) == (0, 11900, 0, 16820)  # twips
    assert (h.width_px, h.height_px) == (595, 841)
    assert h.frame_count == 0          # §1.6 帧数 0：不修则 FFDec 静默零输出
    assert h.body_offset == 21         # 8 + RECT 9B + 帧率2B + 帧数2B
    assert h.frame_rate_raw == 0x0040  # 帧率原样保留位（LE u16=64，不解释不改写）


def test_fr4_1_frame_count_zero_detected(probe_swf: bytes):
    """帧数 0 检测：真实件 RECT 已与页表一致，唯一缺陷=帧数 0。"""
    assert swf_needs_fix(probe_swf) == [REASON_FRAME_COUNT_ZERO]
    assert swf_needs_fix(probe_swf, page_w=595, page_h=841) == [REASON_FRAME_COUNT_ZERO]


def test_fr4_1_rect_mismatch_detected(probe_swf: bytes):
    """RECT 与页表不符检测：改尺寸后的件对 595×841 报 rect_mismatch，自洽则无。"""
    resized = swf_resize(probe_swf, 800, 600, frame_count=1)
    assert swf_needs_fix(resized, page_w=595, page_h=841) == [REASON_RECT_MISMATCH]
    assert swf_needs_fix(resized, page_w=800, page_h=600) == []


def test_fr4_1_resize_patches_frame_count_and_keeps_geometry(probe_swf: bytes):
    """修正主路径：RECT 同值重写 + 帧数 0→1 + 长度补丁；尾部 ShowFrame/End 原样。"""
    fixed = swf_resize(probe_swf, 595, 841, frame_count=1)
    h = parse_swf_header(fixed)
    assert h.frame_count == 1                       # 帧数>0：过链硬门
    assert (h.width_px, h.height_px) == (595, 841)  # twip=px*20（§1.6）
    assert (h.xmin, h.ymin) == (0, 0) and h.xmax == 595 * PIXEL_TO_TWIP
    assert h.length_ok and len(fixed) == 495770     # RECT 位宽未变，总长不变
    assert fixed[19:21] == struct.pack("<H", 1)     # 帧数落位字节
    assert fixed[-4:] == probe_swf[-4:] == b"\x40\x00\x00\x00"  # tags 体零触碰
    assert swf_needs_fix(fixed, 595, 841) == []     # 幂等：修后不再报缺陷
    fixed2, reasons = swf_resize_if_needed(probe_swf, 595, 841)
    assert reasons == [REASON_FRAME_COUNT_ZERO] and fixed2 == fixed


def test_fr4_1_resize_if_needed_noop_when_clean(probe_swf: bytes):
    """干净件零改写：needs 为空时原字节直返（不产生无谓重写）。"""
    fixed = swf_resize(probe_swf, 595, 841, frame_count=1)
    data, reasons = swf_resize_if_needed(fixed, 595, 841)
    assert reasons == [] and data is fixed


def test_fr4_1_resize_widens_rect_bits(probe_swf: bytes):
    """RECT 位宽增长路径：4000×5000px → 80000/100000 twips 需 17bit，头整体后移。"""
    fixed = swf_resize(probe_swf, 4000, 5000, frame_count=1)
    h = parse_swf_header(fixed)
    assert (h.width_px, h.height_px) == (4000, 5000)
    assert h.body_offset == 22                       # RECT 9B→10B：帧率/帧数随之后移
    assert h.frame_count == 1 and h.frame_rate_raw == 0x0040
    assert h.length_ok and len(fixed) == 495771      # 总长 +1，长度补丁随头重算
    assert check_swf(fixed).length_ok
    assert fixed[-4:] == b"\x40\x00\x00\x00"         # tags 体依旧零触碰


def test_fr4_1_resize_keeps_max_geometry_when_only_one_axis_changes(probe_swf: bytes):
    """只改宽不改高：ymax 原样 16820，xmin/ymin 恒 0。"""
    fixed = swf_resize(probe_swf, 1000, 841, frame_count=1)
    h = parse_swf_header(fixed)
    assert h.xmax == 1000 * PIXEL_TO_TWIP and h.ymax == 841 * PIXEL_TO_TWIP
    assert (h.xmin, h.ymin) == (0, 0)


def test_fr4_1_garbage_inputs_rejected(probe_swf: bytes):
    """坏输入显式拒绝（不产半修件）：空/短/非 SWF/压缩 SWF。"""
    with pytest.raises(SwfError):
        parse_swf_header(b"")
    with pytest.raises(SwfError):
        parse_swf_header(b"FWS\x09" + b"\x00" * 8)   # 头都不完整
    with pytest.raises(SwfError):
        parse_swf_header(b"XXXX" + b"\x00" * 64)
    compressed = b"CWS" + probe_swf[3:]              # doc88 合成件恒 FWS；压缩件显式拒
    with pytest.raises(SwfError, match="FWS"):
        parse_swf_header(compressed)
    with pytest.raises(SwfError):
        swf_resize(compressed, 595, 841)
    with pytest.raises(SwfError):
        swf_resize(b"nope", 595, 841)
    with pytest.raises(ValueError):
        swf_resize(probe_swf, 0, 841)                # 非法几何


# ---------------------------------------------------------------------------
# ③ FFDec 子进程封装（真实件过链；本机工具，非网络）
# ---------------------------------------------------------------------------

def test_fr4_1_build_ffdec_cmd_argv():
    """命令行拼装纯函数：规格 §1.7 原序（-format frame:pdf/-zoom/-select/-export）。"""
    cmd = build_ffdec_cmd(java_exe="C:/j/bin/java.exe", ffdec_jar="D:/ffdec/ffdec.jar",
                          out_dir="O", swf_target="S", zoom=1.5, select="1")
    assert cmd == ["C:/j/bin/java.exe", "-jar", "D:/ffdec/ffdec.jar",
                   "-format", "frame:pdf", "-zoom", "1.5", "-select", "1",
                   "-export", "frame", "O", "S"]


def test_fr4_1_ffdec_missing_tool_fails_fast(tmp_path: Path):
    """工具缺位快速失败（带自举指引），不发 JVM。"""
    with pytest.raises(ToolchainError, match="fetch_toolchain"):
        run_ffdec_frame_pdf(tmp_path, tmp_path / "o",
                            java_exe=tmp_path / "nope.exe",
                            ffdec_jar="D:/ffdec/ffdec.jar")
    with pytest.raises(ToolchainError, match="fetch_toolchain"):
        run_ffdec_frame_pdf(tmp_path, tmp_path / "o",
                            java_exe="C:/j/bin/java.exe",
                            ffdec_jar=tmp_path / "nope.jar")


@pytest.mark.skipif(not _FFDEC_READY, reason=_SKIP_FFDEC)
def test_fr4_1_ffdec_silent_zero_without_fix(tmp_path: Path, probe_swf: bytes):
    """§1.6 反证（真实子进程）：帧数 0 → FFDec returncode 0 且零产物。"""
    staged = tmp_path / "raw.swf"
    staged.write_bytes(probe_swf)
    run = export_frame_pdf(staged, tmp_path / "out_raw")
    assert isinstance(run, FramePdfRun)
    assert run.returncode == 0      # 坑点：退出码照旧 0
    assert run.produced == {}       # 静默零输出——帧修正不可省的实锤


@pytest.mark.skipif(not _FFDEC_READY, reason=_SKIP_FFDEC)
def test_fr4_1_ffdec_real_chain(tmp_path: Path, probe_swf: bytes):
    """真实件过链：修正(595×841/帧数1) → FFDec → frames.pdf 在且 1 页 595×841pt。"""
    fixed, reasons = swf_resize_if_needed(probe_swf, page_w=595, page_h=841)
    assert REASON_FRAME_COUNT_ZERO in reasons
    assert parse_swf_header(fixed).frame_count > 0
    staged = tmp_path / "page1.swf"
    staged.write_bytes(fixed)
    run = export_frame_pdf(staged, tmp_path / "out")
    assert run.returncode == 0
    assert set(run.produced) == {"page1"}
    pdf = run.produced["page1"]
    assert pdf.is_file() and pdf.stat().st_size > 100_000  # 实测 483KB，阈值从宽
    import pypdfium2 as pdfium
    doc = pdfium.PdfDocument(str(pdf))
    assert len(doc) == 1
    w, h = doc[0].get_size()
    assert (w, h) == (595.0, 841.0)  # 页几何==页表 w-h（1px=1pt 实测）


@pytest.mark.skipif(not _FFDEC_READY, reason=_SKIP_FFDEC)
def test_fr4_1_ffdec_dir_batch_keys_by_stem(tmp_path: Path, probe_swf: bytes):
    """目录批模式：FFDec 对目录输入产出 {outdir}/{swf名}/frames.pdf，按键=stem 收敛。"""
    fixed = swf_resize(probe_swf, 595, 841, frame_count=1)
    swf_dir = tmp_path / "grp"
    swf_dir.mkdir()
    (swf_dir / "3.swf").write_bytes(fixed)
    (swf_dir / "1.swf").write_bytes(fixed)
    run = run_ffdec_frame_pdf(swf_dir, tmp_path / "out")
    assert run.returncode == 0
    assert set(run.produced) == {"1", "3"}           # 实测产物计数，非声明值
    assert all(p.is_file() for p in run.produced.values())


@pytest.mark.skipif(not _PRESSE_READY, reason=_SKIP_PRESSE)
def test_fr4_1_presse_merge_real(tmp_path: Path):
    """presse merge 实测：两单页 PDF 合并 → 2 页、页序几何逐页对得上。"""
    from PIL import Image
    try:  # 兄弟件复用（像素拼页产参照 PDF，与 presse 链解耦）
        from kb_factory.harvest_engine.pdf.image_pdf import build_image_pdf
    except ImportError:
        from harvest_engine.pdf.image_pdf import build_image_pdf
    pngs = []
    for name, wh in (("a", (10, 20)), ("b", (30, 40))):
        p = tmp_path / f"{name}.png"
        Image.new("RGB", wh, (255, 255, 255)).save(p)
        pngs.append(p)
    pdf1 = build_image_pdf([pngs[0]], tmp_path / "1.pdf")
    pdf2 = build_image_pdf([pngs[1]], tmp_path / "2.pdf")
    out = presse_merge([pdf1, pdf2], tmp_path / "merged.pdf")
    assert out.is_file() and out.stat().st_size > 0
    import pypdfium2 as pdfium
    doc = pdfium.PdfDocument(str(out))
    assert len(doc) == 2
    assert doc[0].get_size() == (10.0, 20.0) and doc[1].get_size() == (30.0, 40.0)


def test_fr4_1_presse_missing_tool_fails_fast(tmp_path: Path):
    dummy = tmp_path / "1.pdf"
    dummy.write_bytes(b"%PDF-dummy")  # 输入合法在场，独测工具缺位分支
    with pytest.raises(ToolchainError, match="fetch_toolchain"):
        presse_merge([dummy], tmp_path / "o.pdf", presse_exe=tmp_path / "nope.exe")


# ---------------------------------------------------------------------------
# ① 工具链定位器 + 自举（在位直用；gh 代理可配；缺才拉）
# ---------------------------------------------------------------------------

def test_fr4_1_locator_real_machine():
    """本机已落位直用：rea-tools 下 ffdec.jar + JDK 定位成功，版本横幅实测可析。"""
    jar = locate_ffdec(_ROOT)
    assert jar and jar.is_file() and jar.name == "ffdec.jar"
    java = locate_java(_ROOT)
    assert java and java.is_file()
    banner = ffdec_banner(java, jar)  # 真实 JVM 调用（-help 首行）
    version = parse_ffdec_banner(banner)
    assert version and re.fullmatch(r"\d+\.\d+\.\d+", version)  # 不写死，防升级漂移


def test_fr4_1_locator_tmp_tree(tmp_path: Path):
    """目录约定：root/{ffdec,jdk*,presse} 三件定位（假树验规则，不碰真机）。"""
    (tmp_path / "ffdec" / "lib").mkdir(parents=True)
    (tmp_path / "ffdec" / "ffdec.jar").write_bytes(b"")
    (tmp_path / "jdk-21.0.12.1+1" / "bin").mkdir(parents=True)
    java = tmp_path / "jdk-21.0.12.1+1" / "bin" / ("java.exe" if os.name == "nt" else "java")
    java.write_bytes(b"")
    (tmp_path / "presse").mkdir()
    presse = tmp_path / "presse" / ("presse.exe" if os.name == "nt" else "presse")
    presse.write_bytes(b"")
    assert locate_ffdec(tmp_path) == tmp_path / "ffdec" / "ffdec.jar"
    assert locate_java(tmp_path) == java
    assert locate_presse(tmp_path) == presse
    rep = probe_toolchain(root=tmp_path)
    assert isinstance(rep, ToolchainReport)
    assert rep.ffdec_jar and rep.java_exe and rep.presse_exe and rep.fetched == []


def test_fr4_1_locator_absent_returns_none(tmp_path: Path):
    assert locate_ffdec(tmp_path) is None
    assert locate_presse(tmp_path) is None
    rep = probe_toolchain(root=tmp_path)
    assert rep.ffdec_jar is None and rep.presse_exe is None


def test_fr4_1_ensure_present_never_touches_network(tmp_path: Path, monkeypatch):
    """在位直用铁律：三件全在 → ensure 零网络（注入网络故障断言器证伪任何拉取）。"""
    for rel in (("ffdec", "ffdec.jar"), ("presse", "presse.exe" if os.name == "nt" else "presse"),
                ("jdk-21", "bin", "java.exe" if os.name == "nt" else "java")):
        d = tmp_path.joinpath(*rel[:-1])
        d.mkdir(parents=True, exist_ok=True)
        (d / rel[-1]).write_bytes(b"")

    def _boom(*a, **k):  # 网络故障注入点（公约允许的确定性注入）
        raise AssertionError("网络不应被触碰：在位组件必须直用")

    monkeypatch.setattr(ft, "latest_release_assets", _boom)
    monkeypatch.setattr(ft, "download_to", _boom)
    rep = ensure_toolchain(("ffdec", "java", "presse"), root=tmp_path)
    assert rep.fetched == [] and rep.ffdec_jar and rep.presse_exe and rep.java_exe


def test_fr4_1_ensure_java_out_of_scope_reports_missing(tmp_path: Path, monkeypatch):
    """java 不在自举射程：缺位只如实报缺+notes，不拉不炸。"""
    monkeypatch.setattr(ft, "latest_release_assets", lambda *a, **k: pytest.fail("不该联网"))
    rep = ensure_toolchain(("java",), root=tmp_path)
    assert rep.java_exe is None and rep.fetched == [] and rep.notes


def test_fr4_1_default_root_env_override(monkeypatch, tmp_path: Path):
    monkeypatch.setenv(TOOLCHAIN_ROOT_ENV, str(tmp_path))
    assert default_toolchain_root() == tmp_path
    monkeypatch.delenv(TOOLCHAIN_ROOT_ENV)
    root = default_toolchain_root()
    assert root.name == "rea-tools"  # 缺省=仓库根旁工具区（gitignore 已覆盖）


def test_t12_proxied_url_rules():
    """gh 代理前缀规则：空前缀=原样；github.com 下载位才挂前缀；他站不动。"""
    dl = "https://github.com/cmy2008/presse/releases/download/v0.0.2/a.zip"
    assert proxied_url(dl, "") == dl
    assert proxied_url(dl, "https://ghproxy.net/") == "https://ghproxy.net/" + dl
    assert proxied_url(dl, "https://ghproxy.net") == "https://ghproxy.net/" + dl  # 尾斜杠归一
    api = "https://api.github.com/repos/x"
    assert proxied_url(api, "https://ghproxy.net/") == api       # api 位不挂代理
    assert proxied_url("https://example.com/a", "https://ghproxy.net/") == "https://example.com/a"


# 2026-10-22 实测 cmy2008/presse latest(v0.0.2) 资产六件（真名，非杜撰）
_PRESSE_ASSETS = [
    "presse-aarch64-apple-darwin.tar.gz",
    "presse-aarch64-pc-windows-msvc.zip",
    "presse-aarch64-unknown-linux-musl.tar.gz",
    "presse-x86_64-apple-darwin.tar.gz",
    "presse-x86_64-pc-windows-msvc.zip",
    "presse-x86_64-unknown-linux-gnu.tar.gz",
]


def test_t12_pick_presse_asset_by_platform():
    assert pick_presse_asset(_PRESSE_ASSETS, platform="win32", machine="AMD64") \
        == "presse-x86_64-pc-windows-msvc.zip"
    assert pick_presse_asset(_PRESSE_ASSETS, platform="win32", machine="ARM64") \
        == "presse-aarch64-pc-windows-msvc.zip"
    assert pick_presse_asset(_PRESSE_ASSETS, platform="linux", machine="x86_64") \
        == "presse-x86_64-unknown-linux-gnu.tar.gz"
    assert pick_presse_asset(_PRESSE_ASSETS, platform="linux", machine="aarch64") \
        == "presse-aarch64-unknown-linux-musl.tar.gz"
    assert pick_presse_asset(_PRESSE_ASSETS, platform="darwin", machine="arm64") \
        == "presse-aarch64-apple-darwin.tar.gz"
    assert pick_presse_asset(["only-linux.tar.gz"], platform="win32", machine="AMD64") is None


def test_t12_pick_ffdec_asset_rules():
    names = ["ffdec_26.4.0.zip", "ffdec_26.4.0_src.zip", "ffdec-cli.jar",
             "checksums.txt", "source-code.zip"]
    assert pick_ffdec_asset(names) == "ffdec_26.4.0.zip"
    assert pick_ffdec_asset(["other.zip"]) is None


def test_t12_repo_coordinates():
    """自举坐标与原工具 config.py 同源（DOC88_SPEC §1.7 自举口径）。"""
    assert PRESSE_REPO == "cmy2008/presse"
    assert FFDEC_REPO == "cmy2008/jpexs-decompiler"
    assert GH_PROXY_ENV == "KB_HARVEST_GH_PROXY"
    assert TOOLCHAIN_ROOT_ENV == "KB_HARVEST_TOOLCHAIN_DIR"


def test_t12_cli_probe(capsys, tmp_path: Path, monkeypatch):
    from kb_factory.harvest_engine.tools import fetch_toolchain as ft_main
    (tmp_path / "ffdec").mkdir()
    (tmp_path / "ffdec" / "ffdec.jar").write_bytes(b"")
    monkeypatch.setattr(sys, "argv", ["fetch_toolchain", "--probe", "--root", str(tmp_path)])
    rc = ft_main.main()
    out = capsys.readouterr().out
    assert rc == 0 and "ffdec" in out


@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP, reason="KB_HARVEST_SKIP_LIVE=1：实弹自举跳过（公约第 4 条）")
def test_fr4_1_live_presse_ensure_idempotent():
    """实弹自举（真网络）：ensure(presse) 幂等——在位零拉取，缺位真实拉取后落位。"""
    rep = ensure_toolchain(("presse",))
    assert rep.presse_exe and Path(rep.presse_exe).is_file()
    print(f"[live] presse={rep.presse_exe} fetched={rep.fetched}")


# ---------------------------------------------------------------------------
# ④ NFR6：零 GPL import（静态门，镜像发布门扫描口径）
# ---------------------------------------------------------------------------

def test_nfr6_zero_gpl_import_in_t12_modules():
    """本任务两模块 import 面干净：无 fitz(AGPL)、无原工具 GPL 码 import。"""
    for rel in ("pdf/swf_toolchain.py", "tools/fetch_toolchain.py"):
        src = (_KB_DIR / "harvest_engine" / rel).read_text(encoding="utf-8")
        roots = set()
        for node in ast.walk(ast.parse(src)):
            if isinstance(node, ast.Import):
                roots.update(alias.name.split(".")[0] for alias in node.names)
            elif isinstance(node, ast.ImportFrom) and node.module:
                roots.add(node.module.split(".")[0])
        assert "fitz" not in roots, f"{rel}: fitz(AGPL) 禁用（image_pdf 铁律同源）"
        assert not any(r.startswith("doc88") for r in roots), f"{rel}: 原工具 GPL 码零 import"
