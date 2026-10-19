import re, io
p = r"E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2/dsim/ch04.md"
t = io.open(p, encoding="utf-8").read()
cjk = re.findall(r"[\u4e00-\u9fff]", t)
out = []
out.append("CJK_total %d" % len(cjk))
anchors = re.findall(r"P4\d{3}", t)
out.append("anchor_refs %d unique %d" % (len(anchors), len(set(anchors))))
out.append("own_calc %d" % t.count("own_calc"))
banned = ["驱动","导致","主要","唯一","显著","确定","最优","必然","全面","行业平均"]
for w in banned:
    n = t.count(w)
    if n: out.append("BANNED %s %d" % (w, n))
m = re.search(r"^> (.+)$", t, re.M)
if m:
    lead = m.group(1)
    out.append("lead_cjk %d" % len(re.findall(r"[\u4e00-\u9fff]", lead)))
bad = []
for ln, line in enumerate(t.split("\n"), 1):
    if line.startswith("#") or line.startswith(">") or line.startswith("adds:") or line.startswith("|---"):
        continue
    for s in re.split(r"(?<=[。？！])", line):
        if re.search(r"\d", s) and "P4" not in s and "own_calc" not in s:
            bad.append("L%d %s" % (ln, s[:70]))
out.append("no_anchor_digit_sentences %d" % len(bad))
out.extend(bad)
io.open(r"E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2/dsim/_check_result.txt", "w", encoding="utf-8").write("\n".join(out))
print("done", len(out))
