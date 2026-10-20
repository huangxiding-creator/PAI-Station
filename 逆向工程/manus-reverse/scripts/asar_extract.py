# -*- coding: utf-8 -*-
"""Minimal ASAR extractor — reads asar archive, writes files to output dir.

Usage: py -3 -I asar_extract.py <app.asar> <output_dir>
"""
import json
import struct
import sys
from pathlib import Path


def read_header(f):
    f.seek(0)
    # Layout: [0:4]=size-pickle payload len(4) [4:8]=H(header pickle total size)
    # header pickle buf: [0:4]=payload size [4:8]=json string len [8:8+len]=json
    _, h_size = struct.unpack('<II', f.read(8))
    hdr = f.read(h_size)
    json_len = struct.unpack('<I', hdr[4:8])[0]
    header = json.loads(hdr[8:8 + json_len])
    data_base = 8 + h_size                           # file bytes start after whole pickle
    return header, data_base


def walk(node, prefix, f, data_base, out_root, counter):
    for name, entry in node.get('files', {}).items():
        p = prefix / name
        if 'files' in entry:                          # directory
            walk(entry, p, f, data_base, out_root, counter)
            continue
        if 'offset' not in entry:                     # unpacked (empty) file
            continue
        off = data_base + int(entry['offset'])
        size = entry['size']
        f.seek(off)
        payload = f.read(size)
        dest = out_root / p
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_bytes(payload)
        counter[0] += 1
        counter[1] += size


def main():
    asar_path = Path(sys.argv[1])
    out_root = Path(sys.argv[2])
    out_root.mkdir(parents=True, exist_ok=False)
    with asar_path.open('rb') as f:
        header, data_base = read_header(f)
        counter = [0, 0]
        walk(header, Path('.'), f, data_base, out_root, counter)
    print(f"extracted {counter[0]} files, {counter[1]:,} bytes -> {out_root}")


if __name__ == '__main__':
    main()
