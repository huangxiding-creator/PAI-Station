# RUN_LEDGER — 第22/23渠道双交付 (pansou + ChinaTextbook)

- **日期**: 2026-10-04
- **令源**: 用户两连令（Arc F: pansou 注册调研渠道 / Arc G: ChinaTextbook 整合调研渠道）
- **形态**: 渠道注册（github项目转技能+渠道双交付 doctrine, 1003 定型）
- **落点**: ResearchFactory-Eng `EPC100/collectors/pansou/` + `EPC100/collectors/chinatextbook/`，named_channels 21→23
- **编号收口**: 同日发现 zh-search-pro（夜班会话建成时自称第22但未入册）→ manifest 补录为第24条，22/23 维持 pansou/chinatextbook 注册时序（commit 9b149f5）

---

## 第22渠道 pansou (网盘聚合发现)

| 项 | 值 |
|---|---|
| 上游 | fish2018/pansou (Go, MIT, 14776★) |
| 部署 | 源码构建 `EPC100/services/pansou/pansou.exe` (Go1.25.14 静态 30MB, 本机 :8888 常驻) |
| 工具链坑 | go1.27 与 sonic v1.14 不兼容 (`GoMapIterator` undefined) → 降 1.25.14 全绿; GOPROXY=goproxy.cn; CGO_ENABLED=0 |
| 引擎 | TG 56频道 + 插件5白名单 (labi/zhizhen/shandian/duoduo/muou) |
| 风险线 | 白名单排除账号型/成人盗版/裸IP; 永不 refresh 绕缓存; AUTH_ENABLED+JWT; 30s/300/900s/10 节流四件套; 24h 词去重 |
| 定位 | 发现+链接留档, 不下载/不转存/不分发文件本体 |
| 实车判据 | health ok(56频道/5插件/状态ok) · 三体15命中(uc/aliyun/quark/baidu) · 15卡入册 · conductor J1072315270 heavy 窗入队 · 账本 run ✅ 五连过 |
| 契约修正 | `/api/health` 无信封直回(信封检测按 code 键有无分流) — 实车才暴露 |
| 稀疏事实 | 白名单5插件偏文娱密度: 工程词(工程总承包/考研)0命中为诚实空; 文娱词(三体)15命中 |
| 运行态隔离 | `EPC100/services/` 整目录 gitignore (exe/auth.env/pid/cache) |

## 第23渠道 chinatextbook (全套教材语料库)

| 项 | 值 |
|---|---|
| 上游 | TapXWorld/ChinaTextbook (82520★, 43.5GB, master 分支, License=None) |
| 目录 | `git/trees/master?recursive=1` 单调用全树(3112条/truncated:false), 网络败退 1004 离线种子 `tools/downloads/ctb_tree.json` |
| 规模 | 2087 册 (1905整书+182分卷组); 路径分类学 L1学段→L2学科→L3版本-出版社→L4年级 |
| 取书 | raw.githubusercontent ↔ gh-proxy.com 双梯(实测 200+Range); codeload 422 死路 |
| 分卷根治 | 官方 mergePDFs.go `sort.Strings` 字典序在 ≥10 卷组必坏(上游实存 pdf.11 组) → 整数后缀排序+纯字节拼接+%PDF魔数/字节和双校验 |
| 定位 | 存量语料引用(弹药门槛语义: 不计门槛, 成稿可引用); License=None → 小段引用+页码溯源, 不转存分发 |
| 实车判据 | api源刷目录2087册 · 高中∪数学693册 · 90KB答案卷字节精确落盘 · 2卷组48,068,561字节合并双验 · conductor net:ctb 入队+账本 run ✅ 五连过 |
| 带宽实态 | raw 直连 CN ≈105KB/s(48MB书7.6min) → 小书优先+limit 3+heavy 夜窗已内建 |
| P1 缓行 | 国家中小学智慧教育平台腿: s-file-1 JSON 匿名可达但 r1/r2/r3-ndr-private PDF 401, 需用户 ND_UC_AUTH(7d TTL)+X-ND-AUTH MAC 签名 — 等用户给凭据再启 |

## 接线与验证

- `epc100_channels.py` 主链两腿(try/except 隔离) + named set + coverage 完备门
- `channel_manifest.json` named 21→23 (pansou/chinatextbook 各一条)
- 单测 18+12=30 件新增; 全套 **271 passed** (10.1s)
- conductor: pansou→`api:pansou` / chinatextbook→`net:ctb`, 均 heavy 窗, 幂等入队
- 对抗性审查: 三维(correctness/security/ops)评审+逐条反驳验证 workflow (wf_13816ec8) — 结论见本档追加节

## 追加: 对抗性审查结论

(workflow 完成后回填)
