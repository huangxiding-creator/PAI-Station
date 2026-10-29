# -*- coding: utf-8 -*-
import json
d = json.load(open('_all.json', encoding='utf-8'))
L = []
A = L.append
A('# 易媒助手开源等价物调研纪要(一键多平台发布系统底座选型)')
A('')
A('- 生成: 2026-10-19 | 方法: gh api GitHub REST + 各仓README一手实测, star数/许可证/推送时间全部实测, 无手填')
A('- 逐项目明细: `逆向工程/易媒助手/RESEARCH_DOCKET/github/*.json` (一项目一文件) + 汇总 `_all.json`')
A('- 背景铁律: 必须找可直接拿来用的开源项目, 尽量不自己开发。对标易媒助手(CEF内嵌+直连API双引擎+SQLite cookie隔离)')
A('')
A('## 一、结论速览')
A('')
A('**主底座 = DevilJie/social-auto-upload-web-ui(千帆云递)**, 辅以上游 dreammis/social-auto-upload 模块池,')
A('B站协议走 biliup, 公众号图文走官方API(iamzifei skill蓝本), 长尾平台兜底用 pywinauto 驱动易媒助手本体。')
A('搜狐号/网易号等长尾图文平台开源界空白, 需自研少量适配器。')
A('')
A('## 二、排名表(全部实测 2026-10-19)')
A('')
A('| # | 项目 | stars | 许可 | 最近推送 | 平台数 | 发布形态 | 技术栈 | 账号管理 | 签名算法 | 维护 | 适配分 | 采纳 |')
A('|---|------|-------|------|----------|--------|----------|--------|----------|----------|------|--------|------|')
for r in d['summary_table']:
    stars = str(r['stars']); lic = str(r['license']); np = str(r['platforms'])
    fit = str(r['fit'])
    sig = (r['signature'] or '无')[:40]
    acct = (r['account_mgmt'] or 'N/A')[:60]
    tech = (r['tech_stack'] or '')[:80]
    pub = (r['publish_types'] or '')[:60]
    mnt = (r['maintenance'] or '')[:30]
    nm = r['repo']
    if r.get('name'): nm += ' ' + r['name']
    A('| ' + ' | '.join([str(r['rank']), nm, stars, lic, r['pushed_at'], np, pub, tech, acct, sig, mnt, fit, r['adoption']]) + ' |')
A('')
A('注: 平台数为"发布能力覆盖数"; 千帆云递19平台全表与各项目逐平台清单见对应 JSON。')
A('')
A('## 三、每个项目我们拿什么')
A('')
for r in d['summary_table']:
    A('### ' + str(r['rank']) + '. ' + r['repo'] + (' — ' + r['name'] if r.get('name') else ''))
    A('- ' + r['url'])
    take = {
     'DevilJie/social-auto-upload-web-ui': '主底座整体clone-and-adapt: 19平台适配器impl/(Registry模式按平台分目录)+Flask任务队列+SQLite账号/素材库+定时排程+CloakBrowser反检测+MCP服务, 数据全本地',
     'dreammis/social-auto-upload': 'uploader/ 12平台Playwright模块(alipay/baijiahao/bilibili/douyin/hupu/ks/tencent/tk/weibo/xhs/xiaohongshu/youtube) + xhs accounts.ini多账号模式 + sau CLI + AI skills; 上游修复回流源',
     'biliup/biliup': 'B站协议投稿组件(多P/多登录方式/边录边传), 替代浏览器自动化B站路线, MIT可闭源集成',
     'iamzifei/wechat-article-publisher-skill': '公众号图文官方API直连蓝本: MD/HTML->结构化->草稿箱API+素材库自动传图, 零风控零浏览器',
     'hanliang97/MatrixMedia': '不抄代码(GPL), 抄三个机制: CLI(argv含cli)+HTTP API(30088)+MCP三通道编排; Electron persist:<手机号><平台> session按账号隔离; cli accounts登录态检测命令',
     'pywinauto/pywinauto': 'UIA驱动易媒助手桌面端的兜底通道, 衔接已逆向的SQLite cookie资产, 覆盖开源空白的长尾平台',
     'kebenxiaoming/matrix': 'xhs-api本地flask签名服务(x-s/x-t)思路 + MySQL发布队列/Redis登录态队列/supervisor守护的多账号调度架构(Apache可抄)',
     'NanmiCoder/MediaCrawler': '不抄代码(非商用许可), 抄两个模式: 浏览器上下文内JS表达式现取签名参数(免逆向); CDP连接真人Chrome复用登录态降风控',
     'BACNext/BACNext': 'BAC律师函后的社区接力仓库, 仅作B站协议情报跟踪, 不依赖',
     'SocialSisterYi/bilibili-API-collect': '已死(2026-01-28律师函停更删文档)。价值=风险先例: 协议文档化路线会被平台武装维权',
     'cml227/Wanmeiyifa': '不采用: 无许可证+2023-11停更'
    }
    A('- 拿什么: ' + take.get(r['repo'], '见JSON明细'))
    A('')
