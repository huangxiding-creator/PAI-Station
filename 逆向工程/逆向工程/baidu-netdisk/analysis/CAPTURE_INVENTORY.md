# 百度网盘客户端 8.2.5 动态抓包清单（2026-10-29）

手段：ProxySetting.ini(proxy_type=1)→127.0.0.1:8888 + mitmproxy 12.3.1 + 用户级 CA（收尾已撤销）。
窗口期 18:38–19:05，共 **1152 条 HTTPS 流量 / 87 个端点 / 9 域名**（filediff 占 970 条），零 TLS 异常（客户端不锁证书，对 MITM 完全友好）。请求数 << 100/操作红线；**全程零写操作**（新建文件夹测试未执行，原因见末节）。

## 一、凭据形态结论（最高价值）

| 形态 | 结论 |
|---|---|
| 主凭据 | **Cookie：BDUSS(192位 base62) + STOKEN(64位)**。1015 条中 1000+ 条带 Cookie 头，无 Cookie 的全是静态资源 |
| Cookie 全家族 | BDUSS / STOKEN / BAIDUID(37) / PANPSC(343) / ab_sr(262) / ndut_fmt(64) / *_BFESS 变体 / HMACCOUNT |
| bdstoken(32 hex) | 作 query 参数出现在 `rest/2.0/dss/*`；由 `GET /api/loginStatus` 响应**明文发放**（本机 vault 留档） |
| 签名头 | **不存在**。普查全部请求头：无 Sign / sign2 / bd-Log-Id / PAN-* / Authorization。头只有 Accept/Host/UA/Cookie/Content-Type/Content-Length(+CEF 腿的 Sec-* 标准头) |
| 签名参数 | **全在 query**：`rand`(40hex)+`rand2`(40hex) 成对逐请求随机 + `time`(unix) + `logid`=base64("unix时间戳,随机数")。rand 族生成算法待静态腿在 kernel_btsdk.dll 验证 |

## 二、UA 实测值（完整可复制，3 家族）

```
# A 原生腿（281+ 条，主力 API）
netdisk;8.2.5.103;PC;PC-Windows;10.0.19045;WindowsBaiduYunGuanJia

# B CEF UI 腿（63 条，页面/XHR）
Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) baidunetdisk/8.2.5 Chrome/108.0.5359.215 Electron/22.3.27 Safari/537.36;netdisk;8.2.5.103;PC;PC-Windows;10.0.19045;WindowsBaiduYunGuanJia

# C CEF 纯资源腿（静态图）
Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) baidunetdisk/8.2.5 Chrome/108.0.5359.215 Electron/22.3.27 Safari/537.36
```
内核=Electron 22.3.27 / Chromium 108.0.5359.215（BrowserEngine 模块，baidunetdiskhost.exe）。

## 三、原生腿通用参数模板（复刻必带）

```
clienttype=8
channel=00000000000000000000000040000001
version=8.2.5.103
devuid=BDIMXV2-O_<32hex>-C_0-D_<盘符序列号>_00000001.-M_<MAC 12hex>-V_<8hex>   # 本机值在 vault
deviceid=152236194638317114        # 另一设备标识（filediff 用）
dname=<URL编码的主机名>            # "惠普"
vip=2                              # 会员等级数字
logid=<base64(ts,rand)>
rand=<40hex>&rand2=<40hex>&time=<unix>
```
CEF 腿变体：`clienttype=8&app_id=250528&web=1&channel=Windows_10.0.19045_Uniyunguanjia_netdisk_00000000000000000000000040000001`。

## 四、端点全表（按场景分组）

### 登录态/身份
| 方法 | 端点 | 关键参数 | 场景 |
|---|---|---|---|
| GET | pan.baidu.com/api/loginStatus | clienttype=8&app_id=250528&web=1 | 登录态查询；**响应含 bdstoken/uk/username/vip_level/vip_type/photo_url** |
| POST | pan.baidu.com/api/user/getinfo | 模板+rand/rand2 | 用户信息 |
| POST | pan.baidu.com/api/quota | 同上 | 配额 |
| POST | pan.baidu.com/api/account/getprivilege | sourcetype=2 | 权益 |
| POST | pan.baidu.com/api/account/getdeviceswitch | seg=2&switch=192 | 设备开关 |
| POST | pan.baidu.com/api/multidevice/check | deviceid | 多端检查 |
| POST | pan.baidu.com/api/device/anticheck | 模板 | 设备风控反查 |

