# -*- coding: utf-8 -*-
"""sched_nblm_expand — 20万CJK门缺口 NB 定向深化扩写件 (1021).

总装实测 182,692 CJK, 差 ~17,308。本件沿各章既有会话请 NB 补写一个
「深化实战节」(判例深析/完整算例/文书模板——增量内容非注水), 产物
chNN_扩写.md; 由编排方插到该章「本章小结要点」标题之前, 再总装过门。
安全宪法同族(锁出口); 守卫 min_chars=2500; 幂等: 已有扩写件即跳过。
用法: py -X utf8 sched_nblm_expand.py [--chapters 1,3,6,8,11]
"""
from __future__ import annotations

import asyncio
import json
import os
import sys
import time
from pathlib import Path

os.environ.setdefault("HTTP_PROXY", "http://127.0.0.1:7890")
os.environ.setdefault("HTTPS_PROXY", "http://127.0.0.1:7890")

M2 = Path(__file__).resolve().parent
SCHED = M2 / "sched"
OUT = SCHED / "nblm_out"
STATE_P = SCHED / "nblm_state.json"

# 每章一个深化节选题 (贴本章主题, 判例/算例/模板密度高)
TOPICS = {
    1: ("现金流四道闸量化演练与三案对照",
        "补写深化节「1.5 现金流四道闸的量化演练与三案对照」：取笔记本资料中"
        "有完整数字的三个判例，逐案演算延误天数→固定成本累积→资金占用利息→"
        "违约金敞口的完整链条（每步给出算式），并做成对照表；再给出承包商"
        "现金流预警的三档阈值设置建议。所有数字来自笔记本，句末标注编号。"),
    3: ("六时间参数完整算例与双代号网络图实战",
        "补写深化节「3.5 六时间参数完整算例与双代号网络图实战」：用一个笔记本"
        "资料中的真实工程（如福建高校配电房改造），完整演算 ES/EF/LS/LF/TF/FF "
        "六参数逐工序计算表、关键线路锁定过程、工期-成本优化的具体取舍步骤，"
        "并配判例说明网络图在诉讼举证中的效力要点。句末标注编号。"),
    6: ("签证七步法文书模板与反面判例",
        "补写深化节「6.6 签证闭环七步法的文书模板与反面判例」：为七步法每步"
        "给出可直接套用的文书要素模板（意向通知/同期记录/签证单九字段/索赔"
        "报告骨架），每模板配一个因文书缺陷败诉的反面判例（案情-裁判-文书"
        "缺口-教训）。句末标注编号。"),
    8: ("五族损失科目逐族算例",
        "补写深化节「8.9 五族损失科目逐族算例」：对停窝工人工费、机械闲置费、"
        "管理费、融资利息、利润损失五族，各取一个笔记本判例完整演算（口径-"
        "公式-代入-法院认定值-未被支持部分的教训），汇总成一张「科目-公式-"
        "证据要件」速查表。句末标注编号。"),
    11: ("FIDIC工期条款对照与海外实战要点",
        "补写深化节「11.6 FIDIC 工期条款对照与海外实战要点」：整理笔记本资料"
        "涉及的 FIDIC 银皮书/红皮书工期相关条款（开工/顺延/EOT/赶工/暂停）与"
        "2017版示范文本的逐条对照表，标注「同一情形两种文本下的不同后果」，"
        "并给海外项目工期管理的五条实战要点。句末标注编号。"),
}


async def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    nums = [int(x) for x in
            (sys.argv[sys.argv.index("--chapters") + 1]
             if "--chapters" in sys.argv else "1,3,6,8,11").split(",")]
    from notebooklm import NotebookLMClient
    from m2_write_guard import write_if_long
    st = json.loads(STATE_P.read_text(encoding="utf-8"))
    async with await NotebookLMClient.from_storage(timeout=120.0) as client:
        for n in nums:
            key, (title, ask) = f"ch{n:02d}", TOPICS[n]
            dst = OUT / f"ch{n:02d}_扩写.md"
            if dst.is_file() and dst.stat().st_size > 2500:
                print(f"[skip] ch{n:02d} 扩写已存在")
                continue
            nb_id = st["notebooks"][key]
            conv = st["chapters"][str(n)]["conversation_id"]
            print(f"[nb] ch{n:02d} 深化节「{title}」生成中…")
            try:
                res = await client.chat.ask(
                    nb_id,
                    f"为本章补写一个深化实战节。要求：{ask}\n"
                    f"读者是中国施工企业的项目经理、商务、造价与法务人员。"
                    f"直接输出正文（### 级标题起），禁止重复本章已有小节，"
                    f"语言平实具体，判例写清案情-裁判-教训。",
                    conversation_id=conv)
            except Exception as e:  # noqa: BLE001
                print(f"[!!] ch{n:02d} 扩写失败: {e}")
                continue
            if not write_if_long(dst, res.answer, min_chars=2500):
                print(f"[!!] ch{n:02d} 扩写被守卫拦截")
                continue
            st["chapters"][str(n)]["conversation_id"] = \
                res.conversation_id or conv
            st["chapters"][str(n)]["ts"] = time.strftime("%F %T")
            STATE_P.write_text(json.dumps(st, ensure_ascii=False, indent=1),
                               encoding="utf-8")
            cjk = len(__import__("re").findall(r"[一-鿿]", res.answer))
            print(f"[✅] ch{n:02d} 扩写 {cjk:,} CJK → {dst.name}")
            await asyncio.sleep(5)
    return 0


if __name__ == "__main__":
    raise SystemExit(asyncio.run(main()))
