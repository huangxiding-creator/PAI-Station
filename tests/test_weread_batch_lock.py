# -*- coding: utf-8 -*-
"""weread_batch 串行提取锁测试（2026-09-11 用户令：绝不并行提取）。

锁语义：OS 级独占（msvcrt），持锁期间任何第二进程抢锁失败；
释放（close/进程退出/崩溃）后可重抢，无死锁残留。
"""
import importlib.util
import subprocess
import sys
from pathlib import Path

SCRIPT = Path(__file__).resolve().parent.parent / "scripts" / "weread_batch.py"


def load_module():
    spec = importlib.util.spec_from_file_location("wb_lock", SCRIPT)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


def test_first_acquire_then_release(tmp_path, monkeypatch):
    wb = load_module()
    monkeypatch.setattr(wb, "RECON", str(tmp_path))
    lock = wb.acquire_extract_lock()
    assert lock is not None
    lock.close()
    again = wb.acquire_extract_lock()               # 释放后立即可重抢
    assert again is not None
    again.close()


def test_second_process_blocked_while_held(tmp_path, monkeypatch):
    wb = load_module()
    monkeypatch.setattr(wb, "RECON", str(tmp_path))
    lock = wb.acquire_extract_lock()
    assert lock is not None
    code = (
        "import importlib.util,sys\n"
        f"spec=importlib.util.spec_from_file_location('wb',r'{SCRIPT}')\n"
        "wb=importlib.util.module_from_spec(spec);spec.loader.exec_module(wb)\n"
        f"wb.RECON=r'{tmp_path}'\n"
        "sys.exit(0 if wb.acquire_extract_lock() is None else 3)\n"
    )
    r = subprocess.run([sys.executable, "-X", "utf8", "-c", code],
                       capture_output=True, timeout=30)
    assert r.returncode == 0, "持锁期间子进程不应抢到锁"
    lock.close()


def test_lock_records_pid(tmp_path, monkeypatch):
    import os
    wb = load_module()
    monkeypatch.setattr(wb, "RECON", str(tmp_path))
    lock = wb.acquire_extract_lock()
    assert lock is not None
    lock.seek(0)                                    # 经持锁句柄本体读（新句柄会撞区域锁）
    body = lock.read()
    assert str(os.getpid()) in body                 # 持锁进程 pid 落盘可诊断
    lock.close()
