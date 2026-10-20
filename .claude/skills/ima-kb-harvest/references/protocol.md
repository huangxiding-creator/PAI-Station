# IMA 协议参考（逆向实锤，改代码前必读）

来源：IMA批量下载助手.exe v1.7.1 逆向 + ima.qq.com web bundle 对照 + 实测验证（2026-10-19）。
完整报告：`E:\AI-Station\逆向工程\IMA下载助手\README.md`

## 认证

```
微信扫码: open.weixin.qq.com/connect/qrconnect
  params: appid=wx0d63f5de059f1d52, scope=snsapi_login,
          redirect_uri=https://ima.qq.com/login/#/qr-code-scanned/, login_type=jssdk,
          self_redirect=true, style=dark, stylelite=1
  → 正则 /connect/qrcode/([^"]+) 取 uuid → 二维码 open.weixin.qq.com/connect/qrcode/{uuid}
轮询: lp.open.weixin.qq.com/connect/l/qrconnect?uuid=…
  → window.wx_errcode=(\d+) / window.wx_code='([^']*)'
  405=成功(拿code) 404=已扫待确认 403=拒绝 402=过期（长轮询hold约25-35s，timeout要≥35）
IMA登录: POST https://ima.qq.com/cgi-bin/auth_login/login
  body: {account_type:2, code:<wx_code>, auth_appid:"wx0d63f5de059f1d52",
         client_info:{guid:"guid-ca2055bffb9236ba0dea970403000002519701",
                      platform:4, qimei36:"ca2055bffb9236ba0dea970403000002519701"}}
  resp: {code:0, token, refresh_token, user_id, token_valid_time:7200,
         refresh_token_valid_time:2592000}
刷新: POST /cgi-bin/auth_login/refresh
  body: {user_id, refresh_token, token_type:14}   ← 数字14！
bkn: hash=5381; for c in token: hash += (hash<<5)+ord(c); return hash & 0x7FFFFFFF
```

## 请求头（iOS 客户端态）

```
Accept: */*  Content-Type: application/json  From_browser_ima: 1
X-Ima-Bkn: <bkn>  X-Ima-Cookie: <完整串>
User-Agent: ima/4032 CFNetwork/3860.300.31 Darwin/25.2.0
Cookie 七字段: IMA-GUID / IMA-Q36（设备指纹，全用户共享硬编码）/
  IMA-UID / IMA-TOKEN / UID-TYPE=2 / CLIENT-TYPE=256002 / APP-VERSION=2.2.4.4069 /
  IMA-TOKEN-TYPE=idcTokenImatokenBindSocial /
  IMA-IUA=PR=IMA&PP=com.tencent.imaios&PPVN=2.2.4.4069&PL=IOS&RL=440.0*956.0&MO=iPhone18,2&OS=18.2&DN=iPhone18,2
```

注意：**iOS 头走 `knowledge_tab_reader` 模块**；web（H5 cookie, CLIENT-TYPE=256052）走 `knowledge` 模块。路径不通用。

## 端点表（全部 POST https://ima.qq.com/cgi-bin/…）

| 端点 | body | 响应要点 |
|---|---|---|
| knowledge_tab_reader/get_knowledge_base_list | {type:1, limit:49} 平铺勿包params | results[] |
| knowledge_tab_reader/search_knowledge_base | {query, limit:10, cursor:""} | searched_knowledge_bases[].id |
| knowledge_tab_reader/get_knowledge_list | {limit:30, knowledge_base_id, folder_id, cursor} | knowledge_list/next_cursor/is_end/total_size |
| knowledge_tab_reader/search_knowledge | {cursor,query,knowledge_base_id,compared_knowledge_base_id:<同kb>,policy:"",forbid_default_cover:false} | searched_knowledge_list |
| knowledge_tab_reader/get_tag_view | {knowledge_base_id, cursor, limit} | |
| knowledge_member/join_knowledge | {knowledge_base_id} | need_review:false=免审 |
| file_manager/get_media | {media_id, knowledge_base_id} | jump_url_info{url,headers}；null=无权/付费 |
| knowledge_share_get/get_share_know_doc | {docid,knowledge_id,op:{op_attach,op_basic,op_content,op_resource:true,disable_cover:false}} | doc_info.content_info.content |
| report_svr/get_task_report | {report_id, knowledge_base_id} | format_answer.block_list |

## 关键语义

- **文件夹**：media_type=99，其可用的 folder_id = 条目 `media_id`（`folder_` 前缀）；`folder_id` 字段常为空
- **media_type 分发**：11+笔记→get_share_know_doc→.md；2+"ima 报告"→get_task_report→.html；2+网址/腾讯新闻、6+公众号→链接台账；1等→get_media 直下
- **下载权**：加入库后 role_type 0→1 才放行 get_media；付费库（kb_payment_info 非空）仍拒 —— 官方付费墙，不绕
- **分页**：next_cursor base64，前8字节大端 int 为游标；is_end 终止
- **下载CDN**：jump_url_info.url（\u0026 要还原 &），用 jump_url_info.headers 直 GET
- **风控**：随机延迟 + 并发≤8； UA 保持 iOS 客户端态勿改

## 文件位置

- 复刻客户端: scripts/ima_replica.py（ImaClient: login/ensure_token/api/search_kb_plaza/join_kb/get_all_files_recursive/download_media）
- 收割编排: scripts/harvest.py（status/login/search/harvest/dedup）
- 凭证: scripts/credentials.json（敏感）
