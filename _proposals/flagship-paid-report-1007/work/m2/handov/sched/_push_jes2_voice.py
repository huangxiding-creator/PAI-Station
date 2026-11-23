# -*- coding: utf-8 -*-
"""_push_jes2_voice — 用 9399 端口的活会话直接投 JES2 之声稿 (纯 CDP, 不再折腾)."""
import json, re, sys, time, urllib.request

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
PORT = 9399

# CDP 连接
ver = json.loads(urllib.request.urlopen(f"http://127.0.0.1:{PORT}/json/version", timeout=5).read())
import websocket
browser = websocket.create_connection(ver["webSocketDebuggerUrl"], timeout=25)
bid = [0]
def bcall(method, **params):
    bid[0] += 1
    browser.send(json.dumps({"id": bid[0], "method": method, "params": params}))
    while True:
        m = json.loads(browser.recv())
        if m.get("id") == bid[0]:
            if "error" in m: raise RuntimeError(m["error"])
            return m.get("result", {})

# 读当前 token (从已有标签页)
tabs = bcall("Target.getTargets").get("targetInfos", [])
page_t = next((t for t in tabs if t.get("type") == "page" and "weixin" in t.get("url", "")), None)
token = ""
if page_t:
    m = re.search(r"token=(\d+)", page_t.get("url", ""))
    token = m.group(1) if m else ""
if not token:
    # 从页面 JS 取
    page_ws = None
    for t in (http_json(f"http://127.0.0.1:{PORT}/json", 4) or []):
        if t.get("type") == "page" and "weixin" in t.get("url", ""):
            page_ws = t["webSocketDebuggerUrl"]; break
    if page_ws:
        pw = websocket.create_connection(page_ws, timeout=15)
        pw.send(json.dumps({"id": 1, "method": "Runtime.evaluate",
                            "params": {"expression": "location.href", "returnByValue": True}}))
        while True:
            m = json.loads(pw.recv())
            if m.get("id") == 1:
                mm = re.search(r"token=(\d+)", m.get("result", {}).get("result", {}).get("value", ""))
                token = mm.group(1) if mm else ""
                break
        pw.close()
print("token:", token)
if not token: sys.exit(1)

# 新开标签页: 编辑器
tid = bcall("Target.createTarget", url=f"https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_edit_v2&action=edit&isNew=1&type=77&token={token}")["targetId"]
time.sleep(6)
# 找到新标签页的 ws URL
ws_url = ""
for t in (json.loads(urllib.request.urlopen(f"http://127.0.0.1:{PORT}/json", timeout=5).read())):
    if t.get("id") == tid and t.get("webSocketDebuggerUrl"):
        ws_url = t["webSocketDebuggerUrl"]; break
if not ws_url:
    print("编辑器标签页未找到"); sys.exit(1)
page = websocket.create_connection(ws_url, timeout=25)
pid = [0]
def pcall(method, **params):
    pid[0] += 1
    page.send(json.dumps({"id": pid[0], "method": method, "params": params}))
    while True:
        m = json.loads(page.recv())
        if m.get("id") == pid[0]:
            if "error" in m: raise RuntimeError(str(m["error"])[:120])
            return m.get("result", {})

# 等编辑器加载
for _ in range(20):
    try:
        r = pcall("Runtime.evaluate", expression="document.getElementById('title') ? 1 : 0", returnByValue=True)
        if r.get("result", {}).get("value"): break
    except Exception: pass
    time.sleep(1)
print("编辑器就绪", flush=True)

# 填标题
pcall("Runtime.evaluate", expression="""
document.getElementById('title').focus();
document.execCommand('selectAll', false, null);
document.execCommand('insertText', false, '发布| 《建工司法解释二逐条实务与多立场应对实战研究报告》');
""", returnByValue=True)
time.sleep(1)

