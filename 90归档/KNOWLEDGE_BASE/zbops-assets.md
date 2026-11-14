# B 栈：zbops 资产地图（文件:行号实证基线 2026-10-14）

> Read if：改 B 栈（队列/proactive/8440 入口），或接 wxrpa/rion-cli。根目录 E:\AI-Station\私域运营\zbops\

## auto_responder（发送队列=安全网核心）

- 位置：zbops/radar/auto_responder.py
- 参数（L30-37）：MAX_PER_CHAT_DAILY=3（同群日上限）/ MAX_GLOBAL_DAILY=20（全局日上限）/
  CHAT_COOLDOWN=30*60s（同群冷却）/ 营业时间 8-21 点 / 群间隔 60-180s / md5 前 50 字符内容去重
- 熔断（L87-116）：report_risk_signal 触发 → 分级响应 → queue.clear()
- enqueue 为进程内方法（L82）——HTTP 化后队列/计数器进程归属需设计
- 发送腿：_send_via_wxrpa（L166-195）→ from wxrpa import wxwin, navigate, human_input
  → Ctrl+V/Ctrl+Enter 进个人微信桌面客户端（WXRPA_PATH=e:\AI-Station\私域运营\wxrpa）

## proactive（每日主动服务）

- 位置：zbops/radar/proactive.py
- 每日 9:00-10:00 循环（L108-121）+ 当日已推去重
- 热词腿：rion-cli 拉群消息关键词（L163-179）
- 群画像标签匹配（L139-157）→ responder.enqueue(priority=3)
- 内容钩子库：L93-100 五领域（可直接注入 LangBot prompt 复用）
- 内容源：L43 直读 F:\We-AIPO\data\state\channels_publish_detail.json（自产 JSON 准源）

## 企微侧

- aibot：WS 客户端订阅-回调模式（wss://openws.work.weixin.qq.com），仅处理
  aibot_msg_callback/aibot_event_callback 被动回复——无主动群发 API
- 主动推送出路口：responder 队列（个微腿）或企微群 webhook（HTTP 零开发）

## 8440 缺口（Phase 1 要补）

- main.py L264-276 仅 selftest/run/monitor/both 四子命令；callback 子命令只存在于文档串
- 要补：FastAPI 服务入口 + POST /enqueue 路由（鉴权）+ 队列进程归属设计
- 注意：消息指令 `py -I 私域运营/zbops/main.py selftest` 为 P7 test_cmd

## 既有信号资产

- SignalDetector / OpportunityEvaluator（zbops/radar/）——商机识别已有骨架
- rion-cli（wechat-cli skill）：本地 DB 直读 100 群消息
