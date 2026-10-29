# kb_generate 云函数部署手册（TCB / 微信云开发·Python）

一句话：小程序端 `wx.cloud.callFunction({name:'kb_generate', data:{text}})` →
本函数真跑 `kb_factory.catalog_engine`（stdlib only 纯规则引擎，零第三方依赖、
零 LLM 调用、无渠道检索）→ 返回与包内样本同构的蓝图视图（≤200KB 传输预算）。

## 目录（最小自含可部署）

```
kb_generate/
├── index.py            入口 main(event, context=None)（别名 main_handler）
├── kb_factory/         引擎子集（pack.py 同步生成；catalog_engine 26 件 .py + 包 __init__）
│   └── MANIFEST.txt    同步清单（来源路径+文件表+包体决策）
├── cloudbaserc.json    @cloudbase/cli 函数配置（name/timeout/envVariables）
├── pack.py             引擎子集同步器（只增不删；重复执行幂等）
├── test_kb_generate.py 离线单测（真网络用例已 skip 保底）
└── DEPLOY.md           本文件（不参与运行，打进包亦无害）
```

首版不含 channel_adapters（渠道 enrich 留服务器侧后续）：`mode="taxonomy"` 固定，
不打真网络，同输入必同输出（确定性）。

收口波B 引擎面扩充（26 件 .py，全 stdlib 零第三方）：新增 cataloging / purpose /
views / skos_export / dendron / storm_breadth / clc_layer + 四词表 loader
（thuocl_lex / fibo_lex / brick_lex / cilin_norm），engine.py 六开关接线
（KB_PURPOSE / KB_COLD_EXPAND / KB_TAXONOMY_GATE / KB_VIEWS / KB_SKOS_EXPORT /
guided）随包同步。**重数据不进包**（见下「包体账」）：seeds/ 词表与本体
（thuocl 6.8M · fibo 76M · brick 2.6M · cilin 3.6M · taxonomy YAML 120K ·
六域种子 ~9.7M）留服务器侧；loader 缺数据一律 fail-soft（route_seeds 记
unavailable_skipped、词池回退 taxonomy 内置表、cilin 默认关直通）。根目录
`taxonomy_loader.py` 不进包（`import yaml`=第三方依赖，破坏云函数零依赖铁律；
引擎未接线，唯一消费方 skos_export.from_taxonomy 云函数路径不调用）。

## 入参 / 出参

- 入参 `event = {"text": "一句话需求", "depth": 可选, "guided": 可选}`
  - `depth` → 引擎规模档：`small|medium|large|huge`（别名 s/m/l/h，或 1..4）；
    缺省/非法 = `large`（与本地旗舰演示样本同档：16 L1 / 3136 槽）；
    另有蓝图深度档 `standard|pro|flagship`（轨A4 透传，槽量 ×1.4/×1.8 放大，
    pro/flagship 自动叠 STORM 多视角广度腿）。
  - `guided` → 导览层三态透传（收口波B）：`true|false` 或 `"1"|"0"` 显式开/关；
    缺省 = 引擎看环境变量 `KB_GUIDED_LAYER`（默认关）。开启时首 L1 前插
    「00-导览」（📥收件箱+五类实体索引，+6 页），视图层同构兼容（实测
    huge 50000 槽 +guided = 50006 槽，传输体仍 ≤200KB）。
- 出参：蓝图 dict `{domain, need, tree, ratio, stats, quote, provenance, _remote}`，
  槽位已瘦身（name/tier/ext/size/icon/src/perm 标签）、每主题组截断 ≤3 条、
  统计与报价为引擎全量真值；`quote.import_add` 为 UI 键名（引擎键在服务端适配）。
- `text` 为空 → 抛 `ValueError`（小程序端按调用失败走本地样本兜底，永不白屏）。

## 环境变量（收口波B 开关面；控制台位：云函数 → kb_generate → 函数配置 → 环境变量）

