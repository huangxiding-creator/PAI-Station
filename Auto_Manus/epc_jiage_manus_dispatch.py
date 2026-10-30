# -*- coding: utf-8 -*-
"""EPC-JIAGE 军团试探性派单 (1025 军令「所有渠道都要使用」二波·manus腿).

背景: 第10份研报 S1 全渠道二波补位; 派单主题=工程计价依据体系全景.
机制: 复用军团在役件 (manus_lib login/send_task, profiles_v3 登录态复用,
token 直调积分预检); REST CreateTask 404x3 两次实锤 (0923+1025) → 浏览器
composer 为唯一实证派发路, 故本腿开浏览器 (端口 9441-9443, 避开
9333/9222/9336/9337 红线口; 最小化+离屏由 make_page 内建).

纪律: 单号单任务 (DAILY_PER_ACCOUNT≤2 沿 0923 用户授权); 成功才写军团
统一台账; 失败如实留痕零造假; 浏览器用完即清.

用法: py -X utf8 epc_jiage_manus_dispatch.py <email> <port>
"""
from __future__ import annotations

import json
import random
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import manus_api as api  # noqa: E402
import manus_lib as lib  # noqa: E402

ROOT = Path(__file__).resolve().parent
ACCOUNT_FILE = ROOT / "Manus账号（全部）260922_干净版.txt"
PROFILES = ROOT / "data" / "profiles_v3"
JLOG = ROOT / "data" / "epc_jiage_dispatch_log.jsonl"      # 本腿专账 (只增)
CORPS_LOG = ROOT / "data" / "epc50_corps_log.jsonl"        # 军团统一台账

TOPIC = ("工程计价依据体系全景：各省信息价发布机制、"
         "定额测定流程与合同解除结算规则")
EXTRA = ("聚焦计价/定额/结算/造价鉴定主题。信息价：覆盖不少于8个代表性"
         "省份（含江苏/广东/浙江/四川/河南/陕西/黑龙江/新疆）的发布载体、"
         "更新频次、查询入口与法律效力；定额：预算定额与工期定额的测定"
         "立项、测算方法、审批发布流程（含标准定额站/造价管理总站角色）；"
         "结算：不同合同解除类型（协商解除/违约解除/不可抗力/情势变更）"
         "下的结算规则与计价依据适用，附GB50500清单计价规范与建设工程"
         "造价鉴定规范现行版本号。全部信息须来自官方一手来源，"
         "2024-2026现行版本优先")
VARIANTS = [
    "每条关键信息请附来源链接与发布时间，优先官方一手来源，多渠道交叉验证。",
    "请为所有事实性内容标注可核查的出处（URL 与日期），官方与权威来源优先。",
    "所有数据与论断需给出引用来源（链接+发布时间），尽量从多个独立来源互证。",
]


def jlog(row: dict) -> None:
    row["ts"] = time.strftime("%Y-%m-%dT%H:%M:%S")
    with JLOG.open("a", encoding="utf-8") as f:
        f.write(json.dumps(row, ensure_ascii=False) + "\n")


def main() -> int:
    email = sys.argv[1]
    port = int(sys.argv[2]) if len(sys.argv) > 2 else 9441
    variant = random.choice(VARIANTS)
    prompt = lib.build_prompt("collect", TOPIC, EXTRA) + "\n\n" + variant
    creds = dict(lib.load_accounts(str(ACCOUNT_FILE)))
    if email not in creds:
        jlog({"email": email, "status": "no_password_in_account_file"})
        print(f"[jiage] {email} 无密码档案, 跳过")
        return 2
    tok = api.load_token(email)
    credits = -1
    if tok:
        st, text = api._urllib_call(
            "POST", "/user.v1.UserService/GetAvailableCredits", tok, {},
            timeout=12)
        if st == 200:
            try:
                credits = int(json.loads(text).get("totalCredits", -1))
            except ValueError:
                pass
    print(f"[jiage] {email} | 积分预检 {credits} | 端口 {port}", flush=True)
    if credits < 60:
        jlog({"email": email, "status": "low_credits", "credits": credits})
        print(f"[jiage] 积分不足 ({credits}) < 60, 不烧登录, 跳过")
        return 3
    prof = PROFILES / email.split("@")[0]
    prof.mkdir(parents=True, exist_ok=True)
    page = lib.make_page(port=port, profile=str(prof))
    try:
        try:
            country = lib.ensure_network(page)
            print(f"[jiage] 网络三件套绿, 出口 {country}", flush=True)
        except Exception as e:
            jlog({"email": email, "status": "net_guard_fail",
                  "err": f"{type(e).__name__}: {str(e)[:120]}"})
            print(f"[jiage] 网络预检失败: {e}")
            return 4
        try:
            sessions = lib.ensure_login(page, email, creds[email])
        except Exception as e:
            jlog({"email": email, "status": "login_exc",
                  "err": f"{type(e).__name__}: {str(e)[:120]}"})
            print(f"[jiage] 登录异常: {type(e).__name__}: {str(e)[:100]}")
            return 5
        if sessions is None:
            jlog({"email": email, "status": "login_fail"})
            print(f"[jiage] {email} 登录失败, 如实记账")
            return 5
        print(f"[jiage] 登录态就绪 (存量会话 {len(sessions)})", flush=True)
        try:
            sid, api_hits = lib.send_task(page, prompt)
        except Exception as e:
            jlog({"email": email, "status": "send_exc",
                  "err": f"{type(e).__name__}: {str(e)[:120]}"})
            print(f"[jiage] 派发异常: {type(e).__name__}: {str(e)[:100]}")
            return 6
        if not sid:
            jlog({"email": email, "status": "send_no_sid",
                  "api_hits": api_hits[:8]})
            print(f"[jiage] {email} 未落到 sid (积分墙/改版?), 如实记账")
            return 6
        jlog({"email": email, "status": "dispatched", "sid": sid,
              "credits_before": credits, "topic": TOPIC,
              "prompt_chars": len(prompt)})
        with CORPS_LOG.open("a", encoding="utf-8") as f:
            f.write(json.dumps({
                "ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "email": email,
                "sid": sid, "topic": "JIAGE-T0", "round": "topic",
                "q": None, "title": TOPIC[:40], "use": "collect",
                "engine": "manus", "battle": "EPC-JIAGE"},
                ensure_ascii=False) + "\n")
        print(f"[jiage] DISPATCHED {email} -> sid={sid}")
        return 0
    finally:
        try:
            page.quit()
        except Exception:
            pass


if __name__ == "__main__":
    sys.exit(main())
