# -*- coding: utf-8 -*-
"""killblock_dump.py — 三合一终击：自杀阻断(kill/_exit 拦截)+双层签名伪装+即窗口dex快扫
"""
import base64
import os
import sys
import time

import frida

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
OUT = r"E:\AI-Station\逆向工程\rokid-rebrand\dump"
os.makedirs(OUT, exist_ok=True)

CERT_DER = open(r"E:\AI-Station\逆向工程\rokid-rebrand\original_cert.der", "rb").read()
CERT_HEX = base64.b64encode(CERT_DER).decode()

JS_TMPL = r"""
var ORIG_CERT_B64 = '%s';
var ORIG_APK = '/data/local/tmp/orig.apk';
var found = {};
var blocked = 0;

Java.perform(function() {
    // === A. 自杀阻断 ===
    ['kill', 'killpg', 'raise'].forEach(function(fn) {
        var addr = Module.findExportByName('libc.so', fn);
        if (!addr) return;
        Interceptor.attach(addr, {
            onEnter: function(args) {
                var pid = args[0].toInt32 ? args[0].toInt32() : 0;
                var sig = (fn === 'raise') ? args[0].toInt32() : args[1].toInt32();
                if (sig === 9 || sig === 15 || sig === 6 || sig === 1) {
                    blocked++;
                    send('[A] 拦截 ' + fn + '(pid=' + pid + ', sig=' + sig + ') ×' + blocked);
                    args[1] = ptr(0);  // sig→0 = 无操作
                    if (fn !== 'raise') args[1] = ptr(0);
                }
            }
        });
    });
    ['_exit', 'exit', 'abort'].forEach(function(fn) {
        var addr = Module.findExportByName('libc.so', fn);
        if (!addr) return;
        Interceptor.replace(addr, new NativeCallback(function(code) {
            blocked++;
            send('[A] 拦截 ' + fn + '(' + code + ') ×' + blocked + ' — 拒绝死亡');
            // 直接返回，不退出
        }, 'void', ['int']));
    });
    send('[A] 自杀阻断就绪');

    // === B. 双层签名伪装 ===
    var PM = Java.use('android.app.ApplicationPackageManager');
    var Signature = Java.use('android.content.pm.Signature');
    PM.getPackageInfo.overload('java.lang.String', 'int').implementation = function(pkg, flags) {
        var info = this.getPackageInfo(pkg, flags);
        try {
            if (pkg === 'com.rokid.sprite.aiapp' && (flags & 64) !== 0) {
                var bytes = Java.use('android.util.Base64').decode(ORIG_CERT_B64, 0);
                info.signatures.value = Java.array('android.content.pm.Signature', [Signature.$new(bytes)]);
                send('[B] L1 喂原证书');
            }
        } catch (e) {}
        return info;
    };
    // open 重定向
    ['openat', 'open', 'fopen'].forEach(function(fname) {
        var addr = Module.findExportByName(null, fname);
        if (!addr) return;
        try {
            Interceptor.attach(addr, {
                onEnter: function(args) {
                    try {
                        var idx = fname === 'open' ? 0 : (fname === 'fopen' ? 0 : 1);
                        var path = args[idx].readCString();
                        if (path && path.indexOf('/base.apk') !== -1 &&
                            path.indexOf('com.rokid.sprite.aiapp') !== -1) {
                            args[idx].writeUtf8String(ORIG_APK);
                        }
                    } catch (e) {}
                }
            });
        } catch (e) {}
    });
    // mmap apk → 也重定向不了 fd；但配合 A 即可
    send('[B] 伪装就绪');

    // === C. 即窗口 dex 快扫（3 秒后即开扫，不等死） ===
    setTimeout(function() { scanWave(1); }, 3000);
    setTimeout(function() { scanWave(2); }, 7000);
    setTimeout(function() { scanWave(3); }, 12000);
    setTimeout(function() { scanWave(4); }, 20000);

    function scanWave(w) {
        var N = 0;
        function scan(r) {
            var file = r.file ? r.file.path : '';
            if (file && file.indexOf('/memfd:') !== 0) return;
            if (r.size > 600000000 || r.size < 4096) return;
            var CHUNK = 0x100000;
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
                                    try { send({w:w,n:N,size:fis}, Memory.readByteArray(addr,fis)); N++; } catch(e){}
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
        send({wave: w, done: true});
    }
    send('[C] 快扫排程 3/7/12/20s');
});
"""


def main():
    secs = int(sys.argv[1]) if len(sys.argv) > 1 else 90
    dev = frida.get_device_manager().add_remote_device("127.0.0.1:27042")
    pid = dev.spawn(["com.rokid.sprite.aiapp"])
    print("[*] spawned", pid, flush=True)
    session = dev.attach(pid)
    state = {"dex": 0, "blocked": 0}

    def on_message(m, d):
        p = m.get("payload", {})
        if isinstance(p, str):
            print(p, flush=True)
            if p.startswith("[A]"):
                state["blocked"] += 1
            return
        if m.get("type") == "error":
            return
        if not isinstance(p, dict):
            return
        if p.get("wave"):
            print(f"[*] 扫描波 {p['wave']} 完", flush=True)
        if "n" in p and d and p["size"] > 50000:
            fn = os.path.join(OUT, "kb_%02d.dex" % state["dex"])
            open(fn, "wb").write(d)
            state["dex"] += 1
            print(f"[✓DUMP] {fn} {p['size']}B", flush=True)

    script = session.create_script(JS_TMPL % CERT_HEX)
    script.on("message", on_message)
    script.load()
    dev.resume(pid)
    print(f"[*] resumed; {secs}s", flush=True)
    t0 = time.time()
    while time.time() - t0 < secs:
        time.sleep(2)
    import subprocess
    alive = subprocess.run(
        ["e:/AI-Station/rea-tools/platform-tools/adb.exe", "-s", "emulator-5554",
         "shell", "pidof", "com.rokid.sprite.aiapp"],
        capture_output=True).stdout.decode().strip()
    print(f"[*] 终局: 进程={'活! ' + alive if alive else '死'} 拦截自杀={state['blocked']} dex={state['dex']}", flush=True)


if __name__ == "__main__":
    sys.exit(main())
