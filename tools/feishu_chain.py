# -*- coding: utf-8 -*-
"""feishu_chain.py — 飞书智库接力编排器 (1004大力采集令配套).

背景: 6线程inventory实锤丢树(2075) vs 3线程复核爬(>12000仍涨) —
高并发瞬时失败≥5次破防弃子树是根因. 本编排器串行接力, 杜绝并发互相打死:

  1. 等复核爬(brzp41dqs写 feishu_zongbao_nodes_verify.json)收敛退出
  2. 用复核版(更全)覆盖主nodes json → fetch 第二遍 (幂等, 只补新docx)
  3. 姊妹库(全量版 7532476524113920002) inventory 3线程 (低并发保树完整)
  4. 姊妹库 nodes → fetch (engine=feishu_zhiku 入池)
  5. 总rebuild入账

判活: 复核爬进程按命令行 --out verify json 匹配 (CIM并发失明防坑).
"""
import json
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
TOOLS = Path(r"E:\AI-Station\tools")
PY = (r"C:\Users\91216\AppData\Local\Programs\Python"
      r"\Python311\python.exe")
MAIN_JSON = TOOLS / "feishu_zongbao_nodes.json"
VERIFY_JSON = TOOLS / "feishu_zongbao_nodes_verify.json"
SISTER_JSON = TOOLS / "feishu_sister_nodes.json"
SISTER_SPACE = "7532476524113920002"
LOG = TOOLS / "feishu_chain.log"


def log(msg: str) -> None:
    line = f"[{time.strftime('%F %T')}] {msg}"
    print(line, flush=True)
    with LOG.open("a", encoding="utf-8") as f:
        f.write(line + "\n")


def verify_running() -> bool:
    """复核爬是否还活着 (按命令行含 verify json 名判, CIM失明防坑)."""
    out = subprocess.run(
        ["powershell", "-NoProfile", "-Command",
         "Get-CimInstance Win32_Process -Filter \"Name='python.exe'\" | "
         "Select-Object -ExpandProperty CommandLine"],
        capture_output=True, timeout=30).stdout or b""
    # GBK坑: 命令行含中文, text=True按locale解会炸reader线程 → 字节态自解
    txt = out.decode("utf-8", errors="replace") \
        + out.decode("gbk", errors="ignore")
    return "feishu_zongbao_nodes_verify" in txt


def run(args: list, tag: str) -> int:
    log(f"{tag} 启动: {' '.join(args)}")
    cp = subprocess.run([PY, "-X", "utf8", *args],
                        creationflags=0x08000000)  # CREATE_NO_WINDOW
    log(f"{tag} 退出码 {cp.returncode}")
    return cp.returncode


def count_docs(fp: Path) -> tuple:
    if not fp.exists():
        return 0, {}
    nodes = json.loads(fp.read_text(encoding="utf-8"))
    types: dict = {}
    for n in nodes:
        t = n.get("obj_type", "?")
        types[t] = types.get(t, 0) + 1
    return len(nodes), types


def main() -> int:
    log("接力编排器启动")
    # ① 等复核爬收敛 (最长等4h, 每60s查)
    waited = 0
    while verify_running():
        time.sleep(60)
        waited += 60
        n, t = count_docs(VERIFY_JSON)
        if waited % 600 == 0:
            log(f"复核爬仍在跑 {waited//60}min | 当前 {n} 节点 {t}")
        if waited >= 14400:
            log("复核爬超4h未收敛, 放弃等待 (用现有verify快照继续)")
            break
    n_v, t_v = count_docs(VERIFY_JSON)
    log(f"复核爬结束: {n_v} 节点 {t_v}")
    if n_v < 100:
        log("复核json异常小, 跳过覆盖")
    else:
        MAIN_JSON.write_text(
            VERIFY_JSON.read_text(encoding="utf-8"), encoding="utf-8")
        log(f"主nodes json已用复核版覆盖 ({n_v} 节点)")
        # ② fetch 第二遍 (幂等补差)
        run([str(TOOLS / "feishu_wiki_zongbao.py"), "fetch",
             "--threads", "6"], "fetch第二遍")
        # 再补一刀 (fetch单次失败件第二遍重试)
        run([str(TOOLS / "feishu_wiki_zongbao.py"), "fetch",
             "--threads", "6"], "fetch重试遍")

    # ③ 姊妹库下钻 (3线程低并发保树完整)
    run([str(TOOLS / "feishu_wiki_zongbao.py"), "inventory",
         "--space-id", SISTER_SPACE, "--threads", "3",
         "--out", str(SISTER_JSON)], "姊妹库inventory")
    n_s, t_s = count_docs(SISTER_JSON)
    log(f"姊妹库: {n_s} 节点 {t_s}")
    if n_s >= 100:
        # ④ 姊妹库 fetch (临时换主json → fetch → 还原)
        bak = TOOLS / "feishu_zongbao_nodes_main.bak.json"
        bak.write_text(MAIN_JSON.read_text(encoding="utf-8"),
                       encoding="utf-8")
        MAIN_JSON.write_text(
            SISTER_JSON.read_text(encoding="utf-8"), encoding="utf-8")
        run([str(TOOLS / "feishu_wiki_zongbao.py"), "fetch",
             "--threads", "6"], "姊妹库fetch")
        MAIN_JSON.write_text(
            bak.read_text(encoding="utf-8"), encoding="utf-8")
        log("主nodes json已还原")
    # ⑤ 总账
    import ammo_pool as ap  # noqa: E402
    sys.path.insert(0, r"E:\AI-Station\Auto_Manus")
    sys.path.insert(0, r"E:\AI-Station\reforge_factory")
    ap.rebuild("EPC49-SEPDC")
    s = json.loads((ap._camp_dir("EPC49-SEPDC") / "pool_state.json")
                   .read_text(encoding="utf-8"))
    log(f"[门槛账] 有效 {s['total_chars']:,} 字 "
        f"({100*s['total_chars']/200_000_000:.2f}% of 2亿)")
    log("接力编排器完成")
    return 0


if __name__ == "__main__":
    sys.exit(main())
