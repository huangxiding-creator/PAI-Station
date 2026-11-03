# -*- coding: utf-8 -*-
"""sigspoof_spawn.py — 签名伪装+dex收割二连：
① spawn 竞速装载钩子（PackageManager.getPackageInfo 签名替换为原版证书）
② 伪装通过易盾校验 → 改造版/重签版复活
③ 复活后 App 真进程内 dump 16 片 dex
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
var dumped = 0;
var found = {};

function makeOriginalSignature(SignatureCls) {
    var bytes = Java.use('android.util.Base64').decode(ORIG_CERT_B64, 0);
    return SignatureCls.$new(bytes);
}

Java.perform(function() {
    send('[*] installing signature spoof');
    var PM = Java.use('android.app.ApplicationPackageManager');
    var Signature = Java.use('android.content.pm.Signature');

    // getPackageInfo(String, int) — 覆写 signatures/toCharArray
    PM.getPackageInfo.overload('java.lang.String', 'int').implementation = function(pkg, flags) {
        var info = this.getPackageInfo(pkg, flags);
        try {
            if (pkg === 'com.rokid.sprite.aiapp' && (flags & 64) !== 0) {  // GET_SIGNATURES
                var orig = makeOriginalSignature(Signature);
                info.signatures.value = Java.array('android.content.pm.Signature', [orig]);
                send('[spoof] signatures 替换为原版');
            }
        } catch (e) { send('[spoof-err] ' + e); }
        return info;
    };
    // GET_SIGNATURES_ARGUMENTS = 64; 新版可能用SigningInfo(0x08000000)
    send('[*] spoof ready');

    // ② dex 收割：延迟扫描（等壳解完）
    setTimeout(function() {
        Java.perform(function() {
            send('[*] dex 扫描启动');
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
                            if (u8[i]===0x64 && u8[i+1]===0x65 && u8[i+2]===0x78 && u8[i+3]===0x0a) {
                                var fis=(u8[i+0x20])|(u8[i+0x21]<<8)|(u8[i+0x22]<<16)|(u8[i+0x23]<<24);
                                var sis=(u8[i+0x38])|(u8[i+0x39]<<8)|(u8[i+0x3a]<<16)|(u8[i+0x3b]<<24);
                                var hsz=(u8[i+0x24])|(u8[i+0x25]<<8)|(u8[i+0x26]<<16)|(u8[i+0x27]<<24);
                                if (sis>0&&sis<2000000&&fis>=0x70&&fis<0x8000000&&hsz===0x70) {
                                    var addr=r.base.add(off+i); var key=''+addr;
                                    if (!found[key]) { found[key]=true;
                                        try { send({n:N,size:fis}, Memory.readByteArray(addr,fis)); N++; } catch(e){}
                                    }
                                    i += fis-1;
                                }
                            }
                        }
                    } catch (e) {}
                }
            }
            var ranges = Process.enumerateRanges('r--');
            var idx = 0;
            var timer = setInterval(function() {
                var t0 = Date.now();
                while (idx < ranges.length && Date.now()-t0 < 150) { try { scan(ranges[idx]); } catch(e){} idx++; }
                if (idx >= ranges.length) { clearInterval(timer); send({done: true, n: N}); }
            }, 50);
        });
    }, 12000);
});
"""


def main():
    secs = int(sys.argv[1]) if len(sys.argv) > 1 else 90
    dev = frida.get_device_manager().add_remote_device("127.0.0.1:27042")
    pid = dev.spawn(["com.rokid.sprite.aiapp"])
    print("[*] spawned", pid, flush=True)
    session = dev.attach(pid)
    state = {"dex": 0, "spoof": 0}

    def on_message(m, d):
        p = m.get("payload", {})
        if isinstance(p, str):
            print(p, flush=True)
            if "spoof" in p:
                state["spoof"] += 1
            return
        if m.get("type") == "error":
            print("[JS-ERR]", m.get("description", "")[:120], flush=True)
            return
        if not isinstance(p, dict):
            return
        if p.get("done"):
            print(f"[*] dex 扫完 命中 {p['n']}", flush=True)
            state["fin"] = True
        if "n" in p and d and p["size"] > 50000:
            fn = os.path.join(OUT, "sp_%02d.dex" % state["dex"])
            open(fn, "wb").write(d)
            state["dex"] += 1
            print(f"[✓DUMP] {fn} {p['size']}B", flush=True)

    script = session.create_script(JS_TMPL % CERT_HEX)
    script.on("message", on_message)
    script.load()
    dev.resume(pid)
    print(f"[*] resumed；监控 {secs}s（进程存活+spoof命中+dex）", flush=True)
    t0 = time.time()
    while time.time() - t0 < secs:
        time.sleep(2)
        alive = session.readyState if hasattr(session, "readyState") else True
        try:
            # 进程还活着吗
            if not state.get("fin"):
                pass
        except Exception:
            break
    try:
        print("[*] 进程状态:", dev.enumerate_processes() and "dev-ok", flush=True)
    except Exception:
        pass
    print(f"[*] 收官: spoof={state['spoof']} dex={state['dex']}", flush=True)
    print("[*] 若进程被杀=伪装失败; 若存活=伪装成功!", flush=True)


if __name__ == "__main__":
    sys.exit(main())
