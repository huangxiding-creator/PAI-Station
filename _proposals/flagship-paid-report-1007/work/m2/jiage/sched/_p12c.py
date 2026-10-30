BS = chr(92)
D2 = BS + BS + BS + BS
Q = chr(34)
p = "_r12_c4_ops.py"
lines = open(p, encoding="utf-8").read().split(chr(10))
prefix = "* " + D2 + "(P_0" + D2 + ")" + chr(0xFF1A) + "**"
lines[15] = "(" + Q + "L" + Q + ", " + Q + prefix + Q + ", None,"
open(p, "w", encoding="utf-8", newline=chr(10)).write(chr(10).join(lines))
print("ok:", lines[15][:40])
