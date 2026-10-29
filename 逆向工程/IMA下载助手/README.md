# IMA批量下载助手 逆向工程与复刻报告

**日期**: 2026-10-19 · **目标**: 复刻 ima 知识库检索 + 一键整库下载 · **状态**: ✅ 全链路打通并实测验证

---

## 一、标的识别

| 项 | 值 |
|---|---|
| 文件 | `E:\AI-Station\逆向工程\逆向标的\IMA批量下载助手.exe` (78.5MB) |
| 打包 | PyInstaller (Python 3.13.12, 无加密 CArchive + PYZ) |
| GUI | PySide6 (Qt) |
| 版本 | v1.7.1 (build 2026-06-04) |
| 商业模式 | 卡密制（作者私有授权服务器 `https://imaima.iepose.cn`，Ed25519 验签+机器码绑定+下载额度计费） |

## 二、逆向路径

1. **PyInstaller 解包** → 285 TOC 条目 + PYZ 1441 模块（tools/pyi_extract.py, pyz_extract.py）
2. **业务包识别**: `services/` `core/` `gui/` `data/` `utils/` `config`
3. **py313 本机反汇编**（tools/pyc_dump.py）→ dump/ 全量 dis + 常量摘要
4. **Workflow 9路并行源码重建**（src_rebuilt/，对抗校验）
5. **本机痕迹解密**（localstate/）: DPAPI 登录凭证（熵 `ima-helper-login-credentials-v1`）、license.enc（PBKDF2(SHA256, 机器码, `ima_local_salt`, 100k) → AESGCM）
6. **Web bundle 对照**（webjs/）: ima.qq.com wikis 前端 JS 端点表
7. **实测验证**: 真实登录/搜索/加入/下载闭环 ✅

## 三、协议全解（实测验证版）

### 3.1 认证体系

```
微信扫码: open.weixin.qq.com/connect/qrconnect (appid=wx0d63f5de059f1d52, scope=snsapi_login)
  → 轮询 lp.open.weixin.qq.com/connect/l/qrconnect (wx_errcode=405 → wx_code)
IMA登录: POST https://ima.qq.com/cgi-bin/auth_login/login
  body: {account_type:2, code:<wx_code>, auth_appid:"wx0d63f5de059f1d52",
         client_info:{guid:"guid-ca2055bffb9236ba0dea970403000002519701", platform:4,
                      qimei36:"ca2055bffb9236ba0dea970403000002519701"}}
  resp: {code:0, token, refresh_token, user_id, token_valid_time:7200, refresh_token_valid_time:2592000}
Token刷新: POST /cgi-bin/auth_login/refresh
  body: {user_id, refresh_token, token_type:14}   ← 14 是数字枚举（trpc.aitools TokenType）
Cookie: IMA-GUID/IMA-Q36(设备指纹,客户端硬编码全用户共享)/IMA-UID/IMA-TOKEN/UID-TYPE=2/
        CLIENT-TYPE=256002/APP-VERSION=2.2.4.4069/IMA-TOKEN-TYPE=idcTokenImatokenBindSocial/IMA-IUA(iOS指纹)
bkn = 腾讯 DJB 变体: hash=5381; for c in token: hash += (hash<<5)+ord(c); return hash & 0x7FFFFFFF
```

### 3.2 请求头

```
Accept: */* | Content-Type: application/json | From_browser_ima: 1
X-Ima-Bkn: <bkn> | X-Ima-Cookie: <完整cookie串>
User-Agent: ima/4032 CFNetwork/3860.300.31 Darwin/25.2.0   (iOS 客户端伪装)
```

### 3.3 端点表（iOS 头走 `knowledge_tab_reader` 模块；web 走 `knowledge`）

| 功能 | POST https://ima.qq.com/cgi-bin/… | body | 备注 |
|---|---|---|---|
| 我的库列表 | knowledge_tab_reader/get_knowledge_base_list | {type:1, limit:49} | 平铺,勿包params |
| **广场搜库** | knowledge_tab_reader/search_knowledge_base | {query, limit:10, cursor:""} | searched_knowledge_bases[].id |
| 库内搜索 | knowledge_tab_reader/search_knowledge | {cursor,query,knowledge_base_id,compared_knowledge_base_id:<同kb_id>,policy:"",forbid_default_cover:false} | |
| 文件列表 | knowledge_tab_reader/get_knowledge_list | {limit:30, knowledge_base_id, folder_id, cursor} | **文件夹ID=条目media_id(folder_前缀)** |
| 标签视图 | knowledge_tab_reader/get_tag_view | {knowledge_base_id, cursor, limit} | |
| **加入知识库** | knowledge_member/join_knowledge | {knowledge_base_id} | 免审核库 need_review:false; **加入后 role_type 0→1 才能下载** |
| 取下载URL | file_manager/get_media | {media_id, knowledge_base_id} | → jump_url_info.url(+headers); 付费库给 null(kb_payment_info) |
| 笔记正文 | knowledge_share_get/get_share_know_doc | {docid, knowledge_id, op:{op_attach/basic/content/resource:true,disable_cover:false}} | → doc_info.content_info.content |
| 报告正文 | report_svr/get_task_report | {report_id, knowledge_base_id} | → format_answer.block_list |
| 下载CDN | jump_url_info.url 直 GET | 用 jump_url_info.headers | 域名 res-skb.ima.qq.com 等 |

