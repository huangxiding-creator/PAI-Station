# -*- coding: utf-8 -*-
"""gen_btier_register_ledger.py - build btier_register_ledger.md from measured JSONL (zero fabrication)."""
import json, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = Path(__file__).resolve().parent.parent
rows = [json.loads(l) for l in (HERE / "_raw" / "btier_register_probe.jsonl").read_text(encoding="utf-8").splitlines()]

# final rulings (pass2/pass2b evidence in _raw/btier_register_probe2_retries.jsonl + console logs)
OVERRIDE = {
 101: ("LIT", "pass2: 200/400000B 真题名(gitbook) via direct"),
 121: ("LIT", "pass2: 200/101919B 真题名, challenge-platform仅脚本非拦截 via direct"),
 183: ("LIT", "pass2: 根域 200/108370B 'Welcome to the UNGM' via direct (旧/PublicTender路径已404)"),
 74:  ("BLOCKED_ANTIBOT", "451 风控拒答(直连) - 浏览器腿候选"),
 75:  ("BLOCKED_ANTIBOT", "419 页面过期式反爬(直连) - 浏览器腿候选"),
 201: ("BLOCKED_ANTIBOT", "412 反爬(直连; 注册表已知'反爬412浏览器腿') - 浏览器腿候选"),
 207: ("BLOCKED_ANTIBOT", "567 非标拒答(直连) - 浏览器腿候选"),
 215: ("BLOCKED_ANTIBOT", "412 反爬(直连) - 浏览器腿候选"),
 225: ("BLOCKED_ANTIBOT", "412 反爬(直连) - 浏览器腿候选"),
 210: ("BLOCKED_ANTIBOT", "403'请求异常'(代理)/直连SSL断 - 滑块验证码闸门, 浏览器腿候选"),
 193: ("BLOCKED_ANTIBOT", "http直连403 Forbidden - 浏览器腿候选"),
 198: ("BLOCKED_ANTIBOT", "TCP通但服务端断连无响应(直连) - 浏览器腿候选"),
 192: ("DEAD", "DNS解析失败(getaddrinfo) 当日不可达"),
 203: ("DEAD", "DNS解析失败(getaddrinfo) 当日不可达"),
 116: ("DEAD", "全路由不通(直连SSL EOF+代理502/超时)"),
 145: ("DEAD", "全路由不通(http 502 / https握手超时)"),
 160: ("DEAD", "全路由不通(SSL EOF+502)"),
 195: ("FAIL_HTTP", "GET 405拒(http/https/bulletin子站均405) - 浏览器腿候选"),
 205: ("FAIL_HTTP", "500 服务端错误(直连,http同) - 复测/浏览器腿"),
 199: ("FAIL_HTTP", "SPA壳 200/71B 纯HTTP无内容(Angular壳) - 浏览器腿/接口另探"),
 206: ("FAIL_HTTP", "SPA壳 200/345B 纯HTTP无内容 - 浏览器腿/接口另探"),
 213: ("FAIL_HTTP", "SPA壳 200/552B 纯HTTP无内容(Vue壳, 题名实) - 浏览器腿/接口另探"),
 224: ("FAIL_HTTP", "SPA壳 200/345B 纯HTTP无内容 - 浏览器腿/接口另探"),
 230: ("USER_ACTION", "已有百度BDUSS登录态(secrets/baidu_bduss.ini, 1014收) 页面200但纯HTTP不可验证功能面 - 浏览器腿验证即可点亮"),
}
GATE = {
 15: "免费层注册表单(邮箱) + 邮箱验证; 纯HTTP 403拒 - 需人工注册或提供账号",
 60: "站点503不稳, 注册面未实测 - 复测后定",
 61: "网页服务未实测, 登录/注册面待人工核",
 64: "开源自部署件, 需X账号cookie(非注册站) - 需用户提供X账号cookie或弃用",
 91: "智谱账号手机号登录(zhipu.secret=API key 非web登录态) - 浏览器登录态收割(tencent-captcha-click技能)或人工登录",
 107: "Google OAuth/邮箱注册 - 人工注册",
 109: "扣子账号: 手机号/微信扫码登录 - 人工登录",
 117: "Google OAuth注册 - 人工注册",
 123: "邮箱/Google注册+邮箱验证 - 人工注册",
 125: "申请制表单(FutureHouse Platform) - 人工申请",
 126: "Google账号(生态已有NBLM工厂auth美国02出口可复用) - 本波纯HTTP不点亮, 浏览器腿复用auth",
 127: "邮箱/Google注册 - 人工注册",
 136: "X/xAI账号登录 - 人工登录",
 137: "云产品账号注册/开源自托管二选一 - 人工注册或走开源件",
 141: "kimi账号手机号/微信登录 - 人工登录",
 146: "邮箱/Google注册 - 人工注册",
 151: "谷歌账号 - 生态已有NBLM工厂auth(1020实测26本在册)在役, 本波不重复注册, 纯HTTP不点亮",
 159: "账号注册(邮箱/Google) - 人工注册",
 166: "Qwen账号手机号登录 - 人工登录",
 167: "Google OAuth/邮箱注册 - 人工注册",
 170: "Google/邮箱注册 - 人工注册",
 171: "邮箱注册+人机验证(实测captcha标记) - 人工注册",
 175: "邮箱注册(Elsevier, 人机+邮箱验证; 纯HTTP 403) - 人工注册",
 200: "手机号注册+短信验证码 - 人工注册(或短信码代收)",
 204: "免费注册文献传递(表单+验证码) - 人工注册",
 212: "免费注册(手机/邮箱+验证码) - 人工注册",
 216: "免费注册(表单) - 人工注册",
 230: "已有百度BDUSS登录态 - 浏览器腿验证即可点亮(无需新注册)",
 233: "微信扫码/邮箱注册(实测扫码/微信登录标记) - 人工注册",
}
for r in rows:
    if r["idx"] in OVERRIDE:
        r["verdict"], r["reason"] = OVERRIDE[r["idx"]]
    if r["verdict"] == "USER_ACTION" and r["idx"] in GATE:
        r["gate"] = GATE[r["idx"]]

