# -*- coding: utf-8 -*-
"""nblm_run_jiage — JIAGE 第10份报告 NotebookLM 产线编排器 (1026 用户令适配版).

蓝本: m2/sched_nblm_run.py (SCHED 战役验证件, --campaign-dir 通用化思路).

Phase 0 框架NBLM化 (用户升级令):
  00_战役总笔记本(48源) → 框架prompt(三场景/买家=造价工程师与商务经理/12章左右)
  → 提取 → chapters_nblm.json (权威目录; 手筑 chapters.json 降为参照)
Phase 1 各章内容NBLM化:
  按NBLM框架逐章: bank映射→源上传→章prompt(1.5-2万字门/买家体裁/源编号)
  → 分段指向续写到门 → _chNN_nblm.md + dupcheck门

安全宪法: 出口锁定 7892/美国04 (1026实测锁定, 禁切换); NB云端运行不用管;
  续写必带指向 (NBLM续写拼接重复缺陷在案); 章间节流; 云端草稿如实提取不美化。
用法: py -X utf8 nblm_run_jiage.py --phase framework
      py -X utf8 nblm_run_jiage.py --phase chapters --chapters 1
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

HERE = Path(__file__).resolve().parent
M2 = HERE.parent.parent                      # .../work/m2
sys.path.insert(0, str(M2))
from m2_write_guard import write_if_long     # noqa: E402

PX = "http://127.0.0.1:7892"                 # 锁定出口 (nblm_conn_state.json)
os.environ["HTTP_PROXY"] = PX
os.environ["HTTPS_PROXY"] = PX
os.environ.pop("http_proxy", None); os.environ.pop("https_proxy", None)

UPLOAD = HERE / "nblm_upload"
STATE_P = HERE / "nblm_state.json"
LEDGER_P = HERE / "nblm_ledger.json"
CH_NBLM = HERE / "chapters_nblm.json"
REPORT = "工程计价依据与市场价基准实战研究报告"
CJK_GATE = 15000                             # 1.5万字门 (CJK实测)
MAX_ROUNDS = 3                               # 正文续写轮上限 (首问之外)


# ---------- 通道 ----------
def conn_check() -> bool:
    def curl(ua: bool) -> str:
        cmd = ["curl", "-s", "-m", "15", "-x", PX, "-o", "/dev/null",
               "-w", "%{http_code}|%{redirect_url}", "https://notebooklm.google.com"]
        if ua:
            cmd = cmd[:1] + ["-A", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
                              "AppleWebKit/537.36 (KHTML, like Gecko) "
                              "Chrome/131.0.0.0 Safari/537.36",
                              "-H", "Accept-Language: zh-CN,zh;q=0.9,en;q=0.8"] + cmd[1:]
        r = subprocess.run(cmd, capture_output=True, text=True, timeout=25)
        return r.stdout.strip()

    for ua in (False, True):
        out = curl(ua)
        code = out.split("|")[0]
        if code == "000":
            print(f"[conn] ✗ 内核不可达 ({PX}) — 检查用户态内核")
            return False
        if "unsupported" in out:
            print(f"[conn] ✗ 出口被 NB 区域门拒: {out[:80]}")
            print("       安全纪律: 禁止切换出口/国家, 如实报告等恢复")
            return False
    print(f"[conn] ✅ 出口可用 ({PX}, 锁定态见 nblm_conn_state.json)")
    return True


# ---------- 状态 ----------
def load_state() -> dict:
    if STATE_P.is_file():
        return json.loads(STATE_P.read_text(encoding="utf-8"))
    return {"notebooks": {}, "framework": None, "chapters": {}}


def save_state(st: dict) -> None:
    STATE_P.write_text(json.dumps(st, ensure_ascii=False, indent=1),
                       encoding="utf-8")


def load_ledger() -> dict:
    if LEDGER_P.is_file():
        return json.loads(LEDGER_P.read_text(encoding="utf-8"))
    return {"campaign": "EPC-JIAGE", "report": REPORT, "locked_exit": PX + "/美国04",
            "chapters": {}}


def save_ledger(ld: dict) -> None:
    LEDGER_P.write_text(json.dumps(ld, ensure_ascii=False, indent=1),
                        encoding="utf-8")


# ---------- NB 客户端 ----------
async def get_client(attempts: int | None = None):
    """from_storage 带长退避重试 — 1026 实测: 每出口IP首个 from_storage 过,
    紧随的必败 (Google 边缘一次性放行). 故整个生产必须单会话完成:
    --phase all 一次 from_storage + keepalive 跑完框架+12章.
    2245+: BD上游限制并发握手 → ConnectError; 限 max_connections=2 走单车道."""
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
                  f"{str(e)[:90]}) — 冷却{wait}s 后重试", flush=True)
            await asyncio.sleep(wait)
    raise last


async def ensure_notebook(client, st: dict, key: str, title: str) -> str:
    nb_id = st["notebooks"].get(key)
    if nb_id:
        return nb_id
    # 2253+: CREATE_NOTEBOOK 曾超时但服务端可能已建 — 先按题复用防重本
    try:
        for n in await client.notebooks.list():
            if str(getattr(n, "title", "")) == title:
                st["notebooks"][key] = n.id
                save_state(st)
                print(f"[nb] 复用既有 {title} → {n.id}")
                return n.id
    except Exception as e:  # noqa: BLE001
        print(f"[nb] list 复用检查失败({type(e).__name__}): {str(e)[:60]}")
    last = None
    for att in range(3):
        try:
            nb = await client.notebooks.create(title=title)
            st["notebooks"][key] = nb.id
            save_state(st)
            print(f"[nb] 建 {title} → {nb.id}")
            return nb.id
        except Exception as e:  # noqa: BLE001
            last = e
            print(f"[nb!] 建本第{att+1}次失败: {type(e).__name__} {str(e)[:70]}")
            await asyncio.sleep(20 * (att + 1))
    raise last


async def upload_dir(client, nb_id: str, d: Path, tag: str) -> int:
    files = sorted([f for f in d.iterdir()
                    if f.suffix.lower() in (".md", ".txt", ".pdf")])
    exist = {s.title for s in await client.sources.list(nb_id)}
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
                print(f"[up!] {f.name[:44]} 第{att+1}次: {type(e).__name__} {str(e)[:60]}")
                await asyncio.sleep(20 * (att + 1))
        if ok:
            n += 1
            print(f"[up] {tag} ← {f.name[:60]}")
            await asyncio.sleep(4)
        else:
            print(f"[skip] {f.name[:44]} 三次失败, 跳过")
    for _ in range(120):
        srcs = await client.sources.list(nb_id)
        sts = [str(getattr(s, "status", "")).lower() for s in srcs]
        if sts and all(x in ("ready", "complete", "ok") or "fail" in x for x in sts):
            break
        await asyncio.sleep(5)
    return len(files)


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


# ---------- Phase 0: 框架 ----------
def framework_prompt() -> str:
    return (
        "你是工程建设行业战略咨询总监。基于本笔记本全部资料，为"
        f"《{REPORT}》设计全书目录框架（12章左右）。读者（本书买家）："
        "中国工程行业的造价工程师与商务经理。本书三大使用场景："
        "①投标报价编制（招标控制价、投标报价、综合单价组价）；"
        "②结算核对（进度款支付、竣工结算核对）；"
        "③合同解除与争议（合同解除结算、造价鉴定）。要求："
        "1)每章标题用判断句或动作句，不用名词堆砌；2)按读者认知路径排序"
        "（体系与规则全景→计价方法→三大场景实战→职业与工具生态→行动清单收尾）；"
        "3)每章注明：本章解决的读者问题、3-6个小节要点、主要使用场景（①或②或③或通用）；"
        "4)章节须覆盖笔记本证据的十大主题维度：政策法规与定额体系、计价依据与定额测定、"
        "信息价与市场价基准、投标编制实务、结算核对实务、合同解除结算、造价鉴定与争议、"
        "清单与定额计价模式、造价咨询与职业、数据源与工具生态；"
        "5)输出格式严格：先给不超过500字的全书定位说明；随后每章一块，首行格式为"
        "【第N章】章标题｜场景：X，接着一行「本章解决：…」，再以「·」开头给出3-6行小节要点。"
        "全部简体中文，不使用计算机术语。")


def parse_framework(text: str) -> list[dict]:
    chs: list[dict] = []
    cur = None
    for line in text.split("\n"):
        s = line.strip()
        m = re.match(r"【第(\d+)章】\s*(.+?)\s*[｜|]\s*场景[:：]\s*(.+)$", s)
        if m:
            if cur:
                chs.append(cur)
            cur = {"no": int(m.group(1)), "title": m.group(2).strip(),
                   "scenario": m.group(3).strip(), "solve": "", "points": []}
            continue
        if cur is None:
            continue
        if s.startswith("本章解决") and len(s) < 300:
            cur["solve"] = re.sub(r"^本章解决[:：]\s*", "", s)
        elif s.startswith("·") and len(s) < 200:
            cur["points"].append(s.lstrip("·").strip())
    if cur:
        chs.append(cur)
    # 章号重排 (NBLM可能跳号): 按出现顺序 1..N
    for i, c in enumerate(chs, 1):
        c["no"] = i
    return chs


async def phase_framework(st: dict, ld: dict, client=None) -> int:
    own = client is None
    if own:
        client = await get_client()
    try:
        nb_id = await ensure_notebook(
            client, st, "framework", "JIAGE-计价依据报告-00战役总")
        n = await upload_dir(client, nb_id, UPLOAD / "00_战役总笔记本", "总本")
        print(f"[nb] 战役总本源数: {n}, 生成框架…")
        res = await ask_retry(client, nb_id, framework_prompt())
        (HERE / "00_框架_nblm.md").write_text(res.answer, encoding="utf-8")
        st["framework"] = {"conversation_id": res.conversation_id,
                           "ts": time.strftime("%F %T")}
        save_state(st)
        chs = parse_framework(res.answer)
        print(f"[fw] 解析出 {len(chs)} 章")
        if len(chs) < 8:
            print("[fw] ✗ 章数<8, 疑似格式漂移 — 原文已存 00_框架_nblm.md")
            return 1
        CH_NBLM.write_text(json.dumps(chs, ensure_ascii=False, indent=1),
                           encoding="utf-8")
        for c in chs:
            print(f"  第{c['no']:2d}章 [{c['scenario'][:6]}] {c['title'][:30]} "
                  f"({len(c['points'])}要点)")
        print(f"[✅] 框架已存 chapters_nblm.json ({len(chs)}章, 权威目录)")
        return 0
    finally:
        if own:
            pass  # 外层 async with 负责关闭; 兼容直传 client


# ---------- Phase 1: 各章 ----------
def map_bank(ch: dict, olds: list[dict]) -> int:
    """NBLM 章 → 手筑 bank 章号 (kws命中 + 标题二元组重合)."""
    text = ch["title"] + " " + ch.get("solve", "") + " " + " ".join(ch["points"])
    best, bs = 1, -1.0
    for oc in olds:
        s = 2.0 * sum(1 for k in oc["kws"] if k in text)
        t = oc["title"]
        grams = {t[i:i+2] for i in range(len(t) - 1)}
        s += 0.15 * sum(1 for g in grams if g in text)
        if s > bs:
            bs, best = s, oc["no"]
    return best


def chapter_prompt(ch: dict, kws: list[str]) -> str:
    pts = "\n".join(f"· {p}" for p in ch["points"]) or "· 由你按资料自定3-6个小节"
    return (
        f"你是资深工程造价研究专家。基于本笔记本全部资料，撰写《{REPORT}》"
        f"第{ch['no']}章「{ch['title']}」完整初稿。读者：中国工程行业的造价工程师"
        "与商务经理。本章要点骨架（按此展开，小节标题可细化）：\n" + pts +
        f"\n场景定位：{ch['scenario']}。" +
        ("本章核心问题：" + ch["solve"] + "。" if ch.get("solve") else "") +
        "要求：1)开篇一段说明本章帮读者解决什么问题、读完能拿来做什么；"
        "2)按小节展开：判例写清案情-裁判-教训，方法给可执行步骤，关键数字讲清用法；"
        "3)所有数字与案例必须来自笔记本资料，句末以[源编号]标注来源"
        "（源编号=笔记本源名称开头的两位数字）；4)语言平实具体面向实战，"
        "不用计算机术语，不空话套话；5)章末附「小结要点」与「本章证据边界」；"
        "6)现在输出本章前半部分（约7000字），最后一行单独输出"
        "【未写小节清单】：逐条列出本章尚未写的小节标题。"
        f"本章主题词：{'、'.join(kws)}。")


def cjk_len(t: str) -> int:
    return len(re.findall(r"[一-鿿]", t))


def paras(t: str) -> list[str]:
    return [p.strip() for p in re.split(r"\n+", t) if len(p.strip()) >= 30]


def dupcheck_parts(parts: list[str]) -> tuple[list[str], list[float]]:
    """逐段检测与已累积内容的重复率; >50% 重复的续写段剔除 (双版缺陷门)."""
    kept, fracs = [], []
    seen: set[str] = set()
    for i, p in enumerate(parts):
        ps = paras(p)
        if not ps:
            kept.append(p); fracs.append(0.0); continue
        dup = sum(1 for x in ps if x in seen)
        frac = dup / len(ps)
        fracs.append(round(frac, 3))
        if i > 0 and frac > 0.5:
            print(f"[dup] 第{i+1}段重复率{frac:.0%} >50% — 剔除不入成品 (双版缺陷门)")
            continue
        kept.append(p)
        seen.update(ps)
    return kept, fracs


def dupcheck_file(text: str) -> dict:
    ps = paras(text)
    from collections import Counter
    c = Counter(ps)
    dup_paras = sum(v - 1 for v in c.values() if v > 1)
    heads = [l.strip() for l in text.split("\n")
             if re.match(r"^#{1,4}\s+\S", l.strip())]
    ch = Counter(heads)
    dup_heads = sum(v - 1 for v in ch.values() if v > 1)
    return {"paragraphs": len(ps), "dup_paragraphs": dup_paras,
            "headings": len(heads), "dup_headings": dup_heads}


async def gen_one(client, st: dict, ld: dict, ch: dict, olds: list[dict]) -> None:
    key = f"ch{ch['no']:02d}"
    out = HERE / f"_ch{ch['no']:02d}_nblm.md"
    if out.is_file() and cjk_len(out.read_text(encoding="utf-8")) >= 8000:
        print(f"[skip] {key} 已有稿({out.stat().st_size:,}B)")
        return
    bank_no = map_bank(ch, olds)
    oc = next(o for o in olds if o["no"] == bank_no)
    print(f"[map] NBLM第{ch['no']}章 → bank ch{bank_no:02d}「{oc['title'][:20]}」")
    nb_id = await ensure_notebook(
        client, st, key,
        f"JIAGE-计价依据报告-第{ch['no']}章-{ch['title'][:14]}")
    d = UPLOAD / f"ch{bank_no:02d}_笔记本"
    await upload_dir(client, nb_id, d, key)
    print(f"[nb] {key} 生成章稿 (门: CJK≥{CJK_GATE:,})…")
    t0 = time.time()
    res = await ask_retry(client, nb_id, chapter_prompt(ch, oc["kws"]))
    parts = [res.answer]
    conv = res.conversation_id
    pending: list[str] = re.findall(
        r"【未写小节清单】[:：]?(.*)$", res.answer, re.S)
    pending_list = []
    if pending:
        for ln in pending[0].split("\n")[1:6]:
            ln = ln.strip().lstrip("·-· ").strip()
            if ln and len(ln) < 80:
                pending_list.append(ln)
    rounds = 0
    while rounds < MAX_ROUNDS:
        total_cjk = cjk_len("\n\n".join(parts))
        if total_cjk >= CJK_GATE:
            print(f"[gate] {key} CJK {total_cjk:,} 已达门")
            break
        done = all(("无" == p.strip() or not p.strip()) for p in pending_list) \
            if pending_list else False
        if rounds > 0 and done:
            print(f"[gate] {key} 未写清单=无, 正文完成 (CJK {total_cjk:,})")
            break
        rounds += 1
        if pending_list:
            tgt = "；".join(pending_list[:6])
            fu = (f"继续。只写以下未输出的小节：{tgt}（约5000字）。"
                  "禁止重复任何已出现的小节标题与内容，句末继续标注[源编号]。"
                  "最后一行单独输出更新后的【未写小节清单】（全部写完则只写：无）。")
        else:
            fu = ("继续，输出本章后半部分剩余小节(约5000字)——只写前次未输出的小节，"
                  "禁止重复任何已出现的小节标题与内容，句末继续标注[源编号]。"
                  "最后一行单独输出更新后的【未写小节清单】（全部写完则只写：无）。")
        await asyncio.sleep(4)
        r2 = await ask_retry(client, nb_id, fu, conv=conv)
        conv = r2.conversation_id or conv
        parts.append(r2.answer)
        m = re.search(r"【未写小节清单】[:：]?(.*?)$", r2.answer, re.S)
        if m:
            nl = [x.strip().lstrip("·-· ").strip()
                  for x in m.group(1).split("\n")[1:6]]
            pending_list = [x for x in nl if x and x != "无" and len(x) < 80]
        print(f"[..] {key} 轮{rounds} 累计CJK {cjk_len(chr(10).join(parts)):,}")
    # 源引用对照 (单独一轮, 指向明确防重复)
    await asyncio.sleep(4)
    try:
        r3 = await ask_retry(client, nb_id, (
            "本章正文已完成。现在只输出《源引用对照》清单：逐条列出本章引用的"
            "[源编号]→源资料名→对应内容摘要(每条一行)，并附本章术语速查。"
            "不要重复任何正文小节。"), conv=conv)
        conv = r3.conversation_id or conv
        parts.append(r3.answer)
    except Exception as e:  # noqa: BLE001
        print(f"[!] {key} 源对照轮失败: {e}")
    kept, fracs = dupcheck_parts(parts)
    body = "\n\n".join(kept)
    dup = dupcheck_file(body)
    rec = {
        "bank_no": bank_no, "conversation_id": conv,
        "ts": time.strftime("%F %T"),
        "parts_total": len(parts), "parts_kept": len(kept),
        "part_dup_fracs": fracs,
        "sources": len(list(d.glob('*.md'))),
        "cjk": cjk_len(body), "gate": CJK_GATE,
        "gate_hit": cjk_len(body) >= CJK_GATE,
        "rounds": rounds, "secs": round(time.time() - t0),
        **dup,
    }
    if not write_if_long(out, body, min_chars=8000, relative=True):
        print(f"[!!] {key} 稿被守卫拦截(疑似空/截断), 不落盘 — 原文段保留在会话 {conv}")
        rec["written"] = False
    else:
        rec["written"] = True
        print(f"[✅] {key} → _ch{ch['no']:02d}_nblm.md | CJK {rec['cjk']:,} "
              f"| 门{'✓' if rec['gate_hit'] else '✗'} | dup段{dup['dup_paragraphs']} "
              f"| {rec['secs']}s")
    ld["chapters"][str(ch["no"])] = rec
    save_ledger(ld)
    st.setdefault("chapters", {})[str(ch["no"])] = {
        "conversation_id": conv, "ts": time.strftime("%F %T")}
    save_state(st)
    await asyncio.sleep(8)      # 章间节流


async def phase_chapters(st: dict, ld: dict, nums: list[int], client=None) -> None:
    olds = json.loads((HERE / "chapters.json").read_text(encoding="utf-8"))
    if not CH_NBLM.is_file():
        print("[!] chapters_nblm.json 不存在 — 先跑 --phase framework")
        return
    chs = json.loads(CH_NBLM.read_text(encoding="utf-8"))

    async def _loop(client):
        for ch in chs:
            if nums and ch["no"] not in nums:
                continue
            try:
                await gen_one(client, st, ld, ch, olds)
            except Exception as e:  # noqa: BLE001
                print(f"[!!] 第{ch['no']}章整体失败({type(e).__name__}: "
                      f"{str(e)[:100]})——跳过续跑下一章", flush=True)
                await asyncio.sleep(30)

    if client is not None:
        await _loop(client)
        return
    # 独立进程: await 形式返回的是上下文对象, 必须 async with 进入 (1027 修复)
    async with await get_client() as c:
        await _loop(c)


async def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser()
    ap.add_argument("--phase", default="framework",
                    choices=["framework", "chapters", "all"])
    ap.add_argument("--chapters", default="")
    ap.add_argument("--skip-check", action="store_true")
    ns = ap.parse_args()
    if not ns.skip_check and not conn_check():
        return 1
    st, ld = load_state(), load_ledger()
    nums = [int(x) for x in ns.chapters.split(",") if x.strip()]
    if ns.phase == "all":
        # 1026 实测: 每出口IP首个 from_storage 一次性放行 → 全生产单会话
        async with await get_client() as client:
            fw = await phase_framework(st, ld, client=client)
            if fw != 0 and not CH_NBLM.is_file():
                print("[all] 框架失败且无既有权威目录, 收工")
                return fw
            await phase_chapters(st, ld, nums, client=client)
        return 0
    if ns.phase == "framework":
        async with await get_client() as client:
            return await phase_framework(st, ld, client=client)
    await phase_chapters(st, ld, nums)
    return 0


if __name__ == "__main__":
    raise SystemExit(asyncio.run(main()))
