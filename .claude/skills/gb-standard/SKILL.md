---
name: gb-standard
description: 中国国家标准(GB/GB/T) PDF 下载与情报查询（eBiaozhun 免登录链）。输入标准号如 GB/T 8110-2020，自动解析精确名称/版本/金币价/详情页；0 币免费件直下 PDF，付费件如实报价不绕墙。查国标标准、下载国标 PDF 时使用。
# EXTENDED METADATA (github-to-skills 规范, skill-manager 幂等更新用)
github_url: https://github.com/dageer2026/china-gb-standard-downloader
github_hash: d3de5455a707
version: 0.1.0
created_at: 2026-10-03
entry_point: scripts/gb_download.py
dependencies: ["requests"]
---

# gb-standard — 国标 GB/GB/T 下载与情报

上游: dageer2026/china-gb-standard-downloader（MIT；用户给的旧地址
dageergpt-ship-it/... 已 301 改名至此）。原仓库就是一个 Reasonix AI Skill
(skill.md)，本技能是其配方的工程化封装。

## 链路（eBiaozhun 三步）

```
search.html?q={数字段}        →  /std/{hash}.html  (标题含标准号者)
/std/{hash}.html              →  var pid = {N};    + 金币价 + 精确标准名
/matrix/order/paystatus?type=doc&pid={N}  (X-Requested-With + PHPSESSID)
  code=1 → files[0].url 直链 PDF（0 币免登录件）→ 下载 → ≥100KB 验真
  code=0 未支付 → 付费件: 报价 + 详情页链接, 不绕支付墙
```

## 2026-10-03 实测口径（相对上游 6 月配方的漂移）

- 全站抽样 5 件国标全部 3-15 金币（GB/T 700 3币 / GB/T 9775 5币 /
  GB 50017-2003 15币）——**0 币免登录直发件已罕见**，免费通道保留但不保证命中
- 搜索注意: 数字段搜索会混入 QB/T、JB/T 同号标准，脚本已按 GB 前缀+年代号择优
- 年代坑: 问 2020 版站点可能只有 1995 版（如 GB/T 8110），脚本如实报版本

## 用法

```bash
# 只解析情报 (名称/价格/直链, 不下载)
python .claude/skills/gb-standard/scripts/gb_download.py "GB/T 8110-2020" --info

# 下载 PDF 到目录 (免费件直下; 付费件报 FAIL+价格)
python .claude/skills/gb-standard/scripts/gb_download.py "GB 50017-2017" -o outdir
```

## 边界

- 付费件不绕（不注册小号、不碰支付逻辑——账号安全纪律延伸）
- 标准间 sleep 3s 轻节流；官方免费平台 openstd.samr.gov.cn 可作补充
  （采标 ISO 件官方无免费）
- 仅供个人学习研究；商用购正版（中国标准出版社）

## 调研渠道形态

已注册为 ResearchFactory-Eng 渠道 `gbstandard`（标准号→情报卡落盘，
免费件附带 PDF），见 `channels/gbstandard_channel.py`。