order = ["LIT", "USER_ACTION", "BLOCKED_ANTIBOT", "FAIL_HTTP", "DEAD", "SKIP"]
import collections
cnt = collections.Counter(r["verdict"] for r in rows)
uniq_lit = len({r["url"] for r in rows if r["verdict"] == "LIT"})
uniq_all = len({r["url"] for r in rows if r["url"]})
lines = []
A = lines.append
A("# B级渠道接入·免费注册波子台账 (free_register 124条, 1026)")
A("")
A("- 用户令: B级渠道全部接入调研渠道 | 本波=免费注册波 (免费宪法在役: 只走免费钥/免费注册/开放数据集, 付费面永不采购)")
A("- 权威源: `btier_plan.json` bucket=free_register 全 124 条 (idx 14-233, 唯一名 123: BASE/HKEX披露易/百度学术 各2条)")
A("- 方法: 纯HTTP零浏览器 (浏览器非必要不开铁律); 直连优先→代理兜底 7895/7890/7891/7893; UA=Chrome124; 探针件 `_scripts/btier_register_probe.py`(pass2件`btier_register_probe2.py`)")
A("- 原始实测: `_raw/btier_register_probe.jsonl` (124行逐站实测) + `_raw/btier_register_probe2_retries.jsonl` (变体重试)")
A("- 密钥纪律: 凭据只内存读用不打印; 本波动用 `secrets/baidu_bduss.ini`(百度指数/爱企查带凭据冒烟) 与既有 metaso 账号态; 未采购任何付费面; 未新建任何付费单")
A("- 铁律遵守: 验证码/人机/短信/邮箱点击/扫码/OAuth 类一律不硬闯, 全部落用户动作清单; 台账只增未删任何文件")
A("")
A("## 结论 (全实测, 零造假)")
A("")
A(f"- attempted = **{len(rows)}** (free_register 124 条逐站真实探针)")
A(f"- lit = **{cnt['LIT']}** (免登录面冒烟通过=真点亮; 唯一站点口径 {uniq_lit}/{uniq_all})")
A(f"- blocked_user_action = **{cnt['USER_ACTION']}** (注册/登录卡点→用户动作清单, 见下)")
A(f"- BLOCKED_ANTIBOT = {cnt['BLOCKED_ANTIBOT']} (反爬/风控拒答→浏览器腿候选, 非用户动作)")
A(f"- FAIL_HTTP = {cnt['FAIL_HTTP']} (SPA壳4+405/500各1, 纯HTTP不可判→浏览器腿/接口另探)")
A(f"- DEAD = {cnt['DEAD']} (当日全路由不通/DNS失败, 复测再判)")
A("")
A("## A. 点亮 63 条 (LIT, 免登录面冒烟通过)")
A("")
A("| idx | 渠道 | 实测面 | 证据 |")
A("|-----|------|--------|------|")
for r in sorted([r for r in rows if r["verdict"] == "LIT"], key=lambda x: x["idx"]):
    A(f'| {r["idx"]} | {r["name"]} | {r["url"]} | {r["reason"]} |')
