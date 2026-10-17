# engine_stage — 引擎 voice_feedback.py 规范备份（防 stage 回滚丢代码）

- 真源：`data/state/qw_deploy_stage_1007/qianwen_engine/voice_feedback.py`（gitignored）
- 本目录：git 追踪的逐字节备份。stage 被任何会话回滚/覆盖后，从这里 `cp` 回去再部署即可。
- 事故记录：2026-10-17 17:25 某部署线把 stage 回滚到 09:30 原版（两个致命 bug）打到 050，
  线上评分腿 500 中断；本备份即恢复所据最终版（含统计端点+chips 便捷标签）。
- 纪律：改 stage 的 voice_feedback.py 后必须同步 `cp` 到本目录并 commit。
