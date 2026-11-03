# -*- coding: utf-8 -*-
"""hook_monitor.py — 终极截胡：钩 BDumpManagerService.noticeMonitor(DumpResult)
转储一到达即捕获；同进程内自动触发脱壳循环（不打断钩子会话）
产物: dump/hm_*.dex 或记录 DumpResult 内的文件路径
"""
import subprocess
import sys
import threading
import time
from pathlib import Path

import frida

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ADB = r"E:\AI-Station\rea-tools\platform-tools\adb.exe"
DEV = "emulator-5554"
OUT = Path(r"E:\AI-Station\逆向工程\rokid-rebrand\dump")
BD = "top.niunaijun.blackdexa64"

JS = r"""
var got = 0;
Java.perform(function() {
    var Svc = Java.use('top.niunaijun.blackbox.core.system.dump.BDumpManagerService');
    // noticeMonitor(DumpResult)
    Svc.noticeMonitor.implementation = function(result) {
        send({hit: 'noticeMonitor'});
        try {
            var fields = result.getClass().getDeclaredFields();
            var info = {};
            for (var i = 0; i < fields.length; i++) {
                var f = fields[i];
                f.setAccessible(true);
                var v = f.get(result);
                var t = '' + (v === null ? 'null' : v.getClass ? v.getClass().getName() : v);
                info[f.getName()] = t.substring(0, 40);
            }
            send({fields: info});
            // 若有 byte[] 字段直接发回
            for (var i = 0; i < fields.length; i++) {
                var f = fields[i];
                f.setAccessible(true);
                var v = f.get(result);
                if (v !== null && '' + v.getClass().getName() === '[B') {
                    send({bytes: f.getName(), len: v.length}, v);
                    got++;
                }
            }
        } catch (e) { send({err: '' + e}); }
        return this.noticeMonitor(result);
    };
    send({ready: 1});
});
// 自动触发循环: 每 90 秒若无新料则点一次 开始脱壳
var timer = setInterval(function() {
    try { Java.perform(function() {
        var Intent = Java.use('android.content.Intent');
        var Runtime = Java.use('java.lang.Runtime');
    }); } catch (e) {}
}, 90000);
"""


def sh(*args, timeout=60):
    return subprocess.run([ADB, "-s", DEV] + list(args), capture_output=True,
                          timeout=timeout).stdout


def trigger_loop(stop):
    """后台触发循环：无新料则点开始脱壳（不 force-stop，保钩子会话）"""
    while not stop.is_set():
        pid = sh("shell", "pidof", BD).decode().strip()
        if not pid:
            sh("shell", "am", "start", "-n",
               f"{BD}/top.niunaijun.blackdex.view.base.WelcomeActivity")
            time.sleep(9)
            sh("shell", "input", "tap", "1280", "115")
            time.sleep(1)
            sh("shell", "input", "text", "rokid")
            time.sleep(2)
        sh("shell", "input", "tap", "1000", "655")
        print("[触发] 点开始脱壳", flush=True)
        stop.wait(90)


def main():
    pid = sh("shell", "pidof", BD).decode().strip().split()[0]
    pid = int(pid)
    print(f"[*] 附体 {BD} pid={pid}，挂 noticeMonitor 钩 …", flush=True)
    dev = frida.get_device_manager().add_remote_device("127.0.0.1:27042")
    session = dev.attach(pid)
    state = {"hits": 0}

    def on_message(m, d):
        p = m.get("payload", {})
        if m.get("type") == "error":
            print("[JS-ERR]", m.get("description", "")[:100], flush=True)
            return
        if not isinstance(p, dict):
            return
        if p.get("ready"):
            print("[*] 钩就位", flush=True)
        if p.get("hit"):
            print(f"[★] noticeMonitor 触发！({time.strftime('%H:%M:%S')})", flush=True)
        if p.get("fields"):
            print("[DumpResult 字段]", p["fields"], flush=True)
        if p.get("bytes") and d:
            fn = OUT / f"hm_{state['hits']:02d}.dex"
            fn.write_bytes(d)
            state["hits"] += 1
            print(f"[✓✓] {fn.name} {p['len']}B 落袋！", flush=True)

    script = session.create_script(JS)
    script.on("message", on_message)
    script.load()

    stop = threading.Event()
    t = threading.Thread(target=trigger_loop, args=(stop,), daemon=True)
    t.start()
    print("[*] 触发循环已开，等 noticeMonitor …", flush=True)
    t0 = time.time()
    while state["hits"] < 3 and time.time() - t0 < 1800:
        time.sleep(2)
    stop.set()
    print(f"[终] 截获 {state['hits']} 片", flush=True)


if __name__ == "__main__":
    sys.exit(main())
