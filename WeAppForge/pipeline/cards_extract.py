# -*- coding: utf-8 -*-
"""cards_extract.py — 商机卡结构化抽取（裂变 2.0 波 3a，2026-09-28；VIRAL_100X 引擎 1 数据底座）

母本=data/xueyuan/content/reports/<slug>/chapters_full.json（B 线契约件，旁挂零重解析）。
纯代码 html 结构抽取（零模型调用）；已实车形态五类，多形态适配+兜底跳过计数：
  A: <p><strong>N. [T2][类别] 项目名</strong></p> + <ul><li>阶段：..</li></ul>   （站点详情）
  C: <p><strong>N. 项目名 [★]</strong></p> + <p>类型: .. | 阶段: .. | ..</p>     （汇总清单）
  B: 附录表  #|项目名称|类别|区域|投资额|可操作性|综合评分（/阶段|评分）          （Top100/全量索引）
  E: 地市局分类表 序号|商机名称|采购方|.. / 项目/采购名称|主要内容|需求方/采购方式|..
     / 策略建议全量表 项目|商机类型|需求方|来源|可操作性
产出契约（字段名冻结，交接引擎/卡渲染/前端三方）：
  微信小程序/zongbao/content/cards/<slug>.json =
  {"report_id","generated_at","source":"cards_extract v1",
   "cards":[{"id","title","amount","amount_raw","owner","stage","window",
             "province","source_chapter","summary"}]}
纪律（C14）：抽不出=空串/'-' 如实，绝不编造；summary=原文关键词拼装（项目+业主+金额），禁止改写。
幂等：已产出且非 --force 跳过（字节级稳定）；--force/缺失才重抽，卡序=首现顺序（排序冻结）。
"""
from __future__ import annotations

import argparse
import json
import re
import sys
from datetime import datetime
from html.parser import HTMLParser
from pathlib import Path

XY_CONTENT = Path("E:/AI-Station/data/xueyuan/content")            # 母本（chapters_full.json）
PROJECT_CONTENT = Path("E:/AI-Station/微信小程序/zongbao/content")
CARDS_DIR = PROJECT_CONTENT / "cards"
SOURCE_TAG = "cards_extract v1"
BIG_TABLE_ROWS = 500      # 全量索引表行数阈值（js 附录C 实测 17104 行）
BIG_TABLE_KEEP = 100      # 大表保留前 N 数据行（评分降序=Top100，与附录A 同源同序）

# ---------------- 无效值集（如实为空，不编造） ----------------
INVALID_GENERIC = {"未提及", "未提供", "未公开", "未知", "留空", "—", "-", "－",
                   "?", "？", "无", "", "视项目而定"}
INVALID_AMOUNT = INVALID_GENERIC | {"自筹", "财政", "政府投资", "国有", "多个渠道"}

# ---------------- 表头 → 逻辑列映射（形态 B/E） ----------------
COLMAP = [
    ("title", ("商机名称", "项目/采购名称", "项目名称", "工程名称", "项目", "名称")),
    ("owner", ("采购方", "需求方/采购方式", "需求方", "业主单位", "业主", "采购单位")),
    ("window", ("截止日期", "截止/时间", "期限", "计划工期", "工期", "时间窗", "时间")),
    ("stage", ("项目阶段", "当前阶段", "所处阶段", "阶段")),
    ("amount", ("投资额", "总投资", "合同金额", "投资规模", "投资", "金额")),
    ("desc", ("主要内容", "项目内容", "内容", "简介", "备注", "说明")),
]

HEAD_PAT = re.compile(r"^\s*(\d{1,4})\s*[.、．]\s*(.+)$")            # 条目头：N. ……
LI_KV_PAT = re.compile(r"^(阶段|期限|投资|采购方|需求方|截止|合作方式|采购方式|"
                       r"可操作性评分|类别|评分|类型|来源|合作)[:：]\s*(.*)$")
PIPE_KV_PAT = re.compile(r"(类型|阶段|投资|合作方式|合作|需求方|采购方|来源|期限|"
                         r"采购方式|截止)[:：]")
