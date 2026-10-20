# -*- coding: utf-8 -*-
"""sched_nblm_run — SCHED NotebookLM 产线编排器 (1020用户产线).

通道三件套内置: 美国02出口(Clash API) + 工厂auth + 代理env。
相A 框架: 建笔记本→上传00_框架笔记本源→工厂v2.0框架词→存 nblm_out/00_框架.md
相B 章节: --chapters 逐章建本→上传→v3.0章词→存 nblm_out/chNN_初稿.md
状态: nblm_state.json (笔记本id/已传源/会话) 幂等续跑。
用法: py -X utf8 sched_nblm_run.py [--phase framework|chapters] [--chapters 1,2]
"""
from __future__ import annotations

import argparse
import asyncio
import json
import os
import sys
import time
import urllib.request
from pathlib import Path
from urllib.parse import quote

# ---- 通道三件套(先于 notebooklm 导入) ----
os.environ.setdefault("HTTP_PROXY", "http://127.0.0.1:7890")
os.environ.setdefault("HTTPS_PROXY", "http://127.0.0.1:7890")

M2 = Path(__file__).resolve().parent
SCHED = M2 / "sched"
UPLOAD = SCHED / "nblm_upload"
OUT = SCHED / "nblm_out"
STATE_P = SCHED / "nblm_state.json"
PROMPTS = Path(
    r"E:\AI-Station\ResearchFactory-Eng\04 参考指令")
CLASH_SECRET = "d42f2047-3a9e-45a1-9e1c-b6a91441588f"
CLASH = "http://127.0.0.1:53401"
OK_NODE = "🇺🇸 美国 02"


def clash_put(group: str, node: str) -> None:
    req = urllib.request.Request(
        f"{CLASH}/proxies/{quote(group)}", method="PUT",
        headers={"Authorization": "Bearer " + CLASH_SECRET,
                 "Content-Type": "application/json"},
        data=json.dumps({"name": node}).encode())
    try:
        with urllib.request.urlopen(req, timeout=8) as r:
            r.read()
    except Exception as e:  # noqa: BLE001
        print(f"[clash] 切换 {group}→{node} 异常: {e}")


def load_state() -> dict:
    if STATE_P.is_file():
        return json.loads(STATE_P.read_text(encoding="utf-8"))
    return {"notebooks": {}, "framework": None}


def save_state(st: dict) -> None:
    STATE_P.write_text(
        json.dumps(st, ensure_ascii=False, indent=1), encoding="utf-8")


async def get_client():
    from notebooklm import NotebookLMClient
    return NotebookLMClient.from_storage()


async def ensure_notebook(client, st: dict, key: str, title: str) -> str:
    nb_id = st["notebooks"].get(key)
    if nb_id:
        return nb_id
    nb = await client.notebooks.create(title=title)
    st["notebooks"][key] = nb.id
    save_state(st)
    print(f"[nb] 建 {title} → {nb.id}")
    return nb.id


async def upload_dir(client, nb_id: str, d: Path, tag: str) -> int:
    files = sorted([f for f in d.iterdir()
                    if f.suffix.lower() in (".md", ".txt", ".pdf")])
    exist = {s.title for s in await client.sources.list(nb_id)}
    n = 0
    for f in files:
        title = f.stem[:80]
        if title in exist:
            continue
        await client.sources.add_file(nb_id, f, title=title)
        n += 1
        print(f"[up] {tag} ← {f.name[:60]}")
        await asyncio.sleep(2)
    # 轮询直至全部源就绪
    for _ in range(120):
        srcs = await client.sources.list(nb_id)
        st = [str(getattr(s, "status", "")).lower() for s in srcs]
        if st and all(x in ("ready", "complete", "ok") or "fail" in x
                      for x in st):
            break
        await asyncio.sleep(5)
    return len(files)


def framework_prompt() -> str:
    return (
        "你是工程建设行业战略咨询总监。基于本笔记本全部资料，为"
        "《工程工期管理与延误索赔实战指南·2026版》设计12章目录框架。"
        "读者是中国施工企业的项目经理、商务、造价与法务人员。要求："
        "1)每章标题用判断句而非名词堆砌；2)每章列出本章解决的读者问题"
        "与3-6个小节要点；3)按读者认知路径排序(经济账→规则→计划→管控→"
        "归责→证据→索赔→计算→判例→组织→国际→趋势)；4)注明每章建议"
        "引用的资料主题；5)全部简体中文输出，不超过3000字。")


