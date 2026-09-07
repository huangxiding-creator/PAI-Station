"""混沌学园全要素提取 CLI（M2.5 原料采集）。

纯 API 通道（零浏览器）：login → detail/directory/subtitles → data/hundun/
输出 <course_id>.json（结构化）+ <slug>.md（全要素 markdown）。
用法: python scripts/hundun_extract.py [course_id ...]
不带参数则提取首页三门本周课。
"""
import configparser
import json
import os
import re
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))), "src"))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from paistation.forge.hundun import HundunClient, extract_course, to_markdown

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(ROOT, "data", "hundun")
DEFAULT_COURSES = [
    "0c65743262608bb454bc9c3079a45675",  # AI时代的品牌营销 GEO（白鸦）
    "6e8b3ca3ddb59511021c2432fd77c5ea",
    "9022383de89428c01a12c3af280d438a",
]


def slugify(title: str) -> str:
    keep = re.sub(r"[^\w一-鿿-]+", "_", title).strip("_")
    return keep[:60] or "course"


def main(argv):
    ids = argv or DEFAULT_COURSES
    cred = configparser.ConfigParser()
    cred.read(os.path.join(ROOT, "config", "hundun.secret.ini"),
              encoding="utf-8")
    cli = HundunClient(phone=cred.get("hundun", "phone"),
                       password=cred.get("hundun", "password"))
    profile = cli.login()
    print(f"[login] OK 用户={profile.get('name')} "
          f"会员={profile.get('dhy_expire_time_display', '?')}")
    os.makedirs(OUT, exist_ok=True)
    for cid in ids:
        course = extract_course(cli, cid)
        with open(os.path.join(OUT, f"{cid}.json"), "w", encoding="utf-8") as fh:
            json.dump(course, fh, ensure_ascii=False, indent=1)
        md = to_markdown(course)
        name = f"{slugify(course['title'])}.md"
        with open(os.path.join(OUT, name), "w", encoding="utf-8") as fh:
            fh.write(md)
        chapters = course["chapters"]
        got = sum(1 for c in chapters if c["transcript"])
        total_chars = sum(len(c["transcript"]) for c in chapters)
        print(f"[extract] {course['title']} | 讲师 {course['teacher']} | "
              f"章节 {len(chapters)}（字幕 {got}）| 文稿 {total_chars} 字 "
              f"-> {name}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
