# -*- coding: utf-8 -*-
"""viewtree.py — 运行时 View 树遍历：找底导容器/Tab 数据源（单会话一击）"""
import sys
import time

import frida

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

JS = r"""
Java.perform(function() {
    send('[*] walking view tree');
    var View = Java.use('android.view.View');
    var ViewGroup = Java.use('android.view.ViewGroup');
    var ActivityThread = Java.use('android.app.ActivityThread');

    function walk(v, depth, path) {
        if (depth > 14) return;
        var cls = v.getClass().getName();
        var id = '';
        try { id = '' + v.getId(); } catch (e) {}
        var txt = '';
        try {
            if (cls.indexOf('TextView') !== -1 || cls.indexOf('Button') !== -1 || cls.indexOf('CheckedTextView') !== -1) {
                txt = '' + Java.cast(v, Java.use('android.widget.TextView')).getText();
            }
        } catch (e) {}
        var interesting = cls.indexOf('rokid') !== -1 || cls.indexOf('BottomNav') !== -1 ||
                          cls.indexOf('TabLayout') !== -1 || cls.indexOf('NavBar') !== -1 ||
                          (txt && txt.length > 0 && txt.length < 20) ||
                          cls.indexOf('NavigationBar') !== -1 || cls.indexOf('Pager') !== -1;
        if (interesting || depth <= 4) {
            send({d: depth, p: path.substring(0, 100), cls: cls.substring(0, 60), id: id, txt: ('' + txt).substring(0, 24)});
        }
        if (v.getClass().getName().indexOf('ViewGroup') !== -1 || cls.indexOf('Layout') !== -1 || cls.indexOf('ComposeView') !== -1) {
            try {
                var vg = Java.cast(v, ViewGroup);
                var n = vg.getChildCount();
                for (var i = 0; i < n && i < 30; i++) {
                    walk(vg.getChildAt(i), depth + 1, path + '/' + i);
                }
            } catch (e) {}
        }
    }

    // 拿当前 resumed activity 的 decorView
    var at = ActivityThread.currentActivityThread();
    var act = at.getActivity(new Java.use('android.os.Binder()) ' ? 0 : 0); // placeholder
});
"""


def main():
    pid = int(sys.argv[1])
    dev = frida.get_device_manager().add_remote_device("127.0.0.1:27042")
    session = dev.attach(pid)
    lines = []

    def on_message(message, data):
        p = message.get("payload", {})
        if isinstance(p, str):
            print(p, flush=True)
            return
        lines.append(p)
        print("  " * p.get("d", 0) + f"[{p.get('cls','?')}] id={p.get('id','')} txt={p.get('txt','')}", flush=True)

    # 简化 JS：直接用 Application 的 activityLifecycleCallbacks 不可得；
    # 改用 ActivityThread.activities() 反射拿 activity 记录
    JS2 = r"""
    Java.perform(function() {
        var ActivityThread = Java.use('android.app.ActivityThread');
        var at = ActivityThread.currentActivityThread();
        // mActivities 字段
        var f = ActivityThread.class.getDeclaredField('mActivities');
        f.setAccessible(true);
        var map = f.get(at);
        var it = map.values().iterator();
        while (it.hasNext()) {
            var rec = it.next();
            try {
                var af = rec.getClass().getDeclaredField('activity');
                af.setAccessible(true);
                var act = af.get(rec);
                send({activity: act.getClass().getName()});
            } catch (e) {}
        }
    });
    """
    script = session.create_script(JS2)
    script.on("message", on_message)
    script.load()
    time.sleep(3)
    session.detach()


if __name__ == "__main__":
    main()
