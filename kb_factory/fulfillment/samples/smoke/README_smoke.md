# W7 冒烟样例（真实运行证据）

生成器：`py -3 -X utf8 kb_factory/fulfillment/samples/smoke/_make_fixtures.py`
（自建 tmp 语料 + 迷你蓝图 8 槽 + 假订单 SMOKE-1022-001，全部落本目录）

冒烟运行（与 `py -3 -m kb_factory.fulfillment --once` 同路，环境三件套见脚本头注释）：

```
py -3 -X utf8 kb_factory/fulfillment/samples/smoke/_run_smoke.py
```

- KB_LOCAL_CORPUS → samples/smoke/corpus（本地绿源语料覆盖）
- KB_WECOM_NOTIFY=0 → 冒烟不触发真企微通知
- KB_SMTP_SECRET → 不存在路径（演示 SMTP 缺配→wecom_fallback 降级分支）

结果（2026-10-22 实跑）：8 槽 / 4 交付（绿源真实复制）/ 4 进获取指引清单；
订单 inbox→done（rename 非删除）；ledger.jsonl 留痕；zip 镜像树根名=知识库名。
