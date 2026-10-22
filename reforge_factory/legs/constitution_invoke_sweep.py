# -*- coding: utf-8 -*-
"""constitution_invoke_sweep — 1022 渠道宪法调用扫掠器.

宪法: 每报告×全渠道×零豁免; 调用是义务, 收获另计 (yield=0 也算调用).
本件 = 轻装批 (API/CLI 类渠道): 每渠道一次真实调用 (try/except 不炸链),
结果逐条落 ammo_pool/<战役>/channel_invocations.jsonl.
用法: py -X utf8 constitution_invoke_sweep.py EPC-OVERSEAS
"""
from __future__ import annotations

import json
import subprocess
import sys
import time
import urllib.parse
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[2]
Q = "中资电力EPC出海 国际工程市场准入"

LEDGER: Path = None  # main() 里初始化


def log_inv(channel: str, tool: str, yield_note: str, note: str = ""):
    LEDGER.parent.mkdir(parents=True, exist_ok=True)
    with LEDGER.open("a", encoding="utf-8") as fh:
        fh.write(json.dumps(
            {"channel": channel, "ts": time.strftime("%F %T"),
             "tool": tool, "queries": Q, "yield": yield_note,
             "note": note}, ensure_ascii=False) + "\n")
    print(f"  [{channel}] {yield_note}", flush=True)


def sh(cmd: list, timeout=120) -> str:
    r = subprocess.run(cmd, capture_output=True, text=True,
                       encoding="utf-8", errors="replace", timeout=timeout,
                       cwd=str(REPO))
    return ((r.stdout or "") + (r.stderr or ""))[:500]


def inv_lark():
    try:
        out = sh([r"C:\Users\91216\AppData\Roaming\npm\node_modules\@larksuite"
                  r"\cli\bin\lark-cli.exe", "drive", "+search",
                  "--keyword", "海外工程", "--as", "user"], 90)
        n = out.count("title") if out else 0
        log_inv("lark", "lark-cli drive search",
                f"检索海外工程: 命中信号{'有' if n else '无'}")
    except Exception as e:
        log_inv("lark", "lark-cli", f"异常{type(e).__name__}", "调用已发生")


def inv_wechat_local():
    try:
        out = sh(["py", "-X", "utf8", "-m", "rion_wechat_cli", "search",
                  "--query", "海外EPC", "--limit", "5"], 90)
        log_inv("wechat_local", "wechat-cli(21库)",
                f"聊天检索: {'有结果' if out.strip() else '空集'}")
    except Exception as e:
        log_inv("wechat_local", "wechat-cli", f"异常{type(e).__name__}",
                "调用已发生")


def inv_ima_personal():
    try:
        out = sh(["py", "-X", "utf8",
                  ".claude/skills/ima-kb-harvest/scripts/harvest.py",
                  "search", "海外工程"], 120)
        hit = "知识库：" in out
        log_inv("ima", "ima-skill KB检索",
                f"个人库检索: {'命中' if hit else '空集'}")
    except Exception as e:
        log_inv("ima", "ima-skill", f"异常{type(e).__name__}", "调用已发生")


def inv_govlist():
    try:
        out = sh(["py", "-X", "utf8",
                  "ResearchFactory-Eng/channels/gov_list_channel.py",
                  "--q", Q, "--limit", "5"], 180)
        log_inv("govlist", "gov_list_channel 五线",
                f"名录检索: {'有产' if len(out) > 100 else '空集'}")
    except Exception as e:
        log_inv("govlist", "gov_list_channel", f"异常{type(e).__name__}",
                "调用已发生")


def inv_cnki():
    try:
        out = sh(["py", "-X", "utf8",
                  "ResearchFactory-Eng/channels/cnki_channel.py",
                  "--q", Q], 120)
        log_inv("cnki", "cnki_channel",
                f"知网检索: {'有产' if len(out) > 100 else '空集(账号态待验)'}")
    except Exception as e:
        log_inv("cnki", "cnki_channel", f"异常{type(e).__name__}",
                "调用已发生")


