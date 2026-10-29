# -*- coding: utf-8 -*-
# ============================================================================
# [重建代码 | Reconstructed from bytecode]
# 来源模块 : utils/time_parser.pyc (自 PyInstaller PYZ 提取, CPython 3.13.1 字节码)
# 反汇编   : dump/utils_time_parser.dis.txt / dump/utils_time_parser.summary.txt
#           (由 tools/utils_dump.py 以 marshal.loads + dis.dis 落盘)
# 方法     : 指令级人工重建(异常表恢复 try/except 与 if/elif 链/STORE_FAST_STORE_FAST
#            顺序经实验比对确认), 并经 CPython 3.13 重编译 dis 逐指令比对(diff=0)验证;
#            docstring 取自 co_consts 原文
# 置信度   : 高 —— 指令序列/行号/常量 100% 对齐
# 不确定点 : def 与首语句间无字节码的行(29/32-33/39-40/43/45/52/54/58-59/63/65/68)
#            原文可能是注释而非空行, 语义不受影响
# 注意     : 本注释头之下第一行 = 原 time_parser.py 第 1 行 (行号 1:1 对齐)
# ============================================================================
"""时间字符串解析工具"""
from datetime import datetime, timedelta


def parse_time_wording(time_str):
    """
解析不规范的时间字符串为datetime对象

支持格式：
- "25/12/11" → 2025年12月11日
- "2/26" → 当前年份2月26日
- "昨天" → 昨天日期
- "06:47" → 今天06:47
- "-" 或空 → None

Args:
    time_str: 时间字符串

Returns:
    datetime对象，解析失败返回None
"""
    if not time_str or time_str == '-':
        return None

    time_str = time_str.strip()
    now = datetime.now()

    try:
        if time_str == '昨天':
            return now - timedelta(days=1)

        if ':' in time_str and '/' not in time_str:
            parts = time_str.split(':')
            if len(parts) == 2:
                hour, minute = int(parts[0]), int(parts[1])
                return now.replace(hour=hour, minute=minute, second=0, microsecond=0)

        if '/' in time_str:
            parts = time_str.split('/')

            if len(parts) == 3:
                year = int(parts[0])
                if year < 100:
                    year += 2000
                month = int(parts[1])
                day = int(parts[2])
                return datetime(year, month, day)

            if len(parts) == 2:
                month = int(parts[0])
                day = int(parts[1])
                year = now.year

                result = datetime(year, month, day)
                if result > now:
                    result = datetime(year - 1, month, day)

                return result

    except (ValueError, IndexError):
        pass

    return None
