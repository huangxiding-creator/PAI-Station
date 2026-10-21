import os, sys
WORK = os.path.dirname(os.path.abspath(__file__))
target = os.path.join(WORK, "attack1.py")
src = open(target, "r", encoding="utf-8").read()
OLD1 = "        if os.path.isdir(p):\n            return p, v"
NEW1 = "        if os.path.isdir(p) or os.path.isfile(p):\n            return p, v"
OLD2 = "        fs = []\n        for root, dirs, names in os.walk(d):"
NEW2 = "        fs = []\n        if os.path.isfile(d):\n            fs.append(d)\n        for root, dirs, names in os.walk(d):"
n1 = src.count(OLD1)
n2 = src.count(OLD2)
print("matches old1=%d old2=%d" % (n1, n2))
if n1 != 1 or n2 != 1:
    print("PATCH_ABORT unexpected match counts")
    sys.exit(2)
src = src.replace(OLD1, NEW1).replace(OLD2, NEW2)
open(target, "w", encoding="utf-8").write(src)
print("PATCH_OK bytes=%d" % len(src))
