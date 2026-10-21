import os, sys, io, json, base64, binascii, string, zipfile
WORK = os.path.dirname(os.path.abspath(__file__))
OUT1 = os.path.join(WORK, "out1")
BLOBS = os.path.join(WORK, "blobs")
rep = json.load(open(os.path.join(WORK, "attack1_report.json"), "r", encoding="utf-8"))
for r in rep["files"]:
    print("REC %s size=%d magic=%s b64_err=%s body_ascii=%r hits=%d" % (
        r.get("dir"), r.get("size"), r.get("magic"), r.get("b64_err"),
        r.get("body_head_ascii"), len(r.get("hits", []))))
    for h in r.get("hits", []):
        print("  HIT %s detail=%s readable=%s saved=%s sig=%s utf8=%s" % (
            h.get("transform"), h.get("detail"), h.get("readable"),
            h.get("saved"), h.get("sig"), h.get("head_utf8")))
LOCAL = os.environ.get("LOCALAPPDATA")
WPS = os.path.join(LOCAL, "Kingsoft", "WPS Office", "12.1.0.28802", "office6", "addons", "kwpsaitypeset", "mui", "zh_CN")
FILES = [
    ("official", os.path.join(WPS, "presettemplates", "official")),
    ("nationalstandard", os.path.join(WPS, "presettemplates", "thesis", "standard", "nationalstandard")),
    ("public_official_template", os.path.join(WPS, "publictemplates", "public_official_template")),
    ("bid", os.path.join(WPS, "customtemplates", "bid")),
]
MAGIC_A = b"225f8didjBaA"
MAGIC_B = b"ACE4ksmg7AJf"
B64SET = set((string.ascii_letters + string.digits + "+/=").encode("ascii"))
def hexsp(b, n):
    h = binascii.hexlify(b[:n]).decode("ascii")
    return " ".join(h[i:i+2] for i in range(0, len(h), 2))
def asciirep(b, n):
    return "".join(chr(x) if 32 <= x < 127 else "." for x in b[:n])
def xor_cycle(d, key):
    return bytes(b ^ key[i % len(key)] for i, b in enumerate(d))
def sname(s):
    return "".join(c if (c.isalnum() or c in "-_.") else "_" for c in s)[:80]
def safe_unzip(zbytes, dest):
    listing = []
    os.makedirs(dest, exist_ok=True)
    zf = zipfile.ZipFile(io.BytesIO(zbytes))
    for info in zf.infolist():
        if info.is_dir():
            continue
        parts = [p for p in info.filename.replace(chr(92), "/").split("/") if p not in ("", ".", "..")]
        if not parts:
            continue
        target = os.path.join(dest, *parts)
        os.makedirs(os.path.dirname(target), exist_ok=True)
        data = zf.read(info)
        open(target, "wb").write(data)
        listing.append([info.filename, len(data)])
    return listing
KEYS = [MAGIC_A, MAGIC_B, b"wps", b"kingsoft", b"kwpsaitypeset", b"official", b"public"]
for key_name, path in FILES:
    data = open(path, "rb").read()
    body = data[12:]
    print("FILE %s total=%d body=%d magic12=%r" % (key_name, len(data), len(body), data[:12]))
    print("  body_head_hex=%s" % hexsp(body, 48))
    print("  body_head_ascii=%r" % asciirep(body, 48))
    for key in KEYS:
        x = xor_cycle(body, key)
        s = set(x)
        if s <= B64SET:
            try:
                blob = base64.b64decode(x)
            except Exception as e:
                print("  XORKEY %s -> b64text but decode err %r" % (key.decode("ascii"), e))
                continue
            sig = blob[:4]
            print("  XORKEY %s -> pure-b64 -> blob len=%d head=%r" % (key.decode("ascii"), len(blob), blob[:8]))
            fn = os.path.join(BLOBS, sname(key_name) + "_xor" + key.decode("ascii")[:8] + ".dec")
            open(fn, "wb").write(blob)
            print("    saved=%s" % fn)
            if blob[:2] == b"PK":
                dest = os.path.join(OUT1, sname(key_name))
                try:
                    lst = safe_unzip(blob, dest)
                    print("    ZIP_OK entries=%d dest=%s" % (len(lst), dest))
                    for e in lst[:25]:
                        print("      ENTRY %s %d" % (e[0], e[1]))
                except Exception as e:
                    print("    ZIP_FAIL %r" % e)
        else:
            head_ok = x[:4]
            if x[:2] == b"PK" or x[:1] == b"{" or x[:1] == b"<":
                print("  XORKEY %s -> direct container head=%r" % (key.decode("ascii"), x[:12]))
                fn = os.path.join(BLOBS, sname(key_name) + "_xor" + key.decode("ascii")[:8] + ".direct")
                open(fn, "wb").write(x[:4194304])
                if x[:2] == b"PK":
                    dest = os.path.join(OUT1, sname(key_name) + "_direct")
                    try:
                        lst = safe_unzip(x, dest)
                        print("    ZIP_OK entries=%d dest=%s" % (len(lst), dest))
                        for e in lst[:25]:
                            print("      ENTRY %s %d" % (e[0], e[1]))
                    except Exception as e:
                        print("    ZIP_FAIL %r" % e)
print("INSPECT_DONE")
