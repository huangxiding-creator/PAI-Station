# -*- coding: utf-8 -*-
"""wxrpa — 个人微信 PC 客户端精简 RPA 引擎（总包私域运营台 wx-rpa worker 的核心）。

架构复刻自识流 AI 助手逆向结论（见 逆向工程/识流AI助手-逆向分析报告.md）：
  感知（截图+本地OCR+像素diff） → 决策（调用方） → 拟人输入（贝塞尔/剪贴板协议） → 行动后验证（新气泡+时间戳）

安全边界（硬编码，见 ARCHITECTURE.md §5.7 "永不做"清单）：
  - 不自动点赞/评论/发布朋友圈（能力不存在）
  - 不加好友、不群发陌生人
  - 夜间静默（可配置）、可一键熔断
"""
__version__ = "0.1.0"

from . import wxwin, perceive, human_input, navigate, verify, guardrail  # noqa: F401