# 正文: 逐段 insertText (不用剪贴板)
paragraphs = [
"出品：总包创研院研究团队",
"",
"一部解释，四代演进，六种立场——法释〔2026〕12号二十三条2026年6月30日施行，把建工合同裁判规则推入第四代。《建工司法解释二逐条实务与多立场应对实战研究报告》今天上架：12章、20万字、253页，23条逐条拆解×六立场攻防矩阵×旧案新规翻转推演，三个维度交叉，织成一张每类读者都能对号入座的规则地图。",
"为什么这部解释需要一册「多立场」的书",
"行业对解释二的学习刚需比以往任何一代都迫切，原因不在条文多深，而在立场之多。同一条文，站在国资发包人、非国资发包人、国企总包、非国资总包、分包单位、链条末端施工主体六种立场上，适用的重点、防守的要件、进攻的窗口完全不同——实务圈的普遍感受是：解释二真好，但讲义没法只用一个版本。本书第10章把六立场×23条织成攻防矩阵，国资发包人读哪些条是护身符、非国资总包读哪些条是进攻窗口、分包读哪些条是保命通道——一张矩阵表全部对号入座。",
"全书12章的认知地图",
"第1章四代解释演进定调（23条全景与立法本意，官方发布全文+最高法答记者问定调底本）；第2章合同效力的收缩与扩张；第3章黑白合同的结算主导权；第4章实际施工人的彻底重构（三类主体划分+代位权通道）；第5章转包与违法分包的连带追责；第6章优先受偿权的系统完善（行权期限起算+顺位之争）；第7章无效合同的折价补偿（量价分离+参照结算）；第8章结算与鉴定的联动对决；第9章停窝工损失的突围举证；第10章六立场条款攻防矩阵；第11章旧案新规的翻转推演；第12章管辖程序与存量自救。",
"三类读者，三张地图",
"企业法务与合规读第1、2、12章——规则全景与存量合同自查清单；商务与结算人员读第3、7、8章——结算主导权与折价补偿攻防；项目管理与分包管理者读第4、5、9章——身份重构、连带追责与损失举证；六类立场的决策者直取第10章矩阵，对号入座后再按需回翻主题章。",
"证据纪律：54卷判例切片+官方底本",
"20万字级、253页PDF、12章逐章收编台账。研究弹药：官方发布全文（23条齐）+最高法答记者问定调底本+四代新旧条文对照+君合大成律所专题解析+61篇学术论文摘要汇编，判例语料54卷切片1.7G跨十池收割。每一个案号、金额、条文号均可按章末尾注追溯——253页里没有一句「据介绍」。",
"实际施工人的重构：最值得先读的一章",
"第4章拆解新规最锋利的制度变化：旧规时代笼统的「实际施工人」表述被告别，代之以三类主体划分+代位权通道——层层转包链条末端的队伍还能不能直接告发包人、代位权怎么走、发包人「应当知道」的边界在哪，本书用温州柳秀娟层层转包案、中冶叶圣明参照支付案、十堰伟豪挂靠认定案等十余件真实判例四段式拆解（事实、争点、裁判、启示），再按新规推演结论变化。",
"旧案新规翻转推演：本书最独特的一章",
"第11章把已收录的旧判例放到23条下逐条重演：中冶叶圣明转包审计案在新规下还判得了吗、郑泉涌相对性案的身份之辨、中核二二鉴定攻防案的启动权换位——每一处显式标注「裁判时点为旧法时代，推演为本研究」。这种学法是把新规则的逻辑在真实案卷上过一遍，不是预言，是沙盘。",
"微信搜索「总包AI顾问」小程序，第1章全章免费试读，全本¥698。",
]
for para in paragraphs:
    safe = para.replace("'", "\\'").replace("\\", "\\\\")
    pcall("Runtime.evaluate", expression=f"""
document.querySelector('.ProseMirror, [contenteditable=true], .edui-body-container').focus();
document.execCommand('insertText', false, {json.dumps(para)});
document.execCommand('insertParagraph', false, null);
""", returnByValue=True)
    time.sleep(0.5)

print("正文已注入", flush=True)
time.sleep(2)

# 保存: JS 点保存
r = pcall("Runtime.evaluate", expression="""
(function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent||el.getBoundingClientRect().height>0);}
  var els=document.querySelectorAll('button, .weui-desktop-btn, [role=button], a');
  for (var i=0;i<els.length;i++){
    var t=(els[i].innerText||'').trim();
    if(t==='保存为草稿' && vis(els[i])){ els[i].click(); return 'clicked'; }
  }
  return 'notfound';
})()
""", returnByValue=True)
print("保存:", r.get("result", {}).get("value", ""), flush=True)
time.sleep(8)

# 处理可能的弹窗
for _ in range(6):
    r = pcall("Runtime.evaluate", expression="""
(function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent||el.getBoundingClientRect().height>0);}
  var bs=document.querySelectorAll('button, .weui-desktop-btn, [role=button]');
  var wants=['我知道了','确定','确认','继续发表'];
  for (var w=0;w<wants.length;w++){
    for (var i=0;i<bs.length;i++){
      var t=(bs[i].innerText||'').replace(/\\s+/g,'').trim();
      if(t===wants[w] && vis(bs[i])){ bs[i].click(); return 'ok:'+wants[w]; }
    }
  }
  return '';
})()
""", returnByValue=True)
    v = r.get("result", {}).get("value", "")
    if v:
        print(f"弹窗: {v}", flush=True)
        time.sleep(2)
    else:
        break

# 验证
time.sleep(5)
r = pcall("Runtime.evaluate", expression="""
(function(){
  var xhr = new XMLHttpRequest();
  xhr.open('GET', '/cgi-bin/appmsg?action=list_ex&type=77&token=%s&lang=zh_CN&begin=0&count=20', false);
  xhr.withCredentials = true; xhr.send();
  return xhr.responseText;
})()
""" % token, returnByValue=True)
try:
    items = json.loads(r.get("result", {}).get("value", "[]")).get("app_msg_list") or []
except Exception:
    items = []
hit = any("司法解释二逐条实务" in (it.get("title") or "") for it in items)
print(f"落箱: {'PASS' if hit else 'FAIL'} | 箱内 {len(items)} 条", flush=True)

# 关编辑器标签页
bcall("Target.closeTarget", targetId=tid)
browser.close()
print("[done]", "PASS" if hit else "FAIL")
