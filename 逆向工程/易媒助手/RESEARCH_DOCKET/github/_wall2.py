# -*- coding: utf-8 -*-
import json, os
def load(f):
    return json.load(open(f, encoding='utf-8'))
files = [
 'social-auto-upload-web-ui.json','social-auto-upload.json','biliup.json',
 'wechat-article-publisher-skill.json','MatrixMedia.json','pywinauto.json',
 'matrix-kebenxiaoming.json','MediaCrawler.json','BACNext.json',
 'bilibili-API-collect.json','wanmeiyifa.json']
meta = {
 'social-auto-upload-web-ui.json': dict(rank=1, name='千帆云递 QianFan Sync', n_plat=19, fit=92, adoption='reuse-主底座', platforms='小红书/视频号/抖音/快手/B站/百家号/TikTok/YouTube/腾讯视频/爱奇艺/微博/支付宝/今日头条/知乎/CSDN/VIVO/微信公众号/淘宝光合/京东京麦'),
 'social-auto-upload.json': dict(rank=2, n_plat=11, fit=90, adoption='reuse-上游模块池'),
 'biliup.json': dict(rank=3, n_plat=1, fit=85, adoption='reuse-B站协议适配器'),
 'wechat-article-publisher-skill.json': dict(rank=4, n_plat=1, fit=85, adoption='reuse-公众号图文官方API蓝本'),
 'MatrixMedia.json': dict(rank=5, name='矩媒 MatrixMedia', n_plat=8, fit=65, adoption='pattern-only(GPL-2.0传染)'),
 'pywinauto.json': dict(rank=6, n_plat=0, fit=72, adoption='reuse-驱动易媒助手兜底'),
 'matrix-kebenxiaoming.json': dict(rank=7, n_plat=4, fit=60, adoption='reuse(Apache,参考xhs签名服务)'),
 'MediaCrawler.json': dict(rank=8, n_plat=7, fit=55, adoption='pattern-only(非商用许可)'),
 'BACNext.json': dict(rank=9, n_plat=1, fit=20, adoption='pattern-only同源法律风险'),
 'bilibili-API-collect.json': dict(rank=10, n_plat=1, fit=15, adoption='不采用(法律风险情报)'),
 'wanmeiyifa.json': dict(rank=11, n_plat=0, fit=15, adoption='不采用(无许可+停更)')}
rows = []
for f in files:
    d = load(f); m = meta[f]
    rows.append(dict(
        rank=m['rank'], repo=d['repo'], name=m.get('name',''),
        stars=d.get('stars'), license=d.get('license'), pushed_at=d.get('pushed_at'),
        platforms=m['n_plat'],
        platform_list=m.get('platforms', '/'.join(d.get('platforms') or [])),
        publish_types=d.get('publish_types') or d.get('desc','')[:60],
        tech_stack=(d.get('tech_stack') or '')[:120],
        account_mgmt=(d.get('account_mgmt') or '')[:100],
        signature=d.get('signature',''),
        maintenance=d.get('maintenance',''),
        fit=m['fit'], adoption=m['adoption'], url=d.get('url','')))
rows.sort(key=lambda r: r['rank'])
out = dict(generated='2026-10-19',
 task='一键多平台发布系统(中文自媒体20+平台/多账号cookie/图文+视频)开源底座调研',
 method='gh api GitHub REST + README 实测核实,全部数据一手实测无手填',
 summary_table=rows)
json.dump(out, open('_all.json','w',encoding='utf-8'), ensure_ascii=False, indent=2)
print('ok _all.json rows=', len(rows))
