# -*- coding: utf-8 -*-
"""菲律宾抽蓄P6招聘启事 → 总包之声草稿箱
封面: PIL 生成 900x383 深蓝金封面; 正文: philippines_p6_recruit.html (ocean-calm 手写排版)
复用 We-AIPO WeChatDraftPublisher (_get_token / _upload_image / draft.add)
纪律: 只进草稿箱, 群发动作留给用户 (防封第一); appsecret 只经内存, 不打印不落盘
"""
import sys
import json
import re
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
WA = Path(r"E:/CPOPC/We-AIPO")
sys.path.insert(0, str(WA))
ZV = Path(__file__).resolve().parent

COVER = ZV / "philippines_p6_cover.jpg"
HTML = ZV / "philippines_p6_recruit.html"


def make_cover():
    from PIL import Image, ImageDraw, ImageFont
    W, H = 900, 383
    img = Image.new("RGB", (W, H), "#26415c")
    d = ImageDraw.Draw(img)
    top, bot = (38, 65, 92), (74, 124, 155)
    for y in range(H):  # 垂直渐变: 深蓝→海蓝
        t = y / H
        d.line([(0, y), (W, y)], fill=tuple(int(top[i] + (bot[i] - top[i]) * t) for i in range(3)))
    fb = lambda s: ImageFont.truetype(r"C:/Windows/Fonts/msyhbd.ttc", s)
    fm = lambda s: ImageFont.truetype(r"C:/Windows/Fonts/msyh.ttc", s)
    d.text((60, 48), "招 贤 纳 士", font=fm(20), fill=(198, 213, 226))
    d.line([(60, 88), (184, 88)], fill=(201, 160, 106), width=2)
    d.text((60, 138), "菲律宾130亿抽蓄EPC", font=fb(56), fill=(255, 255, 255))
    d.text((62, 232), "招聘英才 · 高级进度计划工程师（Primavera P6）", font=fm(27), fill=(212, 227, 238))
    d.rectangle([(0, H - 10), (W, H)], fill=(201, 160, 106))  # 底部金条
    img.save(COVER, quality=92)
    print(f"封面生成: {COVER.name}")


def push():
    import requests
    from src.plugins.output.wechat_draft import WeChatDraftPublisher

    html = HTML.read_text(encoding="utf-8")
    m = re.search(r"<body>(.*)</body>", html, re.S)
    if not m:
        print("HTML 正文提取失败"); return 1
    content = m.group(1).strip()
    print(f"正文 {len(content)} 字节, section={content.count('<section')}")

    accs = json.loads((WA / "data" / "wechat_accounts.json").read_text(encoding="utf-8"))
    acc = next(a for a in accs if a.get("enabled") and a.get("name") == "总包之声")
    print(f"目标账号: 总包之声 | {acc['appid'][:6]}...")

    pub = WeChatDraftPublisher()
    token = pub._get_token(acc["appid"], acc["appsecret"])
    if not token:
        print("token 获取失败 (IP 白名单?)"); return 1
    print("token ✓")

    # 删除旧版草稿, 草稿箱只留最新版
    old = ZV / "draft_media_id.txt"
    if old.exists():
        old_id = old.read_text(encoding="utf-8").strip()
        if old_id:
            r = requests.post("https://api.weixin.qq.com/cgi-bin/draft/delete",
                              params={"access_token": token},
                              json={"media_id": old_id}, timeout=30)
            print(f"旧草稿删除: errcode={r.json().get('errcode')}")

    thumb = pub._upload_image(token, COVER, acc)
    print("封面上传:", ("✓ " + thumb[:20]) if thumb else "失败")
    if not thumb:
        return 1

    article = {
        "title": "菲律宾130亿抽蓄EPC招聘英才",
        # 45110: author 按字节限 8, 中文超两字即拒 → 留空(公众号作者字段可空)
        "author": "",
        "digest": "130亿菲律宾抽蓄EPC，寻找能掌盘P6基线的进度计划高手。中国水电三局 · FIDIC · 2025—2031。",
        "content": content,
        "content_source_url": "",
        "need_open_comment": 0,
        "only_fans_can_comment": 0,
        "thumb_media_id": thumb,
        "show_cover_pic": 1,
    }
    # 乱码根因: requests json= 将中文转 \uXXXX 转义, 微信草稿网关不解码直接当字面文本存
    # (实锤: draft/get 读回 title 为字面 '菲律宾...') → 必须 ensure_ascii=False
    # 以 UTF-8 原文直发 + 显式 charset 头
    payload = json.dumps({"articles": [article]}, ensure_ascii=False).encode("utf-8")
    r = requests.post("https://api.weixin.qq.com/cgi-bin/draft/add",
                      params={"access_token": token},
                      data=payload,
                      headers={"Content-Type": "application/json; charset=utf-8"},
                      timeout=30)
    data = r.json()
    errcode = data.get("errcode", 0)
    print(f"draft/add errcode={errcode} errmsg={data.get('errmsg', '')}")
    if data.get("media_id"):
        (ZV / "draft_media_id.txt").write_text(data["media_id"], encoding="utf-8")
        print(f"草稿已进「总包之声」草稿箱 media_id={data['media_id']}")
        return 0
    return 1


if __name__ == "__main__":
    make_cover()
    sys.exit(push())
