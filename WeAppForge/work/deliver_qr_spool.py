# -*- coding: utf-8 -*-
"""把修复版体验码投进桥出站发件箱（微信送达：文字+图片）。"""
import json
from pathlib import Path
import datetime

SPOOL = Path.home() / ".wechat-claude-code" / "outbound-spool"
SPOOL.mkdir(parents=True, exist_ok=True)
item = SPOOL / ("mp-qr-fix1-" + datetime.datetime.now().strftime("%H%M%S") + ".json")
item.write_text(json.dumps({
    "text": ("【总包AI顾问·体验版修复码】长按这张图→识别小程序码即可打开"
             "（打开后若提示域名/调试，点右上角「···」→开发调试→打开）。"
             "页面能显示就说明修好了，有问题不用截图，我这边雷达在盯。"),
    "file": "E:/AI-Station/WeAppForge/work/qr_trial_fix1.jpg",
    "created_at": datetime.datetime.now().isoformat(timespec="seconds"),
}, ensure_ascii=False, indent=2), encoding="utf-8")
print("SPOOLED", item)
