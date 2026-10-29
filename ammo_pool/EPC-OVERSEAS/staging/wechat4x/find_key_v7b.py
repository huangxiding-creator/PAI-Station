# -*- coding: utf-8 -*-
# v7b: 4.1.15.56 mask = old-4.1.11-mask prefix (>=30B, verified decodes x'hex) + new tail.
# Steps: classify blobs by old-mask prefix decode -> keep pure x'hex blobs ->
# charset-solve tail positions (hex chars / closing quote) -> decode, PBKDF2-HMAC verify,
# decrypt in-process (keys stay in RAM).
import ctypes, hashlib, hmac, os, re, struct, subprocess, sys, time, itertools
import ctypes.wintypes as wt
import multiprocessing as mp
from find_key_v7 import (gather_blobs, collect_dbs, ALLOWED, _verify,
                         SALT, DATA_END, HSZ, BASE, DEC_OUT)

OLD_MASK = bytes.fromhex("d2c7442458020000004889442450488b450048844c2448488944254048584c24")
HEXSET = set(b"0123456789abcdefABCDEF")
N = 99

def main():
    t0 = time.time()
    dbs = collect_dbs()
    salt_hexes = set(dbs)
    print(f"dbs={len(dbs)}", flush=True)
    blobs = list(dict.fromkeys(gather_blobs()))
    print(f"blobs99={len(blobs)} ({time.time()-t0:.0f}s)", flush=True)
    if not blobs:
        print("no blobs", flush=True); return

    good = []
    for b in blobs:
        pre = bytes(v ^ m for v, m in zip(b[:30], OLD_MASK[:30]))
        if pre[:2] in (b"x'", b"X'") and all(c in HEXSET for c in pre[2:30]):
            good.append(b)
    print(f"classified x'hex blobs via old-mask prefix: {len(good)}/{len(blobs)}", flush=True)
    if not good:
        print("no blob matches old prefix — prefix changed too", flush=True); return
    # show decoded prefix of first good blob
    d0 = bytes(v ^ m for v, m in zip(good[0][:30], OLD_MASK[:30]))
    print("sample prefix decode:", d0.decode("latin1"), flush=True)

    # charset-solve tail positions 30..98 (hex for 30..97, quote for 98)
    mask = bytearray(OLD_MASK[:30]) + bytearray(N - 30)
    multi = {}
    for i in range(30, N):
        col = [b[i] for b in good]
        want = {ord("'")} if i == N - 1 else HEXSET
        cands = [c for c in range(256) if all(v ^ c in want for v in col)]
        if not cands:
            print(f"INCONSISTENT tail pos={i}", flush=True)
            for b in good[:3]:
                print("  tail-sample:", b[30:].hex(), flush=True)
            return
        mask[i] = cands[0]
        if len(cands) > 1: multi[i] = cands
    print(f"tail solved; multi-candidate positions: {multi if len(multi)<12 else list(multi)[:12]}", flush=True)
    full_mask = bytes(mask)
    print(f"recovered mask[{N}]: {full_mask.hex()}", flush=True)
    # check if mask is periodic with shorter cycle (repeating obfuscation key)
    for L in range(8, 50):
        if full_mask[:N - L] == full_mask[L:] and all(mask[i] == mask[i % L] for i in range(N)):
            print(f"mask is periodic, period={L}: {full_mask[:L].hex()}", flush=True)
            break

    # decode all good blobs
    cands = {}
    for b in good:
        dec = bytes(v ^ m for v, m in zip(b, full_mask))
        run = dec[2:98].decode("ascii", "replace").lower()
        if not re.fullmatch(r"[0-9a-f]{96}", run):
            print("decode mismatch:", dec[:20], flush=True); continue
        kh, es = run[:64], run[64:96]
        if len(set(bytes.fromhex(kh))) >= 15:
            cands.setdefault(kh, es if es in salt_hexes else None)
    print(f"key candidates={len(cands)} (embedded-salt matched: {sum(1 for v in cands.values() if v)}) ({time.time()-t0:.0f}s)", flush=True)

    tasks = []
    for kh, es in cands.items():
        if es: tasks.append((kh, es, dbs[es][1]))
        else:
            for sh, (_rel, pg) in dbs.items(): tasks.append((kh, sh, pg))
    hits = []
    with mp.Pool(min(os.cpu_count() or 4, 12)) as pool:
        for r in pool.imap_unordered(_verify, tasks, chunksize=1):
            if r: hits.append(r); print(f"HIT salt={r[0][:8]}.. key={r[1][:6]}..*** rel={dbs[r[0]][0]}", flush=True)
    print(f"VERIFY hits={len(hits)}/{len(dbs)} ({time.time()-t0:.0f}s)", flush=True)
    if not hits:
        print("RESULT none", flush=True); return
    import wx4_pipeline as P
    os.makedirs(DEC_OUT, exist_ok=True)
    LOG = []
    log = lambda m: (LOG.append(m), print(m, flush=True))
    for sh, kh in hits:
        rel = dbs[sh][0]
        d = os.path.join(DEC_OUT, rel.replace("\\", "__").replace("/", "__"))
        try:
            if P.decrypt_db(os.path.join(BASE, rel), d, bytes.fromhex(kh), log):
                import sqlite3
                con = sqlite3.connect(d)
                n = con.execute("SELECT count(*) FROM sqlite_master WHERE type='table'").fetchone()[0]
                log(f"  VERIFY {os.path.basename(d)}: {n} tables OK"); con.close()
        except Exception as e:
            log(f"  ERROR {rel}: {e!r}")
    with open(os.path.join(DEC_OUT, "_v7b.log"), "w", encoding="utf-8") as f:
        f.write("\n".join(LOG))
    print(f"DEC done -> {DEC_OUT}", flush=True)

if __name__ == "__main__":
    mp.freeze_support()
    main()
