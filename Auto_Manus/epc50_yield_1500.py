# -*- coding: utf-8 -*-
"""EPC50 15:00 整点兜底班 — 用户令升级 (09-24): 24h 全天候运行, 唯一避开自媒永动机.

常驻调度已归 epc50_yield_guard.py (心跳驱动). 本器=今日 15:00 一次性整点兜底
(WeAIPO 日引擎 15:00 起跑, 守护判忙最多迟一拍, 本器保证整点精确让路).
动作与守护同款: 只停重腿 (军团 bash fill 循环+corps python+9333 浏览器),
轻腿照常 (收割器 api 直连 / cnki 国内线 / weread 夜任务) — 对齐 EPC100
「NB让路 pre-NB照常」方针; 然后切回国内直连 (登记 changelog).
"""
import io
import subprocess
import sys

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")

sys.path.insert(0, r"E:\AI-Station\Auto_Manus")
from epc50_yield_guard import kill_heavy   # noqa: E402 (复用守护收线实现)

PY311 = r"C:\Users\91216\AppData\Local\Programs\Python\Python311\python.exe"


def main() -> int:
    k = kill_heavy()   # bash fill 循环+corps python+metaso+9333 浏览器
    print(f"[yield] 重腿已停: {k or '(无可停进程, 守护可能已收线)'}",
          flush=True)
    rc = subprocess.call([PY311,
                          r"E:\AI-Station\Auto_Manus\epc50_net_back_direct.py",
                          "--force"])
    print(f"[yield] 切回直连 rc={rc} — 自媒永动机请用网 "
          f"(轻腿照常: 收割/cnki/weread)", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