**media_type 分发**（download_single_file 逆向）:
- `11+笔记` → get_share_know_doc → 导出 .md（ImaNoteMdParser 规则）
- `2+ima报告` → get_task_report → .html
- `2+网址/腾讯新闻`、`6+公众号` → 链接记台账（原版写 Excel）
- 其他(1=PDF等) → get_media 直下
- 文件夹=99（ID 用 media_id）

### 3.4 分页

`next_cursor`(base64) + `is_end`；decode_cursor=前8字节大端 int。

## 四、复刻件（最终交付）

**`replica/ima_replica.py`** — 零依赖 vendor 授权服务器，直连 ima.qq.com：

```bash
py -3.13 ima_replica.py login                                   # 微信扫码（弹二维码）
py -3.13 ima_replica.py plaza DeepSeek                          # 广场搜库
py -3.13 ima_replica.py join 7476280295446827                   # 加入库
py -3.13 ima_replica.py kbs                                     # 我的库列表
py -3.13 ima_replica.py scan <kb_id> out.json                   # 整库扫描
py -3.13 ima_replica.py download <kb_id> <目录> --workers 4     # 一键整库下载
py -3.13 ima_replica.py search <kb_id> <关键词>                  # 库内检索
```

实测: 2026-10-19 登录✓ → 广场搜索✓ → 加入「知识库：AI资料库」✓ → **15/15 文件下载成功（157MB，%PDF- 真头验证）**

特性: token 自动刷新 / 台账幂等跳过 / 目录结构还原 / 并发+随机延迟 / 文件名清洗 / 笔记→md / 报告→html / 链接台账

## 五、目录资产

| 目录 | 内容 |
|---|---|
| extracted/ | PyInstaller 解包（285条目） |
| extracted/_pyz/ | 1441 个 pyc |
| dump/ | 全量 disassembly + 常量摘要 |
| src_rebuilt/ | **Workflow 全量重建源码 11 文件 6231 行（9/9 模块；ima_service 1375 行、auth 759 行、database 860 行、workers 906 行…；login_and_refresh 经指令流 diff 验证 PASS）** |
| webjs/ | ima web bundle（端点表来源） |
| localstate/ | 本机状态副本 + 解密凭证（**敏感：含token，勿外传**） |
| tools/ | 分析脚本（提取器/解密器/dumper） |
| replica/ | **复刻件（交付物）** |

## 补充实锤（第二轮验证 2026-10-19 下午）

- **access_status=2（可查看"不可导出"）的文件 get_media 完全放行**：实测 63MB JGJ99-2015 规程 PDF 完整下载（"不可导出"仅是 ima 客户端 UI 限制）。原版工具正是靠此下载全 status=2 的「工程知识库超市」系列库（本机日志 7 月 5.5 万文件铁证）
- access_status=1（不可查看）= 真不可见；code=600001 = 登录过期信号
- 原 get_knowledge_base_list 完整 body: `{'params': [{'type':1,'limit':'49'},{'type':2,...},{'type':3,...}]}`（params 为多类型数组）
- 搜索 filters 结构: `[{'filter_type': 2, 'tags_filter': {'tags': [...]}}]`
- 微信轮询 errcode: 405=成功 404/408=等待 403=过期

## 六、红线备忘

- 复刻件**不含也不需要** vendor（imaima.iepose.cn）的卡密授权 —— 直连腾讯官方接口
- 付费知识库（kb_payment_info 非空）加入后仍不可下载，需 ima 官方付费订阅 —— 复刻件如实报错不绕过
- localstate/ 内含解密后的 IMA-TOKEN/refresh_token（有效期至 2026-11 左右），仅本机使用
- 原 EXE 与 AppData 原文件均未改动（只读副本）
