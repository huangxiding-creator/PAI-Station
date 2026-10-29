# -*- coding: utf-8 -*-
"""probe_login3.py — account格式两变体 (86-前缀/+86前缀), 凭据读secret"""
import base64, json, re, sys, uuid, time
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from curl_cffi import requests as cr
from Crypto.Cipher import PKCS1_v1_5
from Crypto.PublicKey import RSA
RSA_PUB = ("MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCX4kRYjU6XclWT4mwxgQ55JerRar8CPEHp4uZRITqZuk8p"
           "0z5UTL02muequw2dgvgNlJkE8C7eyXf1S8TH+MvbVkHnCoKKigAPb08PtqcvVIqnZn+kNDpiQZapkpHrEXe"
           "R+rWfj3etTwMHYbV+zTaKOdxa7fm3oO4CWbgmfkSC8wIDAQAB")
c = PKCS1_v1_5.new(RSA.import_key(base64.b64decode(RSA_PUB)))
sec = json.load(open(r'E:/AI-Station/data/secrets/metaso_kb.secret', encoding='utf-8'))
phone, pwd = sec['phone'], sec['password']
s = cr.Session(impersonate='chrome')
s.cookies.set('tid', str(uuid.uuid4()), domain='.metaso.cn', path='/')
s.cookies.set('_nb_ioWEgULi', '', domain='.metaso.cn', path='/')
r = s.get('https://metaso.cn/', timeout=30)
token = re.search(r'<meta id="meta-token" content="([^"]+)"', r.text).group(1)
for acct in (f'86-{phone}', f'+86{phone}'):
    r = s.post('https://metaso.cn/login',
               json={'login_by': 'account', 'account': acct,
                     'pwd': base64.b64encode(c.encrypt(pwd.encode())).decode()},
               timeout=40, headers={'token': token, 'origin': 'https://metaso.cn', 'referer': 'https://metaso.cn/'})
    print(f'[{acct[:3]}****]', r.status_code, r.text[:120])
    time.sleep(2)
