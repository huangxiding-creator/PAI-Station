"""减法智能（提案第 24 章④）：时间显微镜 / Stop-Doing / 信息断舍离 / 产品自减。

加法做不过 SaaS，减法只有最懂你的本地系统能做——账本证明的立场。
"""

_DEEPWORK = ("winword.exe", "idea64.exe", "code.exe", "wps.exe", "excel.exe",
             "powerpnt.exe", "xmind.exe")
_DISTRACT = ("chrome.exe", "edge.exe", "wechat.exe", "qq.exe", "douyin",
             "bilibili", "taobao", "jd.exe")


def time_flow_microscope(app_minutes: dict) -> dict:
    """应用时长 → 时间流向：深工作/分心/专注比/最大分心源。"""
    deep = sum(v for k, v in app_minutes.items() if k.lower() in _DEEPWORK)
    distract = sum(v for k, v in app_minutes.items()
                   if k.lower() in _DISTRACT)
    total = sum(app_minutes.values()) or 1
    top = max(((k, v) for k, v in app_minutes.items()
               if k.lower() in _DISTRACT), key=lambda kv: kv[1],
              default=("-", 0))
    return {"deep_work_min": deep, "distraction_min": distract,
            "top_distraction": top[0],
            "focus_ratio": round(deep * 100 / total)}


def stop_doing_list(items: list) -> list:
    """高频（≥20 次）+ 已有自动化路径的任务 → 建议停做清单。"""
    return [i["task"] for i in items
            if i.get("times", 0) >= 20 and i.get("auto_available")]


def declutter_info(sources: list) -> list:
    """90 天未读的信息源 → 断舍离候选（本月读过的绝不建议删）。"""
    return [s["source"] for s in sources if s.get("last_read_days", 0) > 90]


def zero_use_features(features: list) -> list:
    """90 天零用功能 → 裁撤评审（产品自减：不是加功能，是删功能）。"""
    return [f for f in features if f.get("days_since_use", 0) >= 90]
