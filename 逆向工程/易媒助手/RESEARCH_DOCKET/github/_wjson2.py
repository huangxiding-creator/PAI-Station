# -*- coding: utf-8 -*-
import json
def w(name,d): json.dump(d,open(name,'w',encoding='utf-8'),ensure_ascii=False,indent=2)

w('bilibili-API-collect.json',{
 'repo':'SocialSisterYi/bilibili-API-collect','url':'https://github.com/SocialSisterYi/bilibili-API-collect',
 'stars':20163,'license':None,'pushed_at':'2026-01-30','archived':True,'language':None,'forks':2906,
 'status':'已死: 2026-01-28维护者收到B站委托律所律师函,指控系统性收集传播非公开API接口/调用逻辑/参数结构/访问控制及安全认证机制,已停止维护并删除相关文档及源码,仓库archived',
 'value':'仅存历史参考(fork镜像仍在社区流通); B站协议文档路线已被平台主动维权,直连协议路线法律风险高',
 'publish_types':'N/A(纯API文档库,非发布工具)','tech_stack':'Markdown文档',
 'maintenance':'死亡(律师函后停更)','adoption':'pattern-only且高风险; 建议B站走biliup或浏览器自动化',
 'source':'gh api+README实测 2026-10-19'})

w('biliup.json',{
 'repo':'biliup/biliup','url':'https://github.com/biliup/biliup',
 'stars':5517,'license':'MIT','pushed_at':'2026-10-18','archived':False,'language':'Rust','note':'PyPI另有Python包biliup(B站投稿库,social-auto-upload运行时自动调用)',
 'desc':'自动直播录制/投稿/twitch/ytb频道搬运,命令行投稿B站+视频下载,多种登录方式,支持多p,边录边传0落盘',
 'platforms':['Bilibili'],'publish_types':'视频投稿(协议直连,非浏览器)',
 'tech_stack':'Rust(biliup-rs CLI)+Python包; B站投稿协议含登录(扫码/密码/cookie)',
 'account_mgmt':'多种登录方式,cookie持久化','signature':'内置B站投稿协议与认证(wbi签名等)',
 'maintenance':'非常活跃(2026-10-18推送)','adoption':'reuse(MIT)',
 'source':'gh api实测 2026-10-19; biliup-rs=1073stars/MIT/archived(2025-11)'})

w('_dead-repos.json',{
 'checked_404':[
  {'repo':'lecepin/WeChatVideoUploader','note':'原视频号Playwright上传明星项目,现404;作者lecepin仓库列表已无此项目(2026-10-19实测),疑似被删/投诉下架;其代码以social-auto-upload的tencent_uploader模块形式存活'},
  {'repo':'uvan-x/media-platform-upload','note':'404,uvan-x账号本身也不存在(已注销),social-auto-upload的活跃UI继任=DevilJie/social-auto-upload-web-ui'},
  {'user':'ovtenkf','note':'用户不存在(404),任务清单中的ovtenkf/other无法核实'},
  {'repo':'any-publish','note':'GitHub无同名开源仓(gh search --match name实测)'},
  {'repo':'BearCarryBack(月伴/苏轼)','note':'GitHub无同名开源仓(gh search实测);疑为闭源商业工具,UNVERIFIED'}],
 'source':'gh api实测 2026-10-19'})
print('ok 3 more')
