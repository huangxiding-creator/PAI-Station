# -*- coding: utf-8 -*-
"""probe_login.py — metaso 密码登录端点首探 (凭据从 data/secrets/metaso_kb.secret 读, 输出全掩码)"""
import json, re, sys, uuid
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from curl_cffi import requests as cr

RSA_PUB = ("MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCX4kRYjU6XclWT4mwxgQ55JerRar8CPEHp4uZRITqZuk8p"
           "0z5UTL02muequw2dgvgNlJkE8C7eyXf1S8TH+MvbVkHnCoKKigAPb08PtqcvVIqnZn+kNDpiQZapkpHrEXe"
           "R+rWfj3etTwMHYbV+zTaKOdxa7fm3oO4CWbgmfkSC8wIDAQAB")
try:
    from Crypto.Cipher import PKCS1_v1_5 as _P15
    from Crypto.PublicKey import RSA as _RSA
    HAVE_CRYPTO = True
except ImportError:
    HAVE_CRYPTO = False
# manual pure-python RSA PKCS1 v1.5 fallback
def rsa_encrypt_pkcs1v15(pub_b64: str, msg: bytes) -> bytes:
    import base64
    der = base64.b64decode(pub_b64)
    # parse DER SEQUENCE {INTEGER n, INTEGER e}
    def read_len(b, i):
        l = b[i]; i += 1
        if l & 0x80:
            k = l & 0x7f; l = int.from_bytes(b[i:i+k], 'big'); i += k
        return l, i
    def read_int(b, i):
        assert b[i] == 0x02; i += 1
        l, i = read_len(b, i)
        return int.from_bytes(b[i:i+l], 'big'), i + l
    assert der[0] == 0x30
    _, i = read_len(der, 1)
    n, i = read_int(der, i)
    e, _ = read_int(der, i)
    k = (n.bit_length() + 7) // 8
    pad_len = k - 3 - len(msg)
    import os as _os
    ps = b''
    while len(ps) < pad_len:
        c = _os.urandom(pad_len - len(ps))
        ps += bytes(x for x in c if x != 0)
    em = b'\x00\x02' + ps + b'\x00' + msg
    m = int.from_bytes(em, 'big')
    c = pow(m, e, n)
    return c.to_bytes(k, 'big')

sec = json.load(open(r'E:/AI-Station/data/secrets/metaso_kb.secret', encoding='utf-8'))
phone, pwd = sec['phone'], sec['password']
print(f'cred: phone=158****{phone[-4:]} pwd={pwd[:3]}****')

s = cr.Session(impersonate='chrome')
s.cookies.set('tid', str(uuid.uuid4()), domain='.metaso.cn', path='/')
s.cookies.set('_nb_ioWEgULi', '', domain='.metaso.cn', path='/')
r = s.get('https://metaso.cn/', timeout=30)
m = re.search(r'<meta id="meta-token" content="([^"]+)"', r.text)
assert m, 'meta-token not found'
token = m.group(1)
print('home ok, token len', len(token), 'cookies:', sorted(s.cookies.keys()))

if HAVE_CRYPTO:
    key = _RSA.import_key(base64.b64decode(RSA_PUB)) if False else _RSA.import_key(__import__('base64').b64decode(RSA_PUB))
    c = _P15.new(key)
    ct = c.encrypt(pwd.encode('utf-8'))
else:
    ct = rsa_encrypt_pkcs1v15(RSA_PUB, pwd.encode('utf-8'))
import base64
pwd_enc = base64.b64encode(ct).decode()
print('rsa ok len', len(pwd_enc))

body = {'login_by': 'account', 'account': phone, 'pwd': pwd_enc}
r = s.post('https://metaso.cn/login', json=body, timeout=40,
           headers={'token': token, 'origin': 'https://metaso.cn', 'referer': 'https://metaso.cn/',
                    'accept': 'application/json, text/plain, */*'})
print('LOGIN status', r.status_code)
try:
    j = r.json()
    safe = {k: v for k, v in j.items() if k.lower() not in ('data',)}
    print('json top:', safe)
    d = j.get('data')
    if isinstance(d, dict):
        print('data keys:', list(d.keys())[:20])
except Exception as e:
    print('non-json:', r.text[:300])
print('cookies after:', sorted(s.cookies.keys()))
# who am i
r2 = s.get('https://metaso.cn/api/my-info', timeout=30, headers={'token': token})
print('my-info status', r2.status_code, 'body:', r2.text[:400])
