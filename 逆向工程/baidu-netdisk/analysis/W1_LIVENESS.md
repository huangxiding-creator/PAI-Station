# W1 只读活性普查原始记录（W1_LIVENESS）

- 日期：2026-10-29 · 执行：W1 协议规格工程师 · 脚本：`scripts/w1_liveness.py` + `scripts/w1_retry.py`
- 凭据：`data/secrets/bdn_credentials.json`（BDUSS/STOKEN/ua_native，全程掩码前 8 位）
- 请求头模板：`Cookie: BDUSS=<v>; STOKEN=<v>` / `User-Agent: netdisk;8.2.5.103;PC;PC-Windows;10.0.19045;WindowsBaiduYunGuanJia` / `Referer: https://pan.baidu.com/disk/main`
- **全部 9 发均不带 rand/rand2**（目的之一 = 测签名必要性）；间隔 ≥1.6s；预算 9/12 发（quota GET 绿 → POST 兜底未触发）
- 熔断线 errno {31119, 31329, 20012, 31034}：**全程零触发，未停线**
- 机器原始件：`analysis/W1_LIVENESS_RAW.jsonl`（注：末两条复测的 n 字段双双误标 9，以本表顺序编号为准；tag 字段可区分）

## 逐发账本

| # | tag | 方法+URL | HTTP | errno | 响应前 80 字符 |
|---|---|---|---|---|---|
| 1 | quota-get | GET `pan.baidu.com/api/quota?checkfree=1&checkexpire=1` | 200 | **0** | `{"errmsg":"","errno":0,"expire":false,"free":3305728953542,"is_show_window":0,"n` |
| — | quota-post | （兜底未触发：#1 已 errno=0） | — | — | — |
| 2 | xpan-search | GET `pan.baidu.com/rest/2.0/xpan/file?method=search&key=AI&recursion=1&num=5` | 200 | **0** | `{"errno":0,"list":[{"category":6,"extent_tinyint1":0,"fs_id":218865167185894,"is` |
| 3 | xpan-multifile-metas | GET `pan.baidu.com/rest/2.0/xpan/multifile?method=metas&fsids=[341179797843843]&dlink=0` | EXC | null | ContentDecodingError（gzip 解码异常→实为 404 页，见 #8） |
| 4 | xpan-share-record | GET `pan.baidu.com/rest/2.0/xpan/share?method=record` | 200 | **0** | `{"errno":0,"request_id":84347568867154225,"count":30,"nextpage":1,"list":[{"shar` |
| 5 | share-record-blueprint | GET `pan.baidu.com/share/record?page=1&desc=1&order=time` | 200 | **0** | `{"count":86,"createsharetips_ldlj":"复制这段内容后打开百度网盘手机App，操作更方便哦","errno":0,"list":` |
| 6 | recycle-list | GET `pan.baidu.com/api/recycle/list?num=100&page=1` | 200 | **0** | `{"errno":0,"list":[{"category":3,"delete_type":0,"extent_int8":0,"fs_id":1974405` |
| 7 | filediff-post（极简参数） | POST `pan.baidu.com/api/filediff?clienttype=8` body `cursor=&action=manual` | EXC | null | ConnectionReset(10054)——参数过简被 RST（见 #9 对照） |
| 8 | xpan-multifile-metas-retry | 同 #3 + `Accept-Encoding: identity` | **404** | null（HTML） | `<!DOCTYPE html> <html lang="zh-CN">...<title>页...`（zh-CN 404 页） |
| 9 | filediff-post-fullparams | POST `pan.baidu.com/api/filediff?block_list=1&clienttype=8&channel=00000000000000000000000040000001&version=8.2.5.103&deviceid=152236194638317114&dname=%e6%83%a0%e6%99%ae` body `cursor=&action=manual` | 200 | **2** | `{"errno":2,"reset":false,"cursor":"","request_id":84370185323305437,"entries":"` |

## 结论

1. **活性**：6 端点形态 errno=0（quota-GET / xpan-search / xpan-share-record / share-record / recycle-list，加此前 V1/V3 冒烟的 loginStatus、api/list、xpan-list 共 9 形态绿）。`xpan/multifile?method=metas` = **404 已死**（legacy 形态退役，现行=官方 `xpan/multimedia?method=filemetas`）。`api/filediff` = 活（200 JSON 应答），errno=2 为空 cursor 参数错而非拒绝；极简 query 会被 TCP RST，**参数完整度有门、签名无门**。
2. **rand/rand2 必要性**：9 发全零 rand/rand2，无一发遭签名类拒绝（无 401/无 errno 111/无风控码）→ **读面 rand/rand2 非强制**，实证面扩至 quota/xpan-search/xpan-share-record/share-record/recycle-list/filediff 六端点 + 冒烟三形态。写面（pset/transfer/filemanager）待 W2/W4 验证。
3. **意外收获**：官方口径「2026-09-16 旧分享服务下线」实测仅覆盖写面——`xpan/share?method=record` 只读面 errno=0 且 count=30 在役；两代分享列表形态（xpan 与蓝本 share/record）同时活着。
4. 回填：以上结果已写入 PROTOCOL.md 活性/rand 必要性两列，受影响端点全部标 A 级 + 2026-10-29。
