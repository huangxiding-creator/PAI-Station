# -*- coding: utf-8 -*-
"""probe_verify.py — 手机号注册性判别 (POST /verify?type=login_sms, 最多2发)"""
import json, re, sys, uuid
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from curl_cffi import requests as cr
sec = json.load(open(r'E:/AI-Station/data/secrets/metaso_kb.secret', encoding='utf-8'))
phone = sec['phone']
s = cr.Session(impersonate='chrome')
s.cookies.set('tid', str(uuid.uuid4()), domain='.metaso.cn', path='/')
s.cookies.set('_nb_ioWEgULi', '', domain='.metaso.cn', path='/')
r = s.get('https://metaso.cn/', timeout=30)
token = re.search(r'<meta id="meta-token" content="([^"]+)"', r.text).group(1)
r = s.post('https://metaso.cn/verify?type=login_sms', json={'phone': f'86-{phone}'},
           timeout=40, headers={'token': token, 'origin': 'https://metaso.cn',
                                'referer': 'https://metaso.cn/'})
body = r.text.replace(phone, '158****2899')
print('verify:', r.status_code, body[:300])
print('cookies:', sorted(s.cookies.keys()))
