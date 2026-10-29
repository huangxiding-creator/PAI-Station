# -*- coding: utf-8 -*-
# v6: Config.Cipher runtime scan — Windows WeChat 4.1+ key extraction
# Recipe cross-validated from two 2026-10 upstreams (TANGandXUE/wcdb-key-tool Windows port
# in Z-V-I/wechat4-db-export + Circumsized/Wechat-Emoticon-Export):
#   needle "com.Tencent.WCDB.Config.Cipher" -> (addr,len30) pair refs -> node@qaddr-0x10
#   -> cfg ptr@node+0x28 -> obj window cfg+0x88 -> data_ptr@+0x8 len@+0x10 -> blob
#   -> XOR mask (31B) -> x'<hex64 key+hex32 salt>' -> PBKDF2-HMAC-SHA512 verify vs db page1
# Layers: A exact recipe | B offset fuzz in cfg window | C all-31-phase masked literal scan
#         D raw literal scan (mask-free) | E verification pool (12w)
# Keys NEVER hit disk: verified keys stay in RAM, decrypt runs in-process via wx4_pipeline.
import ctypes, hashlib, hmac, json, os, re, struct, subprocess, sys, time
import ctypes.wintypes as wt
import multiprocessing as mp

PAGE = 4096; SALT = 16; HSZ = 64; RESERVE = 80; DATA_END = PAGE - RESERVE + 16
NEEDLE = b"com.Tencent.WCDB.Config.Cipher"
MASK = bytes.fromhex("d2c7442458020000004889442450488b450048844c2448488944254048584c24")
LIT = re.compile(rb"[xX]'([0-9a-fA-F]{64,192})'")
PLAIN_HEX64 = re.compile(rb"(?<![0-9a-fA-FxX])[0-9a-fA-F]{96}(?![0-9a-fA-F])")
MAXADDR = 0x7FFFFFFFFFFF
READABLE = {2, 4, 8, 16, 32, 64, 128}
CHUNK = 32 * 1024 * 1024
BASE = r"C:/Users/91216/xwechat_files/wxid_ui29wkg2ug6922_66f7/db_storage"
DEC_OUT = r"C:/Users/91216/AppData/Local/Temp/wx4_dec"
DEC_ONLY = "--decrypt-only" in sys.argv  # stdin: key lines "salt_hex key_hex"
NO_DECRYPT = "--no-decrypt" in sys.argv

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

def xor_rep(d, mask, phase=0):
    ml = len(mask)
    return bytes(v ^ mask[(i + phase) % ml] for i, v in enumerate(d))

def probable(k32):
    return len(k32) == 32 and len(set(k32)) >= 15 and k32 != b"\x00" * 32 and k32 != b"\xff" * 32

# ---------- db collection ----------
def collect_dbs():
    dbs = {}; salt2rel = {}
    for root, _d, files in os.walk(BASE):
        for fn in files:
            if not fn.endswith(".db") or fn.endswith(("-wal", "-shm")):
                continue
            p = os.path.join(root, fn)
            try:
                if os.path.getsize(p) < PAGE: continue
                with open(p, "rb") as f: pg = f.read(PAGE)
            except OSError: continue
            if pg[:15] == b"SQLite format 3": continue
            salt_hex = pg[:SALT].hex()
            rel = os.path.relpath(p, BASE)
            if salt_hex not in dbs:
                dbs[salt_hex] = (rel, pg); salt2rel.setdefault(salt_hex, rel)
    return dbs

# ---------- verification ----------
TPAGES = None
def _winit(tp): global TPAGES; TPAGES = tp

def _vsalt(args):
    keyhex, salt_hex, rel, pg = args
    try:
        k = bytes.fromhex(keyhex)
    except Exception:
        return None
    if not probable(k): return None
    enc = hashlib.pbkdf2_hmac("sha512", k, pg[:SALT], 256000, 32)
    mk = hashlib.pbkdf2_hmac("sha512", enc, bytes(b ^ 0x3A for b in pg[:SALT]), 2, 32)
    calc = hmac.new(mk, pg[SALT:DATA_END] + struct.pack("<I", 1), hashlib.sha512).digest()
    if hmac.compare_digest(calc, pg[DATA_END:DATA_END + HSZ]):
        return (salt_hex, keyhex, rel)
    return None

