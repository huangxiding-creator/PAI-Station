# S1-3 回炉环 + 降级 真工件冒烟 (2026-10-06)

验收判据: 坏 JSON 注入 — 回炉与降级路径各实测触发 ≥1 次。

| 案例 | 注入坏件 | CLI 结果 | 指纹 | 账本 |
|---|---|---|---|---|
| EPC50-rework | framework.json 尾逗号 `…,}` | mode=reworked rounds=1 校验错 0 | d5be60d7d8cf (与好件逐位同 — 零数据丢失) | framework:reworked |
| EPC50-degrade | 字节垃圾 `\x88\xff\x99 \x00 not-json` | mode=degraded rounds=2 校验错 0 | 61488750d999 (contracts.default_framework 三段兜底, warn 在) | framework:degraded |

- 战役 = EPC50-SNEI 批准链拷贝 (charter_accepted.json 同源, S0-3 门真接线)
- 命令: `python superline/framework_gen.py --battle-dir <战役> --check-framework`
- 修梯 (≤2 修复轮): r0 原样 utf-8 严格 → r1 清洗 (BOM/零宽/全角空格/控制符/尾逗号) 或编码转真 (utf-8 死→GBK) → r2 errors=replace 重读清洗; 全死 → 降级三段默认框架 (密度全 low 待侦察补据, 兜底件过 validate_framework 不悬空)
- 单测: tests/test_framework_gen.py::test_s13_rework_and_degrade_paths (回炉×2 + 降级 + clean + absent 五路)
