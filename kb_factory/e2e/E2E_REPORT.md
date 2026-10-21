# KB-FACTORY 全链 E2E 报告 · 20261022-072946

- 结论：全绿 ✓（assertion 16/16）
- 基线：git 177a6988a（worktree）· Python 3.13.1
- 元数据步：真网络真灌 —— 真灌 3 组 filled=30（请求 3 次）

## 步骤耗时

| 步骤 | 耗时(s) |
|---|---|
| ① 引擎生成蓝图（域=水利EPC） | 0.01 |
| ② wenku 元数据真灌 3 组（频控守卫） | 8.47 |
| ③ 落订单 JSON 入 tmp inbox（markdown+import_pack） | 0.0 |
| ④ subprocess fulfillment --once（KB_WECOM_NOTIFY=0） | 1.03 |
| ⑤ 全链断言 | 0.01 |
| 合计 | 9.52 |

## 断言清单

- ✓ ①蓝图生成 · root=水利EPC slots=1000
- ✓ ②元数据步完成（含降级如实注明） · 真灌 3 组 filled=30（请求 3 次）
- ✓ ②真网络预算 ≤10 请求 · 实测 3 请求
- ✓ ③订单落地 · version=markdown+import_pack email=test@example.com
- ✓ ④CLI rc=0 · rc=0
- ✓ ⑤原包 zip 在
- ✓ ⑤MD 版 zip 在（双产物之一）
- ✓ ⑤导入包 zip 在（双产物之二，与原包并列 outbox）
- ✓ ⑤转换报告存在
- ✓ ⑤manifest.versions 记录三版本 · selection=markdown+import_pack counts={'original': 117, 'markdown': 117, 'import_pack': 119}
- ✓ ⑤获取指引清单存在（包内）
- ✓ ⑤原包 zip 含获取指引清单+manifest
- ✓ ⑤绿源真交付（种入文件已 copy 入包） · delivered=16 planted=EPC专题研究_core_001.pdf
- ✓ ⑤ledger result∈{ok,ok_wecom_fallback,degraded_not_delivered} · degraded_not_delivered
- ✓ ⑤ledger versions 记录
- ✓ ⑤订单箱收口（inbox→done）

## 产物位置

- 产线目录：`E:\AI-Station\.claude\worktrees\agent-a5c6f05898c1f6bee\kb_factory\e2e\tmp\20261022-072946`（tmp，不清理不删除）
- 原包：`outbox/E2E-20261022-072946.zip`；MD 版：`outbox/E2E-20261022-072946_md(.zip)`；导入包：`outbox/水利EPC_import_pack.zip`

## 降级注记

- 无降级：真网络真灌全程贯通。
