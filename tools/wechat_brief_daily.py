# -*- coding: utf-8 -*-
"""微信群聊简报每日流水线（无人值守，每晚 22:00 计划任务拉起）。

S1 索引    hub db-index（当天 00:00~23:59，私聊+群聊）
S2 机器稿  hub group-daily + contact-daily（同一时间窗）
S3 语义编辑 无头 claude 按 group-editorial 规范写 topics/groups/contacts/final_report
S4 旗舰 HTML render-bundle（pandoc 前置 PATH）
S5 PDF     Edge headless 打印 HTML
S6 发布    wb(workbench) 上传 index.html + latest.pdf 到阿里云 /www/WeChatBrief/
S7 推送    出站发件箱（桥守护进程消费 → 微信 PDF+网址）+ 企微兜底通知

运维：
  暂停   新建 tools/WeChatBriefPause 文件（main 首行早退）
  手跑   tools/wechat_brief_run_now.cmd（前台看全程输出）
  日志   tools/logs/brief_YYYYMMDD.log + tools/brief_state.json
  单段   python wechat_brief_daily.py --stages s3,s4

安全：全链路只读微信本地库；凭据零接触（wecom.secret.ini 由既有脚本读取）。
"""
from __future__ import annotations

import argparse
import datetime as dt
import glob
import json
import os
import re
import subprocess
import sys
import time
from pathlib import Path

if sys.stdout is None:  # pythonw 无控制台
    sys.stdout = open(os.devnull, "w", encoding="utf-8")
if sys.stderr is None:
    sys.stderr = open(os.devnull, "w", encoding="utf-8")
for _s in (sys.stdout, sys.stderr):
    if hasattr(_s, "reconfigure"):
        try:
            _s.reconfigure(encoding="utf-8", errors="replace")
        except Exception:  # noqa: BLE001
            pass

