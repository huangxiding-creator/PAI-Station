# -*- coding: utf-8 -*-
"""intent 金标准扩容生成器（09-16 轮 81→219；可复用、幂等、自校验）。

从仓库根运行：python tools/gen_intent_golden.py
本轮贡献 138 行：l1 +93（十类均衡+级联优先级探针+未映射留档）、
reject +33（八个拒绝分支含边界值与非活动块/脏值 fail-closed）、
accept +12（四条恰好过线边界）。
自校验纪律：每行先跑真实 classify()/gate()，任一不匹配 expect 即
退出非零、不写盘；按 name 去重幂等——重复运行不追加重复行，
新增行只须往三个列表里按同款格式加条目。
"""
import json
import sys
from pathlib import Path

sys.path.insert(0, "src")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from paistation.intent.l1_fast import classify
from paistation.intent.reject_gate import gate

FIX = Path("tests/fixtures/intent_golden.jsonl")

# ---------- 追加 l1：81 条（name, sample, expect） ----------
L1_NEW = [
    # project 24 中的 11 条新增（原 13）
    ("cursor-agent", {"process": "Cursor.exe", "title": "agent.ts — repo", "domain": "", "idle_s": 0}, "project"),
    ("webstorm-vue", {"process": "webstorm64.exe", "title": "app.vue - 前端", "domain": "", "idle_s": 0}, "project"),
    ("goland-main", {"process": "goland64.exe", "title": "main.go", "domain": "", "idle_s": 0}, "project"),
    ("windows-terminal", {"process": "WindowsTerminal.exe", "title": "pwsh", "domain": "", "idle_s": 0}, "project"),
    ("pwsh-shell", {"process": "pwsh.exe", "title": "PS>", "domain": "", "idle_s": 0}, "project"),
    ("git-bash", {"process": "git-bash.exe", "title": "MINGW64", "domain": "", "idle_s": 0}, "project"),
    ("python-train", {"process": "python.exe", "title": "train.py", "domain": "", "idle_s": 0}, "project"),
    ("docker-desktop", {"process": "Docker Desktop.exe", "title": "Containers", "domain": "", "idle_s": 0}, "project"),
    ("node-server", {"process": "node.exe", "title": "server.js", "domain": "", "idle_s": 0}, "project"),
    ("gitlab-domain", {"process": "chrome.exe", "title": "CI 流水线", "domain": "gitlab.com", "idle_s": 0}, "project"),
    ("gitee-domain", {"process": "edge.exe", "title": "镜像仓", "domain": "gitee.com", "idle_s": 0}, "project"),
    ("stackoverflow-domain", {"process": "chrome.exe", "title": "how to parse json", "domain": "stackoverflow.com", "idle_s": 0}, "project"),
    ("title-代码", {"process": "notepad++.exe", "title": "订单系统代码 - Notepad++", "domain": "", "idle_s": 0}, "project"),
    ("title-开发", {"process": "foo.exe", "title": "插件开发环境搭建", "domain": "", "idle_s": 0}, "project"),
    ("title-调试", {"process": "chrome.exe", "title": "调试控制台 - DevTools", "domain": "", "idle_s": 0}, "project"),
    ("title-编译", {"process": "msbuild.exe", "title": "编译输出 - Build", "domain": "", "idle_s": 0}, "project"),
    ("title-终端", {"process": "wt.exe", "title": "终端 - Ubuntu (WSL)", "domain": "", "idle_s": 0}, "project"),
    ("title-分支-优先于知乎", {"process": "chrome.exe", "title": "git 分支管理策略 - 知乎", "domain": "", "idle_s": 0}, "project"),
    ("code-优先于bilibili域名", {"process": "Code.exe", "title": "x.py", "domain": "bilibili.com", "idle_s": 0}, "project"),
    ("pycharm-engine", {"process": "pycharm64.exe", "title": "engine.py - proj", "domain": "", "idle_s": 0}, "project"),
    ("powershell-cmd", {"process": "powershell.exe", "title": "PS C:\\>", "domain": "", "idle_s": 0}, "project"),
    ("github-pr", {"process": "chrome.exe", "title": "PR #42 · PAI-Station", "domain": "github.com", "idle_s": 0}, "project"),
    ("idea-exact", {"process": "idea.exe", "title": "UserService.java", "domain": "", "idle_s": 0}, "project"),
    # docs +12（原 8）
    ("et-excel", {"process": "et.exe", "title": "预算表.xlsx", "domain": "", "idle_s": 0}, "docs"),
    ("wpp-ppt", {"process": "wpp.exe", "title": "宣讲.pptx", "domain": "", "idle_s": 0}, "docs"),
    ("winword-contract", {"process": "WINWORD.EXE", "title": "合同审查.docx", "domain": "", "idle_s": 0}, "docs"),
    ("powerpnt", {"process": "POWERPNT.EXE", "title": "汇报.pptx", "domain": "", "idle_s": 0}, "docs"),
    ("acrobat-spec", {"process": "acrobat.exe", "title": "规范.pdf", "domain": "", "idle_s": 0}, "docs"),
    ("obsidian-vault", {"process": "Obsidian.exe", "title": "知识库 - vault", "domain": "", "idle_s": 0}, "docs"),
    ("notion-prd", {"process": "Notion.exe", "title": "产品需求文档", "domain": "", "idle_s": 0}, "docs"),
    ("typora-md", {"process": "Typora.exe", "title": "调研笔记.md", "domain": "", "idle_s": 0}, "docs"),
    ("xmind-arch", {"process": "XMind.exe", "title": "系统架构图", "domain": "", "idle_s": 0}, "docs"),
    ("title-docx", {"process": "foo.exe", "title": "方案.docx - 预览", "domain": "", "idle_s": 0}, "docs"),
    ("title-pdf", {"process": "chrome.exe", "title": "招投标法规.pdf", "domain": "", "idle_s": 0}, "docs"),
    ("title-表格", {"process": "foo.exe", "title": "报价表格", "domain": "", "idle_s": 0}, "docs"),
    # research +11（原 9）
    ("google-search", {"process": "chrome.exe", "title": "Google 搜索", "domain": "google.com", "idle_s": 0}, "research"),
    ("zhihu-q", {"process": "chrome.exe", "title": "如何选型", "domain": "zhihu.com", "idle_s": 0}, "research"),
    ("wikipedia", {"process": "firefox.exe", "title": "维基百科", "domain": "wikipedia.org", "idle_s": 0}, "research"),
    ("csdn-blog", {"process": "chrome.exe", "title": "报错解决", "domain": "csdn.net", "idle_s": 0}, "research"),
    ("juejin", {"process": "chrome.exe", "title": "前端掘金", "domain": "juejin.cn", "idle_s": 0}, "research"),
    ("cnblogs", {"process": "edge.exe", "title": "园子随笔", "domain": "cnblogs.com", "idle_s": 0}, "research"),
    ("arxiv-paper", {"process": "chrome.exe", "title": "1706.03762", "domain": "arxiv.org", "idle_s": 0}, "research"),
    ("duckduckgo", {"process": "chrome.exe", "title": "privacy search", "domain": "duckduckgo.com", "idle_s": 0}, "research"),
    ("tieba-baidu", {"process": "chrome.exe", "title": "贴吧", "domain": "tieba.baidu.com", "idle_s": 0}, "research"),
    ("title-搜索", {"process": "chrome.exe", "title": "百度搜索_工程总承包", "domain": "", "idle_s": 0}, "research"),
    ("title-百科", {"process": "foo.exe", "title": "百度百科", "domain": "", "idle_s": 0}, "research"),
    # chat +8（原 8）
    ("tim-im", {"process": "TIM.exe", "title": "TIM", "domain": "", "idle_s": 0}, "chat"),
    ("lark-im", {"process": "lark.exe", "title": "Lark", "domain": "", "idle_s": 0}, "chat"),
    ("telegram", {"process": "telegram.exe", "title": "Telegram", "domain": "", "idle_s": 0}, "chat"),
    ("discord", {"process": "Discord.exe", "title": "Discord", "domain": "", "idle_s": 0}, "chat"),
    ("title-公众平台", {"process": "chrome.exe", "title": "微信公众平台", "domain": "", "idle_s": 0}, "chat"),
    ("title-消息-wxwork", {"process": "wxwork.exe", "title": "企业微信 - 消息", "domain": "", "idle_s": 0}, "chat"),
    ("title-钉钉", {"process": "foo.exe", "title": "钉钉 - 已连接", "domain": "", "idle_s": 0}, "chat"),
    ("wechat-transfer", {"process": "WeChat.exe", "title": "文件传输助手", "domain": "", "idle_s": 0}, "chat"),
    # thinking +8（原 8）
    ("gemini-domain", {"process": "chrome.exe", "title": "Gemini", "domain": "gemini.google.com", "idle_s": 0}, "thinking"),
    ("kimi-domain", {"process": "chrome.exe", "title": "Kimi", "domain": "kimi.moonshot.cn", "idle_s": 0}, "thinking"),
    ("doubao-domain", {"process": "chrome.exe", "title": "豆包", "domain": "doubao.com", "idle_s": 0}, "thinking"),
    ("yuanbao-domain", {"process": "chrome.exe", "title": "元宝", "domain": "yuanbao.tencent.com", "idle_s": 0}, "thinking"),
    ("metaso-domain", {"process": "chrome.exe", "title": "秘塔", "domain": "metaso.cn", "idle_s": 0}, "thinking"),
    ("poe-domain", {"process": "chrome.exe", "title": "Poe", "domain": "poe.com", "idle_s": 0}, "thinking"),
    ("title-claude", {"process": "chrome.exe", "title": "Claude - 询问", "domain": "", "idle_s": 0}, "thinking"),
    ("title-新对话", {"process": "foo.exe", "title": "新对话 - AI", "domain": "", "idle_s": 0}, "thinking"),
    # leisure +8（原 9）
    ("youku", {"process": "chrome.exe", "title": "优酷", "domain": "youku.com", "idle_s": 0}, "leisure"),
    ("iqiyi", {"process": "chrome.exe", "title": "爱奇艺", "domain": "iqiyi.com", "idle_s": 0}, "leisure"),
    ("netflix", {"process": "edge.exe", "title": "Netflix", "domain": "netflix.com", "idle_s": 0}, "leisure"),
    ("music163-domain", {"process": "chrome.exe", "title": "网易云", "domain": "music.163.com", "idle_s": 0}, "leisure"),
    ("steam-proc", {"process": "steam.exe", "title": "Steam 商店", "domain": "", "idle_s": 0}, "leisure"),
    ("qqmusic-probe", {"process": "qqmusic.exe", "title": "QQ音乐", "domain": "", "idle_s": 0}, "leisure"),
    ("title-电影", {"process": "foo.exe", "title": "电影预告片", "domain": "", "idle_s": 0}, "leisure"),
    ("title-哔哩", {"process": "foo.exe", "title": "哔哩哔哩弹幕网", "domain": "", "idle_s": 0}, "leisure"),
    # meeting +8（原 4）
    ("voov-proc", {"process": "voovmeeting.exe", "title": "VooV Meeting", "domain": "", "idle_s": 0}, "meeting"),
    ("tencent-meeting-proc", {"process": "tencentmeeting.exe", "title": "腾讯会议", "domain": "", "idle_s": 0}, "meeting"),
    ("zoom-domain", {"process": "chrome.exe", "title": "Zoom", "domain": "zoom.us", "idle_s": 0}, "meeting"),
    ("gmeet-domain", {"process": "chrome.exe", "title": "Meet", "domain": "meet.google.com", "idle_s": 0}, "meeting"),
    ("teams-domain", {"process": "edge.exe", "title": "Teams", "domain": "teams.microsoft.com", "idle_s": 0}, "meeting"),
    ("title-会议中", {"process": "foo.exe", "title": "全体员工大会 会议中", "domain": "", "idle_s": 0}, "meeting"),
    ("title-视频会议", {"process": "foo.exe", "title": "视频会议 - 主持", "domain": "", "idle_s": 0}, "meeting"),
    ("wechat-但线上会议-优先级探针", {"process": "WeChat.exe", "title": "线上会议", "domain": "", "idle_s": 0}, "meeting"),
    # system +6（原 5）
    ("taskmgr", {"process": "taskmgr.exe", "title": "任务管理器", "domain": "", "idle_s": 0}, "system"),
    ("control-panel", {"process": "control.exe", "title": "控制面板", "domain": "", "idle_s": 0}, "system"),
    ("mmc-devmgmt", {"process": "mmc.exe", "title": "设备管理器", "domain": "", "idle_s": 0}, "system"),
    ("regedit", {"process": "regedit.exe", "title": "注册表编辑器", "domain": "", "idle_s": 0}, "system"),
    ("services-proc", {"process": "services.exe", "title": "服务", "domain": "", "idle_s": 0}, "system"),
    ("title-设置", {"process": "systemsettings.exe", "title": "设置 - 蓝牙", "domain": "", "idle_s": 0}, "system"),
    # idle +5（原 3）
    ("idle-360", {"process": "Code.exe", "title": "main.py", "domain": "", "idle_s": 360}, "idle"),
    ("idle-600", {"process": "chrome.exe", "title": "B站", "domain": "bilibili.com", "idle_s": 600}, "idle"),
    ("idle-900", {"process": "WeChat.exe", "title": "微信", "domain": "", "idle_s": 900}, "idle"),
    ("idle-1800", {"process": "foo.exe", "title": "", "domain": "", "idle_s": 1800}, "idle"),
    ("idle-恰好300边界", {"process": "wps.exe", "title": "文档", "domain": "", "idle_s": 300}, "idle"),
    # unknown +4（原 2）
    ("idea64-未映射留档", {"process": "idea64.exe", "title": "App.java", "domain": "", "idle_s": 0}, "unknown"),
    ("calc-未映射", {"process": "Calculator.exe", "title": "计算器", "domain": "", "idle_s": 0}, "unknown"),
    ("paint-未映射", {"process": "mspaint.exe", "title": "画图", "domain": "", "idle_s": 0}, "unknown"),
    ("blank-sample", {"process": "", "title": "", "domain": "", "idle_s": 0}, "unknown"),
]

