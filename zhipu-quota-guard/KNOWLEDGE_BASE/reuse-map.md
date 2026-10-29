# reuse-map — OSS 复用地图（Phase 2 结论，Agent-B 实证）

## 直接采用
| 零件 | 来源 | 许可证 | 用法 |
|---|---|---|---|
| 额度取数+解析 | opencode-glm-quota / lichong-a monitor 契约 | MIT | 端点+字段解析参考（自写薄客户端，Python） |
| 本地消耗速率 | ccusage（19138★） | MIT | 直接 `npx ccusage` 或借鉴其 JSONL 聚合逻辑（Python 直读更轻，v1 自读 JSONL） |
| 浏览器自动化 | DrissionPage 4.1.1.4@.venv | — | 官方 get/set.cookies 持久化范式 |
| 守护 | Windows 计划任务（原生） | — | 开机触发+崩溃自拉起；WinSW(MIT) 备选 |

## pattern 参考（不抄代码）
| pattern | 来源 | 原因 |
|---|---|---|
| reset 端点族 + cron + 账号间防风控延迟 | zcode-proxy | 无许可证 |
| 额度归一化/状态机/请求头 | zcode2api(309★) | AGPL-3.0 |
| 多账号额度展示+活动领取 | zcode-switch(410★) | MIT 但 Tauri/Rust 整件过重，取思路 |

## 自建清单（≈15-20%）
reset API glue / 决策引擎 / 企微通知编排 / 守护循环 / 面板 / 账本

## 裁决
adapt（≈85% 可复用）——无需发明任何协议或解析器；唯一空白=重置动作，走抓包。
