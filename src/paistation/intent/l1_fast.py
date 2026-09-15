"""M7b L1 快通道：银甲虫 classifyActivity 规则级联移植 + 中文生态扩展。

方法论栈第②层：标题/进程/域名/空闲 → 纯本地规则，毫秒级，零 LLM。
置信度沿用银甲虫标定；新增 docs 类（WPS/Office 场景，中文办公刚需）。
嵌入 top-k 召回升级位（xvfeng 双层粗筛）留待 M7c 接 memory 嵌入器。

与银甲虫的差异（有意为之）：无逐采样 idle 值（我们的 AFK 由
presence_stream 迟滞判定），故无「低活跃→思考 0.45」分支；AFK 段
由 segmenter 以 presence.afk 样本显式表达。
"""
from __future__ import annotations

CATEGORIES = {
    "idle": "空闲",
    "chat": "聊天",
    "project": "做项目",
    "docs": "写文档",
    "thinking": "AI 思考",
    "research": "查资料",
    "leisure": "休息娱乐",
    "system": "系统操作",
    "unknown": "未识别",
}

CONFIDENCE = {
    "idle": 0.95, "chat": 0.9, "project": 0.8, "leisure": 0.78,
    "thinking": 0.72, "research": 0.72, "docs": 0.7, "system": 0.6,
    "unknown": 0.3,
}

# 级联顺序即优先级：idle > chat > project > docs > thinking >
# research > leisure > system > unknown
# 进程名精确匹配（防短名误伤：qq 不匹配 qqmusic）
_PROC_EXACT = {
    "chat": frozenset({"qq", "tim"}),
    "project": frozenset({"code", "cmd", "idea", "cursor", "pycharm"}),
    "docs": frozenset({"wps", "et", "wpp", "winword", "excel",
                       "powerpnt"}),
    "system": frozenset({"explorer", "notepad", "taskmgr", "control",
                         "mmc", "regedit"}),
}
# 进程名子串匹配（无歧义的长名）
_PROC_SUBSTR = {
    "chat": ("wechat", "weixin", "dingtalk", "feishu", "lark",
             "telegram", "discord"),
    "project": ("cursor", "pycharm", "webstorm", "goland", "clion",
                "terminal", "powershell", "pwsh", "git", "node",
                "python", "docker"),
    "docs": ("acrobat", "obsidian", "notion", "typora", "xmind"),
    "leisure": ("steam", "cloudmusic", "spotify"),
    "system": ("services", "ms-settings"),
}
# 域名后缀匹配（www. 前缀等）
_DOMAINS = {
    "project": ("github.com", "gitlab.com", "gitee.com",
                "stackoverflow.com"),
    "thinking": ("chatgpt.com", "claude.ai", "gemini.google.com",
                 "openai.com", "kimi.moonshot.cn", "chat.deepseek.com",
                 "doubao.com", "yuanbao.tencent.com", "metaso.cn",
                 "poe.com"),
    "research": ("google.com", "bing.com", "baidu.com",
                 "duckduckgo.com", "zhihu.com", "wikipedia.org",
                 "csdn.net", "juejin.cn", "cnblogs.com", "arxiv.org"),
    "leisure": ("bilibili.com", "youtube.com", "douyin.com", "youku.com",
                "iqiyi.com", "netflix.com", "spotify.com",
                "music.163.com", "steampowered.com"),
}
# 标题关键词（进程/域名都缺席时的兜底信号）
_TITLES = {
    "chat": ("微信", "聊天", "消息", "钉钉", "飞书"),
    "project": ("visual studio", "vscode", "npm", "electron", "node.js",
                "代码", "开发", "编译", "调试", "终端", "仓库", "分支"),
    "docs": (".docx", ".xlsx", ".pptx", ".pdf", "wps", "文档", "表格",
             "幻灯片"),
    "thinking": ("chatgpt", "claude", "gemini", "kimi", "deepseek",
                 "豆包", "元宝", "秘塔", "新对话"),
    "research": ("搜索", "查询", "知乎", "百科", "教程", "指南"),
    "leisure": ("视频", "直播", "游戏", "音乐", "电影", "哔哩"),
    "system": ("任务管理器", "此电脑", "回收站", "设置", "资源管理器"),
}


def _base(process: str) -> str:
    return (process or "").lower().replace(".exe", "").strip()


def _proc_hit(cat: str, process: str) -> bool:
    b = _base(process)
    return b in _PROC_EXACT.get(cat, frozenset()) or \
        any(s in b for s in _PROC_SUBSTR.get(cat, ()))


def _domain_hit(cat: str, domain: str) -> bool:
    d = (domain or "").lower().strip()
    return any(d == x or d.endswith("." + x) for x in _DOMAINS.get(cat, ()))


def _title_hit(cat: str, title: str) -> bool:
    t = (title or "").lower()
    return any(k in t for k in _TITLES.get(cat, ()))


def classify(sample: dict) -> dict:
    """单采样 → {category, label, confidence, reason}。

    sample: {process, title, domain, idle_s}
    """
    idle_s = float(sample.get("idle_s") or 0.0)
    if idle_s >= 300:
        return {"category": "idle", "label": CATEGORIES["idle"],
                "confidence": CONFIDENCE["idle"], "reason": "超过5分钟无输入"}
    process = sample.get("process") or ""
    domain = sample.get("domain") or ""
    title = sample.get("title") or ""
    for cat in ("chat", "project", "docs", "thinking", "research",
                "leisure", "system"):
        if _proc_hit(cat, process):
            return _hit(cat, f"进程={_base(process)}")
        if _domain_hit(cat, domain):
            return _hit(cat, f"域名={domain}")
        if _title_hit(cat, title):
            return _hit(cat, "标题关键词")
    return _hit("unknown", "无规则命中")


def _hit(cat: str, reason: str) -> dict:
    return {"category": cat, "label": CATEGORIES[cat],
            "confidence": CONFIDENCE[cat], "reason": reason}
