"""扫描域（P0）：纳入哪些根、排除哪些段、红线哪些模式。

调研共识（paperless 子目录即标签 / organize 过滤器 DSL）：路径信号
是与内容同权的一等信号，所以域定义本身就是画像的一部分。
红线纪律：密钥类文件名只登记路径、内容永不进提取与索引；
凭据库/加密盘（.kdbx 等）同样只登记不解析（self-profile 红线）。
"""
from __future__ import annotations

import fnmatch
import logging
import os

_log = logging.getLogger("paistation.sense.localfiles.domain")

# 目录段级排除（fnmatch 匹配单个路径段，任一段命中即整树跳过）
DEFAULT_EXCLUDE_NAMES = (
    "node_modules", ".git", ".svn", ".hg", "__pycache__", ".mypy_cache",
    ".ruff_cache", ".pytest_cache", "venv", ".venv", "env", "site-packages",
    "AppData", "$RECYCLE.BIN", "System Volume Information", "Windows",
    "Program Files", "Program Files (x86)", "ProgramData",
    ".cache", ".npm", ".nuget", ".gradle", ".idea", ".vscode", ".vs",
    "dist", "build", "target", "out", "bin", "obj",  # 构建产物
    "browser_profile",  # 本项目 data/ 下的浏览器隔离档案
)

# 路径前缀级排除（规范化小写比较）
DEFAULT_EXCLUDE_PATHS = (
    "e:/ai-station/data/local_index",   # 自己的索引库不进索引
    "e:/ai-station/data/browser_profile",
    "e:/ai-station/_recon",             # 调研工件自有家园，另有台账
    "e:/ai-station/vendor",             # 第三方部署体
    "e:/ai-station/build",
)

# 红线：内容永不提取/索引，仅登记路径（inventory 只存元数据）
SECRET_NAME_PATTERNS = (
    "*key*", "*secret*", "*token*", "*.pem", "*.p12", "*.pfx",
    "*.kdbx", "*.wallet", "*.kbdx", "*credential*", "*password*",
    "id_rsa*", "authorized_keys", "*.keystore", "*.jks",
)
SECRET_PATH_SEGMENTS = (".ssh", ".gnupg", ".password-store")

# 纳入根（存在才参与；不存在记 debug 跳过）
DEFAULT_INCLUDES = (
    "~/Desktop", "~/Documents", "~/Downloads", "~/Pictures",
    "E:/AI-Station",
    # 2026-09-17 扩域：D/F 盘工作阵地（白龟湖全案档案 01-10 编号体系/
    # 自媒体图库/工程知识库超市·水利系列）。
    # 2026-09-17 二次扩域（用户拍板"全部进大脑"）：MemoTrace 微信全量
    # 导出（聊天记录/朋友圈，文字金矿+媒体 metadata 零成本路由）、
    # BaiduSyncdisk（实测真本地文件）、浏览器下载区、用户媒体目录。
    "D:/20 白龟湖项目",
    "D:/WEMedia",
    "D:/WEMediaOutput",
    "F:/工程知识库超市",
    "D:/MemoTrace",
    "D:/BaiduSyncdisk",
    "D:/360Downloads",
    "D:/360安全浏览器下载",
    "D:/md2wechat-skill",
    "~/Videos",
    "~/Music",
)


def _norm(path: str) -> str:
    return path.replace("\\", "/").rstrip("/").lower()


class ScanDomain:
    """不可变扫描域：covers() 判纳入、is_secret() 判红线。"""

    def __init__(self, includes=DEFAULT_INCLUDES,
                 exclude_names=DEFAULT_EXCLUDE_NAMES,
                 exclude_paths=DEFAULT_EXCLUDE_PATHS,
                 secret_patterns=SECRET_NAME_PATTERNS,
                 secret_segments=SECRET_PATH_SEGMENTS):
        self.includes = tuple(os.path.expanduser(p) for p in includes)
        self.exclude_names = tuple(n.lower() for n in exclude_names)
        self.exclude_paths = tuple(_norm(p) for p in exclude_paths)
        self.secret_patterns = tuple(p.lower() for p in secret_patterns)
        self.secret_segments = tuple(s.lower() for s in secret_segments)

    # ---------- 判定 ----------

    def existing_roots(self) -> list[str]:
        roots = []
        for root in self.includes:
            if os.path.isdir(root):
                # normpath 归一分隔符：expanduser('~/Desktop') 会保留
                # '/Desktop' 正斜杠，与 es.exe 纯反斜杠输出零交集——
                # 双后端必须同一规范形（Windows=反斜杠）
                roots.append(os.path.normpath(root))
            else:
                _log.debug("扫描根不存在，跳过: %s", root)
        return roots

    def covers(self, path: str) -> bool:
        """在纳入根之下、且无任何段/前缀命中排除。"""
        norm = _norm(str(path))
        if not any(norm.startswith(_norm(r) + "/") or norm == _norm(r)
                   for r in self.includes):
            return False
        for pref in self.exclude_paths:
            if norm.startswith(pref):
                return False
        for seg in norm.split("/"):
            if seg in self.exclude_names:
                return False
        if norm.rsplit("/", 1)[-1].startswith("~$"):
            return False  # Office 全程锁文件：零价值，枚举级排除
        return True

    def is_secret(self, path: str) -> bool:
        """红线判定：命中即只登记路径，内容不提取不索引。"""
        norm = _norm(str(path))
        if any(seg in self.secret_segments for seg in norm.split("/")):
            return True
        name = norm.rsplit("/", 1)[-1]
        return any(fnmatch.fnmatch(name, pat) for pat in self.secret_patterns)
