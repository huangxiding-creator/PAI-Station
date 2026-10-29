# -*- coding: utf-8 -*-
import json
def w(name,d): json.dump(d,open(name,'w',encoding='utf-8'),ensure_ascii=False,indent=2)

w('MediaCrawler.json',{
 'repo':'NanmiCoder/MediaCrawler','url':'https://github.com/NanmiCoder/MediaCrawler',
 'stars':67192,'license':'NOASSERTION(自定义非标准许可证,含非商用限制)','pushed_at':'2026-10-15','archived':False,'language':'Python','forks':12835,
 'desc':'小红书/抖音/快手/B站/微博/贴吧/知乎 7平台爬虫与评论采集',
 'platforms':['小红书','抖音','快手','B站','微博','贴吧','知乎'],
 'publish_types':'N/A(采集不发布)','tech_stack':'Playwright + CDP模式(连接用户已有Chrome,127.0.0.1:9222,复用已有登录态降风控;可关CDP回标准Playwright)',
 'account_mgmt':'登录态缓存:扫码/cookie登录后Playwright browser_data持久化;多账号在Pro闭源版才有(开源版单账号)',
 'signature':'核心思路:无需JS逆向,在保留登录态的浏览器上下文里用JS表达式现取签名参数(x-s/x-t等);不开源硬逆向的X-Bogus/a_bogus实现',
 'value_for_us':'多平台cookie/登录态管理模式+签名参数浏览器内获取模式可直接借鉴(与易媒助手SQLite cookie隔离对照);CDP端口默认9222注意与WeAIPO免打扰红线冲突',
 'maintenance':'非常活跃(2026-10-15)','adoption':'pattern-only(非商用许可,不可抄代码入闭源产品)','source':'gh api+README实测 2026-10-19'})

w('wechat-article-publisher-skill.json',{
 'repo':'iamzifei/wechat-article-publisher-skill','url':'https://github.com/iamzifei/wechat-article-publisher-skill',
 'stars':157,'license':'MIT','pushed_at':'2026-08-12','archived':False,
 'desc':'Claude Skill:Markdown/HTML一键发布到微信公众号草稿箱(v1.1.0 API-based)',
 'platforms':['微信公众号'],'publish_types':'图文(草稿箱,不自动群发)',
 'tech_stack':'官方API直连:Python解析Markdown/HTML→结构化(title/content/images)→微信草稿API;图片自动传素材库;无浏览器自动化',
 'account_mgmt':'微信公众号官方API凭证(AppSecret等)','signature':'官方API无需签名逆向',
 'value_for_us':'公众号图文走官方API是最安全路线,直接作为公众号适配器蓝本','maintenance':'活跃(2026-08)',
 'adoption':'reuse(MIT)','source':'gh api+README实测 2026-10-19'})

w('pywinauto.json',{
 'repo':'pywinauto/pywinauto','url':'https://github.com/pywinauto/pywinauto',
 'stars':6218,'license':'BSD-3-Clause','pushed_at':'2026-10-15','archived':False,'language':'Python',
 'desc':'Windows GUI自动化(UIA/text属性),可驱动桌面客户端控件',
 'platforms':['任意Windows桌面应用(含易媒助手CEF壳)'],'publish_types':'取决于被驱动软件',
 'tech_stack':'Win32 API+UI Automation;配合inspect识别控件','account_mgmt':'由被驱动软件自管(易媒助手SQLite)',
 'signature':'N/A(不走协议)','value_for_us':'驱动易媒助手桌面端复用其20+平台覆盖的兜底方案;CEF内嵌页面仍是 Chromium,混合UIA+CDP可深控',
 'maintenance':'活跃(2026-10-15)','adoption':'reuse(BSD-3)','source':'gh api实测 2026-10-19'})

w('wanmeiyifa.json',{
 'repo':'cml227/Wanmeiyifa','url':'https://github.com/cml227/Wanmeiyifa',
 'stars':45,'license':None,'pushed_at':'2023-11-28','archived':False,
 'desc':'万媒易发:AI驱动多平台多账号管理神器(README自述)','platforms':'README宣称多平台,未逐一核实',
 'tech_stack':'未核实','account_mgmt':'未核实',
 'maintenance':'死亡(2023-11停更近3年)','adoption':'不采用(无许可证+停更)',
 'source':'gh api实测 2026-10-19'})

w('BACNext.json',{
 'repo':'BACNext/BACNext','url':'https://github.com/BACNext/BACNext',
 'stars':200,'license':None,'pushed_at':'2026-08-17','archived':False,
 'desc':'bilibili-API-collect遭B站律师函停更后的社区接力仓库(另见pskdje/bilibili-API-collect镜像fork 307stars)',
 'platforms':['Bilibili'],'publish_types':'N/A(API文档)',
 'tech_stack':'Markdown文档','maintenance':'社区接力,非官方',
 'adoption':'pattern-only且同源法律风险(原仓因系统性整理非公开API被B站发函)','source':'gh search实测 2026-10-19'})

# 更新 social-auto-upload.json 补目录证据
d=json.load(open('social-auto-upload.json',encoding='utf-8'))
d['dir_evidence']='uploader/下12个平台模块: alipay/baijiahao/bilibili/douyin/hupu/ks/tencent/tk/weibo/xhs/xiaohongshu/youtube; xhs_uploader含accounts.ini(多账号ini)+扫码登录py; bilibili_uploader仅runtime.py(运行时装biliup协议库); 另有sau_backend/sau_frontend/db/createTable.py(SQLite)/skills/'
d['account_mgmt']='Playwright storage_state JSON + xhs的accounts.ini多账号配置 + SQLite(db/)'
d['status']='COMPLETE'
w('social-auto-upload.json',d)
for f in ['MatrixMedia.json','matrix-kebenxiaoming.json','social-auto-upload-web-ui.json','bilibili-API-collect.json','biliup.json']:
    x=json.load(open(f,encoding='utf-8')); x['status']='COMPLETE'; w(f,x)
print('ok json batch 3')
