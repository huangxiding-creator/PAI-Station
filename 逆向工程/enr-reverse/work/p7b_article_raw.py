# -*- coding: utf-8 -*-
import sys, io, re
sys.path.insert(0, "E:/AI-Station/逆向工程/chinca-reverse/replica")
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from chinca_api import ChincaClient

c = ChincaClient()
r = c.get("/CICA/info/24091410422111")
html = r.text
open("E:/AI-Station/逆向工程/enr-reverse/captures/p7_chinca_2024_raw.html", "w", encoding="utf-8", errors="replace").write(html)
print("size", len(html))
# 图片
for m in re.finditer(r'<img[^>]+src="([^"]+)"', html):
    print("img:", m.group(1)[:120])
# 附件
for m in re.finditer(r'href="([^"]+\.(?:pdf|xlsx?|docx?|zip|rar))"', html, re.I):
    print("att:", m.group(1)[:120])
# 表格
print("tables:", len(re.findall(r"<table", html, re.I)))
# 正文容器后 3 万字符窗内的表格行
i = html.find('class="releasetime"')
win = html[i:i+80000]
rows = re.findall(r"<tr[^>]*>(.*?)</tr>", win, re.S|re.I)
print("rows in window:", len(rows))
for rrow in rows[:6]:
    cells = [re.sub(r"<[^>]+>|\s+|&nbsp;", "", c).strip() for c in re.findall(r"<t[dh][^>]*>(.*?)</t[dh]>", rrow, re.S)]
    print("   ", cells[:8])
