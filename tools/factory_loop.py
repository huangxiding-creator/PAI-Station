# -*- coding: utf-8 -*-
"""factory_loop — W2 主循环: 7×24 工厂编排器 (FACTORY-7x24, 用户令1122全批).

纯调用者 (零重写): 现有产线脚本按原样作为子程序被调度.
状态机: SELECT(需求塔Top1) → SCOUT(六渠道快侦) → S1(弹药三件) →
        DRAFT(初稿: NBLM活→NB链/GLM降级) → COLLATE(收编+审计门) →
        MERGE(总装排版) → LIST(上架) → PROMO(宣发) → RETRO(复盘入账) → next
纪律全继承: 零造假审计门/让路互斥(run.lock+永动机检测)/失败降级不硬闯/中央账本.
用法:
  py -X utf8 tools/factory_loop.py --once          # 一份全链(开发/验收用)
  py -X utf8 tools/factory_loop.py                  # 常驻循环(7×24)
  py -X utf8 tools/factory_loop.py --install-guard  # 安装四任务守护
  py -X utf8 tools/factory_loop.py --status         # 工厂心跳
"""
from __future__ import annotations

import argparse
import json
import subprocess
import sys
import time
import traceback
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
FACT = REPO / "data" / "factory"
M2 = REPO / "_proposals" / "flagship-paid-report-1007" / "work" / "m2"
LEDGER = FACT / "factory_ledger.jsonl"
LOCK = FACT / "run.lock"
STATE = FACT / "factory_state.json"
PY = sys.executable
SUBPROCESS_TIMEOUT = 3600 * 2

# 让路互斥: 永动机活跃检测 (浏览器在跑=让路等待)
AUTOPUB_CHROME_MARK = "browser_profiles"


def log(msg: str):
    line = f"[{time.strftime('%m-%d %H:%M:%S')}] {msg}"
    print(line, flush=True)


def ledger_write(stage: str, campaign: str, data: dict):
    LEDGER.parent.mkdir(parents=True, exist_ok=True)
    rec = {"ts": time.strftime("%Y-%m-%d %H:%M:%S"), "stage": stage,
           "campaign": campaign, **data}
    with LEDGER.open("a", encoding="utf-8") as f:
        f.write(json.dumps(rec, ensure_ascii=False) + "\n")


def state_load() -> dict:
    if STATE.is_file():
        try:
            return json.loads(STATE.read_text(encoding="utf-8"))
        except Exception:
            pass
    return {"running": None, "history": []}


def state_save(st: dict):
    STATE.parent.mkdir(parents=True, exist_ok=True)
    STATE.write_text(json.dumps(st, ensure_ascii=False, indent=1), encoding="utf-8")


def run(cmd: list[str], timeout: int = SUBPROCESS_TIMEOUT, check: bool = True) -> tuple[int, str]:
    """跑子程序 (现有产线脚本), 返回 (rc, 输出尾部)."""
    try:
        r = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8",
                           errors="replace", timeout=timeout, cwd=str(REPO))
        out = ((r.stdout or "") + (r.stderr or ""))[-4000:]
        if check and r.returncode != 0:
            log(f"  ✗ rc={r.returncode}: {' '.join(cmd[:3])}…")
        return r.returncode, out
    except subprocess.TimeoutExpired:
        return 124, "timeout"
    except Exception as e:
        return 125, str(e)[:300]


def autopub_busy() -> bool:
    """永动机浏览器在跑 → 让路 (研报生产不影响永动机铁律)."""
    try:
        r = subprocess.run(
            ["powershell", "-NoProfile", "-Command",
             "(Get-CimInstance Win32_Process -Filter \"Name='chrome.exe'\" | "
             f"Where-Object {{$_.CommandLine -match '{AUTOPUB_CHROME_MARK}'}} | Measure-Object).Count"],
            capture_output=True, text=True, timeout=30)
        return int((r.stdout or "0").strip() or 0) > 0
    except Exception:
        return False


def acquire_lock() -> bool:
    LOCK.parent.mkdir(parents=True, exist_ok=True)
    if LOCK.is_file():
        try:
            old = int(LOCK.read_text().strip())
            # PID 探活 (简化: 只查进程是否存在)
            r = subprocess.run(["powershell", "-NoProfile", "-Command",
                                f"if (Get-Process -Id {old} -ErrorAction SilentlyContinue) {{1}} else {{0}}"],
                               capture_output=True, text=True, timeout=20)
            if (r.stdout or "").strip() == "1":
                return False  # 活锁持有者
        except Exception:
            pass
    LOCK.write_text(str(__import__("os").getpid()))
    return True


