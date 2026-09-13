"""M6.1 硬件分级（dist/）：探测器+三档配置映射。

普适性红线：低配老笔记本也要能跑——探测器量 CPU/内存/GPU，
映射 low/mid/high 三档；低配关深读、退 hashing 嵌入、缩并发，
保住"常驻+零成本"两条命根。探测失败按 low 处理（宁保守不炸机）。
"""
from __future__ import annotations

import ctypes
import os
import shutil
import subprocess

TIER_SETTINGS = {
    "low": {
        "embedder": "hashing",       # 零依赖兜底，不下载模型
        "deepread": False,           # 深读吃资源，低配先关
        "workers": 1,
        "screen_interval_sec": 1200,
        "ensemble_size": 4,
    },
    "mid": {
        "embedder": "hashing",
        "deepread": True,
        "workers": 4,
        "screen_interval_sec": 600,
        "ensemble_size": 8,
    },
    "high": {
        "embedder": "bge-m3",        # 双根探测有模型才升，否则仍 hashing
        "deepread": True,
        "workers": 8,
        "screen_interval_sec": 300,
        "ensemble_size": 8,
    },
}


def probe_hardware() -> dict:
    """本机硬件快照；任何一步失败都给保守可用的默认值。"""
    cpu = os.cpu_count() or 2
    ram_gb = _ram_gb() or 4.0
    return {"cpu": cpu, "ram_gb": ram_gb, "gpu": _has_gpu()}


def _ram_gb() -> float | None:
    try:
        class MEMORYSTATUSEX(ctypes.Structure):
            _fields_ = [("dwLength", ctypes.c_ulong),
                        ("dwMemoryLoad", ctypes.c_ulong),
                        ("ullTotalPhys", ctypes.c_ulonglong),
                        ("ullAvailPhys", ctypes.c_ulonglong),
                        ("ullTotalPageFile", ctypes.c_ulonglong),
                        ("ullAvailPageFile", ctypes.c_ulonglong),
                        ("ullTotalVirtual", ctypes.c_ulonglong),
                        ("ullAvailVirtual", ctypes.c_ulonglong),
                        ("ullAvailExtendedVirtual", ctypes.c_ulonglong)]
        stat = MEMORYSTATUSEX()
        stat.dwLength = ctypes.sizeof(MEMORYSTATUSEX)
        ctypes.windll.kernel32.GlobalMemoryStatusEx(ctypes.byref(stat))
        return round(stat.ullTotalPhys / (1024 ** 3), 1)
    except Exception:                        # noqa: BLE001 - 非 Windows/失败保守
        return None


def _has_gpu() -> bool:
    nvidia_smi = shutil.which("nvidia-smi")
    if not nvidia_smi:
        return False
    try:
        proc = subprocess.run([nvidia_smi], capture_output=True, timeout=10)
        return proc.returncode == 0
    except (OSError, subprocess.SubprocessError):
        return False


def tier_of(cpu: int, ram_gb: float, gpu: bool) -> str:
    """规则：短板定档（单超多不补），高档要求双达标（12 核/32G 起步）。"""
    if cpu <= 4 or ram_gb <= 8:
        return "low"
    if cpu >= 12 and ram_gb >= 32:
        return "high"
    return "mid"


def detect(probe=None) -> tuple[str, dict]:
    """探测→定档→出该档运行参数（返回 (tier, settings) 副本）。"""
    info = (probe or probe_hardware)()
    tier = tier_of(info["cpu"], info["ram_gb"], info["gpu"])
    return tier, dict(TIER_SETTINGS[tier])
