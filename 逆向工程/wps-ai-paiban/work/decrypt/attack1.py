# -*- coding: utf-8 -*-
# attack1.py -- encoding-layer attack on WPS AI-typeset template containers (kwpsaitypeset)
# Analysis only: reads WPS addon template dirs; writes only under this work dir.
import os, sys, io, json, math, base64, binascii, zlib, hashlib, string, zipfile

WORK = os.path.dirname(os.path.abspath(__file__))
OUT1 = os.path.join(WORK, "out1")
BLOBS = os.path.join(WORK, "blobs")
for p in (OUT1, BLOBS):
    os.makedirs(p, exist_ok=True)

LOCAL = os.environ.get("LOCALAPPDATA") or os.path.normpath(os.path.join("C:", os.sep, "Users", "91216", "AppData", "Local"))
VERSIONS = ["12.1.0.28802", "12.1.0.28505"]

def find_dir(rel):
    for v in VERSIONS:
        p = os.path.join(LOCAL, "Kingsoft", "WPS Office", v, "office6", "addons", "kwpsaitypeset", "mui", "zh_CN", *rel.split("/"))
        if os.path.isdir(p) or os.path.isfile(p):
            return p, v
    return None, None

SAMPLES = [
    ("official", "presettemplates/official"),
    ("nationalstandard", "presettemplates/thesis/standard/nationalstandard"),
    ("public_official_template", "publictemplates/public_official_template"),
    ("bid", "customtemplates/bid"),
]

MAGIC_A = b"225f8didjBaA"
MAGIC_B = b"ACE4ksmg7AJf"
B64SET = set((string.ascii_letters + string.digits + "+/").encode("ascii"))
HEAD = 8192
BATTERY_N = 6
MAX_FILES = 60

SIGS = [
    ("zip", b"PK" + bytes([3, 4])),
    ("zip-span", b"PK" + bytes([7, 8])),
    ("zip-empty", b"PK" + bytes([5, 6])),
    ("ole", bytes.fromhex("d0cf11e0a1b11ae1")),
    ("gzip", bytes([0x1f, 0x8b])),
    ("pdf", b"%PDF-"),
    ("png", bytes([0x89]) + b"PNG"),
    ("rar", b"Rar!"),
    ("7z", b"7z" + bytes([0xbc, 0xaf])),
]

LINES = []
HIT_SAID = [0]
HEADS = {}

def say(m):
    LINES.append(m)

def shannon(data):
    if not data:
        return 0.0
    cnt = [0] * 256
    for b in data:
        cnt[b] += 1
    n = float(len(data))
    e = 0.0
    for c in cnt:
        if c:
            p = c / n
            e -= p * math.log2(p)
    return round(e, 3)

def sig_of(d):
    for name, sig in SIGS:
        if d.startswith(sig):
            return name
    if len(d) >= 2 and d[0] == 0x78 and d[1] in (0x01, 0x5e, 0x9c, 0xda):
        return "zlib"
    return None

def text_score(d):
    try:
        s = d.decode("utf-8")
        ok = True
    except UnicodeDecodeError:
        s = d.decode("utf-8", "ignore")
        ok = False
    if not s:
        return 0, 0.0, ok
    cjk = 0
    pr = 0
    for ch in s:
        o = ord(ch)
        if 0x4e00 <= o <= 0x9fff:
            cjk += 1
        if ch.isprintable() or o in (13, 10, 9):
            pr += 1
    return cjk, round(pr / float(len(s)), 3), ok

def hexsp(b, n=64):
    h = binascii.hexlify(b[:n]).decode("ascii")
    return " ".join(h[i:i + 2] for i in range(0, len(h), 2))

def asciirep(b, n=64):
    return "".join(chr(x) if 32 <= x < 127 else "." for x in b[:n])

def inflate_all(d):
    out = []
    for name, wbits in (("zlib", 15), ("raw-deflate", -15), ("gzip", 31)):
        try:
            out.append((name, zlib.decompress(d, wbits)))
        except Exception:
            pass
    return out

