import re, io, sys
p = r"E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2/transform/ch03.md"
t = io.open(p, encoding="utf-8").read()
cjk = re.findall(r"[\u4e00-\u9fff]", t)
anchors = re.findall(r"P3\d{3}", t)
uniq = sorted(set(anchors))
own = re.findall(r"own_calc", t)
print("CJK_CHARS", len(cjk))
print("ANCHOR_REFS", len(anchors))
print("ANCHOR_UNIQUE", len(uniq), uniq)
print("OWN_CALC", len(own))
# lines with ascii digits lacking anchor/own_calc
bad = []
for i, line in enumerate(t.splitlines(), 1):
    s = line.strip()
    if not re.search(r"[0-9]", s):
        continue
    if re.search(r"P3\d{3}|own_calc", s):
        continue
    if s.startswith("#"):  # structural headings
        bad.append((i, "HEADING", s[:60])); continue
    bad.append((i, "NOANCHOR", s[:80]))
print("FLAGGED", len(bad))
for b in bad:
    print(b)
