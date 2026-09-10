"""混沌学园逐课知识挖掘：GLM 免费链提炼思维模型/原则/方法论/经验。

对 triage.json 排序后的全部课程：
- 章节打包 ≤48K 字符/片 → glm-4-flash json_mode 提炼四类知识资产
- 每片产出 items：{type, name, core, steps, quote, ai_application, src}
- 课程级合并落盘 _mining/<cid>.json（断点续跑：已存在即跳过）
- 单课失败不挡批，记入 failed 列表，重跑自动补
用法: python scripts/hundun_mine.py [--limit N] [--only AI课程]
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

from paistation.llm.zhipu_client import ZhipuClient, extract_json  # noqa: E402

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BASE = os.path.join(ROOT, "data", "hundun")
MINE = os.path.join(BASE, "_mining")
CHUNK = 48000
THROTTLE = 1.0

SYSTEM = (
    "你是首席知识官。任务：从在线课程文稿中提炼对「AI 产品研发」真正可迁移、"
    "可复用的知识资产。铁律：只提炼文稿中确实出现的内容，不得编造；保留讲者"
    "原始术语；泛泛而谈、广告、寒暄一律不提炼；宁缺毋滥。"
)

TPL = """课程：《{title}》｜讲师：{teacher}｜分类：{tab}
本片段包含章节：{ch_titles}
（第{i}/{n}段，可能从中间开始）

{chunk}

输出 JSON（UTF-8、无围栏），四类知识资产，每类≤8条、严格筛选：
{{
 "thinking_models": [{{"name":"模型名≤15字","core":"核心思想2-3句",
   "quote":"原文最精华金句≤80字","ai_application":"对AI产品研发的应用启示1-2句","src":"所属章节标题"}}],
 "principles": [同上结构],
 "methodologies": [{{"name","core",
   "steps":"操作步骤，分号分隔，无则空串","quote","ai_application","src"}}],
 "experiences": [{{"name":"经验/教训标题≤15字",
   "core":"具体经验或失败教训，含案例主体与结果","quote","ai_application","src"}}]
}}
thinking_models=思维模型；principles=原则/定律；methodologies=可操作方法论；experiences=实战经验教训。无则空数组。"""

_TYPES = {"thinking_models": "思维模型", "principles": "原则",
          "methodologies": "方法论", "experiences": "经验"}


def build_client() -> ZhipuClient:
    cp = configparser.ConfigParser()
    cp.read(os.path.join(ROOT, "config", "llm.secret.ini"), encoding="utf-8")
    return ZhipuClient(api_key=cp.get("llm", "api_key"),
                       free_models=["glm-4-flash-250414", "glm-4.7-flash"])


def pack_chunks(course: dict) -> list:
    """章节按序打包 ≤CHUNK 字符；单章超长按段落二次切。返回 [(ch_titles, text)]。"""
    chunks, cur, cur_titles, cur_len = [], [], [], 0
    for ch in course.get("chapters") or []:
        title = ch.get("title", "") or ""
        text = ch.get("transcript") or ""
        if not text.strip():
            continue
        if len(text) > CHUNK:  # 超长章节按空行切
            paras, buf = [], ""
            for p in re.split(r"\n\s*\n", text):
                if len(buf) + len(p) > CHUNK and buf:
                    paras.append(buf)
                    buf = p
                else:
                    buf = f"{buf}\n\n{p}" if buf else p
            if buf:
                paras.append(buf)
            text_parts = paras
        else:
            text_parts = [text]
        for part in text_parts:
            if cur_len + len(part) > CHUNK and cur:
                chunks.append((cur_titles, "\n\n".join(cur)))
                cur, cur_titles, cur_len = [], [], 0
            cur.append(part)
            cur_titles.append(title)
            cur_len += len(part)
    if cur:
        chunks.append((cur_titles, "\n\n".join(cur)))
    return chunks


def mine_course(cli: ZhipuClient, course: dict, meta: dict) -> list:
    items = []
    chunks = pack_chunks(course)
    for i, (titles, text) in enumerate(chunks, 1):
        prompt = TPL.format(
            title=course.get("title", ""), teacher=course.get("teacher", ""),
            tab=meta.get("folder", ""), ch_titles="；".join(dict.fromkeys(titles))[:120],
            i=i, n=len(chunks), chunk=text)
        raw = cli.chat(SYSTEM, prompt, json_mode=True, temperature=0.2)
        data = extract_json(raw)
        for key, label in _TYPES.items():
            for it in data.get(key) or []:
                if not isinstance(it, dict) or not it.get("name"):
                    continue
                it["type"] = label
                items.append(it)
        time.sleep(THROTTLE)
    return items


def main(argv: list) -> int:
    limit = int(argv[argv.index("--limit") + 1]) if "--limit" in argv else 0
    only = argv[argv.index("--only") + 1] if "--only" in argv else ""
    excl = argv[argv.index("--exclude") + 1] if "--exclude" in argv else ""
    triage = json.load(open(os.path.join(MINE, "triage.json"), encoding="utf-8"))
    ranked = sorted(triage.items(), key=lambda kv: -kv[1]["score"])
    if only:
        ranked = [(c, m) for c, m in ranked if only in m.get("folder", "")]
    if excl:
        ranked = [(c, m) for c, m in ranked if excl not in m.get("folder", "")]
    todo = []
    for cid, meta in ranked:
        if os.path.exists(os.path.join(MINE, f"{cid}.json")):
            continue
        sub = meta["folder"] if meta["folder"] == "AI课程" \
            else os.path.join("课程资料", meta["folder"])
        src = os.path.join(BASE, sub, f"{cid}.json")
        if os.path.exists(src):
            todo.append((cid, meta, src))
    if limit:
        todo = todo[:limit]
    if "--reverse" in argv:  # 双进程对向推进，零重叠
        todo = todo[::-1]
    print(f"[mine] 待挖 {len(todo)} 门（triage 降序）", flush=True)
    cli = build_client()
    failed = []
    t0 = time.time()
    for i, (cid, meta, src) in enumerate(todo, 1):
        try:
            course = json.load(open(src, encoding="utf-8"))
            items = mine_course(cli, course, meta)
            rec = {"course_id": cid, "title": course.get("title", ""),
                   "teacher": course.get("teacher", ""), "folder": meta["folder"],
                   "score": meta["score"], "items": items}
            tmp = os.path.join(MINE, f"{cid}.tmp")
            with open(tmp, "w", encoding="utf-8") as fh:
                json.dump(rec, fh, ensure_ascii=False, indent=1)
            os.replace(tmp, os.path.join(MINE, f"{cid}.json"))
            print(f"[{i}/{len(todo)}] {course.get('title', '')[:26]} → "
                  f"{len(items)}条", flush=True)
        except Exception as exc:  # noqa: BLE001 - 单课失败不挡批
            failed.append({"cid": cid, "err": str(exc)[:150]})
            print(f"[{i}/{len(todo)}] FAIL {meta.get('title', '')[:26]}: "
                  f"{str(exc)[:90]}", flush=True)
        if i % 25 == 0:
            mins = (time.time() - t0) / 60
            print(f"[progress] {i}/{len(todo)} fail={len(failed)} {mins:.1f}min",
                  flush=True)
    with open(os.path.join(MINE, "mine_failed.json"), "w", encoding="utf-8") as fh:
        json.dump(failed, fh, ensure_ascii=False, indent=1)
    print(f"[mine] 完成 fail={len(failed)} 耗时{(time.time() - t0) / 60:.1f}分钟",
          flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
