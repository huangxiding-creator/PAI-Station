# v0.9.5 全量审查宪章（Super-Skill 全环节驱动 · 1009 用户令）

> 任务：对总包AI顾问小程序做不跳环节的全面审查、测试、优化改进，目标=所有功能 100% 完美运行。
> 方法：Super-Skill V4.1.16 十四阶段裁剪映射到存量产品审计（0-3=宪章/知识底座，
> 4=需求面，5=架构无漂移核验，6=工单分解，7=测试基建在役核验，8=修复执行，
> 9=QA 全电池+双轴评审，10=Ralph 收敛，11=部署上钉出码，12=教训沉淀）。

## 一、需求面（全部用户令 → 验收判据 → 在役测试）

### R1 咨询主流程（核心）
- R1.1 输入问题 → 跳答案页 → 流式生成（打字机+阶段播报+秒表）
  - 测试：e2e `real_ask`（settle: loading=false ∧ polling=false ∧ blocks>0）
- R1.2 每个按钮必有可见反馈（v0.9.4 用户令「点了没反应」根治）
  - 空问→toast+聚焦；短问→toast；iOS/不支持→中性 toast；支付失败→弹窗
  - 测试：e2e ask feedback ×4 + BOOT-SIM 结构门
- R1.3 追问（fuList）+ 要点速览 + 依据来源（citations 渲染一致性）
  - 测试：e2e followup ready + citations render-consistent + cite pop 开关

### R2 导出（收费线，iOS 铁律）
- R2.1 单篇导出 ¥0.1：未付→支付弹窗；已付→ActionSheet(Word/PDF/MD)；失败必弹窗不假死
- R2.2 批量导出：未解锁计数→一单付清；>99 条→引导弹窗；iOS 隐藏付费入口（payOk=false）
- R2.3 支付链 .catch 兜底 hideLoading（v0.9.4 假死根治）
  - 测试：BOOT-SIM 结构门 + e2e 导出真点活性（本轮新增）

### R3 报告商城（v0.9.0）
- R3.1 研究页目录 + 购买（虚拟支付四道具）+ 已购阅读 + 我的页书架入口
  - 测试：e2e report nav + my 书架 srv-row

### R4 发票（v0.9.4 用户令）
- R4.1 满 ¥200 门槛（GATE 态）+ 必填收票邮箱 + 企微推送 fail-open
  - 测试：e2e invoice gate + pytest test_invoice.py 9 用例

### R5 我的页信息架构（用户习惯）
- R5.1 高频在上（额度→记录），外观沉底（v0.9.4）；v0.9.5：报告/发票入口 srv-row 重设计
  - 测试：BOOT-SIM v0.9.5 五连门（441/441 在役）

### R6 合规（0.7.4 血泪）
- R6.1 AI 标识 12 位常驻 + 极限词清零 + 隐私四件套（含发票信息）+ UGC 双闸
  - 测试：BOOT-SIM 合规门族

### R7 主题
- R7.1 周换装+锁定+跟随星期；深色 obsidian 变量统一接管
  - 测试：e2e theme tap/auto

## 二、100% 完美的诚实口径
- 自动化可证：结构门（BOOT-SIM 441）+ 引擎（pytest）+ 真点（e2e 按钮矩阵）全绿
- 手机终审保留项：真实支付扣款、iOS 真机、深色模式实机——只有用户能验
- 版本信标：我的页底部 v0.9.5（旧实例缓存判定锚点）

## 三、双轴评审范围（Phase 9）
- 轴一 标准：命名/重复/死码/错误处理一致性/immutability
- 轴二 规范：上表 R1-R7 逐条对代码实证（不许 mock 骗绿）

## 四、修复批 B 收口台账（1009，24+6 findings 全闭环）
- M1-M5 / L1-L16 / L20-L21 / U3-U6：批A 已修（bootsim 同步断言）
- 批B 本轮：L17 隐私弹窗唯一出处(showPrivacyModal 单定义双调用) · L18 信任四数同源 utils/kbstats.js(ask/zhiku 双页接线,wxml 改绑定) · L22 errCount 死仪表删除 · L23 theme.apply 只推 themeStyle · L24 packOptions 忽略 v095-audit/.vscode · U1 refreshQuota 二连失败轻提示(_retriedOnce 门,首载静默) · U2 追问/有用在途视觉(fuSending/pill-busy)
- **L19（wxss hero 块去重）：评估后不抽取留档**——diff 实证四页已实质分叉（ask 块内挪位插入额度票根、research 持有额外 position:absolute、report 结构异构），仅 pot↔zhiku 规则级相同；中途抽 @import 的回归风险 > 去重收益，且各页「同 X 页语言」注释已标明耦合。判据：改 hero 语言须四页同步。
- 复验：BOOT-SIM 451/451（新增 8 门批B断言+4 门旧断言重锚）· pytest 94/94 · e2e 31/31（零异常零控制台错误）
