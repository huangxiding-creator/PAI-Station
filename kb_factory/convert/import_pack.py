"""W8 · 随身导入包（+¥19）：面向主流AI知识库应用的一键导入 zip。

make_import_pack(src_dir) -> zip_path：原包深拷贝结构 + 顶层加
- 如何导入.txt：知识库类App 三步导入法（建库→按目录上传→开问；Coze 单列）
- 目录速览.txt：全树清单
zip 命名 {库名}_import_pack.zip（库名读 manifest.json，兜底目录名）。

文案纪律：零渠道名零技术词（不提来源与获取方式；具体应用名仅保留 Coze，
其余一律通用措辞）。
"""
from __future__ import annotations

import json
import zipfile
from pathlib import Path

from kb_factory.convert.md_convert import _WS_RE, _BAD_RE  # 文件名清洗同源复用

HOW_TO_NAME = "如何导入.txt"
OVERVIEW_NAME = "目录速览.txt"

GUIDE_TEMPLATE = """《{lib}》随身导入包 · 如何导入

本导入包适配手机/网页端的知识库类应用，三步完成导入，全程无需任何额外工具。

一、主流AI知识库应用
  第1步 建库：打开你常用的AI知识库应用，新建知识库，命名「{lib}」。
  第2步 按目录上传：按包内目录结构，逐文件夹上传资料，保持原有层级不变。
  第3步 开问：上传完成后直接提问，例如「这个资料库讲了什么？」

二、Coze
  第1步 建库：在 Coze 中新建知识库，命名「{lib}」。
  第2步 按目录上传：按包内目录结构，逐文件夹上传资料。
  第3步 开问：在对话中关联该知识库，即可开始提问。

三、其他知识库类App（通用）
  第1步 建库：任选一款支持文件上传的知识库类App，新建知识库。
  第2步 按目录上传：先传根目录的说明文件，再逐文件夹上传全部资料。
  第3步 开问：上传完成后直接提问使用。

小贴士：文件较多时可分批上传；全部传完后建议先问一句「库里有哪些资料」，确认导入完整。
"""


def _sanitize(text: str) -> str:
    s = _WS_RE.sub("_", text).strip("_")
    return _BAD_RE.sub("", s) or "未命名"


def lib_name(src_dir: Path) -> str:
    """库名：manifest.json 的 库名/name/kb_name/title，兜底目录名。"""
    manifest = src_dir / "manifest.json"
    if manifest.is_file():
        try:
            data = json.loads(manifest.read_text("utf-8"))
        except (OSError, ValueError):
            data = None
        if isinstance(data, dict):
            for key in ("库名", "name", "kb_name", "title"):
                if data.get(key):
                    return _sanitize(str(data[key]))
    return _sanitize(src_dir.name)


def render_tree(root: Path) -> str:
    """全树清单（目录/文件缩进树）。"""
    lines = [f"{root.name}/"]

    def walk(directory: Path, prefix: str) -> None:
        entries = sorted(directory.iterdir(), key=lambda p: (p.is_file(), p.name))
        for i, entry in enumerate(entries):
            last = i == len(entries) - 1
            branch = "└── " if last else "├── "
            suffix = "/" if entry.is_dir() else ""
            lines.append(f"{prefix}{branch}{entry.name}{suffix}")
            if entry.is_dir():
                walk(entry, prefix + ("    " if last else "│   "))

    walk(root, "")
    return "\n".join(lines)


def make_import_pack(src_dir: str | Path, out_dir: str | Path | None = None) -> Path:
    """生成随身导入包 zip，返回 zip 路径（默认在源包旁）。"""
    src = Path(src_dir).resolve()
    if not src.is_dir():
        raise FileNotFoundError(f"交付包目录不存在: {src}")
    name = lib_name(src)
    out = Path(out_dir).resolve() if out_dir else src.parent
    out.mkdir(parents=True, exist_ok=True)
    zip_path = out / f"{name}_import_pack.zip"

    with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as zf:
        for p in sorted(src.rglob("*")):
            if p.is_file():
                zf.write(p, p.relative_to(src).as_posix())
        zf.writestr(HOW_TO_NAME, GUIDE_TEMPLATE.format(lib=name))
        zf.writestr(OVERVIEW_NAME, render_tree(src) + "\n")
    return zip_path


if __name__ == "__main__":  # 直跑单文件调试
    import sys

    print(make_import_pack(sys.argv[1]))