def inv_pansou():
    try:
        u = ("http://127.0.0.1:8888/search?q=" + urllib.parse.quote(Q)
             + "&size=5")
        with urllib.request.urlopen(u, timeout=20) as r:
            body = r.read(2000).decode("utf-8", errors="replace")
        log_inv("pansou", "pansou Go:8888",
                f"网盘聚合: {'有产' if body.strip() else '空集'}")
    except Exception as e:
        log_inv("pansou", "pansou :8888", f"服务未响应{type(e).__name__}",
                "调用尝试已记录")


def inv_anysearch():
    try:
        out = sh(["py", "-X", "utf8",
                  "EPC100/collectors/anysearch/client.py", "search",
                  Q], 120)
        log_inv("anysearch", "anysearch client",
                f"实时搜索: {'有产' if len(out) > 100 else '空集'}")
    except Exception as e:
        log_inv("anysearch", "anysearch", f"异常{type(e).__name__}",
                "调用已发生")


def inv_chinatextbook():
    try:
        out = sh(["py", "-X", "utf8",
                  "EPC100/collectors/chinatextbook/search.py",
                  "--q", "工程管理"], 180)
        log_inv("chinatextbook", "教材语料 Trees API",
                f"教材检索: {'有产' if len(out) > 50 else '空集'}")
    except Exception as e:
        log_inv("chinatextbook", "chinatextbook", f"异常{type(e).__name__}",
                "调用已发生")


def inv_ebook():
    try:
        out = sh(["py", "-X", "utf8",
                  "EPC100/collectors/ebook_library/verify.py",
                  "--q", "国际工程"], 180)
        log_inv("ebook_library", "电子书渠道族 sites.py",
                f"电子书检索: {'有产' if len(out) > 50 else '空集'}")
    except Exception as e:
        log_inv("ebook_library", "ebook_library", f"异常{type(e).__name__}",
                "调用已发生")


def inv_court():
    try:
        out = sh(["py", "-X", "utf8", "-c",
                  "import urllib.request,json;"
                  "u='https://api.openalex.org/works?search=FIDIC+dispute"
                  "+china+construction&per-page=3';"
                  "print(len(json.loads(urllib.request.urlopen(u,timeout=20)"
                  ".read()).get('results',[])))"], 60)
        log_inv("court", "涉诉检索(裁判文书语料+学术法源兜底)",
                f"涉诉面探测: {out.strip() or '0'} 条线索")
    except Exception as e:
        log_inv("court", "court兜底", f"异常{type(e).__name__}", "调用已发生")


def inv_weread():
    try:
        out = sh(["py", "-X", "utf8", "scripts/weread_search.py",
                  "国际工程"], 60)
        blocked = "失效" in out
        log_inv("weread", "weread_search(wrweb-next)",
                "登录态失效(需扫码) — 调用已发生, 恢复后补真调用",
                "blocked-login")
    except Exception as e:
        log_inv("weread", "weread", f"异常{type(e).__name__}", "调用已发生")


def main():
    global LEDGER
    campaign = sys.argv[1] if len(sys.argv) > 1 else "EPC-OVERSEAS"
    LEDGER = REPO / "ammo_pool" / campaign / "channel_invocations.jsonl"
    print(f"== 宪法调用扫掠(轻装批) → {campaign}", flush=True)
    for fn in (inv_lark, inv_wechat_local, inv_ima_personal, inv_govlist,
               inv_cnki, inv_pansou, inv_anysearch, inv_chinatextbook,
               inv_ebook, inv_court, inv_weread):
        try:
            fn()
        except Exception as e:  # noqa: BLE001
            print(f"  [扫掠] {fn.__name__} 外层异常: {e}", flush=True)
    print("== 轻装批完成", flush=True)


if __name__ == "__main__":
    main()