def rc4(key, data):
    S = list(range(256))
    j = 0
    kb = key if isinstance(key, bytes) else key.encode("ascii")
    for i in range(256):
        j = (j + S[i] + kb[i % len(kb)]) & 0xff
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

def clean_b64(body):
    try:
        txt = "".join(body.decode("ascii").split())
    except UnicodeDecodeError:
        return None, "non-ascii"
    for c in txt:
        if c not in B64SET and c != "=":
            return None, "badchar:" + c
    t = txt.rstrip("=")
    pads = len(txt) - len(t)
    if "=" in t:
        return None, "pad-mid"
    if pads > 2:
        return None, "pad>2"
    if len(txt) % 4 == 1:
        return None, "len mod 4 is 1"
    add = (4 - len(txt) % 4) % 4
    return (txt + "=" * add).encode("ascii"), add

def template_like(d):
    if not d:
        return False
    ls = d[:65536].lstrip()
    if ls[:1] in (b"<", b"{"):
        return True
    cjk, ratio, ok = text_score(d[:8192])
    return bool(ok and cjk >= 20 and ratio > 0.85)

def sname(s):
    return "".join(c if (c.isalnum() or c in "-_.") else "_" for c in s)[:80]

def save(path, data):
    with open(path, "wb") as f:
        f.write(data)
    return path

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
        try:
            data = zf.read(info)
        except Exception:
            listing.append([info.filename, -1, "read-error"])
            continue
        save(target, data)
        listing.append([info.filename, len(data), ""])
    return listing
KEYS = [MAGIC_A, MAGIC_B, b"wps", b"WPS", b"kingsoft", b"kwpsaitypeset",
        b"aitypeset", hashlib.md5(MAGIC_A).digest(), hashlib.md5(MAGIC_B).digest(),
        hashlib.sha256(MAGIC_A).digest()]

def kname(k):
    if k in (MAGIC_A, MAGIC_B):
        return k.decode("ascii")
    return k.hex()[:12]

def attack_blob(blob, tag, rec, prefix, heavy):
    got = []

    def hit(kind, detail, data, ext="bin"):
        entry = {"transform": kind, "detail": detail[:200]}
        if data is not None:
            sig = sig_of(data)
            entry["sig"] = sig
            cjk, ratio, ok = text_score(data[:8192])
            entry["head_utf8"] = {"cjk": cjk, "ratio": ratio, "ok": ok}
            entry["readable"] = template_like(data)
            if entry["readable"] or sig:
                fn = prefix + "." + ext
                save(fn, data[:8 * 1024 * 1024])
                entry["saved"] = fn
                if sig == "zip":
                    dd = os.path.join(OUT1, sname(tag))
                    try:
                        lst = safe_unzip(data, dd)
                        entry["unzipped_to"] = dd
                        entry["unzip_listing"] = lst[:200]
                    except Exception as ex:
                        entry["unzip_error"] = str(ex)[:200]
        rec.setdefault("hits", []).append(entry)
        if HIT_SAID[0] < 40:
            HIT_SAID[0] += 1
            say("HIT %s %s %s sig=%s readable=%s" % (tag, kind, detail[:120], entry.get("sig"), entry.get("readable")))
        if entry.get("readable") or entry.get("unzip_listing"):
            got.append(True)

    sig = sig_of(blob)
    if sig:
        hit("plain", "sig=" + sig, blob, "plain")
    for name, dec in inflate_all(blob):
        hit("plain+" + name, "len=%d" % len(dec), dec, "infl")

    cur = blob
    for layer in range(2, 5):
        s = set(cur)
        if not s or not (s <= (B64SET | {61})):
            break
        try:
            nxt = base64.b64decode(cur)
        except Exception:
            break
        if not nxt or nxt == cur:
            break
        rec["b64_layers"] = layer
        if sig_of(nxt) or template_like(nxt) or inflate_all(nxt):
            hit("b64x%d" % layer, "len=%d" % len(nxt), nxt, "b%d" % layer)
            break
        cur = nxt

    if not heavy:
        return bool(got)

    head = blob[:HEAD]
    for k in range(1, 256):
        xh = xor1(head, k)
        sig = sig_of(xh)
        if sig:
            hit("xor1(0x%02x)" % k, "sig=" + sig, xor1(blob, k), "x%02x" % k)
        else:
            cjk, ratio, ok = text_score(xh[:1024])
            if ok and cjk >= 15 and ratio > 0.9:
                full = xor1(blob, k)
                if template_like(full):
                    hit("xor1(0x%02x)" % k, "utf8 cjk=%d" % cjk, full, "x%02x" % k)

    for key in KEYS:
        xh = xor_cycle(head, key)
        sig = sig_of(xh)
        if sig:
            hit("xorkey(" + kname(key) + ")", "sig=" + sig, xor_cycle(blob, key), "xk")
        elif template_like(xh):
            hit("xorkey(" + kname(key) + ")", "utf8", xor_cycle(blob, key), "xk")

    for key in KEYS:
        xh = rc4(key, head)
        sig = sig_of(xh)
        if sig:
            hit("rc4(" + kname(key) + ")", "sig=" + sig, rc4(key, blob), "rc4")
        elif template_like(xh):
            hit("rc4(" + kname(key) + ")", "utf8", rc4(key, blob), "rc4")

    return bool(got)

