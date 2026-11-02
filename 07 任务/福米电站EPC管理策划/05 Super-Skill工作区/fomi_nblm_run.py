# -*- coding: utf-8 -*-
"""fomi_nblm_run - FOMI-EPC NBLM 产线 Phase 0 (框架) 运行器.
照 caselaw_nblm_run 公式: 7892 通道 + curl_cffi + from_storage 保活单车道 + 梯式重试.
铁律: 通道锁定不轮换; 数字零造假; 只新增不删除; 幂等(state).
用法: py -X utf8 fomi_nblm_run.py --check | --phase framework
"""
from __future__ import annotations

import argparse
import asyncio
import json
import os
import re
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.stderr.reconfigure(encoding="utf-8", errors="replace")
os.environ.setdefault("NOTEBOOKLM_TRANSPORT", "curl_cffi")

WS = Path(r"E:\AI-Station\07 任务\福米电站EPC管理策划\05 Super-Skill工作区")
UPLOAD = WS / "nblm_upload"
FW = UPLOAD / "00_战役总笔记本"
OUT = WS / "nblm_out"
STATE = WS / "nblm_state.json"
REPORT = "几内亚福米水电站EPC建设管理策划方案"
NB_TITLE = "FOMI-第14役-00战役总笔记本"
PX = os.environ.get("NBLM_PROXY", "http://127.0.0.1:7892")
for _k in ("http_proxy", "https_proxy", "HTTP_PROXY", "HTTPS_PROXY"):
    os.environ.pop(_k, None)
os.environ["HTTP_PROXY"] = PX
os.environ["HTTPS_PROXY"] = PX


def load_state() -> dict:
    if STATE.is_file():
        try:
            return json.loads(STATE.read_text(encoding="utf-8"))
        except Exception:
            pass
    return {"notebooks": {}}


def save_state(st: dict) -> None:
    STATE.write_text(json.dumps(st, ensure_ascii=False, indent=1),
                     encoding="utf-8")


def nb_reachable() -> bool:
    r = subprocess.run(
        ["curl", "-s", "-m", "15", "-x", PX, "-o", os.devnull,
         "-w", "%{http_code}|%{redirect_url}",
         "https://notebooklm.google.com"],
        capture_output=True, text=True, timeout=25)
    parts = r.stdout.strip().split("|")
    code = parts[0] if parts else "000"
    redir = parts[1] if len(parts) > 1 else ""
    ok = code in ("200", "301", "302", "303", "307", "308") \
        and "unsupported" not in redir
    print("[conn] NB via %s: http=%s redirect=%s -> %s"
          % (PX, code, redir[:60], "可达" if ok else "不可达"))
    return ok


async def get_client():
    from notebooklm import NotebookLMClient
    return await NotebookLMClient.from_storage(timeout=120.0)


async def ensure_notebook(client, st: dict) -> str:
    nb_id = st["notebooks"].get("framework")
    if nb_id:
        return nb_id
    try:
        for n in await client.notebooks.list():
            if str(getattr(n, "title", "")) == NB_TITLE:
                st["notebooks"]["framework"] = n.id
                save_state(st)
                print("[nb] 复用既有 %s → %s" % (NB_TITLE, n.id))
                return n.id
    except Exception as e:                         # noqa: BLE001
        print("[nb] list 失败(%s)" % type(e).__name__)
    for att in range(3):
        try:
            nb = await client.notebooks.create(title=NB_TITLE)
            st["notebooks"]["framework"] = nb.id
            save_state(st)
            print("[nb] 建 %s → %s" % (NB_TITLE, nb.id))
            return nb.id
        except Exception as e:                     # noqa: BLE001
            print("[nb!] 建本第%d次失败: %s %s" % (att + 1, type(e).__name__,
                                                   str(e)[:70]))
            await asyncio.sleep(20 * (att + 1))
    raise RuntimeError("建本失败")


async def upload_dir_3s(client, nb_id: str) -> tuple:
    files = sorted([f for f in FW.iterdir()
                    if f.suffix.lower() in (".md", ".txt", ".pdf")])
    exist = {s.title for s in await client.sources.list(nb_id)}
    exist |= {os.path.splitext(t)[0] for t in tuple(exist)}
    n = 0
    for f in files:
        title = f.stem[:80]
        if title in exist:
            continue
        ok = False
        for att in range(3):
            try:
                await client.sources.add_file(nb_id, f, title=title)
                ok = True
                break
            except Exception as e:                 # noqa: BLE001
                print("[up!] %s 第%d次: %s %s" % (f.name[:44], att + 1,
                                                   type(e).__name__,
                                                   str(e)[:60]))
                await asyncio.sleep(20 * (att + 1))
        if ok:
            n += 1
            print("[up] ← " + f.name[:60])
            await asyncio.sleep(3)
        else:
            print("[skip] " + f.name[:44])
    for _ in range(120):
        srcs = await client.sources.list(nb_id)
        sts = [str(getattr(s, "status", "")).lower() for s in srcs]
        if sts and all(any(k in x for k in ("ready", "complete", "ok", "fail"))
                       for x in sts):
            break
        await asyncio.sleep(5)
    final = {s.title for s in await client.sources.list(nb_id)}
    present = sum(1 for f in files if f.stem[:80] in final)
    return len(files), present


