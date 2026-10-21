# -*- coding: utf-8 -*-
"""m2_write_guard — 防空覆盖写入守卫 (1021 汲取令落地, 蓝本: Manus live
event[89] 生成脚本自改造「len(text)>3000 才写」).

铁律: 任何批量生成器写盘前, 若目标已存在合格稿, 新正文长度低于阈值时
禁止覆盖 —— 防空章/截断输出污染成品 (live 实测曾出 28 字符空章险入交付).

用法(库):
    from m2_write_guard import write_if_long
    write_if_long(path, text, min_chars=3000)      # 返回 True=已写 False=拒写
    write_if_long(path, text, min_chars=3000, relative=True)  # 新稿不短于旧稿60%
CLI:
    py -X utf8 m2_write_guard.py check <path> <text_len> [--min 3000]
"""
from __future__ import annotations

import argparse
import sys
from pathlib import Path

DEFAULT_MIN = 3000          # Manus live 实证阈值
RELATIVE_FLOOR = 0.6        # relative 模式: 新稿不得低于旧稿 60%


def write_if_long(path: Path | str, text: str, min_chars: int = DEFAULT_MIN,
                  relative: bool = False) -> bool:
    """合格才写盘。绝对门槛: len(text)>=min_chars; relative 再加:
    已有旧稿时 len(text)>=旧稿*RELATIVE_FLOOR (防返工短稿覆盖长稿)。"""
    p = Path(path)
    n = len(text)
    if n < min_chars:
        print(f"[guard] ✋ 拒写 {p.name}: 新稿{n:,}字 < 绝对门槛{min_chars:,}")
        return False
    if relative and p.is_file():
        old = len(p.read_text(encoding="utf-8", errors="replace"))
        floor = int(old * RELATIVE_FLOOR)
        if n < floor:
            print(f"[guard] ✋ 拒写 {p.name}: 新稿{n:,}字 < 旧稿{old:,}×"
                  f"{RELATIVE_FLOOR:.0%}={floor:,}")
            return False
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(text, encoding="utf-8")
    return True


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser()
    ap.add_argument("cmd", choices=["check"])
    ap.add_argument("path")
    ap.add_argument("text_len", type=int)
    ap.add_argument("--min", type=int, default=DEFAULT_MIN)
    ns = ap.parse_args()
    ok = ns.text_len >= ns.min
    print(f"[guard] {'✅ 可写' if ok else '✋ 拒写'}: {ns.path} "
          f"{ns.text_len:,} vs 门槛{ns.min:,}")
    return 0 if ok else 1


if __name__ == "__main__":
    raise SystemExit(main())
