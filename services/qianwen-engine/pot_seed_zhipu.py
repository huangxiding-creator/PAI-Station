# -*- coding: utf-8 -*-
"""锅圈播种机 v2（智谱免费链）：EPC 热点问题 → 总包专家长文 → 公共锅圈条目。

用法（ECS 生产位）：
  PYTHONPATH=/opt/qianwen venv/bin/python pot_seed_zhipu.py questions.json [limit]

- 与 pot_seed.py（KB 链）并存：本题库不烧 KB 积分（免费模型优先铁律）
- 幂等：已入锅的同题自动跳过 → 断点续跑直接重跑
- 护栏：每问让路 pending（用户问题优先）+ 质量门（长度/套话/结构）+ 失败重试一次
"""
from __future__ import annotations

import json
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from qianwen_engine import store, zhipu  # noqa: E402

GAP_SEC = 3          # zhipu 模块内已有 1.5s 全局节流，这里再垫一点
MIN_CHARS = 350      # 质量门：正文过短=生成异常，弃用重试
MAX_RETRY = 1

SYSTEM = """你是「总包AI顾问」背后的资深工程总承包专家：20年EPC项目管理与商务合约经验，处理过大量计价调价、变更索赔、结算审计、招投标合规与新能源EPC争议。

回答要求（严格遵守）：
- 简体中文，600-900字
- 结构：先用一两句话给出「结论」；再用 ## 小标题分三到四节展开（如 依据与逻辑 / 操作要点 / 风险提示）
- 引用法规规范只用确定存在的名称（《民法典》、建工司法解释、《房屋建筑和市政基础设施项目工程总承包管理办法》等），不编造条文号，不写「第X条第X款」
- 口吻：专业、接地气、可执行，像资深总包商务经理给同事支招；直接以内容开头
- 不写「作为AI」「根据我的了解」等套话
- markdown 格式（## 小标题、有序列表、关键结论加粗）"""


def _qualify(ans: str) -> bool:
    if len(ans) < MIN_CHARS:
        return False
    if "作为AI" in ans or "作为一个AI" in ans:
        return False
    has_structure = ("##" in ans) or ("\n1." in ans) or ("\n- " in ans)
    return has_structure


def main() -> int:
    if len(sys.argv) < 2:
        print("usage: pot_seed_zhipu.py questions.json [limit]")
        return 2
    qfile = Path(sys.argv[1])
    limit = int(sys.argv[2]) if len(sys.argv) > 2 else 10 ** 9
    items = json.loads(qfile.read_text(encoding="utf-8"))
    print(f"[seed-zh] {len(items)} questions, limit={limit}, gap={GAP_SEC}s")

    seeded = skipped = failed = 0
    for i, it in enumerate(items):
        if seeded >= limit:
            print(f"[seed-zh] limit hit ({limit})")
            break
        q = (it.get("q") or "").strip()
        if not q:
            continue
        if store.pot_exists(q):
            skipped += 1
            continue
        # 用户问题优先：引擎在跑真问题 → 让路（DB pending 串行化）
        waited = 0
        while store.any_pending() and waited < 240:
            time.sleep(5)
            waited += 5
        ans = ""
        for attempt in range(1 + MAX_RETRY):
            try:
                t0 = time.time()
                raw = zhipu.deep_answer(SYSTEM, q)
                if _qualify(raw):
                    ans = raw
                    elapsed = round(time.time() - t0, 1)
                    break
                print(f"[seed-zh] #{i + 1} quality-gate miss "
                      f"(len={len(raw)}), retry {attempt + 1}")
            except Exception as exc:  # noqa: BLE001
                print(f"[seed-zh] #{i + 1} attempt{attempt + 1} FAIL: {exc}")
                time.sleep(10)
        if not ans:
            failed += 1
            continue
        sort = int(it.get("sort", i))
        aid = store.save_pot_answer(q, ans, [], sort=sort, elapsed=elapsed, via="pot_zhipu")
        seeded += 1
        print(f"[seed-zh] #{i + 1} OK {aid} {len(ans)}字 {elapsed}s: {q[:28]}…")
        time.sleep(GAP_SEC)
    print(f"[seed-zh] done seeded={seeded} skipped={skipped} failed={failed}")
    return 0 if seeded > 0 else 1


if __name__ == "__main__":
    raise SystemExit(main())
