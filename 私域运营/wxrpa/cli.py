# -*- coding: utf-8 -*-
"""wxrpa CLI。

用法（在 wxrpa 目录下）：
  py -I cli.py title                          # 读当前聊天标题（连通性冒烟）
  py -I cli.py sessions                       # OCR 会话列表
  py -I cli.py send "文件传输助手" "测试"      # 发送（默认目标，先冒烟再实战）
  py -I cli.py send "黄细丁" "成功了！" --pick 2   # 同名消歧：第 2 个结果
  py -I cli.py send --manual "黄细丁" "内容"  # 主理人在场豁免静默时段
  py -I cli.py activity --rounds 5            # 新消息活动检测
"""
from __future__ import annotations

import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))


def main():
    from wxrpa import engine
    cmd = sys.argv[1] if len(sys.argv) > 1 else "help"
    if cmd == "title":
        print(engine.read_title())
    elif cmd == "sessions":
        print(engine.session_list_text())
    elif cmd == "send":
        manual = "--manual" in sys.argv
        args = [a for a in sys.argv[2:] if not a.startswith("--")]
        chat, text = args[0], args[1]
        pick = "first"
        if "--pick" in sys.argv:
            pick = int(sys.argv[sys.argv.index("--pick") + 1])
        r = engine.send_text(chat, text, disambiguate=pick,
                             quiet_hours_override=manual)
        import json
        print(json.dumps(r, ensure_ascii=False, indent=2))
    elif cmd == "activity":
        rounds = int(sys.argv[sys.argv.index("--rounds") + 1]) if "--rounds" in sys.argv else 1
        print(engine.detect_activity(rounds=rounds))
    else:
        print(__doc__)


if __name__ == "__main__":
    main()
