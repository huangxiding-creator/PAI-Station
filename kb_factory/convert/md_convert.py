"""W8 · 轻便阅读版（Markdown版）转换器。

convert_package(src_dir) -> dst_dir：镜像交付包目录树，逐文件转换——
- .docx → md（pandoc，--wrap=none；失败→诚实占位，绝不静默假装成功）
- .doc  → 先 pandoc 直试，失败→占位（如实标注 doc 老格式）
- .pdf  → v1 不抽取内文，占位（标题+页数+来源+建议原文阅读）
- .xlsx/.ppt（及 .xls/.pptx）→ 占位（同 pdf 逻辑）
- .md/.txt → 原样复制，文件名规范（去空格/特殊字符）
- 其余（manifest.json 等）→ 原样复制
产出 dst 根 转换报告.md（逐文件：成功转换/原样复制/占位 + 原因）。

占位/报告文案纪律：零渠道名零技术词（不提工具名与来源渠道）。
"""
from __future__ import annotations

import os
import re
import shutil
import subprocess
import time
from datetime import datetime
from pathlib import Path, PurePosixPath

DEFAULT_PANDOC = Path(r"E:\AI-Station\tools\pandoc-3.11\pandoc.exe")
PANDOC_TIMEOUT = 120  # 秒

# 生成件首行机器标记（HTML 注释，渲染不可见）：占位必须可被机器识别，
# 「绝不静默假装转换成功」由测试据此核数。
PLACEHOLDER_MARK = "<!-- kb-convert: placeholder -->"
CONVERTED_MARK = "<!-- kb-convert: markdown -->"

CONVERTED_EXTS = {".docx", ".doc"}          # 尝试真转换（doc 失败→占位）
PLACEHOLDER_EXTS = {".pdf", ".xls", ".xlsx", ".ppt", ".pptx"}  # v1 一律占位

REPORT_NAME = "转换报告.md"

_WS_RE = re.compile(r"[\s\u3000]+")
_BAD_RE = re.compile(r'[<>:"/\\|?*\x00-\x1f#$%&@^`~]')


def find_pandoc() -> str | None:
    """定位 pandoc：KB_PANDOC 环境变量覆盖 > 站内固定路径 > PATH。找不到返回 None。"""
    override = os.environ.get("KB_PANDOC")
    if override:
        return override if Path(override).is_file() else None  # 显式覆盖失效→如实判缺
    if DEFAULT_PANDOC.is_file():
        return str(DEFAULT_PANDOC)
    return shutil.which("pandoc")


def normalize_stem(stem: str) -> str:
    """文件名规范：空白→下划线，剔除路径不安全/特殊字符；保留中文与全角标点。

    只清理因空白替换产生的首尾下划线；原名自带的保持不动（如 _INDEX.md）。
    """
    lead, tail = stem.startswith("_"), stem.endswith("_")
    s = _WS_RE.sub("_", stem)
    s = _BAD_RE.sub("", s)
    if not lead:
        s = s.lstrip("_")
    if not tail:
        s = s.rstrip("_")
    return s or "未命名"


def dst_relpath(src_name: str) -> str:
    """源文件名 → dst 相对路径。doc/docx/pdf/xlsx/ppt → 同名 .md；其余保留扩展名。"""
    p = PurePosixPath(src_name.replace("\\", "/"))
    stem, ext = p.stem, p.suffix.lower()
    if ext in CONVERTED_EXTS or ext in PLACEHOLDER_EXTS:
        return f"{normalize_stem(stem)}.md"
    return f"{normalize_stem(stem)}{p.suffix}"


def _run_pandoc(pandoc: str, src: Path, dst: Path) -> tuple[bool, str]:
    """调用 pandoc 转单文件。返回 (成功?, 原因)；成功时在产物首行加转换标记。"""
    cmd = [pandoc, str(src), "-t", "gfm", "--wrap=none", "-o", str(dst)]
    try:
        r = subprocess.run(cmd, capture_output=True, timeout=PANDOC_TIMEOUT)  # 只读调用源文件
    except subprocess.TimeoutExpired:
        dst.unlink(missing_ok=True)
        return False, "转换超时，已保留占位"
    except OSError:
        dst.unlink(missing_ok=True)
        return False, "转换工具不可用，已保留占位"
    if r.returncode == 0 and dst.is_file() and dst.stat().st_size > 0:
        body = dst.read_text("utf-8", errors="replace")
        dst.write_text(f"{CONVERTED_MARK}\n{body}", encoding="utf-8", newline="")
        return True, "已转为 Markdown"
    dst.unlink(missing_ok=True)
    return False, f"自动转换失败（退出码 {r.returncode}），已保留占位"


def _pdf_page_hint(src: Path) -> str:
    """粗页数（只数字节标记，不解析内容）。数不出→如实写未识别，不编造。"""
    try:
        data = src.read_bytes()
    except OSError:
        return "页数：未识别"
    n = len(re.findall(rb"/Type\s*/Page(?!s)", data))
    return f"页数：约 {n} 页" if n else "页数：未识别"


