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
    """需求塔: 跑词频层+语义层, **逐顺位过SCOUT门** (Top1被拒自动降Top2…)."""
    log("[SELECT] 需求塔运行…")
    rc, out = run([PY, "-X", "utf8", str(REPO / "tools" / "factory_demand.py"),
                   "--days", "3", "--top", "10"], timeout=600)
    if rc != 0:
        log(f"[SELECT] 需求层失败: {out[-200:]}")
        return None
    doc = json.loads((FACT / "factory_top10.json").read_text(encoding="utf-8"))
    top = doc.get("top") or []
    if not top:
        log("[SELECT] Top10 为空")
        return None
    # 语义挖掘 (前3主题)
    run([PY, "-X", "utf8", str(REPO / "tools" / "factory_demand_mine.py"),
         "--themes", "3", "--per-theme", "5"], timeout=1800)
    mined_map = {}
    mp = FACT / "factory_mined.json"
    if mp.is_file():
        try:
            md = json.loads(mp.read_text(encoding="utf-8"))
            for e in md.get("themes", []):
                mined_map[e.get("theme", "")] = e
        except Exception:
            pass
    # 逐顺位: SCOUT 门不过 → 下一个 (最多试5个)
    for pick in top[:5]:
        sel = {"theme": pick["theme"], "score": pick["score"], "detail": pick,
               "mined": mined_map.get(pick["theme"])}
        if stage_scout(sel):
            log(f"[SELECT] 选定(过门): {sel['theme']} [{sel['score']}] "
                + (f" 方向: {sel['mined']['directions'][0][:40]}"
                   if sel["mined"] and sel["mined"].get("directions") else ""))
            ledger_write("SELECT", sel["theme"],
                         {"score": sel["score"],
                          "directions": (sel["mined"] or {}).get("directions", [])[:3]})
            return sel
        log(f"[SELECT] {pick['theme']} 未过SCOUT门, 降下一顺位")
        ledger_write("SELECT_PASS", pick["theme"], {"reason": "scout_fail"})
    return None


def stage_scout(sel: dict) -> bool:
    """六渠道快侦: 跨池+库内 grep 命中量 (30分钟可行性)."""
    theme = sel["theme"]
    # 主题→争点词表 (切片按争点命名: 结算审减/变更签证/优先受偿权…)
    THEME_KWS = {
        "EPC工程总承包": ["EPC", "总承包"], "招投标与投标": ["招投标", "招标", "投标", "中标", "评标"],
        "合同与索赔": ["变更签证", "索赔", "费用索赔", "黑白合同", "合同"], "工程结算与造价": ["结算", "造价", "审减", "审计", "计价"],
        "竣工验收与移交": ["验收", "竣工", "移交"], "分包与劳务": ["分包", "转包", "挂靠", "实际施工人", "劳务"],
        "安全生产": ["安全责任", "安全事故"], "保险与保函": ["保函", "保险"],
        "融资与投资": ["融资", "BOT", "PPP"], "税务": ["发票", "税"],
        "国际工程": ["国际", "FIDIC", "海外"], "新能源与储能": ["储能", "光伏", "风电"],
        "水利水电": ["水利", "水电"], "交通基建": ["公路", "桥梁", "隧道", "铁路"],
        "房建与市政": ["房建", "市政", "管廊"], "数字化转型": ["BIM", "数字化"],
        "司法鉴定与诉讼": ["鉴定", "诉讼", "管辖"], "政策与法规": ["法规", "条例"],
    }
    kws = THEME_KWS.get(theme, [theme[:4]])
    js = REPO / "data" / "harvest" / "judgment_slices"
    n = 0
    seen = set()
    for f in js.rglob("*.md"):
        if f.stem in seen:
            continue
        if any(k in f.stem for k in kws):
            seen.add(f.stem)
            n += 1
    log(f"[SCOUT] 判例切片命中 {n} 卷 (词表={kws[:3]})")
    ok = n >= 3
    ledger_write("SCOUT", theme, {"slices": n, "pass": ok})
    return ok


