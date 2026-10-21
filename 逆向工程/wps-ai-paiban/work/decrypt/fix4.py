import os, struct, hashlib, zlib
WORK = os.path.dirname(os.path.abspath(__file__))
BLOBS = os.path.join(WORK, "blobs")
MAGIC_A = b"225f8didjBaA"
MAGIC_B = b"ACE4ksmg7AJf"
def pad16(k):
    return (k + bytes(16))[:16]
KEYS = [
    ("magicA_pad", pad16(MAGIC_A)),
    ("magicB_pad", pad16(MAGIC_B)),
    ("md5A", hashlib.md5(MAGIC_A).digest()),
    ("md5B", hashlib.md5(MAGIC_B).digest()),
    ("md5wps", hashlib.md5(b"wps").digest()),
    ("md5kingsoft", hashlib.md5(b"kingsoft").digest()),
    ("md5addon", hashlib.md5(b"kwpsaitypeset").digest()),
    ("shaA16", hashlib.sha256(MAGIC_A).digest()[:16]),
    ("zeros", bytes(16)),
]
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
def printable_ratio(d):
    if not d:
        return 0.0
    ok = sum(1 for b in d if 32 <= b < 127 or b in (9, 10, 13))
    return ok / float(len(d))
def xxtea_decrypt(data, key):
    if len(data) < 8:
        return None
    if len(data) % 4 != 0:
        return None
    n = len(data) // 4
    v = list(struct.unpack("<%dI" % n, data))
    k = list(struct.unpack("<4I", key))
    delta = 0x9E3779B9
    rounds = 6 + 52 // n
    total = (rounds * delta) & 0xFFFFFFFF
    y = v[0]
    while total != 0:
        e = (total >> 2) & 3
        for p in range(n - 1, 0, -1):
            z = v[p - 1]
            mx = (((z >> 5) ^ ((y << 2) & 0xFFFFFFFF)) + ((y >> 3) ^ ((z << 4) & 0xFFFFFFFF))) & 0xFFFFFFFF
            mx = (mx ^ ((total ^ y) + (k[(p & 3) ^ e] ^ z))) & 0xFFFFFFFF
            v[p] = (v[p] - mx) & 0xFFFFFFFF
            y = v[p]
        z = v[n - 1]
        mx = (((z >> 5) ^ ((y << 2) & 0xFFFFFFFF)) + ((y >> 3) ^ ((z << 4) & 0xFFFFFFFF))) & 0xFFFFFFFF
        mx = (mx ^ ((total ^ y) + (k[0 ^ e] ^ z))) & 0xFFFFFFFF
        v[0] = (v[0] - mx) & 0xFFFFFFFF
        y = v[0]
        total = (total - delta) & 0xFFFFFFFF
    return struct.pack("<%dI" % n, *v)
blobs = {n: load(n) for n in NAMES}
print("XXTEA_BATTERY_START")
hits = 0
for n in NAMES:
    blob = blobs[n]
    offsets = [o for o in range(0, 16) if (len(blob) - o) % 4 == 0 and (len(blob) - o) >= 8]
    for o in offsets:
        body = blob[o:]
        for kn, key in KEYS:
            dec = xxtea_decrypt(body, key)
            if dec is None:
                continue
            s = sig_of(dec)
            pr = printable_ratio(dec[:2048])
            mk = dec.find(b"[Content_Types].xml")
            if s or mk >= 0 or pr > 0.9:
                fn = os.path.join(BLOBS, n + "_xxtea_" + kn + "_off" + str(o) + ".dec")
                open(fn, "wb").write(dec)
                print("XHIT %s off=%d key=%s sig=%s printable=%.3f ct_xml=%d saved=%s" % (n, o, kn, s, pr, mk, fn))
                hits += 1
    print("  tried %s offsets=%s" % (n, offsets))
print("XXTEA_HITS=%d" % hits)
print("FIX4_DONE")