# ---------------------------------------------------------------- 路径常量
STATION = Path(r"E:\AI-Station")
TOOLS = STATION / "tools"
HUB_PROJ = STATION / "vendor" / "wechat-intelligence-hub" / "projects" / "wechat-intelligence-hub"
VENV_PY = STATION / "vendor" / "wechat-intelligence-hub" / ".venv" / "Scripts" / "python.exe"
READER_SHIM = STATION / ".claude" / "skills" / "wechat-cli" / "scripts" / "rion-wechat-cli.cmd"
HUBPY = HUB_PROJ / "wechat_intelligence_hub.py"
PANDOC_DIR = STATION / "tools" / "pandoc-3.11"
EDGE = Path(r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe")
WB = Path(r"C:\Users\91216\bin\wb.cmd")
NOTIFY = TOOLS / "notify_wecom.py"
PROMPT_TEMPLATE = TOOLS / "wechat_brief_claude_prompt.md"
SPOOL_DIR = Path.home() / ".wechat-claude-code" / "outbound-spool"

ECS_ID = "i-f8za6qhv365cwhti5y35"
SITE_URL = "http://47.120.43.20:8883/"
REMOTE_ROOT = "/www/WeChatBrief"

LOGS = TOOLS / "logs"
PAUSE_FLAG = TOOLS / "WeChatBriefPause"
LOCK_FILE = LOGS / "brief.lock"
STATE_FILE = TOOLS / "brief_state.json"

NO_WINDOW = 0x08000000  # CREATE_NO_WINDOW（不弹窗铁律）
CLAUDE_TIMEOUT = 1500   # 语义编辑 25 分钟
INSTANCE_ID = ECS_ID

_run_dir: Path | None = None  # set in main


def log(msg: str) -> None:
    line = f"[{dt.datetime.now().strftime('%H:%M:%S')}] {msg}"
    print(line, flush=True)
    LOGS.mkdir(parents=True, exist_ok=True)
    today = dt.date.today().strftime("%Y%m%d")
    with open(LOGS / f"brief_{today}.log", "a", encoding="utf-8") as fh:
        fh.write(line + "\n")


def sh(args, cwd=None, timeout=300, is_cmd=False, input_text=None):
    """统一子进程：无窗口、UTF-8 宽容解码。返回 (rc, stdout)。"""
    argv = ["cmd", "/c"] + [str(a) for a in args] if is_cmd else [str(a) for a in args]
    env = dict(os.environ)
    env.setdefault("PYTHONIOENCODING", "utf-8")
    try:
        p = subprocess.run(
            argv, cwd=str(cwd) if cwd else None, timeout=timeout,
            capture_output=True, creationflags=NO_WINDOW, env=env,
            input=input_text.encode("utf-8") if input_text is not None else None)
        out = (p.stdout or b"").decode("utf-8", errors="replace")
        err = (p.stderr or b"").decode("utf-8", errors="replace")
        return p.returncode, (out + ("\n[stderr] " + err if err.strip() else ""))
    except subprocess.TimeoutExpired:
        return 124, f"[timeout after {timeout}s]"
    except Exception as exc:  # noqa: BLE001
        return 125, f"[spawn-fail] {exc}"


def hub_env() -> dict:
    env = dict(os.environ)
    env.update({
        "WECHAT_HUB_HOME": str(HUB_PROJ),
        "PYTHONUTF8": "1",
        "WECHAT_READER_BIN": str(READER_SHIM),
    })
    return env


def hub(args, timeout=600):
    """直接调 hub 主程序（不经 hub.sh，免 bash 依赖）。"""
    env = hub_env()
    env["PATH"] = f"{PANDOC_DIR};{env.get('PATH', '')}"
    argv = [str(VENV_PY), str(HUBPY)] + [str(a) for a in args]
    try:
        p = subprocess.run(
            argv, cwd=str(HUB_PROJ), timeout=timeout, capture_output=True,
            creationflags=NO_WINDOW, env=env)
        out = (p.stdout or b"").decode("utf-8", errors="replace")
        err = (p.stderr or b"").decode("utf-8", errors="replace")
        return p.returncode, (out + ("\n[stderr] " + err if err.strip() else ""))
    except subprocess.TimeoutExpired:
        return 124, f"[timeout after {timeout}s]"
    except Exception as exc:  # noqa: BLE001
        return 125, f"[spawn-fail] {exc}"


def find_claude() -> Path:
    """VSCode 扩展原生 claude.exe（版本号择新）；npm shim 本机不可用。"""
    ext_root = Path.home() / ".vscode" / "extensions"
    if ext_root.is_dir():
        cands = []
        for p in ext_root.glob("anthropic.claude-code-*/resources/native-binary/claude.exe"):
            m = re.search(r"claude-code-(\d+(?:\.\d+)*)", str(p))
            key = tuple(int(x) for x in m.group(1).split(".")) if m else (0,)
            cands.append((key, p))
        if cands:
            return max(cands)[1]
    return Path(os.environ.get("APPDATA", "")) / "npm" / "claude.cmd"


def run_dir() -> Path:
    global _run_dir
    if _run_dir is None:
        stamp = dt.datetime.now().strftime("%Y%m%d-%H%M%S")
        _run_dir = HUB_PROJ / "output" / "auto" / f"run-{stamp}"
    return _run_dir


# ---------------------------------------------------------------- S1 索引
def s1_index(state: dict) -> bool:
    today = dt.date.today().strftime("%Y-%m-%d")
    out = run_dir() / "db-index"
    log(f"[S1] 索引 {today} 全天 → {out.name}")
    rc, outlog = hub([
        "db-index", "--scope", "sessions", "--session-type", "private,group",
        "--session-limit", "80", "--per-chat-limit", "500",
        "--since", f"{today} 00:00", "--until", f"{today} 23:59:59",
        "--out", str(out),
    ], timeout=900)
    log((outlog or "").strip().splitlines()[-1] if outlog else "")
    ok = rc == 0 and "读取消息" in outlog
    state["s1"] = {"ok": ok, "rc": rc}
    if not ok:
        log(f"[S1] 失败 rc={rc}\n{outlog[-800:]}")
    return ok


# ---------------------------------------------------------------- S2 机器稿
def s2_reports(state: dict) -> bool:
    today = dt.date.today().strftime("%Y-%m-%d")
    since, until = f"{today} 00:00", f"{today} 23:59:59"
    rd = run_dir()
    log("[S2] group-daily + contact-daily")
    rc1, out1 = hub(["group-daily", "--since", since, "--until", until,
                     "--out", str(rd / "group-daily")], timeout=900)
    rc2, out2 = hub(["contact-daily", "--since", since, "--until", until,
                     "--out", str(rd / "contact-daily")], timeout=600)
    ok = rc1 == 0
    state["s2"] = {"ok": ok, "rc_group": rc1, "rc_contact": rc2}
    if not ok:
        log(f"[S2] group-daily 失败\n{out1[-800:]}")
    return ok


# ---------------------------------------------------------------- S3 语义编辑
def s3_semantic(state: dict) -> bool:
    rd = run_dir()
    packet = rd / "group-daily" / "group_daily_editorial_packet.json"
    if not packet.is_file():
        log(f"[S3] 找不到编辑素材 {packet}")
        state["s3"] = {"ok": False, "note": "packet missing"}
        return False
    prompt = PROMPT_TEMPLATE.read_text(encoding="utf-8").format(run_dir=str(rd))
    claude = find_claude()
    log(f"[S3] 无头语义编辑：{claude.name}（超时 {CLAUDE_TIMEOUT}s）")
    argv = [str(claude), "-p", "--permission-mode", "acceptEdits",
            "--add-dir", str(HUB_PROJ), "--max-turns", "30",
            "--output-format", "text"]
    is_cmd = claude.suffix.lower() == ".cmd"
    rc, out = sh(argv, cwd=str(rd), timeout=CLAUDE_TIMEOUT,
                 input_text=prompt, is_cmd=is_cmd)
    (rd / "claude_edit_output.md").write_text(out or "", encoding="utf-8")
    need = [rd / "final_report.md",
            rd / "group-daily" / "group_daily_topics.md",
            rd / "group-daily" / "group_daily_groups.md",
            rd / "contact-daily" / "contact_daily_brief.md"]
    missing = [p.name for p in need if not p.is_file()]
    ok = rc == 0 and not missing
    state["s3"] = {"ok": ok, "rc": rc, "missing": missing}
    if not ok:
        log(f"[S3] 失败 rc={rc} missing={missing}\n{(out or '')[-600:]}")
    return ok


# ---------------------------------------------------------------- S4 HTML
def s4_bundle(state: dict) -> bool:
    rd = run_dir()
    log("[S4] render-bundle 旗舰 HTML")
    rc, out = hub(["render-bundle", str(rd)], timeout=600)
    html = rd / "wechat_daily_report.html"
    ok = rc == 0 and html.is_file() and html.stat().st_size > 5000
    state["s4"] = {"ok": ok, "rc": rc}
    if not ok:
        log(f"[S4] 失败 rc={rc}\n{out[-800:]}")
    return ok


# ---------------------------------------------------------------- S5 PDF
def s5_pdf(state: dict) -> bool:
    rd = run_dir()
    html = rd / "wechat_daily_report.html"
    pdf = rd / f"wechat_daily_report_{dt.date.today():%Y%m%d}.pdf"
    log(f"[S5] Edge headless → {pdf.name}")
    argv = [str(EDGE), "--headless", "--disable-gpu", "--no-first-run",
            "--no-pdf-header-footer", f"--print-to-pdf={pdf}",
            html.resolve().as_uri()]
    rc, _ = sh(argv, timeout=180)
    ok = rc == 0 and pdf.is_file() and pdf.stat().st_size > 10000
    state["s5"] = {"ok": ok, "rc": rc, "pdf": str(pdf) if ok else ""}
    if not ok:
        log(f"[S5] PDF 失败 rc={rc}")
    return ok


# ---------------------------------------------------------------- S6 发布
def s6_publish(state: dict) -> bool:
    rd = run_dir()
    html = rd / "wechat_daily_report.html"
    pdf = rd / f"wechat_daily_report_{dt.date.today():%Y%m%d}.pdf"
    log("[S6] 上传阿里云 /www/WeChatBrief")
    if not (html.is_file() and pdf.is_file()):
        state["s6"] = {"ok": False, "note": "html/pdf missing"}
        return False
    up1 = sh([str(WB), "upload", str(html), f"{REMOTE_ROOT}/index.html",
              "--instance-id", INSTANCE_ID, "-f"], timeout=180, is_cmd=True)
    up2 = sh([str(WB), "upload", str(pdf), f"{REMOTE_ROOT}/latest.pdf",
              "--instance-id", INSTANCE_ID, "-f"], timeout=180, is_cmd=True)
    up3 = sh([str(WB), "upload", str(pdf),
              f"{REMOTE_ROOT}/archive/{dt.date.today():%Y%m%d}.pdf",
              "--instance-id", INSTANCE_ID, "-f"], timeout=180, is_cmd=True)
    ok = up1[0] == 0 and up2[0] == 0
    state["s6"] = {"ok": ok, "rc1": up1[0], "rc2": up2[0], "rc3": up3[0]}
    if not ok:
        log(f"[S6] 上传失败 {up1[1][-300:]} {up2[1][-300:]}")
    return ok


# ---------------------------------------------------------------- S7 推送
def wecom(title: str, body: str) -> None:
    py = sys.executable if sys.executable.endswith(".exe") else str(VENV_PY)
    sh([py, str(NOTIFY), title, body], cwd=str(STATION), timeout=60)


def s7_push(state: dict) -> bool:
    rd = run_dir()
    pdf = rd / f"wechat_daily_report_{dt.date.today():%Y%m%d}.pdf"
    text = (f"📊 今日微信简报已发布\n{SITE_URL}\n"
            f"PDF：{SITE_URL}latest.pdf（本条附带本地版，网页版同内容）")
    # 出站发件箱：桥守护进程轮询消费 → 微信送达（token 过期则等下次对话补送）
    try:
        SPOOL_DIR.mkdir(parents=True, exist_ok=True)
        item = SPOOL_DIR / f"brief-{dt.date.today():%Y%m%d}.json"
        item.write_text(json.dumps({
            "text": text, "file": str(pdf),
            "created_at": dt.datetime.now().isoformat(timespec="seconds"),
        }, ensure_ascii=False, indent=2), encoding="utf-8")
        log(f"[S7] 发件箱已投：{item.name}")
    except Exception as exc:  # noqa: BLE001
        log(f"[S7] 发件箱写入失败：{exc}")
    # 企微兜底（立即送达，含网址）
    wecom("微信简报已发布", f"网址：{SITE_URL}\nPDF：{SITE_URL}latest.pdf\n（微信端 PDF 由桥补送）")
    state["s7"] = {"ok": True}
    return True


# ---------------------------------------------------------------- 主流程
STAGES = {"s1": s1_index, "s2": s2_reports, "s3": s3_semantic,
          "s4": s4_bundle, "s5": s5_pdf, "s6": s6_publish, "s7": s7_push}


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--stages", default="s1,s2,s3,s4,s5,s6,s7")
    args = parser.parse_args()

    if PAUSE_FLAG.exists():
        print("暂停旗标存在，退出")
        return 0
    LOGS.mkdir(parents=True, exist_ok=True)
    if LOCK_FILE.exists() and time.time() - LOCK_FILE.stat().st_mtime < 3600:
        print("上一次运行未结束（<1h），退出")
        return 0
    LOCK_FILE.write_text(str(os.getpid()), encoding="utf-8")

    state = {"date": dt.date.today().isoformat(), "started": dt.datetime.now().isoformat(timespec="seconds")}
    log(f"==== 微信简报流水线启动 pid={os.getpid()} run={run_dir().name} ====")
    failed: list[str] = []
    for name in [s.strip() for s in args.stages.split(",") if s.strip()]:
        try:
            if not STAGES[name](state):
                failed.append(name)
                if name in {"s1", "s2", "s3", "s4"}:  # 前段失败后段无意义
                    break
        except Exception as exc:  # noqa: BLE001
            failed.append(name)
            log(f"[{name.upper()}] 异常 {exc}")
            if name in {"s1", "s2", "s3", "s4"}:
                break
    state["finished"] = dt.datetime.now().isoformat(timespec="seconds")
    state["failed"] = failed
    STATE_FILE.write_text(json.dumps(state, ensure_ascii=False, indent=2), encoding="utf-8")
    log(f"==== 结束 failed={failed or '无'} ====")
    if failed:
        wecom("微信简报流水线告警", f"失败段：{'、'.join(failed)}\n详见 {LOGS}")
    try:
        LOCK_FILE.unlink()
    except OSError:
        pass
    return 1 if failed else 0


if __name__ == "__main__":
    raise SystemExit(main())