# ---------- 追加 reject：28 条 ----------
R_NEW = [
    ("离席段-午后小憩", {"category": "idle", "duration_min": 20, "confidence": 0.95, "coverage": 0.9, "category_counts": {"idle": 30}}),
    ("离席段-午休", {"category": "idle", "duration_min": 60, "confidence": 0.95, "coverage": 0.95, "category_counts": {"idle": 60}}),
    ("离席段-夜里挂机", {"category": "idle", "duration_min": 240, "confidence": 0.95, "coverage": 0.99, "category_counts": {"idle": 200}}),
    ("离席段-会议忘关", {"category": "idle", "duration_min": 45, "confidence": 0.85, "coverage": 0.9, "category_counts": {"idle": 40, "meeting": 4}}),
    ("时短-闪切窗口", {"category": "chat", "duration_min": 0.3, "confidence": 0.9, "coverage": 0.8, "category_counts": {"chat": 2}}),
    ("时短-一分钟", {"category": "project", "duration_min": 1.0, "confidence": 0.8, "coverage": 0.8, "category_counts": {"project": 5}}),
    ("时短-1.5min", {"category": "docs", "duration_min": 1.5, "confidence": 0.7, "coverage": 0.7, "category_counts": {"docs": 4}}),
    ("时短-边界下1.99", {"category": "research", "duration_min": 1.99, "confidence": 0.72, "coverage": 0.6, "category_counts": {"research": 6}}),
    ("时短-零时长", {"category": "project", "duration_min": 0, "confidence": 0.8, "coverage": 0.8, "category_counts": {"project": 1}}),
    ("置信不足-0.35", {"category": "project", "duration_min": 30, "confidence": 0.35, "coverage": 0.8, "category_counts": {"project": 20}}),
    ("置信不足-0.45", {"category": "docs", "duration_min": 15, "confidence": 0.45, "coverage": 0.7, "category_counts": {"docs": 10}}),
    ("置信不足-0.49", {"category": "research", "duration_min": 10, "confidence": 0.49, "coverage": 0.6, "category_counts": {"research": 8}}),
    ("置信不足-unknown0.3", {"category": "unknown", "duration_min": 25, "confidence": 0.3, "coverage": 0.5, "category_counts": {"unknown": 15}}),
    ("置信不足-缺字段按0", {"category": "chat", "duration_min": 8, "coverage": 0.7, "category_counts": {"chat": 6}}),
    ("离席为主-0.82", {"category": "project", "duration_min": 40, "confidence": 0.8, "coverage": 0.8, "category_counts": {"idle": 41, "project": 9}}),
    ("离席为主-恰好0.8边界", {"category": "docs", "duration_min": 30, "confidence": 0.7, "coverage": 0.7, "category_counts": {"idle": 8, "docs": 2}}),
    ("离席为主-0.9", {"category": "research", "duration_min": 50, "confidence": 0.72, "coverage": 0.6, "category_counts": {"idle": 18, "research": 2}}),
    ("离席为主-挂机下载", {"category": "leisure", "duration_min": 120, "confidence": 0.78, "coverage": 0.7, "category_counts": {"idle": 35, "leisure": 3}}),
    ("离席为主-回神五分钟", {"category": "thinking", "duration_min": 90, "confidence": 0.72, "coverage": 0.65, "category_counts": {"idle": 80, "thinking": 12}}),
    ("混杂-coverage0.2", {"category": "project", "duration_min": 35, "confidence": 0.8, "coverage": 0.2, "category_counts": {"project": 10, "chat": 10, "docs": 10, "research": 10, "leisure": 10}}),
    ("混杂-coverage0.3", {"category": "docs", "duration_min": 25, "confidence": 0.7, "coverage": 0.3, "category_counts": {"docs": 6, "chat": 5, "meeting": 4, "project": 5}}),
    ("混杂-coverage0.39", {"category": "chat", "duration_min": 18, "confidence": 0.9, "coverage": 0.39, "category_counts": {"chat": 8, "project": 7, "system": 5}}),
    ("混杂-五类均摊", {"category": "research", "duration_min": 30, "confidence": 0.72, "coverage": 0.25, "category_counts": {"research": 4, "docs": 4, "thinking": 4, "chat": 4}}),
    ("L2不足-0.55", {"category": "project", "duration_min": 40, "confidence": 0.8, "coverage": 0.8, "category_counts": {"project": 30}, "l2_confidence": 0.55}),
    ("L2不足-0.3", {"category": "docs", "duration_min": 20, "confidence": 0.7, "coverage": 0.7, "category_counts": {"docs": 15}, "l2_confidence": 0.3}),
    ("L2不足-边界下0.59", {"category": "research", "duration_min": 15, "confidence": 0.72, "coverage": 0.6, "category_counts": {"research": 10}, "l2_confidence": 0.59}),
    ("非活动块-null", None),
    ("非活动块-字符串", "not-a-block"),
    ("非活动块-数字", 42),
    ("闸门异常-counts列表", {"category_counts": ["bad"], "duration_min": 10, "confidence": 0.8, "coverage": 0.8}),
    ("闸门异常-counts脏值", {"category": "project", "duration_min": 10, "confidence": 0.8, "coverage": 0.8, "category_counts": {"project": "x"}}),
    ("闸门异常-duration字符串", {"category": "docs", "duration_min": "abc", "confidence": 0.8, "coverage": 0.8, "category_counts": {"docs": 6}}),
    ("闸门异常-coverage字符串", {"category": "chat", "duration_min": 10, "confidence": 0.9, "coverage": "abc", "category_counts": {"chat": 6}}),
]

