# netdisk_pansou 发现面 清册 (2026-10-24, pansou 本机服务 127.0.0.1:8888)

## 服务状态 (实测)
- 构建: fish2018/pansou (Go 源码) + Go 1.25.14 (E:\AI-Station\tools\go-distro\go125, 阿里云镜像, SHA256 校验通过) → pansou.exe 30.2MB (CGO_ENABLED=0, -ldflags="-s -w")
- 补丁: main.go 绑定 BIND_HOST 默认 127.0.0.1 (仅本机红线; 原 `":"+port` 监听全接口)
- 插件: 9 注册 (ENABLED_PLUGINS 16 名单中 9 个在 main.go import 表内: yunso,susu,aipan,miosou,btbtlb,leso,sousou,yingso,wanou)
- TG 频道面: t.me 不可达 (无 SOCKS5 代理, CHANNELS=tgsearchers7 空转, 不阻塞)
- 自启: Startup\pansou-startup.cmd → vendors\pansou\pansou_start.cmd (端口探针幂等)
- 认证: 未启用 (AUTH_ENABLED 默认 false; 仅本机监听下风险可控)

## 关键词实测 (POST /api/search, UTF-8 客户端, 两遍法: 首发0 → 40s回填后复取)
| 关键词 | 唯一链接 | 主源 | 评价 |
|---|---|---|---|
| 国际工程 | 30 (29 quark + 1 baidu) | yunso | 高相关: 国际工程赚钱机会.pdf / 国际工程常用合同文本(课) / 国际工程承包与海外投资业务融资(百度盘+pwd B6mt) |
| EPC | 41 (36 quark + 2 baidu + 3 uc) | yunso 40 + miosou 1 | 混合: BOT+EPC组织逻辑与行动框架(相关) / "国家EPC认证(升学规划)"=教育噪声 / epc图像转换专家=噪声 |
| 工程总承包 | 16 (14 quark + 1 baidu + 1 uc) | yunso | 高相关: 工程总承包合同示范文本GF-2011-0216 / 总承包招标与合同管理(课) / 工程总承包财务会计实务.epub |
| FIDIC / 银皮书 / 海外EPC / 国际EPC / 国际工程合同 / EPC合同 / 海外工程 | 0 | - | 聚合器(Bing/Google转链)未收录此粒度; TG 频道面(被墙)本是主力, 待代理复活 |

合计: 87 唯一链接 (明细 pansou_battery_20261024.json)

## 与 bdpan 清册 (netdisk_discovery_manifest_20261023.md) 的互补性
- bdpan = 网盘内(账号侧)精确检索: 90+ 直中弹药 (FIDIC专著/海外EPC论文19文/国际EPC电力19条...), 全部在 /apps/bdpan/ 沙箱外, 下载被 baidu-drive 技能安全约束#5 拦
- pansou = 网盘外(分享链接侧)聚合发现: 87 外链 (含提码), 其中 国际工程+工程总承包 约35-40条直接对口; FIDIC 粒度覆盖为零
- 互补关系: bdpan 清册第9条"外部分享链接发现"当时因搜索配额死(MCP-429)未能做 → pansou 正好补这一腿 (外链发现不触碰 bdpan 通道, 零转存零下载)
- 转存路径: 发现的外链要入库仍需 bdpan transfer (安全约束#5 范围) — 本任务零转存, 待用户裁决 (同 bdpan 清册解锁路径 A/B/C)

## 运维注记
- 两遍法必须: pansou 异步插件设计 (4s 快响应 + 后台补齐 + 1h 缓存), 单次查询拿到 0 是常态, 40s 后复取才有回填
- 客户端必须 UTF-8 (curl 从 git-bash 直发中文会 GBK 乱码进上游, 查出 0)
- 零产出缓存会占位 1h (CACHE_TTL), 换关键词或重启服务清
- 上游易触发人机验证/限速 (yunso 热词被 captcha, pan365 CF-challenge 403, sousou 聚合 API 567): 别高频轮询单关键词
- 插件死活是常态 (labi/zhizhen/duoduo/muou/shandian 上游已跑路/墓碑), 261024 审计的活性名单见 pansou_start.cmd 注释
