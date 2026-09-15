"""L1 分诊器：扩展名+magic → kind + parser_id 路由（零重库）。

调研共识（Tika 注册表 / unstructured partition_*）：先分诊后路由。
exiftool 未装 → 后缀为主、magic 兜底（puremagic 已在依赖位）；
分不出来按 unknown 走 metadata-only，绝不猜解析器。
"""
from __future__ import annotations

import os

# kind → (后缀集, parser_id)；顺序即优先级
ROUTES: dict[str, tuple[tuple[str, ...], str]] = {
    "pdf":        ((".pdf",), "pymupdf"),
    "word":       ((".docx", ".docm"), "python-docx"),
    "excel":      ((".xlsx", ".xlsm"), "openpyxl"),
    "powerpoint": ((".pptx",), "python-pptx"),
    "email_msg":  ((".msg",), "extract_msg"),
    "email_eml":  ((".eml",), "stdlib-email"),
    "mbox":       ((".mbox",), "stdlib-email"),
    "text":       ((".txt", ".md", ".rst", ".log", ".ini", ".toml",
                    ".yaml", ".yml", ".cfg", ".conf"), "plaintext"),
    "code":       ((".py", ".js", ".ts", ".tsx", ".java", ".c", ".cpp", ".h",
                    ".cs", ".go", ".rs", ".rb", ".php", ".sh", ".bat", ".ps1",
                    ".sql", ".html", ".css", ".vue"), "plaintext"),
    "data":       ((".json", ".csv", ".tsv", ".xml"), "plaintext"),
    "image":      ((".png", ".jpg", ".jpeg", ".gif", ".bmp", ".webp",
                    ".tif", ".tiff", ".svg"), "metadata-only"),
    "audio":      ((".mp3", ".wav", ".flac", ".aac", ".m4a",
                    ".ogg"), "metadata-only"),
    "video":      (".mp4 .avi .mkv .mov .wmv .flv".split(), "metadata-only"),
    "archive":    (".zip .rar .7z .tar .gz .bz2 .iso".split(), "metadata-only"),
    "binary":     ((".exe", ".dll", ".so", ".dylib", ".bin", ".dat",
                    ".db", ".sqlite", ".pyd"), "metadata-only"),
}
_SUFFIX2KIND = {sfx: kind for kind, (sfxs, _) in ROUTES.items() for sfx in sfxs}


class Triage:
    """后缀路由 + PDF magic 复核（后缀撒谎最常见的就是 pdf/doc）。"""

    def classify(self, path: str) -> tuple[str, str]:
        """→ (kind, parser_id)；metadata-only 的 kind 由调用方按需覆盖。"""
        suffix = os.path.splitext(path)[1].lower()
        kind = _SUFFIX2KIND.get(suffix, "")
        if not kind:
            kind, parser = self._by_magic(path)
            return kind, parser
        return kind, ROUTES[kind][1]

    def _by_magic(self, path: str) -> tuple[str, str]:
        head = b""
        try:
            with open(path, "rb") as fh:
                head = fh.read(8)
        except OSError:
            return "unknown", "metadata-only"
        if head.startswith(b"%PDF"):
            return "pdf", "pymupdf"
        if head.startswith(b"PK\x03\x04"):
            return "ooxml", "metadata-only"  # 无后缀的 Office 包，不猜
        return "unknown", "metadata-only"
