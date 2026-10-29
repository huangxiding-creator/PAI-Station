# -*- coding: utf-8 -*-
"""probe_login2.py — 判别1003: 不存在手机号 vs 我们的号 (各1发, 不多打)"""
import base64, json, re, sys, uuid
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from curl_cffi import requests as cr
from Crypto.Cipher import PKCS1_v1_5
from Crypto.PublicKey import RSA

RSA_PUB = ("MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCX4kRYjU6XclWT4mwxgQ55JerRar8CPEHp4uZRITqZuk8p"
           "0z5UTL02muequw2dgvgNlJkE8C7eyXf1S8TH+MvbVkHnCoKKigAPb08PtqcvVIqnZn+kNDpiQZapkpHrEXe"
           "R+rWfj3etTwMHYbV+zTaKOdxa7fm3oO4CWbgmfkSC8wIDAQAB")
cipher = PKCS1_v1_5.new(RSA.import_key(base64.b64decode(RSA_PUB)))

def enc(pw):
    return base64.b64encode(cipher.encrypt(pw.encode('utf-8'))).decode()

s = cr.Session(impersonate='chrome')
s.cookies.set('tid', str(uuid.uuid4()), domain='.metaso.cn', path='/')
s.cookies.set('_nb_ioWEgULi', '', domain='.metaso.cn', path='/')
r = s.get('https://metaso.cn/', timeout=30)
token = re.search(r'<meta id="meta-token" content="([^"]+)"', r.text).group(1)

sec = json.load(open(r'E:/AI-Station/data/secrets/metaso_kb.secret', encoding='utf-8'))
for tag, acct, pw in [('ghost', '19900000000', 'Xx12345678'),
                      ('ours', sec['phone'], sec['password'])]:
    r = s.post('https://metaso.cn/login',
               json={'login_by': 'account', 'account': acct, 'pwd': enc(pw)},
               timeout=40, headers={'token': token, 'origin': 'https://metaso.cn',
                                    'referer': 'https://metaso.cn/'})
    body = r.text[:200]
    body = body.replace(sec['phone'], '158****2899')
    print(f'[{tag}] {r.status_code} {body}')
    import time; time.sleep(2)
