# 引擎周期任务（每轮 claude -p 读我）
1. 读 CLAUDE.md（章程红线）+ consensus.md（接力棒）+ ledger/run-ledger.jsonl 尾20行（近况）
2. 从 tasks.md 选最高优先级未完成任务（一次只做一个，串行全链纪律）
3. 按 super-skill 14相执行该任务；遇审批闸→tools/notify_approval_wecom.py 通知后停轮等批
4. 完成后：更新 consensus.md（传棒）+ 追加 run-ledger + 有产出则走发布链
5. 额度紧张迹象（报错429/限额）→ `py -X utf8 organ_probe.py --organ zqg --summary` 读护盾器官状态（器官层W2.2），优先护盾自理，勿硬烧
