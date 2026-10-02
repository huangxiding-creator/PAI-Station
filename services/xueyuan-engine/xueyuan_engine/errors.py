# -*- coding: utf-8 -*-
"""统一业务异常——{code,message} 机器码错误体（API_DESIGN §一通例）。

app.py 注册 handler；各业务域 raise ApiError(状态码, 机器码, 中文文案)。
独立小模块避免 app↔业务域循环导入。
"""
from __future__ import annotations


class ApiError(Exception):
    """对外错误：status + 机器码 code（如 ALREADY_ENTITLED）+ 中文 message。

    extra 可携带契约要求的附加字段（如 503 PAY_NOT_CONFIGURED 的 degrade:"pay_gray"），
    handler 原样并入错误体（超集字段不破坏 {code,message} 通例）。
    """

    def __init__(self, status: int, code: str, message: str,
                 extra: dict | None = None) -> None:
        super().__init__(message)
        self.status = status
        self.code = code
        self.message = message
        self.extra = extra or {}
