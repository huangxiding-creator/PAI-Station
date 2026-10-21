p = 'E:/AI-Station/逆向工程/wps-ai-paiban/work/decrypt/scan1.py'
s = open(p, encoding='utf-8').read()
old = "line = line.strip().replace('/', '" + chr(92) + "')"
new = "line = line.strip().replace('/', chr(92))"
if old in s:
    s = s.replace(old, new)
    open(p, 'w', encoding='utf-8').write(s)
    print('FIXED')
else:
    print('PATTERN NOT FOUND - checking')
    for i, ln in enumerate(s.splitlines(), 1):
        if 'replace' in ln:
            print(i, repr(ln))
