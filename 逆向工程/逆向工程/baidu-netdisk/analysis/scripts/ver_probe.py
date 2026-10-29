import sys, re, json
for p in sys.argv[1:]:
    data = open(p, "rb").read()
    hits = set()
    for m in re.finditer(rb"[0-9]\.[0-9]{1,2}\.[0-9]{1,3}\.[0-9]{1,4}", data):
        s = m.group().decode()
        if s.startswith(("3.0.", "7.5", "7.6", "8.")):
            hits.add(s)
    print(p, json.dumps(sorted(hits)[:20]))
