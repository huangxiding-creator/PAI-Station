# -*- coding: utf-8 -*-
"""live_harvest.py — 面板开窗期实时收割：驱动周期→开着结果面板→同时附体双进程扫描"""
import subprocess
import sys
import time
from pathlib import Path

import frida
from PIL import Image

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ADB = r"E:\AI-Station\rea-tools\platform-tools\adb.exe"
DEV = "emulator-5554"
EV = Path(r"E:\AI-Station\逆向工程\rokid-rebrand\evidence")
OUT = Path(r"E:\AI-Station\逆向工程\rokid-rebrand\dump")
BD = "top.niunaijun.blackdexa64"

JS = r"""
var N = 0; var found = {};
function scan(r) {
    var file = r.file ? r.file.path : '';
    if (file || r.size > 300000000 || r.size < 4096) return;
    try {
        var CHUNK = 0x100000;
        for (var off = 0; off + 0x70 <= r.size; off += CHUNK - 0x100) {
            var len = Math.min(CHUNK, r.size - off);
            try {
                var buf = Memory.readByteArray(r.base.add(off), len);
                var u8 = new Uint8Array(buf);
                for (var i = 0; i + 0x70 <= u8.length; i++) {
                    if (u8[i]===0x64 && u8[i+1]===0x65 && u8[i+2]===0x78 && u8[i+3]===0x0a) {
                        var fis = (u8[i+0x20])|(u8[i+0x21]<<8)|(u8[i+0x22]<<16)|(u8[i+0x23]<<24);
                        var sis = (u8[i+0x38])|(u8[i+0x39]<<8)|(u8[i+0x3a]<<16)|(u8[i+0x3b]<<24);
                        var hsz = (u8[i+0x24])|(u8[i+0x25]<<8)|(u8[i+0x26]<<16)|(u8[i+0x27]<<24);
                        if (sis>0 && sis<2000000 && fis>=0x70 && fis<0x8000000 && hsz===0x70) {
                            var addr = r.base.add(off + i); var key = '' + addr;
                            if (!found[key]) { found[key] = true;
                                try { send({n: N, addr: key, size: fis}, Memory.readByteArray(addr, fis)); N++; }
                                catch (e) {}
                            }
                            i += fis - 1;
                        }
                    }
                }
            } catch (e) {}
        }
    } catch (e) {}
}
var ranges = Process.enumerateRanges('rw-').concat(Process.enumerateRanges('r--'));
send({info: 'ranges=' + ranges.length + ' pid=' + Process.id});
var idx = 0;
var timer = setInterval(function() {
    var t0 = Date.now();
    while (idx < ranges.length && Date.now() - t0 < 120) { scan(ranges[idx]); idx++; }
    if (idx >= ranges.length) { clearInterval(timer); send({done: true, n: N}); }
}, 40);
"""


def sh(*args, timeout=90):
    return subprocess.run([ADB, "-s", DEV] + list(args), capture_output=True,
                          timeout=timeout).stdout


def tap(x, y, wait=1.5):
    sh("shell", "input", "tap", str(x), str(y))
    time.sleep(wait)


def shot(name):
    p = EV / f"lh_{name}.png"
    open(p, "wb").write(sh("exec-out", "screencap", "-p", timeout=60))
    return Image.open(p).convert("RGB")


def dark_ratio(im):
    w, h = im.size
    c = im.crop((w // 4, h // 3, 3 * w // 4, 2 * h // 3)).resize((40, 24))
    px = list(c.getdata())
    return sum(1 for p in px if sum(p) / 3 < 75) / len(px)


def harvest_now(tag):
    pids = sh("shell", "pidof", BD).decode().split()
    pids += sh("shell", "pidof", BD + ":black").decode().split()
    total = 0
    for pid in pids:
        try:
            pid = int(pid)
        except ValueError:
            continue
        try:
            dev = frida.get_device_manager().add_remote_device("127.0.0.1:27042")
            s = dev.attach(pid)
        except Exception as e:
            print(f"[!] attach {pid}: {type(e).__name__}", flush=True)
            continue
        saved = {"n": 0, "fin": False}

        def on_message(m, d, saved=saved, pid=pid):
            p = m.get("payload", {})
            if m.get("type") == "error":
                return
            if not isinstance(p, dict):
                return
            if p.get("done"):
                saved["fin"] = True
                print(f"[*] pid{pid} 扫完 命中{p['n']}", flush=True)
            if "info" in p:
                print(f"[*] pid{pid} {p['info']}", flush=True)
            if "n" in p and d:
                fn = OUT / f"lv_{tag}_{saved['n']:02d}.dex"
                fn.write_bytes(d)
                saved["n"] += 1
                print(f"[DUMP] {fn.name} {p['size']}B", flush=True)

        sc = s.create_script(JS)
        sc.on("message", on_message)
        sc.load()
        t0 = time.time()
        while not saved["fin"] and time.time() - t0 < 200:
            time.sleep(1)
        try:
            s.detach()
        except Exception:
            pass
        total += saved["n"]
    return total


def main():
    print("[1] 驱动周期 …", flush=True)
    sh("shell", "am", "force-stop", BD)
    time.sleep(3)
    sh("shell", "am", "start", "-n", f"{BD}/top.niunaijun.blackdex.view.base.WelcomeActivity")
    time.sleep(9)
    tap(1280, 115, 2)
    sh("shell", "input", "text", "rokid")
    time.sleep(3)
    tap(1000, 655, 3)
    t0 = time.time()
    escaped = False
    while time.time() - t0 < 420:
        im = shot("cyc")
        if time.time() - t0 > 90 and dark_ratio(im) > 0.5 and not escaped:
            print("[2] 自救 …", flush=True)
            tap(1280, 1120, 3)
            sh("shell", "input", "swipe", "500", "650", "500", "650", "1200")
            time.sleep(3)
            tap(1380, 895, 5)
            escaped = True
            t0 = time.time() + 300
            continue
        if escaped and dark_ratio(im) < 0.3:
            time.sleep(4)
            break
        time.sleep(10)
    print("[3] 多候选开面板 …", flush=True)
    opened = False
    for cx, cy in [(950, 653), (700, 655), (520, 655), (950, 545), (1280, 655)]:
        tap(cx, cy, 3)
        im = shot("dlg")
        dr = dark_ratio(im)
        print(f"    候选({cx},{cy}) 暗比{dr:.2f}", flush=True)
        if dr > 0.35:
            opened = True
            break
    if not opened:
        print("[!] 本周期面板未开(可能脱壳失败), 重试", flush=True)
        return 99
    print("[4] 开窗期双进程收割 …", flush=True)
    n = harvest_now("w")
    print(f"[终] 收割 {n} 片", flush=True)


if __name__ == "__main__":
    for attempt in range(4):
        rc = main()
        if rc == 0:
            sys.exit(0)
        if rc != 99:
            sys.exit(rc)
    sys.exit(1)
