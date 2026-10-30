# -*- coding: utf-8 -*-
"""top50_nblm_run - 第11份 EPC-TOP50 NBLM 产线编排器 (照 JIAGE sched_nblm_run 验证线复用).

通道公式 (任务令): 美国04出口锁定 + 认证态 default profile + curl_cffi TLS 仿装
  (NOTEBOOKLM_TRANSPORT=curl_cffi) + 单会话承载全生产.
铁律: 通道锁定不轮换国家; NBLM 云端草稿如实提取不美化; 数字零造假;
  幂等续跑 (sched/nblm_state.json); 只新增不删除文件.
用法:
  py -X utf8 top50_nblm_run.py --check
  py -X utf8 top50_nblm_run.py --phase framework
  py -X utf8 top50_nblm_run.py --phase chapters --chapters 1,2
  py -X utf8 top50_nblm_run.py --phase all
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

# 1029v3 用户令(入宪): NBLM 须国外网, 先调网再跑 — 默认共享内核 7892
# (父会话 1029 晚实测绿; 7920 内核2 出口风暴期三连 SSL 瞬断, 弃用).
# env NBLM_PROXY 可覆盖; 每次会话启动前 nb_reachable() 自服探测 (curl -x PX 301=绿).
_NBLM_PROXY = os.environ.get("NBLM_PROXY", "http://127.0.0.1:7892")
# 1029v3修(真根因): Windows os.environ 键名不分大小写, pop 小写=pop 大写 —
# v2「先设后清」把代理整个卸掉 → 直连被 GFW 重置 → curl35 风暴假象(双内核同症).
# 必须先清后设; 顺序反了 = 无代理直连.
for _k in ("http_proxy", "https_proxy", "HTTP_PROXY", "HTTPS_PROXY"):
    os.environ.pop(_k, None)
os.environ["HTTP_PROXY"] = _NBLM_PROXY
os.environ["HTTPS_PROXY"] = _NBLM_PROXY

SCHED, UPLOAD, OUT = base.SCHED, base.UPLOAD, base.OUT
FW_DIR = UPLOAD / "00_战役总笔记本"
RF = Path(r"E:\AI-Station\reforge_factory")   # 1029修: reforge_factory 真身在站根, 不在 flagship 目录
PX = _NBLM_PROXY                  # 1029v3: 共享内核 7892 (默认); 7920 内核2 风暴期弃用
REPORT = "工程企业工程总承包业务全景研究报告：2025 TOP50"
BUYERS = "工程企业高管、设计院院长、EPC从业者"
CJK_GATE = 15000                  # 1029v2: 章稿 CJK 门 (1.5万); ch04 退化段(6,235)根因=无门循环
MAX_EXT_ROUNDS = 3                # 达门前的定向扩写轮上限 (照 JIAGE MAX_ROUNDS 蓝本)


def cjk_len(t: str) -> int:
    return len(re.findall(r"[一-鿿]", t))


async def upload_dir_3s(client, nb_id: str, d: Path, tag: str) -> tuple:
    """1029v6: 返回 (包文件数, 在场源数); 其余照旧 (3s 节流+双名匹配)."""
    files = sorted([f for f in d.iterdir()
                    if f.suffix.lower() in (".md", ".txt", ".pdf")])
    exist = {s.title for s in await client.sources.list(nb_id)}
    # 1029v4修(配额爆仓根因): 服务器对 md/txt 用完整文件名做标题, 与传入 stem
    # 不一致 → exist 永远漏检 → 每次运行全量重传 → 50/50 配额触顶 RPC3.
    # 反向剥离扩展名补全 stem 形态后按双名匹配; ch04 笔记本已 50/50 满额
    # (重复灌入), 修复后全部命中 exist → 零新增, 直接进生成段.
    import os as _os
    exist |= {_os.path.splitext(t)[0] for t in tuple(exist)}
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
        # 1029v5修: str(SourceStatus.READY)='SourceStatus.READY' → 裸词等值
        # 永不匹配 → 每章空转120×5s. 改子串匹配.
        if sts and all(any(k in x for k in ("ready", "complete", "ok", "fail"))
                       for x in sts):
            break
        await asyncio.sleep(5)
    # 1029v6: 复点在场源数 (双名匹配), 供 gen_one 源齐门
    import os as _os2
    final = {s.title for s in await client.sources.list(nb_id)}
    final |= {_os2.path.splitext(t)[0] for t in tuple(final)}
    present = sum(1 for f in files if f.stem[:80] in final)
    return len(files), present


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


def _clash_ports() -> list:
    ports = {48897, 53401}
    try:
        r = subprocess.run(["netstat", "-ano"], capture_output=True, timeout=10)
        p = subprocess.run(
            ["powershell", "-NoProfile", "-Command",
             "(Get-Process clash*,mihomo* -ErrorAction SilentlyContinue).Id -join ','"],
            capture_output=True, text=True, timeout=10)
        pids = {x for x in p.stdout.strip().split(",") if x.strip().isdigit()}
        for line in r.stdout.decode("gbk", errors="replace").splitlines():
            if "LISTEN" not in line or "127.0.0.1" not in line:
                continue
            if (not pids) or any(line.rstrip().endswith(pid) for pid in pids):
                parts = line.split()
                local = parts[1] if len(parts) > 1 else ""
                if ":" in local:
                    try:
                        pt = int(local.split(":")[-1])
                        if 1024 < pt < 65536:
                            ports.add(pt)
                    except ValueError:
                        pass
    except Exception:
        pass
    return [48899]                # 1029隔离令: 只认专用内核2控制器, 共享48898勿碰


def _clash_req(port: int, path: str, method: str = "GET", body: dict = None):
    req = urllib.request.Request(
        "http://127.0.0.1:" + str(port) + path, method=method,
        headers={"Authorization": "Bearer " + base.CLASH_SECRET,
                 "Content-Type": "application/json"},
        data=json.dumps(body).encode() if body else None)
    with urllib.request.urlopen(req, timeout=6) as r:
        return json.loads(r.read().decode("utf-8", "replace"))


def lock_exit_node() -> str:
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
                print("[exit] 一次性锁定 " + us04[0] + " (原=" + cur + ", 组=" + name + ") 之后不再切换")
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


def framework_prompt() -> str:
    return storm_head() + (
        "你是工程建设行业首席研究总监。基于本笔记本全部资料，为《" + REPORT
        + "》设计12章实战目录框架。读者是" + BUYERS + "，报告必须同时服务三类"
        "使用场景：①全景画像（谁是50强、格局如何、钱与人在哪）；②分档对比"
        "（头部/中坚/追赶各档企业的能力与打法差异）；③行动清单（不同位置的"
        "企业下一步怎么干）。要求：1)每章标题用判断句而非名词堆砌；2)每章列出"
        "本章解决的读者问题与3-6个小节要点；3)按读者认知路径排序：全景画像、"
        "榜单与口径、央企集团军、专业赛道、区域梯队、设计院转型路径、项目管理"
        "交付、营收盈利风险、人才组织、数字化创新、50强分档画像、三场景行动"
        "清单；4)每章注明建议引用的资料主题，并标注该章主要服务哪一场景；"
        "5)全部简体中文，不超过3000字。")


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
        "你是深耕工程行业的资深研究总监。基于本笔记本全部资料，撰写《" + REPORT
        + "》第" + str(ch["no"]) + "章「" + ch["title"] + "」完整初稿。读者是"
        + BUYERS + "。本章主题词：" + "、".join(ch["kws"]) + "（树子问 "
        + ",".join(ch.get("subqs", [])) + "）。" + ol_txt
        + "要求：开篇一段说明本章帮读者解决什么问题；按小节展开，企业案例写清"
        "数据-动作-结果，方法给可执行步骤；所有数字与企业名必须来自笔记本资料，"
        "句末标注来源编号；语言平实具体面向买家决策，不用计算机术语与空话套话；"
        "本章合计15000-20000字，分多段输出。现在先输出本章前部小节（约6000字），"
        "我随后会分段要后续部分。")


FOLLOWUPS = [
    ("继续，输出本章中部小节（约5000字）——只写前次未输出的小节，禁止重复任何"
     "已出现的小节标题与内容，句末继续标注来源编号。"),
    ("继续，输出本章后部剩余小节并收束（约5000字）——只写仍未输出的小节，最后"
     "给出「小结要点」与「本章证据边界」，禁止重复已出现的小节标题与内容。"),
    ("本章正文已完成。现在只输出《源引用对照》清单：逐条列出本章引用的编号→"
     "源资料名→对应内容摘要(每条一行)。不要重复任何正文小节。"),
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


async def phase_framework(st: dict, client) -> None:
    ensure_storm()
    OUT.mkdir(exist_ok=True)
    nb_id = await base.ensure_notebook(
        client, st, "framework", "TOP50-第11份-00战役总笔记本")
    n = await upload_dir_3s(client, nb_id, FW_DIR, "框架")
    print("[nb] 战役总笔记本源数: " + str(n) + ", 开始生成框架…")
    res = await base.ask_retry(client, nb_id, framework_prompt())
    (OUT / "00_框架.md").write_text(res.answer, encoding="utf-8")
    st["framework"] = {"conversation_id": res.conversation_id,
                       "ts": time.strftime("%F %T")}
    base.save_state(st)
    print("[OK] 框架已存 nblm_out/00_框架.md (" + f"{len(res.answer):,}" + "字)")
    extract_chapters_nblm()


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
            cur = {"no": no,
                   "title": m.group(3).strip(), "sections": []}
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
    nb_id = await base.ensure_notebook(
        client, st, "ch" + nn,
        "TOP50-第11份-第" + str(no) + "章-" + ch["title"][:12])
    total, present = await upload_dir_3s(
        client, nb_id, UPLOAD / ("ch" + nn + "_笔记本"), "ch" + nn)
    if present < total:
        # 1029v6 源齐门: 账户级日上传配额受限时残缺笔记本生成=薄稿+烧配额
        print("[wait] ch" + nn + " 源未齐 (" + str(present) + "/" + str(total)
              + ") — 上传配额/网络受限, 本轮不生成, 等下一循环")
        return
    print("[nb] ch" + nn + " 生成章稿 (4段指向式+CJK门扩写轮)…")
    res = await base.ask_retry(client, nb_id, chapter_prompt(ch))
    body_parts = [res.answer]
    conv = res.conversation_id
    print("[seg] ch" + nn + " 段1 " + f"{len(res.answer):,}" + "字")
    for k, fu in enumerate(FOLLOWUPS[:2]):
        await asyncio.sleep(4)
        try:
            r2 = await base.ask_retry(client, nb_id, fu, conv=conv)
            conv = r2.conversation_id or conv
            body_parts.append(r2.answer)
            print("[seg] ch" + nn + " 段" + str(k + 2) + " +" + f"{len(r2.answer):,}" + "字")
        except Exception as e:
            print("[!] ch" + nn + " 段" + str(k + 2) + " 失败: " + str(e)[:80])
            break
    # 1029v2: CJK 门定向扩写轮 — 退化首段/欠产章兜底 (分段指向, 防双版)
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
              + "），逐节展开企业案例的数据-动作-结果，补充具体数字与做法，"
              "句末标注来源编号；禁止重复任何已出现的小节标题与整段内容。")
        await asyncio.sleep(4)
        try:
            r3 = await base.ask_retry(client, nb_id, fu, conv=conv)
            conv = r3.conversation_id or conv
            body_parts.append(r3.answer)
            print("[ext] ch" + nn + " 扩写轮" + str(extra) + " +"
                  + f"{len(r3.answer):,}" + "字 (累计CJK "
                  + f"{cjk_len(chr(10).join(body_parts)):,}" + ")")
        except Exception as e:
            print("[!] ch" + nn + " 扩写轮" + str(extra) + " 失败: " + str(e)[:80])
            break
    # 源引用对照 (最后单独一轮, 指向明确防重复)
    cites = ""
    await asyncio.sleep(4)
    try:
        r4 = await base.ask_retry(client, nb_id, FOLLOWUPS[2], conv=conv)
        conv = r4.conversation_id or conv
        cites = r4.answer
        print("[seg] ch" + nn + " 引用对照 +" + f"{len(cites):,}" + "字")
    except Exception as e:
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
          + ", 扩写轮" + str(extra) + ")")
    await asyncio.sleep(3)      # 1029协调令: 章间节流 3s; 上传间 3s (upload_dir_3s)


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
               "--campaign", "EPC-TOP50"],
        "cv": ["-X", "utf8", str(RF / "claim_verifier.py"),
               "--chapter", str(ch_md), "--bank", str(bank),
               "--out", str(SCHED / ("_ch" + nn + "_claims.md"))],
        "ar": ["-X", "utf8", str(RF / "adversarial_review.py"),
               "--chapter", str(ch_md), "--bank", str(bank),
               "--campaign", "EPC-TOP50"],
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
        except Exception as e:
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
            ar_dst.write_text(cands[0].read_text(encoding="utf-8"),
                              encoding="utf-8")
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
        async with await base.get_client() as client:
            await phase_framework(st, client)
    elif ns.phase in ("chapters", "all"):
        if ns.phase == "all":
            async with await base.get_client() as client:
                await phase_framework(st, client)
        for ch in chs:
            if ch["no"] not in nums:
                continue
            # 1029修3: Google边缘节流窗(10-20min)实测——6试/420s梯, 全程约40min覆盖
            for attempt in range(6):
                try:
                    async with await base.get_client() as client:
                        await gen_one(client, st, ch)
                    run_weapons(str(ch["no"]).zfill(2))
                    break
                except Exception as e:
                    last = attempt >= 5
                    print("[!!] 第" + str(ch["no"]) + "章第" + str(attempt + 1)
                          + "次失败(" + type(e).__name__ + ": "
                          + str(e)[:120] + ")——"
                          + ("放弃续跑" if last else "420s后重试(新client)"))
                    if not last:
                        await asyncio.sleep(420)
    elif ns.phase == "weapons":
        for no in nums:
            run_weapons(str(no).zfill(2))
    return 0


if __name__ == "__main__":
    raise SystemExit(asyncio.run(main()))
