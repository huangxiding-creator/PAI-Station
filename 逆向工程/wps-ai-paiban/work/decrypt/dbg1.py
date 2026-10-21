import os
L = os.environ.get("LOCALAPPDATA")
print("LOCALAPPDATA=%r" % L)
base = os.path.join(L, "Kingsoft", "WPS Office")
print("base isdir=%r" % os.path.isdir(base))
for v in ("12.1.0.28802", "12.1.0.28505"):
    p = os.path.join(base, v, "office6", "addons", "kwpsaitypeset", "mui", "zh_CN")
    print(v, "zh_CN isdir=", os.path.isdir(p))
    pt = os.path.join(p, "presettemplates")
    print("  presettemplates isdir=", os.path.isdir(pt))
    try:
        kids = os.listdir(pt)
        print("  children=%d" % len(kids))
        for k in kids[:12]:
            kp = os.path.join(pt, k)
            print("   child %r isdir=%s" % (k, os.path.isdir(kp)))
            if k.lower().startswith("official") or k.lower().startswith("thesis"):
                try:
                    for k2 in os.listdir(kp)[:12]:
                        print("     grand %r isdir=%s" % (k2, os.path.isdir(os.path.join(kp, k2))))
                except Exception as e:
                    print("     listdir err %r" % e)
    except Exception as e:
        print("  listdir err %r" % e)
