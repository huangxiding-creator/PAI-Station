# -*- coding: utf-8 -*-
"""W1 修复轮原始响应调试：dump 115/feijipan/uc/guangya 关键步原始 JSON（数请求，非搜索）"""
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "engine" / "sourcehub"))
sys.stdout.reconfigure(encoding="utf-8")

from curl_cffi import requests as creq   # noqa: E402

UA = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"}

print("== 115 snap swhyiia3wzi ==")
r = creq.get("https://115cdn.com/webapi/share/snap?share_code=swhyiia3wzi&offset=0&limit=20&receive_code=&cid=",
             headers={**UA, "Referer": "https://115cdn.com"}, impersonate="chrome124", timeout=20)
print(json.dumps(r.json(), ensure_ascii=False)[:900])

print("\n== feijipan o7VYA8OZ recommend/list ==")
from adapters._izfj import FeijipanAdapter   # noqa: E402
from adapters._crypto import fj_hex          # noqa: E402
ad = FeijipanAdapter()
ts = fj_hex(str(int(__import__("time").time() * 1000)))
r = ad.post(f"{ad.api_base}{ad.prefix}/buy/vip/list?devType=6&devModel=Chrome&uuid={ad._uuid}&extra=2&timestamp={ts}", headers=ad._h())
r = ad.post(f"{ad.api_base}{ad.prefix}/recommend/list?devType=6&devModel=Chrome&uuid={ad._uuid}&extra=2&timestamp={ts}&shareId=o7VYA8OZ&type=0&offset=1&limit=60", headers=ad._h())
print(json.dumps(r.json(), ensure_ascii=False)[:1200])

print("\n== uc 5d5e3c5011224 detail 根列表 ==")
r1 = creq.post("https://pc-api.uc.cn/1/clouddrive/share/sharepage/token?entry=ft&fr=pc&pr=UCBrowser",
               headers={**UA, "Origin": "https://drive.uc.cn", "Referer": "https://drive.uc.cn/",
                        "Content-Type": "application/json"},
               json={"share_for_transfer": True, "pwd_id": "5d5e3c5011224", "passcode": ""},
               impersonate="chrome124", timeout=20)
tok = r1.json().get("data", {}).get("stoken", "")
r2 = creq.get(f"https://pc-api.uc.cn/1/clouddrive/transfer_share/detail?pwd_id=5d5e3c5011224&passcode=&stoken={tok}"
              f"&entry=ft&pdir_fid=0&fetch_file_list=1&_page=1&_size=50&_fetch_total=1&_fetch_share=1"
              f"&_sort=file_type:asc,file_name:asc&fr=pc&pr=UCBrowser",
              headers={**UA, "Origin": "https://drive.uc.cn", "Referer": "https://drive.uc.cn/"},
              impersonate="chrome124", timeout=20)
lst = r2.json().get("data", {}).get("list", [])
print(f"stoken={'OK' if tok else 'FAIL'} 根 {len(lst)} 项")
for it in lst[:6]:
    print("   ", {k: it.get(k) for k in ("file_name", "dir", "file", "size", "fid", "share_fid_token")})
