# -*- coding: utf-8 -*-
"""Build local fixture: challenge page with instrumented script1 (console.log the solved cookie, no reload)."""
import os, re

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
FIX = os.path.join(BASE, "work", "fixture")
os.makedirs(FIX, exist_ok=True)

html = open(os.path.join(BASE, "captures", "challenge_h1.html"), encoding="utf-8").read()

# replace script1 (the readable loader) with an instrumented version
m = re.search(r"<script>(function getRenderData.*?)</script>", html, re.S)
assert m, "script1 not found"
new_script1 = (
    "function getRenderData(){return document.getElementById(\"renderData\").innerHTML}"
    "var renderData=JSON.parse(getRenderData()),arg1=renderData.l1.slice(10,60);"
    "function setCookie(e,r){var t=new Date;t.setTime(t.getTime()+36e5),document.cookie=e+\"=\"+r+\";expires=\"+t.toGMTString()+\";max-age=3600;path=/\"}"
    "function reload(e){setCookie(\"acw_sc__v2\",e);console.log(\"CHINCA_ACWV2:\"+e);console.log(\"CHINCA_ARG1:\"+arg1);}"
)
html2 = html.replace(m.group(1), new_script1, 1)
assert "CHINCA_ACWV2" in html2
out = os.path.join(FIX, "challenge.html")
with open(out, "w", encoding="utf-8") as f:
    f.write(html2)
print("fixture written:", out, len(html2))