def process_file(dirkey, idx, path, heavy):
    name = os.path.basename(path)
    size = os.path.getsize(path)
    rec = {"dir": dirkey, "idx": idx, "file": name, "path": path, "size": size, "hits": []}
    try:
        with open(path, "rb") as f:
            data = f.read(32 * 1024 * 1024)
    except Exception as ex:
        rec["error"] = str(ex)[:200]
        return rec
    magic = data[:12]
    if magic == MAGIC_A:
        rec["magic"] = "A"
    elif magic == MAGIC_B:
        rec["magic"] = "B"
    else:
        rec["magic"] = "unknown"
        rec["magic_hex"] = hexsp(magic, 12)
        return rec
    body = data[12:]
    rec["body_len"] = len(body)
    rec["body_head_ascii"] = asciirep(body, 48)
    clean, err = clean_b64(body)
    rec["b64_valid"] = clean is not None
    rec["b64_err"] = err
    if clean is None:
        attack_blob(body, "%s_%02d_%s" % (dirkey, idx, sname(name)), rec,
                    os.path.join(BLOBS, "%s_%02d_%s_raw" % (dirkey, idx, sname(name))), heavy)
        return rec
    rec["b64_clean_len"] = len(clean)
    try:
        blob = base64.b64decode(clean, validate=True)
    except Exception as ex:
        rec["b64_decode_error"] = str(ex)[:200]
        return rec
    rec["blob_len"] = len(blob)
    rec["blob_mod16"] = len(blob) % 16
    rec["blob_head_hex"] = hexsp(blob, 64)
    rec["blob_head_ascii"] = asciirep(blob, 64)
    rec["blob_entropy"] = shannon(blob[:524288])
    sample = blob[:65536]
    if sample:
        pr = sum(1 for b in sample if 32 <= b < 127 or b in (9, 10, 13)) / float(len(sample))
        rec["blob_printable"] = round(pr, 4)
    rec["sig_plain"] = sig_of(blob)
    HEADS.setdefault(rec["magic"], []).append(blob[:4096])
    tag = "%s_%02d_%s" % (dirkey, idx, sname(name))
    if idx <= 3:
        save(os.path.join(BLOBS, tag + ".blob.bin"), blob[:2097152])
    attack_blob(blob, tag, rec, os.path.join(BLOBS, tag), heavy)
    return rec

def lcp(items, cap=4096):
    if len(items) < 2:
        return None
    n = cap
    for a, b in zip(items, items[1:]):
        m = 0
        for x, y in zip(a[:cap], b[:cap]):
            if x != y:
                break
            m += 1
        if m < n:
            n = m
        if n == 0:
            return 0
    return n
