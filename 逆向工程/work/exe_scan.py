# -*- coding: utf-8 -*-
"""Static PE structure scan of the 210MB main executable."""
import io, sys, struct

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
PATH = r"e:\AI-Station\逆向工程\extracted\app64\识流AI助手.exe"
data = open(PATH, "rb").read()
print("size:", len(data))

e_lfanew = struct.unpack_from("<I", data, 0x3C)[0]
assert data[e_lfanew:e_lfanew+4] == b"PE\x00\x00"
machine = struct.unpack_from("<H", data, e_lfanew + 4)[0]
num_sections = struct.unpack_from("<H", data, e_lfanew + 6)[0]
opt_size = struct.unpack_from("<H", data, e_lfanew + 20)[0]
print("machine: 0x%x (8664=x64, 14c=x86)" % machine)
print("sections:", num_sections)

sec_off = e_lfanew + 24 + opt_size
max_raw_end = 0
for i in range(num_sections):
    off = sec_off + i * 40
    name = data[off:off+8].rstrip(b"\x00").decode("ascii", "replace")
    vsize, vaddr, rsize, raddr = struct.unpack_from("<IIII", data, off + 8)
    print(f"  {name:10s} vsize={vsize/1e6:8.2f}MB rawsize={rsize/1e6:8.2f}MB rawptr=0x{raddr:x}")
    max_raw_end = max(max_raw_end, raddr + rsize)

overlay = len(data) - max_raw_end
print("overlay bytes after last section: %.2f MB" % (overlay / 1e6))

# scan overlay-ish region for signatures
import re
sigs = {
    "7z": bytes.fromhex("377abcaf271c"),
    "zip": b"PK\x03\x04",
    "asar-hdr?": b'"files"',
}
tail_start = max(0, max_raw_end - 1024*1024)
region = data[tail_start:]
for name, sig in sigs.items():
    idxs = [m.start() + tail_start for m in re.finditer(re.escape(sig), region)][:5]
    print(name, "sig hits:", idxs)
