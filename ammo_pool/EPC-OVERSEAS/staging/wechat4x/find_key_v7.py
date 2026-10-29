# -*- coding: utf-8 -*-
# v7: charset-constraint XOR mask recovery for Weixin 4.1.15.56 Config.Cipher blobs
# Structure layer confirmed intact by v6 (209/209 nodes, 35x 99B blobs).
# Upstream mask (4.1.11) = Weixin.dll code bytes -> changed per version.
# Plaintext of 99B blob = x' + 64hexkey + 32hexsalt + '  (charset: x'0-9a-fA-F)
# 35 blobs share the mask bytewise per position -> each position has 35 constraints
# -> unique mask recovery regardless of mask length/repetition. Then verify + decrypt.
import ctypes, hashlib, hmac, os, re, struct, subprocess, sys, time
import ctypes.wintypes as wt
import multiprocessing as mp

PAGE = 4096; SALT = 16; HSZ = 64; RESERVE = 80; DATA_END = PAGE - RESERVE + 16
NEEDLE = b"com.Tencent.WCDB.Config.Cipher"
MAXADDR = 0x7FFFFFFFFFFF
READABLE = {2, 4, 8, 16, 32, 64, 128}
CHUNK = 32 * 1024 * 1024
BASE = r"C:/Users/91216/xwechat_files/wxid_ui29wkg2ug6922_66f7/db_storage"
DEC_OUT = r"C:/Users/91216/AppData/Local/Temp/wx4_dec"
ALLOWED = set(b"xX'") | set(b"0123456789") | set(b"abcdef") | set(b"ABCDEF")

kernel32 = ctypes.windll.kernel32

class MBI(ctypes.Structure):
    _fields_ = [("BaseAddress", ctypes.c_uint64), ("AllocationBase", ctypes.c_uint64),
                ("AllocationProtect", wt.DWORD), ("_p1", wt.DWORD),
                ("RegionSize", ctypes.c_uint64), ("State", wt.DWORD),
                ("Protect", wt.DWORD), ("Type", wt.DWORD), ("_p2", wt.DWORD)]

def read_mem(h, addr, sz):
    buf = ctypes.create_string_buffer(sz); n = ctypes.c_size_t(0)
    if kernel32.ReadProcessMemory(h, ctypes.c_uint64(addr), buf, sz, ctypes.byref(n)):
        return buf.raw[:n.value]
    return None

def enum_regions(h):
    regs = []; addr = 0; mbi = MBI()
    while addr < MAXADDR:
        if kernel32.VirtualQueryEx(h, ctypes.c_uint64(addr), ctypes.byref(mbi), ctypes.sizeof(mbi)) == 0:
            break
        if mbi.State == 0x1000 and mbi.Protect in READABLE and 0 < mbi.RegionSize < 500 * 1024 * 1024:
            regs.append((mbi.BaseAddress, mbi.RegionSize))
        nxt = mbi.BaseAddress + mbi.RegionSize
        if nxt <= addr: break
        addr = nxt
    return regs

def iter_chunks(h, regs, overlap=0):
    for base, size in regs:
        off = 0; tail = b""; tail_base = base
        while off < size:
            cur = min(CHUNK, size - off)
            chunk = read_mem(h, base + off, cur) or b""
            dbase = tail_base if tail else base + off
            data = tail + chunk
            if data:
                yield dbase, data
                if overlap:
                    tail = data[-overlap:]; tail_base = dbase + len(data) - len(tail)
                else:
                    tail = b""; tail_base = base + off + cur
            else:
                tail = b""; tail_base = base + off + cur
            off += cur

def u64(d, o):
    return struct.unpack_from("<Q", d, o)[0] if o >= 0 and o + 8 <= len(d) else 0

def collect_dbs():
    dbs = {}
    for root, _d, files in os.walk(BASE):
        for fn in files:
            if not fn.endswith(".db") or fn.endswith(("-wal", "-shm")): continue
            p = os.path.join(root, fn)
            try:
                if os.path.getsize(p) < PAGE: continue
                with open(p, "rb") as f: pg = f.read(PAGE)
            except OSError: continue
            if pg[:15] == b"SQLite format 3": continue
            salt_hex = pg[:SALT].hex()
            if salt_hex not in dbs:
                dbs[salt_hex] = (os.path.relpath(p, BASE), pg)
    return dbs

