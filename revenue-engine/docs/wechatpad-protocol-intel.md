# WeChatPadPro 协议情报档案（事实级，tier-① 源码阅读产物）

> 2026-10-14。来源=LangBot master 内嵌客户端源码（Apache-2.0，本地副本
> _tmp_verify_langbot/）+ WeChatPadPro 公开 README/Swagger + issue 区一手报告。
> 边界：WeChatPadPro 本体无 LICENSE——本档案只汇编公开接口事实，不涉其代码，
> 不构成对其内部实现的还原。用途：T-041 存活实验设计 / 存活监控探针 / 稳定性排障。

## 1. 认证流（三段式）

```
ADMIN_KEY(部署环境变量, :8848 管理面)
   └─POST /admin/GenAuthKey1 {Count:1, Days:365} → 普通token列表
        └─POST /login/GetLoginQrCodeNew {Check, Proxy} → 二维码URL(手机扫码)
             └─POST /login/GetLoginStatus 轮询 → 已登录(手机确认"iPad在线")
                  └─POST /login/WakeUpLogin {Check, Proxy} → 掉线唤醒(免扫码)
POST /login/LogOut → 主动退出
```

- token 失效判定：GetLoginStatus 返回 `Code==300 且 Text=='你已退出微信'`（login.py）
- **异地警告**：GetLoginQrCodeNew/WakeUpLogin 带 Proxy 字段——issue 实证「无 Socks5
  代理或本地服务器慎用」；**登录地与常用地不一致本身就是风控因子**（T-041 实验须固定网络出口**

## 2. 消息面 API（token 鉴权，HTTP POST JSON）

| 端点 | 用途 | 关键字段 |
|---|---|---|
| /message/SendTextMessage | 发文本 | MsgItem[]{AtWxIDList, MsgType:0, TextContent, ToUserName}——ToUserName=群id(xxx@chatroom)即群发；ats=['notify@all']=@全体 |
| /message/SendImageMessage | 发图 | ImageContent=URL |
| 表情/语音/APP 消息 | handler_map 同构 | emoji_md5 / voice_data / app_msg |
| /group/GetChatroomMemberDetail | 群成员详情 | {ChatRoomName}→Data.member_data.chatroom_member_list[](user_name/nick_name) |

## 3. 收消息：WS 回调（非轮询）

- LangBot 以 websocket.WebSocketApp 连 wechatpad_ws 地址（部署配置项），服务端推
  JSON → `_schedule_ws_message` 投递事件循环 → event_converter 转统一事件
- 群消息判定：from_user_name 后缀 `@chatroom`（wechatpad.py L471-473）
- 发送侧并发保护：`_MAX_CALLBACK_FUTURES` 上限+锁（L661-679）；HTTP 响应读取
  上限 16MB（http_util.py，分块读+Content-Length 预检）——**服务端可能返回超大包是
  已知风险面**，LangBot 已加固，自研探针须同等设限

## 4. 存活实验（T-041）设计输入

1. 采集面：GetLoginStatus 轮询（建议 30min 一次）+ WS 断连事件 = 「在线率」双源
2. 风控征兆分级：①WS 频繁断连 ②WakeUpLogin 失败 ③GetLoginStatus Code!=200
   ④手机端弹「环境异常」——③④=风控异常级（触发 REQ-021 双栈同停口径）
3. issue #67 实证：被拉群（未主动）也会掉线封号——**实验期禁止拉小号进任何重要群**，
   只进测试群
4. 出口固定：小号注册地/常用地=实验机所在地，否则配 Socks5（Proxy 字段）

## 5. 已知不稳定面（issue 区一手）

- 封号 4 案：#18/#67/#126/#167（多为「登录环境异常」类）
- 协议随微信版本漂移：仓库 2026-08 后 push 间隔变长，存活实验期间锁定当前 digest

## 6. 后续逆向项（用户令「继续逆向」排程）

| 项 | 价值 | 前置 |
|---|---|---|
| WeChatPadPro docker 镜像静态分析（层剥+字符串/端点盘点） | 验证其行为与文档口径一致；识别遥测/心跳参数 | 镜像拉取（让路令期间未拉，需网络窗口+用户点头；层级②只读分析） |
| 识流拟人引擎参数复核 | 输入节奏参数已提取（既有报告），无需重做 | 无 |
| wxautox v4 行为对照 | UIA 路线参数对照（购买授权后合法使用，非逆向） | 购买决定 |
