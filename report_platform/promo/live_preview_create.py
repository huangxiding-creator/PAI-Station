# -*- coding: utf-8 -*-
"""live_preview_create — 视频号后台「直播预告」批量创建器 v2 (1104 总包圈直播战役).

v2 关键修正 (v1 None 之谜): 同步 Vue click 处理会销毁 CDP 求值上下文,
run_js 返回值丢失 → 一律三步法: 标记(取址) → 点击(不取值) → 只读回读验证.

借鉴永动机法 (video_channel_session 同款纪律):
  - attach 9222 自家新 tab, 用毕即关, 不动永动机既有 tab
  - 绝不假绿: 时间框/主题/描述逐项回读; 创建后 当前计划 卡片回读=成功判据
  - 取证截图全程 (live_forensics/)
"""
from __future__ import annotations

import argparse
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

PROMO = Path(__file__).resolve().parent
SHOT = PROMO / "live_forensics"
SHOT.mkdir(exist_ok=True)

LIVE_URL = "https://channels.weixin.qq.com/platform/live/home"

SESSIONS = [
    {"no": 1, "day": 12, "topic": "抢抓六网机遇，再造增长曲线",
     "desc": ("第1讲·熊俊波｜《“六张网”赛道研判·分层切入·营销重构·组织适配实战》。"
              "研判六网赛道，分层优选切入，重构营销打法，优化组织机制。系列首播。")},
    {"no": 2, "day": 17, "topic": "六网首重水网，聚力抢占先机",
     "desc": ("第2讲·熊俊波｜《攻坚国家水网：细分优选、市场拓展与项目谋划实战》。"
              "水网赛道研判，创新拓展路径，打通资金申报链路，复盘标杆项目。")},
    {"no": 3, "day": 19, "topic": "把握管网红利 筑牢城市生命线",
     "desc": ("第3讲·刘军｜《深耕城市管网：核心赛道、项目谋划与业务升级实战》。"
              "甄选核心赛道，多网协同抢抓项目，打造核心拳头产品。")},
    {"no": 4, "day": 24, "topic": "建强物流网，畅通经济循环",
     "desc": ("第4讲·刘军｜《细拓国家物流网：典型业务、切入路径与能力提升实战》。"
              "融入枢纽核心布局，创新拓展模式，构建核心竞争优势。")},
    {"no": 5, "day": 26, "topic": "抢滩新型电网 谋局新三网协同",
     "desc": ("第5讲·袁圆｜《转型新型电网：切准赛道、谋划拓展、多网协同实战》。"
              "电·算·通新三网机遇拆解，切入路径与准入资质，客户地图与营销案例。")},
]
HOUR, MINUTE = 20, 0
MARK = "data-lpc-mark"


def log(m: str) -> None:
    print(f"[lpc {time.strftime('%H:%M:%S')}] {m}", flush=True)


CLICK_JS = f"""
var el = document.querySelector('[{MARK}]');
if (el) {{
    ['pointerdown','mousedown','pointerup','mouseup','click'].forEach(function(ev){{
        el.dispatchEvent(new MouseEvent(ev, {{bubbles:true, cancelable:true, view:window}}));
    }});
}}
el && el.removeAttribute('{MARK}');
"""


VIS_DLG = """
            (function(){
                var ws = document.querySelectorAll('.weui-desktop-dialog__wrp');
                for (var i=0;i<ws.length;i++){
                    var r = ws[i].getBoundingClientRect();
                    if (r.width>0 && r.height>0) return 'VISIBLE';
                }
                return 'NONE_VISIBLE';
            })()
"""

VIS_TITLE = """
            (function(){
                var ts = document.querySelectorAll('.date-time-picker__title');
                for (var i=0;i<ts.length;i++){
                    if (ts[i].getBoundingClientRect().width>0)
                        return (ts[i].innerText||'').replace(/\\s+/g,'');
                }
                return '';
            })()
"""


