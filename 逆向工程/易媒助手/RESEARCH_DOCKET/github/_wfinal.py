# -*- coding: utf-8 -*-
import json
d = json.load(open('social-auto-upload-web-ui.json', encoding='utf-8'))
d['name'] = '千帆云递 QianFan Sync v1.2.5'
d['platforms_full'] = ['小红书','视频号','抖音','快手','哔哩哔哩','百家号','TikTok','YouTube','腾讯视频','爱奇艺','微博','支付宝','今日头条','知乎','CSDN','VIVO','微信公众号','淘宝光合','京东京麦']
d['platforms'] = d['platforms_full']
d['publish_types'] = '视频+图集双形态(图文以小红书/抖音等为主), 日历式定时(全量/增量批量), 异步任务队列+失败重试, B站可视化封面编辑器'
d['tech_stack'] = 'Vue3+Vite+Element Plus+Pinia前端 / Python Flask+flask-async+Waitress+SQLite后端 / Playwright+CloakBrowser隐身Chromium / TypeScript MCP服务(5410) / OpenCV+FFmpeg'
d['account_mgmt'] = '本地SQLite(init_db.py建表)+data/运行时目录(gitignored)存DB与cookies, 数据全本地; 账号多标签管理按标签筛选目标账号'
d['signature'] = '无签名算法逆向, 走Playwright浏览器自动化+CloakBrowser反检测降识别风险'
d['structure'] = 'backend/impl按平台分目录Registry模式; blueprints图集/素材/图片发布; ext_api异步任务队列; services草稿合并与FFmpeg; frontend账号管理/发布中心/素材中心/仪表盘'
d['origin'] = '源自dreammis/social-auto-upload, 前端完全重写, Playwright能力继承'
d['maintenance'] = '非常活跃(2026-10-19当天推送, 2026-05创建即高频迭代)'
d['status'] = 'COMPLETE'
json.dump(d, open('social-auto-upload-web-ui.json','w',encoding='utf-8'), ensure_ascii=False, indent=2)
print('ok web-ui json completed')
