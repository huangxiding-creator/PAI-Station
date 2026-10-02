python3 - <<'EOF'
raw = open('/root/qianwen-audit/secrets/zongbao_qianwen_mp.secret','rb').read()
print('bytes:', len(raw))
print('newlines:', raw.count(b'\n'))
print('first_char:', chr(raw[0]) if raw else '-')
import json
try:
    d = json.loads(raw)
    print('is_json: True keys:', sorted(d.keys()))
    for k, v in d.items():
        print(' ', k, '-> len', len(str(v)))
except Exception:
    print('is_json: False')
print('hexish_only:', all(c in b'0123456789abcdefABCDEF\n\r' for c in raw))
EOF
