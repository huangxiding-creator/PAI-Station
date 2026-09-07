"""工具守卫（提案 4.2 security）：命令三级分级 allow / ask / deny。

deny：不可逆破坏（格式化、递归删系统路径、注册表写、关机、磁盘清理）
ask：有外联或副作用（下载、装包、push）
allow：只读与本地测试
判定必须留下审计痕迹（deny/ask 双留痕，allow 不噪音）。
词边界匹配防误伤（rmrf.py ≠ rm -rf）。
"""
import re

_DENY = [
    r"\brm\s+(-[a-z]*r[a-z]*f|-[a-z]*f[a-z]*r)\b",  # rm -rf / rm -fr
    r"\brm\s+-[a-z]*r[a-z]*f?\s+[A-Za-z]:[\\/]",     # rm -r C:\
    r"\bformat\s+[A-Za-z]:",                          # format C:
    r"\brd\s+/s\b",                                   # rd /s /q
    r"\bdel\s+(/[a-z]+\s+)*[A-Za-z]:\\",              # del C:\...（带盘符绝对路径）
    r"\bshutdown\b", r"\breboot\b", r"\bpoweroff\b",
    r"\breg\s+(delete|add)\b.*(/f|force)?",           # 注册表写/删
    r"\bdiskpart\b", r"\bclean\b.*disk", r"\bcd\s+--erase\b",
    r"\bmkfs(\.\w+)?\b",                              # Linux 格式化
]
_ASK = [
    r"\b(curl|wget)\b",            # 下载
    r"\bpip\s+install\b", r"\bnpm\s+install\b", r"\bpnpm\s+add\b",
    r"\bgit\s+push\b", r"\bgit\s+reset\s+--hard\b",
    r"\bInvoke-WebRequest\b", r"\biwr\b",
]
_DENY_RE = [re.compile(p, re.IGNORECASE) for p in _DENY]
_ASK_RE = [re.compile(p, re.IGNORECASE) for p in _ASK]


class ToolGuard:
    """classify(command) -> 'allow' | 'ask' | 'deny'；check 带审计。"""

    def __init__(self, audit=None):
        self._audit = audit

    def classify(self, command: str) -> str:
        cmd = command.strip()
        if not cmd:
            return "allow"
        for pattern in _DENY_RE:
            if pattern.search(cmd):
                return "deny"
        for pattern in _ASK_RE:
            if pattern.search(cmd):
                return "ask"
        return "allow"

    def check(self, command: str) -> dict:
        verdict = self.classify(command)
        matched = None
        for pattern in _DENY_RE + _ASK_RE:
            hit = pattern.search(command)
            if hit:
                matched = hit.group(0)
                break
        result = {"verdict": verdict, "matched": matched, "command": command}
        if verdict != "allow" and self._audit is not None:
            self._audit.record(f"tool_guard.{verdict}", module="security",
                               command=command, matched=matched)
        return result