### 文件域（核心）
| 方法 | 端点 | 关键参数 | 场景 |
|---|---|---|---|
| POST | pan.baidu.com/api/list | dir=/&page=1&num=1000&order&desc | **目录列表**（一次 1000 条） |
| POST | pan.baidu.com/api/filediff | block_list=1&deviceid&dname；body: cursor=<base64>&action=manual | **秒级增量轮询**（最高频，154+条）；响应回新 cursor |
| POST | pan.baidu.com/recent/list | 模板 | 最近使用 |
| GET | d.pcs.baidu.com/rest/2.0/pcs/file | method=locateupload | 上传定位（PCS 通道） |

### 会员/商业化
| 方法 | 端点 | 关键参数 |
|---|---|---|
| POST | pan.baidu.com/rest/2.0/membership/user | method=identify |
| POST | pan.baidu.com/rest/2.0/membership/user/info | method=rights |
| POST | pan.baidu.com/rest/2.0/membership/product | method=abconfig&from=pc_experiments |
| POST | pan.baidu.com/rest/2.0/membership/privilege | method=query&type=28&status=0,1 |
| POST | pan.baidu.com/act/api/conf | conf_key=ee_org_potential_user_conf |
| POST | pan.baidu.com/act/v2/bchannel/list | 模板 |
| POST | pan.baidu.com/act/v2/uinfo/get | action=new_user_365_real_status |
| POST | pan.baidu.com/act/v2/component/storageget | keys=pclogin_<uk>&tid&ptid |

### 企业版（本账号为企业管理员）
| 方法 | 端点 | 关键参数 |
|---|---|---|
| POST | pan.baidu.com/mid_enterprise_v2/api/enterprise/organization/allorganizationinfo | cid=0&app_id=24029990 |
| POST | pan.baidu.com/api/enterprise/organization/isorgpotentialuser | 模板 |

### 设备上报/长连注册（疑似 hcm/ssid 家族）
| 方法 | 端点 | 关键参数 |
|---|---|---|
| POST | pan.baidu.com/rest/2.0/dss/device | method=register&type=0&appid=250528&**bdstoken** |
| POST | pan.baidu.com/rest/2.0/dss/online | method=report&appid=250528&**bdstoken** |
| POST | pan.baidu.com/api/report/user | deviceid |
| POST | pan.baidu.com/xep/getcfg | app=netdisk&type=2&os=Windows |

### 增值域杂项
knowledge/subnotice、knowledge/sub/exist(share_uk,surl)、sbox/user/query、aisearch/user/get、notice/newnum、api/flow/info、rest/2.0/pcs/adx(m=tab&uk)、wan.baidu.com/gameapi(action=pan_micro_game_config)、aiknowledgeapi/record/notice、api/certuser/get

### CEF UI 腿（遥测/配置）
| 方法 | 端点 | 说明 |
|---|---|---|
| GET | pan.baidu.com/api/analytics | PAGE_VIEW/事件流；moduleName=AISearch route=/aipan/search |
| GET | pan.baidu.com/api/getsyscfg | cfg_category_keys=[{web_auto_yun}] |
| GET | mbd.baidu.com/ztbox | action=zpblog 埋点 |
| GET | hm.baidu.com/hm.js + hm.gif | 百度统计 |
| POST | sp1.baidu.com/5b1ZeDe5KgQFm2e88IuM_a/mwb2.gif | 前端性能（TTFB） |
| GET | nd-static.bdstatic.com / staticsns.cdn.bcebos.com / himg.bdimg.com | 静态资源/头像 |

## 五、代理覆盖率（CEF UI vs 原生内核）