def gather_blobs():
    """Re-walk structure, return list of 99B blobs."""
    r = subprocess.run(["tasklist", "/FI", "IMAGENAME eq Weixin.exe", "/FO", "CSV", "/NH"],
                       capture_output=True, text=True, creationflags=0x08000000)
    pids = []
    for line in r.stdout.strip().split("\n"):
        if not line.strip(): continue
        p = line.strip('"').split('","')
        if len(p) >= 5: pids.append((int(p[4].replace(",", "").replace(" K", "").strip() or 0), int(p[1])))
    pids.sort(reverse=True)
    blobs = []
    for mem, pid in pids:
        h = kernel32.OpenProcess(0x0410, False, pid)
        if not h: continue
        try:
            regs = enum_regions(h)
            naddr = set()
            for b, data in iter_chunks(h, regs, overlap=64):
                pos = data.find(NEEDLE)
                while pos >= 0:
                    naddr.add(b + pos); pos = data.find(NEEDLE, pos + 1)
            if not naddr: continue
            print(f"pid={pid} needles={len(naddr)}", flush=True)
            pats = [struct.pack("<Q", a) + struct.pack("<Q", len(NEEDLE)) for a in naddr]
            seen = set()
            for b, data in iter_chunks(h, regs, overlap=0x80):
                for pat in pats:
                    pos = data.find(pat)
                    while pos >= 0:
                        node = read_mem(h, b + pos - 0x10, 0x50)
                        if node and len(node) >= 0x40 and u64(node, 0x10) in naddr and u64(node, 0x18) == len(NEEDLE):
                            cfg = u64(node, 0x28)
                            if 0x10000 <= cfg < MAXADDR:
                                win = read_mem(h, cfg, 0x100)
                                if win:
                                    for o in range(0, 0xF8, 8):
                                        dp, dl = u64(win, o), u64(win, o + 8)
                                        if 0x10000 <= dp < MAXADDR and 80 <= dl <= 512 and (dp, dl) not in seen:
                                            blob = read_mem(h, dp, int(dl))
                                            if blob and len(blob) == dl:
                                                seen.add((dp, dl))
                                                if dl == 99: blobs.append(blob)
                        pos = data.find(pat, pos + 1)
            if blobs:
                print(f"pid={pid} blobs99={len(blobs)}", flush=True)
                return blobs  # main process has them; stop after first pid with hits
        finally:
            kernel32.CloseHandle(h)
    return blobs

def solve_mask(blobs):
    """Per-position charset constraint. Returns candidate masks per position."""
    n = min(len(b) for b in blobs)
    per_pos = []
    for i in range(n):
        col = [b[i] for b in blobs]
        cands = [c for c in range(256) if all(v ^ c in ALLOWED for v in col)]
        per_pos.append(cands)
    return per_pos

def _verify(args):
    keyhex, salt_hex, pg = args
    try: k = bytes.fromhex(keyhex)
    except Exception: return None
    enc = hashlib.pbkdf2_hmac("sha512", k, pg[:SALT], 256000, 32)
    mk = hashlib.pbkdf2_hmac("sha512", enc, bytes(b ^ 0x3A for b in pg[:SALT]), 2, 32)
    calc = hmac.new(mk, pg[SALT:DATA_END] + struct.pack("<I", 1), hashlib.sha512).digest()
    return (salt_hex, keyhex) if hmac.compare_digest(calc, pg[DATA_END:DATA_END + HSZ]) else None

def main():
    t0 = time.time()
    dbs = collect_dbs()
    salt_hexes = set(dbs)
    print(f"dbs={len(dbs)}", flush=True)
    blobs = gather_blobs()
    print(f"blobs99={len(blobs)} ({time.time()-t0:.0f}s)", flush=True)
    if not blobs:
        print("no blobs — structure changed since v6 run", flush=True); return
    uniq = list(dict.fromkeys(blobs))
    print(f"unique blobs={len(uniq)}", flush=True)

    per_pos = solve_mask(uniq)
    widths = [len(c) for c in per_pos]
    print(f"mask candidate widths per position: min={min(widths)} max={max(widths)} "
          f"multi={[(i, w) for i, w in enumerate(widths) if w != 1][:10]}", flush=True)
    if 0 in widths:
        # charset assumption broken for some position — report where
        bad = [i for i, w in enumerate(widths) if w == 0]
        print(f"INCONSISTENT positions (no mask value fits charset): {bad}", flush=True)
        print("=> not bytewise-position XOR with this charset; dump samples:", flush=True)
        for b in uniq[:3]: print("  " + b.hex(), flush=True)
        return
    masks = [bytes(c[0] for c in per_pos)]
    print(f"mask recovered len={len(masks[0])}: {masks[0].hex()}", flush=True)

    # decode all blobs with recovered mask; parse x'<96hex>'
    cands = {}
    for b in uniq:
        dec = bytes(v ^ m for v, m in zip(b, masks[0]))
        if not (dec[0:1] in b"xX" and dec[1:2] == b"'" and dec[98:99] == b"'"):
            # try without strict delimiters: find hex run
            m = re.search(rb"[0-9a-fA-F]{96}", dec)
            if not m: continue
            run = m.group().decode().lower()
        else:
            run = dec[2:98].decode().lower()
        kh, es = run[:64], run[64:96]
        if len(set(bytes.fromhex(kh))) >= 15:
            cands.setdefault(kh, es if es in salt_hexes else None)
    print(f"literal candidates={len(cands)} ({time.time()-t0:.0f}s)", flush=True)

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
        s = os.path.join(BASE, rel)
        d = os.path.join(DEC_OUT, rel.replace("\\", "__").replace("/", "__"))
        try:
            if P.decrypt_db(s, d, bytes.fromhex(kh), log):
                import sqlite3
                con = sqlite3.connect(d)
                n = con.execute("SELECT count(*) FROM sqlite_master WHERE type='table'").fetchone()[0]
                log(f"  VERIFY {os.path.basename(d)}: {n} tables OK"); con.close()
        except Exception as e:
            log(f"  ERROR {rel}: {e!r}")
    with open(os.path.join(DEC_OUT, "_v7.log"), "w", encoding="utf-8") as f:
        f.write("\n".join(LOG))
    print(f"DEC done -> {DEC_OUT}", flush=True)

if __name__ == "__main__":
    mp.freeze_support()
    main()
