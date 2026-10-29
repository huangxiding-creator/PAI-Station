# -*- coding: utf-8 -*-
"""brick 种子构建·解析探针：轻量行式 TTL 解析（stdlib 正则，零第三方包）。

Brick.ttl（v1.4.4 release 编译版）为 rdflib 序列化 Turtle，格式高度规整：
  - 主体块起始行=列 0 「<subject> a <类型列表>;」
  - 谓词行=恰 4 空格缩进；8 空格以上=空白节点内部（sh:property[...] 等，忽略）
  - 逗号续行对象=8 空格缩进的裸前缀名
本探针只取类层级三要素：types / rdfs:label / rdfs:subClassOf / owl:deprecated。
"""
import re
from collections import Counter

PATH = r"E:/AI-Station/kb_factory/seeds/brick/_raw/Brick_v1.4.4.ttl"

SUBJ_HEAD = re.compile(r"^(\S+) a (\S+?)[,;]?\s*$")
PRED = re.compile(r"^    ([a-z]+:[\w]+)\s+(.*)$")
LITERAL = re.compile(r'^"(.*)"(?:\^\^[\w:<>]+|@[a-zA-Z-]+)?$')


def parse():
    subjects = {}
    cur = None          # 当前主体 id
    last_pred = None    # 待续谓词（逗号续行）
    for raw in open(PATH, encoding="utf-8"):
        line = raw.rstrip("\n")
        if not line.strip() or line.startswith("@"):
            cur, last_pred = None, None
            continue
        if not line[0].isspace():                      # 列 0 = 新主体块
            m = SUBJ_HEAD.match(line)
            if m:
                cur = m.group(1)
                rec = subjects.setdefault(cur, {"types": [], "label": None,
                                                "parents": [], "deprecated": False})
                t = m.group(2).rstrip(",;")
                if t not in rec["types"]:
                    rec["types"].append(t)
                last_pred = "a"
            else:                                      # 主体散述行（如 owl:deprecated）
                cur, last_pred = None, None
            continue
        ind = len(line) - len(line.lstrip(" "))
        if ind >= 8:                                   # 空白节点内部 / 深续行
            if ind == 8 and last_pred and line.strip() != "]":
                tok = line.strip().rstrip(",;")
                if last_pred == "a" and re.match(r"^[a-z]+:[\w]+$", tok):
                    rec = subjects[cur]
                    if tok not in rec["types"]:
                        rec["types"].append(tok)
                elif last_pred == "rdfs:subClassOf" and re.match(r"^[a-z]+:[\w]+$", tok):
                    if tok not in subjects[cur]["parents"]:
                        subjects[cur]["parents"].append(tok)
            continue
        m = PRED.match(line)                           # 4 空格谓词行
        if not m:
            continue
        pred, rest = m.group(1), m.group(2).strip()
        if cur is None:
            continue
        rec = subjects[cur]
        if rest.endswith(","):
            last_pred = pred
            rest = rest[:-1].strip()
        else:
            last_pred = None
        if pred == "rdfs:label":
            lm = LITERAL.match(rest.rstrip(";.").strip())
            if lm and not rec["label"]:
                rec["label"] = lm.group(1)
        elif pred == "rdfs:subClassOf":
            tok = rest.rstrip(";.").strip()
            if re.match(r"^[a-z]+:[\w.]+$", tok) and tok not in rec["parents"]:
                rec["parents"].append(tok)
        elif pred == "owl:deprecated":
            if rest.rstrip(";").strip() == "true":
                rec["deprecated"] = True
    return subjects


if __name__ == "__main__":
    subs = parse()
    print("总主体数:", len(subs))
    ns = Counter(s.split(":")[0] for s in subs)
    print("命名空间分布:", ns.most_common())
    # 类筛选：rdfs:Class / owl:Class 且 brick:/rec: 命名空间
    classes = {s: r for s, r in subs.items()
               if s.split(":")[0] in ("brick", "rec")
               and ("rdfs:Class" in r["types"] or "owl:Class" in r["types"])}
    print("brick+rec 类数:", len(classes))
    print("  其中 deprecated:", sum(1 for r in classes.values() if r["deprecated"]))
    print("  无标签:", sum(1 for r in classes.values() if not r["label"]))
    # 孤儿（父在类集外）
    orphans = [s for s, r in classes.items()
               if not any(p in classes for p in r["parents"])]
    print("  根/孤儿（父在集外）:", len(orphans))
    for s in sorted(orphans)[:20]:
        print("   ", s, classes[s]["parents"], classes[s]["label"])
    # 顶类（Equipment/Location/Point/System 子女规模）
    kids = Counter()
    for s, r in classes.items():
        for p in r["parents"]:
            kids[p] += 1
    print("子女最多的 15 类:", kids.most_common(15))
