# cnki-reverse 授权与边界 (scope)

## 授权
- 用户 1024 全渠道 API 化令: 把 CNKI 知网检索面逆向为纯 HTTP API 客户端, 免浏览器拿题录+摘要。
- 方法论契约复刻 sogou-weixin-reverse 结构纪律 (captures/ replica/ 逆向报告.md)。

## 目标(授权范围)
- 检索/题录/摘要通道: 纯 HTTP (GET/POST 只读) 检索关键词 → 题录(题/作者/刊/年) + 摘要。
- 验收: 「国际工程 EPC」≥20 条题录, 5 次独立会话贯通; 若主路全死, 产出免登录替代源结论也算收官。

## 边界(红线, 不可触碰)
1. 不破解滑块验证码本体 (blockPuzzle/verify 不分析算法、不生成轨迹伪造); 只找免滑块入口或带正确握手头直过。
2. 不碰付费全文/CAJ/PDF 下载墙; 不下载任何付费内容。
3. 只读 GET/POST 检索类请求; 不做写操作、不注册账号、不爆破。
4. 不删任何文件; 无 push (本地 commit 只加 cnki-reverse/ 目录); 密钥不进仓。
5. 数字零造假: 一切状态码/贯通率以实测 log 为准。
6. 浏览器仅侦察用途 (headless/minimized), 用完即清 (chrome-process-hygiene 铁律)。

## 现状输入(四路全死基线, 1024 战役)
- kns.cnki.net 主检索 302 → verify/home blockPuzzle 滑块墙
- search.cnki.com SERP = 纯 JS 壳
- 后端 /api/fileterresultapi/articlefileter = openresty 403
- wap.cnki = 登录墙; 老刊目页 16KB 软墙
- 本战役 cnki 腿只收到免登录题录+摘要 6 件

## 候选路线
- A: search.cnki.com JS 壳 → 静态解 bundle 找后端 → fileterresultapi 握手补齐(Referer/头/预置 cookie)
- B: kns.cnki.net/kns8s/brief/grid POST 体系带完整握手头直过
- C: 旧版入口 search.cnki.com.cn / med.cnki.net / cdmd.cnki.com.cn
- D: oversea.cnki.net 海外版
