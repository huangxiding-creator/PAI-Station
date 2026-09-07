"""白名单目录守卫（默认仅 Documents/Desktop/Downloads）——只读红线。

项目目录之外的任何本机交互都必须先过本守卫；感知层对白名单目录只读。
越界访问：拒绝（GuardViolation）并写入审计留痕（锚点 0.5）。
"""
import os

from paistation.security.audit import AuditLog


class GuardViolation(Exception):
    """路径越界或不存在：已拒绝并留痕。"""


class FileGuard:
    """白名单目录读守卫（大小写不敏感、realpath 防 ../ 与符号链接逃逸）。"""

    def __init__(self, allowed_dirs: list[str], audit: AuditLog | None = None):
        self._allowed = [self._normalize(d) for d in allowed_dirs]
        self._audit = audit

    @staticmethod
    def _normalize(path: str) -> str:
        expanded = os.path.expandvars(os.path.expanduser(str(path)))
        return os.path.normcase(os.path.abspath(expanded))

    def _deny(self, path, reason: str):
        if self._audit:
            self._audit.record("file_guard.deny", module="security",
                               path=str(path)[:300], reason=reason)
        raise GuardViolation(f"越界访问被拒：{path}（{reason}）")

    def check(self, path: str) -> str:
        """校验路径在白名单内且存在；返回 realpath。"""
        real = os.path.realpath(os.path.abspath(
            os.path.expandvars(os.path.expanduser(str(path)))))
        if not (os.path.isfile(real) or os.path.isdir(real)):
            self._deny(path, "路径不存在")
        rc = os.path.normcase(real)
        for allowed in self._allowed:
            if rc == allowed or rc.startswith(allowed + os.sep):
                if self._audit:
                    self._audit.record("file_guard.allow", module="security",
                                       path=real[:300])
                return real
        self._deny(path, "不在白名单目录内")

    def read_text(self, path: str, encoding: str = "utf-8",
                  errors: str = "ignore") -> str:
        """守卫校验后只读读取文本。"""
        with open(self.check(path), encoding=encoding, errors=errors) as fh:
            return fh.read()
