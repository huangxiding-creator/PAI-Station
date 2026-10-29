# -*- coding: utf-8 -*-
# v5: multi-target validation (per-db key hypothesis) over deref-priority candidates
import ctypes, ctypes.wintypes as wt, hashlib, hmac, struct, sys, subprocess, time, os, re
import multiprocessing as mp

PAGE_SIZE = 4096; SALT = 16; HMAC_SZ = 64; RESERVE = 80
DATA_END = PAGE_SIZE - RESERVE + 16
PATTERN = b'\x00'*8 + (0x20).to_bytes(8,'little') + (0x2F).to_bytes(8,'little')
MAXA = 0x7FFFFFFFFFFF
BASE = r'C:/Users/91216/xwechat_files/wxid_ui29wkg2ug6922_66f7/db_storage'
TARGETS = {}
for sub, name in [('message','message_0.db'),('message','message_1.db'),('message','message_2.db'),
                  ('message','biz_message_0.db'),('contact','contact.db'),('session','session.db')]:
    p = os.path.join(BASE, sub, name)
    if os.path.exists(p):
        b = open(p,'rb').read(PAGE_SIZE)
        if b[:15] != b'SQLite format 3': TARGETS[name] = b
HEX64 = re.compile(rb'(?<![0-9a-fA-F])[0-9a-fA-F]{64}(?![0-9a-fA-F])')
TPAGES = None

def read_mem(h, addr, size):
    buf = ctypes.create_string_buffer(size); got = ctypes.c_size_t(0)
    if ctypes.windll.kernel32.ReadProcessMemory(h, ctypes.c_void_p(addr), buf, size, ctypes.byref(got)):
        return buf.raw[:got.value]
    return None

def _validate(keyhex):
    import hashlib, hmac, struct
    try: key32 = bytes.fromhex(keyhex)
    except Exception: return None
    if len(key32) != 32: return None
    out = []
    for tn, pg in TPAGES.items():
        salt = pg[:SALT]
        enc = hashlib.pbkdf2_hmac('sha512', key32, salt, 256000, 32)
        mk = hashlib.pbkdf2_hmac('sha512', enc, bytes(b ^ 0x3a for b in salt), 2, 32)
        calc = hmac.new(mk, pg[SALT:DATA_END] + struct.pack('<I', 1), hashlib.sha512).digest()
        if hmac.compare_digest(calc, pg[DATA_END:DATA_END+HMAC_SZ]):
            out.append(tn)
    return (keyhex, out) if out else None

def init_worker(tp):
    global TPAGES; TPAGES = tp

if __name__ == '__main__':
    mp.freeze_support()
    print('targets:', list(TARGETS), flush=True)
    out = subprocess.run(['powershell','-NoProfile','-Command',
        "Get-Process Weixin -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Id"],
        capture_output=True, text=True).stdout.split()
    pids = [int(p) for p in out if p.strip().isdigit()]
    print('Weixin PIDs:', pids, flush=True)
    class MBI(ctypes.Structure):
        _fields_=[("BaseAddress",ctypes.c_void_p),("AllocationBase",ctypes.c_void_p),
                  ("AllocationProtect",wt.DWORD),("p1",wt.DWORD),("RegionSize",ctypes.c_size_t),
                  ("State",wt.DWORD),("Protect",wt.DWORD),("Type",wt.DWORD),("p2",wt.DWORD)]
    deref = set(); other = set(); t0 = time.time()
    for pid in pids:
        h = ctypes.windll.kernel32.OpenProcess(0x410, False, pid)
        if not h: continue
        addr = 0x10000; mbi = MBI()
        while addr < MAXA:
            if not ctypes.windll.kernel32.VirtualQueryEx(h, ctypes.c_void_p(addr), ctypes.byref(mbi), ctypes.sizeof(mbi)):
                break
            base = mbi.BaseAddress if mbi.BaseAddress else addr
            rs = mbi.RegionSize if mbi.RegionSize else 0x1000
            if mbi.State == 0x1000 and (mbi.Protect & (0x02|0x04|0x20|0x40)) and not (mbi.Protect & 0x100):
                data = read_mem(h, base, rs)
                if data:
                    idx = 0
                    while True:
                        idx = data.find(PATTERN, idx)
                        if idx == -1: break
                        if idx >= 8:
                            ptr = struct.unpack('<Q', data[idx-8:idx])[0]
                            if 0x10000 < ptr < MAXA:
                                kb = read_mem(h, ptr, 64)
                                if kb and len(kb) == 64:
                                    deref.add(kb[:32].hex())
                                    if re.fullmatch(rb'[0-9a-fA-F]{64}', kb):
                                        deref.add(bytes.fromhex(kb.decode()).hex())
                        if idx >= 40: other.add(data[idx-40:idx-8].hex())
                        other.add(data[idx+24:idx+56].hex())
                        idx += 1
                    for m in HEX64.finditer(data):
                        other.add(m.group().decode())
            addr = base + rs
        ctypes.windll.kernel32.CloseHandle(h)
    deref.discard('00'*32); other.discard('00'*32); other -= deref
    print(f'GATHER done: deref={len(deref)} other={len(other)} elapsed={time.time()-t0:.0f}s', flush=True)
    all_c = sorted(deref) + sorted(other)
    workers = min(os.cpu_count() or 4, 12)
    t1 = time.time(); done = 0; hits = []
    with mp.Pool(workers, initializer=init_worker, initargs=(TARGETS,)) as pool:
        for res in pool.imap_unordered(_validate, all_c, chunksize=8):
            done += 1
            if done % 1000 == 0:
                print(f'  {done}/{len(all_c)} hits={len(hits)} elapsed={time.time()-t1:.0f}s', flush=True)
            if res:
                hits.append(res)
                print(f'HIT key={res[0]} targets={res[1]}', flush=True)
                covered = set()
                for _, ts in hits: covered |= set(ts)
                if set(TARGETS) <= covered:
                    pool.terminate(); break
    print('RESULT ' + ('; '.join(f'{h[0]}:{",".join(h[1])}' for h in hits) if hits else 'none'), flush=True)