def stage_s1(sel: dict) -> str | None:
    """S1 弹药三件: 战役目录+chapters+manifest+bank (复用 jes2 产线脚本模板)."""
    theme = sel["theme"]
    code = "".join(ch for ch in theme if ch.isascii() and ch.isalpha())[:4].upper() or "RPT"
    campaign = f"EPC-{code}-{time.strftime('%y%m')}"
    cdir = M2 / code.lower() if code else M2 / theme[:4]
    # 用主题拼音缩写做目录名 (简化: 用 EPC-<hash>)
    import hashlib
    short = hashlib.md5(theme.encode()).hexdigest()[:4]
    campaign = f"EPC-F{short.upper()}"
    cdir = M2 / campaign.lower()
    if cdir.exists():
        log(f"[S1] 战役已存在: {campaign}")
        return campaign
    sched = cdir / "sched"
    sched.mkdir(parents=True, exist_ok=True)
    # chapters.json: 12章按主题展开 (此处通用骨架; 方向细化由 DRAFT 层吸收 mined.directions)
    subs = ["全景与规则地图", "法律性质与条件体系", "程序与流程规范", "特殊情形的规则",
            "时间线认定", "资料与档案", "占有转移与责任转移", "期间与通知义务",
            "资金扣留与退还", "责任范围与边界", "联动与对冲", "体系化行动清单"]
    chs = [{"no": i + 1, "title": f"{theme}·{s}", "type": "融合",
            "kws": [theme[:4], s[:4]], "subqs": [f"Q{i+1}"]} for i, s in enumerate(subs)]
    (sched / "chapters.json").write_text(json.dumps(chs, ensure_ascii=False, indent=1), encoding="utf-8")
    # 弹药池: 跨池软链复制 (命中主题词的切片)
    pool = REPO / "ammo_pool" / campaign / "staging"
    pool.mkdir(parents=True, exist_ok=True)
    js = REPO / "data" / "harvest" / "judgment_slices"
    THEME_KWS_S1 = {"招投标与投标": ["招投标","招标","投标","中标","评标"], "合同与索赔": ["变更签证","索赔","黑白合同"],
        "工程结算与造价": ["结算","造价","审减","审计"], "竣工验收与移交": ["验收","竣工"],
        "分包与劳务": ["分包","转包","挂靠","实际施工人"], "安全生产": ["安全"], "保险与保函": ["保函","保险"],
        "融资与投资": ["融资","BOT","PPP"], "税务": ["发票"], "国际工程": ["国际","FIDIC"],
        "新能源与储能": ["储能","光伏","风电"], "水利水电": ["水利","水电"], "交通基建": ["公路","桥梁","隧道","铁路"],
        "司法鉴定与诉讼": ["鉴定","管辖"], "数字化转型": ["BIM"], "政策与法规": ["法规"]}
    kws_s1 = THEME_KWS_S1.get(theme, [theme[:4]])
    copied = 0
    for p in js.rglob("*.md"):
        if any(k in p.stem for k in kws_s1):
            dst = REPO / "data" / "harvest" / "judgment_slices" / campaign / p.name
            dst.parent.mkdir(parents=True, exist_ok=True)
            try:
                dst.write_bytes(p.read_bytes())
                copied += 1
            except OSError:
                pass
    log(f"[S1] {campaign}: 12章骨架+切片{copied}卷")
    ledger_write("S1", campaign, {"chapters": 12, "slices": copied})
    return campaign


