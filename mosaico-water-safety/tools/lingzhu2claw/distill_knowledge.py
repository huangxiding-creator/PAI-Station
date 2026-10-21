# -*- coding: utf-8 -*-
"""知识蒸馏器: 本地KB源md → assets/knowledge/*.md（板端预算内）。

确定性蒸馏(零LLM): 小件全保留; 大件按标题树+关键词段落抽取。
用法: py tools/lingzhu2claw/distill_knowledge.py
"""
from __future__ import annotations

import os
import re

KB = r"E:\AI-Station\乐奇AI眼镜\水利安全助手AI眼镜\03 水利行业安全生产知识库\00 水利安全生产核心遵循文件"
OUT = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))), "assets", "knowledge")

# (输出名, 源文件, 模式, 预算KB)
PLAN = [
    ("重大隐患直接判定清单", "05-1《水利工程建设项目生产安全重大事故隐患清单指南》（2023版）.md", "full", 24),
    ("运行管理重大隐患清单", "05-2 《水利工程运行管理生产安全重大事故隐患清单指南》（2023版）.md", "full", 12),
    ("重大事故隐患判定导则", "05 《水利水电工程生产安全重大事故隐患判定导则》（SLT_842—2025).md", "distill", 22),
    ("危险性较大单项工程", "02附录 危险性较大的单项工程.md", "full", 8),
    ("六项机制实施指南要点", "06《水利安全生产风险管控“六项机制”实施工作指南》.md", "distill", 12),
    ("危险源辨识与风险评价方法", "04 《水利水电工程危险源辨识与风险评价导则》SLT843-2025.md", "distill", 10),
    ("建设安全生产管理规定", "01 水利工程建设安全生产管理规定（2005年发布，2014年修正，2017年修正，2019年修正）.md", "distill", 5),
    ("施工安全监督检查要点", "03 水利工程建设质量与安全生产监督检查办法（试行）_转自DOC.md", "distill", 4),
]

KEYWORDS = re.compile(r"风险|等级|判定|重大|危险源|LS|LEC|必须|应当|不得|严禁|机制|查找|研判|报告|管控|整改|备案|责任")


def distill(text: str, budget: int) -> str:
    out, size = [], 0
    lines = text.split("\n")
    i = 0
    while i < len(lines):
        ln = lines[i]
        if re.match(r"^#{1,4} ", ln):  # 标题全保
            out.append(ln)
            size += len(ln.encode("utf-8")) + 1
            i += 1
            continue
        # 关键词段落: 聚段
        if KEYWORDS.search(ln) and len(ln.strip()) > 10:
            para = [ln]
            j = i + 1
            while j < len(lines) and lines[j].strip() and not re.match(r"^#{1,4} ", lines[j]) and j - i < 6:
                para.append(lines[j])
                j += 1
            blob = "\n".join(para)
            b = len(blob.encode("utf-8")) + 1
            if size + b <= budget * 1024:
                out.append(blob)
                size += b
            i = j
            continue
        i += 1
    return "\n\n".join(out)


def main() -> int:
    os.makedirs(OUT, exist_ok=True)
    total = 0
    for name, src, mode, budget in PLAN:
        p = os.path.join(KB, src)
        if not os.path.exists(p):
            print(f"[skip] 源缺失: {src}")
            continue
        text = open(p, encoding="utf-8").read()
        if mode == "full":
            body = text
            if len(body.encode("utf-8")) > budget * 1024:
                body = body[: budget * 1024 // 3 * 3]
                print(f"[warn] {name} 超预算截断")
        else:
            body = distill(text, budget)
        out = f"# {name}\n\n（依据源文件蒸馏：{src}）\n\n{body}\n"
        fp = os.path.join(OUT, f"{name}.md")
        open(fp, "w", encoding="utf-8", newline="\n").write(out)
        sz = os.path.getsize(fp)
        total += sz
        print(f"[ok] {name}.md  {sz//1024}KB  (源{len(text.encode('utf-8'))//1024}KB)")
    print(f"[done] 合计 {total//1024}KB")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