AMOUNT_PAT = re.compile(r"[约逾超近]?\s*[\d,，.．]+\s*(?:亿元|万元|元)")
AMOUNT_HINT_PAT = re.compile(r"(?:总投资|投资|概算|合同价|预算|估算价|金额)[约为?？:：\s]{0,4}"
                             r"([约逾超近]?\s*[\d,，.．]+\s*(?:亿元|万元|元))")
H2_OWNER_PAT = re.compile(r"^(.{2,30}?(?:局|厅|委|中心|公司|政府))（\d+\s*个商机）$")


# ================= html → 块序列（标准库，零三方依赖） =================
class BlockParser(HTMLParser):
    """mammoth 规整 html → 块序列。块形状：
    ("p", text, strong_only) / ("h1"|"h2"|"h3", text) / ("ul", [li,..]) / ("table", [[cell,..],..])
    td/li 内的 <p> 归并进所在 cell/li 文本（不产顶层块）。"""

    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.blocks: list = []
        self._buf: list = []
        self._strong_buf: list = []
        self._in_strong = 0
        self._cell: list | None = None        # 当前 td 文本片段
        self._li: list | None = None          # 当前 li 文本片段
        self._row: list | None = None
        self._rows: list | None = None
        self._pending_lis: list = []

    # ---- 文本累计去向：td > li > 顶层块 ----
    def _emit(self, text: str) -> None:
        if self._cell is not None:
            if text:
                self._cell.append(text)
        elif self._li is not None:
            if text:
                self._li.append(text)

    def handle_starttag(self, tag, attrs):
        if tag in ("p", "h1", "h2", "h3", "h4", "h5", "h6"):
            self._buf, self._strong_buf, self._in_strong = [], [], 0
        elif tag == "strong":
            self._in_strong += 1
        elif tag == "br":
            self._emit("\n")
        elif tag == "li":
            self._li = []
        elif tag == "table":
            self._rows = []
        elif tag == "tr" and self._rows is not None:
            self._row = []
        elif tag in ("td", "th") and self._row is not None:
            self._cell = []

    def handle_endtag(self, tag):
        if tag in ("p", "h1", "h2", "h3", "h4", "h5", "h6"):
            text = "".join(self._buf).strip()
            strong_text = "".join(self._strong_buf).strip()
            self._buf, self._strong_buf, self._in_strong = [], [], 0
            if not text:
                return
            if self._cell is not None or self._li is not None:
                return                           # td/li 内文本已实时累计（p 为透明容器）
            elif tag == "p":
                self.blocks.append(("p", text, bool(strong_text) and strong_text == text))
            else:
                self.blocks.append((tag, text))
        elif tag == "strong":
            self._in_strong = max(0, self._in_strong - 1)
        elif tag == "li":
            if self._li is not None and "".join(self._li).strip():
                self._pending_lis.append("".join(self._li).strip())
            self._li = None
        elif tag in ("td", "th"):
            if self._cell is not None:
                self._row.append("".join(self._cell).strip())
            self._cell = None
        elif tag == "tr":
            if self._row:
                self._rows.append(self._row)
            self._row = None
        elif tag == "table":
            if self._rows is not None:
                self.blocks.append(("table", self._rows))
            self._rows = None
        elif tag in ("ul", "ol"):
            if self._pending_lis:
                self.blocks.append(("ul", self._pending_lis))
            self._pending_lis = []

    def handle_data(self, data):
        self._buf.append(data)
        if self._in_strong:
            self._strong_buf.append(data)
        self._emit(data)                      # li/cell 容器内文本同步累计


def parse_blocks(html: str) -> list:
    bp = BlockParser()
    bp.feed(html)
    bp.close()
    return bp.blocks


# ================= 字段清洗（纯函数，确定性） =================
def norm_amount(raw: str) -> tuple:
    """'(总投资)34.7亿元'→('34.7亿','34.7亿元')；'未提及/自筹/?'→('','')。元级保留不换算。"""
    if not raw:
        return "", ""
    m = AMOUNT_PAT.search(raw)
    if not m:
        return "", ""
    amount_raw = re.sub(r"\s+", "", m.group(0))
    if amount_raw.endswith("亿元") or amount_raw.endswith("万元"):
        amount = amount_raw[:-1]                # 12.5亿元→12.5亿
    else:
        amount = amount_raw                     # 793300元 原样（不换算防算错）
    return amount, amount_raw


