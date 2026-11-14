# EVOLUTION_REPORT — zongbao-ai-v0917（经验固化）

## 入账 playbook（复利元则 C0）

本轮新增可复用判断（已/ss playbook 或 KNOWLEDGE_BASE 固化）：

1. **受控输入框=真机 IME 杀手**：value 绑定+每键 setData 在真机（含 Windows 端）打断
   输入法组合态→键盘收起→布局回弹误触主 CTA。解=实例字段存值+bindfocus 复位+统一
   取口（REQ-009 全案在 ask.js 注释与 KB）。
2. **automator 组件穿界选择器**：自定义组件内部元素=组件元素内 `comp.$('.cls')` 或
   `#组件id >>> .cls`（tag 形式不认）；合成 tap() 不携带 dataset——e2e 需真值兜底腿。
3. **worker worktree 生存术**：断点抢救（半成品 worktree 直续）；验证须把改动文件
   LF 同步回主树（bootsim ROOT 硬编码）；共享文件改动先读全部消费方。
4. **平台单页模式铁则**（官方文档实拉）：朋友圈亮灯两步门槛、无登录态、纯内容页
   定位、禁「打开小程序查看完整内容」类诱导——全源扫荡锚已在役。
5. **提交键真身=A.btn.btn_primary**（三次实证）——已根治进 0918 向导本体。

## KB 新增

- KNOWLEDGE_BASE/share-semantics.md（官方分享语义+单页模式+落地决策）
- KNOWLEDGE_BASE/soft-delete-design.md（五门可见性+账务隔离+pending 裁定）

## 流程判定

Super-Skill V5 十二段全走（含双人工触点：需求批准 1 次+授权 2 次）对成熟产品的
增量迭代偏重（P0-P3 对本轮贡献有限），但按用户令「不跳过任何一个环节」执行完毕；
判定：增量迭代可从 P4 起跳（引擎 init --from P4），全流程保留给新产品线。

## 下轮候选（非承诺）

- my 页 deleteBusy 守卫（judge low 遗留）
- 分享卡片 imageUrl 定制（朋友圈转化优化，数据驱动再议）
