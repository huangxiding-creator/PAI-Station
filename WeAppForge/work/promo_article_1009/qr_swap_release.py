# -*- coding: utf-8 -*-
"""发布后换码腿：过审+发布六步完成后，把草稿内 trial 占位小程序码换成 release 正式码。

前置（全部满足才许跑）：
  1. 0.9.x 审核通过
  2. 发布六步清单执行完毕（线上版本=0.9.x，非遗留 1.0.7）
  3. 传 --i-published 旗标（人工确认发布完成的开关）

流程：gen release 码（scene=s=art 归因不变）→ uploadimg 换 mmbiz 域 →
      draft/get 读草稿 → 全量替换旧码 URL → draft/update → 回读验证。
"""
import json
import sys
import time
from pathlib import Path

import requests

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
PROMO = Path(r"E:\AI-Station\WeAppForge\work\promo_article_1009")
S = requests.Session()
S.trust_env = False


def read_kv(path: Path) -> dict:
    return {k.strip(): v.strip() for k, v in (
        ln.split("=", 1) for ln in path.read_text(encoding="utf-8", errors="replace").splitlines() if "=" in ln)}


def gh_token() -> str:
    for a in json.load(open(r"E:\CPOPC\We-AIPO\data\wechat_accounts.json", encoding="utf-8")):
        if a.get("name") == "总包之声":
            r = S.get("https://api.weixin.qq.com/cgi-bin/token", params={
                "grant_type": "client_credential", "appid": a["appid"],
                "secret": a.get("appsecret") or a["secret"]}, timeout=15)
            d = r.json()
            assert "access_token" in d, f"gh token FAIL: {d}"
            return d["access_token"]
    raise SystemExit("总包之声 not found")


def mp_token() -> str:
    kv = read_kv(Path(r"E:\AI-Station\data\secrets\zongbao_qianwen_mp.secret"))
    r = S.get("https://api.weixin.qq.com/cgi-bin/token", params={
        "grant_type": "client_credential", "appid": kv["appid"], "secret": kv["appsecret"]}, timeout=15)
    d = r.json()
    assert "access_token" in d, f"mp token FAIL: {d}"
    return d["access_token"]


def main() -> None:
    if "--i-published" not in sys.argv:
        print("拒绝执行：须先过审+完成发布六步，然后传 --i-published 旗标。")
        print("发布六步清单 = _proposals/report-miniprogram-1008/HANDOFF.md §六")
        sys.exit(2)

    push = json.loads((PROMO / "push_result.json").read_text(encoding="utf-8"))
    draft_id = push["media_id"]

    # ① release 码
    qr_path = PROMO / "qr_art_release_1280.png"
    r = S.post("https://api.weixin.qq.com/wxa/getwxacodeunlimit",
               params={"access_token": mp_token()},
               json={"page": "pages/ask/ask", "scene": "s=art", "check_path": False,
                     "env_version": "release", "width": 1280}, timeout=30)
    if "json" in r.headers.get("Content-Type", ""):
        raise SystemExit(f"release QR FAIL（线上版还没发布？）: {r.json()}")
    qr_path.write_bytes(r.content)
    print(f"release QR -> {qr_path.name} {len(r.content)}B")

    # ② uploadimg
    time.sleep(1)
    with open(qr_path, "rb") as f:
        r = S.post("https://api.weixin.qq.com/cgi-bin/media/uploadimg",
                   params={"access_token": gh_token()},
                   files={"media": (qr_path.name, f, "image/png")}, timeout=60)
    new_url = r.json().get("url", "")
    assert new_url.startswith("http"), f"uploadimg FAIL: {r.json()}"
    print(f"new QR url: {new_url}")

    # ③ draft/get → ④ 替换 → ⑤ draft/update
    token = gh_token()
    r = S.post("https://api.weixin.qq.com/cgi-bin/draft/get",
               params={"access_token": token}, data=json.dumps({"media_id": draft_id}).encode(),
               headers={"Content-Type": "application/json; charset=utf-8"}, timeout=30)
    art = json.loads(r.content.decode("utf-8"))["news_item"][0]
    old = push.get("qr_trial_url") or _extract_old_qr(art["content"])
    content = art["content"].replace(old, new_url)
    assert new_url in content and old not in content, "替换失败"

    body = json.dumps({"media_id": draft_id, "articles": [{
        "title": art["title"], "content": content,
        "thumb_media_id": art["thumb_media_id"], "digest": art["digest"],
        "need_open_comment": 1, "only_fans_can_comment": 0,
    }]}, ensure_ascii=False).encode("utf-8")
    for att in range(3):
        r = S.post("https://api.weixin.qq.com/cgi-bin/draft/update",
                   params={"access_token": token}, data=body,
                   headers={"Content-Type": "application/json; charset=utf-8"}, timeout=30)
        d = json.loads(r.content.decode("utf-8"))
        if d.get("errcode") == 0:
            break
        print(f"update retry {att + 1}: {d}")
        time.sleep(3)
    assert d.get("errcode") == 0, f"draft/update FAIL: {d}"

    # ⑥ 回读验证
    r = S.post("https://api.weixin.qq.com/cgi-bin/draft/get",
               params={"access_token": token}, data=json.dumps({"media_id": draft_id}).encode(),
               headers={"Content-Type": "application/json; charset=utf-8"}, timeout=30)
    back = json.loads(r.content.decode("utf-8"))["news_item"][0]["content"]
    n = back.count(new_url)
    (PROMO / "qr_swap_result.json").write_text(json.dumps(
        {"new_url": new_url, "replaced_old": old, "occurrences": n}, ensure_ascii=False, indent=2),
        encoding="utf-8")
    print(f"SWAP DONE: release 码在文中出现 {n} 次（预期 3）。草稿可群发。")


def _extract_old_qr(content: str) -> str:
    import re
    push_urls = json.loads((PROMO / "url_map.json").read_text(encoding="utf-8"))
    trial = push_urls["QR"]
    # 微信规范化后 http→https；按文件名段匹配真身
    stem = trial.rsplit("/", 1)[-1][:60]
    for m in re.finditer(r'https://mmbiz\.qpic\.cn/[^"]+', content):
        if m.group(0).find(stem[:50]) >= 0:
            return m.group(0)
    raise SystemExit(f"旧 trial 码 URL 未在草稿中定位（stem={stem[:30]}…）")


if __name__ == "__main__":
    main()
