# -*- coding: utf-8 -*-
r"""wenku-Setup-3.4.3.exe NSIS 静态解包（复用 xique-reverse/tools 已验证流水线逻辑）。
产物落 E:\AI-Station\kb_rev\nsis_out\（untrusted 纪律：只切不运行）。"""
import struct, sys, os, lzma, re

SRC = r"E:\AI-Station\逆向工程\逆向标的\wenku-Setup-3.4.3.exe"
OUT = r"E:\AI-Station\kb_rev\nsis_out"
os.makedirs(OUT, exist_ok=True)
d = open(SRC, "rb").read()
print(f"exe size={len(d)}")

# ── A. 定位 NSIS firstheader ──
i = d.find(b"\xEF\xBE\xAD\xDE")
while i >= 0:
    if d[i + 4 : i + 16] == b"NullsoftInst":
        break
    i = d.find(b"\xEF\xBE\xAD\xDE", i + 1)
if i < 0:
    print("NO firstheader"); sys.exit(1)
flags, = struct.unpack_from("<I", d, i + 16)
siginfo = d[i + 4 : i + 16]
hdr_len, = struct.unpack_from("<I", d, i + 16)
all_len, = struct.unpack_from("<I", d, i + 20)
print(f"firstheader @{hex(i)} siginfo={siginfo!r}")
print(f"hdr_len={hdr_len} all_following={all_len} ({all_len/1048576:.1f}MB) end={hex(i+24+all_len)} file={hex(len(d))}")

# ── B. 首块解压（NSIS3 solid LZMA：@+24 起 [props5][data]，无 size 字段——xique 实战配方） ──
props = d[i + 24 : i + 29]
body = d[i + 29 :]
print(f"LZMA props={props.hex()} (dict={struct.unpack('<I', props[1:5])[0]/1048576:.0f}MB) body={len(body)}")
stream = props + b"\xff" * 8 + body
dec = lzma.LZMADecompressor(format=lzma.FORMAT_ALONE)
solid = dec.decompress(stream)
print(f"solid stream: {len(solid)} bytes, unused_tail={len(dec.unused_data)}")
open(os.path.join(OUT, "solid_stream.bin"), "wb").write(solid)

# ── C. walk：[4B hlen][header][blocks...] ──
hlen, = struct.unpack_from("<I", solid, 0)
hdr = solid[4 : 4 + hlen]
open(os.path.join(OUT, "header.bin"), "wb").write(hdr)
print(f"header len={hlen} flags={struct.unpack_from('<I', hdr, 0)[0]:#x}")
off = 4 + hlen
blocks = []
while off < len(solid) - 4:
    ln, = struct.unpack_from("<I", solid, off)
    if ln == 0 or off + 4 + ln > len(solid):
        print(f"chain break @{hex(off)} len={ln}"); break
    blocks.append((off + 4, ln))
    off += 4 + ln
print(f"blocks={len(blocks)} last_end={hex(off)} total={hex(len(solid))}")

# ── D. cut + 签名识别 + 栈判定线索 ──
SIGS = [(b"MZ", "PE"), (b"PK\x03\x04", "ZIP"), (b"7z\xbc\xaf\x27\x1c", "7Z"), (b"Rar!", "RAR"),
        (b"{", "JSON?"), (b"<?xml", "XML"), (b"MSCF", "CAB"), (b"\x1f\x8b", "GZ"),
        (b"ID3", "MP3"), (b"\x89PNG", "PNG"), (b"\xff\xd8\xff", "JPG")]
kinds = {}
fobj = open(os.path.join(OUT, "blocks"), "wb")
fobj.close()
import io
manifest = []
for n, (o, ln) in enumerate(blocks):
    data = solid[o : o + ln]
    fn = os.path.join(OUT, f"blk{n:03d}_{ln}.bin")
    open(fn, "wb").write(data)
    kind = next((k for s, k in SIGS if data[: len(s)] == s), "?")
    kinds[kind] = kinds.get(kind, 0) + 1
    manifest.append((n, ln, kind, data[:8].hex()))
print("block kinds:", kinds)
for row in manifest[:60]:
    print("  blk%03d len=%9d %s %s" % row)

# ── E. header 内文件名清单（栈判定金矿） ──
names = re.findall(rb"[\x20-\x7e]{4,}", hdr)
interesting = [x.decode("latin1") for x in names
               if re.search(rb"(?i)\.(exe|dll|pak|asar|dat|bin|node|json|htm|html|js|css|png|icns|so|dylib)$|electron|cef|chrom|node|asar|v8|icudtl|locales|snapshot", x)]
print(f"\n== header 中的框架线索（前80） ==")
for s in interesting[:80]:
    print("  ", s)
open(os.path.join(OUT, "names_all.txt"), "w", encoding="utf-8").write("\n".join(x.decode("latin1") for x in names))
print(f"\nnames total={len(names)} -> names_all.txt；blocks={len(blocks)}")
