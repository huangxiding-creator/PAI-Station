import sys as _s; _s.stdout.reconfigure(encoding="utf-8", errors="replace")
import re, sys, html
def text_of(path):
    raw = open(path, encoding='utf-8', errors='ignore').read()
    raw = re.sub(r'<script[^>]*>.*?</script>', ' ', raw, flags=re.S|re.I)
    raw = re.sub(r'<style[^>]*>.*?</style>', ' ', raw, flags=re.S|re.I)
    raw = re.sub(r'<(br|/p|/div|/li|/h[1-6]|/tr)[^>]*>', '\n', raw, flags=re.I)
    raw = re.sub(r'<[^>]+>', ' ', raw)
    raw = html.unescape(raw)
    raw = re.sub(r'[ \t]+', ' ', raw)
    raw = re.sub(r'\n\s*\n+', '\n', raw)
    return raw
print(text_of(sys.argv[1]))
