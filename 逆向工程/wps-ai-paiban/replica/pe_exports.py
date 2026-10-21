#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""轻量 PE 导出表解析器（objdump 不可用时的 Windows 本地等价件）。
用法: py -3 pe_exports.py <dll路径> [关键词过滤]"""
import struct
import sys


def rva2off(rva, sections):
    for va, vsz, raw, rsz in sections:
        if va <= rva < va + max(vsz, rsz):
            return raw + (rva - va)
    return None


def main(path, kw=None):
    data = open(path, "rb").read()
    pe_off = struct.unpack_from("<I", data, 0x3C)[0]
    assert data[pe_off:pe_off + 4] == b"PE\x00\x00", "not PE"
    machine, nsec = struct.unpack_from("<HH", data, pe_off + 4)[0:2]
    opt_sz = struct.unpack_from("<H", data, pe_off + 20)[0]
    opt = pe_off + 24
    magic = struct.unpack_from("<H", data, opt)[0]
    pe32p = magic == 0x20B
    dd_off = opt + (0x74 if pe32p else 0x60)
    exp_rva, exp_sz = struct.unpack_from("<II", data, dd_off)
    arch = {0x14C: "x86", 0x8664: "x64", 0xAA64: "arm64"}.get(machine, hex(machine))
    print(f"[PE] arch={arch} bits={64 if pe32p else 32} sections={nsec} export_rva={exp_rva:#x} size={exp_sz}")
    if not exp_rva:
        print("[!] 无导出表（仅导入或纯资源/内部组件）")
        return
    secs = []
    for i in range(nsec):
        s = pe_off + 24 + opt_sz + i * 40
        vsz, va, rsz, raw = struct.unpack_from("<I", data, s + 8)[0], struct.unpack_from("<I", data, s + 12)[0], \
            struct.unpack_from("<I", data, s + 16)[0], struct.unpack_from("<I", data, s + 20)[0]
        secs.append((va, vsz, raw, rsz))
    e = rva2off(exp_rva, secs)
    n_names = struct.unpack_from("<I", data, e + 24)[0]
    names_rva = struct.unpack_from("<I", data, e + 32)[0]
    names_off = rva2off(names_rva, secs)
    names = []
    for i in range(n_names):
        nrva = struct.unpack_from("<I", data, names_off + i * 4)[0]
        no = rva2off(nrva, secs)
        end = data.index(b"\x00", no)
        name = data[no:end].decode("utf-8", "replace")
        if kw is None or kw.lower() in name.lower():
            names.append(name)
    print(f"[导出] {n_names} 个（过滤后 {len(names)}）")
    for n in names[:80]:
        print(" ", n)


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2] if len(sys.argv) > 2 else None)