def verify_pool(cands, dbs, pool):
    # cands: dict keyhex -> embedded_salt_hex|None ; returns [(salt,keyhex,rel)]
    tasks = []
    for kh, esalt in cands.items():
        if esalt and esalt in dbs:
            rel, pg = dbs[esalt]
            tasks.append((kh, esalt, rel, pg))
        else:
            for sh, (rel, pg) in dbs.items():
                tasks.append((kh, sh, rel, pg))
    hits = []
    for r in pool.imap_unordered(_vsalt, tasks, chunksize=1):
        if r:
            hits.append(r); print(f"HIT salt={r[0][:8]}.. rel={r[2]} key={r[1][:6]}..***", flush=True)
    return hits

# ---------- blob decoding ----------
def blob_key_candidates(blob, salts):
    """Return {keyhex: embedded_salt|None} from a raw blob, trying multiple decodings."""
    out = {}
    def harvest(dec):
        for m in LIT.finditer(dec):
            run = m.group(1).decode("ascii", "replace").lower()
            starts = [0]
            if len(run) > 96:
                starts.extend(range(0, len(run) - 63, 32)); starts.append(len(run) - 64)
            for st in dict.fromkeys(starts):
                if st < 0 or st + 64 > len(run): continue
                kh = run[st:st + 64]
                es = run[st + 64:st + 96] if st + 96 <= len(run) else None
                if es and es not in salts: es = None
                try:
                    if probable(bytes.fromhex(kh)): out.setdefault(kh, es)
                except ValueError: pass
        for m in PLAIN_HEX64.finditer(dec):
            run = m.group().decode("ascii", "replace").lower()
            kh, es = run[:64], run[64:96]
            if es not in salts: es = None
            try:
                if probable(bytes.fromhex(kh)): out.setdefault(kh, es)
            except ValueError: pass
    harvest(blob)                       # D: mask-free
    harvest(xor_rep(blob, MASK))        # A: mask phase 0
    for ph in range(1, len(MASK)):      # C: all phases
        harvest(xor_rep(blob, MASK, ph))
    return out

