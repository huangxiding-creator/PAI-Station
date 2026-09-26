import re
import html

raw = open(r'E:/AI-Station/_proposals/ima-public-kb-channel/RESEARCH_DOCKET/web_eco/_bili.html', encoding='utf-8', errors='ignore').read()
t = re.search(r'<title[^>]*>(.*?)</title>', raw, re.S)
print('TITLE:', html.unescape(t.group(1)).strip()[:150] if t else '?')

for m in re.finditer(r'<meta[^>]*name="description"[^>]*content="([^"]*)"', raw):
    print('DESC:', html.unescape(m.group(1))[:900])

kw = m = re.search(r'"desc"\s*:\s*"([^"]{10,2000})"', raw)
if m:
    print('JSON_DESC:', html.unescape(m.group(1))[:900])

urls = sorted(set(re.findall(r'https?://[a-zA-Z0-9\-.]*ima\.qq\.com[^\s"\'<>\\]{0,120}', raw)))
for u in urls:
    print('IMA_URL:', html.unescape(u))

up = re.search(r'"owner":\s*\{"mid":\d+,"name":"([^"]+)"', raw)
if up:
    print('UPPER:', up.group(1))
stat = re.findall(r'"(?:view|like|danmaku|favorite)":\s*(\d+)', raw)[:6]
print('STATS:', stat)
