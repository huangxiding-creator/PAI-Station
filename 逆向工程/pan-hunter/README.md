# PAN-HUNTER — 全网网盘资源检索与免登下载 CLI

> 逆向工程/pan-hunter · W0-W4 收官（2026-10-30/31）。宪法=[PROPOSAL.md](PROPOSAL.md)（法务四原则）。
> 一句话：**全网免登发现 + 绿盘免登直下**；黄盘交付=本地凭据插件（默认关，凭据零托管）。

## 快速上手

```powershell
python -I E:\AI-Station\逆向工程\pan-hunter\ph.py search "水电站 施工组织"   # 两栏：绿盘可直下 + 全部命中
python -I E:\AI-Station\逆向工程\pan-hunter\ph.py discover "https://pan.quark.cn/s/xxx"   # 黄盘列表+探活
python -I E:\AI-Station\逆向工程\pan-hunter\ph.py download "https://www.lanzoui.com/xxx" --out E:\dst
python -I E:\AI-Station\逆向工程\pan-hunter\ph.py gates      # 十盘真件门红绿灯台账
python -I E:\AI-Station\逆向工程\pan-hunter\ph.py doctor     # 盘矩阵+发现层+插件态体检
python -I E:\AI-Station\逆向工程\pan-hunter\scripts\health_round.py   # 源健康轮（≤7 天一跑）
```

Claude 自然语言直达：技能 `pan-hunter`（E:\AI-Station\.claude\skills\pan-hunter\SKILL.md），
与 bdn（自家盘全盘）/ baidu-drive（沙箱·转存·记忆）/ ebook-treasure（中文书名）四技能分区路由。

## 能力现状（数字全实测，台账为证）

- 源中枢：38 配方源实测 **9 活源**（analysis/SOURCE_AUDIT_1030.md）；健康轮基线 7/9（analysis/health_rounds/）。
- 绿盘：**5/10 过真件门**（uc/lanzou/ilanzou/feijipan/ecpan，≥10MB 真件落盘+sha1，analysis/W1_GREEN_GATES.md）；
  115/光鸭=绿?·owner 开关型、wss=绿?·无当活链。
- 黄盘发现层：**4.5/5 成立**（百度 6/8·阿里 7/8·夸克 16/16·139 2/2·迅雷链路通，analysis/W2_DISCOVERY.md）。
- 北极星：200 本抽书 **182/200 命中（91.0%）·绿盘可下率 15/200（7.5%）**（analysis/NORTH_STAR_BASELINE.md）。

## MCP 挂接（Claude Code）

三工具：`panhunter_search(kw)` / `panhunter_discover(url, pwd?)` / `panhunter_doctor()`——
stdio 传输、零第三方依赖（mcp_server.py 手写 JSON-RPC 最小面；与 CLI 同源同频控同预算铁律）。

命令行挂接（用户自执；默认 local scope，加 `-s user` 全局）：

```powershell
claude mcp add pan-hunter -- python E:\AI-Station\逆向工程\pan-hunter\mcp_server.py
```

挂接后 `/mcp` 面板可见 pan-hunter 三工具；卸载 `claude mcp remove pan-hunter`。
本地自测（不挂 Claude 也能验协议合法性）：`python E:\AI-Station\逆向工程\pan-hunter\scripts\mcp_selftest.py`。

## 免责与边界

1. **只打公开分享面**：本工具只索引/访问无需登录即可到达的公开分享页面与匿名接口
   （BDCLND/share_token/stoken 等均为分享面派生令牌，非用户凭据）。**不含任何付费墙/会员墙/限速破解**；
   123 云盘免费层墙（5112）、迅雷/夸克/阿里/百度直链凭据墙等一律如实标注，不绕行。
2. **收割物仅内部调研语料，不进付费交付物**：下载件用于通道测试与调研语料（每次 download 成功自动落
   `analysis/download_audit.jsonl` 审计行：ts/url/盘/大小/sha1/purpose=research）；对外付费交付只收整编/原创内容。
3. **不建公开索引库、不转存再分发**（无公开策展原则）；命中 URL 台账仅私有留痕。
4. **凭据零托管**：永不代收用户盘 Cookie/账号；黄盘本地凭据插件默认全关（plugins/config.json），
   凭据文件由用户本地自供、禁入仓。
5. **数字以台账为准**：一切活源数/成功率/红绿灯/门件 sha1 以 `analysis/` 目录实测台账为准，
   对外声明禁手填禁估算；红盘不承诺交付、黄盘不说「可下载」、绿?不冒充绿。
6. **频控在身**：单源间隔≥2s、并发≤4、发现层≤150 发/进程、下载截断 1.5GB；请勿并行加压。

## 目录导览

| 路径 | 内容 |
|---|---|
| ph.py / mcp_server.py | CLI 五命令 / MCP 头三工具 |
| engine/sourcehub/ | 源中枢（recipes 38 源+searchagg 聚合）+ adapters 十盘 + discovery 五盘 + plugins 凭据插件框架 |
| engine/pansou/ | pansou 上游 MIT 冻结副本（配方库；月度增量合并义务） |
| analysis/ | 全部实测台账（门账/审计/健康轮/北极星/W4_QA） |
| scripts/ | 跑批与工具件（gate_hunt/health_round/mcp_selftest 等） |
| METHODOLOGY.md | 本役方法论沉淀（六大判例） |