def amount_from_desc(text: str) -> tuple:
    """amount 列缺失时从主要内容/条目描述文本抽金额（关键词窗口限定，防抓无关数字）"""
    if not text:
        return "", ""
    m = AMOUNT_HINT_PAT.search(text)
    return norm_amount(m.group(1)) if m else ("", "")


def clean_owner(raw: str) -> str:
    if not raw:
        return ""
    s = re.split(r"[;；]", raw.strip())[0].strip()     # 剥「；公开招标」尾
    return "" if s in INVALID_GENERIC else s


def clean_window(raw: str) -> str:
    if not raw:
        return ""
    s = re.sub(r"\s+", "", raw.strip())
    return "" if s in INVALID_GENERIC else raw.strip()


def clean_stage(raw: str) -> str:
    if not raw:
        return "-"
    s = re.sub(r"\s+", "", raw)
    return "-" if s in INVALID_GENERIC else raw.strip()


def clean_title(raw: str) -> str:
    """剥头 [T2]/[类别] 短标签与尾 [★★] 星级；保留名内合法括号内容"""
    t = re.sub(r"\s+", " ", raw or "").strip()
    while True:
        m = re.match(r"^(\[[^\[\]]{1,14}\])\s*(.+)$", t)
        if not m:
            break
        t = m.group(2)
    t = re.sub(r"\s*\[[★☆✦＋+]{1,6}\]\s*$", "", t)
    t = re.sub(r"\s*[★☆]{1,6}$", "", t)
    return t.strip(" ：:;；,，")


def title_key(t: str) -> str:
    return re.sub(r"[\s\u3000]+", "", t or "").rstrip("\u2026.")   # \u5265\u5c3e\u622a\u65ad\u7b26\uff0c\u7a84\u5217\u622a\u65ad\u7248\u53ef\u524d\u7f00\u5bf9\u9f50


def is_dup_key(k1: str, k2: str) -> bool:
    """同 key，或互为前缀且短者 ≥12 字（附录窄列截断版对齐，防误合短名）"""
    if not k1 or not k2:
        return False
    if k1 == k2:
        return True
    return (k1.startswith(k2) or k2.startswith(k1)) and min(len(k1), len(k2)) >= 12


def make_summary(title: str, owner: str, amount_raw: str, stage: str) -> str:
    """≤40 字原文关键词拼装（项目+业主+金额+阶段），超长截断，禁止改写"""
    segs = []
    if owner:
        segs.append(f"业主{owner}")
    if amount_raw:
        segs.append(f"投资{amount_raw}")
    if stage and stage != "-":
        segs.append(f"阶段{stage}")
    s = f"{title}（{'，'.join(segs)}）" if segs else title
    return s[:40]


# ================= 抽取器（确定性状态机） =================
def _parse_kv_list(li_texts: list) -> dict:
    out = {}
    for li in li_texts:
        m = LI_KV_PAT.match(re.sub(r"\s+", "", li))
        if m:
            out[m.group(1)] = m.group(2).strip()
    return out


def _parse_pipe_fields(text: str) -> dict:
    segs = [seg.strip() for seg in text.split("|")]
    if len(segs) < 2:
        return {}
    out = {}
    for seg in segs:
        m = re.match(r"^(类型|阶段|投资|合作方式|合作|需求方|采购方|来源|期限|采购方式|截止)[:：]\s*(.*)$",
                     re.sub(r"\s+", "", seg))
        if m:
            out.setdefault(m.group(1), m.group(2))
    return out


def _map_columns(header: list) -> dict | None:
    """表头→逻辑列号；无 title 类列=非商机表（None，跳过计数）"""
    norm = [re.sub(r"[\s\u3000]+", "", h) for h in header]
    cols = {}
    for logical, names in COLMAP:
        col = next((i for i, h in enumerate(norm) if h in names), None)
        if col is None:
            for i, h in enumerate(norm):
                if any(n in h and abs(len(h) - len(n)) <= 4 for n in names):
                    col = i
                    break
        if col is not None:
            cols[logical] = col
    return cols if "title" in cols else None