| 变量 | 生产建议 | 说明 |
|---|---|---|
| `KB_PURPOSE` | **开（=1）**，已写入 cloudbaserc.json envVariables | ① purpose 前置 + ④ 结构 lint 后置。纯代码路径；包内无 seeds 数据时 `route_seeds` 按磁盘实存跳过缺席 file 种子并如实记 `unavailable_skipped`（builtin 种子 six_domains/clc_22 正常路由），实测不崩。 |
| `KB_VIEWS` | **开（=1）**，已写入 cloudbaserc.json envVariables | ⑥ 三视图统一出口（by_topic/by_phase/by_type）。只写 `provenance.views_available`+stage_log S10 行，原树/槽位/stats/quote 零改动。 |
| `KB_GUIDED_LAYER` | 可选 | 导览层进程级开关；小程序端逐请求控制优先用 `event.guided` 透传（三态，显式传参优先于本变量）。 |
| `KB_COLD_EXPAND` | 可选（默认关） | ② 冷门域兜底：clc_layer 巨人 pip 包云函数缺席 → fail-soft 返 None，自动由 dendron 模板兜底（纯代码在包，可用）。 |
| `KB_TAXONOMY_GATE` | **保持关** | ③ 种子分类法门禁需 `seeds/taxonomy/check_taxonomy.py`（未随包），开启即 ImportError 如实崩（设计行为，禁静默放行）；校验执法在服务器侧跑。 |
| `KB_SKOS_EXPORT` | **保持关** | ⑤ SKOS JSON-LD 导出是产物落盘侧挂钩（引擎零 IO 纪律）；云函数只读文件系统无落盘位，导出归服务器/CLI 侧 `skos_export.export_blueprint`。 |
| `KB_CILIN_NORM` | **保持关** | 词林归一：数据版权需上游授权评估（模块头合规标注），且 cilin.json（3.6M）未随包；关态入口原样直通零漂移。 |

缺省全关 = 引擎输出与既有版本逐字节零漂移（最高优先级口径）。

## 部署步骤

```powershell
# 0) 前置：Node + @cloudbase/cli（一次性）
npm install -g @cloudbase/cli@latest
tcb login

# 1) 同步引擎子集（上游 catalog_engine 有改动后重跑；只增不删）
cd E:\AI-Station\kb_factory\cloudfn\kb_generate
py -3 pack.py

# 2) 部署（-e 换成你的环境 ID；已存在则覆盖更新）
tcb fn deploy kb_generate -e <envId>

# 3) 控制台核对（https://console.cloud.tencent.com/tcb → 云函数 → kb_generate）
#    入口         index.main（SCF 习惯命名亦可：index.main_handler，已做双别名）
#    运行内存     512MB
#    超时时间     20 秒（引擎纯规则实测毫秒级，20s 留足冷启动余量）
#    运行环境     Python（选控制台可用最新版；引擎 3.7+ 兼容，无第三方依赖免安装）
```

## 验证

DevTools console（app.js 已 `wx.cloud.init({env: wx.cloud.DYNAMIC_CURRENT_ENV})`）：

```js
wx.cloud.callFunction({ name: 'kb_generate', data: { text: '水利工程质量验收' } })
  .then(r => console.log(r.result.stats, r.result.quote.total))
// 期望：{files: 3136, gb: 4.64, l1_count: 16, l2_count: 224, ...} 38.3
```

curl 例（需在控制台开启「HTTP 访问服务」并绑定路径 `/kb_generate`）：

```bash
curl -X POST "https://<envId>.service.tcloudbase.com/kb_generate" \
  -H "Content-Type: application/json" \
  -d '{"text": "水利工程质量验收"}'
```

本地自测（零部署）：

```powershell
cd E:\AI-Station\kb_factory\cloudfn\kb_generate
py -3 -c "import index; bp=index.main({'text':'水利工程质量验收'}); print(bp['stats'], bp['quote']['total'])"
py -3 -m pytest test_kb_generate.py -q
```

## 资源账（实测，非手填）

- **包体**：vendored `kb_factory/` 全包实测 **388KB / 27 件**（同步集 386KB + MANIFEST；
  `__pycache__` 不计），预算 ≤2MB 达标——重数据（seeds 词表/本体/词林，合计 ~96M）
  不进包留服务器侧（决策与实测数同录 MANIFEST.txt）。
- 传输体：全部档位 ≤200KB（与包内样本同一预算）。收口波B 实测：基线 120KB ·
  clc+pro 114KB · flagship 115KB · guided 开 117KB · huge+guided 111KB ·
  KB_PURPOSE+KB_VIEWS 双开 111~116KB——全档守线。
- 耗时：taxonomy 纯规则毫秒级（large 3136 槽），huge 50000 槽约秒级。
- 内存：huge 档约几十 MB，512MB 配置宽裕。

## 后续（不在首版）

- 渠道 enrich（channel_adapters 有网络依赖）→ 服务器侧调用后回写 `real` 文件标记。
- depth 由小程序端按用户选择上行（服务端已就位）。
- seeds 数据消费（thuocl/fibo/brick/cilin 词表命中加权、taxonomy YAML 真源、
  KB_TAXONOMY_GATE 门禁执法）→ 全部留服务器侧；云函数需要时另行评估
  （COS 挂载或按 ≤2MB 预算精选子集随包，届时 pack.py 数据决策段同步改）。
