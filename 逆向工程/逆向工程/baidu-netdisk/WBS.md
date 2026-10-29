# WBS · BDPAN-FACTORY（super-skill P6 产物·项目本地化）
> 注：仓库根 .super-skill/ 归属 revenue-engine（P8 executing），本战役状态件全部项目本地化，不碰根工作区。

| 波 | 内容 | 出口门 | 状态 |
|---|---|---|---|
| W0 | 凭据迁移 vault→data/secrets/bdn_credentials.json；控制台宽权限应用核查 | 迁移完成+gitignore 验证 | ✅ 2026-10-29（控制台核查顺延 W2 触点） |
| W1 | PROTOCOL.md 规格书（证据分级 A/B/C/D）+ 只读活性普查（≤12 GET） | 分级覆盖率门 | ✅ 111 端点（A50/B31/C10/D20），9 发全绿，读面 rand 非强制实证 |
| W2 | 客户端 UI 会话恢复+写场景补抓（用户触点：扫码或授权代登） | 写侧端点入表；share/transfer/recycle 条件门定生死 | ⏸ 待 W3/W4 期间择机 |
| W3 | bdncore + bdn 骨架 + 8 只读命令（whoami/quota/ls/tree/search/meta/share-list/recycle-list） | 全命令 errno=0 实测绿 | ✅ 8/8 活体绿（ls/=17 对基线），34/34 离线，30 发预算内 → ss-judge 质检中 |
| W4 | 写命令+传输引擎（mkdir/rename/mv/cp/rm/upload/download）；首写=mkdir 冒烟+客户端交叉可见 | 验收门 1-5 | ✅ a-h 20/22 过（200MB 断点续传/下载 md5/rm 双确认全实证；诚实遗留=秒传 md5 混淆+filediff 冷启动）→ ss-judge 二审中 |
| W4.5 | go/no-go 中途复审（数字报告呈用户裁决） | 用户裁决 | ⏸ |
| W5 | bdn 独立技能 + mirror 备份链 + doctor 复验器 + 通道路由降级 | 降级切换实测绿 | ✅ 全过（judge KEEP 首次零返工）：doctor 8 针全绿零漂移；mirror 26/26→增量 0→只增不删代码级审计；分享旧代写面仍活（漂移账#15）；transfer 链至 bdstoken 门（errno=2 定位，形态实装待 1 发复测）；101/101 离线 |
| W6 | QA 总门 + Ralph×3 + 方法论沉淀 | 13+3 门终态报告 | ⏸ |