# ---------- 追加 accept：12 条 ----------
A_NEW = [
    ("project-深度工作45min", {"category": "project", "duration_min": 45, "confidence": 0.8, "coverage": 0.85, "category_counts": {"project": 40, "chat": 5}}),
    ("research-专题30min", {"category": "research", "duration_min": 30, "confidence": 0.72, "coverage": 0.6, "category_counts": {"research": 20, "thinking": 8}}),
    ("docs-写作25min", {"category": "docs", "duration_min": 25, "confidence": 0.7, "coverage": 0.75, "category_counts": {"docs": 30}}),
    ("meeting-整点会议", {"category": "meeting", "duration_min": 60, "confidence": 0.85, "coverage": 0.9, "category_counts": {"meeting": 50, "system": 3}}),
    ("thinking-对话15min", {"category": "thinking", "duration_min": 15, "confidence": 0.72, "coverage": 0.8, "category_counts": {"thinking": 12, "chat": 2}}),
    ("chat-运营沟通", {"category": "chat", "duration_min": 10, "confidence": 0.9, "coverage": 0.55, "category_counts": {"chat": 20, "project": 10}}),
    ("边界-duration恰好2.0", {"category": "project", "duration_min": 2.0, "confidence": 0.8, "coverage": 0.8, "category_counts": {"project": 3}}),
    ("边界-confidence恰好0.5", {"category": "system", "duration_min": 10, "confidence": 0.5, "coverage": 0.6, "category_counts": {"system": 8}}),
    ("边界-coverage恰好0.4", {"category": "leisure", "duration_min": 12, "confidence": 0.78, "coverage": 0.4, "category_counts": {"leisure": 6, "chat": 5, "project": 4}}),
    ("边界-idle占比0.79", {"category": "project", "duration_min": 90, "confidence": 0.8, "coverage": 0.8, "category_counts": {"idle": 79, "project": 21}}),
    ("长跑-3小时浸泡", {"category": "project", "duration_min": 180, "confidence": 0.8, "coverage": 0.9, "category_counts": {"project": 150, "docs": 10, "thinking": 5}}),
    ("混合-0.45过线", {"category": "docs", "duration_min": 22, "confidence": 0.78, "coverage": 0.45, "category_counts": {"docs": 10, "research": 6, "chat": 5}}),
]

