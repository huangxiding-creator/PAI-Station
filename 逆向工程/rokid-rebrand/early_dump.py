# -*- coding: utf-8 -*-
"""early_dump.py — 超早期 dex 快扫（300/800/1500/2500ms）+ 全谱杀手拦截
逻辑：易盾必须先解密 dex 才能跑校验 → 死前窗口内 dex 必然存在
"""
import os
import sys
import time

import frida

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
OUT = r"E:\AI-Station\逆向工程\rokid-rebrand\dump"
os.makedirs(OUT, exist_ok=True)

JS = r"""
var found = {};
var waveN = 0;

// === 全谱杀手拦截 ===
['kill', 'killpg', 'tgkill', 'pthread_kill'].forEach(function(fn) {
    var addr = Module.findExportByName('libc.so', fn);
    if (!addr) return;
    try {
        Interceptor.attach(addr, {
            onEnter: function(args) {
                var sig = (fn === 'tgkill') ? args[2].toInt32() :
                          (fn === 'pthread_kill') ? args[1].toInt32() :
                          (fn === 'raise') ? args[0].toInt32() : args[1].toInt32();
                if (sig === 9 || sig === 6 || sig === 15 || sig === 1 || sig === 2) {
                    send('[K] 拦截 ' + fn + ' sig=' + sig);
                    for (var i = 0; i < 4; i++) args[i] = ptr(0);
                    args[0] = ptr(0);  // pid=0 无效 → 调用失败
                }
            }
        });
    } catch (e) {}
});
['_exit', 'exit', '_Exit', 'abort'].forEach(function(fn) {
    var addr = Module.findExportByName('libc.so', fn);
    if (!addr) return;
    try {
        Interceptor.replace(addr, new NativeCallback(function(code) {
            send('[K] 拒绝 ' + fn + '(' + code + ')');
        }, 'void', ['int']));
    } catch (e) {}
});
// syscall 直接退出
var sysaddr = Module.findExportByName('libc.so', 'syscall');
if (sysaddr) {
    Interceptor.attach(sysaddr, {
        onEnter: function(args) {
            var nr = args[0].toInt32();
            if (nr === 94 || nr === 93) {  // exit_group/exit
                send('[K] 拦截 syscall(' + nr + ')');
                args[0] = ptr(-1);
            }
        }
    });
}
// Java 层
Java.perform(function() {
    var Sys = Java.use('java.lang.System');
    Sys.exit.implementation = function(c) { send('[K] 拒绝 System.exit(' + c + ')'); };
    var Proc = Java.use('android.os.Process');
    Proc.killProcessQuietly.implementation = function() { send('[K] 拒绝 killProcessQuietly'); };
    Proc.killProcess.implementation = function() { send('[K] 拒绝 killProcess'); };
    send('[K] 全谱拦截就绪');

    // === 超早期四波扫 ===
    function scanWave(delay) {
        setTimeout(function() {
            waveN++;
            var N = 0;
            function scan(r) {
                var file = r.file ? r.file.path : '';
                if (file && file.indexOf('/memfd:') !== 0) return;
                if (r.size > 600000000 || r.size < 4096) return;
                var CHUNK = 0x80000;
                for (var off = 0; off + 0x70 <= r.size; off += CHUNK - 0x100) {
                    var len = Math.min(CHUNK, r.size - off);
                    try {
                        var buf = Memory.readByteArray(r.base.add(off), len);
                        var u8 = new Uint8Array(buf);
                        for (var i = 0; i + 0x70 <= u8.length; i++) {
                            if (u8[i]===0x64&&u8[i+1]===0x65&&u8[i+2]===0x78&&u8[i+3]===0x0a) {
                                var fis=(u8[i+0x20])|(u8[i+0x21]<<8)|(u8[i+0x22]<<16)|(u8[i+0x23]<<24);
                                var sis=(u8[i+0x38])|(u8[i+0x39]<<8)|(u8[i+0x3a]<<16)|(u8[i+0x3b]<<24);
                                var hsz=(u8[i+0x24])|(u8[i+0x25]<<8)|(u8[i+0x26]<<16)|(u8[i+0x27]<<24);
                                if (sis>0&&sis<2000000&&fis>=0x70&&fis<0x8000000&&hsz===0x70) {
                                    var addr=r.base.add(off+i); var key=''+addr;
                                    if (!found[key]) { found[key]=true;
                                        try { send({w:waveN,size:fis}, Memory.readByteArray(addr,fis)); N++; } catch(e){}
                                    }
                                    i += fis-1;
                                }
                            }
                        }
                    } catch (e) {}
                }
            }
            var ranges = Process.enumerateRanges('r--');
            for (var i = 0; i < ranges.length; i++) { try { scan(ranges[i]); } catch(e){} }
            send({wave_done: waveN});
        }, delay);
    }
    scanWave(300);
    scanWave(800);
    scanWave(1500);
    scanWave(2500);
    scanWave(4000);
    scanWave(6000);
    send('[S] 波次排程: 0.3/0.8/1.5/2.5/4/6s');
});
"""


def main():
    secs = int(sys.argv[1]) if len(sys.argv) > 1 else 60
    dev = frida.get_device_manager().add_remote_device("127.0.0.1:27042")
    pid = dev.spawn(["com.rokid.sprite.aiapp"])
    print("[*] spawned", pid, flush=True)
    session = dev.attach(pid)
    state = {"dex": 0}

    def on_message(m, d):
        p = m.get("payload", {})
        if isinstance(p, str):
            print(p, flush=True)
            return
        if m.get("type") == "error":
            return
        if not isinstance(p, dict):
            return
        if p.get("wave_done"):
            print(f"[*] 波{p['wave_done']}完 (累计{state['dex']}片)", flush=True)
        if "size" in p and d and p["size"] > 50000:
            fn = os.path.join(OUT, "ed_%02d.dex" % state["dex"])
            open(fn, "wb").write(d)
            state["dex"] += 1
            print(f"[✓✓DUMP] {fn} {p['size']}B", flush=True)

    script = session.create_script(JS)
    script.on("message", on_message)
    script.load()
    dev.resume(pid)
    print(f"[*] resumed; {secs}s", flush=True)
    t0 = time.time()
    while time.time() - t0 < secs:
        time.sleep(1)
    import subprocess
    alive = subprocess.run(
        ["e:/AI-Station/rea-tools/platform-tools/adb.exe", "-s", "emulator-5554",
         "shell", "pidof", "com.rokid.sprite.aiapp"],
        capture_output=True).stdout.decode().strip()
    print(f"[*] 终局: 进程={'活! ' + alive if alive else '死'} dex={state['dex']}", flush=True)


if __name__ == "__main__":
    sys.exit(main())