def _write_placeholder(dst: Path, src: Path, advisory: str, extra: list[str] | None = None) -> None:
    """写占位 md：标题+来源徽章+建议+诚实限制说明。"""
    ext = src.suffix.lower().lstrip(".")
    lines = [
        PLACEHOLDER_MARK,
        f"# {normalize_stem(src.stem)}",
        "",
        f"> 来源：{src.name}（{ext} 格式）",
        "",
        advisory,
        "",
        *(extra or []),
        "",
        "---",
        "本页为索引占位，内容以包内原文件为准。",
    ]
    dst.write_text("\n".join(lines).rstrip() + "\n", encoding="utf-8", newline="")


def _placeholder_for(src: Path, dst: Path, reason: str = "") -> str:
    """按源类型生成占位，返回报告用说明（=占位原因，零技术词）。"""
    ext = src.suffix.lower()
    if ext == ".pdf":
        _write_placeholder(
            dst, src,
            "PDF原文保真，建议原文阅读。",
            extra=[
                _pdf_page_hint(src),
                "说明：轻便阅读版 v1 暂不抽取 PDF 内文，本页仅作索引。",
            ],
        )
        return "v1 不转换 PDF，保真占位（PDF原文保真，建议原文阅读）"
    if ext in {".xls", ".xlsx", ".ppt", ".pptx"}:
        _write_placeholder(dst, src, "表格/演示原文保真，建议原文阅读。")
        return "v1 不转换表格/演示文件，保真占位"
    if ext == ".doc":
        _write_placeholder(dst, src, "原文为 doc 老格式，建议原文阅读。")
        return reason or "doc 老格式自动转换未成功，保真占位"
    # .docx 转换失败
    _write_placeholder(dst, src, "原文为 docx，建议原文阅读。")
    return reason or "docx 自动转换未成功，保真占位"


def convert_package(src_dir: str | Path, dst_dir: str | Path | None = None) -> Path:
    """整包转 Markdown 版。返回 dst_dir（默认：源目录旁 {源名}_md）。"""
    src = Path(src_dir).resolve()
    if not src.is_dir():
        raise FileNotFoundError(f"交付包目录不存在: {src}")
    dst = Path(dst_dir).resolve() if dst_dir else src.parent / f"{src.name}_md"
    dst.mkdir(parents=True, exist_ok=True)

    pandoc = find_pandoc()
    rows: list[tuple[str, str, str]] = []  # (relpath, 结果, 说明)
    n_converted = n_copied = n_placeholder = 0

    for dirpath, dirnames, filenames in os.walk(src):
        dirnames.sort()
        rel_dir = Path(dirpath).relative_to(src)
        (dst / rel_dir).mkdir(parents=True, exist_ok=True)
        for fn in sorted(filenames):
            s = Path(dirpath) / fn
            rel = s.relative_to(src).as_posix()
            d = dst / rel_dir / dst_relpath(fn)
            if d.exists():  # 规范化撞名兜底
                d = d.with_name(f"{d.stem}_2{d.suffix}")
            ext = s.suffix.lower()
            if ext in CONVERTED_EXTS:
                if pandoc is None:
                    _placeholder_for(s, d, "转换工具不可用，保真占位")
                    rows.append((rel, "占位", "转换工具不可用，保真占位"))
                    n_placeholder += 1
                else:
                    ok, why = _run_pandoc(pandoc, s, d)
                    if ok:
                        rows.append((rel, "成功转换", why))
                        n_converted += 1
                    else:
                        _placeholder_for(s, d, why)
                        rows.append((rel, "占位", why))
                        n_placeholder += 1
            elif ext in PLACEHOLDER_EXTS:
                why = _placeholder_for(s, d)
                rows.append((rel, "占位", why))
                n_placeholder += 1
            else:
                shutil.copy2(s, d)
                rows.append((rel, "原样复制", "仅规范化文件名，内容零改动"))
                n_copied += 1

    total = len(rows)
    tool_state = "就绪" if pandoc else "不可用（本包 doc/docx 均为占位）"
    lines = [
        "# 转换报告（Markdown 版）",
        "",
        f"- 源目录：{src.name}",
        f"- 输出目录：{dst.name}",
        f"- 转换工具：{tool_state}",
        f"- 生成时间：{datetime.now().strftime('%Y-%m-%d %H:%M')}",
        "",
        "## 汇总",
        "",
        "| 结果 | 数量 |",
        "|---|---|",
        f"| 成功转换 | {n_converted} |",
        f"| 原样复制 | {n_copied} |",
        f"| 占位（保真提示） | {n_placeholder} |",
        f"| 合计 | {total} |",
        "",
        "## 逐文件明细",
        "",
        "| 文件 | 结果 | 说明 |",
        "|---|---|---|",
        *[f"| {rel} | {res} | {why} |" for rel, res, why in rows],
        "",
    ]
    lines.append(f"汇总：成功转换 {n_converted}｜原样复制 {n_copied}｜占位 {n_placeholder}｜合计 {total}")
    (dst / REPORT_NAME).write_text("\n".join(lines), encoding="utf-8", newline="")
    return dst


if __name__ == "__main__":  # 直跑单文件调试
    import sys

    print(convert_package(sys.argv[1]))
