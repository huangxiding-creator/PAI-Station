# timeline — sogou-weixin-reverse

- 2026-10-24 T0 侦察：REA 工具加载✓；Reverse-skill 本体定位 github/reverse-skill（契约：路由→scope 硬门→Evidence→Finding→Path）；
  PentAGI 活体确认 127.0.0.1:8443（调用法沉淀于 wps-ai-paiban/pentagi/*.sh：login→/api/v1/flows/1/assistants/ provider=glm）；
  zh-search-pro 既有战力：type=2 模板 + curl_cffi impersonate=chrome 过检索面 + /link?url= 自域跳转链已知未解析；
  SouGouWeDown 原件随 E:\AIResearch 永久丢失（1012 事故）→ 无现成件，从零破。
- 2026-10-24 T1 立案：work/sogou-weixin/scope.md（auth=granted, network_profile=authorized_target_only, 9371 专用 CDP 口）
- 2026-10-24 T2 probe1 纯HTTP检索探测（预热+单发检索，2×GET）→ 结果见 captures/probe1_log.json

## Findings
- F-1 (probe1, 纯HTTP): 检索面直通 — warmup 得 ABTEST+SUID；GET /weixin?type=2&query=… → 200/31KB/10条，无 antispider。curl_cffi impersonate=chrome 即可，无需浏览器。
  Evidence: captures/probe1_log.json + search_page.html
- F-2 (probe2, 纯HTTP): /link?url= 解析被墙 — 302 → weixin.sogou.com/antispider/?from=…&token=773A55C8…。token 出现在闸门页 URL；纯 HTTP 无 SNUID 无法过闸。
  Evidence: captures/probe2_log.json + link_resp.html
- F-4 (REA scen1, 浏览器实弹): /link 在浏览器腿=200+GBK 碎片页(非302), 100ms 后 window.location.replace 落 mp.weixin.qq.com/s?src=11&timestamp&ver=7045&signature=…; 1538网络事件全景。Evidence: evidence/rea_scen1_raw.json [seq 313/323]
- F-5 (probe1复核): 检索响应本身 Set-Cookie: SNUID(域.sogou.com) — probe2 死因=会话没先打检索。Evidence: captures/probe1_log.json
- F-6 (probe3): token=8HEX+SNUID+6HEX, token_embeds_snuid=true 实证, 会话绑定。
- F-7 (p3_link_body): /link 200页=approve埋点+11段 url+='碎片' 拼接+100ms跳转; 正则 url\+= 拼接即得签名链, 无需执行JS。Evidence: captures/p3_link_body.txt
- F-8 (probe4): 纯HTTP四段全链贯通 — 349KB文章页, 标题/时间/biz/正文5440字全提取。Evidence: captures/probe4_log.json
- T3 REA 实弹(9371专用最小化实例, scen1 抓包1538事件)
- T4 probe3/4 纯HTTP过闸+全文贯通(零浏览器)
- T5 复刻件 sogou_weixin_api.py 铸成; 解析修正: 条目分隔=<li id=sogou_vr_11002601_box_N>, 时间=document.write(timeConvert('epoch')), 账号=span.all-time-y2
- T6 复刻件实测: 「水利EPC」「EPC总承包」多会话全绿(账号+日期+摘要+全文+图床链; 黄藏寺项目文章真实命中)
- T7 PentAGI 派工: flow1 死因=缺primary container; 借道 flow14(finished+1容器) REST POST /flows/14/assistants/ → assistant16 GLM-4.7-flash 出研判三节(附录A)
- T8 9371 实例清杀(PID48784树3进程), 端口归零, chrome计数回基线23
- T9 逆向报告.md 成稿; 复刻件+证据链+授权档全量入档
