import json
d = json.load(open('cache_hunt.json', encoding='utf-8'))
report = []
for m in d['marker_files']:
    p = m['path']
    data = open(p, 'rb').read()
    pk = data.find(b'PK' + bytes([3,4]))
    ole = data.find(bytes([0xd0,0xcf,0x11,0xe0]))
    ct = data.find(b'[Content_Types]')
    pkend = data.rfind(b'PK' + bytes([5,6]))
    report.append({'path': p, 'size': m['size'],
                   'first64_hex': data[:64].hex(),
                   'pk_offset': pk, 'ole_offset': ole,
                   'content_types_offset': ct, 'eocd_offset': pkend})
for r in report:
    print(r['size'], 'pk@', r['pk_offset'], 'ole@', r['ole_offset'],
          'CT@', r['content_types_offset'], 'EOCD@', r['eocd_offset'])
print('--- first container first 96 bytes hex ---')
print(report[0]['first64_hex'])
print('--- first 96 bytes as ascii (printable) ---')
d0 = open(report[0]['path'], 'rb').read(96)
print(''.join(chr(c) if 32 <= c < 127 else '.' for c in d0))
with open('container_probe.json', 'w', encoding='utf-8') as f:
    json.dump(report, f, ensure_ascii=False, indent=1)
