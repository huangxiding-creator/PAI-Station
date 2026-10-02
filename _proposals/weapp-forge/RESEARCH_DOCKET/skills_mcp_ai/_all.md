# skills_mcp_ai 渠道调研：AI 辅助小程序开发三大生态

- 生成时间：2026-09-27 21:20 (+08:00)
- 调研范围：(A) Claude Skills 生态小程序 skill；(B) MCP server 生态；(C) AI 生成器/低代码格局 + 端到端缺口证据
- 条目数：**49 条**（skill 19 / mcp 9 / repo 9 / product 8 / doc 4），机器可读版见同目录 `_all.json`
- 方法：gh api 实测搜索（含中文 URL 编码查询）+ npm registry API 实测 + skills.sh 搜索 API 实测 + mcp.so/smithery/glama 实测 + WebSearch 多源交叉。官方文档页为 SPA 直抓失败处均已标注并经多源交叉证实。

---

## A. Claude Skills 生态（小程序相关 skill 全景）

| # | 品 | 星/安装 | 覆盖环节 | 一句话边界 |
|---|---|---|---|---|
| A1 | [anthropics/skills 官方库](https://github.com/anthropics/skills) | 178616★ | **无小程序条目** | 19 个 skill 全是通用文档/Web 场景，官方零覆盖 |
| A2 | [skills.sh 市场](https://skills.sh/api/search?q=miniprogram) | 实测 | 全景 | 小程序类最高安装 1324，对比通用类 164853 差 **124 倍** |
| A3 | [Gourdbaby/wechat-miniprogram-skill](https://github.com/Gourdbaby/wechat-miniprogram-skill) | 9★ / 装1324 | 编码规范 | 规则集：setData/rpx/iOS 日期坑，无流程能力 |
| A4 | [wechat-miniprogram/skyline-skills](https://github.com/wechat-miniprogram/skyline-skills)（官方） | 55★ / 装831-979 | Skyline 知识 | 8 个文档切片，只管渲染引擎迁移 |
| A5 | [wechatpay-apiv3/wechatpay-skills](https://github.com/wechatpay-apiv3/wechatpay-skills)（官方） | 359★ / 装1414 | 支付知识 | 选型/示例/质检/排障四能力，知识型非流水线 |
| A6 | [Sun-sunshine06/miniprogram-skills](https://github.com/Sun-sunshine06/miniprogram-skills) | 25★ | 开发+DevTools 诊断 | 社区小程序 skill 星数第一，绝对值极低 |
| A7 | [asdyych/wechat-miniprogram-skill](https://github.com/asdyych/wechat-miniprogram-skill) | 16★ | 开发知识 | 单件 |
| A8 | [beeyang0/miniprogram-VirtualPayment](https://github.com/beeyang0/miniprogram-VirtualPayment) | 21★ | 虚拟支付接入 | 文档型，依赖已有工程 |
| A9 | [Hongyi999/miniprogram-skill](https://github.com/Hongyi999/miniprogram-skill) | 2★ | 从零到部署（号称） | 最接近端到端，零影响力无验证 |
| A10 | [Billzhouheart/wechat-miniprogram-designUI](https://github.com/Billzhouheart/wechat-miniprogram-designUI) | 5★ | 设计规范/审核红线 | 单件 |
| A11 | [bx33661/miniapp-audit-skills](https://github.com/bx33661/miniapp-audit-skills) | 3★ | 安全审计 | 单件 |
| A12 | [youxiyin/claude-skill-miniprogram-sop](https://github.com/youxiyin/claude-skill-miniprogram-sop) | 0★ | 端到端 SOP（号称） | 5 阶段+5 人闸概念稿，与提案同构但零落地 |
| A13 | [Zacklinkk/wechat-dev-docs-skill](https://github.com/Zacklinkk/wechat-dev-docs-skill) | 3★ | 官方文档 agent 化 | 知识检索单件 |
| A14 | [mzopedia/develop-wechat-ai-miniprograms](https://github.com/mzopedia/develop-wechat-ai-miniprograms) | 0★ | 开发-验证-发布 SOP | 覆盖到发布但无人用 |
| A15 | [whinc/super-skills](https://skills.sh/api/search?q=miniprogram) | 装364+327 | automation + CI 上传 | 两零件分家，无编排 |
| A16 | [watertian/wechat-devtools-mcp](https://github.com/WaterTian/wechat-devtools-mcp) | 145★ / 装440 | DevTools 操作（MCP+Skill 双形态） | glama 已收录 |
| A17 | [sdaxiji-beep/codex-skills](https://github.com/sdaxiji-beep/codex-skills) | 4★ | NL→小程序 | 个人尝试 |
| A18 | [jasondu/wechat-miniprogram-dev-skill](https://github.com/jasondu/wechat-miniprogram-dev-skill) | 1★ | CloudBase 方向 | 单件 |
| A19 | 对照：[aiworkskills/wechat-article-skills](https://github.com/aiworkskills/wechat-article-skills) | **643★** | 公众号全流程 | 同生态内容侧全流程 skill 已成立并获社区认可 |
| A20 | 对照：[wechat-claude-code](https://github.com/Wechat-ggGitHub/wechat-claude-code) | 685★ | 微信↔CC 桥 | 微信工具类 skill 有真实需求，全在通信/内容侧 |

**A 节结论**：小程序开发 skill 存在约 15+ 个但全部碎片化——星数最高 25、安装最高 1324，没有一个项目同时覆盖"脚手架→编码→编译→预览→上传→审核→发布"。youxiyin 与 Hongyi999 两个 0-2★ 的项目喊出了端到端口号但零落地，恰恰证明"有人想要、无人做成"。

## B. MCP server 生态

| # | 品 | 形态/活跃度 | tools 覆盖 | 边界 |
|---|---|---|---|---|
| B1 | [微信官方文档《使用 Skill/MCP 辅助小程序开发》](https://developers.weixin.qq.com/miniprogram/dev/devtools/skill/) | 官方文档 | 官方两路径：DevTools 装 MCP / 装 CloudBase Skill | 定位"辅助已有项目"，非从零生成 |
| B2 | [官方「微信开发者工具 Skill」公测](https://developers.weixin.qq.com/community/develop/doc/000e4a112a80103ee355ee95361800) | 官方公测 | 打开项目/编译/模拟器/日志/预览/上传/云开发 | Nightly 2.02.2607032+，官方只做工具操作层 |
| B3 | [wechat-miniprogram-mcp](https://registry.npmjs.org/wechat-miniprogram-mcp)（annopick 个人） | npm 0.2.0，2026-06 起 7 版 | 控制 API+自动化 API（导航/交互/触摸/滚动/组件数据/票据/体验评分） | 需 DevTools 开服务端口，无上传/审核 |
| B4 | [@yfme/weapp-dev-mcp](https://github.com/yfmeii/weapp-dev-mcp) | 175★，社区最热 | 页面自动化（playwright 式）+request mock | 官方 Skill 出场后 README 挂"建议迁移" |
| B5 | [jiawei686/wechat-dev-mcp](https://github.com/jiawei686/wechat-dev-mcp) | 17★，npx 即用 | 打开/跳页/点按/截图/读日志+四来源报错巡检 skill | 仅调试环节 |
| B6 | [微信支付 MCP](https://github.com/search?q=wechat+pay+mcp&type=repositories) | **未找到** | — | 官方只出知识型 skills；支付执行无 MCP |
| B7 | [mcp.so 搜 miniprogram](https://mcp.so/zh/search?q=miniprogram) | 仅 2 条收录 | — | smithery 104 个 wechat server 几乎全是客服/公众号向 |
| B8 | [TencentCloudBase/CloudBase-AI-Toolkit](https://github.com/TencentCloudBase/CloudBase-AI-Toolkit) | 1126★ 官方，v2.34 高频更新 | 数据库/函数/存储/部署/57 云 API 白名单 | 后端一体化；前端生成与全流程编排不在边界 |
| B9 | [微信「AI 开发模式」](https://developers.weixin.qq.com/miniprogram/dev/ai/guide.html) + [mp-skills CLI](https://github.com/TencentCloudBase/mp-skills) + [awesome-miniprogram-skills](https://github.com/TencentCloudBase/awesome-miniprogram-skills) | 官方 2026-06 推 | find/add/create/validate/eval + 6 官方示例 | **注意：此 Skill=给终端用户的应用能力，非开发辅助**（同名不同物） |

**B 节结论**：DevTools 操作层已三分——官方 Skill 公测（最强）、个人 MCP 两三个（将被官方收编或并存）、CloudBase 后端 MCP（官方、活跃）。但**支付执行无 MCP、审核/类目/发布管理无 MCP、微信侧开放数据无 MCP**。MCP 层拼图缺角明显。

## C. AI 生成器/低代码格局

| 品 | 阵营 | 小程序支持 | 价格 | 关键边界 |
|---|---|---|---|---|
| [微信 DevTools Skill 公测](https://developers.weixin.qq.com/community/develop/doc/000e4a112a80103ee355ee95361800) | 官方 | 工具操作层 | 免费 | 不生成产品，只让 Agent 操作工具 |
| [微信 AI 开发模式](https://developers.weixin.qq.com/miniprogram/dev/ai/guide.html) | 官方 | 应用 AI 化 | 免费 | 面向终端用户，非开发工具 |
| [CloudBase AI/CLI](https://docs.cloudbase.net) | 官方(腾讯云) | 后端+部署 | 按量计费 | 宣称省 80% 编码；前端/审核不管 |
| [CodeBuddy IDE](https://cloud.tencent.com/developer/article/CodeBuddy-gomoku) | 腾讯 | 生态整合最深 | 免费(未验证) | 仍是专业开发者 IDE，非一句话到上线 |
| [百度秒哒](https://cloud.baidu.com/doc/MIAODA/s/pmfnccc1g) | 商业 | **原生支持生成** | 免费每月≈3应用+点数制 | 生成质量"一般"；独立发布仍要用户自过注册/认证/类目/审核全流程 |
| [v0 / bolt.new / lovable](https://zhuanlan.zhihu.com/p/2075271143611811521) | 海外 | **均不支持** | — | 三巨头全部只出 Web 应用，无小程序 target |
| [即速应用](https://www.jisuapp.cn/) | 商业低代码 | 模板拖拽 | ≈999 元/年起 | 非 AI 原生 |
| [上线了](https://www.sxl.cn/) | 商业低代码 | 模板拖拽 | ≈1800-5400 元/年 | 非 AI 原生 |
| [凡科](https://www.fkw.com/) | 商业低代码 | 模板拖拽 | ≈698-5998 元/年 | 非 AI 原生 |
| [微盟](https://www.163.com/dy/article/2026-08-05-top10-miniapp-platforms)（有赞同类） | 商城 SaaS | 电商小程序 | ≈16800-59800 元/年 | 重 SaaS，服务存量商家 |
| [vibetemplate/miniprogram-generator](https://github.com/vibetemplate/miniprogram-generator) | 开源 | uni-app 提示词模板 | 免费 41★ | 高级 prompt，无工具链闭环 |

**可借鉴零件（研报付费阅读试点）**：[wx-book 169★](https://github.com/zprial/wx-book)、[holy-reader 64★](https://github.com/xifengzhu/holy-reader)、[douyin-novel 32★](https://github.com/DeekeScript/douyin-novel-story-miniprogram)、[云开发阅读 30★](https://github.com/lijie90/wechat_CloudDevelop)、[allProject 源码合集 357★](https://github.com/giteecode/allProject)。英文向 novel reader miniprogram 仅 1 条 1★——**"研报付费阅读小程序"无成建制开源竞品**。

---

## 一、现有 skill/MCP 覆盖矩阵（环节 × 现有品）

| 流程环节 | 官方品 | 社区 skill | 社区 MCP | 商业产品 | 缺口判断 |
|---|---|---|---|---|---|
| 需求→PRD→原型 | — | — | — | CodeBuddy Craft(泛) | **空白** |
| 脚手架/初始化 | mp-skills new(面向AI模式) | Sun-sunshine06, Hongyi999 | — | 秒哒(生成即模板) | 半空 |
| 编码规范/知识注入 | skyline-skills, wechatpay-skills, cloudbase skills | Gourdbaby(装1324), designUI, dev-docs | — | — | **最厚的一环**（但仍单件） |
| 编译/构建 | DevTools Skill 公测 | whinc/miniprogram-ci | wechat-miniprogram-mcp 控制 API | — | 官方已覆盖 |
| 调试/自动化/日志 | DevTools Skill 公测 | whinc/automation, jiawei686 skill | @yfme/weapp-dev-mcp(175★), wechat-dev-mcp(17★), watertian(145★) | — | 覆盖较好但正被官方收编 |
| 真机预览 | DevTools Skill 公测 | — | 部分 MCP | — | 官方已覆盖 |
| 上传/发布 | DevTools Skill 公测(上传) | whinc/miniprogram-ci | — | — | 官方单点覆盖 |
| 支付接入 | wechatpay-skills(知识) | beeyang0 虚拟支付 | **无支付 MCP** | 秒哒内置支付模板 | **知识有、执行无** |
| 审核/类目/合规 | —(仅设计红线知识) | bx33661 审计, mzopedia 隐私扫描 | — | 低代码平台代办(封闭) | **接近空白** |
| 版本/灰度/运营 | — | TO3C/XCX 上线检查 | — | 微盟/有赞(封闭) | 空白 |
| 编排层(串全流程) | **无** | youxiyin SOP 概念稿(0★) | **无** | **无** | **完全空白=提案的位置** |

## 二、AI 生成器格局表

| 梯队 | 品 | 端到端程度 | 判断 |
|---|---|---|---|
| 官方工具层 | DevTools Skill / AI 开发模式 / CloudBase | 各管一段（工具操作/应用AI化/后端） | 官方在做"积木"不做"工厂" |
| 大厂 AI IDE | CodeBuddy | 编码强，生态整合深 | 专业开发者向，非全民向 |
| 全民 AI builder | 百度秒哒 | NL→小程序→挂官方小程序(可跑通) | **唯一原生支持者**；独立发布流程仍甩给用户；质量口碑"一般" |
| 海外 builder | v0/bolt/lovable | 0（无小程序 target） | 全球性真空 |
| 传统低代码 | 即速/上线了/凡科 | 模板到上线(非AI) | 被 AI 原生范式降维中 |
| 商城 SaaS | 微盟/有赞 | 封闭全托管、1.7万-6万/年 | 占据付费心智，不开放 |
| 开源 | vibetemplate(41★) | prompt 模板 | 无工具链，最高星仅 41 |

## 三、端到端缺口证据清单（为什么还没人做成）

1. **安装量断层**：小程序开发 skill 在 skills.sh 最高 1324 装，同市场通用 skill 16.5 万装、公众号发帖 3.4 万装——差 25-124 倍。品类存在但无头部（A2/A19）。
2. **官方只做积木不做工厂**：微信官方已下场三件套（DevTools Skill 公测、wechatpay-skills、CloudBase-AI-Toolkit+mp-skills），全部是单环节工具/知识件，无一覆盖"需求→生成→审核→发布→运营"编排层（B2/A5/B8/B9）。
3. **支付执行无 MCP**：微信支付官方只出知识型 skills；GitHub 搜 wechat pay mcp 零实质命中。支付是付费阅读小程序的命门，目前只能人工写码（B6）。
4. **审核/类目/合环节近乎空白**：只有 3★ 安全审计 skill 与 0★ 隐私扫描 SOP；微信审核红线仅存在于设计规范 skill 的知识条目里。这是全流程中最"中国特色"、海外工具永远不会做的环节（A11/A14/A10）。
5. **海外三巨头集体缺席**：v0/bolt/lovable 无小程序目标，实测文确认"Bolt 和 Lovable 生成的是 Web 应用"；workaround 是导出后人工 Taro/uni-app 转译（C 表）。
6. **国内最接近者各缺一腿**：秒哒能生成但独立发布流程甩给用户且质量"一般"；CodeBuddy 是专业 IDE 非全民工具；开源最高星 vibetemplate 只是 prompt 库无工具链。
7. **喊出口号的先行者全部零落地**：youxiyin"一段话到上线 SOP"(0★)、Hongyi999"从零到部署"(2★)、mzopedia"开发验证发布 SOP"(0★)——需求被反复提出、无一人做成并获验证（A9/A12/A14）。
8. **两个"Skill"概念混淆掩盖了空白**：微信"AI 开发模式"的 Skill（终端用户应用能力）与 Claude Skill（开发者辅助）同名不同物，外界易误以为"微信已有 skill 生态=开发辅助已解决"，实际开发辅助编排层完全空白（B9）。

### 缺口 Top5（按提案价值排序）

1. **编排层完全空白**——所有环节零件都在（官方积木最全），无人串联成流水线。
2. **审核/类目/合规 AI 化空白**——最具中国特色、最苦、海外永不做的护城河环节。
3. **支付执行无 MCP**——知识有、工具无，付费阅读类产品的硬缺口。
4. **市场断层量化**——124 倍安装量差=需求未被满足的直接市场信号。
5. **试点细分无竞品**——"研报付费阅读小程序"无成建制开源/商业竞品，零件（阅读器 UI/云开发结构/虚拟支付 skill）却全部现成。

### 最有用的发现

- **官方「微信开发者工具 Skill」公测**（Nightly 2.02.2607032+，`wechatide` 命令导出）——提案的编译/预览/上传腿应直接建在官方 Skill 上而非第三方 MCP（第三方已被官方收编，yfmeii 175★ 项目已挂迁移声明）。
- **微信官方双 Skill 姿态**：开发者侧（DevTools Skill+wechatpay-skills）与终端侧（AI 开发模式+mp-skills）同时推进，且官方在 skills.sh 上架了 cloudbase skill(1.19 万装)——官方接受 skill 形态分发，提案可顺势上架官方流量池。
- **weapp-forge 的差异化定位证据链完整**：官方积木全但只做单环节 + 秒哒质量口碑"一般" + 海外真空 + 开源 41★ 封顶 = "组装官方积木的端到端工厂"定位成立。

### 诚实声明（未验证/未找到项）

- skillsmp.com 与 superpowers marketplace 为 JS 渲染无法直搜，小程序条目"未找到直接证据"（非断言为零）。
- 有赞价格、CodeBuddy 收费、秒哒付费档位：未验证。
- 微信官方两文档页（devtools/skill/ 与公测公告）直抓失败（SPA/反爬），内容经 weapp-dev-mcp README 与搜索多源交叉证实，credibility 0.85。
- 低代码价格取自 2026-08 行业评测口径，非官网实时直采。
