# -*- coding: utf-8 -*-
"""军团 v3 小队试点派发器 — 2026-09-28 用户令「可以进行试点」.

v3 安全章程 (相对旧链的根治点, 详见 memory/bulk-account-automation-ban):
  1. 小队制: 首期 10 号 (data/corps_v3_squad.json), 其余号零访问
  2. 指纹隔离: 每号独立 profile (data/profiles_v3/<前缀>/) + 独立端口
     (9401+idx) — 绝不再全军团共用一个浏览器实例轮换登录 (0926 登录墙
     的直接靶子)
  3. 单号日 1 单 (与 v1 共用 dispatch_ledger, 帽=1)
  4. 串行 + 号间随机间隔 (默认 15-25min; --gap-min/--gap-max)
  5. prompt 变体: 3 套引用要求表述轮换 (防同模板指纹)
  6. 哨兵: 页面见停用文案 → 全队停 (CORPS_V3_HALTED 旗标 + 不再启);
     单号累计登录失败 ≥2 → 冷冻 7 天 (corps_v3_cooldown.json)
  7. 让路: WeAIPO 心跳 10min 内 = 忙 → 关浏览器还原 direct 等闲窗
  8. 网络治理: 开窗 rule + 浏览器级节点验证 (内联 lite 版), 收官还原
     direct, 双向登记 network_changelog.jsonl

独立入口铁律: 不 import epc50_corps (模块级 HALT 闸 import 即退);
任务树/账本读写逻辑自包含复制, 同 schema 同文件, 日志追加 engine=v3.
旧链四闸 (fill.sh/corps.py/probe_nodes/guard HALT 分支) 保持锁死.
"""
import argparse
import io
import json
import random
import sys
import time
import urllib.request as u
from pathlib import Path
from urllib.parse import quote

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")
ROOT = Path(__file__).parent
sys.path.insert(0, str(ROOT))

# v3 自己的闸: 哨兵触发 (见停用文案) 后创建; 与旧链 MANUS_CORPS_HALTED
# (锁旧链用, 保留) 互不干扰.
V3_HALTED = ROOT / "data" / "CORPS_V3_HALTED"
if V3_HALTED.exists():
    print(f"[v3-HALT] 哨兵旗标在位: "
          f"{V3_HALTED.read_text(encoding='utf-8').splitlines()[0]}")
    sys.exit(0)

import manus_lib as lib              # noqa: E402  (无闸纯库)
import manus_api as api              # noqa: E402

# ---------------------------------------------------------------- 常量
BATTLE = Path(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics"
              r"\《中石化南京工程有限公司怎么干EPC总承包？》")
TREE = BATTLE / "_pipeline" / "epc50_topic_tree.json"
TREE2 = BATTLE / "_pipeline" / "epc50_topic_tree_v2.json"
SURVEY_SEEDS = BATTLE / "_pipeline" / "epc50_survey_seeds.json"
SAT_OUT = BATTLE / "_pipeline" / "epc50_saturation.json"

SQUAD_FILE = ROOT / "data" / "corps_v3_squad.json"
COOLDOWN = ROOT / "data" / "corps_v3_cooldown.json"
# 多战役树队列 (0930 #49 起): trees 列表顺序=优先级, 第一个还有 pending
# 问的 tree2 作为当日派单源; 无队列文件/空队列 → 退回 TREE2 单树 (#50).
BATTLE_QUEUE = ROOT / "data" / "epc_battle_queue.json"
V3_LOG = ROOT / "data" / "epc50_corps_log.jsonl"   # 同一 append-only 真源
LEDGER = ROOT / "data" / "dispatch_ledger.json"
PROFILES = ROOT / "data" / "profiles_v3"
LOCK = ROOT / "data" / "corps_v3.lock"
CHANGELOG = Path(r"E:\AI-Station\data\state\network_changelog.jsonl")
WEAIPO_HEARTBEAT = Path(r"E:\CPOPC\We-AIPO\data\state\production_heartbeat")
WEAIPO_STALE_S = 600
MIN_CREDITS = 60
DAILY_CAP = 1
SQUAD_SIZE = 10
PORT_BASE = 9401
VARIANTS = [
    "每条关键信息请附来源链接与发布时间，优先官方一手来源，多渠道交叉验证。",
    "请为所有事实性内容标注可核查的出处（URL 与日期），官方与权威来源优先。",
    "所有数据与论断需给出引用来源（链接+发布时间），尽量从多个独立来源互证。",
]
GROUP_PREF = ("手动切换", "漏网之鱼", "Others", "Proxy")
EXCLUDE_KEY = ("香港", "HK")
PREF_ORDER = ("美国", "新加坡", "日本", "台湾", "韩国", "SG", "US", "JP")


