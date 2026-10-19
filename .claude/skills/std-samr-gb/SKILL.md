---
name: std-samr-gb
description: 国家标准全文公开系统(std.samr.gov.cn / openstd.samr.gov.cn)全量逆向客户端。当用户要查国标清单、按行业/ICS 拉全量标准、按关键词批量下载国标全文 PDF、下载 GB/GB-T 标准、生成行业标准动态清单时使用。触发词：国标、标准清单、行业标准清单、下载标准、GB 标准、std.samr、openstd、国家标准全文公开。已在 2026-10-19 全链实测（检索/行业/详情/全文收割/PDF 合成）。
---

# std-samr-gb — 国标全文公开系统客户端

一键三能：**①任意行业全量标准清单 ②关键词检索 ③批量下载全文 PDF**。免登录、无验证码（阅读通道）。

## 快速用法

```bash
SKILL_DIR="$(dirname "$0")"   # 会话内以实际路径代入
cd <skill目录>/scripts

# 1) 关键词检索（--state 可重复给 现行/废止/即将实施）
py -X utf8 cli.py search 液压电梯 --state 现行 --out list.jsonl

# 2) 行业全量清单（ICS 一级类目 43=道路车辆工程；给编号/名称/子串均可）
py -X utf8 cli.py industry 43 --out industry_43.jsonl          # 仅现行
py -X utf8 cli.py industry 91 --all-states --out industry_91_all.jsonl
py -X utf8 cli.py ics-list                                    # 看 40 个类目

# 3) 关键词批量下载全文 PDF（每标准一个子目录 + manifest.jsonl 台账）
py -X utf8 cli.py download 混凝土排水管 --dir out/ --state 现行 [--limit 20]
py -X utf8 cli.py download-id <std_id> [std_id...] --dir out/

# 4) 单条详情（标准号/日期/CCS/ICS/归口/主管部门/hcno）
py -X utf8 cli.py detail <std_id>
```

清单 JSONL 字段：`id, C_STD_CODE(标准号), C_C_NAME(名称), STD_NATURE(性质), STATE(状态), ISSUE_DATE, ACT_DATE, PROJECT_ID`。
下载台账 manifest.jsonl 额外含 `hcno/CCS/ICS/归口/主管部门/pages/pdf/status`——status∈{ok,no_text,fail,exists}，**计数以 manifest 落盘为准，禁手填**。

## 编程用法

```python
from samr_lib import SamrClient, ICS_CATEGORIES
c = SamrClient()
rows = c.industry("43.道路车辆工程", states=["现行"])      # 全量清单
for r in c.search_all(text="电梯", states=["现行"]): ...   # 迭代不载全内存
det = c.detail(rows[0]["id"])                              # 拿 hcno
res = c.harvest(det["hcno"], out_dir="out/GB-XXX")         # -> PDF + 汇总
```

## 逆向协议要点（2026-10-19 实测，详见 references/protocol.md）

1. **检索 API 免认证**：`GET std.samr.gov.cn/gb/search/gbQueryPage?searchText=&ics=<中文全称>&state=G_STATE:"现行"&ISSUE_DATE=&pageNumber=&pageSize=`，JSON，pageSize 实测可 500，全库约 7.98 万件。
2. **详情→阅读器**：`/gb/search/gbDetailed?id=` 页内正则 `newGbInfo\?hcno=([0-9A-F]{32})` 取 hcno。
3. **阅读器会话链**：先 GET `openstd.../bzgk/std/newGbInfo?hcno=`（拿 JSESSIONID），再 GET `/bzgk/std/showGb?type=online&hcno=`，**必须带上一页 Referer，否则 302 弹回详情页**。静态 HTML 即含全部页与拼图映射（span class=`pdfImg-{L}-{T}`=目标 10% 网格位，style background-position=源图瓦片位，瓦片 232×328）。
4. **分块大图闸门**：`/bzgk/std/viewGbImg?fileName=<token>` **必须带请求头 `Cache-Alive: chunked`**，否则 302→静态直链 0 字节。每块 webp（2320 宽）覆盖约 4-5 页，整本多块。
5. **重组**：按 span 映射贴瓦片→页 PNG→PIL 合成 PDF（JPEG 质量 82）。
6. 原生 PDF `viewGb?hcno=` 多数标准无下载按钮（纯预览制），图像重组即通用通道；`try_native_pdf()` 为机会通道。
7. 部分标准无全文公开（detail 无 hcno）→ 台账记 `no_text`，如实呈现。

## 参数速查

- `--state 现行|废止|即将实施`（可多次）；不传=全部状态
- `--ics`：编号 `43` / 名称子串 `道路` / 全名 `43.道路车辆工程`
- `--min-delay/--max-delay`：礼貌延时（默认 0.4–1.0s），批量下载勿低于此
- `ISSUE_DATE` 近效过滤（API 支持 -1/-3/-6/-12/-24/-36 月，CLI 未暴露，编程可用）

## 故障处置

- **检索 403/异常 payload**：先 `py cli.py search 测试` 自检；站点若上 WAF，用 DrissionPage 真浏览器暖会话导出 Cookie（`逆向工程/std-samr/scripts/dp_recon_reader.py` 为蓝本，端口务必 **9411**，勿碰 9222/9336/9337）。
- **chunk 0 字节/404**：确认 `Cache-Alive: chunked` 头在；token 过期则重拉阅读器 HTML。
- **PDF 打不开**：检查 PIL 版本 ≥9；页数为 0 见 manifest error 字段。
- REA 抓包通道（capture_browser_scenario）在本机 2026-10-19 实测挂起（1800s 无响应，已清理其孤儿 Chrome）；协议分析以 curl 直调 + DrissionPage 实测为准。

## 铁律

- 数字零造假：一切清单行数/下载数以落盘 JSONL/manifest 实测为准。
- Chrome 进程守门：任何浏览器自动化只杀自己拉起的（按 user-data-dir 特征），WeAIPO(9222)/mp(9336)/视频号(9337) 永不触碰。
- 批量下载节奏 ≥0.4s/请求，勿打政府站。
