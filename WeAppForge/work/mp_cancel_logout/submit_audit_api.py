# -*- coding: utf-8 -*-
"""submit_audit_api.py — 类目绿灯后重提审 0.7.7 原包（submit_audit API 优先，控制台为兜底）.
前置：BOOT-SIM v3 247/247 全绿；/wxa/get_category 已实证 深度合成/AI问答 APPROVED。
纪律：纯 requests（curl_cffi 对 api.weixin.qq.com TLS 必断）；secret 只读不全显。
"""
import io
import json
import sys
import datetime

import requests

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")

SECRET = r"E:\AI-Station\data\secrets\zongbao_qianwen_mp.secret"
STATE_FLAG = r"E:\AI-Station\data\state\mp_category_green.flag"
STATE_OUT = r"E:\AI-Station\data\state\qianwen_submit_audit_state.json"

# item_list：7 页全报，类目按页映射（与已过审类目一一对应：
# 深度合成/AI问答 = AI 核心；资讯/信息资讯 = 智库内容；工具/信息查询 = 工具/合规页）
ITEM_LIST = [
    {"address": "pages/ask/ask",     "tag": "AI问答 工程咨询",       "first_class": "深度合成", "second_class": "AI问答",  "third_class": "", "title": "咨询"},
    {"address": "pages/answer/answer", "tag": "AI问答 生成标识",     "first_class": "深度合成", "second_class": "AI问答",  "third_class": "", "title": "回答"},
    {"address": "pages/pot/pot",     "tag": "共享问答池 AI标识",     "first_class": "深度合成", "second_class": "AI问答",  "third_class": "", "title": "锅圈"},
    {"address": "pages/zhiku/zhiku", "tag": "行业资讯 知识库",       "first_class": "资讯",     "second_class": "信息资讯", "third_class": "", "title": "智库"},
    {"address": "pages/my/my",       "tag": "个人中心 订阅状态",     "first_class": "工具",     "second_class": "信息查询", "third_class": "", "title": "我的"},
    {"address": "pages/home/home",   "tag": "首页 工程咨询入口",     "first_class": "工具",     "second_class": "信息查询", "third_class": "", "title": "首页"},
    {"address": "pages/legal/privacy", "tag": "隐私政策 用户协议",   "first_class": "工具",     "second_class": "信息查询", "third_class": "", "title": "隐私政策"},
]
FEEDBACK = "类目（深度合成-AI问答）已审核通过，重新提审此前因类目审核中被拒的 0.7.7 整改包：AI 生成内容显著标识已升级，合规整改全部完成。"


def read_secret():
    sec = dict(
        l.strip().split("=", 1)
        for l in io.open(SECRET, encoding="utf-8")
        if "=" in l and not l.startswith("#")
    )
    return sec["appid"].strip(), sec["appsecret"].strip()


def get_token(appid, appsecret):
    r = requests.get(
        "https://api.weixin.qq.com/cgi-bin/token",
        params={"grant_type": "client_credential", "appid": appid, "secret": appsecret},
        timeout=20,
    ).json()
    if "access_token" not in r:
        raise SystemExit(f"[FATAL] token fail: {r}")
    return r["access_token"]


def main():
    appid, appsecret = read_secret()
    assert appid == "wx5cee1574ce45819b", appid
    token = get_token(appid, appsecret)

    # 1) 最近一次审核状态（确认无在途审核、上次失败原因=类目）
    st = requests.get(
        "https://api.weixin.qq.com/wxa/get_latest_auditstatus",
        params={"access_token": token},
        timeout=20,
    ).json()
    print("[last_audit]", json.dumps(st, ensure_ascii=False))

    # 2) 提交审核（常规审核，绝不加急）
    r = requests.post(
        "https://api.weixin.qq.com/wxa/security/submit_audit",
        params={"access_token": token},
        json={"item_list": ITEM_LIST, "feedback_info": FEEDBACK},
        timeout=30,
    ).json()
    print("[submit_audit]", json.dumps(r, ensure_ascii=False))

    if r.get("errcode") == 0 and r.get("audit_id"):
        rec = {
            "at": datetime.datetime.now().astimezone().isoformat(timespec="seconds"),
            "audit_id": r["audit_id"],
            "appid": appid,
            "package": "0.7.7 原包（1002 robot 上传，AI 标识整改版）",
            "feedback": FEEDBACK,
            "last_audit_before": st,
        }
        io.open(STATE_OUT, "w", encoding="utf-8").write(json.dumps(rec, ensure_ascii=False, indent=2))
        print("[OK] audit submitted, audit_id =", r["audit_id"], "-> state:", STATE_OUT)
        return 0
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
