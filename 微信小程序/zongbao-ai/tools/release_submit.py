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

APPID = "wx5cee1574ce45819b"  # zongbao-ai（总包AI顾问）
SECRET_FILE = Path(r"E:\AI-Station\data\secrets") / "zongbao_qianwen_mp.secret"
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


def get(path, token):
    url = BASE + path + (f"?access_token={token}" if token else "")
    with urllib.request.urlopen(url, timeout=20) as r:
        return json.loads(r.read())


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
    elif mode == "category":
        t = get_token()
        r = get("/wxa/get_category", t)
        print("[category]", json.dumps(r, ensure_ascii=False)[:500])
    elif mode == "submit":
        t = get_token()
        # 类目取账号真实值（47001教训：first/second_class 必须与后台审核类目一致）
        cat = get("/wxa/get_category", t)
        first = second = None
        cats = cat.get("category_list") or []
        c0 = cats[0] if cats else {}
        first_id, second_id = c0.get("first_id"), c0.get("second_id")
        print("[category]", "first_id=", first_id, "second_id=", second_id, f"({c0.get('first_class')}/{c0.get('second_class')})")
        r = post("/wxa/submit_audit", {
            "item_list": [{
                "address": "pages/kbfactory/kbfactory",
                "tag": "知识库工厂",
                "first_id": first_id,
                "second_id": second_id,
                "title": "知识库工厂",
                "version_desc": "新功能：一句话免费生成专业知识库蓝图，付费整库交付",
            }, {
                "address": "pages/zhiku/zhiku",
                "tag": "总包智库",
                "first_id": first_id,
                "second_id": second_id,
                "title": "总包智库",
                "version_desc": "智库页新增知识库工厂入口卡",
            }],
            "feedback_info": "新功能：知识库工厂（一句话生成专业知识库蓝图，付费整库交付）。支付走微信虚拟支付（Android），iOS按规范隐藏付费入口。",
        }, token=t)
        print("[submit]", json.dumps(r, ensure_ascii=False)[:300])
        if r.get("errcode") == 0:
            print("[submit] auditid =", r.get("auditid"))
    elif mode == "status":
        t = get_token()
        r = get("/wxa/get_latest_auditstatus", t)
        print("[status]", json.dumps(r, ensure_ascii=False)[:300])
    elif mode == "release":
        t = get_token()
        r = post("/wxa/release", {}, token=t)
        print("[release]", json.dumps(r, ensure_ascii=False)[:300])
    else:
        raise SystemExit(__doc__)


if __name__ == "__main__":
    main()
