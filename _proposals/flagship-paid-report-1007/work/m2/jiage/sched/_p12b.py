BS = chr(92)
D2 = BS + BS + BS + BS
Q = chr(34)
p = "_r12_c4_ops.py"
lines = open(p, encoding="utf-8").read().split(chr(10))
for i, l in enumerate(lines):
    if l.strip() == ("(" + Q + "L" + Q + ", " + Q + "* " + D2 + "(P_0" + D2 + ")" + Q + ", None,"):
        lines[i] = "(" + Q + "L" + Q + ", " + Q + "* " + D2 + "(P_0" + D2 + ")" + Q + ": " + Q + "**" + Q + ", None,"
        print("ambiguous prefix fixed at", i + 1)
open(p, "w", encoding="utf-8", newline=chr(10)).write(chr(10).join(lines))
