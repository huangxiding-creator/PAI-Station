# -*- coding: utf-8 -*-
# v4b: widen regions (all committed readable) + hex-string candidates + deref/inline
import ctypes, ctypes.wintypes as wt, hashlib, hmac, struct, sys, subprocess, time, os, re
import multiprocessing as mp

PAGE_SIZE = 4096; SALT = 16; HMAC_SZ = 64; RESERVE = 80
DATA_END = PAGE_SIZE - RESERVE + 16
PATTERN = b'\x00'*8 + (0x20).to_bytes(8,'little') + (0x2F).to_bytes(8,'little')
MAXA = 0x7FFFFFFFFFFF
UI29_DB = r'C:/Users/91216/xwechat_files/wxid_ui29wkg2ug6922_66f7/db_storage/message/message_0.db'
PAGE1 = None
READABLE = 0x02|0x04|0x20|0x40  # R|RW|RX|RWX (masks subset)
HEX64 = re.compile(rb'(?<![0-9a-fA-F])[0-9a-fA-F]{64}(?![0-9a-fA-F])')

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
    salt = PAGE1[:SALT]
    enc = hashlib.pbkdf2_hmac('sha512', key32, salt, 256000, 32)
    mk = hashlib.pbkdf2_hmac('sha512', enc, bytes(b ^ 0x3a for b in salt), 2, 32)
    calc = hmac.new(mk, PAGE1[SALT:DATA_END] + struct.pack('<I', 1), hashlib.sha512).digest()
    return keyhex if hmac.compare_digest(calc, PAGE1[DATA_END:DATA_END+HMAC_SZ]) else None

def init_worker(page1):
    global PAGE1; PAGE1 = page1

if __name__ == '__main__':
    mp.freeze_support()
    with open(UI29_DB, 'rb') as f: page1 = f.read(PAGE_SIZE)
    out = subprocess.run(['powershell','-NoProfile','-Command',
        "Get-Process Weixin -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Id"],
        capture_output=True, text=True).stdout.split()
    pids = [int(p) for p in out if p.strip().isdigit()]
    print('Weixin PIDs:', pids, flush=True)
    class MBI(ctypes.Structure):
        _fields_=[("BaseAddress",ctypes.c_void_p),("AllocationBase",ctypes.c_void_p),
                  ("AllocationProtect",wt.DWORD),("p1",wt.DWORD),("RegionSize",ctypes.c_size_t),
                  ("State",wt.DWORD),("Protect",wt.DWORD),("Type",wt.DWORD),("p2",wt.DWORD)]
    cands = set(); t0 = time.time(); total_mb = 0
    for pid in pids:
        h = ctypes.windll.kernel32.OpenProcess(0x410, False, pid)
        if not h: continue
        addr = 0x10000; mbi = MBI()
        while addr < MAXA:
            if not ctypes.windll.kernel32.VirtualQueryEx(h, ctypes.c_void_p(addr), ctypes.byref(mbi), ctypes.sizeof(mbi)):
                break
            base = mbi.BaseAddress if mbi.BaseAddress else addr
            rs = mbi.RegionSize if mbi.RegionSize else 0x1000
            if mbi.State == 0x1000 and (mbi.Protect & (0x02|0x04|0x20|0x40)) and not (mbi.Protect & 0x100):  # committed readable, not guard
                data = read_mem(h, base, rs)
                if data:
                    total_mb += len(data)/1e6
                    idx = 0
                    while True:
                        idx = data.find(PATTERN, idx)
                        if idx == -1: break
                        if idx >= 40: cands.add(data[idx-40:idx-8].hex())
                        cands.add(data[idx+24:idx+56].hex())
                        if idx >= 8:
                            ptr = struct.unpack('<Q', data[idx-8:idx])[0]
                            if 0x10000 < ptr < MAXA:
                                kb = read_mem(h, ptr, 32)
                                if kb and len(kb) == 32: cands.add(kb.hex())
                        idx += 1
                    for m in HEX64.finditer(data):
                        cands.add(m.group().decode())
            addr = base + rs
        ctypes.windll.kernel32.CloseHandle(h)
        print(f'pid {pid}: cum {total_mb:.0f}MB cands={len(cands)} elapsed={time.time()-t0:.0f}s', flush=True)
    cands.discard('00'*32)
    print(f'GATHER done: unique_cands={len(cands)}', flush=True)
    workers = min(os.cpu_count() or 4, 12)
    t1 = time.time(); done = 0; found = None
    with mp.Pool(workers, initializer=init_worker, initargs=(page1,)) as pool:
        for res in pool.imap_unordered(_validate, list(cands), chunksize=16):
            done += 1
            if done % 2000 == 0:
                print(f'  validated {done}/{len(cands)} elapsed={time.time()-t1:.0f}s', flush=True)
            if res:
                found = res; pool.terminate(); break
    print(f'RESULT {"ui29_66f7 " + found if found else "none"} after {done}', flush=True)
