# -*- coding: utf-8 -*-
"""校准预测抽取 (T-013B / REQ-042, KB-CALIBRATION-LEDGER-SPEC).

成稿概率化判断句 → 可验证预测 → 追加式校准账本:

    reforge_factory/calibration_ledger.jsonl

抽取 (extract): 三形概率模式 × 将来时线索 (将/预计/有望/可能) 联合命中,
句内上下文窗口截断 (120 字) 为判断文本; 文内「验证口径：」行与「截止<日期>」
就近捕获 (同行起, 向下至空行为止的段块内).

落账 (record): 逐条校验 (prob 须为 1-99 整数 / 验证口径=用户输入或文内行 /
截止时间=文内日期或默认 ts+6 个月), 追加 {id:C-0001,ts,campaign,prediction,
prob,verify_basis,due,outcome:null,brier:null}. 校验先行、追加在后 —— 批内
一条非法整批拒, 账本零残留. require_min 实现 REQ-042 的 ≥5 条门 (不足即拒,
CLI 层 exit 2).

Brier 对账腿在 brier_score.py (settle/report/--synthetic).

用法:
    py reforge_factory/calibration_extract.py --draft 成稿.md \
        --campaign EPC-BID26 [--verify-basis 兜底口径] [--ledger 路径]

退出码: 0=入账成功, 1=参数/校验错, 2=不足 5 条 (REQ-042 门, 不入账).
纯标准库. 测试一律走 tmp 夹具, 绝不写真实账本; 真战役成稿抽取属运营动作.
"""
from __future__ import annotations

import json
import re
import sys
from datetime import date, datetime
from pathlib import Path

#: 将来时动词线索 (无线索的百分数不是预测, 是陈述)
FUTURE_CUES: tuple[str, ...] = ("将", "预计", "有望", "可能")

#: 三形概率模式 (T-013B 指定形态; \d{1,3} 允许抽到 0/100, 由 record 拒之)
PROB_PATTERNS: tuple[re.Pattern, ...] = (
    re.compile(r"概率约?\s*(\d{1,3})\s*%"),                    # 形一 概率约70%
    re.compile(r"(\d{1,3})\s*%\s*的概率"),                     # 形二 70%的概率
    re.compile(r"概率(?:高达|达到|约为)\s*(\d{1,3})\s*%"),     # 形三 概率高达90%
)

#: 句界 (段内再按中英文句读切句)
_SENT_SPLIT = re.compile(r"[。！？；!?;]+")
#: 判断文本上下文窗口 (字符)
MAX_CONTEXT = 120
#: 文内验证口径行/内联
_BASIS_RE = re.compile(r"验证口径[：:]\s*([^。；;\n]+)")
#: 文内截止时间: 截止2027年6月30日 / 截止 2027-06-30 / 截止2027/6/30
_DUE_RE = re.compile(
    r"截止\s*(\d{4})\s*[-/年.]\s*(\d{1,2})\s*[-/月.]\s*(\d{1,2})\s*日?")

#: 真实账本 (测试传 ledger=tmp 夹具覆盖)
DEFAULT_LEDGER = Path(__file__).resolve().parent / "calibration_ledger.jsonl"

#: 九字段 schema (KB-CALIBRATION-LEDGER-SPEC 键序)
SCHEMA_FIELDS = ("id", "ts", "campaign", "prediction", "prob",
                 "verify_basis", "due", "outcome", "brier")

_ID_RE = re.compile(r"^C-(\d{4,})$")
#: REQ-042 门: 成稿抽取入账下限
MIN_PREDICTIONS = 5


def _now_ts() -> str:
    return datetime.now().isoformat(timespec="seconds")


def add_months(d: date, months: int = 6) -> str:
    """日期 + N 月 (日溢出向月末日钳制), 返回 YYYY-MM-DD."""
    total = d.year * 12 + (d.month - 1) + months
    y, m0 = divmod(total, 12)
    day = d.day
    while True:
        try:
            return date(y, m0 + 1, day).isoformat()
        except ValueError:
            day -= 1


def _next_seq(path: Path) -> int:
    """扫现有账本取最大 C-#### 序号 +1 (id 自增, 起始 1)."""
    n = 0
    if not path.exists():
        return 1
    with open(path, "r", encoding="utf-8") as fh:
        for line in fh:
            line = line.strip()
            if not line:
                continue
            try:
                rec = json.loads(line)
            except ValueError:
                continue                       # 脏行不阻塞自增, load_rows 会拦
            m = _ID_RE.match(str(rec.get("id") or ""))
            if m:
                n = max(n, int(m.group(1)))
    return n + 1