A('## 四、平台覆盖缺口(需自研)')
A('')
for g in d['recommendation']['self_build_gaps']:
    A('- ' + g)
A('')
A('## 五、风险清单')
A('')
for r in d['risks']:
    A('- ' + r)
A('')
A('## 六、已核实死件/不存在项')
A('')
for x in d['dead_or_missing']:
    key = x.get('repo') or x.get('user')
    A('- ' + key + ': ' + x['finding'])
A('')
A('## 七、Working notes(过程证据链)')
A('')
A('- 2026-10-19 gh api 实测: social-auto-upload 15619stars/MIT/pushed 2026-09-02; uploader/目录12模块; xhs_uploader含accounts.ini')
A('- 2026-10-19 gh api 实测: lecepin/WeChatVideoUploader 404, lecepin全部仓库列表无此项目')
A('- 2026-10-19 gh api 实测: uvan-x用户404(账号注销); DevilJie/social-auto-upload-web-ui 318stars/MIT/pushed当天, README载19平台表+三层架构+data目录cookies+SQLite')
A('- 2026-10-19 gh api 实测: bilibili-API-collect 20163stars/archived/无LICENSE文件, README原文确认2026-01-28律师函停更删文档; BACNext/BACNext 200stars为社区接力')
A('- 2026-10-19 gh api 实测: MediaCrawler 67192stars/许可证Other(NOASSERTION)/pushed 2026-10-15; README载CDP 9222模式+浏览器上下文取签名+Pro版多账号')
A('- 2026-10-19 gh api 实测: biliup 5517stars/MIT/pushed 2026-10-18(Rust); biliup-rs 1073stars/MIT/archived(2025-11)')
A('- 2026-10-19 gh api 实测: MatrixMedia 992stars/GPL-2.0/pushed 2026-10-17; kebenxiaoming/matrix 969stars/Apache-2.0/pushed 2025-12-27(README载xhs-api签名服务+MySQL/Redis)')
A('- 2026-10-19 gh api 实测: iamzifei skill 157stars/MIT/pushed 2026-08-12(README载官方API草稿箱路线)')
A('- 2026-10-19 gh api 实测: pywinauto 6218stars/BSD-3-Clause/pushed 2026-10-15; 万媒易发45stars/无许可/2023-11停更; ovtenkf用户404')
A('- gh search实测: GitHub无 any-publish / BearCarryBack 同名开源仓; 中文关键词"搜狐号/网易号/图文一键分发"搜索无可用结果(长尾图文开源空白证据)')
A('')
A('## 八、组合方案(落地形态)')
A('')
A('1. clone 千帆云递为仓库基底(Flask后端+Vue前端+MCP), 保持MIT合规与上游同步能力')
A('2. B站适配器替换为 biliup 协议路线(更快更稳); 公众号图文接入官方API草稿箱路线')
A('3. 多账号矩阵: 按MatrixMedia的session partition思路改造千帆云递的cookie存储, 每账号每平台一个隔离上下文+账号池SQLite(对齐易媒助手SQLite cookie隔离设计)')
A('4. 长尾平台(搜狐/网易等): 先用pywinauto驱动易媒助手兜底, 逐个替换为自研Playwright适配器')
A('5. 立即fork+本地镜像全部依赖仓库, 防仓库猝死; 选择器集中到配置文件便于热修')
A('')
open(r'E:\AI-Station\逆向工程\易媒助手\RESEARCH_DIGEST_OSS.md','w',encoding='utf-8').write('\n'.join(L))
print('ok digest written, lines=', len(L))