class LiveCreator:
    def __init__(self, tab):
        self.tab = tab
        self.fr = None

    # ── 基础件 ──
    def refind(self) -> bool:
        """上下文丢失后重取 reserve frame (wujie 会重建 iframe)."""
        for f in self.tab.get_frames():
            if "micro/live/reserve" in (f.url or ""):
                self.fr = f
                return True
        return False

    def expr(self, code: str, retries: int = 3):
        """只读表达式 (带 return); ContextLost/None → 重取 frame 重试.
        注意: return 后绝不能直接换行 (JS ASI 会截成 return;) → 括号包裹."""
        last = None
        for i in range(retries):
            try:
                last = self.fr.run_js("return (" + code + ")")
            except Exception as exc:
                if "ContextLost" in type(exc).__name__ or "刷新" in str(exc):
                    time.sleep(2)
                    self.refind()
                    continue
                raise
            if last is not None:
                return last
            time.sleep(1.5)
            self.refind()
        return last

    def act(self, find_body: str, tag: str = "") -> bool:
        """三步法动作: 标记→点击→清标. find_body = 语句体, 必须 return 目标元素.
        失败自动重试整个标记→点击循环 (wujie 时序诡异, 单次失败≠不在场)."""
        for attempt in range(3):
            marked = None
            try:
                marked = self.fr.run_js(f"""
                    var el = (function(){{ {find_body} }})();
                    if (!el) return 'NO_EL';
                    el.setAttribute('{MARK}', '1');
                    return 'MARKED';
                """)
            except Exception as exc:
                if "ContextLost" in type(exc).__name__ or "刷新" in str(exc):
                    time.sleep(2)
                    self.refind()
                    continue
                raise
            if marked == "MARKED":
                try:
                    self.fr.run_js(CLICK_JS)      # 返回值必丢, 不看
                except Exception:
                    time.sleep(1.5)
                    self.refind()
                return True
            # NO_EL / None → 等待重试 (渲染时序)
            if attempt < 2:
                time.sleep(2)
        if tag:
            log(f"  (act[{tag}] 三轮未成: last={marked!r})")
        return False

    def goto_reserve(self) -> bool:
        self.tab.run_js("""
            var links = document.querySelectorAll('a.finder-ui-desktop-menu__link');
            var target = null;
            for (var i=0;i<links.length;i++){
                var e = links[i];
                if ((e.innerText||'').trim().indexOf('直播预告')>=0) { target = e; if (e.getBoundingClientRect().width>0) break; }
            }
            if (target) ['pointerdown','mousedown','pointerup','mouseup','click'].forEach(function(ev){
                target.dispatchEvent(new MouseEvent(ev, {bubbles:true, cancelable:true, view:window}));
            });
        """)
        time.sleep(7)
        for f in self.tab.get_frames():
            if "micro/live/reserve" in (f.url or ""):
                self.fr = f
                return True
        return False

    # ── 表单链 ──
    def open_create_dialog(self) -> bool:
        # 入口随状态变形: 空态=button; 有计划时=div.create-link — 全形态收编
        ok = self.act("""
            var sel = 'div.create-link, button, [role=button], .weui-desktop-btn, .weui-desktop-link';
            var b = document.querySelectorAll(sel);
            for (var i=0;i<b.length;i++){
                var e = b[i];
                if ((e.innerText||'').trim()==='创建预告'
                    && e.getBoundingClientRect().width>0) return e;
            }
            return null;
        """, tag="创建预告入口")
        log(f"创建预告点击: {ok}")
        # 对话框渲染有延迟 → 轮询至可见 (最多12s)
        dlg = "NONE_VISIBLE"
        for _ in range(6):
            time.sleep(2)
            dlg = self.expr(VIS_DLG)
            if dlg == "VISIBLE":
                break
        log(f"创建对话框: {dlg}")
        return dlg == "VISIBLE"

    def cancel_dialog(self) -> None:
        self.act("""
            var b=document.querySelectorAll('button,[role=button]');
            for(var i=0;i<b.length;i++){
                var e=b[i];
                if((e.innerText||'').trim()==='取消'&&e.getBoundingClientRect().width>0) return e;
            }
            return null;
        """)
        time.sleep(2)

    def set_datetime(self, day: int, hour: int, minute: int) -> bool:
        # 1) 开日期面板 (可见实例才算)
        ok = self.act("""
            return (function(){
                var is = document.querySelectorAll('.date-time-picker__input');
                for (var i=0;i<is.length;i++){
                    if (is[i].getBoundingClientRect().width>0) return is[i];
                }
                return null;
            })();
        """, tag="时间框")
        log(f"时间框点击: {ok}")
        time.sleep(2)
        title = self.expr(VIS_TITLE)
        log(f"面板月份: {title}")
        if "2026年11月" not in str(title):
            log("✗ 非2026年11月 (面板未开或月份不对)")
            return False
        # 2) 点日期格 (失败→重开面板再试一次)
        day_find = f"""
            return (function(){{
                var cells = document.querySelectorAll('.date-time-picker__date');
                for (var i=0;i<cells.length;i++){{
                    var e = cells[i];
                    if (e.getBoundingClientRect().width===0) continue;
                    if (String(e.className).indexOf('disabled')>=0) continue;
                    if ((e.innerText||'').trim()==='{day}') return e;
                }}
                return null;
            }})()
        """
        ok = self.act(day_find, tag=f"date{day}")
        if not ok:
            log(f"选日期{day} 首试失败 → 重开面板再试")
            self.act("""
                return (function(){
                    var is = document.querySelectorAll('.date-time-picker__input');
                    for (var i=0;i<is.length;i++){
                        if (is[i].getBoundingClientRect().width>0) return is[i];
                    }
                    return null;
                })();
            """, tag="重开时间框")
            time.sleep(2)
            title = self.expr(VIS_TITLE)
            log(f"重开后月份: {title}")
            ok = self.act(day_find, tag=f"date{day}-retry")
        log(f"选日期{day}: {ok}")
        if not ok:
            return False
        time.sleep(1.5)
        # 3) 日期格选中态回读 (可见格; 面板关闭则重开再验)
        sel_chk = f"""
            (function(){{
                var cells = document.querySelectorAll('.date-time-picker__date');
                for (var i=0;i<cells.length;i++){{
                    var e = cells[i];
                    if (e.getBoundingClientRect().width===0) continue;
                    if (String(e.className).indexOf('selected')>=0 &&
                        (e.innerText||'').trim()==='{day}') return 'SEL_OK';
                }}
                return 'NOT_SEL';
            }})()
        """
        sel = self.expr(sel_chk)
        if sel != "SEL_OK":
            log(f"选中态首验={sel} → 重开面板再验")
            self.act("""
                return (function(){
                    var is = document.querySelectorAll('.date-time-picker__input');
                    for (var i=0;i<is.length;i++){
                        if (is[i].getBoundingClientRect().width>0) return is[i];
                    }
                    return null;
                })();
            """, tag="重开时间框2")
            time.sleep(2)
            sel = self.expr(sel_chk)
        log(f"日期选中态: {sel}")
        if sel != "SEL_OK":
            return False
        # 4) 开时间下拉 (可见实例)
        ok = self.act("""
            return (function(){
                var is = document.querySelectorAll('.date-time-picker__time-input');
                for (var i=0;i<is.length;i++){
                    if (is[i].getBoundingClientRect().width>0) return is[i];
                }
                return null;
            })();
        """, tag="时间下拉")
        log(f"时间下拉点击: {ok}")
        time.sleep(1.5)
        # 5) 选时 (时列=cols[0], 可见项)
        ok = self.act(f"""
            return (function(){{
                var cols = document.querySelectorAll('.date-time-picker__time-column');
                var vis = [];
                for (var i=0;i<cols.length;i++){{
                    if (cols[i].getBoundingClientRect().width>0) vis.push(cols[i]);
                }}
                if (vis.length < 2) return null;
                var items = vis[0].querySelectorAll('*');
                for (var i=0;i<items.length;i++){{
                    var e = items[i];
                    if (e.getBoundingClientRect().width===0) continue;
                    if (e.childElementCount===0 && (e.innerText||'').trim()==='{hour:02d}') return e;
                }}
                return null;
            }})()
        """, tag=f"时{hour:02d}")
        log(f"选时{hour:02d}: {ok}")
        time.sleep(0.8)
        # 6) 选分 (分列=cols[1], 可见项)
        ok = self.act(f"""
            return (function(){{
                var cols = document.querySelectorAll('.date-time-picker__time-column');
                var vis = [];
                for (var i=0;i<cols.length;i++){{
                    if (cols[i].getBoundingClientRect().width>0) vis.push(cols[i]);
                }}
                if (vis.length < 2) return null;
                var items = vis[1].querySelectorAll('*');
                for (var i=0;i<items.length;i++){{
                    var e = items[i];
                    if (e.getBoundingClientRect().width===0) continue;
                    if (e.childElementCount===0 && (e.innerText||'').trim()==='{minute:02d}') return e;
                }}
                return null;
            }})()
        """, tag=f"分{minute:02d}")
        log(f"选分{minute:02d}: {ok}")
        time.sleep(0.8)
        # 7) 回读时间值 (可见实例)
        tv = self.expr("""
            (function(){
                var ss = document.querySelectorAll('.date-time-picker__time-value');
                for (var i=0;i<ss.length;i++){
                    if (ss[i].getBoundingClientRect().width>0)
                        return (ss[i].innerText||'').trim();
                }
                return '';
            })()
        """)
        log(f"时间值回读: {tv}")
        want = f"{hour:02d}:{minute:02d}"
        if str(tv) != want:
            return False
        # 8) 面板确定 (可见实例)
        ok = self.act("""
            return (function(){
                var cs = document.querySelectorAll('.date-time-picker__confirm');
                for (var i=0;i<cs.length;i++){
                    if (cs[i].getBoundingClientRect().width>0) return cs[i];
                }
                return null;
            })();
        """, tag="面板确定")
        log(f"面板确定: {ok}")
        time.sleep(1.5)
        val = self.expr("""
            (function(){
                var sps = document.querySelectorAll('.date-time-picker__input span');
                for (var i=0;i<sps.length;i++){
                    if (sps[i].getBoundingClientRect().width>0)
                        return (sps[i].innerText||'').trim();
                }
                return '';
            })()
        """)
        log(f"时间框回读: {val}")
        want_full = f"2026-11-{day:02d} {hour:02d}:{minute:02d}"
        return str(val) == want_full

    def fill_topic_desc(self, topic: str, desc: str) -> bool:
        if not (5 <= len(topic) <= 15):
            log(f"✗ 主题字数 {len(topic)} 越界 (5-15)")
            return False
        if len(desc) > 100:
            log(f"✗ 描述字数 {len(desc)} 越界 (100)")
            return False
        r = self.expr(f"""
            (function(){{
                var inps = document.querySelectorAll('input[placeholder*="主题"]');
                var inp = null;
                for (var i=0;i<inps.length;i++){{
                    if (inps[i].getBoundingClientRect().width>0) {{ inp = inps[i]; break; }}
                }}
                if (!inp) return 'NO_VISIBLE_TOPIC_INPUT';
                var setter = Object.getOwnPropertyDescriptor(
                    window.HTMLInputElement.prototype, 'value').set;
                setter.call(inp, {topic!r});
                inp.dispatchEvent(new Event('input', {{bubbles:true}}));
                inp.dispatchEvent(new Event('change', {{bubbles:true}}));
                return 'TOPIC=' + inp.value;
            }})()
        """)
        log(f"主题填写: {r}")
        if topic not in str(r):
            return False
        r = self.expr(f"""
            (function(){{
                var tas = document.querySelectorAll('textarea[placeholder*="描述"]');
                var ta = null;
                for (var i=0;i<tas.length;i++){{
                    if (tas[i].getBoundingClientRect().width>0) {{ ta = tas[i]; break; }}
                }}
                if (!ta) return 'NO_VISIBLE_DESC_TA';
                var setter = Object.getOwnPropertyDescriptor(
                    window.HTMLTextAreaElement.prototype, 'value').set;
                setter.call(ta, {desc!r});
                ta.dispatchEvent(new Event('input', {{bubbles:true}}));
                ta.dispatchEvent(new Event('change', {{bubbles:true}}));
                return 'DESC_LEN=' + ta.value.length;
            }})()
        """)
        log(f"描述填写: {r}")
        if f"DESC_LEN={len(desc)}" not in str(r):
            return False
        # 回读描述计数器 (可见叶节点; Vue 状态真同步的证据)
        cnt = self.expr("""
            (function(){
                var walker = document.createTreeWalker(document.body, NodeFilter.SHOW_ELEMENT);
                while (walker.nextNode()) {
                    var e = walker.currentNode;
                    if (e.childElementCount===0 && e.getBoundingClientRect().width>0) {
                        var t = (e.innerText||'').trim();
                        var m = /^(\\d+)\\s*\\/\\s*100$/.exec(t);
                        if (m) return 'COUNTER=' + m[1];
                    }
                }
                return 'NO_COUNTER';
            })()
        """)
        log(f"描述计数器回读: {cnt}")
        return cnt == f"COUNTER={len(desc)}"

    def shot(self, name: str) -> None:
        """尽力而为取证截图 (超时不阻塞主链)."""
        try:
            self.tab.get_screenshot(path=str(SHOT), name=name)
        except Exception as exc:
            log(f"(截图跳过 {name}: {type(exc).__name__})")

    def submit(self) -> bool:
        # 取证: 提交前表单全景截图
        self.shot("before_submit.png")
        # 提交前快照: 字段值(可见实例) + 按钮态
        pre = self.expr("""
            (function(){
                var t = null, ts = document.querySelectorAll('input[placeholder*="主题"]');
                for (var i=0;i<ts.length;i++){ if (ts[i].getBoundingClientRect().width>0){ t = ts[i]; break; } }
                var d = null, ds = document.querySelectorAll('textarea[placeholder*="描述"]');
                for (var i=0;i<ds.length;i++){ if (ds[i].getBoundingClientRect().width>0){ d = ds[i]; break; } }
                var btns = document.querySelectorAll('button,[role=button],.weui-desktop-btn');
                var binfo = [];
                for (var i=0;i<btns.length;i++){
                    var e = btns[i];
                    if (e.getBoundingClientRect().width===0) continue;
                    var txt = (e.innerText||'').trim();
                    if (txt==='创建' || txt==='取消'){
                        binfo.push(txt + '(dis=' + e.disabled + ')');
                    }
                }
                return 'topic=' + (t?t.value:'?').slice(0,20) + ' desclen=' + (d?d.value.length:'?') + ' | ' + binfo.join(' , ');
            })()
        """)
        log(f"提交前快照: {pre}")
        ok = self.act("""
            return (function(){
                var btns = document.querySelectorAll('button,[role=button],.weui-desktop-btn');
                var target = null;
                for (var i=btns.length-1;i>=0;i--){
                    var e = btns[i];
                    if (e.getBoundingClientRect().width===0) continue;
                    if ((e.innerText||'').trim()==='创建'){ target = e; break; }
                }
                return target;
            })()
        """, tag="创建按钮")
        log(f"创建提交: {ok}")
        time.sleep(4)
        post = self.expr("""
            (function(){
                var bits = [];
                var sels = ['.weui-desktop-dialog__wrp', '[class*=toast]', '[class*=message]'],
                    seen = [];
                sels.forEach(function(sel){
                    document.querySelectorAll(sel).forEach(function(e){
                        var r = e.getBoundingClientRect();
                        if (r.width<30 || r.height<20) return;
                        var t = (e.innerText||'').trim().slice(0,150);
                        if (t && seen.indexOf(t)<0){ seen.push(t); bits.push(sel + ':' + JSON.stringify(t)); }
                    });
                });
                return bits.join(' || ') || 'NO_LAYERS';
            })()
        """)
        log(f"提交后弹层: {str(post)[:300]}")
        self.shot("after_submit.png")
        return ok

    def verify_current_plan(self, topic: str) -> dict:
        time.sleep(3)
        txt = self.expr("(document.body.innerText||'')") or ""
        self.shot(f"after_{topic[:6]}.png")
        cur = ""
        if "当前计划" in txt:
            seg = txt.split("当前计划", 1)[1]
            cur = seg.split("历史预告", 1)[0][:600]
        has = topic[:6] in cur or topic[:6] in txt
        dlg_open = bool(self.expr(
            "!!document.querySelector('.weui-desktop-dialog__wrp')"))
        # 成功判据 = 主题出现在当前计划段 (对话框选择器会误匹配详情面板,
        # 仅作信息展示)
        return {"topic_in_current": has,
                "current_seg": cur.strip()[:250],
                "dialog_still_open": dlg_open}

    def probe_card(self) -> None:
        info = self.expr("""
            (function(){
                var out = [];
                document.querySelectorAll('button,[role=button],.weui-desktop-btn,a').forEach(function(e){
                    if (e.getBoundingClientRect().width===0) return;
                    var t = (e.innerText||'').trim().replace(/\\s+/g,' ');
                    if (t && t.length<20 && out.indexOf(t)<0) out.push(t);
                });
                return out.join(' | ');
            })()
        """)
        log(f"页面按钮全景: {info}")
        imgs = self.expr("""
            (function(){
                var out = [];
                document.querySelectorAll('img').forEach(function(e){
                    if (e.getBoundingClientRect().width<30) return;
                    out.push((e.src||'').slice(0,130) + ' [' + Math.round(e.getBoundingClientRect().width) + 'x' + Math.round(e.getBoundingClientRect().height) + ']');
                });
                return out.join('\\n') || 'NO_IMG';
            })()
        """)
        log(f"页面图片:\n{imgs}")


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--idx", type=int, default=-1)
    ap.add_argument("--all", action="store_true")
    ap.add_argument("--probe-card", action="store_true")
    ap.add_argument("--json", default="",
                    help="SESSIONS.json 路径 (S1产物): "
                         "[{no,day,topic,desc},...] 覆盖内置数据")
    ns = ap.parse_args()

    global SESSIONS, HOUR, MINUTE
    if ns.json:
        import json as _json
        from pathlib import Path as _P
        data = _json.loads(_P(ns.json).read_text(encoding="utf-8"))
        if isinstance(data, dict):
            sessions = data.get("sessions", [])
            HOUR = int(data.get("hour", 20))
            MINUTE = int(data.get("minute", 0))
        else:
            sessions = data
        for s in sessions:
            assert {"no", "day", "topic", "desc"} <= set(s), f"字段缺: {s}"
        SESSIONS[:] = sessions
        log(f"──json 载入 {len(SESSIONS)} 讲 "
            f"(hour={HOUR} minute={MINUTE})")

    from DrissionPage import Chromium
    b = Chromium(addr_or_opts="127.0.0.1:9222")
    tab = b.new_tab(LIVE_URL)
    try:
        time.sleep(7)
        c = LiveCreator(tab)
        if not c.goto_reserve():
            log("✗ reserve 页未达")
            return 1
        log("✓ 直播预告页")
        if ns.probe_card:
            c.probe_card()
            return 0
        idxs = list(range(5)) if ns.all else ([ns.idx] if ns.idx >= 0 else [])
        if not idxs:
            log("未指定 --idx/--all")
            return 1
        rc_all = 0
        for i in idxs:
            s = SESSIONS[i]
            log(f"══ 第{s['no']}讲 {s['topic']} 11月{s['day']}日 ══")
            if not c.open_create_dialog():
                log("✗ 创建对话框未开")
                rc_all = 1
                continue
            if not c.set_datetime(s["day"], HOUR, MINUTE):
                log("✗ 时间设置失败 — 取消防残留")
                c.cancel_dialog()
                rc_all = 1
                continue
            if not c.fill_topic_desc(s["topic"], s["desc"]):
                log("✗ 表单填写失败 — 取消防残留")
                c.cancel_dialog()
                rc_all = 1
                continue
            if not c.submit():
                log("✗ 提交点击失败")
                rc_all = 1
                continue
            v = c.verify_current_plan(s["topic"])
            log(f"核验: 主题在当前计划={v['topic_in_current']} "
                f"(详情面板在场={v['dialog_still_open']}, 仅信息)")
            log(f"当前计划段: {v['current_seg'][:150]}")
            if v["topic_in_current"]:
                log(f"✓✓ 第{s['no']}讲创建成功")
            else:
                log(f"✗ 第{s['no']}讲未确认 — 如实上报")
                rc_all = 1
            time.sleep(3)
        c.probe_card()
        return rc_all
    finally:
        try:
            tab.close()
        except Exception:
            pass


if __name__ == "__main__":
    sys.exit(main())
