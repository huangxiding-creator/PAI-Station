# -*- coding: utf-8 -*-
# WeChat 4.x key finder v2 (chatlog algo port; chunked reads, progress, per-account result)
import ctypes, ctypes.wintypes as wt, hashlib, hmac, struct, sys, subprocess, time

PAGE_SIZE = 4096; SALT = 16; IV = 16; HMAC_SZ = 64; RESERVE = 80
DATA_END = PAGE_SIZE - RESERVE + IV
PATTERN = b'\x00'*8 + (0x20).to_bytes(8,'little') + (0x2F).to_bytes(8,'little')
k32 = ctypes.windll.kernel32
PROCESS_VM_READ = 0x10; PROCESS_QUERY_INFORMATION = 0x400
MEM_COMMIT = 0x1000; PAGE_READWRITE = 0x04; MEM_PRIVATE = 0x20000

class MBI(ctypes.Structure):
    _fields_ = [("BaseAddress", ctypes.c_void_p), ("AllocationBase", ctypes.c_void_p),
                ("AllocationProtect", wt.DWORD), ("__pad1", wt.DWORD),
                ("RegionSize", ctypes.c_size_t), ("State", wt.DWORD),
                ("Protect", wt.DWORD), ("Type", wt.DWORD), ("__pad2", wt.DWORD)]

def read_mem(h, addr, size):
    buf = ctypes.create_string_buffer(size)
    got = ctypes.c_size_t(0)
    if k32.ReadProcessMemory(h, ctypes.c_void_p(addr), buf, size, ctypes.byref(got)):
        return buf.raw[:got.value]
    return None

def load_page1(path):
    with open(path, 'rb') as f: return f.read(PAGE_SIZE)

def validate_key(page1, key32):
    salt = page1[:SALT]
    enc = hashlib.pbkdf2_hmac('sha512', key32, salt, 256000, 32)
    mac_key = hashlib.pbkdf2_hmac('sha512', enc, bytes(b ^ 0x3a for b in salt), 2, 32)
    calc = hmac.new(mac_key, page1[SALT:DATA_END] + struct.pack('<I', 1), hashlib.sha512).digest()
    return hmac.compare_digest(calc, page1[DATA_END:DATA_END+HMAC_SZ])

targets = {
    'ui29_66f7': r'C:/Users/91216/xwechat_files/wxid_ui29wkg2ug6922_66f7/db_storage/message/message_0.db',
    'hcar_0625': r'C:/Users/91216/xwechat_files/wxid_hcar08a4jtoh22_0625/db_storage/message/message_0.db',
}
pages = {k: load_page1(v) for k, v in targets.items()}
out = subprocess.run(['powershell','-NoProfile','-Command',
    "Get-Process Weixin -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Id"],
    capture_output=True, text=True).stdout.split()
pids = [int(p) for p in out if p.strip().isdigit()]
print('Weixin PIDs:', pids, flush=True)

found = {}; cands = 0; t0 = time.time()
CHUNK = 64 * 1024 * 1024
for pid in pids:
    h = k32.OpenProcess(PROCESS_VM_READ | PROCESS_QUERY_INFORMATION, False, pid)
    if not h:
        print(f'pid {pid}: OpenProcess failed err={ctypes.GetLastError()}', flush=True); continue
    print(f'pid {pid}: scanning', flush=True)
    addr = 0x10000; MAXA = 0x7FFFFFFFFFFF; mbi = MBI(); nbytes = 0
    while addr < MAXA:
        if not k32.VirtualQueryEx(h, ctypes.c_void_p(addr), ctypes.byref(mbi), ctypes.sizeof(mbi)):
            break
        base = mbi.BaseAddress if mbi.BaseAddress else addr
        rsize = mbi.RegionSize if mbi.RegionSize else 0x1000
        if mbi.State == MEM_COMMIT and (mbi.Protect & PAGE_READWRITE) and mbi.Type == MEM_PRIVATE and rsize >= 0x100000:
            off = 0
            while off < rsize:
                n = min(CHUNK, rsize - off)
                data = read_mem(h, base + off, n)
                if data:
                    nbytes += len(data)
                    idx = len(data)
                    while True:
                        idx = data.rfind(PATTERN, 0, idx)
                        if idx == -1 or idx < 8: break
                        ptr = struct.unpack('<Q', data[idx-8:idx])[0]
                        if 0x10000 < ptr < MAXA:
                            key32 = read_mem(h, ptr, 32)
                            if key32 and len(key32) == 32:
                                cands += 1
                                for acc, pg in pages.items():
                                    if acc not in found and validate_key(pg, key32):
                                        found[acc] = key32.hex()
                                        print(f'KEY FOUND account={acc} pid={pid} key={key32.hex()}', flush=True)
                        idx -= 1
                off += n
            if len(found) == len(pages): break
        addr = base + rsize
    k32.CloseHandle(h)
    print(f'pid {pid}: read {nbytes/1e6:.0f}MB cands={cands} elapsed={time.time()-t0:.0f}s found={list(found)}', flush=True)
    if len(found) == len(pages): break
for acc, kh in found.items(): print(f'RESULT {acc} {kh}', flush=True)
if not found:
    print('RESULT none', flush=True); sys.exit(2)
