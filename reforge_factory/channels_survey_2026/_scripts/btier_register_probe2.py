# -*- coding: utf-8 -*-
"""btier_register_probe2.py - pass2: variant retries + refined antibot ruling."""
import json, re, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(HERE / "_scripts"))
import importlib.util
spec = importlib.util.spec_from_file_location("p1", HERE / "_scripts" / "btier_register_probe.py")
p1 = importlib.util.module_from_spec(spec); spec.loader.exec_module(p1)

RAW = HERE / "_raw" / "btier_register_probe.jsonl"
rows = [json.loads(l) for l in RAW.read_text(encoding="utf-8").splitlines()]

# variant retries: idx -> list of urls to try
VAR = {
 101: ["https://bellingcat.gitbook.io/toolkit"],
 116: ["http://eic.fiec.org", "https://eic.fiec.org/"],
 121: ["https://fidic.org/"],
 145: ["http://magi.com"],
 160: ["https://petalsearch.com/", "http://petalsearch.com"],
 183: ["https://www.ungm.org/PublicTender/", "https://www.ungm.org/"],
 192: ["http://www.ecaci.org.cn/"],
 193: ["http://www.chinajsb.cn/"],
 195: ["http://www.cebpubservice.com/", "http://www.cebpubservice.com/bulletin/"],
 198: ["http://www.cacem.com.cn/"],
 203: ["http://glxy.mot.gov.cn/", "https://glxy.mot.gov.cn/index.html"],
 205: ["http://xypt.mwr.cn/", "http://xypt.mwr.cn:80/"],
 210: ["http://www.gsxt.gov.cn/", "https://gsxt.gov.cn/"],
 199: ["https://www.aiib.org/en/projects/index.html"],
}
res = {}
for idx, urls in VAR.items():
    for u in urls:
        r = p1.fetch(u)
        mk = p1.markers(r["snippet"] or "")
        title_chal = ("just a moment" in (r["title"] or "").lower()) or ("attention required" in (r["title"] or "").lower())
        print(idx, u, r["status"], r["size"], "via", r["via"], "| title:", (r["title"] or "")[:44], "| mk:", {k: v for k, v in mk.items() if v})
        if r["status"] == 200 and r["size"] > 800 and not title_chal:
            res[idx] = dict(url=u, status=r["status"], size=r["size"], via=r["via"], title=r["title"])
            break
print("retry-lit:", sorted(res))
out_path = HERE / "_raw" / "btier_register_probe2_retries.jsonl"
with out_path.open("a", encoding="utf-8") as f:
    for idx, v in res.items():
        f.write(json.dumps(dict(idx=idx, **v), ensure_ascii=False) + "\n")
