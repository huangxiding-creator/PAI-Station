# -*- coding: utf-8 -*-
"""GB/T 50358 参编版本口径全局修正 (1103 零编造关键勘误: 我院参编2005第一版, 2017版roster无我院)."""
from pathlib import Path

WS = Path(r"E:\AI-Station\07 任务\福米电站EPC管理策划\05 Super-Skill工作区")


def fix(fp: str, pairs: list) -> None:
    p = WS / fp
    t = p.read_text(encoding="utf-8")
    n = 0
    for a, b in pairs:
        if a in t:
            t = t.replace(a, b)
            n += 1
    p.write_text(t, encoding="utf-8")
    print(fp, "replaced", n)


fix("nblm_out/_ch00_综合说明.md", [
    ("系水利行业唯一参编国家标准《建设项目工程总承包管理规范》（GB/T 50358-2017）的勘察设计单位",
     "系国家标准《建设项目工程总承包管理规范》（GB/T 50358）第一版（2005年版）唯一水利行业参编单位"),
])

fix("nblm_out/_ch16.md", [
    ("黄河院为该标准水利行业参编单位（“第一家/唯一”两纪要口径【待核】，以国标参编单位名单原件终核；详见第2章），国标落位按“参编者自我执行”标准掌握",
     "黄河院为该标准第一版（GB/T 50358-2005）参编单位——该版唯一水利行业署名单位（署名“水利部黄河水利委员会勘测规划设计研究院”，我院前身名；现行2017版为体系延续执行），国标落位按“参编者自我执行”标准掌握"),
])

fix("RESEARCH_DOCKET/synth/数字基准表.md", [
    ("GB/T 50358参编口径三源并存(唯一参编单位[内部文档+编制需求] vs 第一家[口述])建议统一表述",
     "终裁1103: 我院参编GB/T 50358第一版2005(该版唯一水利单位,署名黄委会勘测规划设计研究院=前身名); 2017现行版19家参编名单无我院——对外表述必须带版本"),
])

# 通配清扫: 各章/新章残留的 "唯一勘察设计参编" / "唯一参编GB/T 50358-2017" 类表述
import re
BAD = [
    (re.compile(r"GB/T ?50358-2017[^，。；\n]{0,12}唯一勘察设计参编"),
     "GB/T 50358第一版（2005）唯一水利行业参编"),
    (re.compile(r"唯一参编GB/T ?50358-2017"),
     "参编GB/T 50358第一版（2005，水利行业唯一）"),
    (re.compile(r"水利行业唯一参编国家标准《建设项目工程总承包管理规范》（GB/T 50358-2017）的勘察设计单位"),
     "国家标准《建设项目工程总承包管理规范》（GB/T 50358）第一版（2005）唯一水利行业参编单位"),
]
for fp in sorted((WS / "nblm_out").glob("_*.md")):
    t = fp.read_text(encoding="utf-8")
    orig = t
    for pat, rep in BAD:
        t = pat.sub(rep, t)
    if t != orig:
        fp.write_text(t, encoding="utf-8")
        print("swept", fp.name)
print("done")