# ---------------------------------------------------------------- 小工具
def log(msg: str) -> None:
    print(f"[v3 {time.strftime('%H:%M:%S')}] {msg}", flush=True)


def _atomic_json(path: Path, obj) -> None:
    tmp = path.with_suffix(".tmp")
    tmp.write_text(json.dumps(obj, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    tmp.replace(path)


def _tasklist_alive(pid: int) -> bool:
    import subprocess
    try:
        r = subprocess.run(["tasklist", "/FI", f"PID eq {pid}"],
                           capture_output=True, text=True, timeout=20)
        import re
        return bool(re.search(rf"^\S+\s+{pid}\s", r.stdout or "",
                              re.MULTILINE))
    except Exception:
        return True


def claim_or_exit() -> None:
    import os
    try:
        old = int(LOCK.read_text().strip())
        if old != os.getpid() and _tasklist_alive(old):
            log(f"v3 已在跑 (pid {old}), 本实例退出")
            sys.exit(0)
    except (OSError, ValueError):
        pass
    LOCK.parent.mkdir(parents=True, exist_ok=True)
    LOCK.write_text(str(os.getpid()))
    import atexit
    atexit.register(lambda: LOCK.unlink(missing_ok=True))


def weaipo_busy() -> bool:
    try:
        return time.time() - WEAIPO_HEARTBEAT.stat().st_mtime < WEAIPO_STALE_S
    except FileNotFoundError:
        return False
    except Exception:
        return True


# 1003 用户正: WeAIPO 国外网是间歇用 (需要时才用), 心跳=进程活着≠在用网
# (发文/互动等国内操作也刷心跳). 精确判据用 WeAIPO 侧自报状态文件 (只读):
WEAIPO_RUN_STATE = Path(r"E:\CPOPC\We-AIPO\data\state\run_state.json")
WEAIPO_NB_WAVE = Path(r"E:\CPOPC\We-AIPO\data\state\nb_wave.json")


def weaipo_net_busy() -> bool:
    """WeAIPO 正在用国外网? (精细判据, 1003 精细调度令)

    1) run_state.json mode=="rule" — WeAIPO 自报开着代理窗
       (NB 段用网时自己切 rule, 收工还原 direct; 1003 实证
       stage=nb_window_end+mode=direct=用网结束)
    2) nb_wave.json state 非 done / queue>0 — NB 波次生产中
       (视频生产/下载=真用网; state=done+queue=0=NB 已收工)
    兜底: 两状态文件都读不到 → 退回心跳判据 (保守).
    """
    try:
        rs = json.loads(WEAIPO_RUN_STATE.read_text(encoding="utf-8"))
    except Exception:
        rs = None
    try:
        wv = json.loads(WEAIPO_NB_WAVE.read_text(encoding="utf-8"))
    except Exception:
        wv = None
    if rs is None and wv is None:
        return weaipo_busy()            # 状态文件全失 → 心跳保守
    if rs and rs.get("mode") == "rule":
        return True
    if wv and (str(wv.get("state", "")) not in ("done", "")
               or int(wv.get("queue") or 0) > 0):
        return True
    return False


# ---------------------------------------------------------------- clash
def _clash(path, method="GET", data=None, parse=False):
    hdr = {"Authorization": "Bearer " + lib.CLASH_SECRET,
           "Content-Type": "application/json"}
    for p in lib.clash_ports():
        base = f"http://127.0.0.1:{p}"
        try:
            u.urlopen(u.Request(base + "/version", headers=hdr),
                      timeout=2).read()
        except Exception:
            continue
        req = u.Request(base + path,
                        data=json.dumps(data).encode() if data else None,
                        method=method, headers=hdr)
        raw = u.urlopen(req, timeout=4).read()
        return json.loads(raw) if parse else True
    return None


def get_mode() -> str:
    d = _clash("/configs", parse=True) or {}
    return d.get("mode", "?")


def set_mode(mode: str) -> bool:
    return _clash("/configs", "PATCH", {"mode": mode}) is True


def net_log(frm: str, to: str, reason: str) -> None:
    CHANGELOG.parent.mkdir(parents=True, exist_ok=True)
    rec = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "actor": "corps_v3",
           "action": "mode", "from": frm, "to": to, "reason": reason,
           "verify": "pending"}
    with CHANGELOG.open("a", encoding="utf-8") as f:
        f.write(json.dumps(rec, ensure_ascii=False) + "\n")


def discover_group() -> tuple:
    d = _clash("/proxies", parse=True) or {}
    proxies = d.get("proxies", {})
    groups = {n: v for n, v in proxies.items()
              if v.get("type") in ("Selector", "URLTest", "Fallback")}
    group = None
    for pref in GROUP_PREF:
        for n in groups:
            if pref in n:
                group = n
                break
        if group:
            break
    if not group:
        for n, v in groups.items():
            if len(v.get("all", [])) > 1:
                group = n
                break
    if not group:
        return "", []
    nodes = [n for n in groups[group].get("all", [])
             if n not in ("DIRECT", "REJECT", "GLOBAL")
             and not any(k in n for k in EXCLUDE_KEY)]

    def rank(n):
        for i, k in enumerate(PREF_ORDER):
            if k in n:
                return i
        return 99
    # 0928 批次实证: 每 IP 约 2-3 次新鲜登录后 Turnstile 加码 → 轮换池
    # 用户令: 组内全部候选 (美国优先序保持, probe 首中即停不拖时)
    return group, sorted(nodes, key=rank)


def switch(group: str, node: str) -> bool:
    return _clash("/proxies/" + quote(group), "PUT",
                  {"name": node}) is True


def node_ok(page) -> bool:
    """浏览器级节点验证 (probe_nodes lite): 登录页 #email 在 且非 /unavailable."""
    try:
        page.get(lib.LOGIN_URL)
        time.sleep(6)
        url = page.url or ""
        if "unavailable" in url:
            return False
        return page.ele("#email", timeout=5) is not None \
            or "/app" in url
    except Exception:
        return False


# ---------------------------------------------------------------- 小队
def pick_squad(creds: dict) -> list:
    """首期小队: 0928 摸底实证存活 4 号优先 + 低用量 token 号补足.

    低用量 = 近 4 日账本派发数最少 (低姿态画像); 51817 主账号等
    EXCLUDE 名单永不入队. 生成后写盘, 后续只读文件.
    """
    verified = ["5nemn9mj0t@hema.edu.kg",   # 摸底 1515 积分
                "xwd8lu0drf@manus.edu.kg",  # 300
                "t2nkj09o92@manus.edu.kg",  # 294
                "sl1vme8uez@manus.edu.kg"]  # 297
    rows = []
    for ln in V3_LOG.read_text(encoding="utf-8").splitlines():
        if ln.strip():
            try:
                rows.append(json.loads(ln))
            except Exception:
                pass
    recent = {}
    for r in rows:
        if r["ts"] >= "2026-09-24":
            recent[r["email"]] = recent.get(r["email"], 0) + 1
    tokens = {p.stem.replace("_at_", "@")
              for p in (ROOT / "data" / "tokens").glob("*.json")}
    squad = [e for e in verified if e in creds and e in tokens]
    pool = [e for e in tokens
            if e in creds and e not in squad and e != "51817@qq.com"
            and not e.endswith("@midkk.uk")]      # 摸底负债号域避让
    pool.sort(key=lambda e: (recent.get(e, 0), e))
    for e in pool:
        if len(squad) >= SQUAD_SIZE:
            break
        squad.append(e)
    reason = {"generated": time.strftime("%Y-%m-%dT%H:%M:%S"),
              "rule": "存活4号优先+近4日低用量补足10",
              "verified_alive": squad[:len([e for e in verified
                                            if e in squad])],
              "squad": squad}
    _atomic_json(SQUAD_FILE, reason)
    return squad


# ---------------------------------------------------------------- 任务
def _hungry_ids() -> set:
    try:
        sat = json.loads(SAT_OUT.read_text(encoding="utf-8"))
        return {h["id"] for h in sat.get("hungry", [])}
    except Exception:
        return set()


def next_seed() -> dict | None:
    if not SURVEY_SEEDS.is_file():
        return None
    seeds = json.loads(SURVEY_SEEDS.read_text(encoding="utf-8"))
    for s in seeds["seeds"]:
        if s["status"] == "pending":
            return s
    return None


def load_active_tree2() -> tuple[Path | None, dict | None]:
    """按战役队列取第一个还有 pending 问的 tree2 (路径, 树dict).

    #49 (四川院) 起新战役优先; 该树全 dispatched 后自动落回 #50 剩余
    (缺口储备). 单棵树读坏跳过不炸链; 全军无 pending 返回 (None, None).
    """
    paths: list[Path] = []
    try:
        q = json.loads(BATTLE_QUEUE.read_text(encoding="utf-8"))
        paths = [Path(p) for p in q.get("trees", [])]
    except Exception:
        pass
    paths.append(TREE2)
    for p in paths:
        if not p.is_file():
            continue
        try:
            t = json.loads(p.read_text(encoding="utf-8"))
        except Exception:
            continue
        if any(qq["status"] == "pending"
               for tp in t.get("topics", []) for qq in tp["questions"]):
            return p, t
    return None, None


def next_question(tree2: dict) -> dict | None:
    hungry = _hungry_ids()
    first = None
    for tp in tree2["topics"]:
        for q in tp["questions"]:
            if q["status"] != "pending":
                continue
            if first is None:
                first = q
            if q["id"] in hungry:
                return q
    return first


def build_variant_prompt(tree: dict, topic: dict, rnd: int,
                         question: dict | None) -> str:
    if rnd == 0 or question is None:
        pick = topic["queries"][:3]
        use = topic["manus_use"] if rnd == 0 else "collect"
        base = lib.build_prompt(use, f"{topic['title']}（{tree['company']}）",
                                "; ".join(pick))
    else:
        base = lib.build_prompt(
            "collect", question["text"],
            f"聚焦{tree['company']}（{tree['short']}），优先一手与权威来源，"
            f"数据注明出处与年份")
    return base + "\n\n" + random.choice(VARIANTS)


def load_ledger() -> dict:
    try:
        led = json.loads(LEDGER.read_text(encoding="utf-8"))
    except Exception:
        led = {}
    led.setdefault("dispatched", {})
    led.setdefault("day", time.strftime("%Y-%m-%d"))
    if led["day"] != time.strftime("%Y-%m-%d"):
        led = {"day": time.strftime("%Y-%m-%d"), "dispatched": {}}
    return led


# ---------------------------------------------------------------- 哨兵
# 0928 冒烟实锤: page.html 含 JS bundle 内嵌的停用弹窗 locale 文案 →
# 全账号源码命中 = 误报 (verify_suspension_0928.png 复核链). 判据升级:
# ① /unavailable = 区域墙 ≠ 停用 (换节点可解); ② 停用词只认
# document.body.innerText (纯可见文本), 且加「提交申诉」弹窗按钮词.
SUSPEND_KEYS = ("已被暂停", "违反了我们的服务条款", "临时限制", "提交申诉")


def suspended(page) -> bool:
    try:
        if "unavailable" in (page.url or ""):
            return False
        inner = page.run_js("return document.body.innerText") or ""
    except Exception:
        return False
    return any(k in inner for k in SUSPEND_KEYS)


def region_walled(page) -> bool:
    return "unavailable" in (page.url or "")


def rotate_node(page, group: str, cands: list, cur_idx: int) -> tuple:
    """区域墙轮换: 换下一候选节点并重载主页. → (新idx, 是否解墙)."""
    for step in range(1, len(cands) + 1):
        idx = (cur_idx + step) % len(cands)
        if not switch(group, cands[idx]):
            continue
        time.sleep(3)
        try:
            page.get("https://manus.im/")
            time.sleep(6)
        except Exception:
            continue
        if not region_walled(page):
            return idx, True
    return cur_idx, False


def freeze(email: str, days: int, why: str) -> None:
    cd = {}
    try:
        cd = json.loads(COOLDOWN.read_text(encoding="utf-8"))
    except Exception:
        pass
    until = time.time() + days * 86400
    cd[email] = {"until": until, "why": why,
                 "fails": cd.get(email, {}).get("fails", 0)}
    _atomic_json(COOLDOWN, cd)
    log(f"❄ {email} 冷冻 {days} 天 ({why})")


def load_cooldown() -> dict:
    try:
        cd = json.loads(COOLDOWN.read_text(encoding="utf-8"))
    except Exception:
        return {}
    now = time.time()
    return {e: v for e, v in cd.items() if v.get("until", 0) > now}


def bump_fail(email: str) -> None:
    cd = {}
    try:
        cd = json.loads(COOLDOWN.read_text(encoding="utf-8"))
    except Exception:
        pass
    ent = cd.get(email, {"fails": 0, "until": 0, "why": ""})
    ent["fails"] = ent.get("fails", 0) + 1
    cd[email] = ent
    _atomic_json(COOLDOWN, cd)
    if ent["fails"] >= 2:
        freeze(email, 7, f"累计登录失败{ent['fails']}次")


# ---------------------------------------------------------------- 派发
def dispatch(page, email: str) -> str | None:
    """在已登录页面上派 1 单 (变体 prompt); 成功回 sid, 全留痕."""
    led = load_ledger()
    if led["dispatched"].get(email, 0) >= DAILY_CAP:
        return None
    try:
        if "/app/" in (page.url or ""):
            page.get("https://manus.im/")
            time.sleep(3)
    except Exception:
        pass
    if region_walled(page):
        log(f"⏭ {email} 派发导航遇区域墙 (边缘态), 跳过")
        return None
    if TREE.is_file():
        tree = json.loads(TREE.read_text(encoding="utf-8"))
        tree_owner_path = TREE  # 话题级写回归宿
    else:
        # 1003: #50 已交付、_pipeline 已收口清库, 老单树成死路径 (晨窗 8/8
        # FileNotFoundError 烧号根因). 元数据树退回队列活跃 tree2 (schema
        # 同构: company/short/topics), 写回也落 tree2 原文件.
        tree_owner_path, tree = load_active_tree2()
        if tree is None:
            log(f"⏭ {email} 无可用树 (legacy TREE 缺失且队列树全空), 跳过")
            return None
    seed = next_seed()
    if seed is not None:
        prompt = lib.build_prompt(
            "survey_plan", seed["scope"],
            f"聚焦{tree['company']}（{tree['short']}），{seed['angle']}，"
            f"问题要具体、可检索、按主题分组，并标注每题建议来源渠道"
        ) + "\n\n" + random.choice(VARIANTS)
        label = {"kind": "seed", "id": seed["id"],
                 "title": seed["scope"][:60]}
    else:
        pend = [t for t in tree["topics"] if t["status"] == "pending"]
        if pend:
            topic, rnd = pend[0], 0
        else:
            topic = min(tree["topics"], key=lambda x: x.get("rounds", 0))
            rnd = 1
        question = None
        q_tree_path: Path | None = None
        if rnd >= 1:
            q_tree_path, q_tree2 = load_active_tree2()
            question = next_question(q_tree2) if q_tree2 else None
        prompt = build_variant_prompt(tree, topic, rnd, question)
        label = {"kind": "q" if question else "topic",
                 "id": question["id"] if question else topic["id"],
                 "title": (question["text"][:60] if question
                           else topic["title"])}
    try:
        sid, _hits = lib.send_task(page, prompt)
    except Exception as e:
        log(f"send_task EXC {email} {type(e).__name__}: {str(e)[:50]}")
        return None
    if not sid:
        log(f"send_task 无 sid {email}")
        return None
    led["dispatched"][email] = led["dispatched"].get(email, 0) + 1
    _atomic_json(LEDGER, led)
    if label["kind"] == "seed":
        seeds = json.loads(SURVEY_SEEDS.read_text(encoding="utf-8"))
        for s in seeds["seeds"]:
            if s["id"] == label["id"]:
                s["status"] = "dispatched"
                s["sid"] = sid
                s["account"] = email
        _atomic_json(SURVEY_SEEDS, seeds)
    elif label["kind"] == "q":
        back_path = q_tree_path or TREE2
        tree2 = json.loads(back_path.read_text(encoding="utf-8"))
        for tp in tree2["topics"]:
            for q in tp["questions"]:
                if q["id"] == label["id"]:
                    q["status"] = "dispatched"
                    q["sid"] = sid
                    q["account"] = email
        _atomic_json(back_path, tree2)
    else:
        for t in tree["topics"]:
            if t["id"] == label["id"]:
                t["status"] = "dispatched"
                t["rounds"] = t.get("rounds", 0) + 1
                t["last_sid"] = sid
                t["last_account"] = email
        _atomic_json(tree_owner_path, tree)
    with V3_LOG.open("a", encoding="utf-8") as f:
        f.write(json.dumps({
            "ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "email": email,
            "sid": sid, "topic": label["id"], "round": label["kind"],
            "q": label["id"] if label["kind"] == "q" else None,
            "title": label["title"], "use": "collect", "engine": "v3",
            "battle": (q_tree_path.name[:5] if label["kind"] == "q"
                       and q_tree_path else "epc50")},
            ensure_ascii=False) + "\n")
    log(f"✓ {email} → {sid} ({label['kind']}:{label['id']})")
    try:                          # 成功即健康: 清失败计数 (不背包袱)
        cd = json.loads(COOLDOWN.read_text(encoding="utf-8"))
        if email in cd:
            cd.pop(email)
            _atomic_json(COOLDOWN, cd)
    except Exception:
        pass
    return sid


def credits_of(email: str) -> int | None:
    try:
        tok = api.load_token(email)
        st, text = api.api_call(
            None, "POST", "/user.v1.UserService/GetAvailableCredits",
            tok, body={})
        if st == 200:
            return int(json.loads(text).get("totalCredits", -1))
    except Exception:
        pass
    return None


# ---------------------------------------------------------------- 主流程
def account_page(email: str, idx: int):
    prof = PROFILES / email.split("@")[0]
    prof.mkdir(parents=True, exist_ok=True)
    return lib.make_page(port=PORT_BASE + idx, profile=str(prof))


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--limit", type=int, default=0)
    ap.add_argument("--gap-min", type=int, default=15)
    ap.add_argument("--gap-max", type=int, default=25)
    ap.add_argument("--end", default="14:30",
                    help="今日硬停时刻 (自媒 15:00 起跑前收官)")
    ap.add_argument("--duration", type=int, default=0,
                    help="班内时长上限(分钟): end=now+N (7×24 多班次模式, "
                         "0=沿用 --end 单班语义)")
    ap.add_argument("--max-today", type=int, default=0,
                    help="当日累计派单上限 (0=只用日帽). 非黄金班传 4 — "
                         "给 11:00 黄金窗留弹药 (1004 修正: 首夜夜班把 "
                         "日帽 8 单凌晨耗尽, 黄金窗反无弹)")
    ap.add_argument("--smoke", action="store_true",
                    help="冒烟: 仅 1 号 1 单端到端")
    ap.add_argument("--only", default="",
                    help="只派指定账号 (冒烟指定用)")
    ap.add_argument("--prefer", default="",
                    help="节点优先 (名称子串, 冒烟换 IP 用)")
    args = ap.parse_args()
    end_deadline = 0.0
    if args.duration > 0:                   # 7×24 多班次: 班内限时
        # 绝对时刻 (非 HH:MM 时钟) — 1003 实锤: 23:xx 起跑 end 落次日
        # 00:xx 时, 时钟元组比较 (23,36)>=(0,20) 恒真 → 开跑即硬停
        end_deadline = time.time() + args.duration * 60

    claim_or_exit()
    creds = dict(lib.load_accounts("Manus账号（全部）260922_干净版.txt"))
    if SQUAD_FILE.is_file():
        squad = json.loads(SQUAD_FILE.read_text(encoding="utf-8"))["squad"]
    else:
        squad = pick_squad(creds)
        log(f"首期小队生成 ({len(squad)} 号): {squad}")
    if not squad:
        log("小队为空, 退出")
        return 1

    led = load_ledger()
    cold = load_cooldown()
    total_today = sum(led["dispatched"].values())
    if args.max_today and total_today >= args.max_today:
        log(f"今日已派 {total_today} ≥ 非黄金班上限 {args.max_today}, "
            f"留弹药给黄金窗, 本班收官")
        return 0
    todo = [e for e in squad
            if led["dispatched"].get(e, 0) < DAILY_CAP
            and e not in cold]
    if args.only:
        todo = [e for e in todo if e == args.only]
    elif args.smoke:
        todo = todo[:1]
    elif args.limit:
        todo = todo[:args.limit]
    log(f"小队 {len(squad)} | 冷冻 {len(cold)} | 今日待派 {len(todo)}")
    if not todo:
        log("今日无事可派, 收官")
        return 0

    # ---- 开窗前 WeAIPO 闲门 (1003 7×24 协调令 + 精细化) ----
    # 精确判据: WeAIPO 自报在用国外网 (run_state.mode=rule / nb_wave 生产中)
    # 或 clash 已是 rule (别人的代理窗/残留窗) → 零网络操作干等闲窗,
    # 最多 15min; 仍忙 = 本班让路收官 (绝不挂 rule 干等, 下班自动再来)
    gate_from = time.time()
    while weaipo_net_busy() or get_mode() == "rule":
        if time.time() - gate_from > 900:
            log("WeAIPO 在用网持续 >15min, 本班让路不开窗 (下班再来)")
            return 0
        log("WeAIPO 国外网占用中, 等闲窗再开窗 (60s 轮询, 有界15min)...")
        time.sleep(60)
    log("WeAIPO 不在用国外网, 准予开窗")

    # ---- 开窗: rule + 节点验证 (lite probe) ----
    frm = get_mode()
    if frm != "rule":
        set_mode("rule")
        net_log(frm, "rule", "corps_v3 试点开窗")
        log(f"网络 {frm} → rule (已登记)")
    group, cands = discover_group()
    if args.prefer:
        cands.sort(key=lambda n: args.prefer not in n)
    log(f"组 {group!r} | 候选 {cands}")
    probe_page = lib.make_page(port=PORT_BASE, profile=str(PROFILES / "_probe"))
    node = None
    try:
        for cand in cands:
            if not switch(group, cand):
                continue
            time.sleep(2)
            if node_ok(probe_page):
                node = cand
                log(f"✓ 节点命中: {cand}")
                break
            log(f"✗ {cand} 不可用")
    finally:
        try:
            probe_page.browser.quit()
        except Exception:
            pass
    if node is None:
        log("节点全灭, 今日收官 (还原 direct)")
        set_mode("direct")
        net_log("rule", "direct", "corps_v3 节点全灭收官")
        return 3
    node_i = cands.index(node)

    def past_end() -> bool:
        if end_deadline:                    # --duration 模式: 绝对时刻
            return time.time() >= end_deadline
        h, m = map(int, args.end.split(":"))
        now = time.localtime()
        return (now.tm_hour, now.tm_min) >= (h, m)

    sent = skipped = failed = 0
    halted = False
    try:
        for i, email in enumerate(todo):
            if past_end():
                end_lbl = (time.strftime("%H:%M", time.localtime(end_deadline))
                           if end_deadline else args.end)
                log(f"到 {end_lbl} 硬停 (班内限时), 剩余下班续")
                break
            wait_from = time.time()
            while weaipo_net_busy():
                if past_end():
                    break
                if time.time() - wait_from > 480:   # 1003 协调令: 有界让路
                    break
                log("WeAIPO 在用国外网, 等闲窗 (60s 轮询, 有界8min)...")
                time.sleep(60)
            if weaipo_net_busy():
                log("WeAIPO 用网 >8min, 本班让路收官")
                break                   # → finally 守卫还原, 下班再来
            if past_end():
                break
            log(f"[{i + 1}/{len(todo)}] {email} "
                f"(profile=独立, port={PORT_BASE + i})")
            page = None
            try:
                page = account_page(email, i)
                try:                       # 显式导航后查墙 (空白页查=假阴)
                    page.get("https://manus.im/")
                    time.sleep(6)
                except Exception:
                    pass
                if region_walled(page):
                    node_i, ok = rotate_node(page, group, cands, node_i)
                    if ok:
                        log(f"区域墙→轮换到 {cands[node_i]} 解墙")
                    else:
                        log(f"⏭ {email} 区域墙全候选灭, 跳过 (非账号问题)")
                        skipped += 1
                        continue
                sess = lib.ensure_login(page, email, creds.get(email, ""))
                if sess is None:
                    raise RuntimeError("login-None")
                if region_walled(page):
                    node_i, ok = rotate_node(page, group, cands, node_i)
                    if not ok:
                        log(f"⏭ {email} 登录后仍区域墙, 跳过")
                        skipped += 1
                        continue
                if suspended(page):
                    V3_HALTED.write_text(
                        time.strftime("%Y-%m-%dT%H:%M:%S ")
                        + f"哨兵: {email} 页面见停用文案, 全队停\n",
                        encoding="utf-8")
                    log(f"⛔ 哨兵触发: {email} 见停用文案 — 全队停, "
                        f"还原 direct, 上报待用户")
                    halted = True
                    break
                cr = credits_of(email)
                if cr is not None and cr < MIN_CREDITS:
                    log(f"⏭ {email} credits={cr} 不足, 跳过")
                    skipped += 1
                elif dispatch(page, email):
                    sent += 1
                else:
                    failed += 1
            except Exception as e:
                failed += 1
                why = str(e)[:60]
                log(f"✗ {email} {type(e).__name__}: {why}")
                if "login" in why:
                    bump_fail(email)
                    if suspended(page):
                        V3_HALTED.write_text(
                            time.strftime("%Y-%m-%dT%H:%M:%S ")
                            + f"哨兵: {email} 登录失败+停用文案\n",
                            encoding="utf-8")
                        log("⛔ 停用文案确认, 全队停")
                        halted = True
                        break
                    # Turnstile 自适应加码缓解: 登录失败后换节点,
                    # 下一号不吃本节点已累积的 CF 风险
                    if page is not None:
                        try:
                            ni, ok = rotate_node(page, group, cands, node_i)
                            if ok:
                                node_i = ni
                                log(f"换节点备战下一号: {cands[node_i]}")
                        except Exception:
                            pass
            finally:
                try:
                    if page is not None:
                        page.browser.quit()
                except Exception:
                    pass
            if i < len(todo) - 1 and not halted:
                gap = random.uniform(args.gap_min * 60, args.gap_max * 60)
                log(f"号间间隔 {gap / 60:.0f}min (随机)")
                time.sleep(gap)
    finally:
        cur = get_mode()
        if cur != "direct":
            if weaipo_net_busy():
                # 1003 精细化: WeAIPO 已插进来用网 (rule 是它的窗),
                # 军团不还原 — 断它的窗比违反 restore 纪律伤害更大,
                # 其守护自己收线. 留痕登记.
                log("WeAIPO 在用网, mode 不还原 (留其守护收线)")
                net_log(cur, cur, "corps_v3 收官让网 (WeAIPO 在用)")
            else:
                set_mode("direct")
                net_log(cur, "direct", "corps_v3 收官还原")
                log(f"网络 {cur} → direct (已登记)")
        try:                            # 间隙哨兵冷却判据用
            (ROOT / "data" / "corps_v3_last_end.json").write_text(
                json.dumps({"ts": time.time()}), encoding="utf-8")
        except Exception:
            pass
    log(f"[收官] 发出 {sent} | 跳过 {skipped} | 失败 {failed}"
        + (" | ⛔哨兵停线" if halted else ""))
    return 0


if __name__ == "__main__":
    sys.exit(main())
