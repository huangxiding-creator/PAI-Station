# -*- coding: utf-8 -*-
"""caselaw_nblm_run - 第12份 EPC-CASELAW NBLM 产线编排器 (照 JIAGE/TOP50 验证线合流).

通道公式 (任务令 + nblm_conn_state.json 1026 锁定态): 美国04出口锁定 + 认证态
  default profile + curl_cffi TLS 仿装 (NOTEBOOKLM_TRANSPORT=curl_cffi)
  + 单会话承载 + session keeper 保活 (keepalive=60, 并发=1 单车道).
铁律: 通道锁定不轮换国家; NBLM 云端草稿如实提取不美化; 数字零造假 (案号/数字
  必须照抄资料原文); 零浏览器; 续写必带指向 (双版缺陷门); 幂等续跑 (state);
  只新增不删除文件.
Phase 0 框架: 00_战役总笔记本(12源) + STORM多视角前置 → 00_框架.md
  → chapters_nblm.json (权威目录账).
Phase 1 各章: 逐章上传(源齐门) → 章prompt → 分段指向生成(4段+CJK门扩写轮)
  → dupcheck → 提取 _chNN_nblm.md → 三武器逐章审计 (sp/cv/ar).
用法 (须用 Python313F, ope venv 无 notebooklm):
  C:/.../Python313F/python.exe -X utf8 caselaw_nblm_run.py --check
  C:/.../Python313F/python.exe -X utf8 caselaw_nblm_run.py --phase framework
  C:/.../Python313F/python.exe -X utf8 caselaw_nblm_run.py --phase chapters --chapters 1,2
  C:/.../Python313F/python.exe -X utf8 caselaw_nblm_run.py --phase weapons
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
import urllib.request
from pathlib import Path
from urllib.parse import quote

os.environ.setdefault("NOTEBOOKLM_TRANSPORT", "curl_cffi")
_here = Path(__file__).resolve().parent
os.environ.setdefault("NBLM_SCHED_DIR", str(_here / "sched"))

M2 = _here.parent
REPO = M2.parents[1]
sys.path.insert(0, str(M2))
import sched_nblm_run as base                       # noqa: E402

# 通道: 默认共享内核 7892 (JIAGE/TOP50 锁定公式); env NBLM_PROXY 可覆盖.
# Windows env 键名不分大小写 — 必须先清后设, 顺序反了 = 无代理直连 (1029修).
_NBLM_PROXY = os.environ.get("NBLM_PROXY", "http://127.0.0.1:7892")
for _k in ("http_proxy", "https_proxy", "HTTP_PROXY", "HTTPS_PROXY"):
    os.environ.pop(_k, None)
os.environ["HTTP_PROXY"] = _NBLM_PROXY
os.environ["HTTPS_PROXY"] = _NBLM_PROXY

SCHED, UPLOAD, OUT = base.SCHED, base.UPLOAD, base.OUT
FW_DIR = UPLOAD / "00_战役总笔记本"
RF = Path(r"E:\AI-Station\reforge_factory")
PX = _NBLM_PROXY
REPORT = "工程造价争议判例谱系与调解实务研究报告·2026"
BUYERS = "工程造价工程师、商务经理、工程法务与建工律师"
CAMPAIGN = "EPC-CASELAW"
CJK_GATE = 15000                  # 章稿 CJK 门 (1.5万; 无门循环=退化段根因)
MAX_EXT_ROUNDS = 3                # 达门前定向扩写轮上限
NB_TITLE = "CASELAW-第12份-00战役总笔记本"


def cjk_len(t: str) -> int:
    return len(re.findall(r"[一-鿿]", t))


# ---------- session keeper 保活客户端 (JIAGE 1026 公式) ----------
async def get_client(attempts: int | None = None):
    """from_storage 带长退避重试 + keepalive=60 保活 + 并发=1 单车道
    (1026 实测: BD上游限制并发握手; Google 边缘对出口IP 首个 from_storage
    一次性放行 — 失败冷却 300s×n 再试, 不轮换出口)."""
    from notebooklm import NotebookLMClient
    from notebooklm.types import ConnectionLimits
    if attempts is None:
        attempts = int(os.environ.get("NBLM_AUTH_ATTEMPTS", "2"))
    last = None
    for i in range(attempts):
        try:
            return await NotebookLMClient.from_storage(
                timeout=120.0, keepalive=60.0,
                limits=ConnectionLimits(max_connections=2,
                                        max_keepalive_connections=2,
                                        keepalive_expiry=120.0),
                max_concurrent_uploads=1, max_concurrent_rpcs=1)
        except Exception as e:  # noqa: BLE001
            last = e
            if i + 1 >= attempts:
                break
            wait = 300 * (i + 1)
            print(f"[auth] from_storage 第{i+1}次失败({type(e).__name__}: "
                  f"{str(e)[:90]}) — 冷却{wait}s 后重试 (不切出口)", flush=True)
            await asyncio.sleep(wait)
    raise last


async def ensure_notebook(client, st: dict, key: str, title: str) -> str:
    """JIAGE 型: state 命中直用; 否则先按题复用防重本 (超时但服务端已建)."""
    nb_id = st["notebooks"].get(key)
    if nb_id:
        return nb_id
    try:
        for n in await client.notebooks.list():
            if str(getattr(n, "title", "")) == title:
                st["notebooks"][key] = n.id
                base.save_state(st)
                print(f"[nb] 复用既有 {title} → {n.id}")
                return n.id
    except Exception as e:  # noqa: BLE001
        print(f"[nb] list 复用检查失败({type(e).__name__}): {str(e)[:60]}")
    last = None
    for att in range(3):
        try:
            nb = await client.notebooks.create(title=title)
            st["notebooks"][key] = nb.id
            base.save_state(st)
            print(f"[nb] 建 {title} → {nb.id}")
            return nb.id
        except Exception as e:  # noqa: BLE001
            last = e
            print(f"[nb!] 建本第{att+1}次失败: {type(e).__name__} {str(e)[:70]}")
            await asyncio.sleep(20 * (att + 1))
    raise last


async def upload_dir_3s(client, nb_id: str, d: Path, tag: str) -> tuple:
    """TOP50v6: (包文件数, 在场源数); 3s 节流 + 双名匹配防配额爆仓 + 就绪轮询."""
    files = sorted([f for f in d.iterdir()
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
            except Exception as e:  # noqa: BLE001
                print("[up!] " + f.name[:44] + " 第" + str(att + 1) + "次: "
                      + type(e).__name__ + " " + str(e)[:60])
                await asyncio.sleep(20 * (att + 1))
        if ok:
            n += 1
            print("[up] " + tag + " ← " + f.name[:60])
            await asyncio.sleep(3)
        else:
            print("[skip] " + f.name[:44] + " 三次失败, 跳过")
    for _ in range(120):
        srcs = await client.sources.list(nb_id)
        sts = [str(getattr(s, "status", "")).lower() for s in srcs]
        if sts and all(any(k in x for k in ("ready", "complete", "ok", "fail"))
                       for x in sts):
            break
        await asyncio.sleep(5)
    final = {s.title for s in await client.sources.list(nb_id)}
    final |= {os.path.splitext(t)[0] for t in tuple(final)}
    present = sum(1 for f in files if f.stem[:80] in final)
    return len(files), present


async def ask_retry(client, nb_id: str, question: str, conv=None, attempts: int = 3):
    last = None
    for i in range(attempts):
        try:
            if conv:
                return await client.chat.ask(nb_id, question, conversation_id=conv)
            return await client.chat.ask(nb_id, question)
        except Exception as e:  # noqa: BLE001
            last = e
            print(f"[retry] ask 第{i+1}次失败: {type(e).__name__} {str(e)[:80]}")
            await asyncio.sleep(15 * (i + 1))
    raise last


# ---------- STORM 前置 ----------
def ensure_storm() -> None:
    src = _here / "00_多视角问题框架.md"
    dst = OUT / "00_多视角问题框架.md"
    if src.is_file() and not dst.exists():
        OUT.mkdir(exist_ok=True)
        dst.write_text(src.read_text(encoding="utf-8"), encoding="utf-8")
        print("[storm] 框架前置文件就位 -> " + str(dst))


def storm_head() -> str:
    sf = OUT / "00_多视角问题框架.md"
    if not sf.is_file():
        return ""
    block = sf.read_text(encoding="utf-8", errors="replace").strip()
    head = block[:2600] + ("\n(超长截断)" if len(block) > 2600 else "")
    print("[storm] 前置多视角问题块 (" + f"{len(block):,}" + "字, 取前2600)")
    return head + "\n\n---\n\n"


# ---------- 通道 (TOP50 隔离令: 只认专用内核2控制器 48899, 共享48898勿碰) ----------
def _clash_ports() -> list:
    return [48899]


def _clash_req(port: int, path: str, method: str = "GET", body: dict = None):
    req = urllib.request.Request(
        "http://127.0.0.1:" + str(port) + path, method=method,
        headers={"Authorization": "Bearer " + base.CLASH_SECRET,
                 "Content-Type": "application/json"},
        data=json.dumps(body).encode() if body else None)
    with urllib.request.urlopen(req, timeout=6) as r:
        return json.loads(r.read().decode("utf-8", "replace"))


def lock_exit_node() -> str:
    """一次性锁定美国04 (若组已在美国04则只读确认); 之后全程不切换."""
    for port in _clash_ports():
        try:
            proxies = _clash_req(port, "/proxies")
        except Exception:
            continue
        for name, info in proxies.get("proxies", {}).items():
            members = info.get("all") or []
            us04 = [m for m in members if "美国" in m and "04" in m]
            if not us04:
                continue
            cur = info.get("now", "")
            if cur in us04:
                print("[exit] 已锁定 " + cur + " (组=" + name + ", :" + str(port) + ")")
                return cur
            try:
                _clash_req(port, "/proxies/" + quote(name), "PUT", {"name": us04[0]})
                print("[exit] 一次性锁定 " + us04[0] + " (原=" + cur + ", 组=" + name
                      + ") 之后不再切换")
            except Exception as e:
                print("[exit] 切换失败(" + str(e) + ") — 保持 " + cur)
            return us04[0]
    print("[exit] 未找到含美国04的代理组控制器 — 只读保持当前出口")
    return ""


def nb_reachable() -> bool:
    r = subprocess.run(
        ["curl", "-s", "-m", "15", "-x", PX, "-o", "/dev/null",
         "-w", "%{http_code}|%{redirect_url}",
         "https://notebooklm.google.com"],
        capture_output=True, text=True, timeout=25)
    parts = r.stdout.strip().split("|")
    code = parts[0] if parts else "000"
    redir = parts[1] if len(parts) > 1 else ""
    ok = code in ("200", "301", "302", "303", "307", "308") and "unsupported" not in redir
    print("[conn] NB via " + PX + ": http=" + code + " redirect=" + redir[:60]
          + (" -> 可达" if ok else " -> 不可达"))
    return ok


# ---------- Phase 0: 框架 ----------
def framework_prompt() -> str:
    return storm_head() + (
        "你是工程建设行业首席研究总监。基于本笔记本全部资料，为《" + REPORT
        + "》设计12章实战目录框架。读者是" + BUYERS + "，报告必须同时服务三类"
        "使用场景：①争议防控（签约阶段条款设计与履约证据留痕）；②争议应对"
        "（结算审减、变更签证索赔、造价鉴定攻防）；③争议解决（调解、争议评审"
        "DAAB、仲裁与诉讼路径选择）。要求：1)每章标题用判断句而非名词堆砌；"
        "2)每章列出本章解决的读者问题与3-6个小节要点；3)按读者认知路径排序："
        "争议全景与谱系方法论→类案检索方法→固定总价→结算审减→变更签证索赔→"
        "造价鉴定→工期费用索赔→合同效力与黑白合同→优先受偿权→调解与ADR→"
        "仲裁与诉讼→判例谱系总表与行动清单；4)每章注明建议引用的资料主题"
        "（判例案号/司法解释/调解案例），并标注该章主要服务哪一场景"
        "（争议防控/争议应对/争议解决/通用）；5)输出用简体中文markdown，"
        "每章一块以「## 第N章 章标题」开头，下一行「本章解决：…」，再以"
        "- 开头列出小节要点；全文不超过3000字。")


async def phase_framework(st: dict, client) -> None:
    ensure_storm()
    OUT.mkdir(exist_ok=True)
    nb_id = await ensure_notebook(client, st, "framework", NB_TITLE)
    n = await upload_dir_3s(client, nb_id, FW_DIR, "框架")
    print("[nb] 战役总笔记本源数: " + str(n) + ", 开始生成框架…")
    res = await ask_retry(client, nb_id, framework_prompt())
    (OUT / "00_框架.md").write_text(res.answer, encoding="utf-8")
    st["framework"] = {"conversation_id": res.conversation_id,
                       "ts": time.strftime("%F %T")}
    base.save_state(st)
    print("[OK] 框架已存 nblm_out/00_框架.md (" + f"{len(res.answer):,}" + "字)")
    extract_chapters_nblm()


async def framework_with_ladder(st: dict) -> bool:
    """1029实测 Google 边缘节流窗(10-20min): 6试/420s梯, 每试新client.
    幂等: 框架已落账或 chapters_nblm.json 已在则直接过."""
    if st.get("framework") and (SCHED / "chapters_nblm.json").is_file():
        print("[skip] 框架已落账 (state.framework + chapters_nblm.json 在)")
        return True
    if (SCHED / "chapters_nblm.json").is_file():
        print("[skip] chapters_nblm.json 已在 — 框架视为完成")
        return True
    for attempt in range(6):
        try:
            async with await get_client() as client:
                await phase_framework(st, client)
            return True
        except Exception as e:  # noqa: BLE001
            last = attempt >= 5
            print("[!!] 框架第" + str(attempt + 1) + "次失败("
                  + type(e).__name__ + ": " + str(e)[:120] + ")——"
                  + ("放弃" if last else "420s后重试(新client)"), flush=True)
            if not last:
                await asyncio.sleep(420)
    return False


_CN_NUM = {"一": 1, "二": 2, "三": 3, "四": 4, "五": 5, "六": 6, "七": 7,
           "八": 8, "九": 9, "十": 10, "十一": 11, "十二": 12}


def _zh2int(s: str) -> int:
    s = s.strip()
    return int(s) if s.isdigit() else _CN_NUM.get(s, 0)


def extract_chapters_nblm() -> None:
    fp = OUT / "00_框架.md"
    if not fp.is_file():
        return
    t = fp.read_text(encoding="utf-8", errors="replace")
    chapters = []
    cur = None
    for ln in t.splitlines():
        m = re.match(r"^#{1,3}\s*(?:第\s*(\d{1,2}|[一二三四五六七八九十]{1,2})\s*章"
                     r"|(\d{1,2})[、.．])\s*「?([^「」\n]{2,40})」?", ln)
        if m:
            no = _zh2int(m.group(1) or m.group(2))
            if not no:
                continue
            cur = {"no": no, "title": m.group(3).strip(), "sections": []}
            chapters.append(cur)
            continue
        if cur is not None:
            mb = re.match(r"^\s*[-*·]\s*\*\*(\d{1,2}[.．]\d{1,2}\s*[^：:*]{2,24})"
                          r"\s*\*\*", ln)
            sec = ""
            if mb:
                sec = mb.group(1).strip()
            else:
                ms = re.match(r"^\s*(?:[-*·]|\d+[.、)]?)\s*(.{4,30})\s*$", ln)
                if ms and not ms.group(1).strip().startswith("**"):
                    sec = ms.group(1).strip()
            if sec and len(cur["sections"]) < 8:
                cur["sections"].append(sec)
    chapters = chapters[:12]
    rec = {"extracted_from": "nblm_out/00_框架.md", "count": len(chapters),
           "chapters": chapters}
    (SCHED / "chapters_nblm.json").write_text(
        json.dumps(rec, ensure_ascii=False, indent=1), encoding="utf-8")
    print("[OK] chapters_nblm.json 提取 " + str(len(chapters)) + " 章 (权威目录账)")


# ---------- Phase 1: 各章 ----------
def _outline_for(no: int) -> list:
    try:
        cj = json.loads((SCHED / "chapters_nblm.json").read_text(encoding="utf-8"))
        for c in cj.get("chapters", []):
            if c.get("no") == no:
                return c.get("sections", [])[:8]
    except Exception:
        pass
    return []


def chapter_prompt(ch: dict) -> str:
    ol = _outline_for(ch["no"])
    ol_txt = ("；小节骨架参考：" + "／".join(ol)) if ol else ""
    return (
        "你是深耕工程造价争议领域的资深研究总监。基于本笔记本全部资料，撰写《"
        + REPORT + "》第" + str(ch["no"]) + "章「" + ch["title"] + "」完整初稿"
        "（15000-20000字），读者是" + BUYERS + "。本章主题词："
        + "、".join(ch["kws"]) + "（树子问 " + ",".join(ch.get("subqs", []) or ["综合"])
        + "）。" + ol_txt
        + "要求：开篇一段说明本章帮读者解决什么问题；按小节展开——判例条目按"
        "「案情-争议焦点-裁判要点-实务教训」写清，案号与数字必须照抄资料原文，"
        "不编造不美化；方法给可执行步骤；所有案号、数字与规则表述必须来自笔记本"
        "资料，句末以[源编号]标注来源（源编号=笔记本源名称开头的两位数字）；"
        "语言平实具体面向实战，不用计算机术语与空话套话；章末附「小结要点」与"
        "「本章证据边界」。分四段生成：段1前部小节约6000字→段2中部小节约5000字"
        "（只写段1未输出的小节）→段3后部小节收束约5000字（只写仍未输出的小节，"
        "含小结要点与证据边界）→段4《源引用对照》清单。现在先输出本章前部小节"
        "（约6000字）。")


FOLLOWUPS = [
    ("继续，输出本章中部小节（约5000字）——只写前次未输出的小节，禁止重复任何"
     "已出现的小节标题与内容，句末继续标注[源编号]。"),
    ("继续，输出本章后部剩余小节并收束（约5000字）——只写仍未输出的小节，最后"
     "给出「小结要点」与「本章证据边界」，禁止重复已出现的小节标题与内容。"),
    ("本章正文已完成。现在只输出《源引用对照》清单：逐条列出本章引用的"
     "[源编号]→源资料名→对应内容摘要(每条一行)。不要重复任何正文小节。"),
]


def dupcheck(parts: list, nn: str) -> dict:
    headers: dict = {}
    for p in parts:
        for m in re.finditer(r"(?m)^#{1,4}\s*(.{4,40})$", p):
            h = m.group(1).strip()
            headers[h] = headers.get(h, 0) + 1
    duph = [h for h, n in headers.items() if n > 1]
    shingles = set()
    dup_chars = 0
    for i, p in enumerate(parts):
        s = re.sub(r"\s", "", p)
        for j in range(0, max(0, len(s) - 60), 60):
            sh = s[j:j + 60]
            if i > 0 and sh in shingles:
                dup_chars += 60
            shingles.add(sh)
    total = sum(len(re.sub(r"\s", "", p)) for p in parts)
    ratio = round(dup_chars / max(1, total), 4)
    rec = {"chapter": int(nn), "dup_headers": duph[:20],
           "cross_seg_60char_dup_ratio": ratio,
           "seg_chars": [len(p) for p in parts]}
    (OUT / ("_dupcheck_ch" + nn + ".json")).write_text(
        json.dumps(rec, ensure_ascii=False, indent=1), encoding="utf-8")
    print("[dup] ch" + nn + " 重复标题x" + str(len(duph)) + " 跨段重复率 "
          + f"{ratio:.1%}" + " -> _dupcheck_ch" + nn + ".json")
    return rec


async def gen_one(client, st: dict, ch: dict) -> None:
    from m2_write_guard import write_if_long
    no, nn = ch["no"], str(ch["no"]).zfill(2)
    out = SCHED / ("_ch" + nn + "_nblm.md")
    if out.is_file():
        old_cjk = cjk_len(out.read_text(encoding="utf-8"))
        if old_cjk >= CJK_GATE:
            print("[skip] ch" + nn + " 已有稿 CJK " + f"{old_cjk:,}"
                  + " ≥ 门 " + f"{CJK_GATE:,}")
            return
        print("[regen] ch" + nn + " 旧稿 CJK " + f"{old_cjk:,}"
              + " < 门 " + f"{CJK_GATE:,}" + " — 重产")
    nb_id = await ensure_notebook(
        client, st, "ch" + nn,
        "CASELAW-第12份-第" + str(no) + "章-" + ch["title"][:12])
    total, present = await upload_dir_3s(
        client, nb_id, UPLOAD / ("ch" + nn + "_笔记本"), "ch" + nn)
    if present < total:
        # 源齐门: 残缺笔记本生成=薄稿+烧配额, 等下一循环
        print("[wait] ch" + nn + " 源未齐 (" + str(present) + "/" + str(total)
              + ") — 上传配额/网络受限, 本轮不生成, 等下一循环")
        return
    print("[nb] ch" + nn + " 生成章稿 (4段指向式+CJK门扩写轮)…")
    t0 = time.time()
    res = await ask_retry(client, nb_id, chapter_prompt(ch))
    body_parts = [res.answer]
    conv = res.conversation_id
    print("[seg] ch" + nn + " 段1 " + f"{len(res.answer):,}" + "字")
    for k, fu in enumerate(FOLLOWUPS[:2]):
        await asyncio.sleep(4)
        try:
            r2 = await ask_retry(client, nb_id, fu, conv=conv)
            conv = r2.conversation_id or conv
            body_parts.append(r2.answer)
            print("[seg] ch" + nn + " 段" + str(k + 2) + " +" + f"{len(r2.answer):,}" + "字")
        except Exception as e:  # noqa: BLE001
            print("[!] ch" + nn + " 段" + str(k + 2) + " 失败: " + str(e)[:80])
            break
    # CJK 门定向扩写轮 (分段指向, 防双版)
    extra = 0
    while extra < MAX_EXT_ROUNDS:
        cjk_now = cjk_len("\n\n".join(body_parts))
        if cjk_now >= CJK_GATE:
            print("[gate] ch" + nn + " CJK " + f"{cjk_now:,}" + " 已达门")
            break
        extra += 1
        need = min(6000, max(4000, CJK_GATE - cjk_now + 1000))
        secs = _outline_for(ch["no"])
        tgt = "；".join(secs[:8]) if secs else "本章尚未充分展开的小节"
        fu = ("本章篇幅不足（现有正文约" + f"{cjk_now:,}" + "字，目标1.5万-2万字）。"
              "请继续撰写本章第" + str(3 + extra) + "部分（约" + str(need)
              + "字）：只写此前未输出或过于简略的小节（候选：" + tgt
              + "），逐节展开判例条目的案情-争议焦点-裁判要点-实务教训，补充"
              "真实案号与数字，句末标注[源编号]；禁止重复任何已出现的小节标题"
              "与整段内容。")
        await asyncio.sleep(4)
        try:
            r3 = await ask_retry(client, nb_id, fu, conv=conv)
            conv = r3.conversation_id or conv
            body_parts.append(r3.answer)
            print("[ext] ch" + nn + " 扩写轮" + str(extra) + " +"
                  + f"{len(r3.answer):,}" + "字 (累计CJK "
                  + f"{cjk_len(chr(10).join(body_parts)):,}" + ")")
        except Exception as e:  # noqa: BLE001
            print("[!] ch" + nn + " 扩写轮" + str(extra) + " 失败: " + str(e)[:80])
            break
    # 源引用对照 (最后单独一轮, 指向明确防重复)
    cites = ""
    await asyncio.sleep(4)
    try:
        r4 = await ask_retry(client, nb_id, FOLLOWUPS[2], conv=conv)
        conv = r4.conversation_id or conv
        cites = r4.answer
        print("[seg] ch" + nn + " 引用对照 +" + f"{len(cites):,}" + "字")
    except Exception as e:  # noqa: BLE001
        print("[!] ch" + nn + " 引用对照失败: " + str(e)[:80])
    body = "\n\n".join(body_parts)
    full = body + ("\n\n" + cites if cites else "")
    if not write_if_long(out, full, min_chars=5000, relative=True):
        print("[!!] ch" + nn + " 稿被守卫拦截(疑似空/截断), 不落盘")
        raise RuntimeError("ch" + nn + " 守卫拦截(段内容过短)")
    dc = dupcheck(body_parts + ([cites] if cites else []), nn)
    cjk = cjk_len(full)
    st.setdefault("chapters", {})[str(no)] = {
        "conversation_id": conv, "ts": time.strftime("%F %T"),
        "chars": len(full), "cjk": cjk, "gate_hit": cjk >= CJK_GATE,
        "ext_rounds": extra, "dupcheck": dc}
    base.save_state(st)
    print("[OK] ch" + str(no) + "章初稿 _ch" + nn + "_nblm.md " + f"{len(full):,}"
          + "字 (CJK " + f"{cjk:,}" + ", 门" + ("✓" if cjk >= CJK_GATE else "✗")
          + ", 扩写轮" + str(extra) + ", " + str(round(time.time() - t0)) + "s)")
    await asyncio.sleep(3)      # 章间节流


# ---------- 三武器逐章审计 ----------
def run_weapons(nn: str) -> dict:
    ch_md = SCHED / ("_ch" + nn + "_nblm.md")
    bank = SCHED / ("bank_ch" + nn + ".md")
    if not ch_md.is_file():
        return {"ch": nn, "skip": "无稿"}
    r = {"ch": nn}
    env = dict(os.environ)
    env["PYTHONIOENCODING"] = "utf-8"
    cmds = {
        "sp": ["-X", "utf8", str(RF / "sp_scorecard.py"),
               "--chapter", str(ch_md), "--bank", str(bank),
               "--campaign", CAMPAIGN],
        "cv": ["-X", "utf8", str(RF / "claim_verifier.py"),
               "--chapter", str(ch_md), "--bank", str(bank),
               "--out", str(SCHED / ("_ch" + nn + "_claims.md"))],
        "ar": ["-X", "utf8", str(RF / "adversarial_review.py"),
               "--chapter", str(ch_md), "--bank", str(bank),
               "--campaign", CAMPAIGN],
    }
    for key, args in cmds.items():
        try:
            p = subprocess.run([sys.executable, *args], capture_output=True,
                               text=True, encoding="utf-8", errors="replace",
                               timeout=1200, cwd=str(REPO), env=env)
            tail = ((p.stdout or "") + (p.stderr or "")).strip().splitlines()
            r[key] = "rc=" + str(p.returncode) + " | " + (tail[-1][:120] if tail else "")
            print("[wp-" + key + "] ch" + nn + " rc=" + str(p.returncode) + " "
                  + (tail[-1] if tail else "")[:100])
        except Exception as e:  # noqa: BLE001
            r[key] = "EXC " + type(e).__name__ + ": " + str(e)
            print("[wp-" + key + "] ch" + nn + " 异常 " + str(e)[:80])
    sp_side = SCHED / ("_ch" + nn + "_nblm.sp_scorecard.md")
    sp_dst = SCHED / ("_ch" + nn + "_sp.md")
    if sp_side.is_file() and not sp_dst.exists():
        sp_dst.write_text(sp_side.read_text(encoding="utf-8"), encoding="utf-8")
    ar_dst = SCHED / ("_ch" + nn + "_adversarial.md")
    if not ar_dst.exists():
        cands = [c for c in sorted(SCHED.glob("_ch" + nn + "_nblm*.md"))
                 + sorted(OUT.glob("_ch" + nn + "*adversarial*.md"))
                 if ("sp_scorecard" not in c.name and "claims" not in c.name
                     and c.name != "_ch" + nn + "_nblm.md")]
        if cands:
            ar_dst.write_text(cands[0].read_text(encoding="utf-8"), encoding="utf-8")
            r["ar_src"] = cands[0].name
    return r


async def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser()
    ap.add_argument("--phase", default="framework",
                    choices=["framework", "chapters", "all", "weapons", "check"])
    ap.add_argument("--chapters", default="")
    ns = ap.parse_args()

    if ns.phase == "check":
        lock_exit_node()
        return 0 if nb_reachable() else 1

    ensure_storm()
    lock_exit_node()
    if not nb_reachable():
        print("[!] NB 不可达 — 按安全纪律不切换出口, 退出。")
        return 1
    print("[通道] NB 可达, transport=" + os.environ.get("NOTEBOOKLM_TRANSPORT", "")
          + " 单会话开产")

    st = base.load_state()
    nums = [int(x) for x in ns.chapters.split(",") if x.strip()] or list(range(1, 13))
    chs = json.loads((SCHED / "chapters.json").read_text(encoding="utf-8"))

    if ns.phase == "framework":
        ok = await framework_with_ladder(st)
        return 0 if ok else 1
    elif ns.phase in ("chapters", "all"):
        if ns.phase == "all":
            ok = await framework_with_ladder(st)
            if not ok:
                print("[all] 框架失败且无既有权威目录, 收工")
                return 1
        for ch in chs:
            if ch["no"] not in nums:
                continue
            # Google 边缘节流窗(10-20min)实测 — 6试/420s梯 (TOP50 1029 公式)
            for attempt in range(6):
                try:
                    async with await get_client() as client:
                        await gen_one(client, st, ch)
                    run_weapons(str(ch["no"]).zfill(2))
                    break
                except Exception as e:  # noqa: BLE001
                    last = attempt >= 5
                    print("[!!] 第" + str(ch["no"]) + "章第" + str(attempt + 1)
                          + "次失败(" + type(e).__name__ + ": "
                          + str(e)[:120] + ")——"
                          + ("放弃续跑" if last else "420s后重试(新client)"), flush=True)
                    if not last:
                        await asyncio.sleep(420)
    elif ns.phase == "weapons":
        for no in nums:
            run_weapons(str(no).zfill(2))
    return 0


if __name__ == "__main__":
    raise SystemExit(asyncio.run(main()))
