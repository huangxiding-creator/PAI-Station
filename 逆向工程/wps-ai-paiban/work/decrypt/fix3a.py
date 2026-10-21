import os, base64, binascii, math, zlib
WORK = os.path.dirname(os.path.abspath(__file__))
BLOBS = os.path.join(WORK, "blobs")
LOCAL = os.environ.get("LOCALAPPDATA")
WPS = os.path.join(LOCAL, "Kingsoft", "WPS Office", "12.1.0.28802", "office6", "addons", "kwpsaitypeset", "mui", "zh_CN")
FILES = [
    ("official", os.path.join(WPS, "presettemplates", "official")),
    ("nationalstandard", os.path.join(WPS, "presettemplates", "thesis", "standard", "nationalstandard")),
    ("public_official_template", os.path.join(WPS, "publictemplates", "public_official_template")),
    ("bid", os.path.join(WPS, "customtemplates", "bid")),
]
def hexsp(b, n):
    h = binascii.hexlify(b[:n]).decode("ascii")
    return " ".join(h[i:i+2] for i in range(0, len(h), 2))
def entropy(d):
    if not d:
        return 0.0
    cnt = [0]*256
    for b in d:
        cnt[b] += 1
    n = float(len(d))
    e = 0.0
    for c in cnt:
        if c:
            p = c/n
            e -= p*math.log2(p)
    return round(e, 3)
blobs = {}
for name, path in FILES:
    data = open(path, "rb").read()
    txt = b"".join(data[12:].split())
    blob = base64.b64decode(txt, validate=True)
    blobs[name] = blob
    fn = os.path.join(BLOBS, name + ".blob.bin")
    open(fn, "wb").write(blob)
    print("BLOB %s len=%d mod16=%d ent=%s" % (name, len(blob), len(blob)%16, entropy(blob)))
    print("  hex=%s" % hexsp(blob, 48))
names = sorted(blobs)
for i in range(len(names)):
    for j in range(i+1, len(names)):
        a = blobs[names[i]]
        b = blobs[names[j]]
        n = min(len(a), len(b))
        d = n
        for k in range(n):
            if a[k] != b[k]:
                d = k
                break
        print("DIFF %s vs %s offset=%d" % (names[i], names[j], d))
for wname, wbits in (("zlib", 15), ("raw", -15), ("gzip", 31)):
    for name in names:
        try:
            dec = zlib.decompress(blobs[name], wbits)
            print("INFLATE %s %s len=%d" % (name, wname, len(dec)))
        except Exception:
            pass
print("FIX3A_DONE")