# ---------- main scan ----------
def scan():
    t0 = time.time()
    dbs = collect_dbs()
    print(f"dbs: {len(dbs)} distinct salts under {BASE} ({time.time()-t0:.0f}s)", flush=True)
    r = subprocess.run(["tasklist", "/FI", "IMAGENAME eq Weixin.exe", "/FO", "CSV", "/NH"],
                       capture_output=True, text=True, creationflags=0x08000000)
    pids = []
    for line in r.stdout.strip().split("\n"):
        if not line.strip(): continue
        p = line.strip('"').split('","')
        if len(p) >= 5: pids.append((int(p[4].replace(",", "").replace(" K", "").strip() or 0), int(p[1])))
    pids.sort(reverse=True)
    print("Weixin pids (mem desc):", [(pid, mb // 1024) for mb, pid in pids], flush=True)

    cands = {}      # keyhex -> embedded salt hex|None
    stats = {"needle": 0, "pairrefs": 0, "node_ok": 0, "cfg": 0, "blobs": 0,
             "blob_lens": {}, "lit_raw": 0, "lit_masked": 0}
    salt_hexes = set(dbs)

    for mem, pid in pids:
        h = kernel32.OpenProcess(0x0410, False, pid)
        if not h:
            print(f"open fail pid={pid}", flush=True); continue
        try:
            regs = enum_regions(h)
            print(f"pid={pid} regions={len(regs)} total={sum(s for _, s in regs)//1024//1024}MB", flush=True)
            # pass 1: needle addresses
            naddr = set()
            for b, data in iter_chunks(h, regs, overlap=64):
                pos = data.find(NEEDLE)
                while pos >= 0:
                    naddr.add(b + pos); pos = data.find(NEEDLE, pos + 1)
            stats["needle"] += len(naddr)
            print(f"pid={pid} needle_addrs={len(naddr)} ({time.time()-t0:.0f}s)", flush=True)
            if not naddr: continue
            pats = [struct.pack("<Q", a) + struct.pack("<Q", len(NEEDLE)) for a in naddr]
            seen_blob = set()
            # pass 2: pair refs + structure walk (+offset fuzz) ; also raw literal scan
            for b, data in iter_chunks(h, regs, overlap=0x80):
                for m in LIT.finditer(data):
                    run = m.group(1).decode("ascii", "replace").lower()
                    kh = run[:64]; es = run[64:96] if len(run) >= 96 else None
                    if es not in salt_hexes: es = None
                    try:
                        if probable(bytes.fromhex(kh)):
                            cands.setdefault(kh, es); stats["lit_raw"] += 1
                    except ValueError: pass
                for pat in pats:
                    pos = data.find(pat)
                    while pos >= 0:
                        stats["pairrefs"] += 1
                        q = b + pos
                        node = read_mem(h, q - 0x10, 0x50)
                        if node and len(node) >= 0x40:
                            if u64(node, 0x10) in naddr and u64(node, 0x18) == len(NEEDLE):
                                stats["node_ok"] += 1
                                cfg = u64(node, 0x28)
                            else:
                                cfg = 0
                            if not (0x10000 <= cfg < MAXADDR):
                                for off in (0x20, 0x30):
                                    cfg2 = u64(node, off)
                                    if 0x10000 <= cfg2 < MAXADDR and cfg2 & 0xF == 0:
                                        cfg = cfg2; break
                            if 0x10000 <= cfg < MAXADDR:
                                stats["cfg"] += 1
                                win = read_mem(h, cfg, 0x100)   # B: fuzz whole window
                                if win:
                                    for o in range(0, 0xF8, 8):
                                        dp, dl = u64(win, o), u64(win, o + 8)
                                        if 0x10000 <= dp < MAXADDR and 80 <= dl <= 512:
                                            key = (dp, dl)
                                            if key in seen_blob: continue
                                            blob = read_mem(h, dp, int(dl))
                                            if blob and len(blob) == dl:
                                                seen_blob.add(key)
                                                stats["blobs"] += 1
                                                stats["blob_lens"][dl] = stats["blob_lens"].get(dl, 0) + 1
                                                for kh, es in blob_key_candidates(blob, salt_hexes).items():
                                                    cands.setdefault(kh, es)
                        pos = data.find(pat, pos + 1)
            print(f"pid={pid} done cands={len(cands)} stats={stats} ({time.time()-t0:.0f}s)", flush=True)
            if any(es in dbs for es in cands.values()) and len(cands) >= len(dbs) * 0.5:
                break  # likely have full coverage
        finally:
            kernel32.CloseHandle(h)

    print(f"GATHER done cands={len(cands)} stats={stats} ({time.time()-t0:.0f}s)", flush=True)
    workers = min(os.cpu_count() or 4, 12)
    with mp.Pool(workers, initializer=_winit, initargs=(dbs,)) as pool:
        hits = verify_pool(cands, dbs, pool)
    print(f"VERIFY done hits={len(hits)}/{len(dbs)} salts ({time.time()-t0:.0f}s)", flush=True)
    if not hits:
        print("RESULT none", flush=True); return
    print("RESULT " + "; ".join(f"{rel}:{kh[:6]}..***" for sh, kh, rel in hits), flush=True)
    if NO_DECRYPT: return
    import wx4_pipeline as P
    os.makedirs(DEC_OUT, exist_ok=True)
    LOG = []
    log = lambda m: (LOG.append(m), print(m, flush=True))
    for sh, kh, rel in hits:
        s = os.path.join(BASE, rel); d = os.path.join(DEC_OUT, rel.replace("\\", "__").replace("/", "__"))
        try:
            ok = P.decrypt_db(s, d, bytes.fromhex(kh), log)
            if ok:
                import sqlite3
                con = sqlite3.connect(d)
                n = con.execute("SELECT count(*) FROM sqlite_master WHERE type='table'").fetchone()[0]
                log(f"  VERIFY {os.path.basename(d)}: {n} tables OK"); con.close()
        except Exception as e:
            log(f"  ERROR {rel}: {e!r}")
    with open(os.path.join(DEC_OUT, "_v6.log"), "w", encoding="utf-8") as f:
        f.write("\n".join(LOG))
    print(f"DEC done -> {DEC_OUT}", flush=True)

if __name__ == "__main__":
    mp.freeze_support()
    if DEC_ONLY:
        dbs = collect_dbs()
        for line in sys.stdin.read().split():
            sh, kh = line.split(":")
            rel, pg = dbs[sh]
            import wx4_pipeline as P
            os.makedirs(DEC_OUT, exist_ok=True)
            d = os.path.join(DEC_OUT, rel.replace("\\", "__").replace("/", "__"))
            try:
                P.decrypt_db(os.path.join(BASE, rel), d, bytes.fromhex(kh),
                             lambda m: print(m, flush=True))
            except Exception as e:
                print(f"ERROR {rel}: {e!r}", flush=True)
    else:
        scan()
