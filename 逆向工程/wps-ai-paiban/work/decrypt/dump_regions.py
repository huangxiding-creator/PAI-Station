# -*- coding: utf-8 -*-
# usage: py -3 -I dump_regions.py <dll_path> <outdir>
# 1) parse PE export directory; 2) wide ASCII/UTF16 string dumps of hot regions
import sys, re, struct, os

dll_path, outdir = sys.argv[1], sys.argv[2]
data = open(dll_path, 'rb').read()
n = len(data)

e_lfanew = struct.unpack_from('<I', data, 0x3c)[0]
coff = e_lfanew + 4
machine, nsec, _, _, _, optsize, _ = struct.unpack_from('<HHIIIHH', data, coff)
opt = coff + 20
magic = struct.unpack_from('<H', data, opt)[0]
imgbase = struct.unpack_from('<I', data, opt+28)[0] if magic == 0x10b else struct.unpack_from('<Q', data, opt+24)[0]
sec_off = opt + optsize
secs = []
for i in range(nsec):
    b = sec_off + i*40
    name = data[b:b+8].rstrip(b'\x00').decode('ascii', 'replace')
    vsize, vaddr, rawsize, rawptr = struct.unpack_from('<IIII', data, b+8)
    secs.append((name, rawptr, rawsize, vaddr))

def off2rva(off):
    for name, rawptr, rawsize, vaddr in secs:
        if rawptr <= off < rawptr + max(rawsize, 1):
            return vaddr + (off - rawptr)
    return None

def rva2off(rva):
    for name, rawptr, rawsize, vaddr in secs:
        if vaddr <= rva < vaddr + max(rawsize, 1):
            return rawptr + (rva - vaddr)
    return None

# ---- export directory ----
# PE32: NumberOfRvaAndSizes at opt+92, data dirs at opt+96; export dir = index 0
nrva = struct.unpack_from('<I', data, opt+92)[0]
exp_rva, exp_size = struct.unpack_from('<II', data, opt+96)
lines = [f"export_dir rva=0x{exp_rva:x} size={exp_size} nrva={nrva} imagebase=0x{imgbase:x}"]
exports = []
if exp_rva and exp_size:
    eo = rva2off(exp_rva)
    if eo is not None:
        chars, tstamp, maj, mnr, name_rva, base_ord, nfunc, nname, addr_funcs_rva, addr_names_rva, addr_ords_rva = struct.unpack_from('<IIHHIIIIIII', data, eo)
        no = rva2off(name_rva)
        dllname = b''
        if no is not None:
            e = data.index(b'\x00', no)
            dllname = data[no:e]
        lines.append(f"dll_name={dllname.decode('ascii','replace')} nfuncs={nfunc} nnames={nname} ordinal_base={base_ord}")
        names_off = rva2off(addr_names_rva)
        funcs_off = rva2off(addr_funcs_rva)
        ords_off = rva2off(addr_ords_rva)
        for i in range(nname):
            nr = struct.unpack_from('<I', data, names_off + 4*i)[0]
            no2 = rva2off(nr)
            e = data.index(b'\x00', no2)
            nm = data[no2:e].decode('ascii', 'replace')
            ordv = struct.unpack_from('<H', data, ords_off + 2*i)[0]
            frva = struct.unpack_from('<I', data, funcs_off + 4*ordv)[0]
            exports.append((base_ord + ordv, nm, frva))
        for o_, nm, frva in exports:
            lines.append(f"  exp ord={o_:4d} rva=0x{frva:08x} {nm}")
with open(os.path.join(outdir, 'exports.txt'), 'w', encoding='utf-8') as f:
    f.write('\n'.join(lines))
print("exports:", len(exports))

# ---- import directory (which DLLs it imports, look for crypto providers) ----
imp_lines = []
imp_rva, imp_size = struct.unpack_from('<II', data, opt+96+8*1)
if imp_rva:
    io = rva2off(imp_rva)
    while True:
        oft, tds, fwd, namerva, ft = struct.unpack_from('<IIIII', data, io)
        if namerva == 0:
            break
        no2 = rva2off(namerva)
        e = data.index(b'\x00', no2)
        dll = data[no2:e].decode('ascii', 'replace')
        funcs = []
        thunk = oft if oft else ft
        toff = rva2off(thunk)
        while True:
            val = struct.unpack_from('<I', data, toff)[0]
            if val == 0:
                break
            if val & 0x80000000:
                funcs.append(f"#ord{val & 0xffff}")
            else:
                hno = rva2off(val)
                fname_e = data.index(b'\x00', hno+2)
                funcs.append(data[hno+2:fname_e].decode('ascii', 'replace'))
            toff += 4
        imp_lines.append(f"{dll} ({len(funcs)} funcs): " + ', '.join(funcs[:12]) + (' ...' if len(funcs) > 12 else ''))
        io += 20
with open(os.path.join(outdir, 'imports.txt'), 'w', encoding='utf-8') as f:
    f.write('\n'.join(imp_lines))
print("import dlls:", len(imp_lines))

# ---- wide region dumps (ASCII + UTF16LE strings) ----
PRINT = re.compile(rb'[\x20-\x7e]{4,}')
def dump_region(lo, hi, tag):
    out = [f"##### region {tag} [{lo},{hi}) #####"]
    out.append("--- ASCII ---")
    for m in PRINT.finditer(data[lo:hi]):
        out.append(f"{lo+m.start():>8d} | {m.group().decode('ascii')}")
    out.append("--- UTF16LE ---")
    i = lo
    while i < hi - 1:
        if 0x20 <= data[i] <= 0x7e and data[i+1] == 0:
            j = i
            s = []
            while j < hi - 1 and 0x20 <= data[j] <= 0x7e and data[j+1] == 0:
                s.append(chr(data[j])); j += 2
            if len(s) >= 4:
                out.append(f"{i:>8d} | " + ''.join(s))
            i = j
        else:
            i += 1
    return '\n'.join(out)

regions = [
    (3213000, 3219000, "manifest_json_schema_encrypted_mk_key"),
    (3219900, 3221200, "customtemplates_presettemplates_nationalstandard"),
    (3265500, 3266800, "encrypt_zone"),
    (4178000, 4186000, "template_styles_json_utf16"),
]
with open(os.path.join(outdir, 'region_dumps.txt'), 'w', encoding='utf-8') as f:
    f.write('\n\n'.join(dump_region(a, b, t) for a, b, t in regions))
print("region_dumps written")
