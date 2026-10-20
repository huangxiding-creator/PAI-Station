# -*- coding: utf-8 -*-
"""sched_nblm_conn — NotebookLM 通道管理器（生产固化版）.

铁律（用户宪法令）:
- 用这个网络出口就要持续用——禁止切换出口/国家
- 更换国家有风险——会触发 Google 风控可能封号
- 找到可用出口后锁定整个生产周期
- NB 在云端运行不用管

本模块只做两件事:
1. 检测当前出口是否可访问 NB（不切换任何设置）
2. 如果可用 → 返回成功; 如果不可用 → 报告用户（不自行处理）

用法: py -X utf8 sched_nblm_conn.py --check
  返回 exit 0 = 可用, exit 1 = 不可用
"""
from __future__ import annotations

import argparse
import json
import os
import subprocess
import sys
import urllib.request
from pathlib import Path
from urllib.parse import quote

# 在任何网络操作前设置代理 env
os.environ.setdefault("HTTP_PROXY", "http://127.0.0.1:7890")
os.environ.setdefault("HTTPS_PROXY", "http://127.0.0.1:7890")

PROXY = "http://127.0.0.1:7890"
STATE_FILE = Path(__file__).resolve().parent / "sched" / "nblm_conn_state.json"
SECRET = "d42f2047-3a9e-451a-1-9e1c-b6a91441588f"  # noqa: 占位，运行时自动发现


def find_controller_port() -> int | None:
    """扫描 clash-win64 进程的控制器端口（每次CFW重启会变）."""
    r = subprocess.run(["netstat", "-ano"], capture_output=True)
    # 找 clash-win64 PID
    p = subprocess.run(
        ["powershell", "-NoProfile", "-Command",
         "(Get-Process clash-win64 -ErrorAction SilentlyContinue).Id"],
        capture_output=True, text=True)
    pid = p.stdout.strip()
    if not pid:
        return None
    # 找该 PID 的 127.0.0.1 端口
    for line in r.stdout.decode("gbk", errors="replace").splitlines():
        if pid in line and "127.0.0.1" in line and "LISTEN" in line:
            parts = line.split()
            local = parts[1] if len(parts) > 1 else ""
            port = int(local.split(":")[-1]) if ":" in local else 0
            if 1024 < port < 65536:
                return port
    return None


def test_nb_redirect() -> tuple[str, str]:
    """测试 notebooklm.google.com 的重定向状态.

    返回 (http_code, redirect_url)。
    可用判定: redirect 不含 'unsupported' 且 code 为 200/301/302。
    """
    r = subprocess.run(
        ["curl", "-s", "-m", "15", "-x", PROXY,
         "-o", "/dev/null",
         "-w", "%{http_code}|%{redirect_url}",
         "https://notebooklm.google.com"],
        capture_output=True, text=True, timeout=20)
    parts = r.stdout.strip().split("|")
    code = parts[0] if parts else "000"
    redir = parts[1] if len(parts) > 1 else ""
    return code, redir


def is_nb_accessible() -> bool:
    """判定 NB 是否可访问（不切换任何设置）."""
    code, redir = test_nb_redirect()
    if code == "000":
        return False  # 连不上
    if "unsupported" in redir:
        return False  # 区域拒
    return code in ("200", "301", "302", "303", "307", "308")


def get_current_exit() -> dict:
    """获取当前 Clash 配置信息（只读，不修改）."""
    port = find_controller_port()
    if not port:
        return {"controller_port": None}
    try:
        req = urllib.request.Request(
            f"http://127.0.0.1:{port}/proxies/{quote('默认节点')}",
            headers={"Authorization": f"Bearer {SECRET}"})
        d = json.loads(urllib.request.urlopen(req, timeout=5).read())
        return {"controller_port": port, "默认节点": d.get("now", "")}
    except Exception:
        return {"controller_port": port}


def check_and_report() -> int:
    """主入口: 检测 NB 可达性，输出状态，返回 exit code."""
    accessible = is_nb_accessible()
    exit_info = get_current_exit()
    code, redir = test_nb_redirect()

    if accessible:
        print("✅ NB 可访问")
        print(f"   HTTP: {code}")
        print(f"   出口配置: {exit_info}")
        # 保存状态（记录当前可用配置）
        state = {"accessible": True, "last_check": __import__("time").strftime("%F %T"),
                 "exit_info": exit_info, "http_code": code}
        STATE_FILE.parent.mkdir(parents=True, exist_ok=True)
        STATE_FILE.write_text(json.dumps(state, ensure_ascii=False, indent=1),
                              encoding="utf-8")
        return 0
    else:
        print("✗ NB 不可访问")
        print(f"   HTTP: {code}")
        print(f"   Redirect: {redir[:80]}")
        print(f"   出口配置: {exit_info}")
        print()
        print("⚠ 安全纪律: 禁止自行切换出口/国家（有封号风险）")
        print("   请检查代理或联系用户处理")
        return 1


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser(description="NB 通道管理器（只检测不切换）")
    ap.add_argument("--check", action="store_true", help="检测 NB 可达性")
    ns = ap.parse_args()
    if ns.check or True:  # 默认执行检测
        return check_and_report()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
