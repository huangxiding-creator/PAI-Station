# -*- coding: utf-8 -*-
"""七主题设计台：每个主题渲染一张「咨询首页 hero + 答案卡」缩略手机屏，供视觉自审。"""
import json

themes = json.load(open("themes.json", encoding="utf-8"))
WD = {1: "周一", 2: "周二", 3: "周三", 4: "周四", 5: "周五", 6: "周六", 7: "周日"}

def panel(t):
    m = t["meta"]
    v = {k: v for k, v in t.items() if not k.startswith("meta")}
    css_vars = "\n".join(f"  --{k.replace('_', '-').lower()}: {val};" for k, val in v.items())
    return f"""
<div class="phone" style="--dummy:0">
 <style>.p{m['key']} {{ {css_vars.replace('--', '--')} }}</style>
 <div class="scr p{m['key']}">
  <div class="hero">
    <div class="hero-grid"></div>
    <div class="hero-glow"></div>
    <div class="brand">总包AI顾问 · {WD[m['weekday']]} {m['name']}</div>
    <div class="hero-t1">工程难题，问总包智库</div>
    <div class="hero-sub">背后是10年沉淀的顶级总包智库</div>
    <div class="chipbox"><span class="chip">EPC 固定总价调价</span><span class="chip">背靠背条款</span><span class="chip">结算审计</span></div>
    <div class="cta">立即咨询 · 每天免费 6 次</div>
    <div class="ticket"><span class="tk-l">今日额度</span><span class="tk-v">6 <i>/ 次</i></span><span class="tk-r">有用/分享/纠错 各+1次</span></div>
  </div>
  <div class="card">
    <div class="q-line"><span class="q-tag">咨询</span><span class="q-txt">EPC 合同下钢材涨价超 5% 能调价吗？</span></div>
    <div class="para">原则上讲，固定总价合同的材料价格风险由承包人承担，但合同约定了调价窗口的，超出部分可主张调整……<span class="cite">[1]</span></div>
    <div class="tldr"><div class="tldr-h">要点速览</div><div class="tldr-i"><b>01</b> 看合同是否约定±5%调差窗口</div><div class="tldr-i"><b>02</b> 情势变更的司法边界：商业风险 vs 不可预见</div></div>
    <div class="pills"><span class="pill p-on">✓ 有用 +1次</span><span class="pill">导出</span><span class="pill">纠错 +1次</span><span class="pill">分享 +1次</span></div>
    <div class="stamp">有用 ✓</div>
  </div>
 </div>
</div>"""

html = """<!DOCTYPE html><html><head><meta charset="utf-8"><style>
* { margin:0; padding:0; box-sizing:border-box; }
body { background:#111; font-family:"Microsoft YaHei",sans-serif; padding:18px; display:flex; flex-wrap:wrap; gap:18px; }
.phone { width:300px; }
.scr { width:300px; height:520px; overflow:hidden; border-radius:14px; position:relative;
  background: var(--deep, #081a36); border:1px solid #333; }
.hero { position:relative; padding:18px 16px 14px; overflow:hidden; }
.hero-grid { position:absolute; inset:0; opacity:.5;
  background-image: linear-gradient(rgba(var(--grid-rgb),.14) 1px, transparent 1px), linear-gradient(90deg, rgba(var(--grid-rgb),.14) 1px, transparent 1px);
  background-size: 24px 24px; }
.hero-glow { position:absolute; top:-70px; left:50%; transform:translateX(-50%); width:340px; height:200px;
  background: radial-gradient(ellipse at center, rgba(var(--glow-rgb),.30), transparent 65%); }
.brand { position:relative; font-size:10px; letter-spacing:2px; color: var(--ink-faint); }
.hero-t1 { position:relative; margin-top:8px; font-size:21px; font-weight:800; color: var(--ink); letter-spacing:1px; }
.hero-sub { position:relative; margin-top:5px; font-size:10.5px; color: var(--ink-dim); }
.chipbox { position:relative; margin-top:10px; display:flex; gap:6px; flex-wrap:wrap; }
.chip { font-size:9.5px; color: var(--ink-dim); border:1px dashed rgba(var(--grid-rgb),.55); padding:4px 8px; border-radius:3px; background: rgba(var(--navy2-rgb),.35); }
.cta { position:relative; margin-top:12px; text-align:center; font-size:13px; font-weight:700; color:#1b1206;
  background: linear-gradient(135deg, var(--accent), var(--accent-deep)); border-radius:6px; padding:10px 0;
  box-shadow: 0 6px 18px rgba(var(--accent-rgb),.32); }
.ticket { position:relative; margin-top:10px; display:flex; align-items:center; justify-content:space-between;
  background: rgba(var(--raise-rgb),.6); border:1px solid rgba(var(--grid-rgb),.35); border-radius:6px; padding:7px 10px;
  border-style: dashed; }
.tk-l { font-size:9px; color: var(--ink-faint); }
.tk-v { font-size:16px; font-weight:800; color: var(--accent-soft); } .tk-v i { font-size:9px; font-style:normal; color: var(--ink-faint); }
.tk-r { font-size:8.5px; color: var(--ink-faint); max-width:110px; text-align:right; }
.card { margin:10px 12px; background: var(--paper); border-radius:8px; padding:12px; position:relative;
  box-shadow: 0 8px 20px rgba(0,0,0,.35); }
.q-line { display:flex; gap:6px; align-items:flex-start; }
.q-tag { font-size:8.5px; background: var(--amber-bg); color: var(--amber-ink); border-left:3px solid var(--accent); padding:2px 5px; border-radius:2px; white-space:nowrap; }
.q-txt { font-size:11.5px; font-weight:700; color:#2a2f3a; }
.para { margin-top:7px; font-size:10px; line-height:1.7; color:#3d4350; }
.cite { color: var(--blue); font-size:8px; vertical-align:super; }
.tldr { margin-top:8px; background: var(--paper-cool); border:1px solid var(--blue-tint); border-radius:6px; padding:8px; }
.tldr-h { font-size:9.5px; font-weight:800; color: var(--blue); letter-spacing:1px; }
.tldr-i { margin-top:4px; font-size:9.5px; color:#3d4350; } .tldr-i b { color: var(--blue); font-size:8.5px; margin-right:4px; }
.pills { margin-top:9px; display:flex; gap:5px; flex-wrap:wrap; }
.pill { font-size:9px; color:#4a5160; border:1px solid var(--paper-edge); background: var(--paper-hi); border-radius:20px; padding:4px 8px; }
.p-on { color:#fff; background: var(--stamp); border-color: var(--stamp); }
.stamp { position:absolute; right:10px; top:44px; transform:rotate(-14deg); color: var(--stamp);
  border:2px solid var(--stamp); border-radius:4px; padding:2px 6px; font-size:11px; font-weight:900; opacity:.85; }
</style></head><body>
""" + "\n".join(panel(t) for t in themes) + "\n</body></html>"

open("bench_themes.html", "w", encoding="utf-8").write(html)
print("bench_themes.html written,", len(themes), "panels")
