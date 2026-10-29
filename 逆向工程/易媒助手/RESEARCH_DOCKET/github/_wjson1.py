# -*- coding: utf-8 -*-
import json
def w(name,d): json.dump(d,open(name,'w',encoding='utf-8'),ensure_ascii=False,indent=2)

w('social-auto-upload.json',{
 'repo':'dreammis/social-auto-upload','url':'https://github.com/dreammis/social-auto-upload',
 'stars':15619,'license':'MIT','pushed_at':'2026-09-02','archived':False,'language':'Python','forks':2648,
 'platforms':['抖音','Bilibili','小红书','快手','视频号','百家号','支付宝生活号','微博','虎扑','TikTok','YouTube'],
 'publish_types':'视频全平台; 图文仅抖音/小红书/快手; 定时发布多数平台',
 'tech_stack':'Playwright浏览器自动化 + Bilibili走biliup协议库; 自带sau CLI与AI skills',
 'account_mgmt':'Playwright storage_state JSON持久化(README与惯例,细节待目录核验)',
 'signature':'B站走biliup协议上传; 无X-Bogus/a_bogus类签名逆向',
 'matrix_note':'README平台矩阵: 抖音(视频+图文+定时+CLI+Skill全支持,主线重构最完整); B站运行时自动准备biliup; 小红书/快手浏览器自动化含图文; 视频号tencent_uploader; 百家号/支付宝生活号/微博/虎扑浏览器自动化仅视频; TikTok Chrome版; YouTube Studio',
 'maintenance':'活跃(2026-09推送)','adoption':'reuse(MIT)','source':'gh api+README实测 2026-10-19'})

w('MatrixMedia.json',{
 'repo':'hanliang97/MatrixMedia','url':'https://github.com/hanliang97/MatrixMedia',
 'stars':992,'license':'GPL-2.0','pushed_at':'2026-10-17','created':'2026-03-21','archived':False,'language':'JavaScript','forks':133,
 'platforms_cli_publish':['抖音','快手','百家号','哔哩哔哩','头条','视频号','小红书','番茄视频'],
 'publish_types':'视频(CLI 8平台全自动化)+publish-article子命令(图文,范围待查docs/cli.md)',
 'tech_stack':'Vue+Electron+Puppeteer; GUI+CLI(argv含cli无头)+HTTP API(POST 127.0.0.1:30088/publish)+内置MCP Server',
 'account_mgmt':'Electron session partition persist:<手机号><平台> 隔离,CLI与GUI共用; CLI扫码登录仅抖音+视频号,其余平台需GUI先登录一次',
 'signature':'未见协议签名逆向,走浏览器自动化','maintenance':'非常活跃(2026-10-17推送)',
 'adoption':'pattern-only或内部用(GPL-2.0传染,若二次分发须开源)','source':'gh api+README实测 2026-10-19'})

w('matrix-kebenxiaoming.json',{
 'repo':'kebenxiaoming/matrix','url':'https://github.com/kebenxiaoming/matrix',
 'stars':969,'license':'Apache-2.0','pushed_at':'2025-12-27','created':'2024-05-15','archived':False,'language':'Python','forks':202,
 'desc':'抖音/快手/视频号/小红书短视频矩阵分发脚本,python3+playwright',
 'platforms':['抖音','视频号','小红书','快手'],
 'publish_types':'仅视频',
 'tech_stack':'Python3+Playwright; Redis存登录态队列+MySQL存发布队列+supervisor守护; 小红书登录依赖本地xhs-api服务(app2024.py)计算x-s/x-t签名',
 'account_mgmt':'cookie文件管理+MySQL/Redis账号队列,可多账号(user_queue_login按类型排队登录)',
 'signature':'内置小红书x-s/x-t签名服务(xhs-api目录,本地flask)',
 'maintenance':'半休眠(约10个月未推)','adoption':'reuse(Apache-2.0)','source':'gh api+README实测 2026-10-19'})

w('social-auto-upload-web-ui.json',{
 'repo':'DevilJie/social-auto-upload-web-ui','url':'https://github.com/DevilJie/social-auto-upload-web-ui',
 'stars':318,'license':'MIT','pushed_at':'2026-10-19','created':'2026-05-12','archived':False,'language':'Python','forks':76,
 'desc':'基于social-auto-upload的web-ui优化重构(活跃UI继任者)','platforms':'继承social-auto-upload',
 'tech_stack':'Python+Playwright+Web UI','account_mgmt':'待核验','maintenance':'非常活跃(当天推送)',
 'adoption':'reuse(MIT)','source':'gh api实测 2026-10-19'})
print('ok 4 checkpoints written')
