# -*- coding: utf-8 -*-
"""Static PE packer/anti-debug scan for BaiduNetdisk binaries.
Read-only: never executes target code. Usage: python -I pe_scan.py <pe1> [pe2 ...]
Outputs JSON to stdout (ascii-safe).
"""
import sys, re, json
import pefile

PACKER_SIGS = [
    b"Themida", b"WinLicense", b"VMProtect", b".vmp", b"Enigma", b"Obsidium",
    b"ASProtect", b"EXECryptor", b"UPX!", b"PECompact2", b"MPRESS", b"nsPack",
    b"ASPack", b".petite", b"FSG!", b"MEW11", b"StarForce", b"SecuROM",
    b"Armadillo", b"Obsidium", b"Code Virtualizer", b"Oreans",
]
PACKER_SECTION_HINTS = [
    "themida", "winlice", "vmp0", "vmp1", "vmp2", "enigma", "upx0", "upx1",
    "upx2", "aspack", "adata", "nsp0", "nsp1", "nsp2", "pep", "petite",
    "fsg", "mpress", ".bf", "bss",
]
ANTI_DEBUG_APIS = [
    "IsDebuggerPresent", "CheckRemoteDebuggerPresent",
    "NtQueryInformationProcess", "NtSetInformationThread",
    "OutputDebugStringA", "OutputDebugStringW", "DbgUiRemoteBreakin",
    "DbgBreakPoint", "DbgPrint", "ProcessDebugPort", "ProcessDebugObjectHandle",
    "NtCreateDebugObject", "RtlAdjustPrivilege", "NtQuerySystemInformation",
    "GetTickCount", "QueryPerformanceCounter", "NtQueryObject",
    "NtClose", "NtSetDebugFilterState", "NtSystemDebugControl",
    "AddVectoredExceptionHandler", "RaiseException", "NtQueryPerformanceCounter",
]
SEC_NAME_RE = re.compile(rb"[ -~]{2,8}")

def shannon(data):
    if not data:
        return 0.0
    freq = [0]*256
    for b in data:
        freq[b] += 1
    n = len(data)
    e = 0.0
    for f in freq:
        if f:
            p = f/n
            e -= p*math_log2(p)
    return e

def math_log2(x):
    import math
    return math.log2(x)

def utf16_strings(data, minlen=5):
    # crude UTF-16LE ascii-range string extractor
    pat = re.compile(rb"(?:[ -~]\x00){%d,}" % minlen)
    for m in pat.finditer(data):
        yield m.group().decode("utf-16-le", "ignore")

def scan(path):
    out = {"path": path, "error": None}
    try:
        with open(path, "rb") as f:
            data = f.read()
    except OSError as e:
        out["error"] = str(e)
        return out
    out["size"] = len(data)
    out["sha_head"] = None
    try:
        pe = pefile.PE(data=data, fast_load=False)
    except Exception as e:
        out["error"] = "PE parse: %r" % e
        # still do raw strings on non-PE
        return out
    out["machine"] = hex(pe.FILE_HEADER.Machine)
    out["bits"] = 64 if pe.OPTIONAL_HEADER.Magic == pefile.OPTIONAL_HEADER_MAGIC_PE_PLUS else 32
    import datetime
    try:
        ts = pe.FILE_HEADER.TimeDateStamp
        out["timestamp"] = "%d (%s)" % (ts, datetime.datetime.utcfromtimestamp(ts).isoformat())
    except Exception:
        pass
    # version info
    vi = {}
    try:
        pe.parse_data_directories()
        if hasattr(pe, "VS_VERSIONINFO") and pe.VS_VERSIONINFO:
            for st in getattr(pe, "FileInfo", []) or []:
                for entry in st.get("StringTable", []) or []:
                    for k, v in entry.entries.items():
                        vi[k.decode("latin1", "ignore")] = v.decode("latin1", "ignore")
    except Exception:
        pass
    out["version_info"] = vi
    # sections
    secs = []
    maxent = 0.0
    for s in pe.sections:
        name = s.Name.rstrip(b"\x00").decode("latin1", "ignore").strip()
        try:
            ent = s.get_entropy()
        except Exception:
            ent = -1
        d = s.get_data()
        # recompute over raw file-aligned chunk if needed
        if ent < 0:
            ent = shannon(d)
        maxent = max(maxent, ent if ent > 0 else 0)
        secs.append({
            "name": name, "vsize": s.Misc_VirtualSize,
            "rawsize": s.SizeOfRawData, "entropy": round(ent, 3),
            "char": hex(s.Characteristics),
        })
    out["sections"] = secs
    out["max_section_entropy"] = round(maxent, 3)
    out["packed_guess"] = bool(maxent > 7.2)
    # section-name packer hints
    hints = []
    for s in secs:
        ln = s["name"].lower()
        for h in PACKER_SECTION_HINTS:
            if h in ln:
                hints.append(s["name"])
    out["section_hints"] = hints
    # overlay
    try:
        ov = pe.get_overlay_data_start_offset()
        out["overlay_bytes"] = (len(data) - ov) if ov else 0
    except Exception:
        out["overlay_bytes"] = None
    # TLS callbacks
    try:
        out["tls_callbacks"] = len(pe.TLS_DIRECTORY.struct.AddressOfCallBacks) if hasattr(pe, "TLS_DIRECTORY") and pe.TLS_DIRECTORY else 0
    except Exception:
        out["tls_callbacks"] = None
    # imports
    imps = {}
    total = 0
    try:
        for entry in getattr(pe, "DIRECTORY_ENTRY_IMPORT", []) or []:
            dll = entry.dll.decode("latin1", "ignore")
            names = []
            for imp in entry.imports:
                total += 1
                if imp.name:
                    names.append(imp.name.decode("latin1", "ignore"))
            imps[dll] = names
    except Exception:
        pass
    out["import_dll_count"] = len(imps)
    out["import_func_total"] = total
    out["import_dlls"] = sorted(imps.keys())
    found_anti = sorted({a for names in imps.values() for a in names if a in ANTI_DEBUG_APIS})
    out["anti_debug_imports"] = found_anti
    # exports
    try:
        exps = [e.name.decode("latin1", "ignore") for e in pe.DIRECTORY_ENTRY_EXPORT.symbols if e.name][:40]
        out["export_count"] = len(pe.DIRECTORY_ENTRY_EXPORT.symbols)
        out["exports_sample"] = exps
    except Exception:
        out["export_count"] = 0
    # raw strings scan for packer sigs + anti-debug + baidu marks
    hits = {}
    for sig in PACKER_SIGS:
        if sig in data:
            hits[sig.decode("latin1")] = "ascii"
    for s in utf16_strings(data):
        pass  # cheap skip: packer sigs rarely utf16; keep ascii only for speed
    for a in ANTI_DEBUG_APIS:
        if a.encode() in data and a not in found_anti:
            found_anti.append(a + "(str)")
    out["packer_string_hits"] = hits
    out["anti_debug_any"] = found_anti
    # common runtime lib markers to explain high entropy text sections
    for marker, tag in [(b"Go build ID:", "go"), (b"rust_begin_unwind", "rust"),
                        (b"_pydatetime", "cpython"), (b"libcef", "cef"),
                        (b"protobuf", "protobuf"), (b"gRPC", "grpc")]:
        if marker in data:
            out.setdefault("runtime_markers", []).append(tag)
    return out

if __name__ == "__main__":
    results = []
    for p in sys.argv[1:]:
        results.append(scan(p))
    print(json.dumps(results, ensure_ascii=True, indent=1))