def main():
    report = {"script": "attack1.py", "local": LOCAL, "samples": {}, "files": []}
    for dirkey, rel in SAMPLES:
        d, ver = find_dir(rel)
        report["samples"][dirkey] = {"rel": rel, "path": d, "version": ver}
        if not d:
            say("DIR %s MISSING (searched versions %s)" % (dirkey, ",".join(VERSIONS)))
            continue
        fs = []
        if os.path.isfile(d):
            fs.append(d)
        for root, dirs, names in os.walk(d):
            dirs.sort()
            for n in sorted(names):
                fs.append(os.path.join(root, n))
        total = len(fs)
        fs = fs[:MAX_FILES]
        say("DIR %s ver=%s total_files=%d processing=%d" % (dirkey, ver, total, len(fs)))
        for idx, p in enumerate(fs, 1):
            rec = process_file(dirkey, idx, p, idx <= BATTERY_N)
            report["files"].append(rec)
            if idx <= 12:
                say("FILE %s/%02d sz=%d magic=%s b64=%s blob=%s mod16=%s ent=%s print=%s sig=%s hits=%d" % (
                    dirkey, idx, rec.get("size", 0), rec.get("magic"), rec.get("b64_valid"),
                    rec.get("blob_len"), rec.get("blob_mod16"), rec.get("blob_entropy"),
                    rec.get("blob_printable"), rec.get("sig_plain"), len(rec.get("hits", []))))

    cmpx = {}
    for g, heads in sorted(HEADS.items()):
        rs = [r for r in report["files"] if r.get("magic") == g and r.get("b64_valid")]
        mod16s = sorted(set(r["blob_mod16"] for r in rs))
        cmpx[g] = {
            "count": len(rs),
            "mod16_values": mod16s,
            "lcp_prefix_bytes": lcp(heads),
            "avg_entropy": round(sum(r["blob_entropy"] for r in rs) / len(rs), 3) if rs else None,
            "len_range": [min(r["blob_len"] for r in rs), max(r["blob_len"] for r in rs)],
            "example_heads": [r["blob_head_hex"] for r in rs[:2]],
        }
        say("CMP magic=%s count=%d mod16=%s lcp=%s ent=%s lens=%s..%s" % (
            g, cmpx[g]["count"], mod16s, cmpx[g]["lcp_prefix_bytes"], cmpx[g]["avg_entropy"],
            cmpx[g]["len_range"][0], cmpx[g]["len_range"][1]))
        for e in cmpx[g]["example_heads"]:
            say("CMP-HEAD %s %s" % (g, e))
    report["comparison"] = cmpx

    brk = any((e.get("readable") or e.get("unzip_listing"))
              for r in report["files"] for e in r.get("hits", []))
    decoded = sum(1 for r in report["files"] if r.get("b64_valid"))
    anysig = any(r.get("sig_plain") for r in report["files"])
    if brk:
        lvl = "breakthrough"
        why = "readable template content recovered (see HIT lines and out1)"
    elif decoded or anysig:
        lvl = "partial"
        why = "base64 layer decoded for %d files; container structure characterized; deeper encryption not broken" % decoded
    else:
        lvl = "dead-end"
        why = "no file decoded through the base64 layer"
    report["verdict"] = {"level": lvl, "reason": why,
                         "files_processed": len(report["files"]), "files_decoded": decoded}
    say("VERDICT %s -- %s (processed=%d decoded=%d)" % (lvl, why, len(report["files"]), decoded))

    with open(os.path.join(WORK, "attack1_report.json"), "w", encoding="utf-8") as f:
        json.dump(report, f, ensure_ascii=True, indent=1)
    with open(os.path.join(WORK, "attack1_report.txt"), "w", encoding="utf-8") as f:
        for line in LINES:
            f.write(line)
            f.write(chr(10))
    for line in LINES:
        print(line[:500])
    print("REPORT_JSON=" + os.path.join(WORK, "attack1_report.json"))
    print("DONE")

if __name__ == "__main__":
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    main()