def load_rows(ledger=None) -> list[dict]:
    """读全账本 (严格模式: 脏行 ValueError —— 账本损坏要响亮)."""
    path = Path(ledger) if ledger is not None else DEFAULT_LEDGER
    if not path.exists():
        return []
    rows = []
    with open(path, "r", encoding="utf-8") as fh:
        for lineno, line in enumerate(fh, 1):
            line = line.strip()
            if not line:
                continue
            try:
                rows.append(json.loads(line))
            except ValueError as exc:
                raise ValueError(f"{path}:{lineno} 脏行无法解析: {exc}") from exc
    return rows


def _context_window(sent: str, pos: int, max_len: int = MAX_CONTEXT) -> str:
    """判断文本 = 命中句截窗口 (超长居中裁 max_len 字, 两侧加省略号)."""
    if len(sent) <= max_len:
        return sent.strip()
    start = max(0, pos - max_len // 2)
    end = min(len(sent), start + max_len)
    start = max(0, end - max_len)
    out = sent[start:end].strip()
    if start > 0:
        out = "…" + out
    if end < len(sent):
        out += "…"
    return out


def _block_lines(lines: list[str], idx: int) -> list[str]:
    """同行起向下至空行的段块 (验证口径/截止日期就近捕获范围)."""
    block = []
    for line in lines[idx:]:
        if not line.strip():
            break
        block.append(line)
    return block


def _scan_block(block: list[str], pattern: re.Pattern):
    """段块内首个命中 (先行→先列)."""
    for line in block:
        m = pattern.search(line)
        if m:
            return m
    return None


def extract(draft_md: str) -> list[dict]:
    """成稿文本 → 预测列表 [{prediction,prob,verify_basis,due}, ...].

    - 命中 = 概率三形之一 ∩ 句含将来时线索 (将/预计/有望/可能);
    - prediction = 命中句上下文窗口截断文本; 同句同概率去重;
    - verify_basis = 段块内首个「验证口径：」捕获, 无则 None (record 兜底);
    - due = 段块内首个「截止<日期>」归一 YYYY-MM-DD, 无则 None (默认+6月).
    """
    lines = draft_md.splitlines()
    out: list[dict] = []
    seen: set[tuple[str, int]] = set()
    for idx, line in enumerate(lines):
        for sent in _SENT_SPLIT.split(line):
            if not sent.strip() or not any(c in sent for c in FUTURE_CUES):
                continue
            for pat in PROB_PATTERNS:
                for m in pat.finditer(sent):
                    text = _context_window(sent, m.start())
                    prob = int(m.group(1))
                    if (text, prob) in seen:
                        continue
                    seen.add((text, prob))
                    block = _block_lines(lines, idx)
                    bm = _scan_block(block, _BASIS_RE)
                    dm = _scan_block(block, _DUE_RE)
                    due = None
                    if dm:
                        due = _norm_date(dm.group(1), dm.group(2), dm.group(3))
                    out.append({
                        "prediction": text,
                        "prob": prob,
                        "verify_basis": bm.group(1).strip() if bm else None,
                        "due": due,
                    })
    return out


def _norm_date(y: str, m: str, d: str):
    """年月日文本 → YYYY-MM-DD; 非法日期 (如 2 月 30 日) 返回 None."""
    try:
        return date(int(y), int(m), int(d)).isoformat()
    except ValueError:
        return None


def record(predictions, campaign, verify_basis=None, due=None,
           ledger=None, require_min=None) -> list[dict]:
    """校验并追加预测入账本, 返回落盘 record 列表.

    - 校验先行、追加在后: 批内一条非法整批拒, 账本零残留;
    - prob 须为 1-99 int (0/100/浮点/字符串/bool 全拒);
    - verify_basis = 行内捕获 → 参数 (用户输入) → 缺失即拒;
    - due = 行内日期 → 参数 → 默认 ts+6 个月 (add_months);
    - require_min: REQ-042 门, 预测数不足即拒 (零写入);
    - id 自增 C-0001 起 (全账本唯一), 追加式只增不删.
    """
    if not isinstance(campaign, str) or not campaign.strip():
        raise ValueError(f"非法战役名: {campaign!r}")
    rows_in = []
    for p in predictions:
        if not isinstance(p, dict):
            raise ValueError(f"预测须为 dict: {p!r}")
        pred = str(p.get("prediction") or "").strip()
        if not pred:
            raise ValueError("prediction 须为非空判断文本")
        prob = p.get("prob")
        if isinstance(prob, bool) or not isinstance(prob, int):
            raise ValueError(f"prob 须为 int: {prob!r}")
        if not 1 <= prob <= 99:
            raise ValueError(f"prob={prob} 越界, 须 1-99 (0/100 非校准预测)")
        vb = str(p.get("verify_basis") or verify_basis or "").strip()
        if not vb:
            raise ValueError("验证口径缺失 (用户输入或文内「验证口径：」行)")
        due_v = str(p.get("due") or due or "").strip() or None
        rows_in.append({"prediction": pred, "prob": prob,
                        "verify_basis": vb, "due": due_v})
    if require_min is not None and len(rows_in) < require_min:
        raise ValueError(
            f"不足 {require_min} 条可验证预测 (REQ-042 门), 实得 {len(rows_in)}")

    path = Path(ledger) if ledger is not None else DEFAULT_LEDGER
    seq = _next_seq(path)
    written = []
    for r in rows_in:
        record_out = {
            "id": f"C-{seq:04d}",
            "ts": _now_ts(),
            "campaign": campaign,
            "prediction": r["prediction"],
            "prob": r["prob"],
            "verify_basis": r["verify_basis"],
            "due": r["due"] or add_months(date.today(), 6),
            "outcome": None,
            "brier": None,
        }
        written.append(record_out)
        seq += 1
    path.parent.mkdir(parents=True, exist_ok=True)
    with open(path, "a", encoding="utf-8") as fh:
        for rec in written:
            fh.write(json.dumps(rec, ensure_ascii=False,
                                separators=(",", ":")) + "\n")
    return written


def main(argv=None) -> int:
    """CLI: 成稿抽取入账. rc: 0=成功 1=校验/IO 错 2=不足 5 条 (REQ-042 门)."""
    import argparse

    ap = argparse.ArgumentParser(
        description="校准预测抽取入账 (REQ-042): 三形概率句 → calibration_ledger")
    ap.add_argument("--draft", required=True, help="成稿 markdown 路径")
    ap.add_argument("--campaign", required=True, help="战役 id (如 EPC-BID26)")
    ap.add_argument("--verify-basis", default=None,
                    help="兜底验证口径 (文内「验证口径：」缺落时生效)")
    ap.add_argument("--due", default=None,
                    help="兜底截止日期 YYYY-MM-DD (文内「截止」缺落时生效)")
    ap.add_argument("--ledger", default=None, help="账本路径 (缺省 reforge_factory/)")
    ap.add_argument("--min", type=int, default=MIN_PREDICTIONS,
                    help=f"入账下限 (缺省 {MIN_PREDICTIONS}, REQ-042 门)")
    args = ap.parse_args(argv)

    try:
        text = Path(args.draft).read_text(encoding="utf-8")
    except OSError as exc:
        print(f"[calibration_extract] ERROR 读草稿失败: {exc}", file=sys.stderr)
        return 1
    preds = extract(text)
    if len(preds) < args.min:
        print(f"[calibration_extract] 不足 {args.min} 条可验证预测 "
              f"(实得 {len(preds)}), REQ-042 门未过, 不入账", file=sys.stderr)
        return 2
    try:
        written = record(preds, args.campaign, verify_basis=args.verify_basis,
                         due=args.due, ledger=args.ledger)
    except ValueError as exc:
        print(f"[calibration_extract] ERROR {exc}", file=sys.stderr)
        return 1
    print(f"campaign={args.campaign} extracted={len(preds)} "
          f"recorded={len(written)} "
          f"ids={written[0]['id']}..{written[-1]['id']}")
    for rec in written:
        print(f"  {rec['id']} prob={rec['prob']}% due={rec['due']} "
              f"basis={rec['verify_basis'][:40]}")
    return 0


if __name__ == "__main__":
    try:
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    except Exception:                                   # 非 Windows/无 tty 不致命
        pass
    sys.exit(main())
