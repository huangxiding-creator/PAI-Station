# -*- coding: utf-8 -*-
# ============================================================================
# [重建代码 | Reconstructed from bytecode]
# 来源模块 : utils/bkn.pyc (自 PyInstaller PYZ 提取, CPython 3.13.1 字节码)
# 反汇编   : dump/utils_bkn.dis.txt / dump/utils_bkn.summary.txt
# 方法     : 指令级人工重建(LOAD_CONST 恢复常量/异常表恢复控制流/全局+属性链恢复调用),
#            并经 CPython 3.13 重编译 dis 逐指令比对(diff=0)验证; docstring 取自 co_consts 原文
# 置信度   : 高 —— 指令序列/行号/常量 100% 对齐; 仅源码注释与空行填充风格不可还原
# 注意     : 本注释头之下第一行 = 原 bkn.py 第 1 行 (行号 1:1 对齐)
# ============================================================================
"""BKN 计算工具"""
import time


def calculate_bkn(token):
    """
计算 x-ima-bkn 值
使用 DJB Hash 算法（DJBX33A 变体）
"""
    try:
        if not token:
            return 0

        hash_value = 5381
        for char in token:
            hash_value += (hash_value << 5) + ord(char)
        return hash_value & 2147483647

    except Exception:
        return 0


def get_timestamp():
    """获取当前时间戳（秒）"""
    return int(time.time())