- **全走代理**：原生 HTTP 栈（kernel 层 API 腿）与 CEF UI 腿**都**遵守 ProxySetting.ini → netstat 实测 20 条连接指向 127.0.0.1:8888，两家族 UA 均大量入池。
- **未走代理（直连 443 残留 7 条）**：进程 39168/20216 直连 `119.249.103.49`、`110.242.69.43`、`110.242.69.202`（无 PTR，百度自有段）。判读=长连接推送/心跳通道（hcm/ssid 嫌疑），不走 HTTP 代理，代理法够不着 → 需静态腿在 kernel_btsdk.dll/YunDls.dll 补协议。
- 证据：captures\netstat.txt。

## 六、filediff 增量协议解剖（独家）

```
POST /api/filediff?block_list=1&deviceid=...&dname=惠普&clienttype=8&channel=...&version=8.2.5.103
     &devuid=BDIMXV2-...&rand=<40hex>&time=1793270304&rand2=<40hex>&vip=2&logid=<b64>
Content-Type: application/x-www-form-urlencoded
Cookie: BDUSS=...; STOKEN=...
body: cursor=<约200位base64游标>&action=manual&dname=%e6%83%a0%e6%99%ae
→ {"errno":0,"reset":false,"request_id":...,"cursor":"<新游标>", ...}
```
启动即秒级轮询（全程 970 次），是客户端「文件变更感知」主通道。

## 七、账号快照（本机脱敏留档）

uk=587408217 / username=pyeyeye / SVIP8（vip_type=21, vip_identity=21）/ 企业=总包智（海南）教育科技有限公司（cid=1000064637342, adminuk=587408217）。

## 八、复刻最小集建议

1. 登录态 = Cookie(BDUSS+STOKEN)，无其他头级凭据。
2. 必带 query：clienttype=8 & channel=00000000000000000000000040000001 & version=8.2.5.103 & devuid & logid。
3. rand/rand2 是否服务端强校验**未验证**（开放问题，静态腿优先解）。
4. 首选验证端点：POST /api/quota（无副作用）→ POST /api/list（dir=/）→ /api/filediff。

## 九、原始证据（captures/ 已 gitignore，仅本机）

| 文件 | 规模 |
|---|---|
| flows.jsonl | 1152 行 / 3.8MB（脱敏记录：头全集+body前后2KB） |
| flows.mitm | 484MB（mitmproxy 原始流，含完整响应体） |
| secrets_vault.json | 7.2KB（BDUSS/STOKEN/bdstoken/rand 完整值——**绝不入仓**） |
| netstat.txt / win_state1.png | 外联对照 / UI 状态截图 |

## 十、异常与未竟事项

1. **UI 停扫码登录页**：重启后 CEF UI 显示二维码登录（win_state1.png），但原生腿 BDUSS 全程有效（loginStatus errno=0 且回完整画像）→ web 会话未随重启恢复。搜索/新建文件夹等主动 UI 操作因此**未执行**（不代用户扫码）。下次若需 UI 自动化：先让用户扫码恢复，或研究 CEF cookie 恢复链。
2. `--remote-debugging-port=9339` 未透传到 baidunetdiskhost，CDP 不可用；CEF accessibility 关闭（UIA 只见 Legacy Window 壳）→ UI 驱动需另想办法（如注入 renderer accessibility 开关或 CEF 命令行改造）。
3. 直连长连通道 3 个 IP 的域名归属待静态腿/更大范围抓包确认。

—— 动态抓包腿 2026-10-29 收官；收尾已执行：ProxySetting.ini 还原（type=0 直连）、mitmdump 停（8888 释放）、客户端裸参数重启保持运行（13 进程）。
**残留一项**：用户级 Root 库的 mitmproxy CA（1 张，2026-07-19 存量签发，非本次新植入——本次 addstore 即报「已存在」）。certutil -delstore 触发 Windows 根库 UI 确认框，非交互会话无法点选，两次尝试均未落库。若需清除请在交互终端跑：`certutil -user -delstore Root mitmproxy` 并确认弹窗。存量 CA 为 ope-engine 等此前 MITM 工作所留，未清不构成本次新增暴露面。
