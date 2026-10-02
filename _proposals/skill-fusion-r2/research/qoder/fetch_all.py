# -*- coding: utf-8 -*-
import json, subprocess, sys, os
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
IDS = [
 "11db809b-c9d3-4e31-abd0-3f4c2f3c62df",
 "cd4047ca-83ec-4aeb-a067-9ae29c65ff45",
 "60218edb-c1b1-4bf6-a073-30685ad527d4",
 "a9f4be71-bbf3-4c4d-9a8f-9618f1dfaac9",
 "2a582bd3-960d-4e4d-8007-5de2c08464cd",
 "c3a700c4-f4ca-4b4f-9cd2-aaf9f97f9d81",
 "ca70c88d-53fe-43c5-b6d2-fe08cd1dccc4",
 "0e986ded-bb7e-4f67-a0df-3a3885adcbba",
 "1e8c5ffb-9072-4f19-8d0f-197314506c4e",
]
UA = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
summary = []
for i in IDS:
    out = f"{i}.detail.json"
    r = subprocess.run(["curl","-s","--max-time","25",f"https://qoder.com.cn/apphub/api/v1/marketplace/skills/{i}/detail","-H",f"User-Agent: {UA}","-o",out,"-w","%{http_code} %{size_download}"],capture_output=True,text=True)
    code, size = r.stdout.split()
    ok = code == "200"
    name = dl = ""
    if ok:
        d = json.load(open(out, encoding="utf-8"))
        name = d.get("skill_name") or ""
        dl = d.get("download_url") or ""
        summary.append({"id": i, "name": name, "name_cn": d.get("skill_name_cn"), "cat": d.get("category_v2") or d.get("category"), "installs": d.get("install_count"), "url": dl, "files": len(json.dumps(d.get("file_tree",{})))})
        if dl:
            z = f"{name or i}.zip"
            r2 = subprocess.run(["curl","-s","-L","--max-time","60",dl,"-H",f"User-Agent: {UA}","-o",z,"-w","%{http_code} %{size_download}"],capture_output=True,text=True)
            summary[-1]["zip"] = r2.stdout.strip()
    else:
        summary.append({"id": i, "err": r.stdout.strip()})
json.dump(summary, open("_summary.json","w",encoding="utf-8"), ensure_ascii=False, indent=1)
for s in summary: print(s.get("name"), s.get("name_cn"), s.get("cat"), "installs:", s.get("installs"), "zip:", s.get("zip", s.get("err")))
