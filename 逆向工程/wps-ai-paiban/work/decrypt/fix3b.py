import os, base64, binascii, hashlib, zlib
WORK = os.path.dirname(os.path.abspath(__file__))
BLOBS = os.path.join(WORK, "blobs")
MAGIC_A = b"225f8didjBaA"
MAGIC_B = b"ACE4ksmg7AJf"
KEYS = [MAGIC_A, MAGIC_B, b"wps", b"WPS", b"kingsoft", b"kwpsaitypeset", b"aitypeset", b"typeset", b"template", b"official",
        hashlib.md5(MAGIC_A).digest(), hashlib.md5(MAGIC_B).digest(),
        hashlib.sha256(MAGIC_A).digest(), hashlib.sha256(MAGIC_B).digest()]
MARKERS = [b"[Content_Types].xml", b"word/document.xml", b"docProps", b"PK" + bytes([3, 4]), b"Microsoft", b"WPS"]
NAMES = ["official", "nationalstandard", "public_official_template", "bid"]
def load(name):
    return open(os.path.join(BLOBS, name + ".blob.bin"), "rb").read()
def sig_of(d):
    if d[:4] == b"PK" + bytes([3, 4]): return "zip"
    if d[:8] == bytes.fromhex("d0cf11e0a1b11ae1"): return "ole"
    if d[:2] == bytes([0x1f, 0x8b]): return "gzip"
    if d[:5] == b"%PDF-": return "pdf"
    if len(d) >= 2 and d[0] == 0x78 and d[1] in (0x01, 0x5e, 0x9c, 0xda): return "zlib"
    return None
def utf8_cjk(d):
    try:
        s = d.decode("utf-8")
        ok = True
    except UnicodeDecodeError:
        s = d.decode("utf-8", "ignore")
        ok = False
    cjk = 0
    for ch in s:
        if 0x4e00 <= ord(ch) <= 0x9fff:
            cjk += 1
    return ok, cjk
def rc4(key, data):
    S = list(range(256))
    j = 0
    for i in range(256):
        j = (j + S[i] + key[i % len(key)]) & 0xff
        S[i], S[j] = S[j], S[i]
    res = bytearray()
    i = j = 0
    for b in data:
        i = (i + 1) & 0xff
        j = (j + S[i]) & 0xff
        S[i], S[j] = S[j], S[i]
        res.append(b ^ S[(S[i] + S[j]) & 0xff])
    return bytes(res)
def xor_cycle(d, key):
    return bytes(b ^ key[i % len(key)] for i, b in enumerate(d))
def xor1(d, k):
    return bytes(b ^ k for b in d)
blobs = {n: load(n) for n in NAMES}
print("MARKER_SCAN")
for n in NAMES:
    b = blobs[n]
    for m in MARKERS:
        pos = b.find(m)
        if pos >= 0:
            print("  MARK %s at %d: %r" % (n, pos, m))
print("PAIRWISE_XOR")
for i in range(len(NAMES)):
    for j in range(i + 1, len(NAMES)):
        a = blobs[NAMES[i]]
        b = blobs[NAMES[j]]
        x = bytes(p ^ q for p, q in zip(a, b))
        z = 0
        for c in x:
            if c == 0:
                z += 1
            else:
                break
        h = binascii.hexlify(x[:24]).decode("ascii")
        print("  XOR %s ^ %s zero_prefix=%d head=%s" % (NAMES[i], NAMES[j], z, h))
        fn = os.path.join(BLOBS, "xorpair_" + NAMES[i] + "_" + NAMES[j] + ".bin")
        open(fn, "wb").write(x)
def try_all(tag, data):
    sig = sig_of(data)
    ok, cjk = utf8_cjk(data[:4096])
    if sig or (ok and cjk >= 30):
        fn = os.path.join(BLOBS, tag + ".hit")
        open(fn, "wb").write(data[:8388608])
        print("BHIT %s sig=%s utf8=%s cjk=%d saved=%s" % (tag, sig, ok, cjk, fn))
        return True
    return False
print("BATTERY_START")
for n in NAMES:
    blob = blobs[n]
    head = blob[:8192]
    for k in range(1, 256):
        xh = xor1(head, k)
        s = sig_of(xh)
        if s:
            try_all(n + "_xor1_%02x" % k, xor1(blob, k))
            continue
        ok, cjk = utf8_cjk(xh[:1024])
        if ok and cjk >= 15:
            try_all(n + "_xor1_%02x" % k, xor1(blob, k))
    for key in KEYS:
        tag = key.decode("ascii", "replace")[:10] if len(key) <= 16 else key.hex()[:10]
        xh = xor_cycle(head, key)
        s = sig_of(xh)
        if s:
            try_all(n + "_xorkey_" + tag, xor_cycle(blob, key))
            continue
        ok, cjk = utf8_cjk(xh[:1024])
        if ok and cjk >= 15:
            try_all(n + "_xorkey_" + tag, xor_cycle(blob, key))
    for key in KEYS:
        tag = key.hex()[:10]
        xh = rc4(key, head)
        s = sig_of(xh)
        if s:
            try_all(n + "_rc4_" + tag, rc4(key, blob))
            continue
        ok, cjk = utf8_cjk(xh[:1024])
        if ok and cjk >= 15:
            try_all(n + "_rc4_" + tag, rc4(key, blob))
    for wname, wbits in (("zlib", 15), ("raw", -15), ("gzip", 31)):
        try:
            dec = zlib.decompress(blob, wbits)
            print("INFLATE %s %s len=%d" % (n, wname, len(dec)))
            try_all(n + "_infl_" + wname, dec)
        except Exception:
            pass
print("BATTERY_DONE")
print("FIX3B_DONE")
