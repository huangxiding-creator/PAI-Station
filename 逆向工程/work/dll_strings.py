# -*- coding: utf-8 -*-
"""wyhkm.dll 二进制分析：设备路径/IOCTL/注册表/GUID。"""
import io, re, struct, sys

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
data = open(r"e:\AI-Station\逆向工程\extracted\app64\resources\app.asar.unpacked\node_modules\@thiflow\robot\标准版\64位模块\wyhkm.dll", "rb").read()

# 1) Unicode 字符串
print("=== Unicode 字符串（含设备/注册表路径） ===")
for m in re.finditer(rb'(?:[\x20-\x7e]\x00){6,}', data):
    s = m.group().decode("utf-16-le", errors="replace")
    if any(k in s for k in ("\\", "Software", "System", "HARDWARE", "CurrentControl",
                            "Device", "HID", "USB", "driver", "service", "GUID",
                            "{", "interface")):
        print(f"  @{m.start():#x}: {s[:150]}")

# 2) ASCII 字符串（设备相关）
print("\n=== ASCII 字符串（设备/驱动相关） ===")
for m in re.finditer(rb'[\x20-\x7e]{8,}', data):
    s = m.group().decode()
    if any(k in s.lower() for k in ("device", "hid", "usb", "driver", "ioctl",
                                     "sendinput", "keybd_event", "mouse_event",
                                     "createfile", "handle", "\\\\")):
        print(f"  @{m.start():#x}: {s[:120]}")

# 3) IOCTL 候选值
print("\n=== IOCTL 候选（.rdata 区域 DWORD 扫描） ===")
ioctl_set = set()
for i in range(0x31000, min(len(data) - 4, 0x42000), 4):
    val = struct.unpack_from("<I", data, i)[0]
    if val == 0:
        continue
    dev_type = (val >> 16) & 0xFFFF
    func = (val >> 2) & 0xFFF
    method = val & 0x3
    access = (val >> 14) & 0x3
    if dev_type in (0x22, 0x8000, 0x8001, 0x8002, 0x8003, 0x8004, 0x8005) and \
       0 < func < 0x100 and method in (0, 1, 2, 3):
        ioctl_set.add((val, dev_type, func, method, i))

for val, dev, func, method, off in sorted(ioctl_set, key=lambda x: x[0])[:40]:
    print(f"  IOCTL={val:#010x} dev={dev:#06x} func={func:03d} method={method} @{off:#x}")
