# 新源接入指南（W3.3）——目标 ≤1h/源

## 五步（bus/contract 零改动，开闭原则）
1. **定位真身**: 找到数据落点位（文件/CLI/API），取样 2-3 行确认字段结构
   （数字零造假：结构以上游实测为准，不臆造字段）
2. **写适配器**: 复制 `signals/adapters/_template.py` → `<source>.py`，
   覆写 source_type / discover / normalize 三件；evidence 带上游稳定唯一键
3. **注册**: `signals/adapters/__init__.py` 的 ADAPTERS 加一行
4. **契约测试**: 复制任一 `tests/test_*_adapter.py`（~80行），离线层=
   实测结构fixture→六字段契约→运行唯一键幂等→坏行拒收；--live层=真源入主账本
5. **计时落账**: run-ledger 记 `new_source_added`（源名+起止+分钟数）

## 三坑（1023 五源实录）
- 测试 TriAdapter 样本必须**运行唯一键**（时间戳入id/rev/text），否则重跑
  全 dup 断言炸（W3.2b 已踩，五源复刻时又踩一遍）
- 上游重复行是常态（sensing 12657→389 唯一 / 台账 322→27）：dedup 交给 bus，
  discover 不去重
- 引擎/API 源离线测试绝不碰网：fixture 打桩，--live 才实弹

## 计时基线（1023 实测，含五源共用侦察）
- 第3源起计: 5 源（moments/demand_ledger/topic_radar/revision_flywheel/
  refund_score）合计 ~40min ≈ 8min/源（远低于 1h/源门）
- 首两源（viaim/wechat_insight）为范式探路，不计入门

## 拉取
```
py -X utf8 -m signals.bus --pull                    # 全部注册源
py -X utf8 -m signals.bus --pull --adapter moments  # 单源
py -X utf8 -m signals.bus --read --source moments   # 读账
```
