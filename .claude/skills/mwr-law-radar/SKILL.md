---
name: mwr-law-radar
description: 水利法规雷达——水利部监督司法规制度(sljd.mwr.gov.cn/fgzd)镜像+本地水利法规库+知识库聚合的快速检索。当用户要查水利法规/规程/管理办法/监督制度要求、检索"某工程要素适用哪些法规"、或更新 sljd 镜像时使用。触发词：水利法规、法规雷达、监督司、sljd、适用法规、法规检索。
---

# 水利法规雷达（MWR Law Radar）

REA 式逆向 sljd.mwr.gov.cn/fgzd/ 沉淀（2026-10-20，用户令）。三源聚合秒级检索：
① **sljd 监督司镜像**（45 件制度/监督检查指导手册，全量 JSON 快照）
② **本地水利法规库**（07任务/03目录 88 件：部门规章25+规范性文件58+政策5）
③ **planchief KB 八层**（220 文档 5800 块 FTS5，含法规/标准/体系/31范本/ima）

## 用法（scripts/radar.py）

```bash
# 检索法规（关键词，中英混均可）
py -X utf8 <skill_dir>/scripts/radar.py search "安全生产 监督检查"

# 工程要素扫描 → 适用法规建议（策划/方案编制用）
py -X utf8 <skill_dir>/scripts/radar.py sweep 围堰 移民安置 水土保持 验收 质量检测

# 全文 KB 检索（含范本/标准/方法论八层）
py -X utf8 <skill_dir>/scripts/radar.py kb "单元工程 优良率"

# 更新 sljd 镜像（限速全站，~2分钟）
py -X utf8 <skill_dir>/scripts/radar.py mirror
```

## 数据位置（勿删改）

- 镜像快照：`E:\AI-Station\planchief\data\radar_cache\sljd\*.json`（GBK→UTF-8 已转，含正文/附件URL/日期）
- KB：`E:\AI-Station\planchief\data\kb.db`（重建：`py -X utf8 E:\AI-Station\planchief\tools\build_kb.py`）
- 本地法规源：`E:\AI-Station\07 任务\AI项目管理策划\03 项目管理策划规则`（只读）

## 站点情报（逆向沉淀）

- sljd.mwr.gov.cn/fgzd 实为 UTF-8（非 GBK，严格 UTF-8 解失败才回退 GBK）
- 列表页仅 3 页（index.html/index_1/index_2），文档 URL 模式 `./YYYYMM/tYYYYMMDD_*.html`
- 正文含附件(.doc/.docx/.pdf)链接——只记录 URL 不自动下载
- 配套：国家法律法规数据库 flk.npc.gov.cn（法条原文权威源，雷达输出附链接）

## 典型场景

- "水利工程围堰施工要满足哪些监管要求？" → `sweep 围堰` → 法规清单+条文摘录
- 策划方案第X章编制前 → `sweep 本章要素` 取依据链候选
- 新政策发布后 → `mirror` 增量更新再检索