def stage_rest(campaign: str, sel: dict) -> dict:
    """DRAFT→PROMO: 当前会话人工接力段 (工厂基础模式的接缝, 见 --handoff)."""
    handoff = FACT / "HANDOFF_next.md"
    handoff.write_text(
        f"# 工厂交接单 · {campaign}\n\n"
        f"- 主题: {sel['theme']} (评分 {sel['score']})\n"
        f"- 语义方向: {json.dumps((sel.get('mined') or {}).get('directions', [])[:3], ensure_ascii=False)}\n"
        f"- 已完成: SELECT/SCOUT/S1 (12章骨架+切片池)\n"
        f"- 待接力: bank构建→初稿(NBLM/GLM)→收编Workflow→审计→总装→上架→宣发\n"
        f"- 产线模板: 照 jes2/tax 战役 (manifest→bank→Workflow收编→merge→mp_list_report→promo)\n",
        encoding="utf-8")
    log(f"[HANDOFF] 交接单 → {handoff}")
    ledger_write("HANDOFF", campaign, {"handoff": str(handoff)})
    return {"campaign": campaign, "handoff": str(handoff)}


# ───────────────────────── 守护与心跳 ─────────────────────────

GUARD_TASKS = [
    ("FactoryLoopMain", "09:13", "daily"),
    ("FactoryLoopBackup", "13:43", "daily"),
    ("FactoryLoopEvening", "20:23", "daily"),
    ("FactoryLoopHeartbeat", "07:53", "daily"),  # 心跳企微战报
]


def install_guard():
    exe = Path(sys.executable)
    for name, hhmm, _ in GUARD_TASKS:
        cmd = (f'SchTasks /Create /F /TN "{name}" /SC DAILY /ST {hhmm} '
               f'/TR "\\"{exe}\\" -X utf8 {REPO / "tools" / "factory_loop.py"} --once"')
        r = subprocess.run(["powershell", "-NoProfile", "-Command", cmd],
                           capture_output=True, text=True, timeout=30)
        log(f"[guard] {name}@{hhmm}: {'OK' if r.returncode == 0 else (r.stderr or 'fail')[:60]}")


def heartbeat():
    st = state_load()
    import subprocess as sp
    sp.run([PY, "-X", "utf8", str(REPO / "tools" / "notify_wecom.py"),
            "工厂心跳",
            f"在产: {st.get('running') or '空闲'} | 历史: {len(st.get('history', []))}份 | "
            f"账本: {LEDGER}"],
           capture_output=True, timeout=60)
    log("[heartbeat] 企微战报已推")


# ───────────────────────── 主流程 ─────────────────────────

def one_cycle() -> bool:
    """一份的自动段: SELECT→SCOUT→S1→HANDOFF. 返回是否成单."""
    sel = stage_select()  # 内含逐顺位SCOUT门
    if not sel:
        return False
    campaign = stage_s1(sel)
    if not campaign:
        return False
    stage_rest(campaign, sel)
    st = state_load()
    st["history"].append({"campaign": campaign, "theme": sel["theme"],
                          "ts": time.strftime("%Y-%m-%d %H:%M")})
    state_save(st)
    return True


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser()
    ap.add_argument("--once", action="store_true")
    ap.add_argument("--forever", action="store_true")
    ap.add_argument("--install-guard", action="store_true")
    ap.add_argument("--status", action="store_true")
    ns = ap.parse_args()

    if ns.install_guard:
        install_guard()
        return 0
    if ns.status:
        st = state_load()
        print(json.dumps(st, ensure_ascii=False, indent=1))
        return 0

    if not acquire_lock():
        log("[lock] 已有实例在跑, 退出")
        return 0
    try:
        if ns.once:
            ok = one_cycle()
            log(f"[once] {'成单' if ok else '本轮无单(门未过/无Top1)'}")
            return 0 if ok else 1
        # forever: 常驻
        while True:
            try:
                if autopub_busy():
                    log("[yield] 永动机浏览器在跑, 让路30分钟")
                    time.sleep(1800)
                    continue
                one_cycle()
                log("[loop] 一轮完成, 休眠30分钟 (让需求信号再积累)")
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
