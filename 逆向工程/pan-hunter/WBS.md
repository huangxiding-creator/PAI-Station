# WBS · PAN-HUNTER（全网网盘资源检索下载超级 CLI）

> 沿 bdn 战役台账格式。宪法=PROPOSAL.md（三级能力+法务四原则，2026-10-30 用户全案批准）。

| 波 | 内容 | 出口门 | 状态 |
|---|---|---|---|
| W0 | 基建半周：pansou 架构裁决+克隆、curl_cffi 装配+CF 墙对照、源中枢骨架、**源效度审计**（覆盖叙事改实测口径）、aria2 检查 | 引擎起活+实测活源数基线落 analysis/SOURCE_AUDIT_1030.md | ✅ 2026-10-30（裁决=配方库路线；aria2 缺→deferred parfive 顶） |
| W1 | 一级能力：10 绿盘 adapter + 每盘一真件端到端 + 光鸭匿名态定夺；ebook-treasure 抽 200 本北极星基线 | 全绿盘过真件门；命中源数×绿盘可下率出数 | 🔄 10-31 进行中（adapter 10/10 落地；门跑批+北极星并行；详情 RUNLOG） |
| W2 | 二级能力：大四盘免登列表+探活+bdn 凭据插件+139 列表 | 发现/交付两栏声明成型；插件默认关验证 | ⏸ |
| W3 | 长尾攻坚+健康轮：天翼 SSK/123 域名字典/曲奇核验/CF 质询源浏览器栈腿（yiso/miaosou/miosou Anubis）/源健康自动化 | doctor 报实测活源数；死源摘牌 SLA | ⏸ |
| W4 | 产品化：MCP 头+CLI 打磨+免责文案+商用防火墙审计位+发布 | 法务四原则引擎侧留痕 | ⏸ |
| W4.5 | 中期复审（数字报告呈用户裁决） | 用户裁决 | ⏸ |

## W0 细目账

| # | 件 | 状态 |
|---|---|---|
| W0-1 | pansou 克隆（代理 7892，MIT 冻结副本）engine/pansou/ 122 插件全量 | ✅ depth-1 副本 |
| W0-2 | 架构裁决：运行时 vs 配方库（证据链见 SOURCE_AUDIT §1） | ✅ 配方库+Python 中枢 |
| W0-3 | curl_cffi 0.17.0 + parfive 2.3.1（清华源）；aria2 缺→deferred | ✅ |
| W0-4 | HTTP 层定案对照（requests vs curl_cffi × 直连/代理） | ✅ scripts/http_layer_verdict.py |
| W0-5 | 源中枢骨架 engine/sourcehub/（recipes 38 源配方表+core 执行器+audit_w0 跑批+report_gen） | ✅ |
| W0-6 | 源效度审计 3 关键词 × 38 源 → analysis/SOURCE_AUDIT_1030.md | ✅ 149 发/204s：**活源 9/38**、零命中 9、SPA 壳 4、CF 墙 5、反爬 2、死 9（零造假） |
