BS = chr(92)
D1 = BS + BS
D2 = BS + BS + BS + BS
Q = chr(34)
p = "_r12_c4_ops.py"
lines = open(p, encoding="utf-8").read().split(chr(10))
for i, l in enumerate(lines):
    if l.startswith("(L, ".replace("(L, ", "(L, ")) or True:
        pass
    if "F_{ti}" in l and l.strip().startswith("("):
        lines[i] = "(" + Q + "L" + Q + ", " + Q + "* " + D2 + "(F_{ti}" + D2 + ")" + Q + ", None,"
        print("patched F_ti at line", i + 1)
    if "(P_0" in l and l.strip().startswith("(") and "L" in l[:6]:
        lines[i] = "(" + Q + "L" + Q + ", " + Q + "* " + D2 + "(P_0" + D2 + ")" + Q + ", None,"
        print("patched P_0 at line", i + 1)
open(p, "w", encoding="utf-8", newline=chr(10)).write(chr(10).join(lines))
