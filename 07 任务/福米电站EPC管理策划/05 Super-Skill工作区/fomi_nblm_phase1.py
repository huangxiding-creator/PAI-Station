# -*- coding: utf-8 -*-
"""fomi_nblm_phase1 - FOMI-EPC NBLM Phase 1 章级产线 (框架落地后运行).
① 解析 nblm_out/00_框架.md → chapters_nblm.json
② 每章自动选源(章题+小节关键词 × S2台账行/readers/researchers/deep 事实匹配) → chNN_笔记本
③ 每章建本→上传→分段指向生成(CJK门1800, 扩写轮≤2) → nblm_out/_chNN.md
铁律: 数字零造假(NBLM只准照抄资料数字); 分段指向防双版; 幂等(state); 通道锁定不轮换.
用法:
  py -X utf8 fomi_nblm_phase1.py pack           # 解析框架+建章包(不上传)
  py -X utf8 fomi_nblm_phase1.py run --ch 1,2   # 逐章生成
"""
from __future__ import annotations

import argparse
import asyncio
import json
import os
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.stderr.reconfigure(encoding="utf-8", errors="replace")
os.environ.setdefault("NOTEBOOKLM_TRANSPORT", "curl_cffi")

WS = Path(r"E:\AI-Station\07 任务\福米电站EPC管理策划\05 Super-Skill工作区")
DOCKET = WS / "RESEARCH_DOCKET"
UPLOAD = WS / "nblm_upload"
OUT = WS / "nblm_out"
STATE = WS / "nblm_state.json"
REPORT = "几内亚福米水电站EPC建设管理策划方案"
PX = os.environ.get("NBLM_PROXY", "http://127.0.0.1:7892")
for _k in ("http_proxy", "https_proxy", "HTTP_PROXY", "HTTPS_PROXY"):
    os.environ.pop(_k, None)
os.environ["HTTP_PROXY"] = PX
os.environ["HTTPS_PROXY"] = PX

CJK_GATE = 1800
MAX_EXT = 2
SRC_PER_CH = 8


def cjk_len(t: str) -> int:
    return len(re.findall(r"[一-鿿]", t or ""))


def load_state() -> dict:
    base = {"notebooks": {}, "chapters": {}}
    if STATE.is_file():
        try:
            loaded = json.loads(STATE.read_text(encoding="utf-8"))
            if isinstance(loaded, dict):
                base.update(loaded)
                base.setdefault("notebooks", {})
                base.setdefault("chapters", {})
        except Exception:
            pass
    return base


def save_state(st: dict) -> None:
    STATE.write_text(json.dumps(st, ensure_ascii=False, indent=1),
                     encoding="utf-8")


# ---------- ① 框架解析 ----------
def parse_framework() -> list:
    fw = (OUT / "00_框架.md").read_text(encoding="utf-8")
    chapters = []
    blocks = re.split(r"(?m)^##\s+", fw)
    for b in blocks[1:]:
        lines = b.strip().splitlines()
        head = lines[0].strip()
        m = re.match(r"第(\d+)章\s*(.+)", head)
        if not m:
            continue
        responds = ""
        secs = []
        for ln in lines[1:]:
            ln = ln.strip()
            if ln.startswith("本章回应"):
                responds = ln
            elif ln.startswith("-") and len(ln) > 3:
                secs.append(ln.lstrip("- ").strip())
        chapters.append({"no": int(m.group(1)), "title": m.group(2).strip(),
                         "responds": responds, "sections": secs})
    return chapters


# ---------- ② 章包: 关键词自动选源 ----------
def load_rows() -> list:
    rows = []
    s2 = DOCKET / "synth" / "S2_黄河院素材台账.md"
    if s2.is_file():
        for ln in s2.read_text(encoding="utf-8").splitlines():
            if ln.startswith("|") and "──" not in ln and ln.count("|") >= 3:
                rows.append({"kind": "S2台账", "text": ln})
    for grp, d in (("精读", "readers"), ("研究", "researchers"),
                   ("深学", "deep"), ("二轮", "researchers_round2")):
        p = DOCKET / d
        if not p.is_dir():
            continue
        for f in sorted(p.glob("*.json")):
            try:
                o = json.loads(f.read_text(encoding="utf-8"))
            except Exception:
                continue
            if not isinstance(o, dict):
                continue
            for k in ("key_facts", "facts_with_source", "evidence_quotes",
                      "quantitative_facts", "reusable_material",
                      "key_findings", "criteria_map", "decisions_resolved"):
                for x in o.get(k) or []:
                    rows.append({"kind": grp + ":" + k, "text": str(x)})
    return rows


