p = 'E:/AI-Station/逆向工程/wps-ai-paiban/work/decrypt/mkreport2.py'
s = open(p, encoding='utf-8').read()
bad = 'PK' + chr(92) + 'x03' + chr(92) + 'x04'
good = 'PK' + chr(92)[0:0] + "' + chr(92) + 'x03' + chr(92) + 'x04" + chr(39) + chr(39)
if bad in s:
    s = s.replace(bad, 'PK' + chr(39) + ' + chr(92) + ' + chr(39) + 'x03' + chr(92) + 'x04')
    open(p, 'w', encoding='utf-8').write(s)
    print('FIXED_PK')
else:
    print('NO_PK_PATTERN')
bad2 = 'PK' + chr(92) + 'x05' + chr(92) + 'x06'
if bad2 in s:
    s = open(p, encoding='utf-8').read()
    s = s.replace(bad2, 'PK' + chr(39) + ' + chr(92) + ' + chr(39) + 'x05' + chr(92) + 'x06')
    open(p, 'w', encoding='utf-8').write(s)
    print('FIXED_EOCD')