def release_lock():
    try:
        LOCK.unlink()
    except OSError:
        pass


# ───────────────────────── 状态机各阶段 ─────────────────────────

def stage_select() -> dict | None:
    """选题: 优先用细方向清单 (factory_topics.json), 回退到粗主题 (factory_top10.json).
    逐顺位过 SCOUT 门 (Top1 被拒自动降下一顺位)."""
    log("[SELECT] 选题运行…")
    # 优先: 细方向清单 (factory_topics.py 产出)
    topics_file = FACT / "factory_topics.json"
    top, source = [], "topics"
    if topics_file.is_file():
        try:
            tdoc = json.loads(topics_file.read_text(encoding="utf-8"))
            top = [r for r in tdoc.get("top", []) if r.get("topic")]
            if top:
                source = "细方向"
                log(f"[SELECT] 细方向清单 {len(top)} 条")
        except Exception:
            pass
    # 回退: 粗主题 (factory_demand.py)
    if not top:
        rc, out = run([PY, "-X", "utf8", str(REPO / "tools" / "factory_demand.py"),
                       "--days", "3", "--top", "10"], timeout=600)
        if rc != 0:
            log(f"[SELECT] 需求层失败: {out[-200:]}")
            return None
        doc = json.loads((FACT / "factory_top10.json").read_text(encoding="utf-8"))
        top = doc.get("top") or []
        source = "粗主题"
        if not top:
            log("[SELECT] Top10 为空")
            return None
    # 1124 修复: 已出版/已在史主题查重 (今日 F176D 同题重产事故)
    done_themes = {h.get("theme", "") for h in state_load().get("history", [])}
    # 逐顺位: SCOUT 门不过 → 下一个 (最多试5个)
    for pick in top[:5]:
        topic = pick.get("topic") or pick.get("theme") or ""
        if topic and any(topic[:12] in dt or dt[:12] in topic for dt in done_themes if dt):
            log(f"[SELECT] {topic[:20]} 已在史 (查重跳过)")
            ledger_write("SELECT_PASS", topic[:20], {"reason": "theme_dup"})
            continue
        score = pick.get("score") or pick.get("score", 0)
        sel = {"theme": topic, "score": score, "detail": pick, "source": source}
        if stage_scout(sel):
            log(f"[SELECT] 选定(过门): {sel['theme']} [{sel['score']}] ({source})")
            ledger_write("SELECT", sel["theme"], {"score": sel["score"], "source": source})
            return sel
        log(f"[SELECT] {topic[:20]} 未过SCOUT门, 降下一顺位")
        ledger_write("SELECT_PASS", topic[:20], {"reason": "scout_fail"})
    return None


def stage_scout(sel: dict) -> bool:
    """快侦: rss 文章命中数 (≥3 篇过门) + 本地判例命中 (加分, 不做硬门).
    1124 修: 旧版只匹配判例切片文件名, 对细方向（来自 rss/社群信号）永远 0 命中.
    新版: 用细方向标题的前 4 字在 rss 近 30 天文章中搜索, 命中即说明有素材."""
    theme = sel["theme"]
    kw = theme[:4]   # 取前 4 字作为检索词
    n_rss = 0
    rss_root = REPO / "data" / "rss_harvest" / "articles"
    for d in range(30):
        day = time.strftime("%Y-%m-%d", time.localtime(time.time() - d * 86400))
        p = rss_root / day
        if not p.is_dir():
            continue
        for f in p.glob("*.md"):
            try:
                t = f.read_text(encoding="utf-8", errors="replace")[:3000]
                if kw in t:
                    n_rss += 1
            except OSError:
                pass
    # 本地判例命中 (加分)
    n_slice = 0
    js = REPO / "data" / "harvest" / "judgment_slices"
    seen = set()
    for f in js.rglob("*.md"):
        if f.stem in seen:
            continue
        if kw in f.stem or any(k in f.stem for k in [theme[:2], theme[2:4]]):
            seen.add(f.stem)
            n_slice += 1
    log(f"[SCOUT] {theme[:20]} | rss 命中 {n_rss} 篇 | 判例切片 {n_slice} 卷")
    ok = n_rss >= 3 or n_slice >= 2
    ledger_write("SCOUT", theme[:20], {"rss_hits": n_rss, "slices": n_slice, "pass": ok})
    return ok