def score_row(row: dict, ch: dict) -> int:
    kw = ch["title"] + " " + ch.get("responds", "") + " " + " ".join(ch["sections"])
    kws = [w for w in re.split(r"[^\u4e00-\u9fffA-Za-z0-9]+", kw)
           if len(w) >= 2]
    t = row["text"]
    s = sum(2 for w in set(kws) if w in t)
    if re.search(r"福米|几内亚|Fomi|Niandan", t):
        s += 2
    return s


def pack_chapters() -> int:
    chapters = parse_framework()
    if not chapters:
        print("[pack] 框架未解析出章 — 检查 nblm_out/00_框架.md")
        return 1
    (WS / "chapters_nblm.json").write_text(
        json.dumps(chapters, ensure_ascii=False, indent=1), encoding="utf-8")
    rows = load_rows()
    print(f"[pack] 章 {len(chapters)} | 候选行 {len(rows)}")
    for ch in chapters:
        nn = f"{ch['no']:02d}"
        d = UPLOAD / f"ch{nn}_笔记本"
        d.mkdir(parents=True, exist_ok=True)
        scored = sorted(((score_row(r, ch), i, r) for i, r in enumerate(rows)),
                        key=lambda x: -x[0])
        picked, seen = [], set()
        for s, i, r in scored:
            if s < 3 or len(picked) >= SRC_PER_CH:
                break
            key = r["text"][:80]
            if key in seen:
                continue
            seen.add(key)
            picked.append(r)
        body = [f"# 第{ch['no']}章「{ch['title']}」定向素材包\n",
                f"> 本章回应: {ch.get('responds','')}\n",
                "> 以下各行素材均取自项目实证档案与研究台账, 数字与表述以原文为准。\n"]
        for r in picked:
            body.append(f"\n[{r['kind']}] {r['text']}")
        fp = d / "01_章定向素材.md"
        if not fp.exists():
            fp.write_text("\n".join(body), encoding="utf-8")
        # 固定辅源: 数字基准表 + 该章框架块
        aux = d / "02_数字基准表.md"
        if not aux.exists():
            src = DOCKET / "synth" / "数字基准表.md"
            if src.is_file():
                aux.write_text(src.read_text(encoding="utf-8"), encoding="utf-8")
        fwsrc = d / "03_框架本章块.md"
        fwsrc.write_text(
            f"# 第{ch['no']}章 {ch['title']}\n\n{ch.get('responds','')}\n\n"
            + "\n".join("- " + s for s in ch["sections"]) + "\n",
            encoding="utf-8")
        print(f"[pack] ch{nn} {ch['title'][:24]} 素材{len(picked)}行 "
              f"{fp.stat().st_size:,}B")
    return 0


# ---------- ③ 章生成 ----------
def chapter_prompt(ch: dict, part: int, total_parts: int) -> str:
    base = (
        f"你是世界顶级国际工程咨询公司资深合伙人。基于本笔记本全部资料，撰写《{REPORT}》"
        f"第{ch['no']}章「{ch['title']}」。本章回应: {ch.get('responds','')}。"
        f"小节要点:\n" + "\n".join("- " + s for s in ch["sections"]) +
        "\n硬性要求:\n"
        "1)只使用资料中出现的事实与数字, 禁止编造; 资料不足处写【待供给: 需什么】;\n"
        "2)数字一律照抄数字基准表/可研/施组口径, 不确定的写【待核】;\n"
        "3)专业精炼, 干货导向, 不写空话; 每个小节配表格或要点清单优先;\n"
        "4)简体中文markdown, 用「## {no}.{i} 小节名」编号;\n")
    if part == 1:
        return base + (f"5)本次只写本章前半部分(第1-{max(1, (len(ch['sections'])+1)//2)}小节), "
                       "结尾注明【待续】;")
    return base + (f"5)本次接着写本章后半部分(承接上文, 从第{max(1, (len(ch['sections'])+1)//2+1)}小节起), "
                   "不要重复已写内容, 不要重写前半;")


