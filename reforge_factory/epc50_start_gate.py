# -*- coding: utf-8 -*-
"""EPC50 成稿启动双门 (用户裁决 0925 三连): 分池计量 + 极严口径 + 军团额度.

池结构 (0925 分池令):
  EPC50-SNEI      = 一手池 (门槛账: 微信/Manus/官网/深挖/CNKI/论文)
  EPC50-SNEI-AUX  = 辅助池 (分开计量: ima/飞书/v2问答/秘塔; 成稿可引用, 不混入一手)

判据 (用户裁决链):
  门1 弹药门槛 = 一手+辅助 总有效字数 >= 1000万 (弹药门槛铁律: 只算新增+判有效)
  门2 PRIMARY  = 极严口径 一手/(一手+辅助) > 50%
  门3 军团额度 = 今日派发打满 (待派0)

注意: pool_state.note — manifest 行=文件×问题对(qmatch), 行累加=虚账;
     state 才是 source_path 去重真账.
用法: python epc50_start_gate.py
"""
import io
import json
import sys
import time
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")

POOL_ROOT = Path(r"E:\AI-Station\ammo_pool")
CID_PRIMARY = "EPC50-SNEI"
CID_AUX = "EPC50-SNEI-AUX"
CORPS_LOG = Path(r"E:\AI-Station\Auto_Manus\data\epc50_corps_log.jsonl")
ACCOUNTS = Path(r"E:\AI-Station\Auto_Manus\Manus账号（全部）260922_干净版.txt")
LOW_FILE = Path(r"E:\AI-Station\Auto_Manus\data\epc50_credits_low.json")

GATE_CHARS = 10_000_000
GATE_PRIMARY = 0.50


def corps_today() -> tuple[int, int]:
    """返回 (今日已派单数, 当日可派账号数). 账本单源=corps_log append-only."""
    today = time.strftime("%Y-%m-%d")
    dispatched = 0
    if CORPS_LOG.is_file():
        for line in CORPS_LOG.read_text(encoding="utf-8",
                                        errors="replace").splitlines():
            try:
                d = json.loads(line)
            except Exception:
                continue
            # 0925 修: corps 正常行无 event 字段 (schema=ts/email/sid/...)
            # — 旧判据 event==dispatch 恒不中 → 门3 永远 disp=0 假未满.
            # 真判据 = 今日行且带 sid.
            if (d.get("ts", "").startswith(today) and d.get("sid")):
                dispatched += 1
    total = 0
    if ACCOUNTS.is_file():
        for line in ACCOUNTS.read_text(encoding="utf-8",
                                       errors="replace").splitlines():
            s = line.strip()
            if s and not s.startswith("#") and "|" in s and "@" in s.split("|")[0]:
                total += 1
    low = 0
    if LOW_FILE.is_file():
        try:
            d = json.loads(LOW_FILE.read_text(encoding="utf-8"))
            if d.get("day") == today:
                low = len(d.get("low", {}))
        except Exception:
            pass
    return dispatched, max(total - low, 0)


def read_pool(cid: str) -> dict:
    p = POOL_ROOT / cid / "pool_state.json"
    if not p.is_file():
        return {"total_chars": 0, "items": 0, "by_engine": {}}
    return json.loads(p.read_text(encoding="utf-8"))


def main() -> int:
    global CID_PRIMARY, CID_AUX
    if "--battle" in sys.argv and "epc49" in sys.argv:
        CID_PRIMARY = "EPC49-SEPDC"
        CID_AUX = "EPC49-SEPDC-AUX"
    prim = read_pool(CID_PRIMARY)
    aux = read_pool(CID_AUX)
    p_chars = prim.get("total_chars", 0)
    a_chars = aux.get("total_chars", 0)
    tot = p_chars + a_chars

    disp, avail = corps_today()
    quota_full = disp >= avail and avail > 0

    print(f"═══ {CID_PRIMARY} 成稿启动双门 (分池计量) {time.strftime('%m-%d %H:%M')} ═══")
    print(f"一手池:  {p_chars:>10,} 字 / {prim.get('items', 0):,} 文件 "
          f"(门槛账源, 极严PRIMARY)")
    print(f"辅助池:  {a_chars:>10,} 字 / {aux.get('items', 0):,} 文件 "
          f"(分开计量, 成稿可引用, 不进占比)")
    print(f"门1 弹药门槛(总量): {tot:>10,} / {GATE_CHARS:,} 字 "
          f"({'✓ PASS' if tot >= GATE_CHARS else f'{tot/GATE_CHARS*100:.1f}% 进行中'})")
    ratio = p_chars / tot if tot else 0
    print(f"门2 PRIMARY(极严):   {ratio*100:5.1f}% "
          f"({'✓' if ratio > GATE_PRIMARY else '✗'} >50% = 一手/(一手+辅助))")
    print(f"门3 军团额度:        今日已派 {disp} / 可派 {avail} "
          f"({'✓ 打满' if quota_full else '✗ 未满 (守护自动跑)'})")
    # 缺口推演: 新增全一手 x → 门1 tot+x≥1000万 ∧ 门2 (p+x)/(tot+x)>50%
    need1 = max(GATE_CHARS - tot, 0)
    need2 = max(int(tot - 2 * p_chars) + 1, 0) if 2 * p_chars <= tot else 0
    both = max(need1, need2)
    print(f"缺口推演: 门1 还差 {need1:,} | 门2 (新增全一手) 至少 {need2:,} "
          f"→ 双门同破需 {both:,} 字一手网采")
    ok = tot >= GATE_CHARS and ratio > GATE_PRIMARY and quota_full
    print(f"═══ 判定: {'🟢 三门全过, 可请示启动成稿' if ok else '🔴 未全过, 继续弹药生产'} ═══")
    return 0 if ok else 2


if __name__ == "__main__":
    sys.exit(main())