def campaign_dir(campaign: str) -> Path:
    """战役目录 = m2/<去掉 EPC- 前缀的小写> (EPC-F8EF8 → m2/f8ef8).
    主循环与三产物引擎必须用同一个函数 — 1122 曾因两处算法不同留下孤儿目录 epc-f8ef8."""
    return M2 / campaign.replace("EPC-", "").lower()


def gen_chapters(theme: str, sel: dict) -> list[dict] | None:
    """用语义挖掘结果生成针对该主题的 12 章目录. 失败返回 None (调用方回退并如实标注)."""
    try:
        sys.path.insert(0, str(REPO / "tools"))
        from factory_demand_mine import glm, load_keys
        mined = sel.get("mined") or {}
        prompt = (
            "你是研究报告的总编辑。请为下面这个研究方向设计一份 12 章的研究报告目录。\n"
            f"研究方向：{theme}\n"
            f"从近期专家文章中挖掘到的研究方向：{json.dumps(mined.get('directions', [])[:6], ensure_ascii=False)}\n"
            f"专家们指出但尚未解决的难题：{json.dumps(mined.get('unsolved_all', [])[:8], ensure_ascii=False)}\n"
            f"近期相关文章标题样例：{json.dumps((sel.get('detail') or {}).get('samples', [])[:3], ensure_ascii=False)}\n\n"
            "要求：只输出 JSON 数组，共 12 项，每项形如 "
            "{\"no\":1,\"title\":\"章标题：副标题（具体到争点或场景，不要泛泛而谈）\","
            "\"kws\":[\"检索词1\",\"检索词2\",\"检索词3\",\"检索词4\"],\"question\":\"这一章要回答读者的什么问题\"}。"
            "第 1 章是全景与规则地图，最后一章是可落地的行动清单与自查表，中间各章围绕上面的方向和未解难题展开，"
            "每章的 kws 要能直接拿去资料库里检索。不要输出 JSON 以外的任何文字。")
        model, content = glm([{"role": "user", "content": prompt}], load_keys())
        if not content:
            return None
        arr = json.loads(content[content.find("["):content.rfind("]") + 1])
        arr = [x for x in arr if isinstance(x, dict) and x.get("title")][:12]
        if len(arr) < 8:
            return None
        out = []
        for i, x in enumerate(arr, 1):
            out.append({"no": i, "title": str(x["title"])[:80], "type": "融合",
                        "kws": [str(k)[:12] for k in (x.get("kws") or [])[:4]],
                        "question": str(x.get("question", ""))[:160],
                        "subqs": [f"Q{i}"]})
        while len(out) < 12:  # 不足 12 章时补足通用章, 避免总装缺章
            out.append({"no": len(out) + 1, "title": f"{theme}·专题延伸之{len(out) + 1}", "type": "融合",
                        "kws": [theme[:4]], "subqs": [f"Q{len(out) + 1}"]})
        return out
    except Exception as e:
        log(f"[S1] 章节生成失败({str(e)[:60]})")
        return None


