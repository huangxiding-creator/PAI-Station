# seeds/taxonomy 变更账（Shopify 制式垂直域 YAML 三件套）

制式蓝本：巨人 [Shopify/product-taxonomy](https://github.com/Shopify/product-taxonomy)（MIT）——
每垂直域一 YAML，五顶层件：`version` / `sources`(出处与许可证) / `tree`(层级，深度硬顶 3) /
`attributes`(属性字典，校验器按此执法) / `values`(受控词表)。

## v1.0.0 — 2026-10-25（KB-FACTORY v2.7 #6，波B 结构手术轮·种子治理重构）

一次性迁移：seeds/ 既有种子真源 → 本目录新制式（**增量真源，旧 JSON 一律保留不删**）。
迁移器 `seeds/taxonomy/_work/migrate_to_yaml.py`（幂等可重放），对账账本 `migrate_report.json`。

### 新增三件

| 垂直域 YAML | 内容 | 旧真源 |
|---|---|---|
| `engineering_epc.yaml` | 工程总承包六库 49 分组树（根→库→分组，恰三级）+ 每分组蓝图实灌槽位 | `catalog_engine/taxonomy.py::SIX_DOMAINS`（zhiku.js vaults 逐字实读）+ `seeds/0*.json` 同名 l2 分组 file_count 求和 |
| `thuocl_lexicon.yaml` | THUOCL 11 域摘要索引（词数/df 剔除数/raw sha256/就近映射分组） | `seeds/thuocl/_summary.json` + `seeds/thuocl/<域>.json`（词数据本体仍在 JSON） |
| `fibo_ontology.yaml` | FIBO 8 模块索引（主干5+闭包3，逐模块统计平铺）+ FND 基座五概念组 + zh_map 台账位 | `seeds/fibo/*.json`（2625 概念仍在 JSON；概念层级最深 11 级进不了 ≤3 级树，故只迁索引） |

### 守恒对账（migrate_report.json，before/after 逐项相等，after 从落盘 YAML 回读实算）

- 六库：库 6 / 分组 49（MK3 EN4 EX7 KN18 CA13 RB4）/ 槽位 38 分组×10 + 11 分组×0 = 380
- THUOCL：域 11 / 词 143,433 / 映射边 13 / 命中分组 10 / skipped 4 / dropped_df≤1 13,734
- FIBO：模块 8 / 概念 2,625 / zh_map 340 / 基座组 5（机构25 主体26 文件15 时间20 量21=107）
- 校验器全库 0 错（`check_taxonomy.py` 五律）

### 配套件（本波新增，均在任务域内）

- `check_taxonomy.py`：五律校验器（孤儿/重复ID/深度>3/命名/受控词表外引用），CLI+可导入
- `taxonomy_loader.py`（kb_factory 根）：loader 兼容层，YAML 优先缺则回退旧真源；
  三大兼容契约（SIX_DOMAINS / _summary.json / fibo 模块索引）深度相等有测试硬断言
- 测试：`tests/test_taxonomy_migration.py`（守恒+兼容+回归）+ `tests/test_check_taxonomy.py`（五律正负例）

### 待收口波接线（本波禁碰 engine.py/blueprint.py，只留口）

1. 引擎门禁：engine S-1 前跑 `check_taxonomy.validate_library()`，非 0 错拒产蓝图
2. 消费换线：`taxonomy.SIX_DOMAINS` 引用可换 `taxonomy_loader.six_domains()`（零行为漂移）
3. CI 位：`python seeds/taxonomy/check_taxonomy.py --json` 直插

### 纪律备查

- `seeds/brick`、`seeds/cilin` 为并行任务新域，本波未动未吞
- 旧 JSON 种子（六库蓝图 10 件 / THUOCL 11+1 / FIBO 8+2）全量保留，零删除
