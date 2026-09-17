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

# ---------- 图片 OCR 资格（09-17 收编线） ----------
# 目的边界（本人+工作）+ 价值密度双闸：C 盘用户区照片多为私人/
# 消费内容不采；公众号文章配图（Auto-wechat-article-exporter，
# 4.9 万张）量大留作主力队列磨完后的第二波。第一波=工作证据图
# （白龟湖影像卷 627 张/知识库/MemoTrace/企微聊天截图）。
OCR_IMAGE_SUFFIXES = {".jpg", ".jpeg", ".png", ".bmp", ".webp"}
OCR_IMAGE_MIN_BYTES = 51_200  # 50KB 起：表情包/小图标不值 OCR
OCR_IMAGE_PREFIXES = (
    "d:/20 白龟湖项目/", "d:/memotrace/", "f:/工程知识库超市/",
    "d:/wemedia/", "d:/wemediaoutput/", "d:/baidusyncdisk/",
    "e:/ai-station/07 任务/", "e:/ai-station/04 智库/",
    "e:/ai-station/research/",
    "c:/users/91216/documents/wxwork/",  # 企微聊天截图=工作通信
)


def ocr_image_eligible(path: str, size: int) -> bool:
    """图片是否值得 OCR：后缀 × 尺寸 × 目录资格三闸。"""
    p = _norm_path(path)
    return (os.path.splitext(p)[1] in OCR_IMAGE_SUFFIXES
            and size >= OCR_IMAGE_MIN_BYTES
            and p.startswith(OCR_IMAGE_PREFIXES))

# 真机实证（09-16 双会话长跑）：企业微信 WeDrive 云端占位文件 open()
# 会挂起拉云（单文件可卡 6+ 分钟，整轮提取几乎零推进的元凶）——
# 前缀路由 metadata-only（只 stat 不 open），本地缓存恢复后自然重扫。
CLOUD_PLACEHOLDER_PREFIXES = (
    "c:/users/91216/documents/wxwork/",
)


def _norm_path(path: str) -> str:
    return str(path).replace("\\", "/").lower()


class Triage:
    """后缀路由 + PDF magic 复核（后缀撒谎最常见的就是 pdf/doc）。"""

    def classify(self, path: str) -> tuple[str, str]:
        """→ (kind, parser_id)；metadata-only 的 kind 由调用方按需覆盖。"""
        p = _norm_path(path)
        if any(p.startswith(pref) for pref in CLOUD_PLACEHOLDER_PREFIXES):
            return "cloud-placeholder", "metadata-only"
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
