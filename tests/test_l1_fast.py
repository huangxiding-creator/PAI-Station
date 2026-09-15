"""M7b L1 快通道：银甲虫规则级联移植 + 中文生态扩展（9 类）。"""
from paistation.intent.l1_fast import classify


def _s(process="", title="", domain="", idle_s=0.0):
    return {"process": process, "title": title, "domain": domain,
            "idle_s": idle_s}


def test_idle_beats_all():
    r = classify(_s(process="Code.exe", title="main.py", idle_s=400))
    assert r["category"] == "idle"
    assert r["confidence"] == 0.95


def test_chat_weixin():
    r = classify(_s(process="Weixin.exe", title="微信"))
    assert (r["category"], r["confidence"]) == ("chat", 0.9)


def test_chat_qq_exact_not_qqmusic():
    assert classify(_s(process="QQ.exe"))["category"] == "chat"
    assert classify(_s(process="QQMusic.exe"))["category"] != "chat"


def test_project_vscode():
    r = classify(_s(process="Code.exe", title="main.py - pai"))
    assert (r["category"], r["confidence"]) == ("project", 0.8)


def test_project_github_domain():
    r = classify(_s(process="chrome.exe", title="某仓库", domain="github.com"))
    assert r["category"] == "project"


def test_docs_wps():
    r = classify(_s(process="wps.exe", title="提案 - 文档"))
    assert (r["category"], r["confidence"]) == ("docs", 0.7)


def test_thinking_domain_claude():
    r = classify(_s(process="chrome.exe", domain="claude.ai"))
    assert (r["category"], r["confidence"]) == ("thinking", 0.72)


def test_thinking_title_kimi():
    assert classify(_s(process="chrome.exe",
                       title="Kimi - 推理"))["category"] == "thinking"


def test_research_zhihu():
    r = classify(_s(process="chrome.exe", domain="www.zhihu.com"))
    assert r["category"] == "research"


def test_leisure_bilibili():
    r = classify(_s(process="chrome.exe", domain="bilibili.com"))
    assert (r["category"], r["confidence"]) == ("leisure", 0.78)


def test_meeting_processes_and_priority():
    """会议场景（M7_PLAN 验收四场景之一）：进程/域名/标题三路命中。"""
    assert classify(_s(process="wemeetapp.exe"))["category"] == "meeting"
    assert classify(_s(process="chrome.exe", domain="zoom.us"))["category"] \
        == "meeting"
    # 会议优先于聊天/项目：Zoom 里共享代码仍是会议
    r = classify(_s(process="Zoom.exe", title="main.py 代码评审"))
    assert (r["category"], r["confidence"]) == ("meeting", 0.85)


def test_system_explorer():
    r = classify(_s(process="explorer.exe", title="此电脑"))
    assert (r["category"], r["confidence"]) == ("system", 0.6)


def test_unknown_default():
    r = classify(_s(process="foobar.exe", title="神秘软件"))
    assert (r["category"], r["confidence"]) == ("unknown", 0.3)


def test_priority_chat_over_project_title():
    """聊天优先于项目：微信窗口里聊代码提交仍是聊天。"""
    r = classify(_s(process="WeChat.exe", title="main.py 代码提交"))
    assert r["category"] == "chat"


def test_priority_project_over_docs_title():
    """项目优先于文档：VS Code 里开 docx 仍是编码。"""
    r = classify(_s(process="Code.exe", title="report.docx - 工作"))
    assert r["category"] == "project"


def test_priority_thinking_over_research():
    """AI 站优先于检索：gemini.google.com 不落 google.com 检索。"""
    r = classify(_s(process="chrome.exe", domain="gemini.google.com"))
    assert r["category"] == "thinking"
