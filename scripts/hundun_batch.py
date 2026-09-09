"""混沌学园全量批量提取（断点续采）。

census.json → 逐课程 extract_course → 按分类落盘：
- AI 课程（tab=AI 或标题/简介命中 AI 关键词）→ data/hundun/AI课程/
- 其余 → data/hundun/课程资料/<tab>/
幂等：目标 <cid>.json 已存在即跳过；单课失败写入 failed 列表继续。
速率：<cid> 每章字幕调用间隔 0.2s，礼貌稳定采集。
"""
import configparser
import json
import os
import re
import sys
import time

sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))), "src"))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from paistation.forge.hundun import HundunClient, extract_course, to_markdown  # noqa: E402

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BASE = os.path.join(ROOT, "data", "hundun")
CENSUS = os.path.join(BASE, "_recon", "census.json")
AI_DIR = os.path.join(BASE, "AI课程")
OTHER_BASE = os.path.join(BASE, "课程资料")
FAILED = os.path.join(BASE, "_recon", "failed.json")
THROTTLE = 0.2

# AI 相关判定：AI 分类 tab 或标题/简介关键词（用户指令：AI 资料单独一个文件夹）
_KW = re.compile(r"AI|人工智能|大模型|智能体|AIGC|GPT|Agent|机器学习|深度学习"
                 r"|LLM|生成式|OpenAI|DeepSeek|大语言模型")
_HEX32 = re.compile(r"^[0-9a-f]{32}$")


def slugify(title: str) -> str:
    keep = re.sub(r"[^\w一-鿿-]+", "_", title).strip("_")
    return keep[:60] or "course"


def is_ai(rec: dict) -> bool:
    if rec.get("tab") == "AI":
        return True
    probe = f"{rec.get('title', '')}"
    return bool(_KW.search(probe))


def existing_ids() -> set:
    done = set()
    for sub in (AI_DIR, *(os.path.join(OTHER_BASE, d) for d in
                          os.listdir(OTHER_BASE) if os.path.isdir(
                              os.path.join(OTHER_BASE, d)))) if os.path.isdir(OTHER_BASE) else (AI_DIR,):
        for name in os.listdir(sub):
            if name.endswith(".json") and _HEX32.match(name[:-5]):
                done.add(name[:-5])
    return done


def main() -> int:
    census = json.load(open(CENSUS, encoding="utf-8"))["courses"]
    courses = [c for c in census.values() if _HEX32.match(c["course_id"])]
    # AI 优先，组内按评分倒序
    courses.sort(key=lambda c: (not is_ai(c), -(c.get("score") or 0)))

    cred = configparser.ConfigParser()
    cred.read(os.path.join(ROOT, "config", "hundun.secret.ini"), encoding="utf-8")
    cli = HundunClient(phone=cred.get("hundun", "phone"),
                       password=cred.get("hundun", "password"))
    cli.login()
    print(f"[batch] 待处理 {len(courses)} 门（AI 优先）", flush=True)

    done = existing_ids()
    failed = []
    ok = skipped = 0
    t0 = time.time()

    def extract_with_relogin(cid: str) -> dict:
        """提取；403 凭证失效时自动重登一次再试。"""
        try:
            return extract_course(cli, cid)
        except RuntimeError as exc:
            if "error_no=403" not in str(exc):
                raise
            print(f"[relogin] 会话失效，重新登录: {str(exc)[:60]}", flush=True)
            cli.login()
            return extract_course(cli, cid)

    for i, rec in enumerate(courses, 1):
        cid = rec["course_id"]
        if cid in done:
            skipped += 1
            continue
        try:
            course = extract_with_relogin(cid)
            time.sleep(THROTTLE)
            folder = AI_DIR if is_ai(rec) else os.path.join(
                OTHER_BASE, rec.get("tab", "其他") or "其他")
            os.makedirs(folder, exist_ok=True)
            with open(os.path.join(folder, f"{cid}.json"), "w",
                      encoding="utf-8") as fh:
                json.dump(course, fh, ensure_ascii=False, indent=1)
            name = slugify(course["title"])
            with open(os.path.join(folder, f"{name}.md"), "w",
                      encoding="utf-8") as fh:
                fh.write(to_markdown(course))
            ok += 1
            chars = sum(len(c["transcript"]) for c in course["chapters"])
            print(f"[{i}/{len(courses)}] OK {'AI/' if is_ai(rec) else ''}"
                  f"{course['title'][:30]} | {len(course['chapters'])}章 "
                  f"{chars}字", flush=True)
        except Exception as exc:  # noqa: BLE001 - 单课失败不挡批
            failed.append({"course_id": cid, "title": rec.get("title"),
                           "err": str(exc)[:200]})
            print(f"[{i}/{len(courses)}] FAIL {rec.get('title', '')[:30]}: "
                  f"{str(exc)[:80]}", flush=True)
        if i % 25 == 0:
            with open(FAILED, "w", encoding="utf-8") as fh:
                json.dump(failed, fh, ensure_ascii=False, indent=1)
            mins = (time.time() - t0) / 60
            print(f"[progress] {i}/{len(courses)} | ok={ok} skip={skipped} "
                  f"fail={len(failed)} | {mins:.1f}min", flush=True)
    with open(FAILED, "w", encoding="utf-8") as fh:
        json.dump(failed, fh, ensure_ascii=False, indent=1)
    print(f"[batch] 完成：ok={ok} skip={skipped} fail={len(failed)} "
          f"耗时 {(time.time() - t0) / 60:.1f} 分钟", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
