import sys, re, html
sys.stdout.reconfigure(encoding='utf-8')
from curl_cffi import requests

def resolve(link):
    link = html.unescape(link)
    s = requests.Session(impersonate='chrome')
    s.get('https://weixin.sogou.com/', timeout=20)
    r = s.get(link, timeout=25, allow_redirects=False)
    loc = r.headers.get('location', '')
    body = r.text
    if not loc:
        for pat in [r"var\s+url\s*=\s*'([^']+)'", r"URL='?([^'\">]+)", r'window\.location(?:\.href)?\s*=\s*"?([^";\']+)']:
            m = re.search(pat, body)
            if m:
                loc = m.group(1); break
    print('STATUS', r.status_code, 'LOC:', loc[:200])
    if loc:
        try:
            r2 = s.get(loc, timeout=25)
            t = r2.content.decode('utf-8', errors='replace')
            title = re.search(r'<title>([^<]+)</title>', t)
            print('FINAL TITLE:', title.group(1) if title else '?')
            # extract text
            text = re.sub(r'<script.*?</script>|<style.*?</style>', ' ', t, flags=re.S)
            text = re.sub(r'<[^>]+>', ' ', text)
            text = re.sub(r'\s+', ' ', text)
            print('TEXT:', text[:2200])
        except Exception as e:
            print('ERR2', e)
    else:
        clean = re.sub(r'\s+', ' ', body)
        print('BODY:', clean[:600])

if __name__ == '__main__':
    resolve(sys.argv[1])
