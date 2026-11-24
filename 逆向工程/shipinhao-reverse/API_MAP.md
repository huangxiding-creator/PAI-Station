# 视频号后台逆向报告（finder-helper-web 全端点破解）

**标的**: 视频号助手后台 https://channels.weixin.qq.com/platform/*（SPA: `finder-helper-web`，托管 res.wx.qq.com CDN）
**日期**: 2026-11-24 → 2026-11-25 (v2 写操作+W1 直播链)
**方法**: 超级逆向四链 = SPA JS bundle 静态逆向（11 chunk 全量，4.3MB chunk-common 主件）+ 纯 HTTP 保险库 cookie 探针实证 + Workflow 四路提取+对抗核验（5 agent/50min）+ SPA store 在页实验 → CLI 复刻件 `sph.py`
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

## 四、v2 写操作协议（1125 用户令后实现，全链实测）

**关键定谳（300002 五连败破案）**：平台 scene=**7**（FinderAssistant=7，此前误用 1）；信封须含 `_log_finder_uin:""`/`rawKeyBuff:""`/`pluginSessionId:null`；请求 URL 带 `?_aid=<设备稳定uuid>&_rid=<每请求uuid>&_pageUrl=`；头带 `finger-print-device-id` + `X-WECHAT-UIN:<uin>`。

**发布全链（asyncClipPostSwitch=1 必走转码）**：
1. `helper/helper_upload_params` → {uin, appType:251, authKey, scene, videoFileType:20302, pictureFileType:20304, thumbFileType:20350}
2. dfs 分片上传（host=auth_data.envInfo.cdnHostList[0]=finderassistancea-e.video.qq.com）：
   - `PUT /applyuploaddfs` body {BlockSum, BlockPartLength:[累计末偏移]} → UploadID
   - `PUT /uploadpartdfs?PartNumber=N&UploadID=` octet-stream → {ETag, TransFlag:"0_0", X-Errno:0}
   - `POST /completepartuploaddfs?UploadID=` body {TransFlag:<分片应答原样字符串>, PartInfo:[{PartNumber,ETag}]} → DownloadURL（**布尔 TransFlag 会 404 -5103015！**）
   - 头：Authorization=authKey + X-Arguments="apptype=..&filetype=..&weixinnum=..&filekey=..&filesize=..&taskid=<uuid>&scene=.." + Content-MD5
3. `post/post_clip_video` {url,timeStart:0,cropDuration:0,width,height,...} → {clipKey, draftId}（**必走**，转码注册）
4. `post/post_clip_video_result` {clipKey, draftId}（轮询）→ {duration,width,height,md5,fileSize,url,vbitrate,vfps,flag:1}
5. `post/post_create` 平铺载荷：BO 默认{objectType:0,经纬度四件,originalFlag,topics}+{postFlag:0,isFullPost:1,handleFlag:2,**videoClipTaskId:draftId**}+traceInfo{traceKey,uploadCdnStart/End(**秒**!)}+objectDesc{mpTitle,description,mediaType:4,media:[{url=转码url,md5sum=转码md5,urlCdnTaskId=draftId,cardShowStyle:2,...}],topic:{finderTopicInfo:""},mentionedUser:[]} → errCode=0
6. 草稿：`post/post_draft` {postReq:<载荷>,objectId:null}（可免转码链，直传 url 即可）errCode=0
7. 预览：`post/post_preview` {postReq:<载荷>} → {ticket}（**手机 QR 预览票据，非在册作品**）
8. 删除：`post/post_delete` {objectId} → errCode=0；`post/del_draft` {objectId} → errCode=0
9. 可见性：`post/post_update_visible` {objectId, visibleType: 1公开/2关注/3仅自己}

**W1 直播链（1125 实测）**：
- `live/create_live_prepare` → **{liveObjectId, anchorStreamingUrl:"rtmp://push-m1.wxlivecdn.com/trtc_1400439699/", anchorStreamingKey:"live_...?txSecret=..."}** ——推流码纯 HTTP 直达（原判「需真实直播窗口抓包」解除）
- `live/close_live` {liveObjectId} → 0（准备态对象回收实测）
- `live/check_live_status` / `live/current_live_notice`（预约数按场景）/ `live/live_notice_list`（历史 738 条）/ `live/get_live_tag_list` / `live/get_live_recommend_config` 全通
- 预告创建（live_notice_operate 调用点参数）留 W2 挖

**纪律**：测试全部用自产 32KB 测试片；实测发布 2 条均即时删除（get_post_info 300800 确认不存在）；草稿实测存→删闭环；用户 13686 条真实内容与唯一真实草稿零触碰。

## 五、CI / 自动化接入

```bash
# 凭据: 保险库 JSON（S367 保活链每 6h 刷新）或 SPH_COOKIE 环境变量
export SPH_COOKIE="sessionid=xxx;wxuin=xxx"
python sph.py stat overview            # 计划任务/CI 直接调
python sph.py --json post list > posts.json   # 管道消费
python sph.py post upload-raw <file>          # 低层上传验证
python sph.py post draft <mp4> --title T --desc D      # 存草稿
python sph.py post preview <mp4> --title T             # 手机预览票据(QR)
python sph.py post publish <mp4> --title T --confirm   # 正式发布(全链转码)
python sph.py post delete <objectId> --confirm         # 删除
python sph.py live stream                              # 推流码(T-2h 窗口)
python sph.py live close <liveObjectId> --confirm      # 回收直播对象

# 会话失活时: 跑 S367 登录链刷新保险库
# F:/We-AIPO/.venv/Scripts/python.exe E:/AI-Station/WeVideo-AutoPub/s367_login.py
```

CLI 零第三方依赖（纯 urllib）+ ffmpeg（封面/时长探测）；Windows UTF-8 输出兜底。

## 六、纪律与边界

- 发布/删除已实现但全部 --confirm 门；测试片自产自删；删除红线（对既有内容自主删除）从未越过
- cookie 来自在役保险库；写协议经 Workflow 四路提取+对抗核验（5 agent）+ SPA store 在页实验双重定谳
- rawKeyBuff 场景限制（单号绑定不下发）已在案：comment/feed_list、menu/get_menu_info、auth_plugin_session、statistic/post_detail 四端点留多主体场景解锁
