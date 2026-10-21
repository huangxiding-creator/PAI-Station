# -*- coding: utf-8 -*-
# Static string-intel extraction for kwpsaitypeset.dll (analysis only, never executes target)
# usage: py -3 -I analyze_dll.py <dll_path> <hits_file> <outdir>
import sys, re, struct, os, math

dll_path, hits_path, outdir = sys.argv[1], sys.argv[2], sys.argv[3]
data = open(dll_path, 'rb').read()
n = len(data)
PRINT_RUN = re.compile(rb'[\x20-\x7e]{4,}')

# ---------- PE section map ----------
secs = []
try:
    e_lfanew = struct.unpack_from('<I', data, 0x3c)[0]
    if data[e_lfanew:e_lfanew+4] == b'PE\x00\x00':
        coff = e_lfanew + 4
        machine, nsec, _, _, _, optsize, _ = struct.unpack_from('<HHIIIHH', data, coff)
        opt = coff + 20
        sec_off = opt + optsize
        magic = struct.unpack_from('<H', data, opt)[0]
        imgbase = struct.unpack_from('<I', data, opt+28)[0] if magic == 0x10b else 0
        for i in range(nsec):
            base = sec_off + i*40
            name = data[base:base+8].rstrip(b'\x00').decode('ascii', 'replace')
            vsize, vaddr, rawsize, rawptr = struct.unpack_from('<IIII', data, base+8)
            secs.append((name, rawptr, rawsize, vaddr, vsize))
except Exception as e:
    imgbase = 0

def where(off):
    for name, rawptr, rawsize, vaddr, vsize in secs:
        if rawptr <= off < rawptr + max(rawsize, 1):
            rva = vaddr + (off - rawptr)
            return name, rva, (imgbase + rva) if imgbase else 0
    return '?', 0, 0

with open(os.path.join(outdir, 'sections.txt'), 'w', encoding='utf-8') as f:
    f.write(f"file_size={n} machine=0x{machine:x} image_base=0x{imgbase:x} magic=0x{magic:x}\n")
    for name, rawptr, rawsize, vaddr, vsize in secs:
        f.write(f"{name:10s} raw=0x{rawptr:08x}-0x{rawptr+rawsize:08x} size={rawsize:8d} rva=0x{vaddr:08x} vsize={vsize}\n")

# ---------- 1) context windows around each rg hit ----------
hits = []
for line in open(hits_path, encoding='utf-8'):
    line = line.strip()
    if not line:
        continue
    off_s, term = line.split(':', 1)
    hits.append((int(off_s), term))

out = []
seen_windows = set()
for off, term in sorted(hits):
    lo = max(0, off-256); hi = min(n, off+len(term)+256)
    key = (lo, hi)
    if key in seen_windows:
        continue
    seen_windows.add(key)
    sec, rva, va = where(off)
    out.append(f"== {term} @ file_off={off} sec={sec} rva=0x{rva:x} va=0x{va:x} window=[{lo},{hi}) ==")
    for m in PRINT_RUN.finditer(data[lo:hi]):
        t = m.group().decode('ascii')
        out.append(f"   {lo+m.start():>8d} | {t}")
    out.append("")
open(os.path.join(outdir, 'ctx_windows.txt'), 'w', encoding='utf-8').write('\n'.join(out))

# ---------- 2) 16/24/32-char high-entropy printable candidates ----------
def metrics(t):
    l = len(t)
    distinct = len(set(t))
    freq = {}
    for c in t:
        freq[c] = freq.get(c, 0)+1
    ent = -sum((v/l)*math.log2(v/l) for v in freq.values())
    classes = sum([any(c.islower() for c in t), any(c.isupper() for c in t),
                   any(c.isdigit() for c in t), any(not c.isalnum() for c in t)])
    return distinct/l, classes, ent

