# 命令全参数与输出契约

CLI 真身：`E:\AI-Station\逆向工程\pan-hunter\ph.py`（下记 `python -I <ph.py>`）。
退出码约定：0=成功；1=业务失败（链死/无文件/上游异常）；2=路由失败（盘型未注册/非五盘发现层链接）。

## search

```
python -I ph.py search <关键词> [--json] [--source 源1,源2]
```

- 聚合 9 实测活源（melost/mikuclub/panhunt/hunhepan/naspt/pansearch/tg_tgsearchers7/bixin/miosou），
  泛盘链提取 + 跨源 URL 去重 + 盘型红绿灯标注。
- 文本输出两栏：**交付层**（绿盘可直下）+ **发现层**（全部命中，黄盘标注「交付走本地凭据插件，默认关」）。
- `--json` 字段：`url/disk/light/source/deliverable`（deliverable=light=="绿"）。
- 每次执行自动落台账：`analysis/search_ledger.jsonl`（逐发：source/kw/path/status/hits/disks/elapsed）
  + `analysis/search_hits.jsonl`（逐命中 URL 归档）。发数以台账行计，禁手填。
- 耗时预期：9 源并发≤4、源内间隔≥2s ⇒ 单次约 20-40s。

## discover

```
python -I ph.py discover <分享链> [--pwd 提取码]
```

- 仅五盘发现层：baidu / aliyun / quark / xunlei / 139（其余盘型退出码 2）。
- 输出：状态/存活/发数(shots)/分享名/文件清单（≤30 项，含大小）/上游消息。
- 零下载零凭据；BDCLND/share_token/stoken 等均为公开面令牌。
- 总预算硬门 150 发（进程内 DiscoveryLedger 熔断）；提取码可从 URL `?pwd=`/#提取码：xx 片段自动剥。

## download

```
python -I ph.py download <分享链> [--out 目录] [--min-mb N]
```

- 仅绿盘 adapter（uc/lanzou/ilanzou/feijipan/ecpan 等 10 注册盘；黄盘退出码 2）。
- 流程：解析列表 → 选首个 ≥min-mb 文件（默认 10）→ 直链 → 流式落盘（cap 1.5GB）→ 打印 bytes+sha1。
- **成功即自动落审计行** `analysis/download_audit.jsonl`：
  `{ts, url, disk, file, bytes, sha1, purpose:"research", out}`（法务#4 商用防火墙审计位）。
- `--out` 建议指向新目录，勿覆写历史门件（w1_downloads/ 是证据链，禁覆盖禁删）。

## gates

读 `analysis/W1_GREEN_GATES.md`（十盘真件门权威台账：5 绿 + 3 绿? + 123 黄 + cow 死，门件 sha1 全录）。零网络。

## doctor

```
python -I ph.py doctor [--sources]
```

- 默认零网络：盘矩阵（10 adapter 路由+灯）+ 发现层（5 盘）+ 插件态（默认全关，只显态不执行）。
- `--sources`：9 源逐源探活（约 9-12 发，LIVE/FAIL+hits+耗时）。

## health_round（脚本）

```
python -I E:\AI-Station\逆向工程\pan-hunter\scripts\health_round.py [--kw 探针词]
```

- 9 源探活 → `analysis/health_rounds/<ts>.json`（逐源 verdict + 与历轮趋势 ↑↓±）。
- 每轮 ≈9-12 发；建议周期≤7 天（源半衰期实测：melost 结构同日漂移、aipanso 同日 CF 升级）。

## MCP 头

`E:\AI-Station\逆向工程\pan-hunter\mcp_server.py`（stdio，零依赖）：三工具
`panhunter_search(kw)` / `panhunter_discover(url, pwd?)` / `panhunter_doctor()`。
挂接法见仓 README「MCP 挂接」节。
