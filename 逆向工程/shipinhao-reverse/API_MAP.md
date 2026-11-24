# 视频号后台逆向报告（finder-helper-web 全端点破解）

**标的**: 视频号助手后台 https://channels.weixin.qq.com/platform/*（SPA: `finder-helper-web`，托管 res.wx.qq.com CDN）
**日期**: 2026-11-24
**方法**: 超级逆向四链 = SPA JS bundle 静态逆向（11 chunk 全量，4.3MB chunk-common 主件）+ 纯 HTTP 保险库 cookie 探针实证 + 协议还原 → CLI 复刻件 `sph.py`
**账号实证**: 总包说（企业认证，42684 粉 / 13686 内容 / 985 场直播 / 448 单橱窗订单 / 25 合集）

---

## 一、协议结论（全部实测验证）

| 项 | 值 |
|---|---|
| API Base | `https://channels.weixin.qq.com/cgi-bin/mmfinderassistant-bin` |
| HTTP 方法 | 全部 **POST**（含查询类），JSON body |
| 认证 | Cookie 仅需 `sessionid` + `wxuin` 两枚（保险库 vault 快照即可） |
| CSRF | **不需要** XSRF-TOKEN / X-XSRF-TOKEN（实测带 cookie 即通） |
| 请求信封 | `{"timestamp":"<ms>","scene":1,"reqScene":1, ...业务参数}`（scene=1 = FinderAssistant） |
| 响应信封 | `{"errCode":0,"errMsg":"request successful","data":{...}}`；部分老域嵌套 `baseResp.errcode` |
| 头 | `X-Requested-With: XMLHttpRequest`、`Referer: .../platform/*`、Chrome UA |
| 前端枚举 | userpageType: 0全部/1合集/2生效合集/3评论台/4弹幕/5直播回放/6-7音频合集；scene: FinderAssistant=1, WxAdPlatform=5, FinderPromote=6 |
| 分页 | 混用三式: `pageSize/currentPage`（post_list, live history）、`count/lastBuff/continueFlag`（评论、私信）、纯信封（无参） |

## 二、实测验证矩阵

**探针 25 端点 → 22 个 errCode=0 全绿**（batch_results.json），4 个顽固端点缺 `rawKeyBuff`（见缺口节）。
**CLI 22 条命令全量实跑验证**（真实数据）：

- `whoami` ✓ 账号全量身份
- `post list` ✓ 13684 条全指标（objectId/exportId/赞评转藏读）
- `post drafts` ✓ / `post albums` ✓（总包生态圈 7 首）/ `post link` ✓ 短链
- `stat overview` ✓ 粉丝+互动时序 / `stat posts` ✓ 9 渠道×6 指标 / `stat fans-trend` ✓ 7 涨粉渠道 / `stat fans-portrait` ✓ 年龄画像
- `live history` ✓ 985 场+单场峰值/GMV / `live last` ✓ 标签封面
- `comment feeds` ✓ 评论台 / `comment list <exportId>` ✓（链式: 先 post_list 取 exportId）
- `msg sessions` / `msg new` ✓
- `shop status` ✓ / `shop products` ✓ 4 件真实书目价 / `shop orders` ✓ **448 条订单全量**
- `notify list` ✓ 未读计数 / `income detail` ✓ / `member` ✓ 1 管理+13 运营者
- `collection list` ✓ 25 合集 / `profile sections` ✓ 主页分区

## 三、端点全集（478 条，静态出土）

完整清单: `work/endpoints_grouped.txt`。分布: live 119 / shop 64 / post 53 / live-profile-form 42 / statistic 36 / vip 19 / certification 14 / comment 12 / private-msg 10 / auth 21 / member 5 / collection 2 / menu 4 / bullet-chat 5 / event 7 / original 6 / profile 2 / income 1 / notification 2 / active-auth 8 / component 9 / helper 9 + PAGE 路由 25（`/platform/*` 页面图）。

**核心已验证端点（CLI v1 在役）**:

```
auth/auth_data                    账号身份全量
post/post_list                    内容列表 (pageSize/currentPage/userpageType/onlyUnread/needAllCommentCount/forMcn)
post/get_draft_list               草稿
post/get_albums                   音频专辑
post/get_object_short_link        短链
statistic/get-finder-total-statics / post_total_data / new_post_total_data / fans_trend / fans_portrait
live/get_live_history             (pageSize/currentPage/count)
live/get_live_replay_list_v2 / get_last_live_info_v1
comment/comment_list              (lastBuff/exportId/commentSelection/forMcn)
private-msg/get-session-info / get-new-msg
shop/check_shop_window_status / get_all_window_products / get_commerce_order_list (page/count)
notification/notification_list    (unreadCount 可用, list 空)
income/get-my-finder-income-detail
member/member_list
collection/get_collection_list
profile/get_user_page_section_list
```

## 四、已知缺口（v2 待破）

1. **rawKeyBuff 端点 ×4**: `comment/feed_list`、`menu/get_menu_info`、`auth/auth_plugin_session`、`statistic/post_detail`。rawKeyBuff 由 `/auth/login_finder` 场景下发——**1124 动态定谳：本账号单号绑定，服务端不下发 buff**（login_finder data 空；浏览器 localStorage `finder_raw` 实测 len=0；仅多主体切换/广告 iframe 场景产生，对应 localStorage 键组 `finder_username/finder_uin/finder_raw/finder_login_token`）。此为账号场景限制，非工具缺口。
2. **上传/发布协议**: `helper/helper_upload_params`（返回 uin=fakeUin）→ 分片上传（`X-Errno`/`TransFlag` 应答标记）→ `post/post_create`。静态已定位分片协议骨架，CLI v2 按此实现 API 化发布（现发布走浏览器链 WeVideo-AutoPub）。
2. **上传/发布协议**: `helper/helper_upload_params`（返回 uin=fakeUin）→ 分片上传（`X-Errno`/`TransFlag` 应答标记）→ `post/post_create`。静态已定位分片协议骨架，CLI v2 按此实现 API 化发布（现发布走浏览器链 WeVideo-AutoPub）。
3. **写操作端点已静态出土未实现**（安全边界——删除/发布/上架/回复类一律等用户明示令）: `post/post_delete`, `post/del_draft`, `post/post_update_visible`, `comment/del_comment|set_top_comment|create_comment`, `private-msg/send-private-msg`, `shop/batch_op_window_product`, `live/close_live|set_live_switch`, `member/member_invite` 等。
4. `notification/notification_list` 的 list 恒空（unreadCount 正常）——列表内容走别的端点，未深挖。
5. `statistic/fans_portrait` 的日期范围参数未传（默认今日 1 点）；trend 类端点的时间窗参数名待动态捕获定谳。
6. `post/get_post_info {objectId}` 已验证（v1 `post get` 命令在役）。

## 五、CI / 自动化接入

```bash
# 凭据: 保险库 JSON（S367 保活链每 6h 刷新）或 SPH_COOKIE 环境变量
export SPH_COOKIE="sessionid=xxx;wxuin=xxx"
python sph.py stat overview            # 计划任务/CI 直接调
python sph.py --json post list > posts.json   # 管道消费

# 会话失活时（errCode=300xxx/登录跳转）: 跑 S367 登录链刷新保险库
# F:/We-AIPO/.venv/Scripts/python.exe E:/AI-Station/WeVideo-AutoPub/s367_login.py
```

CLI 零第三方依赖（纯 urllib），任何 python3 环境可跑；Windows 下已做 UTF-8 输出兜底。

## 六、纪律与边界

- 本报告与 CLI **全只读**；写端点仅静态编目未实现，发布/删除类操作永不自主执行（删除红线）
- cookie 来自在役保险库，未触碰 9222 在跑发布腿（纯 HTTP 与浏览器自动化完全解耦）
- 复刻件用途=自有账号后台运营自动化；已内建错误透传（errCode 非 0 即 SystemExit）
