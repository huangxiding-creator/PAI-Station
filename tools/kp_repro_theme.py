# -*- coding: utf-8 -*-
"""本地复现 body prompt 构建 — 用线上任务真实数据定位 TypeError"""
import json
import sys
import urllib.request

sys.path.insert(0, r'E:\AI-Station\kunpeng-bid')
sys.stdout.reconfigure(encoding='utf-8', errors='replace')

CID = '1e9c3be1ea4249a6bf9fd16ceaaa8d7c'
d = json.load(urllib.request.urlopen(f'http://47.120.43.20:5100/api/task/{CID}', timeout=15))
ex = d.get('explains') or {}
tree = d.get('outline') or []
print('explains keys:', list(ex.keys()))
print('bid_type:', ex.get('bid_type'))
print('score_points sample:', str(ex.get('score_points'))[:200])

from kunpeng import prompts, workflow  # noqa: E402

# 复刻 gen_leaf 的输入构造
digest = workflow._digest(CID) if hasattr(workflow, '_digest') else ''
print('digest type:', type(digest), 'len:', len(digest or ''))
sp_all = workflow.get_score_points(CID)
print('sp_all[0:2]:', str(sp_all[:2])[:200])

sec_min = 800
sys_sec = prompts.SECTION_BODY_IRON.replace('{min_chars}', str(sec_min))
print('sys_sec OK, len:', len(sys_sec))

ch = tree[0]
cnode = (ch.get('children') or [{}])[0]
title = cnode.get('text', '测试小节')
theme = ch.get('theme', '')
try:
    p = prompts.section_body_prompt(ch.get('text', ''), title, theme, digest or '摘要',
                                    '', sp_all, '知识', sec_min)
    print('section_body_prompt OK, len:', len(p))
except TypeError as e:
    import traceback
    traceback.print_exc()
