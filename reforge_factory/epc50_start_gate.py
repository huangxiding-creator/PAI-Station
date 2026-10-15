# -*- coding: utf-8 -*-
"""EPC50 成稿启动双门 (用户裁决 0925 三连): 分池计量 + 极严口径 + 军团额度.

池结构 (0925 分池令):
  EPC50-SNEI      = 一手池 (门槛账: 微信/Manus/官网/深挖/CNKI/论文)
  EPC50-SNEI-AUX  = 辅助池 (分开计量: ima/飞书/v2问答/秘塔; 成稿可引用, 不混入一手)

判据 (用户裁决链; T-002R 起门参数决策时现读 gates.json 权威源):
  门1 弹药门槛 = 分层门主判 (v3 口径: T1 报告直接 ≥ gates.t1_min_chars,
                 T12 总门关; legacy_t12_gate=True 回 1005令旧口径:
                 T1 ≥ 三百万 ∧ T1+T2 ≥ 三千万, T3 封顶参考, T0 不计);
                 未配 tiers.json 回退旧总量门参考线 (gates.
                 legacy_total_budget_reference; legacy_total_gate=True 回
                 1004令旧口径 二亿)
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

GATE_PRIMARY = 0.50
# T-002R (REQ-010): 门参数不再本件硬编码, 决策时现读 gates.json 单一权威源
# (经 ammo_pool 决策函数 → gates_loader, 无缓存 — 改 json 即时生效).
# legacy v2 口径数字不作为生效常量, 由 flags 回开分支承载:
#   1004令(legacy): 旧总量门 二亿 (legacy_total_gate=True 回开)
#   1005令(legacy): T1 ≥ 三百万 ∧ T1+T2 ≥ 三千万 (legacy_t12_gate=True 回开)
from ammo_pool import (tier_report, gate_t1_min_chars, gate_t12_min_chars,
                       gate_total_chars)


def gate1b_thresholds() -> tuple[int, "int | None"]:
    """门1b 分层门阈值 (T1 门, T12 总门) — 决策时现读 gates.json 权威源.

    返回 (t1_min, t12_min): t12_min=None 即 T12 总门关 (REQ-011 v3 口径);
    flags.legacy_t12_gate=True 时双双回到 1005令 旧 v2 口径值."""
    return gate_t1_min_chars(), gate_t12_min_chars()


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
    total_ref = gate_total_chars()          # 门1 总量参考线 (决策时现读, T-002R)
    t1_min, t12_min = gate1b_thresholds()   # 门1b 分层门 (决策时现读, T-002R)
    print(f"门1 弹药门槛(总量参考线): {tot:>10,} / {total_ref:,} 字 "
          f"({'✓ PASS' if tot >= total_ref else f'{tot/total_ref*100:.1f}% 进行中'})")
    # 分层门 (主判, 门参数现读 gates.json): T1 ≥ t1_min ∧ T12 总门(可关), 只看一手池
    tr = tier_report(CID_PRIMARY)
    if tr["tiers_configured"]:
        t12 = tr["t1"] + tr["t2"]
        m1 = tr["t1"] >= t1_min
        m2 = True if t12_min is None else t12 >= t12_min
        if t12_min is None:                 # T12 总门关 (REQ-011 v3 口径)
            print(f"门1b 分层门(主判):   T1 报告直接 {tr['t1']:>10,} / {t1_min:,} "
                  f"{'✓' if m1 else '✗'} ∧ T1+T2 总门已关 (v3 口径) "
                  f"(T3封顶{tr['t3_capped']:,} 参考, T0 不计)")
        else:
            print(f"门1b 分层门(主判):   T1 报告直接 {tr['t1']:>10,} / {t1_min:,} "
                  f"{'✓' if m1 else '✗'} ∧ T1+T2 {t12:>10,} / {t12_min:,} "
                  f"{'✓' if m2 else '✗'} (T3封顶{tr['t3_capped']:,} 参考, T0 不计)")
        tier_ok = m1 and m2
    else:
        print(f"门1b 分层门(主判):   ⚠️ 未配 tiers.json, 回退旧总量门")
        tier_ok = tot >= total_ref
    ratio = p_chars / tot if tot else 0
    print(f"门2 PRIMARY(极严):   {ratio*100:5.1f}% "
          f"({'✓' if ratio > GATE_PRIMARY else '✗'} >50% = 一手/(一手+辅助))")
    print(f"门3 军团额度:        今日已派 {disp} / 可派 {avail} "
          f"({'✓ 打满' if quota_full else '✗ 未满 (守护自动跑)'})")
    # 缺口推演: 分层门=T1/T1+T2 双缺口 (定向补采, 泛词采量再大也不折算)
    if tr["tiers_configured"]:
        need_t1 = max(t1_min - tr["t1"], 0)
        need_t12 = 0 if t12_min is None else max(
            t12_min - (tr["t1"] + tr["t2"]), 0)
        print(f"缺口推演: T1 还差 {need_t1:,} | T1+T2 还差 {need_t12:,} "
              f"→ 定向补采研究对象本体/同业对标词系")
    need1 = max(total_ref - tot, 0)
    need2 = max(int(tot - 2 * p_chars) + 1, 0) if 2 * p_chars <= tot else 0
    print(f"          (旧总量门差 {need1:,} | 门2 一手占比至少 {need2:,})")
    ok = tier_ok and ratio > GATE_PRIMARY and quota_full
    print(f"═══ 判定: {'🟢 三门全过, 可请示启动成稿' if ok else '🔴 未全过, 继续弹药生产'} ═══")
    return 0 if ok else 2


if __name__ == "__main__":
    sys.exit(main())
