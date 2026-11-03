# -*- coding: utf-8 -*-
"""bd_harvest.py — 组合拳：驱动 BlackDex 脱壳周期 → 完成态时附体 blackdex 进程内存收割 dex
用法: python bd_harvest.py          # 全自动循环
"""
import os
import subprocess
import sys
import threading
import time
from pathlib import Path

import frida
from PIL import Image

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ADB = r"E:\AI-Station\rea-tools\platform-tools\adb.exe"
DEV = "emulator-5554"
EV = Path(r"E:\AI-Station\逆向工程\rokid-rebrand\evidence")
OUT = Path(r"E:\AI-Station\逆向工程\rokid-rebrand\dump")
OUT.mkdir(exist_ok=True)
DUMP = "/data/media/0/Download/dexDump"
BD = "top.niunaijun.blackdexa64"


def sh(*args, timeout=90):
    return subprocess.run([ADB, "-s", DEV] + list(args), capture_output=True,
                          timeout=timeout).stdout


def tap(x, y, wait=1.5):
    sh("shell", "input", "tap", str(x), str(y))
    time.sleep(wait)


def shot(name):
    p = EV / f"bh_{name}.png"
    open(p, "wb").write(sh("exec-out", "screencap", "-p", timeout=60))
    return Image.open(p).convert("RGB")


def dialog_dark_ratio(im):
    w, h = im.size
    c = im.crop((w // 4, h // 3, 3 * w // 4, 2 * h // 3)).resize((40, 24))
    px = list(c.getdata())
    return sum(1 for p in px if sum(p) / 3 < 75) / len(px)


def frida_harvest():
    """附体 blackdex 主+容器双进程，扫 r--/rw- 匿名区找 dex 魔数，收割到 OUT/fd_*.dex"""
    pid_out = sh("shell", "pidof", BD).decode().strip()
    if not pid_out:
        print("[!] blackdex 进程不在", flush=True)
        return 0
    total = 0
    for pid in [int(p) for p in pid_out.split()] + [
            int(p) for p in sh("shell", "pidof", BD + ":black").decode().split()]:
        try:
            total += _harvest_pid(pid)
        except Exception as e:
            print(f"[!] pid {pid} 收割失败: {type(e).__name__} {e}"[:120], flush=True)
        if total >= 3:
            break
    return total


def _harvest_pid(pid):
    print(f"[*] 附体 pid={pid} …", flush=True)
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
    var ranges = Process.enumerateRanges('r--').concat(Process.enumerateRanges('rw-'));
    send({ranges: ranges.length});
    var idx = 0;
    var timer = setInterval(function() {
        var t0 = Date.now();
        while (idx < ranges.length && Date.now() - t0 < 120) { scan(ranges[idx]); idx++; }
        if (idx >= ranges.length) { clearInterval(timer); send({done: true, n: N}); }
    }, 40);
    """
    saved = {"n": 0}
    dev = frida.get_device_manager().add_remote_device("127.0.0.1:27042")
    session = dev.attach(pid)

    def on_message(message, data):
        p = message.get("payload", {})
        if not isinstance(p, dict):
            print("   ", p, flush=True)
            return
        if p.get("done"):
            saved["fin"] = True
            print(f"[*] 扫描完成，命中 {p['n']} 片", flush=True)
            return
        if "n" in p and data:
            fn = OUT / f"fd_{p['n']:02d}.dex"
            fn.write_bytes(data)
            saved["n"] += 1
            print(f"[DUMP] {fn.name} {p['size']}B", flush=True)

    script = session.create_script(JS)
    script.on("message", on_message)
    script.load()
    t0 = time.time()
    while not saved.get("fin") and time.time() - t0 < 180:
        time.sleep(1)
    try:
        session.detach()
    except Exception:
        pass
    return saved["n"]


def main():
    # 周期：开始脱壳 → 卡镜像自救 → 完成(面板/卡片态) → frida 收割
    for cycle in range(3):
        print(f"===== 周期 {cycle + 1} =====", flush=True)
        # 确保在列表页
        sh("shell", "am", "force-stop", BD)
        time.sleep(3)
        sh("shell", "am", "start", "-n", f"{BD}/top.niunaijun.blackdex.view.base.WelcomeActivity")
        time.sleep(9)
        tap(1280, 115, 2)
        sh("shell", "input", "text", "rokid")
        time.sleep(3)
        tap(1000, 655, 3)          # 开始脱壳
        print("[*] 脱壳中（卡镜像90s自动自救）…", flush=True)
        t0 = time.time()
        escaped = False
        while time.time() - t0 < 420:
            im = shot("cyc")
            dr = dialog_dark_ratio(im)
            if time.time() - t0 > 90 and dr > 0.5 and not escaped:
                print("[*] 自救：关闭→启动镜像", flush=True)
                tap(1280, 1120, 3)
                sh("shell", "input", "swipe", "500", "650", "500", "650", "1200")
                time.sleep(3)
                tap(1380, 895, 5)
                escaped = True
                t0 = time.time() + 300   # 完成阶段最多5分钟
                continue
            if escaped and dr < 0.3:      # 面板关闭/回到列表 = 周期结束
                time.sleep(5)
                break
            time.sleep(10)
        # 收割窗口：无论面板状态，只要脱壳过，内存里可能有
        print("[*] 附体收割 BlackDex 进程内存 …", flush=True)
        n = frida_harvest()
        if n >= 3:
            print(f"[✓] 收割 {n} 片，成功！", flush=True)
            return 0
        print(f"[*] 本轮仅 {n} 片，重试", flush=True)
    print("[✗] 三周期未收满", flush=True)
    return 1


if __name__ == "__main__":
    sys.exit(main())