STORM = """【多视角问题框架(前置)】
- 工行审贷官问：这个停了十年的项目凭什么能干成？钱不够怎么办？超支谁兜底？设计院管得住施工分包吗？
- 几内亚业主问：工期承诺可信吗？本地就业与技术转移有多少？移民环保谁负责？
- 黄河院项目经理问：设计牵头EPC的组织怎么搭？雨季与物流怎么排？风险哪十条最致命？
- 水电三局问：与总包的界面和结算规则？设备采购谁主导？
- 独立工程师问：进度与成本的基线和考核口径是否可核查？证据留存机制？
- 当地社区问：用工、道路、生态补偿怎么安排？
---


"""


def framework_prompt() -> str:
    return STORM + (
        "你是世界顶级国际工程咨询公司的资深合伙人，曾主导多个非洲大型水电EPC项目的"
        "项目管理策划。基于本笔记本全部资料，为《" + REPORT + "》设计目录框架。"
        "背景：本方案是中国工商银行融资审查的关键支撑文件——工行对'设计院牵头EPC总"
        "承包能力'存疑，方案必须用黄河勘测规划设计研究院的真实资质、业绩、体系与数字化"
        "能力打消疑虑，同时可指导工程实施。读者：工行审贷委员会（非工程专业）为第一读者，"
        "几内亚业主方与公司内部为第二读者。要求："
        "1)开篇为'综合说明'（执行摘要：疑虑导航+量化承诺的一页式驾驶舱）；"
        "2)总体15-18章，每章标题用判断句而非名词堆砌；每章列出本章回应的读者疑虑与"
        "3-6个小节要点；"
        "3)必须覆盖：项目理解与几内亚实施条件、承包商能力陈述（黄河院资质业绩体系）、"
        "风险管理、组织与专家团队、进度、设计管理（设计牵头EPC价值）、采购与海运清关"
        "物流、施工管理、试运行移交与运维衔接、质量、HSE、属地合规与社会管理（海外"
        "专章）、合同资金税务、沟通相关方、数字化（数字总包平台+AI眼镜）；"
        "4)每章注明建议引用的资料主题（可研章节/施组/素材台账条目/对标标准）；"
        "5)对标基因：GB/T 50358-2017全覆盖并超越、PMBOK绩效域、PMI与IPMA大奖标准；"
        "6)输出用简体中文markdown，每章一块以「## 第N章 章标题」开头，下一行"
        "「本章回应：…」，再以- 开头列出小节要点；全文不超过3200字。")


async def ask_retry(client, nb_id: str, question: str, attempts: int = 3):
    last = None
    for i in range(attempts):
        try:
            return await client.chat.ask(nb_id, question)
        except Exception as e:                     # noqa: BLE001
            last = e
            print("[retry] ask 第%d次失败: %s %s" % (i + 1, type(e).__name__,
                                                     str(e)[:80]))
            await asyncio.sleep(15 * (i + 1))
    raise last


async def upload_only(st: dict) -> None:
    """补传 300 全量包到战役总笔记本 (用户令: ≤300文件/本)."""
    from notebooklm import NotebookLMClient
    async with await NotebookLMClient.from_storage(timeout=120.0) as client:
        nb_id = await ensure_notebook(client, st)
        total, present = await upload_dir_3s(client, nb_id)
        print("[up-phase] 总本源数 %d/%d (上限300纪律)" % (present, total))


async def framework_once(st: dict) -> bool:
    from notebooklm import NotebookLMClient
    async with await NotebookLMClient.from_storage(timeout=120.0) as client:
        nb_id = await ensure_notebook(client, st)
        total, present = await upload_dir_3s(client, nb_id)
        print("[nb] 总本源数 %d/%d, 开始生成框架…" % (present, total))
        res = await ask_retry(client, nb_id, framework_prompt())
        OUT.mkdir(exist_ok=True)
        (OUT / "00_框架.md").write_text(res.answer, encoding="utf-8")
        st["framework"] = {"conversation_id": res.conversation_id,
                           "ts": time.strftime("%F %T"), "sources": present}
        save_state(st)
        cjk = len(re.findall(r"[一-鿿]", res.answer))
        print("[OK] 框架已存 nblm_out/00_框架.md (%s字, CJK %d)"
              % (f"{len(res.answer):,}", cjk))
        return True


async def phase_framework() -> None:
    st = load_state()
    if st.get("framework") and (OUT / "00_框架.md").is_file():
        print("[skip] 框架已落账")
        return
    if not nb_reachable():
        print("[abort] NB 不可达 — 不硬跑 (铁律)")
        return
    for attempt in range(6):
        try:
            await framework_once(st)
            return
        except Exception as e:                     # noqa: BLE001
            print("[fw!] 第%d次失败: %s %s — 冷却420s"
                  % (attempt + 1, type(e).__name__, str(e)[:90]), flush=True)
            await asyncio.sleep(420)
    print("[fw] 6试未成 — 留state后续跑")


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--check", action="store_true")
    ap.add_argument("--phase", default="")
    ns = ap.parse_args()
    if ns.check:
        return 0 if nb_reachable() else 1
    if ns.phase == "framework":
        asyncio.run(phase_framework())
        return 0
    if ns.phase == "upload":
        if not nb_reachable():
            print("[abort] NB 不可达 — 不硬跑 (铁律)")
            return 1
        asyncio.run(upload_only(load_state()))
        return 0
    print(__doc__)
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
