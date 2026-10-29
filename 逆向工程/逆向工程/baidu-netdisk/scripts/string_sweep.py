# -*- coding: utf-8 -*-
"""
百度网盘客户端静态字符串/导入表普查(静态腿, 不运行任何被分析二进制)
用法: python -I string_sweep.py
产出: ../analysis/STATIC_STRINGS_RAW.md (原始清单) + ../analysis/_digest.json (机器摘要, 供人工写汇总)
"""
import json
import os
import re
import sys

try:
    import pefile
    HAVE_PEFILE = True
except ImportError:
    HAVE_PEFILE = False

BASE = r"C:\Users\91216\AppData\Roaming\baidu\BaiduNetdisk"
BDPAN = r"C:\Users\91216\AppData\Local\bdpan\bdpan.exe"
OUT_DIR = r"E:\AI-Station\逆向工程\baidu-netdisk\analysis"

TARGETS = [
    ("netbase.dll", os.path.join(BASE, "netbase.dll")),
    ("kernel_btsdk.dll", os.path.join(BASE, "kernel_btsdk.dll")),
    ("YunDls.dll", os.path.join(BASE, "YunDls.dll")),
    ("YunLogic.dll", os.path.join(BASE, "YunLogic.dll")),
    ("logonbd.dll", os.path.join(BASE, "logonbd.dll")),
    ("channelpcsdk.dll", os.path.join(BASE, "channelpcsdk.dll")),
    ("cefbrowser.dll", os.path.join(BASE, "cefbrowser.dll")),
    ("minosagent.dll", os.path.join(BASE, "minosagent.dll")),
    ("bdpan.exe", BDPAN),
]
SMALL_FILES = [
    ("VersionInfo", os.path.join(BASE, "VersionInfo")),
    ("VersionInfo2", os.path.join(BASE, "VersionInfo2")),
    ("AppProperty.xml", os.path.join(BASE, "AppProperty.xml")),
    ("AppConfig.ini", os.path.join(BASE, "AppConfig.ini")),
    ("cacert.pem", os.path.join(BASE, "cacert.pem")),
]

# (关键词, 是否词边界匹配)  —— 短/泛词用词边界压噪
KEYWORDS = [
    ("http", False), ("baidu", False), ("pcs", True), ("xpan", False),
    ("clienttype", False), ("netdisk;", False), ("User-Agent", False),
    ("BDUSS", False), ("STOKEN", False), ("bdstoken", False), ("sign", True),
    ("superfile", False), ("precreate", False), ("block_list", False),
    ("slice", True), ("md5", True), ("passport", False), ("union", True),
    ("spirit", False), ("d.pcs", False), ("baidupcs", False),
    ("appid", False), ("app_id", False), ("p2p", True), ("torrent", False),
    ("dubbo", False), ("grpc", False), ("protobuf", False),
]
# netbase.dll 追加热更新线索词
EXTRA_KW = {
    "netbase.dll": [("update", True), ("upgrade", True), ("autoupdate", False), ("hotfix", False), ("patch", True), ("download", True)],
}
CTX = 60          # ±60字节上下文
MIN_LEN = 5       # 字符串最短长度
MAX_PER_KW = 400  # 每关键词每文件唯一串上限(截断则标注)

ASCII_RE = re.compile(rb"[\x20-\x7e]{%d,}" % MIN_LEN)
UTF16_RE = re.compile(rb"(?:[\x20-\x7e]\x00){%d,}" % MIN_LEN)
URL_RE = re.compile(r"https?://[^\s\"'<>\\)\]}]+", re.I)
HOST_RE = re.compile(r"(?<![A-Za-z0-9.-])((?:[A-Za-z0-9-]+\.)+)(?:com|cn|net|org|top|io|me)(?![A-Za-z0-9-])", re.I)
PIN_HINTS = ["SSL_set_verify", "X509_verify", "SSL_get_verify_result", "pinning", "certificate_pinned",
             "CertVerifyCertificateChainPolicy", "pin-sha256", "publickeypin"]

def extract_strings(data):
    """返回 [(offset, string)]  ASCII + UTF-16LE"""
    out = []
    for m in ASCII_RE.finditer(data):
        out.append((m.start(), m.group().decode("ascii", "replace")))
    for m in UTF16_RE.finditer(data):
        try:
            out.append((m.start(), m.group().decode("utf-16-le")))
        except Exception:
            pass
    out.sort(key=lambda t: t[0])
    return out

def render_ctx(data, off, klen):
    lo = max(0, off - CTX); hi = min(len(data), off + klen + CTX)
    seg = data[lo:hi]
    seg = seg.replace(b"\x00", b".")
    txt = "".join(chr(b) if 0x20 <= b < 0x7f else "." for b in seg)
    return txt

