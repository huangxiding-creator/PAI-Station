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
for p in sys.argv[1:]:
    t = text_of(p)
    lines = [l.strip() for l in t.split('\n') if l.strip()]
    # keep lines with money or plan keywords
    keep = [l for l in lines if re.search(r'(\$|€|£|USD|per month|/mo|/user|month|annual|year|free|credits|minute|plan|Pro|Business|Premium|Enterprise|Team|Starter|Scale|Basic|Included|unlimited| Unlimited|录|元)', l, re.I)]
    print('='*20, p, '='*20)
    print('\n'.join(keep[:120]))
