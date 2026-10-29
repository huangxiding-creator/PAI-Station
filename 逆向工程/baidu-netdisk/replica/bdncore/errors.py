# -*- coding: utf-8 -*-
"""errno → 中文语义映射 + BdnError 异常族。

来源：任务书既定口径 + BLUEPRINT_MAP.md §8 已知坑（errno 12/-30/4/-9/8001）
     + CAPTURE_INVENTORY.md（20012/31034/311xx 家族）。
"""
from __future__ import annotations

# 熔断 errno 集：命中即全局停（BdnSession 熔断器）
# 规格：PROTOCOL.md 风控停机线 31119/31329（RESEARCH_DOCKET 实锤=官方承认黑名单码）+ 限流 20012/31034
# 2026-10-29 ss-judge HOLDOUT-3 抓雷返工：31319 系笔误（非实证码），已纠正为 31329
CIRCUIT_ERRNOS = frozenset({31119, 31329, 20012, 31034})

# errno → 中文语义
ERRNO_MAP = {
    -6: "未登录或身份失效（BDUSS/STOKEN 过期或无效）",
    -7: "参数错误（路径/参数不合法）",
    -8: "文件或目录已存在",
    -9: "提取码错误（密码型分享）",
    -10: "接口已下线或不可用",
    -12: "访问被拒绝（权限不足）",
    2: "参数错误",
    4: "文件重复（已存在于目标位置）",
    12: "内部错误/操作超限（如超转存数上限）",
    -30: "目标位置存在同名文件",
    111: "身份凭证异常（需重新登录）",
    112: "签名过期（sign1/sign3 失效，需重取）",
    113: "签名错误",
    8001: "触发验证码（需打码腿）",
    20012: "请求过于频繁（限流，熔断级）",
    31034: "请求配额受限（熔断级）",
    31112: "网盘配额已满（上传类）",
    31119: "账号风控/封禁（熔断级，官方承认黑名单码）",
    31329: "风控拦截/黑名单（熔断级，官方承认黑名单码）",
    31326: "Range 请求越界（CT11 节点有界 ≤5MB）",
    31319: "未证实码（历史资料未收录，ss-judge 1029 纠偏后保留仅作提示；勿依赖）",
    31061: "hit limit（单文件限制）",
    31064: "hit limit（请求限制）",
    31090: "文件数超限（批量下载包体过大）",
}


def describe(errno) -> str:
    """errno → 中文语义；未知码返回「未知错误(errno=N)」。"""
    try:
        errno = int(errno)
    except (TypeError, ValueError):
        return f"非法errno({errno!r})"
    return ERRNO_MAP.get(errno, f"未知错误(errno={errno})")


class BdnError(Exception):
    """基底异常。exit code 约定见 bdn.py：1=业务错，2=熔断/凭据错。"""

    exit_code = 1

    def __init__(self, message: str, errno=None):
        self.errno = errno
        super().__init__(message)


class BdnApiError(BdnError):
    """业务错误：errno != 0 且非熔断/非凭据。退出码 1。"""
    exit_code = 1

    def __init__(self, errno, message: str | None = None, payload=None):
        self.errno = int(errno)
        self.payload = payload
        # errno 必须贯通传给基底，否则会被基底默认值 None 覆盖（离线单测抓过此雷）
        super().__init__(f"[errno={self.errno}] {message or describe(self.errno)}",
                         errno=self.errno)


class BdnAuthError(BdnError):
    """凭据错误：加载失败/字段缺失/errno -6 或 111。退出码 2。"""
    exit_code = 2


class BdnNetworkError(BdnError):
    """传输错误：3 次指数退避后仍失败。退出码 1。"""
    exit_code = 1


class BdnCircuitOpen(BdnError):
    """熔断打开：errno 命中 CIRCUIT_ERRNOS 后全局停。退出码 2。"""
    exit_code = 2

    def __init__(self, message: str, errno=None):
        super().__init__(message, errno=errno)
