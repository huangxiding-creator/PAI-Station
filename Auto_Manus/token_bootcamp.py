# -*- coding: utf-8 -*-
"""军团全量 token 建立营 — 211 缺口账号批量建登录态 (0923).

登录门现状: OPEN (rule+美国出口). 每账号: ensure_login → capture_token
→ save_token → 即时 webhook 补配. 账号安全四件套: 账号间 8-15s 随机节流,
连败 3 冷却 5min, ban 词熔断停全营, 进度落盘可断点续跑.
"""
import json
import random
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import manus_api as api
import manus_lib as lib

STATE = Path("data/token_bootcamp.json")
BAN_WORDS = ("unavailable", "banned", "封禁", "deactivated", "verify your account")
GATE_MARKS = ("不可用", "unavailable", "not available", "无法使用")  # 区域门关


def _gate_closed(page) -> bool:
    """登录门探判: title/body 出现区域不可用文案 = 门关 (会漂移重开)."""
    try:
        t = (page.title or "") + " " + (page.html or "")[:4000]
    except Exception:
        return False
    return any(m in t.lower() for m in GATE_MARKS)


def _wait_gate_reopen(page) -> bool:
    """门关时每 1800s 重探, 最多 8h; 门开回 True, 超时回 False."""
    for _ in range(16):
        print("[gate] 登录门关, 1800s 后重探", flush=True)
        time.sleep(1800)
        try:
            page.get("https://manus.im/login?type=signIn")
            time.sleep(5)
        except Exception:
            continue
        if not _gate_closed(page):
            print("[gate] 门已重开, 继续建营", flush=True)
            return True
    return False


def load_state() -> dict:
    if STATE.is_file():
        return json.loads(STATE.read_text(encoding="utf-8"))
    return {"done": [], "failed": {}, "banned": [], "ts": ""}


def main() -> int:
    accounts = lib.load_accounts("Manus账号（全部）260922_干净版.txt")
    st = load_state()
    have = {p.stem.replace("_at_", "@") for p in
            Path("data/tokens").glob("*.json")}
    todo = [(e, p) for e, p in accounts
            if e not in have and e not in st["banned"]]
    print(f"[bootcamp] 缺 token {len(todo)} 账号, 已建 {len(have)}, "
          f"黑名单 {len(st['banned'])}", flush=True)
    if not todo:
        return 0

    page = lib.make_page()
    lib.ensure_network(page)
    consec_fail = 0
    try:
        for i, (email, password) in enumerate(todo, 1):
            if email in st["failed"] and st["failed"][email] >= 2:
                continue  # 两次失败留人工
            try:
                sess = lib.ensure_login(page, email, password)
                if sess is None:
                    raise RuntimeError("login-None")
                tok = api.capture_token(page)
                api.save_token(email, tok)
                st["done"].append(email)
                st["failed"].pop(email, None)
                consec_fail = 0
                print(f"[{i}/{len(todo)}] OK {email}", flush=True)
                # 即时 webhook 补配 (登录态新鲜, 顺手配置)
                try:
                    import manus_webhook_setup as wh
                    out = wh.configure_one(
                        Path("data/tokens") /
                        f"{email.replace('@', '_at_')}.json", apply=True)
                    print(f"    webhook: {out}", flush=True)
                except Exception as e:
                    print(f"    webhook 补配失败 {type(e).__name__}", flush=True)
                # 登录态新鲜, 顺手派发今日任务 (军团全员参战 0923 用户令;
                # 帽=2/账号/日, 同一登录态连发两单, 中间歇一拍)
                try:
                    import epc50_corps as corps
                    corps.dispatch_on_page(page, email)
                    time.sleep(random.uniform(15, 30))
                    corps.dispatch_on_page(page, email)
                except Exception as e:
                    print(f"    派发失败 {type(e).__name__}: {str(e)[:50]}",
                          flush=True)
            except RuntimeError as e:
                msg = str(e)
                page_html = ""
                try:
                    page_html = (page.html or "")[:3000].lower()
                except Exception:
                    pass
                if any(m in (page.title or "") or m in page_html
                       for m in GATE_MARKS):
                    # 区域门关 ≠ 账号问题: 长等待重探, 不烧冷却不熔断
                    st["ts"] = time.strftime("%Y-%m-%dT%H:%M:%S")
                    STATE.write_text(json.dumps(st, ensure_ascii=False),
                                     encoding="utf-8")
                    if not _wait_gate_reopen(page):
                        print("[gate] 8h 未重开, 收营留续跑", flush=True)
                        break
                    continue  # 门开了, 重试本账号
                if any(w in page_html or w in msg.lower() for w in BAN_WORDS):
                    st["banned"].append(email)
                    print(f"[{i}/{len(todo)}] BAN {email} — 全营熔断停止",
                          flush=True)
                    break
                st["failed"][email] = st["failed"].get(email, 0) + 1
                consec_fail += 1
                print(f"[{i}/{len(todo)}] FAIL {email} ({msg[:40]})", flush=True)
                if consec_fail >= 3:
                    print("[cooldown] 连败3, 冷却 300s", flush=True)
                    time.sleep(300)
                    consec_fail = 0
            except Exception as e:
                st["failed"][email] = st["failed"].get(email, 0) + 1
                consec_fail += 1
                print(f"[{i}/{len(todo)}] EXC {email} {type(e).__name__}: "
                      f"{str(e)[:60]}", flush=True)
            st["ts"] = time.strftime("%Y-%m-%dT%H:%M:%S")
            STATE.write_text(json.dumps(st, ensure_ascii=False), encoding="utf-8")
            time.sleep(random.uniform(8, 15))
    finally:
        try:
            page.quit()
        except Exception:
            pass
    print(f"[bootcamp 收] 新建 {len(st['done'])} | 失败 {len(st['failed'])} | "
          f"ban {len(st['banned'])}", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