def stage_s1(sel: dict) -> str | None:
    """S1: 建战役目录 + 12 章目录 + 把本地已有的相关判例切片汇到该战役的切片池.
    注意: 这一步只汇总本地库里现成的判例切片, 不等于完成调研 — 核心调研渠道
    (网盘/ima/微信读书/文库/论文/当当)由调研环节执行, 结果另记调研报告."""
    theme = sel["theme"]
    import hashlib
    short = hashlib.md5(theme.encode()).hexdigest()[:4]
    campaign = f"EPC-F{short.upper()}"
    cdir = campaign_dir(campaign)
    sched = cdir / "sched"
    sched.mkdir(parents=True, exist_ok=True)
    chapters = gen_chapters(theme, sel)
    chapters_source = "语义挖掘+模型生成"
    if chapters is None:
        chapters_source = "通用骨架(章节生成失败, 需人工按主题重写)"
        chapters = [{"no": i + 1, "title": f"{theme}·第{i + 1}部分", "type": "融合",
                     "kws": [theme[:4]], "subqs": [f"Q{i + 1}"]} for i in range(12)]
    (sched / "chapters.json").write_text(json.dumps(chapters, ensure_ascii=False, indent=1), encoding="utf-8")
    # 本地判例切片: 文件名命中主题词表的汇入战役切片池
    THEME_KWS_S1 = {"招投标与投标": ["招投标","招标","投标","中标","评标"], "合同与索赔": ["变更签证","索赔","黑白合同"],
        "工程结算与造价": ["结算","造价","审减","审计"], "竣工验收与移交": ["验收","竣工"],
        "分包与劳务": ["分包","转包","挂靠","实际施工人"], "安全生产": ["安全"], "保险与保函": ["保函","保险"],
        "融资与投资": ["融资","BOT","PPP"], "税务": ["发票"], "国际工程": ["国际","FIDIC"],
        "新能源与储能": ["储能","光伏","风电"], "水利水电": ["水利","水电"], "交通基建": ["公路","桥梁","隧道","铁路"],
        "司法鉴定与诉讼": ["鉴定","管辖"], "数字化转型": ["BIM"], "政策与法规": ["法规"]}
    kws_s1 = THEME_KWS_S1.get(theme, [theme[:4]])
    js = REPO / "data" / "harvest" / "judgment_slices"
    seen = set()
    copied = 0
    for p in js.rglob("*.md"):
        if p.stem in seen or not any(k in p.stem for k in kws_s1):
            continue
        seen.add(p.stem)
        dst = js / campaign / p.name
        dst.parent.mkdir(parents=True, exist_ok=True)
        try:
            dst.write_bytes(p.read_bytes())
            copied += 1
        except OSError:
            pass
    log(f"[S1] {campaign}: 12章目录({chapters_source}) + 本地判例切片{copied}卷")
    ledger_write("S1", campaign, {"chapters": 12, "chapters_source": chapters_source,
                                  "local_slices": copied})
    return campaign


def stage_rest(campaign: str, sel: dict) -> dict:
    """交接单: 如实写明自动段做到了哪一步、哪些环节尚未执行. 交接单之后的生产目前需要
    有人在会话里接力, 不是无人值守."""
    handoff = FACT / "HANDOFF_next.md"
    dirs = campaign_dir(campaign)
    mined = sel.get("mined") or {}
    handoff.write_text(
        f"# 工厂交接单 · {campaign}\n\n"
        f"- 主题: {sel['theme']} (词频评分 {sel['score']})\n"
        f"- 语义挖掘到的方向: {json.dumps(mined.get('directions', [])[:6], ensure_ascii=False)}\n"
        f"- 专家指出但未解决的难题: {json.dumps(mined.get('unsolved_all', [])[:8], ensure_ascii=False)}\n"
        f"- 战役目录: {dirs}\n\n"
        f"## 自动段已完成\n"
        f"- 需求评分与选题、语义挖掘、本地判例切片汇总、12 章目录\n\n"
        f"## 尚未执行 (需要接力)\n"
        f"- 核心调研渠道 (网盘/ima/微信读书/文库/论文/当当) 与调研达标核验\n"
        f"- 弹药编目与分章素材库\n"
        f"- NotebookLM 上传与章节生成 (通道不通时需降级并说明)\n"
        f"- 收编、审计门、总装排版、上架、三产物、宣传物料\n",
        encoding="utf-8")
    log(f"[HANDOFF] 交接单 → {handoff}")
    ledger_write("HANDOFF", campaign, {"handoff": str(handoff)})
    return {"campaign": campaign, "handoff": str(handoff)}


# ───────────────────────── 守护与心跳 ─────────────────────────

GUARD_TASKS = [
    ("FactoryLoopMain", "09:13", "--once"),
    ("FactoryLoopBackup", "13:43", "--once"),
    ("FactoryLoopEvening", "20:23", "--once"),
    ("FactoryLoopHeartbeat", "07:53", "--heartbeat"),
]


