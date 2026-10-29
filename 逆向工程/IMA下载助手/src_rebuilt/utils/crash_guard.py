# -*- coding: utf-8 -*-
# ============================================================================
# [重建代码 | Reconstructed from bytecode]
# 来源模块 : utils/crash_guard.pyc (自 PyInstaller PYZ 提取, CPython 3.13.1 字节码)
# 反汇编   : dump/utils_crash_guard.dis.txt / dump/utils_crash_guard.summary.txt
#           (由 tools/utils_dump.py 以 marshal.loads + dis.dis 落盘)
# 方法     : 指令级人工重建(异常表恢复 try/except 与 with 结构/f-string 逐段还原/
#            STORE_GLOBAL 推断 global 声明), 并经 CPython 3.13 重编译 dis 逐指令
#            比对(diff=0)验证; docstring 取自 co_consts 原文
# 置信度   : 高 —— 指令序列/行号/常量 100% 对齐
# 不确定点 : ① 第 34 行(_header 表达式内)原文可能是注释而非空行 ② install_crash_guard
#            的 global 声明原文可能拆成多行(编译结果相同) ③ 各处空行位置为推测填充
# 注意     : 本注释头之下第一行 = 原 crash_guard.py 第 1 行 (行号 1:1 对齐)
# ============================================================================
import faulthandler
import os
import platform
import sys
import threading
import time
import traceback

from PySide6.QtCore import QtMsgType, qInstallMessageHandler

from config import Config, VERSION


_crash_file = None
_previous_sys_excepthook = None
_previous_threading_excepthook = None


def _write_crash_log(text):
    try:
        path = Config.get_crash_log_file_path()
        os.makedirs(os.path.dirname(path), exist_ok=True)
        with open(path, 'a', encoding='utf-8') as file_obj:
            file_obj.write(text)
            if not text.endswith('\n'):
                file_obj.write('\n')
    except Exception:
        pass


def _header(title):
    return (
        '\n================================================================================'

        + f'\n{title}\n'
        + f'Time: {time.strftime("%Y-%m-%d %H:%M:%S")}\n'
        + f'Version: {VERSION}\n'
        + f'Python: {sys.version.replace(os.linesep, " ")}\n'
        + f'Platform: {platform.platform()}\n'
        + f'Frozen: {getattr(sys, "frozen", False)}\n'
        + '================================================================================'
        + '\n'
    )


def _format_exception(exc_type, exc_value, exc_traceback):
    return ''.join(traceback.format_exception(exc_type, exc_value, exc_traceback))


def _sys_excepthook(exc_type, exc_value, exc_traceback):
    _write_crash_log(_header('UNHANDLED EXCEPTION') + _format_exception(exc_type, exc_value, exc_traceback))
    if _previous_sys_excepthook and _previous_sys_excepthook is not _sys_excepthook:
        try:
            _previous_sys_excepthook(exc_type, exc_value, exc_traceback)
        except Exception:
            pass


def _threading_excepthook(args):
    _write_crash_log(
        _header(f'THREAD EXCEPTION: {getattr(args.thread, "name", "unknown")}')
        + _format_exception(args.exc_type, args.exc_value, args.exc_traceback)
    )
    if _previous_threading_excepthook and _previous_threading_excepthook is not _threading_excepthook:
        try:
            _previous_threading_excepthook(args)
        except Exception:
            pass


def _qt_message_handler(message_type, context, message):
    if message_type in (QtMsgType.QtCriticalMsg, QtMsgType.QtFatalMsg):
        location = ''
        if getattr(context, 'file', None):
            location = f' ({context.file}:{context.line})'
        _write_crash_log(_header('QT CRITICAL MESSAGE') + f'{message}{location}\n')


def install_crash_guard():
    """Install best-effort crash logging for packaged GUI builds."""
    global _crash_file, _previous_sys_excepthook, _previous_threading_excepthook

    try:
        path = Config.get_crash_log_file_path()
        os.makedirs(os.path.dirname(path), exist_ok=True)
        _crash_file = open(path, 'a', encoding='utf-8', buffering=1)
        faulthandler.enable(file=_crash_file, all_threads=True)
    except Exception:
        _crash_file = None

    _previous_sys_excepthook = sys.excepthook
    sys.excepthook = _sys_excepthook

    _previous_threading_excepthook = getattr(threading, 'excepthook', None)
    if _previous_threading_excepthook is not None:
        threading.excepthook = _threading_excepthook

    try:
        qInstallMessageHandler(_qt_message_handler)
    except Exception:
        pass

    _write_crash_log(_header('APPLICATION STARTED'))
