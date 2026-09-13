"""M6.1 硬件分级探测器+三档配置映射：低配机器也能跑（普适性红线）。"""
import pytest

from paistation.dist.tiers import tier_of, TIER_SETTINGS, detect


def test_tier_rules():
    assert tier_of(cpu=4, ram_gb=8, gpu=False) == "low"
    assert tier_of(cpu=8, ram_gb=16, gpu=False) == "mid"
    assert tier_of(cpu=16, ram_gb=64, gpu=True) == "high"
    # 边界：单超多不补——CPU 弱内存大仍是 low（防小马拉大车）
    assert tier_of(cpu=2, ram_gb=32, gpu=True) == "low"


def test_tier_settings_monotonic():
    """档位越高配置越放开：workers 递增、深读默认逐步打开。"""
    assert TIER_SETTINGS["low"]["workers"] <= TIER_SETTINGS["mid"]["workers"] \
        <= TIER_SETTINGS["high"]["workers"]
    assert TIER_SETTINGS["low"]["deepread"] is False   # 低配先关深读保命
    assert TIER_SETTINGS["high"]["deepread"] is True
    # 高配才上 bge-m3；低中配零依赖 hashing 兜底（基本零成本红线）
    assert TIER_SETTINGS["low"]["embedder"] == "hashing"
    assert TIER_SETTINGS["high"]["embedder"] == "bge-m3"


def test_detect_with_injected_probe():
    def fake_probe():
        return {"cpu": 6, "ram_gb": 12, "gpu": False}
    tier, settings = detect(probe=fake_probe)
    assert tier == "mid"
    assert settings["workers"] >= 2


def test_detect_real_machine():
    """真机探测不炸（任何 Windows 笔记本都有答案）。"""
    tier, settings = detect()
    assert tier in ("low", "mid", "high")
    assert "embedder" in settings
