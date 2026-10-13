# REQUIREMENTS — zongbao-ai-v0917（总包AI顾问 0.9.17 迭代）

范围=用户两令（VISION 非目标章节为准）；全部 EARS 形态。

## 分享全量启用

- **REQ-001 [MUST] 当用户在任一页面打开右上角胶囊菜单时，系统应使「转发给朋友」可用（10 页全量定义 onShareAppMessage，品牌化标题+页面路径）**
  全部 10 个页面（ask/home/my/answer/report/research/zhiku/pot/invoice/legal）
  均定义 `onShareAppMessage`，返回品牌化标题与页面路径。
  - REQ-001.AC1 10 页 js 逐一含 onShareAppMessage（BOOT-SIM 逐页锚）。
  - REQ-001.AC2 转发 path 逐页枚举：ask/home/my/invoice/legal → `/pages/ask/ask`
    （主入口；home 非 tab 页，tabBar=ask/pot/zhiku/research/my）；report →
    `report?sku=`、answer → `answer?id=` 携自身参数；research/zhiku/pot → 各自
    页面路径不带参。
  - REQ-001.AC3 分享标题=过审品牌形态闭集（「总包AI顾问-…」/「总包研究 · …」/
    「总包智库 · …」zhiku 在役先例）；诱导词红线扫描范围=onShareAppMessage/
    onShareTimeline 返回值字符串字面量（禁「分享…赠/得/送/加」类承诺，不扫
    非分享文案如「有用 +1次」）。

- **REQ-002 [MUST] 当页面已定义 onShareAppMessage 时，系统应同页成对定义 onShareTimeline 使「分享到朋友圈」可用（官方两步门槛）**
  - REQ-002.AC1 10 页均含 onShareTimeline（BOOT-SIM 逐页锚）。
  - REQ-002.AC2 内容型自洽页（report/answer）query 携最小参数；其余页不携参。
  - REQ-002.AC3 无「点击打开小程序查看完整内容」类诱导文案（官方单页模式
    注意事项+运营规范红线，BOOT-SIM 全 js 扫荡锚）。

- **REQ-003 [MUST] 当朋友圈单页模式（场景值 1154，无登录态）打开任意已分享页面时，系统应不抛未捕获错误并按既有 fail-open 骨架呈现**
  控制台零 error，按既有 fail-open 骨架呈现。
  - REQ-003.AC1 e2e 冷启动直达 report?sku=CNNC-EPC 零异常零 console error。
  - REQ-003.AC2 e2e 先经 dev 登录链创建一条答案取得 aid，再以无登录态冷启动直达
    answer?id=<该 aid> 零异常（观看者门 404 降级路径，fixture 由 e2e 自建非占位）。

## 咨询记录删除

- **REQ-004 [MUST] 当已登录 owner 请求 DELETE /api/answers/{aid} 时，系统应软删（deleted=1）返回 {deleted:true}；非 owner/未知=404；无鉴权=401**
  owner 判定=行 openid 与 Bearer 解析 openid 一致。
  - REQ-004.AC1 pytest 本人删除→200；二次删除幂等 200。
  - REQ-004.AC2 pytest 他人删（用户B）→404；未知 aid→404；无鉴权→401。
  - REQ-004.AC3 pytest 删除后 history/history_all 均不含该行；
    get_answer/get_answer_visible 对该 aid 均 None/404。

- **REQ-005 [MUST] 当记录被软删时，系统应保持 pay_log、rewards、quota 全零变化**
  - REQ-005.AC1 pytest 删除前后 quota_left 相等、pay_log 行数相等、
    reward_exists 判定不变。

- **REQ-006 [MUST] 当用户在「我的」页记录行右侧删除钮点删并确认时，系统应乐观移除该行（qw-pop 确认；失败回滚+toast；静默重拉兜底）**
  确认弹窗固定文案「删除后不可恢复」。
  - REQ-006.AC1 e2e 真点：hist-item 右侧删除钮 → 确认弹窗（自绘 qw-pop，
    禁原生 showModal）→ 列表长度 -1；删至 0 条时空态呈现。
  - REQ-006.AC2 遥测 record_delete_tap / record_delete_ok 事件可于
    /api/telemetry/recent 查得（事件名过引擎 shape 门，无需引擎改动）。
  - REQ-006.AC3 删除后重新拉取 history，列表与服务端一致（无幽灵行）。


- **REQ-009 [MUST] 当用户在咨询页输入框输入/修改问题且未点「免费咨询」按钮时，系统应绝不发送咨询请求，且输入法键盘应保持展开（不被强制收起）**
  - REQ-009.AC1 onInput 不再每键 setData question/qFocus（受控值环=真机 IME 组合态被打断
    →键盘收起的根因）；输入值存页面实例字段，value 绑定仅程序化回填时变化。
  - REQ-009.AC2 qFocus 复位移至 bindfocus（聚焦达成即复位，空点重聚焦语义保留）。
  - REQ-009.AC3 发送唯一入口=onSubmit（免费咨询按钮）；onClear/_fill/onOptimize 同步
    实例字段与 data.question（清空/回填仍生效）。
  - REQ-009.AC4 BOOT-SIM 锚：onInput 块不含 question:/qFocus: 的 setData；
    wxml textarea 带 bindfocus；e2e 打字流零键盘收起（数据面：连续 input 事件
    qFocus 不翻转）。

## 交付链

- **REQ-007 [MUST] 当引擎含 deleted 列迁移部署时，系统应双方言幂等升级且生产健康（四点同步+TCB normal+health ok）**
  - REQ-007.AC1 store.py 两处 CREATE TABLE + _ANSWER_UPGRADES +
    scripts/mysql_schema.sql 四点同步（pytest 源结构断言——引擎线静态锚）。
  - REQ-007.AC2 TCB 部署 normal+HasTraffic；生产 /api/health ok；
    /api/history 冒烟正常。

- **REQ-008 [MUST] 当 REQ-001..007 全部 AC 绿时，系统应完成 0.9.18 robot 上传与提审（六段向导、不加急、只一次；基线=0.9.17 已发布，审核位空）**
  当 REQ-001..007 全部 AC 绿时，系统应完成 0.9.17 robot 上传与提审
  （六段向导、不加急、只一次）。
  - REQ-008.AC1 三线全绿（pytest/BOOT-SIM/e2e）计数在案。
  - REQ-008.AC2 UPLOAD_OK（robot 轮转）+ getcodepage 0.9.18 行=审核中。
  - REQ-008.AC3 提审前置：getcodepage 复核线上=0.9.17 且审核位空
    （1013 实况：无在审版本，无撤审风险；若状态有变则等出结果再提）。

## 溯源

- REQ-001/002/003 ← 用户令①（截图灰按钮+「每一个页面都可以」）
- REQ-004/005/006 ← 用户令②（咨询记录删除）
- REQ-007/008 ← 用户令（部署腾讯云托管+提审）+ 项目铁律
- REQ-009 ← 用户令（1013：未点按钮不发送+键盘不被强制最小化——受控输入框根因）
- 页面数口径：10 = app.json 现全集（tabBar=ask/pot/zhiku/research/my，home 非
  tab）；新增页面随规则继承，无须新 REQ。