def scan_file(name, path):
    with open(path, "rb") as f:
        data = f.read()
    strings = extract_strings(data)
    digest = {"name": name, "size": len(data)}
    raw_blocks = []

    extra = EXTRA_KW.get(name, [])
    kws = KEYWORDS + extra

    hits = {}  # kw -> {s: (off, enc)}
    for off, s in strings:
        low = s.lower()
        for kw, wb in kws:
            if kw == "d.pcs":
                ok = "d.pcs" in low
            elif wb:
                ok = re.search(r"(?<![A-Za-z0-9_])" + re.escape(kw.lower()) + r"(?![A-Za-z0-9])", low) is not None
            else:
                ok = kw.lower() in low
            if ok:
                d = hits.setdefault(kw, {})
                if s not in d:
                    d[s] = off

    # 导入表
    imp_dlls, imp_apis_interesting = [], []
    pinning_hits = []
    if HAVE_PEFILE:
        try:
            pe = pefile.PE(path, fast_load=True)
            pe.parse_data_directories(directories=[
                pefile.DIRECTORY_ENTRY["IMAGE_DIRECTORY_ENTRY_IMPORT"]])
            digest["machine"] = hex(pe.FILE_HEADER.Machine)
            digest["timestamp"] = pe.FILE_HEADER.TimeDateStamp
            try:
                for entry in getattr(pe, "DIRECTORY_ENTRY_IMPORT", []):
                    dll = entry.dll.decode("utf-8", "replace")
                    imp_dlls.append(dll)
                    for imp in entry.imports:
                        if not imp.name:
                            continue
                        n = imp.name.decode("utf-8", "replace")
                        ln = n.lower()
                        if (ln.startswith(("winhttp", "internetopen", "internetconnect", "internetreadfile", "httpsendrequest", "httpopenrequest"))
                                or ln in ("wsastartup", "socket", "connect", "send", "recv", "select", "closesocket", "shutdown", "gethostbyname", "getaddrinfo", "freeaddrinfo", "setsockopt")
                                or ln.startswith(("cert", "crypt", "bcrypt"))
                                or ln.startswith(("evp_", "ssl_"))):
                            imp_apis_interesting.append(dll + "!" + n)
            except Exception as e:
                imp_dlls.append("!!parse error: %s" % e)
        except Exception as e:
            imp_dlls.append("!!PE error: %s" % e)

    # OpenSSL/证书 pinning 线索(字符串层)
    ssl_ver = sorted({s for _, s in strings if re.search(r"OpenSSL\s+\d+\.\d+", s)})[:8]
    boring = sorted({s for _, s in strings if "oringssl" in s})[:4]
    for _, s in strings:
        for h in PIN_HINTS:
            if h.lower() in s.lower() and s not in pinning_hits:
                pinning_hits.append(s)
    # sha256 邻近 cert 的串
    for _, s in strings:
        l = s.lower()
        if "sha256" in l and ("cert" in l or "pin" in l or "pubkey" in l or "key" in l):
            if s not in pinning_hits:
                pinning_hits.append(s)

    # 域名/URL 汇总
    hosts, urls = {}, set()
    for _, s in strings:
        for u in URL_RE.findall(s):
            urls.add(u)
        for m in HOST_RE.finditer(s):
            full = m.group(0)
            hosts[full] = hosts.get(full, 0) + 1
    baidu_hosts = sorted(((h, c) for h, c in hosts.items() if "baidu" in h.lower() or "bdstatic" in h.lower() or "bdimg" in h.lower() or "bcebos" in h.lower()))
    other_hosts = sorted(((h, c) for h, c in hosts.items() if not ("baidu" in h.lower() or "bdstatic" in h.lower() or "bdimg" in h.lower() or "bcebos" in h.lower())))

    # ---- RAW 块 ----
    b = []
    b.append("## %s  (%d bytes)" % (name, len(data)))
    b.append("")
    b.append("- 导入DLL: %s" % (", ".join(imp_dlls) if imp_dlls else "(无/解析失败)"))
    b.append("- 关键网络API: %s" % (", ".join(sorted(set(imp_apis_interesting))) or "(无)"))
    b.append("- OpenSSL版本串: %s" % (ssl_ver or "无"))
    b.append("- BoringSSL串: %s" % (boring or "无"))
    b.append("- Pinning线索串: %s" % (pinning_hits[:20] or "无"))
    b.append("")
    b.append("### 域名(baidu系) %d 个" % len(baidu_hosts))
    b.append("```")
    for h, c in baidu_hosts:
        b.append("%s  x%d" % (h, c))
    b.append("```")
    if other_hosts:
        b.append("### 其他域名 %d 个(节选前60)" % len(other_hosts))
        b.append("```")
        for h, c in other_hosts[:60]:
            b.append("%s  x%d" % (h, c))
        b.append("```")
    if urls:
        b.append("### URL常量 %d 条" % len(urls))
        b.append("```")
        for u in sorted(urls)[:300]:
            b.append(u)
        b.append("```")
    b.append("")
    b.append("### 关键词命中(去重)")
    for kw, _ in kws:
        d = hits.get(kw)
        if not d:
            continue
        items = sorted(d.items(), key=lambda t: t[1])
        b.append("")
        b.append("#### [%s] %d 条唯一串%s" % (kw, len(items), "(截断至%d)" % MAX_PER_KW if len(items) > MAX_PER_KW else ""))
        b.append("```")
        for s, off in items[:MAX_PER_KW]:
            s2 = s if len(s) <= 200 else s[:200] + "..."
            b.append("0x%08x | %s" % (off, s2))
        b.append("```")
    raw_blocks.append("\n".join(b))

    digest["import_dlls"] = imp_dlls
    digest["net_apis"] = sorted(set(imp_apis_interesting))[:80]
    digest["openssl"] = ssl_ver
    digest["boringssl"] = boring
    digest["pinning"] = pinning_hits[:20]
    digest["baidu_hosts"] = baidu_hosts
    digest["other_hosts_top"] = other_hosts[:80]
    digest["urls_top"] = sorted(urls)[:150]
    digest["kw_counts"] = {kw: len(hits.get(kw, {})) for kw, _ in kws if kw in hits}
    digest["kw_samples"] = {kw: [s for s, _ in sorted(hits[kw].items(), key=lambda t: t[1])[:25]]
                            for kw, _ in kws if kw in hits}
    return raw_blocks, digest

