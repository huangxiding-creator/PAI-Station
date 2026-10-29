# -*- coding: utf-8 -*-
# v7c: decode good blobs w/ candidate-set mask; enumerate ambiguous bits;
# verify BOTH modes: (a) direct enc_key HMAC, (b) passphrase -> PBKDF2(256000) -> HMAC.
# Decrypt winners (passphrase mode feeds wx4_pipeline directly; direct mode = custom decrypt).
import ctypes, hashlib, hmac, os, re, struct, sys, time, itertools
import multiprocessing as mp
from find_key_v7 import gather_blobs, collect_dbs, SALT, DATA_END, HSZ, PAGE, RESERVE, BASE, DEC_OUT

OLD_MASK = bytes.fromhex("d2c7442458020000004889442450488b450048844c2448488944254048584c24")
HEXSET = set(b"0123456789abcdefABCDEF")
N = 99

def verify_pair(args):
    """returns (salt_hex, keyhex, mode) mode: 'direct'|'passphrase'"""
    keyhex, salt_hex, pg = args
    try: k = bytes.fromhex(keyhex)
    except Exception: return None
    if len(k) != 32: return None
    salt = pg[:SALT]
    # mode b: passphrase
    enc = hashlib.pbkdf2_hmac("sha512", k, salt, 256000, 32)
    mk = hashlib.pbkdf2_hmac("sha512", enc, bytes(x ^ 0x3A for x in salt), 2, 32)
    calc = hmac.new(mk, pg[SALT:DATA_END] + struct.pack("<I", 1), hashlib.sha512).digest()
    if hmac.compare_digest(calc, pg[DATA_END:DATA_END + HSZ]):
        return (salt_hex, keyhex, "passphrase")
    # mode a: direct enc_key
    mk = hashlib.pbkdf2_hmac("sha512", k, bytes(x ^ 0x3A for x in salt), 2, 32)
    calc = hmac.new(mk, pg[SALT:DATA_END] + struct.pack("<I", 1), hashlib.sha512).digest()
    if hmac.compare_digest(calc, pg[DATA_END:DATA_END + HSZ]):
        return (salt_hex, keyhex, "direct")
    return None

def main():
    t0 = time.time()
    dbs = collect_dbs()
    salt_hexes = set(dbs)
    print(f"dbs={len(dbs)}", flush=True)
    blobs = list(dict.fromkeys(gather_blobs()))
    print(f"blobs99={len(blobs)} ({time.time()-t0:.0f}s)", flush=True)

    good = [b for b in blobs
            if (lambda pre: pre[:2] in (b"x'", b"X'") and all(c in HEXSET for c in pre[2:30]))
            (bytes(v ^ m for v, m in zip(b[:30], OLD_MASK[:30])))]
    print(f"good blobs={len(good)}", flush=True)

    # solve per-position candidate sets for tail 30..98
    mask_sets = [ [OLD_MASK[i]] for i in range(30) ]
    amb = {}
    for i in range(30, N):
        col = [b[i] for b in good]
        want = {ord("'")} if i == N - 1 else HEXSET
        cands = [c for c in range(256) if all(v ^ c in want for v in col)]
        if not cands:
            print(f"INCONSISTENT pos={i}", flush=True); return
        mask_sets.append(cands)
        if len(cands) > 1: amb[i] = cands
    print(f"ambiguous positions: {amb}", flush=True)

    # enumerate combos over ambiguous positions (cap 4096)
    keys = list(amb)
    combos = []
    if len(keys) <= 12:
        for choice in itertools.product(*[amb[k] for k in keys]):
            combos.append(dict(zip(keys, choice)))
    else:
        combos.append({k: v[0] for k, v in amb.items()})
    print(f"combos={len(combos)}", flush=True)

    pairs = set()  # (keyhex, salt_hex)
    for b in good:
        for combo in combos:
            mask = bytes((combo.get(i) or mask_sets[i][0]) for i in range(N))
            dec = bytes(v ^ m for v, m in zip(b, mask))
            run = dec[2:98]
            if not re.fullmatch(rb"[0-9a-fA-F]{96}", run): continue
            run = run.decode().lower()
            kh, es = run[:64], run[64:96]
            if es in salt_hexes:
                pairs.add((kh, es))
    print(f"(key,salt) pairs={len(pairs)} ({time.time()-t0:.0f}s)", flush=True)

    tasks = [(kh, es, dbs[es][1]) for kh, es in pairs]
    hits = []
    with mp.Pool(min(os.cpu_count() or 4, 12)) as pool:
        for r in pool.imap_unordered(verify_pair, tasks, chunksize=1):
            if r: hits.append(r); print(f"HIT {r[2]} salt={r[0][:8]}.. key={r[1][:6]}..*** rel={dbs[r[0]][0]}", flush=True)
    print(f"VERIFY hits={len(hits)}/{len(dbs)} ({time.time()-t0:.0f}s)", flush=True)
    if not hits:
        print("RESULT none", flush=True); return

    import wx4_pipeline as P
    from Crypto.Cipher import AES
    os.makedirs(DEC_OUT, exist_ok=True)
    LOG = []
    log = lambda m: (LOG.append(m), print(m, flush=True))

    def decrypt_direct(src, dst, enc_key):
        """SQLCipher v4 decrypt with pre-derived enc_key (direct mode)."""
        with open(src, "rb") as f, open(dst, "wb") as o:
            first = f.read(PAGE)
            salt = first[:SALT]
            mk = hashlib.pbkdf2_hmac("sha512", enc_key, bytes(x ^ 0x3A for x in salt), 2, 32)
            pages = 1
            cipher = AES.new(enc_key, AES.MODE_CBC, first[PAGE - RESERVE:PAGE - RESERVE + 16])
            dec = cipher.decrypt(first[SALT:PAGE - RESERVE])
            o.write(P.HDR + dec + first[PAGE - RESERVE:PAGE])
            tail = f.read()
            for off in range(0, len(tail), PAGE):
                pb = tail[off:off + PAGE]
                if len(pb) < PAGE: pb = pb + b"\x00" * (PAGE - len(pb))
                if pb.count(0) == PAGE:
                    o.write(pb); pages += 1; continue
                iv = pb[PAGE - RESERVE:PAGE - RESERVE + 16]
                cipher = AES.new(enc_key, AES.MODE_CBC, iv)
                o.write(cipher.decrypt(pb[:PAGE - RESERVE]) + pb[PAGE - RESERVE:PAGE]); pages += 1
        log(f"  direct-decrypted {pages} pages")

    for sh, kh, mode in hits:
        rel = dbs[sh][0]
        s = os.path.join(BASE, rel)
        d = os.path.join(DEC_OUT, rel.replace("\\", "__").replace("/", "__"))
        try:
            if mode == "passphrase":
                ok = P.decrypt_db(s, d, bytes.fromhex(kh), log)
            else:
                decrypt_direct(s, d, bytes.fromhex(kh)); ok = True
            if ok:
                import sqlite3
                con = sqlite3.connect(d)
                n = con.execute("SELECT count(*) FROM sqlite_master WHERE type='table'").fetchone()[0]
                log(f"  VERIFY {os.path.basename(d)}: {n} tables OK"); con.close()
        except Exception as e:
            log(f"  ERROR {rel}: {e!r}")
    with open(os.path.join(DEC_OUT, "_v7c.log"), "w", encoding="utf-8") as f:
        f.write("\n".join(LOG))
    print(f"DEC done -> {DEC_OUT}", flush=True)

if __name__ == "__main__":
    mp.freeze_support()
    main()
