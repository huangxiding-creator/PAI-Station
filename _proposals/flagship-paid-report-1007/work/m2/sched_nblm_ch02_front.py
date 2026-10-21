# -*- coding: utf-8 -*-
"""sched_nblm_ch02_front — ch02 前半(2.1-2.3) NB 补写件.

病理: ch02 首答即出「框架块+后半」, 前半 2.1-2.3 生而缺失。
修法: 沿既有会话续问前半三节(法定规则/示范文本/招投标衔接), 落
nblm_out/ch02_前半补写.md; 由编排方择机拼入编辑稿(框架块后、2.4前)。
安全宪法同 sched_nblm_run(锁出口不切换); 幂等: 已有产物>5KB即跳过。
用法: py -X utf8 sched_nblm_ch02_front.py
"""
from __future__ import annotations

import asyncio
import json
import os
import sys
from pathlib import Path

os.environ.setdefault("HTTP_PROXY", "http://127.0.0.1:7890")
os.environ.setdefault("HTTPS_PROXY", "http://127.0.0.1:7890")

M2 = Path(__file__).resolve().parent
SCHED = M2 / "sched"
OUT = SCHED / "nblm_out"
STATE_P = SCHED / "nblm_state.json"

ASK = (
    "此前你已输出第2章的后半部分（2.4-2.8小节）。现在补写本章前半部分"
    "（2.1-2.3小节），标题与要求如下：\n"
    "2.1 法定规则坐标系——民法典、建筑法、招标投标法、司法解释（一）（二）"
    "中与工期相关的条款如何叠加成规则底座，每条写清「条款说了什么+对工期"
    "意味着什么」；\n"
    "2.2 施工合同示范文本坐标系——2017版示范文本的工期顺延条款（19.1款等）"
    "四代演进，28天除斥期间、变更程序、开竣工日期认定；\n"
    "2.3 招投标与合同衔接坐标系——招标文件工期条款如何进入合同、不平衡报价"
    "与工期风险、黑白合同的工期认定。\n"
    "读者：中国施工企业的项目经理、商务、造价与法务人员。所有数字与案例"
    "必须来自笔记本资料，句末标注来源编号；判例写清案情-裁判-教训；语言"
    "平实具体。直接输出正文，不要重复已输出的后半小节。")


async def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    dst = OUT / "ch02_前半补写.md"
    if dst.is_file() and dst.stat().st_size > 5000:
        print("[skip] 前半补写已存在", dst.stat().st_size, "B")
        return 0
    from notebooklm import NotebookLMClient
    st = json.loads(STATE_P.read_text(encoding="utf-8"))
    nb_id = st["notebooks"]["ch02"]
    conv = st["chapters"]["2"]["conversation_id"]
    async with await NotebookLMClient.from_storage(timeout=120.0) as client:
        res = await client.chat.ask(nb_id, ASK, conversation_id=conv)
    parts = [res.answer]
    conv2 = res.conversation_id or conv
    await asyncio.sleep(4)
    try:  # 一次续写拿足 (前半信息量大, 单答常截断)
        r2 = await client.chat.ask(
            nb_id, "继续输出 2.1-2.3 剩余内容并收尾，禁止重复已输出小节，"
                   "句末继续标注来源编号。完稿时不要加任何寒暄。",
            conversation_id=conv2)
        parts.append(r2.answer)
    except Exception as e:  # noqa: BLE001
        print("[!] 续写失败(单段也可用):", e)
    text = "\n\n".join(parts)
    from m2_write_guard import write_if_long
    if not write_if_long(dst, text, min_chars=3000):
        print("[!!] 补写被守卫拦截(疑似空/截断)")
        return 1
    st["chapters"]["2"]["conversation_id"] = conv2
    st["chapters"]["2"]["ts"] = __import__("time").strftime("%F %T")
    STATE_P.write_text(json.dumps(st, ensure_ascii=False, indent=1),
                       encoding="utf-8")
    total = sum(len(p) for p in parts)
    print(f"[✅] ch02 前半补写 {total:,}字 ({len(parts)}段) → {dst.name}")
    return 0


if __name__ == "__main__":
    raise SystemExit(asyncio.run(main()))
