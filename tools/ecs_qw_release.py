# -*- coding: utf-8 -*-
"""提审→发布 一键链（ECS 第一方 API，预备就位待用户令）。

用法:
  python tools/ecs_qw_release.py --status     # 只读：查审态（get_auditstatus 需 auditid）
  python tools/ecs_qw_release.py --submit     # 提审（item_list+测试备注；用户确认真机后才准跑）
  python tools/ecs_qw_release.py --poll       # 轮询审态
  python tools/ecs_qw_release.py --release    # 发布（审核通过后）

铁律: --submit 是对外不可逆动作，必须用户明示；提审→发布期间上传冻结。
auditid 落盘 /opt/qianwen/data/qianwen/audit_id.txt 供 poll/release 复用。
"""
from __future__ import annotations

import sys

sys.path.insert(0, r"E:\AI-Station")
from tools.ecs_qw import run  # noqa: E402

PY = r"""
import json, sys, urllib.request
from qianwen_engine import wechat
tok = wechat._access_token()
def call(path, payload=None, method=None):
    data = json.dumps(payload or {}).encode() if payload is not None else None
    m = method or ("POST" if data is not None else "GET")
    req = urllib.request.Request(
        "https://api.weixin.qq.com/wxa/" + path + "?access_token=" + tok,
        data=data, headers={"Content-Type": "application/json"})
    return json.loads(urllib.request.urlopen(req, timeout=20).read())
cmd = sys.argv[1]
if cmd == "status":
    print(json.dumps(call("get_auditstatus", {}), ensure_ascii=False))
elif cmd == "submit":
    item_list = [
        {"address": "pages/ask/ask",
         "tag": "工程咨询提问页：AI检索行业知识库生成解答，每日6次免费，含AI优化提问"},
        {"address": "pages/answer/answer",
         "tag": "解答详情页：要点速览、依据来源展开、继续追问（免费）、导出Word/PDF"},
        {"address": "pages/pot/pot",
         "tag": "锅圈：用户自愿共享的公开问答展区，含举报入口与服务端内容安检"},
        {"address": "pages/zhiku/zhiku",
         "tag": "总包智库知识库介绍页（复制链接入口）"},
        {"address": "pages/my/my",
         "tag": "我的：咨询档案、批量导出、外观设置、用户协议与隐私政策入口"},
        {"address": "pages/legal/privacy",
         "tag": "用户协议与隐私政策全文页"},
    ]
    feedback = (
        "工程行业免费问答工具,无付费项。测试:登录后首页输入工程问题,10-40秒出AI解答,"
        "要点速览/继续追问均免费。锅圈为公开问答展区,已接内容安检+举报。"
        "隐私政策在'我的-用户协议'。无需测试账号。"
    )
    d = call("submit_audit", {"item_list": item_list, "feedback_info": feedback,
                              "version_desc": "v0.7.4"})
    print("SUBMIT:", json.dumps(d, ensure_ascii=False))
    if d.get("errcode") == 0 and d.get("auditid") is not None:
        open("/opt/qianwen/data/qianwen/audit_id.txt", "w").write(str(d["auditid"]))
        print("auditid saved:", d["auditid"])
elif cmd == "poll":
    aid = open("/opt/qianwen/data/qianwen/audit_id.txt").read().strip()
    d = call("get_auditstatus", {"auditid": int(aid)})
    print("POLL:", json.dumps(d, ensure_ascii=False))
elif cmd == "release":
    d = call("release", {})
    print("RELEASE:", json.dumps(d, ensure_ascii=False))
"""

def main() -> None:
    import base64
    stage = sys.argv[1] if len(sys.argv) > 1 else "--status"
    cmd = stage.lstrip("-")
    py_b64 = base64.b64encode(PY.encode("utf-8")).decode("ascii")
    script = (
        "set -e\ncd /opt/qianwen/services/qianwen-engine\n"
        f"printf '%s' '{py_b64}' | base64 -d | /opt/qianwen/venv/bin/python - {cmd}\n"
    )
    code, out = run(script)
    print(out)
    sys.exit(code)


if __name__ == "__main__":
    try:
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    except Exception:
        pass
    main()
