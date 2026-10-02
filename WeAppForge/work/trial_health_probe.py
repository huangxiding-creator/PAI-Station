# -*- coding: utf-8 -*-
"""体验版探针（通道体检版，可直跑 / 可被 import）。

0929晚 教训级自纠错（原版语义反了，废）：
  check_path=true 只按「线上版已发布（1.0.7）」的页面表校验——#19 早有实证：
  钉位健康时真页面 pages/ask/ask 也回 41030。故原「真页面回图=健康 / 41030=钉位悬空」
  判据是恒假阴性，API 层根本读不到钉位状态（wxa/getversion=40066 第三方专属）。
  受害面：出码硬闸误锁整个下午 + 监视哨假 BROKEN 误报（已删）+ 上传后探针输出误导。

现行语义（只做通道体检，不做钉位判定）：
  - pages/my/my（线上版表真实存在）回图 = API 通道活着
  - pages/ask/ask 回 41030 = 预期常数（该页不在线上版表，与钉位无关）
  - 钉位真判据 = 用户手机扫「码内显式 page」的码 + 引擎雷达（answers 表新流量）
"""
import io
import json as _json
from curl_cffi import requests

SEC_PATH = "E:/AI-Station/data/secrets/zongbao_qianwen_mp.secret"
RELEASE_PAGE = "pages/my/my"   # 线上版 1.0.7 表内真实存在（神谕实测）
OUR_PAGE = "pages/ask/ask"     # 我们首页，不在老表 → 预期 41030


def _token():
    sec = dict(l.strip().split("=", 1) for l in io.open(
        SEC_PATH, encoding="utf-8") if "=" in l)
    return requests.get(
        "https://api.weixin.qq.com/cgi-bin/token",
        params={"grant_type": "client_credential",
                "appid": sec["appid"], "secret": sec["appsecret"]},
        impersonate="chrome", timeout=30).json()["access_token"]


def _probe(token, page):
    body = {"page": page, "scene": "probe", "check_path": True,
            "env_version": "trial", "width": 280}
    r = requests.post(
        f"https://api.weixin.qq.com/wxa/getwxacodeunlimit?access_token={token}",
        data=_json.dumps(body).encode("utf-8"),
        headers={"Content-Type": "application/json"},
        impersonate="chrome", timeout=60)
    b = r.content
    is_img = b[:3] == b"\xff\xd8\xff" or b[:4] == b"\x89PNG"
    return is_img, (b[:120].decode("utf-8", "replace") if not is_img else "")


def run():
    """通道体检：返回 'CHANNEL_OK' / 'CHANNEL_DOWN'。钉位状态 API 不可读（无 oracle）。"""
    at = _token()
    ok, ok_err = _probe(at, RELEASE_PAGE)
    ours, ours_err = _probe(at, OUR_PAGE)
    print(f"[线上版表页 {RELEASE_PAGE}] {'IMAGE(通道活)' if ok else 'ERR ' + ok_err}")
    print(f"[我们首页 {OUR_PAGE}] {'IMAGE(异常:ask竟在老表?)' if ours else '41030(预期常数,与钉位无关)'}")
    verdict = "CHANNEL_OK" if ok else "CHANNEL_DOWN"
    print(f"SUMMARY: {verdict} — 钉位无API判据；真判据=手机扫显式page码+引擎雷达新流量")
    return verdict


if __name__ == "__main__":
    run()
