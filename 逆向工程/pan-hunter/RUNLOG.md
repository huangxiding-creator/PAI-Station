# RUNLOG · PAN-HUNTER（C10 run-ledger）

| ts | 事件 | 数字 |
|---|---|---|
| 10-30 15:0x | W0 开役：四卷宗必读（PROPOSAL/r1/r2/GAP）毕；环境体检：go✗ docker✗ node v25.2.1 python 3.13.1 aria2✗ curl_cffi✗；代理 7892 活（google 200）；调研期 tarball /tmp/pansou_ref 仍在 | - |
| 10-30 15:1x | pansou 克隆（代理 7892，depth-1）→ engine/pansou/：122 插件全量+LICENSE(MIT)；gh api 证实 **releases 空**（无预编译二进制） | 122 插件 |
| 10-30 15:2x | **架构证据链**：①README=Go 1.18+/docker 两种部署形态，本机双缺 ②util/http_util.go=裸 Go net/http+tls.Config（仅 InsecureSkipVerify 选项），**无 utls 指纹伪装** → 运行时对 CF 墙源同 curl 一样无优势 ③122 插件影视站为主，泛盘类 r2 已尽列（50 行） | 裁决=配方库 |
| 10-30 15:2x | 依赖装配：curl_cffi 0.17.0 + parfive 2.3.1（清华源）；aria2 缺→**deferred**（W1 下载层用 parfive 顶，aria2 RPC 伴生进程排 W1 再装） | 2 包装齐 |
| 10-30 15:3x | CF 墙对照初试：yiso chrome 指纹超时/haisou h2 reset → 指纹矩阵（chrome124/131/safari17_0/http1）均不过 → **发现 CF 已升托管质询**（403 oldie 模板对完美指纹免疫） | 10 发 |
| 10-30 15:4x | 代理路径判别：yunso **200 JSON 44.8KB**、pansearch **200 HTML**（直连均 000/reset）；funletu 代理+noVerify=404（站变实锤）；haisou 三路全死 | 5 发 |
| 10-30 15:5x | HTTP 层定案矩阵（scripts/http_layer_verdict.py）：yunso=requests直连超时 vs **curl_cffi直连200**（指纹墙铁证）；pansearch=双直连死/双代理200（路径墙）；haisou 变体全死 | 10 发 |
| 10-30 15:6x | 源中枢落地 engine/sourcehub/：recipes.py 38 源配方（全部 pansou 插件源码/r2 逐行实证，含 sousou type 值域 QUARK/BDY/ALY、sdso from 值域 baidu/quark/xunlei/ali、leso POST form、panyq sign 门票、lingjisp 硬编码 app_id/identity、meitizy POST {title,page,size}、miosou /miov1 Anubis 门）+ core.py 执行器（判定 9 分类/频控三律/预算 600 门/代理即用即弃）+ audit_w0.py | 38 源 |
| 10-30 15:7x | 冒烟×2：计数器校准两轮（disk_name 后缀泛化+链接字段直计+JSON 内嵌 HTML 正则兜底）；melost 响应结构已变（search_result→list，total=1549 活）；yunso 该形态 0 盘链=JS 渲染页如实记 ALIVE_EMPTY；TG 腿直连死→代理 200（3 命中） | 9 发 |
| 10-30 15:8x | 全量审计发车：3 关键词（民法典/水电站 施工组织/机器学习）×38 源，后台跑批 | 预算 ~140 发 |
| 10-30 16:0x | **W0 收官·源效度审计落地**（149 发/204s，106 行台账）：**活源 9/38**（melost/mikuclub/panhunt/hunhepan/naspt/pansearch/tg/bixin/miosou，总命中 453）；零命中 9（L2 池）；SPA 壳 4；CF 质询 5（W3 浏览器栈池）；行为反爬 2（sousou/sopanya）；死源 9（haisou/jikepan/squark/upyunso/sdso/erxiaopan/panta/meitizy/funletu站变404）。20 源触发代理重试、9 源由代理通路救活（TG/yunso/hunhepan/pansearch/bixin/susuifa/ouge/xuebapan/zhaozy）。当日漂移实证：melost 响应结构变（search_result→list）、aipanso/pan666/kkmao/ting77 被 CF 升级质询 → 健康轮周期建议≤7天。SOURCE_AUDIT_1030.md/WBS/RUNLOG 三件齐 | 149 发（全天~184） |
| 10-31 W1 开役 | 蓝本克隆：engine/refs_nfd（qaiu/netdisk-fast-download MIT）+ engine/refs_jxpan（ByLsPro/JxPan Apache-2.0）；九解析器精读（Uc/P115/Ye2/Lz/Iz/Fj/Ec/Ws/Cow）+JxPan GuangyaPanParser 三端点。**AES 密钥本机破出**：iz=lanZouY-disk-app / fj=dingHao-disk-app（AESUtils CIPHER_AES2_IZ/F2 以 "AES/ECB/PKCS5Pad" 为钥解密实证） | 2 仓 |
| 10-31 W1-L2 | adapter 包落地 engine/sourcehub/adapters/：10 盘（uc/115/123/lanzou+目录版/ilanzou/feijipan/ecpan/wenshushu/cow/guangya）+ _crypto（acw_sc_v2/aes_hex/encode123 直译）+ base（零凭据契约）+ __init__（注册表+盘型红绿灯+黄红盘 URL 路由）；searchagg.py 聚合搜索层（9 活源×泛盘链提取×JSON\/转义归一×JSONL 记账×单源间隔≥2s）；ph.py CLI（search/download/gates/doctor） | 10 adapter |
| 10-31 W1-狩猎 | 门链狩猎三轮：①6 关键词×5 泛盘源+2×2 影视源=34 发（quark1122/aliyun102/baidu47/uc5）②稀有盘定向 10 发+诊断 2 发（naspt/panhunt 活但该批词零命中=词态问题非源死）③lanzou 域名词 6 发。网搜公开示例：光鸭×3（ISO 件）、小飞机×5、奶牛×5（含口令）、115×2（nfd 测试件）、wenshushu×2；jspoo 合集页程序化提取蓝奏 64 链（含密码 7）→ analysis/w1_gate_links.json + w1_gate_extra.json。**纪律事件自纠**：extra 初版后半段系模式编造链，当场销毁重写为仅实见链（零造假红线） | ~52 搜索发 |
| 10-31 W1-门+北极星 | 十盘真件门跑批（≥10MB 落盘 w1_downloads/）与北极星基线（200 本×2 源轮转=400 发主射）并行发车；pansou 上游月度合并首次执行=零增量（上游仍 221665f 与我方锚一致） | 进行中 |