A("")
A("## B. 用户动作清单 29 条 (USER_ACTION, 注册/登录卡点不硬闯)")
A("")
A("| idx | 渠道 | 注册/登录面 | 卡点与所需动作 |")
A("|-----|------|-------------|----------------|")
for r in sorted([r for r in rows if r["verdict"] == "USER_ACTION"], key=lambda x: x["idx"]):
    A(f'| {r["idx"]} | {r["name"]} | {r["url"]} | {r.get("gate","")} |')
A("")
A("## C. 反爬拦截 21 条 (BLOCKED_ANTIBOT, 浏览器腿候选, 非用户动作)")
A("")
A("| idx | 渠道 | 实测 | 裁定 |")
A("|-----|------|------|------|")
for r in sorted([r for r in rows if r["verdict"] == "BLOCKED_ANTIBOT"], key=lambda x: x["idx"]):
    A(f'| {r["idx"]} | {r["name"]} | {r["url"]} | {r["reason"]} |')
A("")
A("## D. 纯HTTP不可判 6 条 (FAIL_HTTP)")
A("")
A("| idx | 渠道 | 实测 | 裁定 |")
A("|-----|------|------|------|")
for r in sorted([r for r in rows if r["verdict"] == "FAIL_HTTP"], key=lambda x: x["idx"]):
    A(f'| {r["idx"]} | {r["name"]} | {r["url"]} | {r["reason"]} |')
A("")
A("## E. 当日不可达 5 条 (DEAD, 复测再判)")
A("")
A("| idx | 渠道 | 实测 | 裁定 |")
A("|-----|------|------|------|")
for r in sorted([r for r in rows if r["verdict"] == "DEAD"], key=lambda x: x["idx"]):
    A(f'| {r["idx"]} | {r["name"]} | {r["url"]} | {r["reason"]} |')
A("")
A("## F. 特殊凭据账 (掩码)")
A("")
A("- `baidu_bduss.ini`: BDUSS(193位, GM***qW)+STOKEN(65位) — 用于百度指数/爱企查带凭据探针; 爱企查免登录面200点亮; 百度指数页面200但功能面需浏览器腿验证(见用户动作#230)")
A("- metaso: 既有账号(158***89)+api_key(mk-***E4)+kb会话 — 本波免登录面200点亮, 深度功能已有态在库")
A("- zhipu.secret: api_key×2(4a***e0/c5***2k) 为API密钥, 非AutoGLM-Research web登录态(两回事, 勿混)")
A("- 本波零新增密钥零新增账号(纯HTTP探针不落新secret); 全部卡点转用户动作清单")
A("")
A("## G. 后续建议")
A("")
A("1. BLOCKED_ANTIBOT 21条 + FAIL_HTTP 6条 → 下一波浏览器腿批量过闸(DrissionPage@--start-minimized独立口, 逐站冒烟后点亮)")
A("2. USER_ACTION 29条中, 可批量化优先: SSRN/NCPSSD/NSTL/艾瑞/ucdrs(邮箱注册类, 若用户提供邮箱验证点击); rmfyalk/Coze/Kimi/Qwen/AutoGLM(手机短信类, 需用户在场)")
A("3. Gemini/NotebookLM 生态已有谷歌工厂auth, 直接走浏览器腿复用, 勿重复注册")
A("4. DEAD 5条次工作日复测一次再定弃留(数字零造假: 当日不通如实记)")
A("")
out = HERE / "btier_register_ledger.md"
out.write_text("\n".join(lines) + "\n", encoding="utf-8")
print("ledger written:", out, "|", len(lines), "lines")
print("counts:", dict(cnt), "| uniq_lit:", uniq_lit, "/", uniq_all)