async def get_client():
    from notebooklm import NotebookLMClient
    for i in range(2):
        try:
            return await NotebookLMClient.from_storage(timeout=120.0)
        except Exception as e:                     # noqa: BLE001
            if i:
                raise
            print("[auth] 失败(%s) 冷却300s: %s" % (type(e).__name__, str(e)[:80]))
            await asyncio.sleep(300)


async def ensure_notebook(client, st: dict, nn: str, title: str) -> str:
    key = "ch" + nn
    nb_id = st["notebooks"].get(key)
    if nb_id:
        return nb_id
    try:
        for n in await client.notebooks.list():
            if str(getattr(n, "title", "")) == title:
                st["notebooks"][key] = n.id
                save_state(st)
                return n.id
    except Exception:
        pass
    nb = await client.notebooks.create(title=title)
    st["notebooks"][key] = nb.id
    save_state(st)
    return nb.id


async def upload_dir(client, nb_id: str, d: Path) -> None:
    files = sorted(f for f in d.iterdir()
                   if f.suffix.lower() in (".md", ".txt", ".pdf"))
    exist = {s.title for s in await client.sources.list(nb_id)}
    for f in files:
        title = f.stem[:80]
        if title in exist:
            continue
        for att in range(3):
            try:
                await client.sources.add_file(nb_id, f, title=title)
                print("[up] ch ← " + f.name[:50])
                break
            except Exception as e:                 # noqa: BLE001
                print("[up!] %s 第%d次 %s" % (f.name[:36], att + 1,
                                               str(e)[:60]))
                await asyncio.sleep(20 * (att + 1))
        await asyncio.sleep(3)


async def gen_chapter(st: dict, ch: dict) -> None:
    nn = f"{ch['no']:02d}"
    from notebooklm import NotebookLMClient
    async with await NotebookLMClient.from_storage(timeout=120.0) as client:
        nb_id = await ensure_notebook(client, st, nn,
                                      f"FOMI-第14役-ch{nn}-{ch['title'][:16]}")
        await upload_dir(client, nb_id, UPLOAD / f"ch{nn}_笔记本")
        parts = []
        res1 = await client.chat.ask(nb_id, chapter_prompt(ch, 1, 2))
        parts.append(res1.answer)
        await asyncio.sleep(5)
        res2 = await client.chat.ask(nb_id, chapter_prompt(ch, 2, 2))
        parts.append(res2.answer)
        text = "\n\n".join(parts)
        for ext in range(MAX_EXT):
            if cjk_len(text) >= CJK_GATE:
                break
            res = await client.chat.ask(nb_id,
                "继续充实本章: 只在不重复已有内容的前提下, 对最薄弱的小节补充资料中的"
                "事实/表格/数字; 禁止新编数字; 输出补写段落。")
            text += "\n\n" + res.answer
            await asyncio.sleep(5)
        OUT.mkdir(exist_ok=True)
        (OUT / f"_ch{nn}.md").write_text(text, encoding="utf-8")
        st["chapters"][nn] = {"ts": time.strftime("%F %T"),
                              "cjk": cjk_len(text),
                              "conv": res1.conversation_id}
        save_state(st)
        print(f"[OK] ch{nn} {ch['title'][:20]} CJK {cjk_len(text)} → _ch{nn}.md")


async def run_chapters(which: list) -> None:
    chapters = json.loads((WS / "chapters_nblm.json")
                          .read_text(encoding="utf-8"))
    st = load_state()
    for ch in chapters:
        if which and ch["no"] not in which:
            continue
        nn = f"{ch['no']:02d}"
        if st["chapters"].get(nn, {}).get("cjk", 0) >= CJK_GATE \
                and (OUT / f"_ch{nn}.md").is_file():
            print(f"[skip] ch{nn} 已达标")
            continue
        for att in range(3):
            try:
                await gen_chapter(st, ch)
                break
            except Exception as e:                 # noqa: BLE001
                print(f"[ch{nn}!] 第{att+1}次失败 {type(e).__name__} "
                      f"{str(e)[:80]} — 冷却300s")
                await asyncio.sleep(300)


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("mode", choices=["pack", "run"])
    ap.add_argument("--ch", default="")
    ns = ap.parse_args()
    if ns.mode == "pack":
        return pack_chapters()
    which = [int(x) for x in re.split(r"[,，]", ns.ch) if x.strip()] \
        if ns.ch else []
    asyncio.run(run_chapters(which))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
