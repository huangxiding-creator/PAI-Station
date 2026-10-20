# -*- coding: utf-8 -*-
"""Manus 全链方法论 Live 抓取器 — 复用 Auto_Manus 基建.

链路: make_page(9333) → ensure_login → capture_token → credits 检查
→ send_task(复杂研报 prompt) → 轮询 getSessionV2 全事件流落盘
→ 完成后抓 files 清单 + outline.

账号安全: 单账号单发, token 只落 Auto_Manus/data/tokens (不进 git).
产物: 逆向工程/manus-reverse/live/<sid>/ 事件快照 + 进度日志.

用法: py -3 live_capture.py <email> [--poll 150] [--max-h 10]
"""
from __future__ import annotations

import argparse
import json
import sys
import time
import traceback
from pathlib import Path

HERE = Path(__file__).resolve().parent
AM = Path(r"E:\AI-Station\Auto_Manus")
sys.path.insert(0, str(AM))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

import manus_api as api          # noqa: E402
import manus_lib as lib          # noqa: E402

OUT = HERE.parent / "live"

RESEARCH_PROMPT = """请深入调研并撰写一份高水平研究报告：《中国水利水电工程EPC总承包风险管理研究报告》。

成果硬性要求：
1）报告结构单独存为"报告结构.md"文件，必须包含：严正声明、内容摘要、研究方法说明、报告价值说明、推荐序、不少于12章核心内容、术语表。章为一级标题，总章序号连续规范。
2）核心内容不少于12章，每章单独存储为一个Markdown文件，章节内容不可重复。总字数达到5万个汉字以上。
3）所有基础数据与事实必须真实、可靠、来源明确，关键信息通过多渠道交叉验证并标明出处；将详细的推理和思考过程写入相应内容，尽量采用表格呈现。穷尽方法无法获取的数据即删除并调整结构，不得留空、不得出现"待补充"字样。
4）语言风格专业、严谨、洞察、客观，符合工程建设术语规范；每个段落不少于150字。
5）各章节完成后按照"报告结构.md"整合为一份完整Markdown成果，并转制为docx格式交付。
6）最终交付前进行全面质量检查：对照上述要求逐项核验（结构完整/字数达标/格式规范/内容去重/无待补充），发现问题自动修正。
7）全流程自动化决策：故障自行修正；需确认事项自主采用最优方案，无需人工确认。遇到权限限制无法直接获取信息时，通过公开渠道间接查找。"""


def log(msg: str):
    line = f"[{time.strftime('%H:%M:%S')}] {msg}"
    print(line, flush=True)


def load_password(email: str) -> str:
    """从军团账号文件取密码 (格式: email|password — 同 lib.load_accounts)."""
    for name in ("Manus账号（全部）260922_干净版.txt",
                 "Manus账号（全部）260922.txt"):
        p = AM / name
        if not p.is_file():
            continue
        for ln in p.read_text(encoding="utf-8", errors="replace").splitlines():
            ln = ln.strip()
            if not ln or ln.startswith("#"):
                continue
            parts = ln.split("|")
            if (len(parts) >= 2 and "@" in parts[0]
                    and parts[0].strip().lower() == email.lower()):
                return parts[1].strip()
    return ""


def session_done(v2: dict) -> bool:
    """从 getSessionV2 判断任务是否收尾."""
    try:
        s = v2 if isinstance(v2, dict) else json.loads(v2)
        # 兼容 {session:{...}} 或直接 session 对象
        sess = s.get("session", s) if isinstance(s, dict) else {}
        status = (sess.get("status") or "").lower()
        return status in ("finished", "completed", "done", "stopped", "failed")
    except Exception:
        return False


def event_count(v2) -> int:
    try:
        s = v2 if isinstance(v2, dict) else json.loads(v2)
        evs = s.get("events") or s.get("session", {}).get("events") or []
        return len(evs)
    except Exception:
        return -1


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("email")
    ap.add_argument("--poll", type=int, default=150, help="轮询间隔秒")
    ap.add_argument("--max-h", type=float, default=10.0, help="最长守护小时")
    args = ap.parse_args()

    sid_dir = None
    page = None
    try:
        pw = load_password(args.email)
        if not pw:
            log(f"✗ 账号 {args.email} 不在军团文件")
            return 2
        page = lib.make_page(lib.BROWSER_PORT)
        sess_list = lib.ensure_login(page, args.email, pw)
        if sess_list is None:
            log("✗ 登录失败 (None)")
            return 3
        log(f"✓ 登录态就绪 (存量会话 {len(sess_list) if isinstance(sess_list, list) else '?'})")
        tok = api.capture_token(page)
        api.save_token(args.email, tok)
        st, text = api.api_call(page, "POST",
                                "/user.v1.UserService/GetAvailableCredits",
                                tok, body={})
        log(f"credits api rc={st} {text[:120]}")

        log("→ 下发复杂研报任务 (方法论全链捕获)…")
        sid, hits = lib.send_task(page, RESEARCH_PROMPT)
        if not sid:
            log("✗ send_task 无 sid")
            return 4
        log(f"✓ sid={sid}")

        sid_dir = OUT / sid
        sid_dir.mkdir(parents=True, exist_ok=True)
        (sid_dir / "prompt.txt").write_text(RESEARCH_PROMPT, encoding="utf-8")
        (sid_dir / "meta.json").write_text(json.dumps({
            "email": args.email, "sid": sid, "ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
            "hits": hits if isinstance(hits, (list, dict)) else str(hits)[:500],
        }, ensure_ascii=False, indent=2), encoding="utf-8")

        deadline = time.time() + args.max_h * 3600
        snap_i = 0
        last_count = -1
        while time.time() < deadline:
            time.sleep(args.poll)
            snap_i += 1
            try:
                v2 = api.get_session_v2(page, tok, sid)
                n = event_count(v2)
                done = session_done(v2)
                snap = sid_dir / f"v2_{snap_i:04d}.json"
                body = v2 if isinstance(v2, str) else json.dumps(v2, ensure_ascii=False)
                snap.write_text(body if isinstance(body, str) else str(body),
                                encoding="utf-8")
                log(f"snap#{snap_i} events={n} done={done} size={snap.stat().st_size}")
                if n == last_count and snap_i > 4 and n >= 0:
                    log("事件数连续两轮无增长 (可能已收尾或暂停)")
                last_count = n
                if done:
                    log("✓ 任务收尾, 抓 files+outline")
                    break
            except Exception as e:
                log(f"poll EXC {type(e).__name__}: {str(e)[:80]}")
                try:
                    lib.ensure_login(page, args.email, pw)
                    tok = api.capture_token(page)
                except Exception:
                    time.sleep(30)

        # 收尾: files + outline
        for kind, fn in (("files", "files.json"), ("outline", "outline.json")):
            try:
                if kind == "files":
                    body = api.get_files(page, tok, sid)
                else:
                    body = api.get_outline(page, tok, sid)
                s = body if isinstance(body, str) else json.dumps(body, ensure_ascii=False)
                (sid_dir / fn).write_text(s, encoding="utf-8")
                log(f"✓ {fn} {len(s)} bytes")
            except Exception as e:
                log(f"{kind} EXC {e}")
        log("=== live capture 结束 ===")
        return 0
    except Exception:
        traceback.print_exc()
        return 1
    finally:
        # 不杀浏览器: 沿用军团常驻 profile; 进程交还外层守护
        pass


if __name__ == "__main__":
    sys.exit(main())