def _card_from_row(row: list, cols: dict, width: int) -> dict:
    def cell(logical):
        i = cols.get(logical)
        return row[i] if i is not None and i < len(row) else ""

    amount, amount_raw = norm_amount(cell("amount"))
    if not amount_raw:
        amount, amount_raw = amount_from_desc(cell("desc"))
    title = clean_title(cell("title"))
    return {"title": title, "amount": amount, "amount_raw": amount_raw,
            "owner": clean_owner(cell("owner")), "stage": clean_stage(cell("stage")),
            "window": clean_window(cell("window"))}


def _card_from_ul(kv: dict, owner_ctx: str) -> dict:
    amount, amount_raw = norm_amount(kv.get("投资", ""))
    owner = clean_owner(kv.get("采购方", "") or kv.get("需求方", ""))
    return {"title": "", "amount": amount, "amount_raw": amount_raw,
            "owner": owner or clean_owner(owner_ctx),
            "stage": clean_stage(kv.get("阶段", "")), "window": clean_window(kv.get("期限", ""))}


def _card_from_pipe(kv: dict) -> dict:
    amount, amount_raw = norm_amount(kv.get("投资", ""))
    return {"title": "", "amount": amount, "amount_raw": amount_raw,
            "owner": clean_owner(kv.get("需求方", "") or kv.get("采购方", "")),
            "stage": clean_stage(kv.get("阶段", "")), "window": clean_window(kv.get("期限", ""))}


_CORE_FIELDS = ("阶段", "期限", "投资", "采购方", "需求方")


def extract_cards(chapters: list, province: str) -> tuple:
    """母本 [{title,html,id}] → (cards, stats)。cards 未编号（build 时按首现序冻结编号）。"""
    cards: list = []
    stats = {"chapters": len(chapters), "skipped_tables_no_title": 0,
             "skipped_heads_no_fields": 0, "truncated_tables": 0, "truncated_rows": 0}

    def push(card: dict, ch_id: str) -> None:
        if not card["title"]:
            return
        key = title_key(card["title"])
        if not key:
            return
        for existing in cards:                     # 同报告去重：同key/前缀key，首现占位后补空字段
            if is_dup_key(title_key(existing["title"]), key):
                if len(key) > len(title_key(existing["title"])):
                    existing["title"] = card["title"]   # 保更长（非截断）标题
                for f in ("amount", "amount_raw", "owner", "stage", "window"):
                    if existing[f] in ("", "-") and card[f] not in ("", "-"):
                        existing[f] = card[f]      # '-'/空=未填，允许后见补全
                return
        cards.append({**card, "province": province, "source_chapter": ch_id})

    for ch in chapters:
        ch_id = ch.get("id", "")
        blocks = parse_blocks(ch.get("html", "") or "")
        owner_ctx = ""
        for i, blk in enumerate(blocks):
            kind = blk[0]
            if kind == "table":
                rows = blk[1]
                if not rows:
                    continue
                cols = _map_columns(rows[0])
                if cols is None:
                    stats["skipped_tables_no_title"] += 1
                    continue
                data = rows[1:]
                if len(data) > BIG_TABLE_ROWS:     # 全量索引巨表：保 Top N（评分降序同附录A）
                    stats["truncated_tables"] += 1
                    stats["truncated_rows"] += len(data) - BIG_TABLE_KEEP
                    data = data[:BIG_TABLE_KEEP]
                width = max(len(r) for r in rows)
                for row in data:
                    push(_card_from_row(row, cols, width), ch_id)
            elif kind == "h2":
                m = H2_OWNER_PAT.match(blk[1].strip())
                if m:
                    owner_ctx = m.group(1)
            elif kind == "p" and blk[2]:           # strong 整段=候选条目头
                m = HEAD_PAT.match(blk[1])
                if not m:
                    continue
                nxt = blocks[i + 1] if i + 1 < len(blocks) else None
                card = None
                if nxt and nxt[0] == "ul":         # 形态 A
                    kv = _parse_kv_list(nxt[1])
                    if sum(1 for k in _CORE_FIELDS if k in kv) >= 2:
                        card = _card_from_ul(kv, owner_ctx)
                elif nxt and nxt[0] == "p" and not nxt[2] and PIPE_KV_PAT.search(nxt[1]):
                    kv = _parse_pipe_fields(nxt[1])  # 形态 C
                    if sum(1 for k in _CORE_FIELDS if k in kv) >= 2:
                        card = _card_from_pipe(kv)
                if card is None:
                    stats["skipped_heads_no_fields"] += 1
                    continue
                card["title"] = clean_title(m.group(2))
                if not card["amount_raw"]:          # 描述段（条目头后第 2 块）金额兜底
                    nxt2 = blocks[i + 2] if i + 2 < len(blocks) else None
                    if nxt2 and nxt2[0] == "p" and not nxt2[2]:
                        amt, raw = amount_from_desc(nxt2[1])
                        if raw:
                            card["amount"], card["amount_raw"] = amt, raw
                push(card, ch_id)
    return cards, stats


