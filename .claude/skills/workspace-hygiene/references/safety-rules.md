# 安全规则（不可协商）

## 保护区前缀（硬编码在 hygiene_common.py）

以下前缀下的一切路径 cleanup_runner 一律拒删（blocked_protected）：

| 前缀 | 理由 |
|---|---|
| E:/AI-Station/data/local_index | D 路 GLOB 金矿索引（index.db 45GB 在役） |
| E:/AI-Station/EngOpp-Mining/data | 工程机会挖掘库（engopp.db 30.6GB） |
| E:/AI-Station/IdeaDig | 选题数据 |
| E:/AI-Station/乐奇AI眼镜 | 在役产品知识库（10-12 仍活动） |
| E:/AI-Station/04 智库 | 智库语料实体 |
| E:/AI-Station/data/hundun | **junction！**指向 04 智库/混沌学园——穿链删=毁真库 |
| E:/AI-Station/.claude | 技能/记忆/会话 |
| E:/AI-Station/reforge_factory | 产线引擎 |
| E:/AI-Station/tools | 常驻工具+31 计划任务引用 |
| E:/AI-Station/ammo_pool | 弹药池 |
| E:/AI-Station/report_platform | 发布平台 |
| 密钥 basename | secret.ini / virtual_pay.secret / video_account_state.json |

## junction 检测

cleanup_runner 双检：`os.path.islink()` 或 `os.path.isjunction()` + `realpath != path` → exit 3 拒删。
**绝对禁止**通过 junction 路径做任何删除操作。

## 回执制（E 批）

```
压缩（py7zr preset 1，>4GB 分卷 3.5GB）
  → 上云（bdpan upload，裸 CLI 直传）
  → 回验（bdpan ls --json 取 size 与本地对拍，分卷和=源字节）
  → 删原件（cleanup_runner --go，清单驱动）
  → 暂存清场（7z 正本+分卷+断点碎片）
```

**云端字节级回验前一个字节不删。**

## 可再生缓存名（豁免保护区判定）

以下 basename 的目录即使在保护区内被删也不算违规（会自动再生）：
`__pycache__` `.pytest_cache` `Code Cache` `GPUCache` `Cache_Data` `Service Worker` `DawnCache` `GrShaderCache` `ShaderCache` `Crashpad`

## 归因式判据（验证门核心）

| 现象 | 判定 | 依据 |
|---|---|---|
| 缺件在 run_progress.jsonl（status=deleted）| 清理伤害 FAIL | 删除账实锤 |
| 缺件在 hardlink_ledger.jsonl | 清理关联 WARN | 链接操作涉及 |
| 缺件不在两账 | **预存漂移不计失败** | 采集管线断点/同步漂移 |
| blocked > 0 | **守卫履职 PASS** | 拦截件被跳过=保护生效 |
| 删除账路径 × 保护区前缀有交集 | **FAIL** | 真不变量被破坏 |
| 删除账路径 × 保护区前缀零交集 | **PASS** | 真不变量成立 |