def write_guard_cmd(name: str, args: str) -> Path:
    """写包装 cmd. 路径一律来自 Path 对象 — 1122 用字符串拼反斜杠路径, \\t \\f 被转成
    制表符/换页符, 四个任务挂进计划程序却一个都执行不了."""
    script = REPO / "tools" / "factory_loop.py"
    logf = FACT / f"{name}.log"
    cmdfile = FACT / f"{name}.cmd"
    cmdfile.parent.mkdir(parents=True, exist_ok=True)
    body = "@echo off\r\n" \
           f'cd /d "{REPO}"\r\n' \
           f'"{Path(sys.executable)}" -X utf8 "{script}" {args} >> "{logf}" 2>&1\r\n'
    cmdfile.write_text(body, encoding="utf-8")
    return cmdfile


def install_guard():
    """注册四任务. 注意: 交接单之后的生产环节尚未自动化之前, 不应启用 —
    每跑一次只会多建一个没人接力的战役, 并把该主题占住."""
    for name, hhmm, args in GUARD_TASKS:
        cmdfile = write_guard_cmd(name, args)
        r = subprocess.run(["cmd", "/c",
                            f"SchTasks /Create /F /TN {name} /SC DAILY /ST {hhmm} /TR \"{cmdfile}\""],
                           capture_output=True, timeout=30)
        out = (r.stdout or b"").decode("gbk", errors="replace") + (r.stderr or b"").decode("gbk", errors="replace")
        log(f"[guard] {name}@{hhmm} ({args}): {'已注册' if r.returncode == 0 else '失败 ' + out[-80:]}")
        if r.returncode == 0:
            log(f"[guard]   校验包装脚本: {cmdfile.read_text(encoding='utf-8').splitlines()[-1][:90]}")


def heartbeat():
    """企微心跳: 如实报工厂状态."""
    st = state_load()
    hist = st.get("history", [])
    handed = [h for h in hist if h.get("status", "handed_off") == "handed_off"]
    published = [h for h in hist if h.get("status") == "published"]
    body = (f"已建成并上架: {len(published)} 份 | 已建战役待接力: {len(handed)} 份"
            + (f" ({'、'.join(h.get('theme', '') for h in handed)})" if handed else "")
            + " | 交接单之后的生产环节仍需人工接力")
    subprocess.run([PY, "-X", "utf8", str(REPO / "tools" / "notify_wecom.py"),
                    "研究工厂心跳", body], capture_output=True, timeout=60)
    log(f"[heartbeat] 企微心跳已推: {body}")


# ───────────────────────── 主流程 ─────────────────────────

def has_inflight() -> dict | None:
    """返回第一个已建战役但尚未做完的条目 (没有则 None). 一次只做一份: 在途未完成不开新题."""
    for h in state_load().get("history", []):
        st = h.get("status", "handed_off")
        if st != "published" and not st.startswith("superseded"):
            return h
    return None


