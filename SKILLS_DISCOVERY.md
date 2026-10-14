# SKILLS_DISCOVERY: 对 revenue-engine 有用的现成技能（2026-10-14）

## 外部技能（新装）

| 技能 | 来源 | 用途 | 状态 |
|---|---|---|---|
| **wechatpay-skills** | 微信支付官方（wechatpay-apiv3，MIT） | 收款腿：产品选型/编码接入/排障的官方 AI 技能包（v1.3，2026-10-13 活跃） | Phase 0-3 商户号确认后安装 |
| LangBot 插件生态（.lbpkg） | LangBot Skill Hub | 全局日 20 限频插件的宿主平台 | Phase 2 A 栈上线时接入 |

## 本地在役技能（直接复用，零新开发）

| 技能 | 引擎角色 |
|---|---|
| wechat-cli（rion） | 群消息读取侧（100 群 DB 直读）——proactive.py 热词腿已在用 |
| wechat-intelligence-hub | 商单雷达/待回复检查——商机信号识别参照 |
| gb-standard | 国标 PDF 下载与情报——工程垂直答疑的内容侧（AI 回答带规范出处） |
| kdocs / lark-* / tencent-docs | 智库内容生产与分发协同 |
| zh-search-pro | 免费中文检索——商机背景调查 |
| baidu-drive | 弹药库备份（研报交付物网盘侧） |
| ebook-treasure | 工程垂直知识补给 |

## 结论

技能层零缺口：外部仅需 wechatpay-skills 一个（且是官方件）；其余全部在役。
无第三方便件需引入 → skill_vet 审查环节仅 wechatpay-skills 一项（MIT 官方，CLEAN 预期）。
