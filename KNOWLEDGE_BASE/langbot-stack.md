# A 栈：LangBot + WeChatPadPro（部署与配置手册要点）

> 证据基线：2026-10-14 对抗验证（api.github.com + 源码行号）。Read if：部署/配置/排障 A 栈，或写限频插件。

## 组件

- LangBot 18,147★ Apache-2.0（默认分支 master，非 main）
- WeChatPadPro 2,642★ 无LICENSE（风险件，存活门前置，可弃）

## 部署

1. WeChatPadPro：`deploy/docker-compose.yml` 三服务（wechatpadpro + mysql:8.0 + redis:6），
   ADMIN_KEY 环境变量；管理界面 :8848（/login/GenAuthKey2?key=ADMIN_KEY）
2. LangBot：仓库自带 Docker；WebUI 建机器人填 wechatpad_key(=adminKey)/wechatpad_url/
   wechatpad_ws/wxid/wechatpad_token
3. 登录：Swagger → GenAuthKey1（days=365）→ GetLoginQrCodeNew 扫码 → 手机确认 iPad 在线
4. LangBot→WeChatPadPro 换 token：sources/wechatpad.py L729/742（/admin/GenAuthKey1）

## 限频配置（入站侧）

- 配置路径：pipeline 的 `safety.rate-limit`：window-length / limitation / strategy(drop|wait)
- 默认 60s/60 次；目标配置 **86400 秒 / 3 次 = 同群日 3 条被动回复**
- 证据：templates/metadata/pipeline/safety.yaml L41-75；algos/fixedwin.py L104-125
- ⚠️ 分组键含 pipeline_uuid（fixedwin.py L54-64）：同群配多条流水线配额放大——
  **每群只配一条启用限频的流水线**
- ⚠️ 这是入站限速器（ratelimit.py 位于 MessageProcessor 之前）：不约束主动/定时推送

## 群能力证据

- 群收：sources/wechatpad.py L471-473（@chatroom 判定）、L509-525（GroupMessage 构造）
- 群发：L628-630（send_text_message + @列表/@全体）；libs/wechatpad_api/api/message.py L21+
- 群成员：chatroom.py /group/GetChatroomMemberDetail

## 插件（全局日 20 的宿主）

- 体系：src/langbot/pkg/plugin/ + .lbpkg 包格式 + alembic 0025_bot_plugin_processors
- 未验证点：能否挂统一发送出口（被动+主动一起计数）；计数器重启是否清零；
  与 fixwin 的双计避免——**实现前先做挂载点实验**

## 已知风险

- 封号 4 案（WeChatPadPro issues #18/#67/#126/#167；#67 被动被拉群都掉线封号）
- LangBot 作者对个微通道的原话：「有。建议用小号」（langbot issue #1096）
- 协议随微信版本漂移；无 LICENSE=默认保留权利（只用不改不分发）