B64 = set('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=')
HEX = set('0123456789abcdefABCDEF')
cands = []
for m in PRINT_RUN.finditer(data):
    s = m.group(); l = len(s)
    if l not in (16, 24, 32):
        continue
    t = s.decode('ascii')
    dr, classes, ent = metrics(t)
    if dr >= 0.7 and classes >= 2 and ent >= 3.5:
        b64ish = 'B64' if set(t) <= B64 else ''
        hexish = 'HEX' if set(t) <= HEX else ''
        sec, rva, _ = where(m.start())
        cands.append((m.start(), t, round(dr, 2), classes, round(ent, 2), f"{b64ish}{hexish}", sec))
with open(os.path.join(outdir, 'key_candidates.txt'), 'w', encoding='utf-8') as f:
    f.write(f"total={len(cands)}\n")
    for off, t, dr, classes, ent, tag, sec in cands:
        f.write(f"{off:>8d} {sec:8s} len={len(t)} dr={dr} cls={classes} ent={ent} {tag:4s} {t}\n")

# ---------- 3) strings named key/Key/secret/seed ----------
named = []
for m in PRINT_RUN.finditer(data):
    t = m.group().decode('ascii')
    tl = t.lower()
    if 'key' in tl or 'secret' in tl or 'seed' in tl:
        named.append((m.start(), t))
with open(os.path.join(outdir, 'named_keys.txt'), 'w', encoding='utf-8') as f:
    f.write(f"total={len(named)}\n")
    for off, t in named:
        f.write(f"{off:>8d} | {t}\n")

# ---------- 4) extra crypto markers (ASCII) ----------
MARK = re.compile(rb'decrypt|Decrypt|DECRYPT|encrypt|Encrypt|RC4|rc4|MD5|md5|SHA1|sha1|SHA256|sha256|SHA512|salt|Salt|SALT|EVP_|AES_|_AES|Cipher|cipher|openssl|OpenSSL|Crypto|crypto|QAESEncryption|QCryptographicHash|Xor|xor_')
mk = []
for m in PRINT_RUN.finditer(data):
    if MARK.search(m.group()):
        mk.append((m.start(), m.group().decode('ascii')))
with open(os.path.join(outdir, 'crypto_markers.txt'), 'w', encoding='utf-8') as f:
    f.write(f"total={len(mk)}\n")
    for off, t in mk:
        f.write(f"{off:>8d} | {t}\n")

# ---------- 5) UTF-16LE hits ----------
u16_kw = ['template', 'Template', 'customtemplates', 'presettemplates', 'publictemplates',
          'Base64', 'Decode', 'AES', 'aes', 'xor', 'XOR', 'nationalstandard', 'desc_base',
          'KFormat', 'QCryptographicHash', 'QAESEncryption', 'decrypt', 'Decrypt',
          'encrypt', 'secret', 'Secret', 'privateKey', 'PublicKey']
u16 = []
for kw in u16_kw:
    pat = kw.encode('utf-16-le')
    start = 0
    while True:
        i = data.find(pat, start)
        if i < 0:
            break
        # extend to full printable UTF-16 run
        a = i
        while a-2 >= 0 and 0x20 <= data[a-2] <= 0x7e and data[a-1] == 0:
            a -= 2
        b = i + len(pat)
        while b+1 < n and 0x20 <= data[b] <= 0x7e and data[b+1] == 0:
            b += 2
        u16.append((i, kw, data[a:b].decode('utf-16-le')))
        start = i + 2
with open(os.path.join(outdir, 'utf16_hits.txt'), 'w', encoding='utf-8') as f:
    f.write(f"total={len(u16)}\n")
    for off, kw, t in sorted(u16):
        f.write(f"{off:>8d} kw={kw:20s} | {t}\n")

print("ctx_windows written:", len(seen_windows))
print("key_candidates:", len(cands))
print("named_keys:", len(named))
print("crypto_markers:", len(mk))
print("utf16_hits:", len(u16))
