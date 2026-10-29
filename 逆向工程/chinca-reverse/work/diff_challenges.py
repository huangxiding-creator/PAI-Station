# -*- coding: utf-8 -*-
import re, hashlib
CAP = r"E:\AI-Station\逆向工程\chinca-reverse\captures"
bodies = {}
for t in ["h1", "h2", "h3"]:
    bodies[t] = open(f"{CAP}\\challenge_{t}.html", encoding="utf-8").read()

def norm(b):
    b = re.sub(r"arg1='[0-9A-Fa-f]+'", "arg1='ARG1'", b)
    b = re.sub(r'name="aliyunwaf_[0-9a-f]+">([A-Za-z0-9+/=]+)</textarea>', 'name="aliyunwaf_BLOB"></textarea>', b)
    return b

n = {t: norm(b) for t, b in bodies.items()}
print("norm hashes:")
for t, v in n.items():
    print(" ", t, hashlib.md5(v.encode()).hexdigest())
print("h1==h2:", n["h1"] == n["h2"], " h1==h3:", n["h1"] == n["h3"])

def scripts(b):
    return re.findall(r'<script[^>]*>(.*?)</script>', b, re.S)

s1, s2, s3 = scripts(bodies["h1"]), scripts(bodies["h2"]), scripts(bodies["h3"])
print("script counts:", len(s1), len(s2), len(s3))
print("script1 (plain loader) equal:", s1[0] == s2[0] == s3[0])
h = lambda x: hashlib.md5(x.encode()).hexdigest()[:12]
print("script2 (obfuscated) hashes:", [h(s) for s in (s1[1], s2[1], s3[1])])
blob = re.compile(r'aliyunwaf_c[0-9a-f]+">([^<]+)<')
print("blob hashes:", [h(blob.search(bodies[t]).group(1)) for t in ["h1", "h2", "h3"]])
# meta markers
for t in ["h1", "h2", "h3"]:
    m = re.search(r'name="aliyun_waf_aa" content="([0-9a-f]+)"', bodies[t])
    m2 = re.search(r'name="aliyun_waf_bb" content="([0-9a-f]+)"', bodies[t])
    print(t, "aa:", m and m.group(1), "bb:", m2 and m2.group(1))
