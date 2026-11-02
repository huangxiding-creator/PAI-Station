# -*- coding: utf-8 -*-
"""hook_headers.py — Frida 钩 okhttp3 请求头，落盘 evidence/frida_headers.log
用法：python hook_headers.py <秒数>   （期间在 app 里触发请求）
"""
import sys
import time

import frida

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
LOG = r"E:\AI-Station\逆向工程\weread-apk-reverse\evidence\frida_headers.log"

JS = """
Java.perform(function() {
    var Builder = Java.use('okhttp3.Request$Builder');
    Builder.build.implementation = function() {
        var req = this.build();
        try {
            var url = req.url().toString();
            if (url.indexOf('weread.qq.com') !== -1) {
                send('[REQ] ' + url);
                var hs = req.headers();
                send('[HDR]\\n' + hs.toString());
            }
        } catch (e) { send('[ERR] ' + e); }
        return req;
    };
    send('[*] hook installed on okhttp3.Request$Builder.build');
});
"""


def on_message(message, data):
    if message.get("type") == "send":
        line = message["payload"]
        print(line, flush=True)
        with open(LOG, "a", encoding="utf-8") as fh:
            fh.write(line + "\n")


def main():
    secs = int(sys.argv[1]) if len(sys.argv) > 1 else 60
    pid = int(sys.argv[2]) if len(sys.argv) > 2 else None
    dev = frida.get_device_manager().add_remote_device("127.0.0.1:27042")
    session = dev.attach(pid or "com.tencent.weread")
    script = session.create_script(JS)
    script.on("message", on_message)
    script.load()
    print("[*] attached, collecting for %ds ..." % secs, flush=True)
    time.sleep(secs)
    print("[*] done", flush=True)


if __name__ == "__main__":
    sys.exit(main())
