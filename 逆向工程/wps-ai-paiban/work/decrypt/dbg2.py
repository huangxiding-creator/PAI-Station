import os
L = os.environ.get("LOCALAPPDATA")
def probe(path):
    print("PROBE %s" % path)
    try:
        st = os.lstat(path)
        print("  lstat mode=%o islink=%s" % (st.st_mode, os.path.islink(path)))
    except Exception as e:
        print("  lstat err %r" % e)
    try:
        tgt = os.readlink(path)
        print("  readlink -> %r" % tgt)
        full = tgt if os.path.isabs(tgt) else os.path.normpath(os.path.join(os.path.dirname(path), tgt))
        print("  target_abs=%r exists=%s isdir=%s" % (full, os.path.exists(full), os.path.isdir(full)))
        if os.path.isdir(full):
            try:
                kids = os.listdir(full)
                print("  target_children=%d first=%r" % (len(kids), kids[:6]))
            except Exception as e:
                print("  target listdir err %r" % e)
    except Exception as e:
        print("  readlink err %r" % e)
for v in ("12.1.0.28802", "12.1.0.28505"):
    zh = os.path.join(L, "Kingsoft", "WPS Office", v, "office6", "addons", "kwpsaitypeset", "mui", "zh_CN")
    for sub in ("presettemplates/official", "presettemplates/bid", "presettemplates/thesis/standard/nationalstandard", "publictemplates/public_official_template", "customtemplates/bid"):
        probe(os.path.join(zh, *sub.split("/")))