def chapter_prompt(ch: dict) -> str:
    return (
        f"你是资深工程咨询研究专家。基于本笔记本全部资料，撰写"
        f"《工程工期管理与延误索赔实战指南·2026版》第{ch['no']}章"
        f"「{ch['title']}」完整初稿。读者：中国施工企业的项目经理、商务、"
        f"造价与法务人员。要求：1)开篇一段说明本章帮读者解决什么问题；"
        f"2)按小节展开，判例写清案情-裁判-教训，方法给可执行步骤；"
        f"3)所有数字与案例必须来自笔记本资料，句末标注来源编号；"
        f"4)语言平实具体，不用计算机术语，不用空话套话；5)章末附"
        f"「小结要点」与「本章证据边界」。本章主题词："
        f"{'、'.join(ch['kws'])}。请输出本章前半部分(约6000字)，"
        f"我随后会说「继续」要后半部分。")


async def phase_framework(st: dict) -> None:
    OUT.mkdir(exist_ok=True)
    async with await get_client() as client:
        nb_id = await ensure_notebook(
            client, st, "framework", "SCHED-工期报告-00框架")
        n = await upload_dir(client, nb_id, UPLOAD / "00_框架笔记本", "框架")
        print(f"[nb] 框架本源数: {n}, 开始生成框架…")
        res = await client.chat.ask(nb_id, framework_prompt())
        (OUT / "00_框架.md").write_text(res.answer, encoding="utf-8")
        st["framework"] = {"conversation_id": res.conversation_id,
                           "ts": time.strftime("%F %T")}
        save_state(st)
        print(f"[✅] 框架已存 nblm_out/00_框架.md "
              f"({len(res.answer):,}字)")


async def phase_chapters(st: dict, nums: list[int]) -> None:
    chs = json.loads((SCHED / "chapters.json").read_text(encoding="utf-8"))
    async with await get_client() as client:
        for ch in chs:
            if ch["no"] not in nums:
                continue
            key = f"ch{ch['no']:02d}"
            nb_id = await ensure_notebook(
                client, st, key,
                f"SCHED-工期报告-第{ch['no']}章-{ch['title'][:12]}")
            d = UPLOAD / f"ch{ch['no']:02d}_笔记本"
            await upload_dir(client, nb_id, d, key)
            print(f"[nb] {key} 生成章稿…")
            res = await client.chat.ask(nb_id, chapter_prompt(ch))
            parts = [res.answer]
            conv = res.conversation_id
            for k in range(2):          # 两次「继续」拿后半部
                await asyncio.sleep(4)
                try:
                    r2 = await client.chat.ask(
                        nb_id, "继续，按同样要求输出本章后续部分(约5000字)，"
                               "句末继续标注来源编号。",
                        conversation_id=conv)
                    parts.append(r2.answer)
                    conv = r2.conversation_id or conv
                except Exception as e:  # noqa: BLE001
                    print(f"[!] {key} 续写{k+1} 失败: {e}")
                    break
            out = OUT / f"ch{ch['no']:02d}_初稿.md"
            out.write_text("\n\n".join(parts), encoding="utf-8")
            st.setdefault("chapters", {})[str(ch["no"])] = {
                "conversation_id": conv,
                "ts": time.strftime("%F %T")}
            save_state(st)
            total = sum(len(p) for p in parts)
            print(f"[✅] 第{ch['no']}章初稿 {total:,}字 "
                  f"({len(parts)}段) → {out.name}")
            await asyncio.sleep(5)


async def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser()
    ap.add_argument("--phase", default="framework",
                    choices=["framework", "chapters"])
    ap.add_argument("--chapters", default="")
    ns = ap.parse_args()
    clash_put("默认节点", OK_NODE)          # 通道保证
    time.sleep(2)
    st = load_state()
    if ns.phase == "framework":
        await phase_framework(st)
    else:
        nums = [int(x) for x in ns.chapters.split(",") if x.strip()] \
            or list(range(1, 13))
        await phase_chapters(st, nums)
    return 0


if __name__ == "__main__":
    raise SystemExit(asyncio.run(main()))
