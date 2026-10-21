# -*- coding: utf-8 -*-
"""release_submit.py — 小程序提审/放量腿（发布链②③，上传成功后跑）。
用法:
  py -3 -X utf8 tools/release_submit.py token     # 取 stable_token（校验密钥）
  py -3 -X utf8 tools/release_submit.py submit    # 提审（本次变更页: kbfactory+zhiku）
  py -3 -X utf8 tools/release_submit.py status    # 查最近一次审核状态
  py -3 -X utf8 tools/release_submit.py release   # 审核通过后放量
凭据: data/secrets/mp_secret_wxfdb55b184756e89e.secret（运行时读 appsecret，零入仓零打印）"""
import json
import sys
import urllib.request
from pathlib import Path

APPID = "wxfdb55b184756e89e"
SECRET_FILE = Path(r"E:\AI-Station\data\secrets") / f"mp_secret_{APPID}.secret"
BASE = "https://api.weixin.qq.com"
CACHE = Path(__file__).resolve().parent / "_release_token.json"


def appsecret() -> str:
    for line in SECRET_FILE.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        for sep in ("=", ":"):
            if sep in line:
                k, v = line.split(sep, 1)
                if "secret" in k.lower() and v.strip():
                    return v.strip()
    raise SystemExit("appsecret not found in secret file")


def post(path, payload=None, token=None):
    url = BASE + path + (f"?access_token={token}" if token else "")
    data = json.dumps(payload or {}).encode()
    req = urllib.request.Request(url, data=data, headers={"Content-Type": "application/json"})
    with urllib.request.urlopen(req, timeout=20) as r:
        return json.loads(r.read())


def get_token(force=False):
    if not force and CACHE.exists():
        t = json.loads(CACHE.read_text(encoding="utf-8"))
        if t.get("expires_at", 0) > 86400 * 365 + 1e9:  # 粗缓存：stable_token 有效期长，用前重取
            pass
    r = post("/cgi-bin/stable_token", {"grant_type": "client_credential",
                                       "appid": APPID, "secret": appsecret(),
                                       "force_refresh": force})
    if "access_token" not in r:
        raise SystemExit(f"token fail: {r}")
    CACHE.write_text(json.dumps(r), encoding="utf-8")
    return r["access_token"]


def main():
    mode = sys.argv[1] if len(sys.argv) > 1 else "token"
    if mode == "token":
        t = get_token(force=True)
        print("[token] OK len=", len(t))
    elif mode == "submit":
        t = get_token()
        r = post("/wxa/submit_audit", {
            "item_list": [{
                "address": "pages/kbfactory/kbfactory",
                "version_desc": "知识库工厂：免费蓝图设计+整库购买",
                "title": "知识库工厂",
                "tag": "工具 > 效率",
            }, {
                "address": "pages/zhiku/zhiku",
                "version_desc": "智库页新增知识库工厂入口卡",
                "title": "总包智库",
                "tag": "工具 > 效率",
            }],
            "feedback_info": "新功能：知识库工厂（一句话生成专业知识库蓝图，付费整库交付）。支付走微信虚拟支付（Android），iOS按规范隐藏付费入口。",
            "version_desc": "KB-FACTORY v1",
        }, token=t)
        print("[submit]", json.dumps(r, ensure_ascii=False)[:300])
        if r.get("errcode") == 0:
            print("[submit] auditid =", r.get("auditid"))
    elif mode == "status":
        t = get_token()
        r = post("/wxa/get_latest_auditstatus", {}, token=t)
        print("[status]", json.dumps(r, ensure_ascii=False)[:300])
    elif mode == "release":
        t = get_token()
        r = post("/wxa/release", {}, token=t)
        print("[release]", json.dumps(r, ensure_ascii=False)[:300])
    else:
        raise SystemExit(__doc__)


if __name__ == "__main__":
    main()
