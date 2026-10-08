# -*- coding: utf-8 -*-
"""watch_category_api.py — 类目盯哨 API 版（1007 持久化改造：零登录免扫码）.

原理: 官方 /wxa/get_category 只返回已通过并生效的类目;
「深度合成>AI问答」在该列表出现 = 绿灯(审核通过), 不出现 = 未生效
(审核中或被驳回, 无须登录区分——绿灯才是唯一触发动作的状态)。

对照基线(1007 浏览器实查): 工具>信息查询 已通过 / 资讯>信息资讯 已通过 /
深度合成>AI问答 审核中 → API 只见前两条, 与原理一致。

坑: curl_cffi impersonate 连 api.weixin.qq.com 被 TLS 掐(SSL_ERROR_SYSCALL),
普通 requests 直连正常——本脚本一律用 requests。

用法: python watch_category_api.py  → JSON verdict:
  GREEN  (深度合成生效, 触发 BOOT-SIM+重提审流程)
  PENDING(未见深度合成, 审核中或驳回未生效)
  ERROR  (网络/接口异常, 下轮再试)
"""
import io
import json
import sys

import requests

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

SECRET = "E:/AI-Station/data/secrets/zongbao_qianwen_mp.secret"
TARGET = ("深度合成", "AI问答")
BASELINE = {("工具", "信息查询"), ("资讯", "信息资讯")}  # 已通过基线, 消失=异常


def main() -> int:
    sec = dict(l.strip().split("=", 1) for l in io.open(SECRET, encoding="utf-8")
               if "=" in l and not l.startswith("#"))
    try:
        r = requests.get(
            "https://api.weixin.qq.com/cgi-bin/token",
            params={"grant_type": "client_credential",
                    "appid": sec["appid"].strip(),
                    "secret": sec["appsecret"].strip()},
            timeout=20).json()
        at = r.get("access_token")
        if not at:
            print(json.dumps({"verdict": "ERROR", "detail": r}, ensure_ascii=False))
            return 1
        cats = requests.get("https://api.weixin.qq.com/wxa/get_category",
                            params={"access_token": at}, timeout=20).json()
    except Exception as e:  # noqa: BLE001 — 网络腿任何异常都如实降级 ERROR
        print(json.dumps({"verdict": "ERROR", "detail": f"{type(e).__name__}: {e}"},
                         ensure_ascii=False))
        return 1
    if cats.get("errcode") != 0:
        print(json.dumps({"verdict": "ERROR", "detail": cats}, ensure_ascii=False))
        return 1
    live = {(c["first_class"], c["second_class"])
            for c in cats.get("category_list", [])}
    green = TARGET in live
    baseline_ok = BASELINE <= live
    print(json.dumps({
        "verdict": "GREEN" if green else "PENDING",
        "categories": sorted("/".join(p) for p in live),
        "baseline_ok": baseline_ok,
        "note": "" if baseline_ok else "基线类目缺失, 建议浏览器复核",
    }, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