def main():
    os.makedirs(OUT_DIR, exist_ok=True)
    raw = ["# 百度网盘客户端 静态字符串普查 RAW (2026-10-29)",
           "",
           "> 方法: python -I string_sweep.py; ASCII+UTF-16LE 字符串(>=5字符), 关键词去重命中;",
           "> 词边界词: pcs/sign/slice/md5/p2p/union/update 等; 导入表: pefile; 未运行任何被分析二进制。",
           ""]
    digests = []
    for name, path in TARGETS:
        if not os.path.exists(path):
            raw.append("## %s — 文件不存在: %s" % (name, path))
            continue
        blocks, dig = scan_file(name, path)
        raw.extend(blocks)
        digests.append(dig)

    raw.append("\n# 附: 小文件直读")
    small_out = {}
    for name, path in SMALL_FILES:
        if not os.path.exists(path):
            continue
        with open(path, "rb") as f:
            data = f.read()
        try:
            txt = data.decode("utf-8")
        except Exception:
            try:
                txt = data.decode("gbk")
            except Exception:
                txt = data.decode("latin-1")
        raw.append("\n## %s (%d bytes)" % (name, len(data)))
        raw.append("```")
        if name == "cacert.pem":
            # 只摘结构不全文
            issuer = re.findall(r"Issuer:.*", txt)
            subject = re.findall(r"Subject:.*", txt)
            ncert = txt.count("BEGIN CERTIFICATE")
            raw.append("证书块数: %d" % ncert)
            raw.append("Issuer 样本(前15):")
            raw.extend(issuer[:15])
            raw.append("Subject 样本(前15):")
            raw.extend(subject[:15])
            small_out[name] = {"certs": ncert, "issuers": issuer[:15]}
        else:
            if any(ord(c) < 0x20 and c not in "\r\n\t" for c in txt[:4000]):
                esc = "".join(
                    c if (ord(c) >= 0x20 or c in "\r\n\t") else "\\x%02x" % ord(c) for c in txt[:4000])
                raw.append("(二进制/加密内容, 转义展示前4000字符)")
                raw.append(esc)
                small_out[name] = "BIN:" + esc[:200]
            else:
                raw.append(txt[:4000])
                small_out[name] = txt[:2000]
        raw.append("```")

    with open(os.path.join(OUT_DIR, "STATIC_STRINGS_RAW.md"), "w", encoding="utf-8") as f:
        f.write("\n".join(raw))
    with open(os.path.join(OUT_DIR, "_digest.json"), "w", encoding="utf-8") as f:
        json.dump({"digests": digests, "small": small_out}, f, ensure_ascii=False, indent=1)
    # 控制台简报
    for d in digests:
        print("== %s size=%d machine=%s" % (d["name"], d["size"], d.get("machine")))
        print("   importDLLs:", ",".join(d["import_dlls"][:20]))
        print("   baiduHosts:", len(d["baidu_hosts"]), "urls:", len(d["urls_top"]), "kw:", d["kw_counts"])

if __name__ == "__main__":
    main()