def finalize_cards(cards: list, report_id: str) -> list:
    """契约排序冻结：首现序 + id 编号 + summary 拼装"""
    out = []
    for i, c in enumerate(cards, 1):
        out.append({"id": f"{report_id}-c{i:03d}", "title": c["title"],
                    "amount": c["amount"], "amount_raw": c["amount_raw"],
                    "owner": c["owner"], "stage": c["stage"], "window": c["window"],
                    "province": c["province"], "source_chapter": c["source_chapter"],
                    "summary": make_summary(c["title"], c["owner"], c["amount_raw"], c["stage"])})
    return out


# ================= 落盘 / 幂等 / 一致性硬闸 =================
def _load_mother(slug: str) -> list | None:
    p = XY_CONTENT / "reports" / slug / "chapters_full.json"
    if not p.exists():
        return None
    return json.loads(p.read_text(encoding="utf-8"))


def _province_from_catalog(slug: str) -> str:
    try:
        catalog = json.loads((PROJECT_CONTENT / "catalog.json").read_text(encoding="utf-8"))
        return next((r.get("province", "") for r in catalog["reports"] if r["id"] == slug), "")
    except Exception:
        return ""


def build_one(slug: str, chapters: list | None = None, province: str = "",
              *, force: bool = False) -> dict:
    """抽取+落盘。幂等：已存在且非 force→skipped；母本与包内 chapters.json id 序漂移→拒绝。"""
    dst = CARDS_DIR / f"{slug}.json"
    if dst.exists() and not force:
        return {"slug": slug, "status": "skipped-existing",
                "cards": len(json.loads(dst.read_text(encoding="utf-8"))["cards"])}
    if chapters is None:
        chapters = _load_mother(slug)
        if chapters is None:
            return {"slug": slug, "status": "no-mother"}
    packed = PROJECT_CONTENT / "reports" / slug / "chapters.json"   # 一致性硬闸（同源旁证）
    if packed.exists():
        try:
            ids_pkg = [c["id"] for c in json.loads(packed.read_text(encoding="utf-8"))]
            ids_mom = [c.get("id") for c in chapters]
            if ids_pkg != ids_mom:
                return {"slug": slug, "status": "mismatch",
                        "error": "母本 chapters_full 与包内 chapters.json 章序不一致，拒绝落盘"}
        except Exception as exc:
            return {"slug": slug, "status": "mismatch", "error": f"包内 chapters.json 不可读: {exc}"}
    if not province:
        province = _province_from_catalog(slug)
    cards, stats = extract_cards(chapters, province)
    payload = {"report_id": slug, "generated_at": datetime.now().isoformat(timespec="seconds"),
               "source": SOURCE_TAG, "cards": finalize_cards(cards, slug)}
    dst.parent.mkdir(parents=True, exist_ok=True)
    dst.write_text(json.dumps(payload, ensure_ascii=False, indent=1), encoding="utf-8")
    return {"slug": slug, "status": "built", "cards": len(payload["cards"]),
            "truncated": stats["truncated_rows"], "skipped_tables": stats["skipped_tables_no_title"],
            "skipped_heads": stats["skipped_heads_no_fields"]}


