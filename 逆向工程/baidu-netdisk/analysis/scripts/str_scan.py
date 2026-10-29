# -*- coding: utf-8 -*-
"""String scanner for BaiduNetdisk reverse: endpoints, verify keywords, credential FIELD NAMES ONLY.
Values are masked (first6 + ... + len) before printing. Never prints full secrets.
Usage: python -I str_scan.py <file> [file ...]
"""
import sys, re, json, hashlib

URL_RE = re.compile(rb"https?://[A-Za-z0-9._~:/?#\[\]@!$&'()*+,;=%-]{4,180}")
DOMAIN_RE = re.compile(rb"[A-Za-z0-9][A-Za-z0-9.-]*\.(?:baidu|baidupcs|bdimg|bdstatic|bcebos|qianxin)\.(?:com|cn)[A-Za-z0-9._/-]{0,80}")
CRED_KEYS = [
    b"BDUSS", b"STOKEN", b"bduss", b"stoken", b"ndus", b"PTQR", b"ptoken",
    b"bdstoken", b"access_token", b"refresh_token", b"sessionid", b"SESSION",
    b"passport", b"Cookie", b"cookie", b"token", b"sig", b"h sha1",
]
VERIFY_KEYS = [
    b"md5", b"MD5", b"sha1", b"SHA1", b"sha256", b"SHA256", b"WinVerifyTrust",
    b"CryptVerifyDetachedMessage", b"verify_sign", b"check_sign", b"signature",
    b"publickey", b"verify_file", b"check_md5", b"md5_check", b"Authenticode",
]
MAGIC = [
    (b"SQLite format 3\x00", "sqlite"),
    (b"MZ", "pe"), (b"PK\x03\x04", "zip"),
    (b"\x1f\x8b", "gzip"), (b"MSCF", "cab"),
    (b"\x89PNG", "png"), (b"\xff\xd8\xff", "jpeg"),
    (b"7z\xbc\xaf\x27\x1c", "7z"),
    (b"Rar!\x1a\x07", "rar"),
]
ASCII_STR = re.compile(rb"[\x20-\x7e]{5,}")
UTF16_STR = re.compile(rb"(?:[\x20-\x7e]\x00){5,}")

def mask_val(v):
    v = v.decode("latin1", "ignore")
    if len(v) <= 10:
        return "*" * len(v)
    return "%s...(%d chars)" % (v[:6], len(v))

def md5sum(path, limit=None):
    h = hashlib.md5()
    with open(path, "rb") as f:
        while True:
            b = f.read(1 << 20)
            if not b:
                break
            h.update(b)
    return h.hexdigest()

def scan(path):
    out = {"path": path}
    try:
        with open(path, "rb") as f:
            head = f.read(16)
            f.seek(0)
            data = f.read()
    except OSError as e:
        out["error"] = str(e)
        return out
    out["size"] = len(data)
    out["magic"] = next((name for m, name in MAGIC if head.startswith(m)), "unknown:" + head[:8].hex())
    if len(data) < 200_000_000:
        out["md5"] = md5sum(path)
    urls = sorted(set(m.group().decode("latin1") for m in URL_RE.finditer(data)))
    if len(urls) > 80:
        urls = urls[:80] + ["...(+%d more)" % (len(urls) - 80)]
    out["urls"] = urls
    doms = sorted(set(m.group().decode("latin1") for m in DOMAIN_RE.finditer(data)))
    if len(doms) > 60:
        doms = doms[:60] + ["...(+%d more)" % (len(doms) - 60)]
    out["baidu_domains"] = doms
    # verify keyword hits with small context (ascii only)
    vhits = {}
    for kw in VERIFY_KEYS:
        idx = data.find(kw)
        if idx >= 0:
            ctx = data[max(0, idx - 40):idx + 60]
            ctx_s = "".join(chr(c) if 32 <= c < 127 else "." for c in ctx)
            vhits[kw.decode("latin1")] = ctx_s[:100]
    out["verify_hits"] = vhits
    # credential keys: only field names + masked nearby value
    chits = {}
    for kw in CRED_KEYS:
        for m in re.finditer(re.escape(kw), data):
            seg = data[m.start():m.start() + 300]
            sm = re.match(rb"([A-Za-z_]{2,20})\s*[=:]\s*([!-~]{8,300})", seg)
            if sm:
                key = sm.group(1).decode("latin1")
                chits[key] = mask_val(sm.group(2))
            else:
                chits.setdefault(kw.decode("latin1"), "name-only(no inline value)")
            break
    out["cred_field_hits"] = chits
    # interesting: pipe names, json/proto markers
    markers = {}
    for mk, tag in [(b"\\\\.\\pipe\\", "pipe_path"), (b"CreateNamedPipe", "CreateNamedPipe"),
                    (b"baidunetdisk", "pipe_prefix_baidunetdisk"), (b"KernelCom", "KernelCom"),
                    (b"protobuf", "protobuf"), (b"application/json", "json_mime"),
                    (b"content-type", "http_hdr"), (b"grpc", "grpc")]:
        c = data.count(mk)
        if c:
            markers[tag] = c
    out["markers"] = markers
    return out

if __name__ == "__main__":
    print(json.dumps([scan(p) for p in sys.argv[1:]], ensure_ascii=True, indent=1))
