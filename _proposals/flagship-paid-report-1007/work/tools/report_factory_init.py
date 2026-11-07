# -*- coding: utf-8 -*-
"""report_factory_init — 日产能战役初始化器 (1108 用户令: 每天一份研报).

从战役配置生成全套产线脚本(以ESS第14份为正身模板, 身份全参数化)——
**消灭错拷污染类**(CASELAW残留事故的根因=手拷脚本漏改身份)。
生成物(写 m2/<slug>/):
  <slug>_nblm_run.py / <slug>_nblm_pack.py  (NBLM产线)
  <slug>_bank.py / sched_nb_draft.py(拷)   (S2三件套)
  <slug>_collation_worksheet.py / <slug>_merge.py  (收编+总装)
  sched/chapters.json                        (从问题树手订或传入)
用法:
  py -X utf8 report_factory_init.py --slug EPC-XX15 --campaign EPC-XX15 \\
     --no 15 --report《XX报告·2026》--buyers "XX人员" --title "XX实战指南" \\
     --tree E:/AI-Station/ammo_pool/EPC-XX15/question_tree.json
"""
from __future__ import annotations

import argparse
import json
import re
import shutil
import sys
from pathlib import Path

REPO = Path(r"E:\AI-Station")
WORK = REPO / "_proposals" / "flagship-paid-report-1007" / "work"
TEMPLATE = WORK / "m2" / "ess"
HERE = WORK / "tools"


def sub(text: str, m: dict) -> str:
    for k, v in m.items():
        text = text.replace(k, v)
    return text


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser()
    ap.add_argument("--slug", required=True)          # 目录名, 如 EPC-XX15
    ap.add_argument("--campaign", required=True)      # ammo_pool 池名
    ap.add_argument("--no", type=int, required=True)  # 第几份
    ap.add_argument("--report", required=True)        # 《报告全名》
    ap.add_argument("--buyers", required=True)
    ap.add_argument("--topic", required=True)         # 主题短语(prompt锚)
    ap.add_argument("--tree", default="")             # question_tree.json(可选)
    ns = ap.parse_args()

    dst = WORK / "m2" / ns.slug
    (dst / "sched").mkdir(parents=True, exist_ok=True)
    M = {
        "EPC-ESS": ns.campaign,
        "ess": ns.slug.lower(),
        "ESS-第14份": f"{ns.slug.upper()}-第{ns.no}份",
        "第14份": f"第{ns.no}份",
        "国际储能与光伏EPC总承包投标实战研究报告·2026": ns.report,
        "新能源EPC总承包企业高管、市场开发与投标报价人员、技术方案与成本控制工程师": ns.buyers,
        "储能与光伏EPC": ns.topic,
    }
    GEN = [
        ("ess_nblm_run.py", f"{ns.slug.lower()}_nblm_run.py"),
        ("ess_nblm_pack.py", f"{ns.slug.lower()}_nblm_pack.py"),
        ("ess_bank.py", f"{ns.slug.lower()}_bank.py"),
        ("ess_collation_worksheet.py", f"{ns.slug.lower()}_collation_worksheet.py"),
        ("ess_merge.py", f"{ns.slug.lower()}_merge.py"),
        ("sched_nb_draft.py", "sched_nb_draft.py"),
    ]
    for src, out in GEN:
        sp = TEMPLATE / src
        if not sp.is_file():
            print(f"[miss] 模板缺 {src}")
            continue
        t = sp.read_text(encoding="utf-8")
        t = sub(t, M)
        (dst / out).write_text(t, encoding="utf-8")
        print(f"[gen] {out}")
    if ns.tree:
        tree = json.loads(Path(ns.tree).read_text(encoding="utf-8"))
        print(f"[tree] campaign={tree.get('campaign')} topic={tree.get('topic')}"
              f" subquestions={len(tree.get('subquestions', []))}"
              f" — chapters.json 需按树手订12章(或接选型件)")
    print(f"[done] {dst} — 全链件已参数化生成; 编译验证: py -m py_compile {dst}/*.py")
    print("[提示] prompt正文中的战役主题句(框架/章prompt)生成后需人工过目一遍——模板替换只保身份一致, 主题语义句仍需校")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
