# -*- coding: utf-8 -*-
"""EPC50 饱和门接线 (0925 用户令: 融合缺口①, 成稿启动前硬前置).

把 reforge_factory 饱和引擎 (G3 coverage) 接到 EPC50 战役:
  - 问题树: epc50_topic_tree_v2.json (56 专题 × 10 问 = 560 子问题)
    → ammo_pool/EPC50-SNEI/question_tree.json (每问一 EEI)
  - 证据指派: 语料文件 ×(问题关键词) 词面匹配 → manifest 行
    (file, question) 对 — 一文件可支多问; 行 schema 与 ammo_pool.ingest
    逐字段同构, 直接落盘 (dedup_key 带问号防 ingest 去重误伤)
  - 有效性判断 (用户铁律「判断通过才计数」): 判据=问题锚定匹配
    (judge_engine=qmatch-v1) — 比 campaign 全局关键词更细: ima 方法论
    件对方法论语料是有效证据, 对企业专属问则不匹配不计数
  - 独立信源 (≥2 host 才算交叉验证): md 头「> 来源: URL」提真 host;
    无 URL 件按渠道归一伪 host (ima://kb.998 / 目录名) — ima 25321 条
    共享一个伪 host, 单源形态如实亮 △, 不被文件名 stem 假独立骗过
  - 反证位: 标题含风险词件记 stance=against (ACH 对抗原料)

产出: ammo_pool/EPC50-SNEI/{question_tree,manifest.jsonl,pool_state}.json
      + coverage() 饱和仪表写回 tree
      + battle/_pipeline/epc50_saturation.json (饥饿清单→军团定向弹)
口径诚实: pool_state.total_chars=去重文件字符 (非行累加, 不虚增门槛账);
      PDF 仅文件名匹配 (内容不提, 如实降级, 见 report.notes)。
"""
import json
import re
import subprocess
import sys
import time
from pathlib import Path
from urllib.parse import urlsplit

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

STATION = Path(r"E:\AI-Station")
BATTLE = STATION / "ResearchFactory-Eng" / "ResearchTopics" / \
    "《中石化南京工程有限公司怎么干EPC总承包？》"
TREE2 = BATTLE / "_pipeline" / "epc50_topic_tree_v2.json"
SAT_OUT = BATTLE / "_pipeline" / "epc50_saturation.json"
CID = "EPC50-SNEI"
POOL = STATION / "ammo_pool" / CID
CORPUS_ROOTS = [BATTLE / "04 网络调研搜集的资料",
                BATTLE / "02 用户准备的研究对象原料"]

COMPANY_ALIAS = ("中石化南京工程", "南京工程有限公司", "中石化南京",
                 "SNEI", "snei")
STOP = set("""公司 什么 如何 哪些 哪个 方面 现状 最新 布局 领域 情况
介绍 分析 研究 梳理 盘点 目前 近年来 是 在 的 与 和 及 对 从 被 有 无
模式 机制 体系 流程 做法 实践 特点 优势 挑战 问题 前景 趋势 战略 定位
组织 人才 管理 创新 市场 竞争 对标 业务 板块 布局 能力 建设 发展 变迁
沿革 体制 改革 转型 升级 结构 布局""".split())
AGAINST_RE = re.compile(
    r"风险|纠纷|处罚|败诉|失败|亏损|警示|整改|问责|事故|索赔|仲裁|诉讼")
URL_RE = re.compile(r"https?://[^\s\)\]】]")


def tokens(text: str) -> list[str]:
    """问题文本 → 匹配键: 去公司名/停用词, 切 2-6 字段词."""
    t = text
    for a in COMPANY_ALIAS:
        t = t.replace(a, " ")
    t = re.sub(r"[？?。，,、；;：:「」『』()\[\]（）\s]+", " ", t)
    words = [w for w in t.split() if len(w) >= 2 and w not in STOP]
    # 长词切双字滑窗增强召回 (中文复合词跨切)
    out = set(words)
    for w in words:
        if len(w) >= 4:
            out.update(w[i:i + 2] for i in range(len(w) - 1))
    return sorted(out)


