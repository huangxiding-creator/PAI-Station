# -*- coding: utf-8 -*-
"""harvest_engine：收割层（CONTEXT 统一语言）——付费订单触发的下载层，全厂唯一可落盘处。

- 四段框架：adapters/base.DownloadAdapter（search/plan/fetch_ladder/verify，FR1.1）。
- 三级梯队：L1 协议直连 → L2 站内JS签名渲染 → L3 截图+OCR，逐级自动降级（FR1.2）。
- 收割台账：audit.HarvestAudit → harvest_audit.jsonl（每请求如实一行，数字零造假）。
- 铁律（ADR-5）：引擎只由付费订单触发；免费层元数据纪律不破（channel_adapters 仍零下载）。
"""
