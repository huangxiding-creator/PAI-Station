---
name: workspace-hygiene
description: AI-Station 全站磁盘清理与目录整理——普查指纹→提案批准→清单驱动删除→硬链去重→回执制云归档→归因式验证门。当用户要清理项目文件/释放磁盘空间/整理目录/去重/归档转云时触发。
---

# Workspace Hygiene（全站清理术）

## Purpose

对 E:\AI-Station 做安全的空间回收与目录治理。核心信条：**清单驱动删除、每步可对账、验证器先证伪自己**。

## Workflow

六阶段，每阶段有出口门，不过门不进下一段：

### 1. 普查（只读，零风险）
```
py bin/census.py                              # 全站尺寸地图+分类账 → work/census.json
py bin/dedup_scanner.py --root <dir> --out work/dedup_manifest.jsonl --resume
                                              # sha256 指纹全扫（断点续扫）
```
看四个数：**PDF 冗余率**（同 sha 组的多余字节）、**停用资产**（HALTED 旗/零引用件）、**git 松散**（count-objects）、**缓存体积**。前两项是主菜，缓存只是配菜。

### 2. 分类提案（呈用户批准）
按四级处置分类，产出 PROPOSAL：
- **A 硬删**：残骸/可再生（缓存/断点件/停用 profile）
- **B git gc**：松散对象打包
- **C 硬链去重**：同 sha 组保母本+副本 os.link（87GB 级战果）
- **D 有损压缩**：先实测收益再决定（本站实测仅 6.7%，裁定不接线）
- **E 回执制云归档**：压缩→上云→**字节级回验**→删原件

**批准前一个文件都不删。**

### 3. 清单生成（只读）
每批生成逐文件清单 `work/manifest_<批名>.txt`（格式 `<bytes>\t<path>` 或 `DIR\t<path>`）。
DIR 行必须带真实字节申报，否则对账必失败。

### 4. 两段式执行
```
py bin/cleanup_runner.py --batch work/manifest_X.txt --report X      # dry-run
# 核对件数/字节/blocked 后：
py bin/cleanup_runner.py --batch work/manifest_X.txt --go --report X # 执行
```
守卫（先于一切）：保护区前缀拒绝+junction 拒删+长路径 \\?\ 前缀。
blocked>0 = 守卫履职（保护生效），不是失败。

### 5. 硬链去重（可选大杀器）
```
py bin/hardlink_factory.py --manifest work/dedup_manifest.jsonl          # dry-run 计划
py bin/hardlink_factory.py --manifest work/dedup_manifest.jsonl --go     # 链成+台账
```
母本留原位（字典序最短或 --prefer-prefix），副本先链临时名→删原件→原子改名。验 st_ino 相同。

### 6. 归因式验证门（每波收尾必跑）
```
py bin/verify_gate.py --wave W1|W2|W3
```
四项：①测试套件全绿 ②schtasks 31 任务态对拍 ③ammo_pool 抽查（缺件过删除/硬链两账归因——不在账=预存漂移不计失败）④删除账×保护区前缀零交集（真不变量）。

## Output Contract

每批结束产出 work/batch_<名>.md（件数/字节/磁盘差/blocked 清单，容差 1%）。
战役结束产出：corpus/sha_index.jsonl（防复发指纹账）+ DIRECTORY.md 更新 + memory 条目。

## Operating Rules

1. **删除只认用户当次批准的清单**——清单外一个不删（1012 铁律）
2. **junction 禁穿链删**——data/hundun 是 04 智库/混沌学园的联接，穿链删=毁真库
3. **先云后删**——E 批云端字节级回验前一个字节不删
4. 云归档单文件 >4GB 必分卷 3.5GB（百度 31299 帽）
5. 缺件归因：先查 run_progress.jsonl + hardlink_ledger.jsonl，不在两账=预存漂移非我伤
6. 验证器判据要归因式：blocked>0=守卫履职；删除账×保护区零交集=真不变量；mtime 噪声免疫
7. 新语料入库先查 corpus/sha_index.jsonl——命中即硬链，防冗余复发

## References

- [safety-rules.md](references/safety-rules.md) — 保护区前缀清单/junction 红线/回执制细节
- [battle-history.md](references/battle-history.md) — 1015 战役实测数据（388GB 普查→+140.9GB 回收全记录）
