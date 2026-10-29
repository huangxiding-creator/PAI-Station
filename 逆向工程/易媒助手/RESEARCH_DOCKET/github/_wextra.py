# -*- coding: utf-8 -*-
import json
p = '_all.json'
d = json.load(open(p, encoding='utf-8'))
d['dead_or_missing'] = [
 {'repo':'lecepin/WeChatVideoUploader','finding':'404。原视频号Playwright上传明星项目已消失,作者仓库列表已无此项目(2026-10-19实测)。其能力以social-auto-upload的tencent_uploader模块存活'},
 {'repo':'uvan-x/media-platform-upload','finding':'404,uvan-x账号已注销。活跃UI继任=DevilJie/social-auto-upload-web-ui'},
 {'user':'ovtenkf','finding':'用户不存在(404),任务清单中ovtenkf/other无法核实'},
 {'repo':'any-publish','finding':'GitHub无同名开源仓(gh search --match name实测)'},
 {'repo':'BearCarryBack(月伴/苏轼)','finding':'GitHub无同名开源仓,疑为闭源商业工具(UNVERIFIED)'}]
rec = dict()
rec['main_base'] = [
 '主底座: DevilJie/social-auto-upload-web-ui (千帆云递, MIT, 19平台, Flask+Vue3+SQLite+Playwright+MCP, 2026-10-19当天活跃)',
 '理由: 平台覆盖最广(19个,含知乎/头条/公众号/CSDN), 图文+图集+视频+定时+任务队列+失败重试+账号标签体系, 数据全本地(SQLite+cookies目录), MIT可闭源商用',
 '次要底座/模块池: dreammis/social-auto-upload (15.6k stars, MIT) 的 uploader/ 12平台模块 + sau CLI + skills, 作为选择器修复的上游回流源']
rec['adapter_strategy'] = [
 'B站: biliup (MIT, 协议直连投稿, 2026-10-18仍活跃) 作为协议适配器',
 '微信公众号图文: iamzifei/wechat-article-publisher-skill 模式 = 官方API草稿箱(最安全,无风控,无浏览器)',
 '视频号/抖音/快手/小红书等: Playwright浏览器自动化适配器(千帆云递/upstream现成)',
 '小红书签名(x-s/x-t)如走协议: 参考kebenxiaoming/matrix内置xhs-api本地服务 或 MediaCrawler浏览器上下文取参模式']
rec['self_build_gaps'] = [
 '搜狐号/网易号/企鹅号/一点资讯等长尾图文平台: 开源界空白, 需自研Playwright适配器',
 '微博图文: 现成实现仅视频, 图文需自研',
 '知乎/头条图文形态: 需对千帆云递实测确认后定',
 '多账号矩阵调度: 现成项目均为单机单账号视角, 矩阵编排(账号池+队列+调度面板)需自研, 可参考kebenxiaoming的MySQL+Redis+supervisor队列模式与MatrixMedia的persist:<手机号><平台> session隔离']
rec['fallback'] = [
 'pywinauto(BSD-3, UIA)驱动易媒助手桌面客户端, 复用其20+平台覆盖与SQLite cookie资产, 作为长尾平台兜底通道(与已逆向成果衔接)']
d['recommendation'] = rec
d['risks'] = [
 '法律: B站2026-01-28对bilibili-API-collect发律师函(指控系统性收集传播非公开API/调用逻辑/认证机制), 原仓停更删文档。协议直连+签名逆向路线已被平台武装维权, 优先官方API+浏览器自动化',
 '仓库猝死: WeChatVideoUploader/uvan-x已404。平台投诉可瞬间杀死依赖仓库。选定底座后立即fork+本地镜像+离线vendor, 选择器资产自持',
 '选择器易碎: 平台改版即失效(kebenxiaoming README自认需自行维护css选择器)。需选择器集中配置+截图AI校验+热修机制',
 '许可证红线: MediaCrawler(非商用)/MatrixMedia(GPL-2.0)/bilibili-API-collect(无许可)不可抄码进入闭源产品线; 千帆云递与upstream与biliup均为MIT可放心',
 '账号风控: 多账号同机同指纹易触发风控。对策=千帆云递CloakBrowser隐身/MatrixMedia按账号session partition/MediaCrawler CDP复用真人浏览器。注意MediaCrawler CDP默认9222端口与WeAIPO浏览器免打扰红线冲突, 复用必须改端口或独立profile']
json.dump(d, open(p,'w',encoding='utf-8'), ensure_ascii=False, indent=2)
print('ok _all.json enriched')