# ---------- 自校验 ----------
errors = []
for name, sample, expect in L1_NEW:
    got = classify(sample)["category"]
    if got != expect:
        errors.append(f"l1 {name}: expect={expect} got={got}")
for name, block in R_NEW:
    l2 = block.get("l2_confidence") if isinstance(block, dict) else None
    got = gate(block, l2_confidence=l2)["decision"]
    if got != "irrelevant":
        errors.append(f"reject {name}: got={got}")
for name, block in A_NEW:
    got = gate(block)["decision"]
    if got != "accept":
        errors.append(f"accept {name}: got={got}")

if errors:
    print("SELF-CHECK FAILED, 不写盘：")
    for e in errors:
        print(" ", e)
    sys.exit(1)

orig = FIX.read_text(encoding="utf-8").splitlines()
orig_rows = [json.loads(l) for l in orig if l.strip()]
add = ([{"kind": "l1", "name": n, "sample": s, "expect": e} for n, s, e in L1_NEW]
       + [{"kind": "reject", "name": n, "block": b} for n, b in R_NEW]
       + [{"kind": "accept", "name": n, "block": b} for n, b in A_NEW])
# 幂等护栏：同名行不二跳（重复运行=零追加）
seen = {r["name"] for r in orig_rows}
add = [r for r in add if r["name"] not in seen]
if not add:
    print(f"已是最新：{len(orig_rows)} 行全在位，零追加。")
    sys.exit(0)
out = orig_rows + add
assert len(out) == len(orig_rows) + len(add)
FIX.write_text("\n".join(json.dumps(r, ensure_ascii=False) for r in out) + "\n", encoding="utf-8")
import collections
c = collections.Counter(r["kind"] for r in out)
l1cats = collections.Counter(r["expect"] for r in out if r["kind"] == "l1")
print(f"OK 写盘：总 {len(out)} = 原 {len(orig_rows)} + 新 {len(add)}")
print("构成:", dict(c))
print("l1 分类分布:", dict(l1cats))
