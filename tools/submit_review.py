# -*- coding: utf-8 -*-
"""submit_review — 本地直连微信API提审 (1017 用户令: 100%完美后自动提审)."""
from __future__ import annotations
import json, sys, time, urllib.request
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
SECRET = REPO / "data" / "secrets" / "zongbao_qianwen_mp.secret"

def read_secret():
    appid = appsecret = ""
    if SECRET.exists():
        for line in SECRET.read_text(encoding="utf-8"):
            k, _, v = line.partition("=")
            k, v = k.strip(), v.strip()
            if k == "appid":
                appid = v
            elif k == "appsecret":
                appsecret = v
    return appid, appsecret

def get_token():
    sec = {}
    if SECRET.exists():
        for line in SECRET.read_text(encoding="utf-8"):
            k, _, v = line.partition("=")
            sec[k.strip()] = v.strip()
    appid = sec.get("appid", "")
    appsecret = sec.get("appsecret", "")
    url = (f"https://api.weixin.qq.com/cgi-bin/token?"
           f"grant_type=client_credential&appid={appid}&secret={appsecret}")
    r = json.loads(urllib.request.urlopen(url, timeout=15).read())
    tok = r.get("access_token", "")
    if tok:
        print(f"✅ token: {tok[:20]}...")
    else:
        print(f"❌ token失败: {r}")
    return tok

def call(tok, path, payload=None):
    data = json.dumps(payload or {}).encode() if payload else b"{}"
    req = urllib.request.Request(
        f"https://api.weixin.qq.com/wxa/{path}?access_token={tok}",
        data=data, headers={"Content-Type": "application/json"})
    return json.loads(urllib.request.urlopen(req, timeout=20).read())

def main():
    tok = get_token()
    if not tok:
        print("❌ 获取 access_token 失败")
        return
    print(f"✅ token 获取成功 ({tok[:20]}...)")

    item_list = [
        {"address": "pages/home/home",
         "tag": "首页：AI工程咨询入口，报告商城入口"},
        {"address": "pages/report/report",
         "tag": "报告详情页：报告介绍、章节目录、试读、购买解锁、语音反馈(新)"},
        {"address": "pages/ask/ask",
         "tag": "工程咨询提问页：AI检索行业知识库生成解答"},
        {"address": "pages/answer/answer",
         "tag": "解答详情页：要点速览、依据来源、继续追问"},
        {"address": "pages/my/my",
         "tag": "我的：咨询档案、设置"},
        {"address": "pages/legal/privacy",
         "tag": "用户协议与隐私政策"},
    ]
    feedback = (
        "工程行业知识工具，含AI问答和付费研究报告商城。"
        "新增：语音反馈+AI六维评分+按质退款功能。"
        "测试：购买任一报告→阅读→按住语音反馈按钮说话→提交→查看评分和退款。"
        "未购买用户仅可浏览报告目录和试读，无付费入口(iOS合规)。"
    )
    version = "0.9.18"
    desc = "语音反馈+AI评分+按质退款"

    result = call(tok, "submit_audit", {
        "item_list": item_list,
        "feedback_info": feedback,
        "version_desc": desc,
    })
    print(json.dumps(result, ensure_ascii=False, indent=1))

    if result.get("errcode") == 0 and result.get("auditid"):
        audit_id = result["auditid"]
        print(f"✅ 提审成功! auditid={audit_id}")
        Path(REPO / "data" / "state" / "audit_id.txt").write_text(str(audit_id))
    else:
        print(f"❌ 提审失败: {result.get('errmsg')}")

if __name__ == "__main__":
    main()
