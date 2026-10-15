# 战役实录（2026-10-15/16）

## 起点

E 盘 476.9GB，余 84.9GB。AI-Station 占 388.3GB / 108.8 万文件。

## 普查关键发现

| 分类 | 体积 | 说明 |
|---|---|---|
| PDF 语料 | 157.4 GB | ResearchTopics 战役库 109GB（30,527 个） |
| SQLite | 79.6 GB | local_index 45GB + engopp 30.6GB（在役不动） |
| 浏览器 profile | 35 GB | Auto_Manus 军团（已停用） |
| git 松散 | 15.3 GB | 41,733 个 loose objects |
| 断点残骸 | 17.75 GB | 飞书下载 .tmp 239 个 |
| 缓存 | ~1.5 GB | tmp/pycache/log（不是主菜！） |

**核心认知：空间不是被垃圾吃的，是被「重复」吃的**——sha256 实证 87GB 硬重复（文件名估算仅 71GB）。

## 各波战果

| 波 | 内容 | 回收 |
|---|---|---|
| W1-A | 残骸七批（tmp/profile/缓存/旧日志/MergePDF） | ~22 GB |
| W1-B | git gc（松散 41,733→36） | ~8 GB |
| W2 | 硬链去重（1,690 组 / 26,451 副本 / 零失败） | **87.0 GB** |
| W3-E | 回执制云归档（profiles+harvest+Merge+备份） | ~47 GB |
| W3-D | 实测裁定不接线（语料已压 q40-50，仅省 6.7%） | 0（备份留） |
| **合计** | | **+140.9 GB** |

## E 盘余量

84.9 GB → **225.8 GB**

## 云归档位置

百度网盘 `AI-Station归档/2026-10-16-E批`：
- profiles_assets.7z（10.27GB，3 卷 3.5GB）
- harvest_sessions.7z（0.57GB）
- merge_archive.7z（69MB）
- inventory 备份 ×2

## 踩坑记录

| 坑 | 解法 |
|---|---|
| 云端单文件 >4GB 被 31299 拒 | 预分卷 3.5GB + rejoin 指令写进 parts_manifest |
| py7zr 海量小文件慢（~20/s） | preset 1 比 preset 9 快 40%，压缩率不劣 |
| subprocess 包装脚本崩（stdout None） | 长传任务裸 CLI 直传 |
| 验证门三假红 | 归因式判据：真不变量=删除账×保护区零交集 |
| DIR 行缺字节申报 → 对账必败 | 生成清单时 dirbytes() 算好再写 |
| Windows 长路径 339 字符 | 全链 \\?\ 前缀 |