def build_tree() -> dict:
    t2 = json.loads(TREE2.read_text(encoding="utf-8"))
    subqs = []
    for tp in t2["topics"]:
        for q in tp["questions"]:
            subqs.append({
                "id": q["id"], "dim": tp.get("dimension") or tp["id"],
                "text": q["text"],
                "eeis": [{"id": q["id"], "text": q["text"],
                          "region": "中国", "subject": "EPC总承包",
                          "queries": tp.get("queries", [])[:3]}]})
    return {"topic": t2.get("company", "中石化南京工程有限公司")
                  + " EPC总承包战役",
            "subquestions": subqs,
            "stats": {"subquestions": len(subqs),
                      "eeis": len(subqs),
                      "queries": sum(len(s["eeis"][0]["queries"])
                                     for s in subqs)},
            "source": "epc50_topic_tree_v2.json (560 问, 每问一 EEI)"}


def host_of(text_head: str, rel_dir: str) -> str:
    """独立信源: 来源 URL 真域 > 渠道伪域 (目录归一)."""
    m = URL_RE.search(text_head)
    if m:
        return urlsplit(m.group(0)).netloc
    if "51_ima" in rel_dir:
        return "ima://kb.998"
    return "chan://" + rel_dir


def credibility_of(rel_dir: str) -> str:
    if any(k in rel_dir for k in ("官网", "61_政策", "gov")):
        return "official"
    if any(k in rel_dir for k in ("论文学术", "40_洞见", "ima")):
        return "research"
    return "media"


