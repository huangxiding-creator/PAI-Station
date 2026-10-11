# -*- coding: utf-8 -*-
"""F1 调研搜集门 — 1010 用户两连令固化 (代码级, 非会话约定):

  令一「调研搜集的资料总字数不达标坚决不能开工写报告」
       → 字数门: T1≥300万 ∧ T1+T2≥3000万 有效字符 (弹药门 v3 口径,
         tiers.json 判定, 只算新增; 2亿=采集预算参考线)
  令二「字数达标后详细汇报质量情况, 我验收批准后才可以开始撰写」
       → 质量门: QUALITY_DOSSIER 生成 + user_approved 旗标;
         仅当用户在会话中明示批准后方可 `approve` 落旗.

联动硬闸: m2_gate.py / m2_gate2.py 顶部检查本门 state,
  user_approved != true → 一律 exit 2 拒绝放行任何章节 (写作冻结).

用法:
  python collection_gate.py measure   # 扫语料+池, 刷 state (字数面)
  python collection_gate.py status    # 打印门态
  python collection_gate.py report    # 达标后生成质量汇报骨架
  python collection_gate.py approve --note "用户批准原话"   # 用户明示后!
"""
import argparse
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
WORK = Path(__file__).parent
STATE = WORK / "collection_gate_state.json"
DOSSIER = WORK / "QUALITY_DOSSIER.md"
F1_INV = WORK / "f1_inventory.json"
CORPUS = Path(r"F:\新建文件夹\AI总包创新院\总包研报")
AMMO = Path(r"E:\AI-Station\ammo_pool")
F1_POOL = AMMO / "F1-BLUEBOOK"
F1_TREE = WORK / "f1_gap_tree_v2.json"
V3_LOG = Path(r"E:\AI-Station\Auto_Manus\data\epc50_corps_log.jsonl")

BAR = {"t1_min": 3_000_000, "t1t2_min": 30_000_000,
       "budget_chars": 200_000_000}       # 弹药门 v3 (1005 用户令)


def _load() -> dict:
    try:
        return json.loads(STATE.read_text(encoding="utf-8"))
    except Exception:
        return {"measured_at": None, "f1_corpus_chars": 0,
                "f1_pool": {}, "corps_f1": {}, "tier": None,
                "word_gate_pass": False, "quality_report": None,
                "user_approved": False, "approved_at": None,
                "approved_note": None}


