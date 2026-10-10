# -*- coding: utf-8 -*-
"""probe_audit_endpoints.py — 暴力试审核状态端点变体。"""
import configparser
import json
import sys

import requests

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
INI = "E:/AI-Station/report_platform/secret.ini"


def main() -> int:
    cp = configparser.ConfigParser()
    cp.read(INI, encoding="utf-8")
    sec = cp["wxapp_wxfdb"]
    appid = sec.get("appid", "wxfdb55b184756e89e").strip()
    appsecret = (sec.get("appsecret") or sec.get("secret", "")).strip()
    r = requests.get("https://api.weixin.qq.com/cgi-bin/token",
                     params={"grant_type": "client_credential", "appid": appid,
                             "secret": appsecret}, timeout=20).json()
    at = r.get("access_token")
    if not at:
        print(json.dumps({"token_fail": r}, ensure_ascii=False))
        return 1

    bases = [
        ("get_category", "get", "https://api.weixin.qq.com/wxa/get_category"),
        ("get_auditstatus", "post", "https://api.weixin.qq.com/wxa/get_auditstatus"),
        ("getauditstatus", "post", "https://api.weixin.qq.com/wxa/getauditstatus"),
        ("get_audit_status2", "get", "https://api.weixin.qq.com/wxa/get_audit_status"),
        ("query_audit", "post", "https://api.weixin.qq.com/wxa/query_audit"),
        ("get_version_info2", "post", "https://api.weixin.qq.com/wxa/getversioninfo"),
        ("revert_code_release", "get", "https://api.weixin.qq.com/wxa/get_qrcode"),
    ]
    out = {}
    for name, method, url in bases:
        try:
            if method == "get":
                resp = requests.get(url, params={"access_token": at}, timeout=15)
            else:
                resp = requests.post(url + f"?access_token={at}", json={}, timeout=15)
            j = resp.json()
            out[name] = {k: j.get(k) for k in ("errcode", "errmsg", "audit_state",
                                               "reason", "version", "release_info",
                                               "status")}
            if "category_list" in j:
                out[name]["n_cats"] = len(j["category_list"])
            # 非标字段全留一份
            extra = {k: v for k, v in j.items()
                     if k not in ("errcode", "errmsg", "audit_state", "reason",
                                  "version", "release_info", "status", "category_list")}
            if extra:
                out[name]["extra_keys"] = list(extra)[:8]
        except Exception as e:  # noqa: BLE001
            out[name] = {"exc": f"{type(e).__name__}: {e}"}
    print(json.dumps(out, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