def one_cycle() -> bool:
    """一轮的自动段: 选题(含语义挖掘与逐顺位过门) → 建战役与章节目录 → 交接单.
    返回是否建成了新战役. 交接单之后的生产不在本函数内."""
    sel = stage_select()  # 内含逐顺位SCOUT门
    if not sel:
        return False
    campaign = stage_s1(sel)
    if not campaign:
        return False
    stage_rest(campaign, sel)
    st = state_load()
    st["history"].append({"campaign": campaign, "theme": sel["theme"],
                          "ts": time.strftime("%Y-%m-%d %H:%M"),
                          "status": "handed_off"})
    state_save(st)
    return True


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser()
    ap.add_argument("--once", action="store_true")
    ap.add_argument("--forever", action="store_true")
    ap.add_argument("--install-guard", action="store_true")
    ap.add_argument("--status", action="store_true")
    ap.add_argument("--heartbeat", action="store_true",
                    help="推一条企微心跳 (守护任务用; --status 只打印不发)")
    ap.add_argument("--mark-published", metavar="CAMPAIGN",
                    help="把某个在途战役标为已上架 (只有真正上架完成后才应调用)")
    ap.add_argument("--force-new", action="store_true",
                    help="已有在途战役时仍强行再建一个 (默认不做: 一份没做完不开下一份)")
    ap.add_argument("--produce", action="store_true",
                    help="在途(或新建)战役→全自动生产: harvest→collate→merge→gate→shelf→promo→finalize")
    ns = ap.parse_args()

    if ns.install_guard:
        install_guard()
        return 0
    if ns.status:
        st = state_load()
        print(json.dumps(st, ensure_ascii=False, indent=1))
        return 0
    if ns.heartbeat:
        heartbeat()
        return 0
    if ns.mark_published:
        st = state_load()
        hit = False
        for h in st.get("history", []):
            if h.get("campaign") == ns.mark_published and h.get("status") != "published":
                h["status"] = "published"
                h["published_ts"] = time.strftime("%Y-%m-%d %H:%M")
                hit = True
        state_save(st)
        log(f"[mark] {ns.mark_published}: {'已标为 published' if hit else '未找到在途条目'}")
        return 0 if hit else 1

    if not acquire_lock():
        log("[lock] 已有实例在跑, 退出")
        return 0
    try:
        if getattr(ns, "produce", False):
            infl = has_inflight()
            if not infl:
                log("[produce] 无在途战役 — 先跑一轮选题建战役")
                one_cycle()
                infl = has_inflight()
                if not infl:
                    log("[produce] 选题未过门, 本轮不生产")
                    return 1
            campaign = infl["campaign"]
            theme = infl.get("theme", "")
            short = campaign.split("F")[-1][:4]
            title = f"《{theme}实战研究报告》"
            sku = f"{campaign}-2026"
            log(f"[produce] {campaign} / {title} / {sku}")
            # 通用骨架拦截: 章节生成失败的骨架不配成书 (1124 首跑事故)
            chj = campaign_dir(campaign) / "sched" / "chapters.json"
            if chj.is_file():
                _t = chj.read_text(encoding="utf-8")
                if "·第1部分" in _t or "·第12部分" in _t:
                    log("[produce] 章节生成失败(通用骨架) — 拦截, 需人工重写章表")
                    ledger_write("PRODUCE_ABORT", campaign, {"reason": "generic_skeleton"})
                    subprocess.run([PY, "-X", "utf8", str(REPO / "tools" / "notify_wecom.py"),
                                    "研究工厂生产拦截",
                                    f"{campaign} 章节生成为通用骨架 — 已拦截不产书, 需人工重写章表"],
                                   capture_output=True, timeout=60)
                    return 1
            cdir_abs = str(campaign_dir(campaign))
            rc = subprocess.run(
                [sys.executable, "-X", "utf8", str(REPO / "tools" / "factory_produce.py"),
                 "--campaign-dir", cdir_abs, "--campaign", campaign,
                 "--title", title, "--sku", sku],
                capture_output=True, text=True, encoding="utf-8", errors="replace",
                timeout=8 * 3600)
            log(f"[produce] rc={rc} 尾部: {(rc.stdout or '')[-400:]}")
            if rc.returncode == 0:
                st = state_load()
                for h in st["history"]:
                    if h.get("campaign") == campaign and h.get("status") != "published":
                        h["status"] = "published"
                        h["published_ts"] = time.strftime("%Y-%m-%d %H:%M")
                        h["sku"] = sku
                state_save(st)
                log(f"[produce] {campaign} 全自动生产收官 → published ({sku})")
            return rc.returncode
        if ns.once:
            infl = has_inflight()
            if infl and not ns.force_new:
                log(f"[once] 已有在途战役 {infl.get('campaign')}（{infl.get('theme')}）待接力, "
                    "不重复开新题 — 先把它做完, 或确认放弃后用 --force-new")
                return 1
            ok = one_cycle()
            log(f"[once] {'已建战役并出交接单' if ok else '本轮未建战役(无方向过门)'}")
            return 0 if ok else 1
        # forever: 常驻. 有在途战役时只等待, 不开新题.
        while True:
            try:
                infl = has_inflight()
                if infl:
                    log(f"[loop] 在途战役 {infl.get('campaign')} 待接力, 30分钟后再看")
                    time.sleep(1800)
                    continue
                if autopub_busy():
                    log("[yield] 永动机浏览器在跑, 让路30分钟")
                    time.sleep(1800)
                    continue
                one_cycle()
                log("[loop] 本轮结束, 休眠30分钟")
                time.sleep(1800)
            except KeyboardInterrupt:
                log("[loop] 人工中断")
                return 0
            except Exception:
                log("[loop] 异常(记账继续):\n" + traceback.format_exc()[-800:])
                ledger_write("ERROR", "-", {"tb": traceback.format_exc()[-500:]})
                time.sleep(900)
    finally:
        release_lock()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