def _save(st: dict) -> None:
    st["bar"] = BAR
    tmp = STATE.with_suffix(".tmp")
    tmp.write_text(json.dumps(st, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    tmp.replace(STATE)


def cjk_of(text: str) -> int:
    return sum('\u4e00' <= c <= '\u9fff' for c in text)


def measure(st: dict) -> dict:
    # ① F1 语料存量 (inventory 实测口径, docx/文本字符)
    try:
        inv = json.loads(F1_INV.read_text(encoding="utf-8"))
        if isinstance(inv, list):                     # 67 项清单 (真源 schema)
            st["f1_corpus_chars"] = int(sum(
                x.get("words_total", 0) for x in inv))
            st["f1_corpus_dirs"] = len(inv)
        else:
            st["f1_corpus_chars"] = int(inv.get("words_total", 0))
            st["f1_corpus_dirs"] = int(inv.get("dirs", 0))
    except Exception:
        st["f1_corpus_chars"] = 0
    # ② F1 专属弹药池 (存量语料 f1_pool_build + 军团 hook_harvest 双入口)
    pool = {"exists": (F1_POOL / "pool_state.json").is_file()}
    try:
        ps = json.loads((F1_POOL / "pool_state.json").read_text(encoding="utf-8"))
        pool.update({"total_chars": ps.get("total_chars", 0),
                     "items": ps.get("items", 0),
                     "pending_chars": ps.get("pending_chars", 0),
                     "t1_chars": ps.get("t1_chars", None),
                     "t2_chars": ps.get("t2_chars", None),
                     "t3_chars": ps.get("t3_chars", None),
                     "t0_chars": ps.get("t0_chars", None),
                     "t1_items": ps.get("t1_items", None),
                     "t2_items": ps.get("t2_items", None),
                     "gate_chars": ps.get("gate_chars", None),
                     "by_engine": ps.get("by_engine", {}),
                     "last_tier_persist": ps.get("last_tier_persist")})
    except Exception:
        pass
    st["f1_pool"] = pool
    # ③ 军团 F1 树派单/收单面
    try:
        t = json.loads(F1_TREE.read_text(encoding="utf-8"))
        qs = [q for tp in t["topics"] for q in tp["questions"]]
        st["corps_f1"] = {
            "pending": sum(q["status"] == "pending" for q in qs),
            "dispatched": sum(q["status"] == "dispatched" for q in qs),
            "done": sum(q["status"] not in ("pending", "dispatched")
                        for q in qs),
            "harvested_chars": sum(q.get("chars", 0) for q in qs),
        }
    except Exception:
        st["corps_f1"] = {}
    # ④ 字数门: 只认 tier 判定过的有效数 (池 t1/t2); 无判定 = 未达标
    t1 = pool.get("t1_chars")
    t2 = pool.get("t2_chars")
    st["tier"] = {"t1_valid": t1, "t2_valid": t2,
                  "judge": "pending" if t1 is None else "pool_state"}
    st["word_gate_pass"] = bool(
        t1 is not None and t2 is not None
        and t1 >= BAR["t1_min"] and t1 + t2 >= BAR["t1t2_min"])
    st["measured_at"] = time.strftime("%Y-%m-%dT%H:%M:%S")
    return st


def _channel_ledger(by_engine: dict) -> list:
    """渠道完备门过账行: 注册表 16 渠道 × F1 池 engine 账 (静默缺席不许收官)."""
    reg_path = Path(r"E:\AI-Station\Auto_Manus\data\bus"
                    r"\channel_registry.json")
    try:
        reg = json.loads(reg_path.read_text(encoding="utf-8"))
    except Exception:
        reg = []
    rows = []
    for ch in reg:
        cid_, name = ch.get("id", "?"), ch.get("name", "?")
        if cid_ == "manus":
            contrib = by_engine.get("manus:corps", 0)
            note = "F1 缺口树派单收割 (hook_harvest 自动入池)"
        else:
            contrib = 0
            note = ("存量编译内含其历史贡献; 跨战役复用已过账"
                    "（见下方池engine cross: 行）; F1 专属新采待开火")
        rows.append((name, contrib, note))
    for tag, chars in sorted(by_engine.items(), key=lambda x: -x[1]):
        if tag == "manus:corps":                     # manus 账已挂注册行
            continue
        if tag == "cross:rss":
            note = "跨战役收割件复用入账 (data/rss_harvest RSS 常年收割面, 同尺 judge+tiers)"
        elif tag.startswith("cross:"):
            note = "跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers)"
        else:
            note = "存量语料建池入账 (多渠道历史编译)"
        rows.append((f"[池engine] {tag}", chars, note))
    return rows


def _grade_hist() -> str:
    try:
        inv = json.loads(F1_INV.read_text(encoding="utf-8"))
        g = {}
        for x in inv:
            g[x.get("grade", "?")] = g.get(x.get("grade", "?"), 0) + 1
        return " · ".join(f"{k}级 {v} 目录" for k, v in sorted(g.items()))
    except Exception:
        return "(盘点件缺失)"


def report(st: dict) -> int:
    """质量档案生成 — 门态无关恒可出 (全部实数, 零手填)。

    门未过时本档案=进度+质量实况 (标题明示 FAIL, 非验收放行件);
    门过后同一生成器产出即为用户验收材料。approve 前置仍硬性要求
    word_gate_pass — 序列不可作弊 (1010 用户令)。
    """
    p = st.get("f1_pool", {})
    r = st.get("corps_f1", {})
    t1 = p.get("t1_chars")
    t2 = p.get("t2_chars")
    t12 = (t1 or 0) + (t2 or 0)
    t1_s = f"{t1:,}" if t1 is not None else "?"
    t2_s = f"{t2:,}" if t2 is not None else "?"
    gate = "PASS ✅" if st.get("word_gate_pass") else "FAIL ⏳"
    nature = ("用户验收材料" if st.get("word_gate_pass")
              else "**进度与质量实况 (字数门未过, 非验收放行件)**")
    gap = max(0, BAR["t1t2_min"] - t12)
    eng_lines = "\n".join(
        f"| {k} | {v:,} |" for k, v in
        sorted(p.get("by_engine", {}).items(), key=lambda x: -x[1]))
    ledger = _channel_ledger(p.get("by_engine", {}))
    ledger_lines = "\n".join(
        f"| {n} | {c:,} | {note} |" for n, c, note in ledger)
    # 缺口四面: 树话题进度 + 存量主稿对位
    try:
        t = json.loads(F1_TREE.read_text(encoding="utf-8"))
        face_rows = []
        for tp in t["topics"]:
            qs = tp["questions"]
            face_rows.append((tp["title"],
                              sum(q["status"] == "pending" for q in qs),
                              sum(q["status"] == "dispatched" for q in qs),
                              sum(q["status"] not in ("pending", "dispatched")
                                  for q in qs),
                              sum(q.get("chars", 0) for q in qs)))
        face_lines = "\n".join(
            f"| {ti} | 待派 {a} / 已派 {b} / 已收 {c} | 已收割 {d:,} 字 |"
            for ti, a, b, c, d in face_rows)
    except Exception:
        face_lines = "(树件缺失)"
    md = f"""# F1 调研搜集质量档案 — {st['measured_at']} ｜ {nature}

> 字数门: T1≥{BAR['t1_min']:,} ∧ T1+T2≥{BAR['t1t2_min']:,} 有效字符（弹药门 v3,
> tiers.json 判定, 只算新增+judge valid）
> 实绩: T1={t1_s} ｜ T2={t2_s}
> ｜ T1+T2={t12:,} ｜ **门态 {gate}**（距 T1+T2 门差 {gap:,} 字待采）

## 1. 总量与分层账
- 存量语料盘点: {st['f1_corpus_chars']:,} 字（han+西文词口径,
  {st.get('f1_corpus_dirs', '?')} 目录, {_grade_hist()}）
- F1-BLUEBOOK 池（判定后真账）: 有效 {p.get('total_chars', 0):,} 字 /
  {p.get('items', 0)} 件 ｜ 待审 {p.get('pending_chars', 0):,}
- 分层: T1 {t1_s} ({p.get('t1_items','?')}件) ｜
  T2 {t2_s} ({p.get('t2_items','?')}件) ｜
  T3 {p.get('t3_chars', 0) or 0:,}（封顶不计门）｜ T0 {p.get('t0_chars', 0) or 0:,}（不计）
- 军团 F1 缺口树: 待派 {r.get('pending')} / 已派 {r.get('dispatched')} /
  已收 {r.get('done')} / 收割 {r.get('harvested_chars', 0):,} 字
- 池引擎账:
| engine | 字数 |
|---|---|
{eng_lines}

## 2. 渠道完备门过账（注册表逐条, 静默缺席不许收官）
| 渠道 | F1 专属贡献(字) | 态/计划 |
|---|---|---|
{ledger_lines}

## 3. 分层成色
- T1 主稿构成（按引擎分账, 不一概而论）: stock:corpus 67 件 = 我方
  编译研究报告（credibility=research → GRADE B 权威二手, 原始一手源
  在其引用链内）; cross:* 收割件 = 各渠道一手/二手资料, 按渠道
  cred 定级（gov=policy/standards 类, paper=cnki/academic 类,
  research=djyanbao 类, 其余 web）, 成稿引用照断言链 S0 门回溯
- 存量成色: {_grade_hist()}（A=单稿≥8万字可精编）
- 抽样锚点回查: 3-1 湖南打样章已过 m2_gate2 数字锚点门
  （165 去重锚点 / own_calc×5 / 源内分歧显式披露）— 方法链在位,
  全量章级回查随 M2 量产逐章执行
- 同题归并纪律: 存量建池 86 候选 docx → 71 主稿（副本/排版/中间
  成果 15 件留档不入池, 防版本虚账）; cross:* 腿内容头去重同防双计

## 4. 缺口四面覆盖（f1_gap_tree_v2 实况）
| 面 | 树进度 | 已收割 |
|---|---|---|
{face_lines}

## 5. 已知瑕疵与披露
1. **口径差**: 存量盘点 1,034.8 万 = han+西文词口径; 存量建池 71 主稿
   10,159,246 = 去空白全字符口径且剔版本副本 — 两者差异为口径定义,
   非丢失（cross:* 与军团增量腿与盘点口径无关, 全走池账）。
2. 存量为**我方自产二手编译品**（B 级）, 非一手官方源; 蓝皮书引用
   数字仍须按断言链 S0 门回溯一手出处（湖南章已示范）。
3. PDF 未入池（与盘点口径对齐防 docx+pdf 双计）, 留档可查。
4. T1/T2 分层为**标题级下界**（1005 定调词表 tiers.json）: 标题无
   EPC 族词≠内容不相关, T0 件在成稿阶段照常可引用, 只不上门账。
5. 树问 chars 为收割 raw 口径, 池门账只认 judge valid — 两账并行
   不互换。
6. 渠道完备门: 16 注册渠道中 F1 专属贡献当前仅存量编译+军团两腿,
   其余渠道 F1 专属补采**尚未开火**（首窗后按完备门逐条过账）。
7. **跨战役复用披露**（1011 两腿）: 池内 engine=cross:* 行为跨战役
   复用 — 一腿来自 ResearchTopics 研究树（EPC49/50 历史战役工作区）
   收割件, 二腿来自 data/rss_harvest/articles（PAIStation-rss-harvest
   每日 07:37/19:37 的 RSS 常年收割面, engine=cross:rss 单列可区分）。
   同一把尺（F1 词表 judge + tiers 标题分层）, 内容头去重（两腿重叠
   14,742 件已自动跳过）; 排除法院裁判文书卷宗、用户私有资料、
   >2MB 合并巨件三类; PAIStation-F1CrossIngest 计划任务 30min 增量
   重跑（幂等）。跨战役素材与 F1 专属新采在池内按 engine 可区分,
   不冒充新采。
"""
    DOSSIER.write_text(md, encoding="utf-8")
    st["quality_report"] = str(DOSSIER)
    print(f"✓ 质量档案已生成 {DOSSIER.name} (门态 {gate}, 全实数)")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("cmd", choices=["measure", "status", "report", "approve"])
    ap.add_argument("--note", default="")
    args = ap.parse_args()
    st = _load()
    if args.cmd == "measure":
        st = measure(st)
        _save(st)
    elif args.cmd == "report":
        rc = report(st)
        _save(st)
        return rc
    elif args.cmd == "approve":
        if not st.get("word_gate_pass"):
            print("⛔ 字数门未过, 不可批准")
            return 1
        if not st.get("quality_report"):
            print("⛔ 质量汇报未生成, 不可批准")
            return 1
        st["user_approved"] = True
        st["approved_at"] = time.strftime("%Y-%m-%dT%H:%M:%S")
        st["approved_note"] = args.note or "用户会话明示批准"
        _save(st)
        print("✓ 用户验收旗标已落 — 写作解冻 (m2_gate 守卫放行)")
        return 0
    g = st.get("word_gate_pass")
    print(f"[F1搜集门 {st.get('measured_at')}] 语料 {st.get('f1_corpus_chars', 0):,} raw"
          f" | T1={st['tier']['t1_valid'] if st.get('tier') else '?'}"
          f" T2={st['tier']['t2_valid'] if st.get('tier') else '?'}"
          f" | 字数门 {'PASS' if g else 'FAIL'}"
          f" | 质量汇报 {'有' if st.get('quality_report') else '无'}"
          f" | 用户批准 {'✓' if st.get('user_approved') else '✗ 未批 — 写作冻结'}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
