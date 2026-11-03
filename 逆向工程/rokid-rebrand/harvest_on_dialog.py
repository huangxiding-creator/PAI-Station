# -*- coding: utf-8 -*-
"""harvest_on_dialog.py — 持续监听：暗面板一出现立即双进程收割（面板=dex数组驻留窗口）
面板语义判别：自救后的完成弹窗（含dexDump路径栏）才是收割窗；日志面板收割为空则继续等
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
var ranges = Process.enumerateRanges('rw-').concat(Process.enumerateRanges('r--'));
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


def tap(x, y, wait=1.5):
    sh("shell", "input", "tap", str(x), str(y))
    time.sleep(wait)


def shot():
    p = EV / "hd_now.png"
    open(p, "wb").write(sh("exec-out", "screencap", "-p", timeout=60))
    return Image.open(p).convert("RGB")


def dark_ratio(im):
    w, h = im.size
    c = im.crop((w // 4, h // 3, 3 * w // 4, 2 * h // 3)).resize((40, 24))
    px = list(c.getdata())
    return sum(1 for p in px if sum(p) / 3 < 75) / len(px)


def harvest(tag):
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

        def on_message(m, d, saved=saved):
            p = m.get("payload", {})
            if not isinstance(p, dict) or m.get("type") == "error":
                return
            if p.get("done"):
                saved["fin"] = True
            if "n" in p and d and p["size"] > 100000:   # 只要 >100KB 的真弹
                fn = OUT / f"hd_{tag}_{saved['n']:02d}.dex"
                fn.write_bytes(d)
                saved["n"] += 1
                print(f"[DUMP] {fn.name} {p['size']}B", flush=True)

        sc = s.create_script(JS)
        sc.on("message", on_message)
        sc.load()
        t0 = time.time()
        while not saved["fin"] and time.time() - t0 < 150:
            time.sleep(1)
        try:
            s.detach()
        except Exception:
            pass
        total += saved["n"]
    return total


def drive_cycle():
    # 热循环: 不 force-stop(容器保温); 只在 app 不在时冷启
    alive = sh("shell", "pidof", BD).decode().strip()
    if not alive:
        sh("shell", "am", "start", "-n", f"{BD}/top.niunaijun.blackdex.view.base.WelcomeActivity")
        time.sleep(9)
        tap(1280, 115, 2)
        sh("shell", "input", "text", "rokid")
        time.sleep(3)
    # 热态直接点卡片按钮(开始脱壳/脱壳完成位置都在 950-1050,655)
    tap(1000, 655, 2)


def main():
    for attempt in range(4):
        print(f"=== 周期 {attempt + 1} ===", flush=True)
        drive_cycle()
        escaped = False
        dark_since = None
        t0 = time.time()
        harvested_this_cycle = False
        while time.time() - t0 < 480:
            im = shot()
            dr = dark_ratio(im)
            # 卡镜像自救
            if not escaped and time.time() - t0 > 100 and dr > 0.5:
                print("[*] 自救 …", flush=True)
                tap(1280, 1120, 3)
                sh("shell", "input", "swipe", "500", "650", "500", "650", "1200")
                time.sleep(3)
                tap(1380, 895, 5)
                escaped = True
                t0 = time.time() + 300
                continue
            # 面板持续>25s（自救后）→ 收割一次
            if escaped:
                if dr > 0.5:
                    dark_since = dark_since or time.time()
                    if not harvested_this_cycle and time.time() - dark_since > 25:
                        print("[*] 面板窗口 → 收割 …", flush=True)
                        n = harvest(str(attempt))
                        if n >= 3:
                            print(f"[✓] 收割 {n} 片成功", flush=True)
                            return 0
                        print(f"[*] 此窗口 {n} 片（可能还是日志面板）", flush=True)
                        harvested_this_cycle = True
                        dark_since = None
                else:
                    dark_since = None
                    if harvested_this_cycle:
                        break
            time.sleep(8)
    print("[✗] 四周期未收满", flush=True)
    return 1


if __name__ == "__main__":
    sys.exit(main())
