# -*- coding: utf-8 -*-
"""fomi_nblm_exec_summary - 综合说明(执行摘要)生成: 战役总本提问, 产出 nblm_out/_ch00_综合说明.md.
用法: py -X utf8 fomi_nblm_exec_summary.py
"""
from __future__ import annotations

import asyncio
import os
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
os.environ.setdefault("NOTEBOOKLM_TRANSPORT", "curl_cffi")
WS = Path(r"E:\AI-Station\07 任务\福米电站EPC管理策划\05 Super-Skill工作区")
OUT = WS / "nblm_out"
STATE = WS / "nblm_state.json"
PX = os.environ.get("NBLM_PROXY", "http://127.0.0.1:7892")
for k in ("http_proxy", "https_proxy", "HTTP_PROXY", "HTTPS_PROXY"):
    os.environ.pop(k, None)
os.environ["HTTP_PROXY"] = PX
os.environ["HTTPS_PROXY"] = PX

PROMPT = (
    "你是世界顶级国际工程咨询公司资深合伙人。基于本笔记本全部资料，为《几内亚福米水电站"
    "EPC建设管理策划方案》撰写开篇「综合说明」（执行摘要，给工行行领导的一页式驾驶舱）。"
    "要求：\n"
    "1)第一段=一句话总纲（谁·干什么·凭什么成）；\n"
    "2)「核心量化承诺表」：工程基准(装机/库容/发电量)、工期(41个月/第33个月首台)、"
    "投资与融资框架、质量安全事故底线、运维衔接(75人属地化)——数字只准照抄资料；\n"
    "3)「工行疑虑导航表」：六条核心疑虑×回应章节×一句证据；\n"
    "4)「黄河院五大独特优势」：规范参编地位/设计深度已到初设/十年坚守投入/数字总包+AI眼镜/"
    "凯乐塔同国别经验——各一句实证；\n"
    "5)结尾=管理底线承诺段；\n"
    "6)简体中文markdown，全文900-1300字，禁止空话，每个数字有资料出处。")


async def main() -> int:
    import json
    from notebooklm import NotebookLMClient
    st = json.loads(STATE.read_text(encoding="utf-8"))
    nb_id = st.get("notebooks", {}).get("framework")
    if not nb_id:
        print("[abort] state 无 framework 笔记本 id — 先跑 phase framework")
        return 1
    for att in range(4):
        try:
            async with await NotebookLMClient.from_storage(timeout=120.0) as c:
                res = await c.chat.ask(nb_id, PROMPT)
                OUT.mkdir(exist_ok=True)
                (OUT / "_ch00_综合说明.md").write_text(res.answer,
                                                       encoding="utf-8")
                cjk = len(re.findall(r"[一-鿿]", res.answer))
                print(f"[OK] 综合说明 {len(res.answer):,}字 CJK {cjk} "
                      f"→ _ch00_综合说明.md")
                return 0
        except Exception as e:                         # noqa: BLE001
            print(f"[es!] 第{att+1}次失败 {type(e).__name__} {str(e)[:90]} "
                  f"— 冷却300s")
            await asyncio.sleep(300)
    return 1


if __name__ == "__main__":
    raise SystemExit(asyncio.run(main()))
