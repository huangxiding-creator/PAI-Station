# -*- coding: utf-8 -*-
"""rapid_harvest.py — 连续收割环：面板暗态期间每45秒一轮双进程扫描，中三片即停
（日志面板扫空无害；文件列表面板弹出后下一轮必中——面板停留期就是驻留窗）
"""
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
                            try { send({n: N, size: fis}, Memory.readByteArray(addr, fis)); N++; }
                            catch (e) {}
                        }
                        i += fis - 1;
                    }
                }
            }
        } catch (e) {}
    }
}
var ranges = Process.enumerateRanges('rw-');
var idx = 0;
var timer = setInterval(function() {
    var t0 = Date.now();
    while (idx < ranges.length && Date.now() - t0 < 120) { try { scan(ranges[idx]); } catch(e){} idx++; }
    if (idx >= ranges.length) { clearInterval(timer); send({done: true, n: N}); }
}, 40);
"""


def sh(*args, timeout=90):
    return subprocess.run([ADB, "-s", DEV] + list(args), capture_output=True,
                          timeout=timeout).stdout


def dark_ratio():
    try:
        p = EV / "rh_now.png"
        open(p, "wb").write(sh("exec-out", "screencap", "-p", timeout=60))
        im = Image.open(p).convert("RGB")
        w, h = im.size
        c = im.crop((w // 4, h // 3, 3 * w // 4, 2 * h // 3)).resize((40, 24))
        px = list(c.getdata())
        return sum(1 for p in px if sum(p) / 3 < 75) / len(px)
    except Exception:
        return 0.0


def harvest_once(round_no):
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
        except Exception:
            continue   # :black 忙时跳过不阻塞
        saved = {"n": 0, "fin": False}

        def on_message(m, d, saved=saved):
            p = m.get("payload", {})
            if not isinstance(p, dict) or m.get("type") == "error":
                return
            if p.get("done"):
                saved["fin"] = True
            if "n" in p and d and p["size"] > 100000:
                fn = OUT / f"rh_{round_no:02d}_{saved['n']:02d}.dex"
                fn.write_bytes(d)
                saved["n"] += 1
                print(f"[DUMP] {fn.name} {p['size']}B", flush=True)

        sc = s.create_script(JS)
        sc.on("message", on_message)
        sc.load()
        t0 = time.time()
        while not saved["fin"] and time.time() - t0 < 100:
            time.sleep(1)
        try:
            s.detach()
        except Exception:
            pass
        total += saved["n"]
    return total


def main():
    print("[*] 连续收割环启动（暗态扫描，中三片停）", flush=True)
    t0 = time.time()
    rounds = 0
    total = 0
    while time.time() - t0 < 1500:
        dr = dark_ratio()
        rounds += 1
        if dr < 0.3:
            alive = sh('shell', 'pidof', BD).decode().strip()
            if not alive:
                sh('shell', 'am', 'start', '-n', BD + '/top.niunaijun.blackdex.view.base.WelcomeActivity')
                time.sleep(8)
                sh('shell', 'input', 'tap', '1280', '115'); time.sleep(1)
                sh('shell', 'input', 'text', 'rokid'); time.sleep(2)
            print(f"[环{rounds}] 无面板 → 触发脱壳", flush=True)
            sh('shell', 'input', 'tap', '1000', '655')
            time.sleep(10)
        print(f"[环{rounds}] 暗比{dr:.2f} → 扫描", flush=True)
        n = harvest_once(rounds)
        total += n
        print(f"[环{rounds}] +{n} 片 (累计{total})", flush=True)
        if total >= 3:
            print(f"[✓] 收满 {total} 片！", flush=True)
            return 0
        time.sleep(20)
    print(f"[终] {total} 片", flush=True)
    return 0 if total >= 3 else 1


if __name__ == "__main__":
    sys.exit(main())