def verify() -> int:
    """清点：cards 全在（对母本 reports 目录）、每份 ≥1 卡、字段非空率报表"""
    slugs = sorted(d.name for d in (XY_CONTENT / "reports").iterdir() if d.is_dir())
    fails, rows = [], []
    all_cards = 0
    for slug in slugs:
        p = CARDS_DIR / f"{slug}.json"
        if not p.exists():
            fails.append(f"{slug}: 缺 cards 文件")
            rows.append((slug, 0, "", "", "", ""))
            continue
        try:
            data = json.loads(p.read_text(encoding="utf-8"))
        except Exception as exc:
            fails.append(f"{slug}: JSON 不可读 {exc}")
            continue
        for key in ("report_id", "generated_at", "source", "cards"):
            if key not in data:
                fails.append(f"{slug}: 契约缺顶层键 {key}")
        cards = data.get("cards", [])
        all_cards += len(cards)
        if not cards:
            fails.append(f"{slug}: 0 卡")
            rows.append((slug, 0, "", "", "", ""))
            continue
        ids = [c["id"] for c in cards]
        if len(set(ids)) != len(ids):
            fails.append(f"{slug}: 卡 id 重复")
        need = ("id", "title", "amount", "amount_raw", "owner", "stage",
                "window", "province", "source_chapter", "summary")
        nz = {f: sum(1 for c in cards if c.get(f)) for f in need}
        if nz["title"] != len(cards) or nz["province"] != len(cards) or nz["id"] != len(cards):
            fails.append(f"{slug}: title/province/id 存在空值")
        if any(f not in c for c in cards for f in need):
            fails.append(f"{slug}: 卡缺契约字段")
        n = len(cards)
        rows.append((slug, n, f"{nz['title'] and 100}%",                   # title 100%（闸已保证）
                     f"owner {nz['owner'] * 100 // n}%", f"amount {nz['amount_raw'] * 100 // n}%",
                     f"stage≠- {sum(1 for c in cards if c['stage'] not in ('-', '')) * 100 // n}%"))
    print(f"[verify] 母本 {len(slugs)} 份 / cards 产出 {len(slugs) - sum(1 for r in rows if r[1] == 0)} 份 / 总卡数 {all_cards}")
    for slug, n, a, b, c, d in rows:
        print(f"  {slug:28s} cards={n:5d}  {a:6s} {b:12s} {c:16s} {d}")
    for f in fails:
        print("  FAIL:", f)
    print("[verify]", "PASS" if not fails else f"FAIL×{len(fails)}")
    return 1 if fails else 0


def main() -> None:
    ap = argparse.ArgumentParser(description="商机卡抽取（母本 chapters_full.json → cards/<slug>.json）")
    ap.add_argument("--only", default="", help="指定 slug（逗号分隔）")
    ap.add_argument("--force", action="store_true", help="忽略缓存重抽（generated_at 刷新）")
    ap.add_argument("--verify", action="store_true", help="清点+非空率报表")
    args = ap.parse_args()
    if args.verify:
        sys.exit(verify())
    slugs = [s for s in (args.only.split(",") if args.only else
                         sorted(d.name for d in (XY_CONTENT / "reports").iterdir() if d.is_dir())) if s]
    results = []
    for i, slug in enumerate(slugs, 1):
        r = build_one(slug, force=args.force)
        results.append(r)
        print(f"[{i}/{len(slugs)}] {slug}: {r['status']}"
              + (f" cards={r['cards']}" if r.get("cards") is not None else "")
              + (f" truncated={r['truncated']}" if r.get("truncated") else ""), flush=True)
    tally = {}
    for r in results:
        tally[r["status"]] = tally.get(r["status"], 0) + 1
    print(json.dumps(tally, ensure_ascii=False))
    bad = [r for r in results if r["status"] in ("failed", "mismatch", "no-mother")]
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    sys.stdout.reconfigure(encoding="utf-8")
    main()