def main() -> int:
    tree = build_tree()
    q_toks = {q["id"]: set(tokens(q["dim"] + " " + q["text"]))
              for q in tree["subquestions"]}
    q_ids = list(q_toks)
    POOL.mkdir(parents=True, exist_ok=True)

    files = []          # (path, rel_dir, name_tokens, text_head, chars)
    n_skip = 0
    for root in CORPUS_ROOTS:
        if not root.is_dir():
            continue
        for p in sorted(root.rglob("*")):
            if p.suffix.lower() not in (".md", ".txt", ".pdf"):
                continue
            if "_pipeline" in p.parts or "_ole2_tmp" in p.parts:
                continue
            rel_dir = p.parent.name
            name = re.sub(r"\.(md|txt|pdf)$", "", p.name, flags=re.I)
            name_toks = tokens(name)
            try:
                if p.suffix.lower() == ".pdf":
                    text_head = name          # PDF 只名匹配 (如实降级)
                    chars = 0
                else:
                    raw = p.read_text(encoding="utf-8", errors="replace")
                    text_head = name + "\n" + raw[:3000]
                    chars = len("".join(raw.split()))
            except Exception:
                n_skip += 1
                continue
            if chars < 200 and p.suffix.lower() != ".pdf":
                continue
            files.append((p, rel_dir, name_toks, text_head, chars))
    print(f"[sat] 语料 {len(files)} 件 (跳 {n_skip}) × {len(q_ids)} 问",
          flush=True)

    rows, seen_files = [], {}
    for p, rel_dir, name_toks, text_head, chars in files:
        head_lower = text_head.lower()
        name_lower = p.stem.lower()
        matched = []
        for qid in q_ids:
            toks = q_toks[qid]
            if not toks:
                continue
            t_in_name = sum(1 for t in toks if t.lower() in name_lower)
            t_in_head = sum(1 for t in toks
                            if t.lower() in head_lower)
            if t_in_name >= 2 or t_in_head >= max(3, len(toks) // 2):
                matched.append(qid)
        if not matched:
            continue
        key = str(p).lower()
        if key not in seen_files:
            seen_files[key] = {"chars": chars, "engine": rel_dir,
                               "host": host_of(text_head, rel_dir),
                               "cred": credibility_of(rel_dir)}
        fe = seen_files[key]
        stance = "against" if AGAINST_RE.search(p.stem) else "support"
        for qid in matched[:20]:      # 帽20: 防泛词件霸占全部问题
            rows.append({
                "ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
                "engine": fe["engine"], "source_path": str(p),
                "url_norm": fe["host"] if fe["host"].startswith(
                    ("ima:", "chan:")) else "https://" + fe["host"] + "/",
                "chars": fe["chars"], "credibility": fe["cred"],
                "dedup_key": f"{key}#{qid}",
                "judge": "valid", "judge_reason": "qmatch",
                "judge_engine": "qmatch-v1",
                "tree_node": qid, "stance": stance})

    with (POOL / "manifest.jsonl").open("w", encoding="utf-8") as f:
        for r in rows:
            f.write(json.dumps(r, ensure_ascii=False) + "\n")
    (POOL / "question_tree.json").write_text(
        json.dumps(tree, ensure_ascii=False, indent=1), encoding="utf-8")
    total_chars = sum(v["chars"] for v in seen_files.values())
    by_engine: dict[str, int] = {}
    for v in seen_files.values():
        by_engine[v["engine"]] = by_engine.get(v["engine"], 0) + v["chars"]
    # 0925 分池令 (用户): 一手/辅助分开计量 — state 拆两账, manifest 行保持混排
    # (行=文件×问题对; start_gate/门槛判据只读 state, 不行累加)
    AUX_ENGINES = {"51_ima知识库", "50_飞书语料", "99_v2问答",
                   "30_秘塔AI", "31_秘塔视频"}

    def _write_state(pool_dir: Path, campaign: str, files: dict, role: str):
        be: dict[str, int] = {}
        for v in files.values():
            be[v["engine"]] = be.get(v["engine"], 0) + v["chars"]
        pool_dir.mkdir(parents=True, exist_ok=True)
        (pool_dir / "pool_state.json").write_text(json.dumps({
            "campaign": campaign,
            "kws": list(COMPANY_ALIAS[:2]) + ["EPC总承包"],
            "total_chars": sum(be.values()), "items": len(files),
            "pending_chars": 0, "pending_items": 0,
            "rejected_chars": 0, "rejected_items": 0,
            "by_engine": dict(sorted(be.items(), key=lambda x: -x[1])),
            "domains": sorted({v["host"] for v in files.values()}),
            "gate_chars": 10_000_000,
            "created": time.strftime("%Y-%m-%d %H:%M"),
            "role": role,
            "note": "rows=(file,question)指派对; total_chars=去重文件账 "
                    "(非行累加); 判据=qmatch-v1 问题锚定; 0925分池: "
                    "state层一手/辅助分开 (用户令)"}, ensure_ascii=False,
            indent=1), encoding="utf-8")

    _write_state(POOL, CID,
                 {k: v for k, v in seen_files.items()
                  if v["engine"] not in AUX_ENGINES},
                 "primary_pool(一手门槛账)")
    aux_dir = POOL.parent / (CID + "-AUX")
    _write_state(aux_dir, CID + "-AUX",
                 {k: v for k, v in seen_files.items()
                  if v["engine"] in AUX_ENGINES},
                 "aux_pool(辅助分开计量,成稿可引用,不进门槛)")
    print(f"[sat] 指派 {len(rows)} 行 | 去重文件 {len(seen_files)} 件 "
          f"/ {total_chars:,} 字 | host {len(set(v['host'] for v in seen_files.values()))} 个",
          flush=True)

    r = subprocess.run([sys.executable, "ammo_pool.py", "coverage", CID],
                       cwd=str(STATION / "reforge_factory"),
                       capture_output=True, text=True, encoding="utf-8",
                       errors="replace")
    print(r.stdout or r.stderr, flush=True)

    # 饥饿清单: coverage 写回 tree 后重读, 出 zero/single 问
    t = json.loads((POOL / "question_tree.json").read_text(encoding="utf-8"))
    cov = t.get("coverage", {})
    hungry = []
    for q in t["subquestions"]:
        st = [e.get("status") for e in q["eeis"]]
        if any(s != "saturated" for s in st):
            hungry.append({"id": q["id"], "dim": q["dim"],
                           "text": q["text"][:60],
                           "status": "zero" if "zero" in st else "single"})
    SAT_OUT.write_text(json.dumps({
        "ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "cid": CID,
        **cov, "hungry_total": len(hungry),
        "hungry": hungry,
        "notes": ["PDF 仅文件名匹配 (内容提取未做, 单源判偏保守)",
                  "ima 全库共享伪 host ima://kb.998 — 单源如实亮 △",
                  "饥饿清单=军团定向采集优先队列"]},
        ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"[sat] 饱和 {cov.get('saturated', 0)}/{cov.get('eei_total', 0)}"
          f" ({cov.get('sat_pct', 0)}%) | 饥饿 {len(hungry)} 问 → "
          f"{SAT_OUT.name}", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
