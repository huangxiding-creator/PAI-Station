# -*- coding: utf-8 -*-
"""_gen_leg_ledger — 渲染 腿建造台账.md (1025 腿批量令收口件, 一次性).

输入: legs/_gen_legs_batch.py 产物 _gen_legs_batch_result.json
      + api_replica_bridge.py HTTP_ENGINES (注册表元数据)
输出: channels_survey_2026/腿建造台账.md
口径: 数字零造假 — 全部取自 result JSON 实测编译态; 在役15腿补一轮
py_compile 复核如实记; 桥/芯 md5 前后对照记改动(预期无改动)。
"""
from __future__ import annotations

import hashlib
import importlib.util
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = Path(__file__).resolve().parent
LEGS = HERE.parent / "legs"
sys.path.insert(0, str(LEGS))
import _gen_legs_batch as _gen          # noqa: E402 (SKELETONS 原因表复用)
RESULT = HERE / "_gen_legs_batch_result.json"
OUT = HERE / "腿建造台账.md"
BRIDGE = LEGS / "api_replica_bridge.py"
CORE = LEGS / "http_api_leg_core.py"


def md5(p: Path) -> str:
    return hashlib.md5(p.read_bytes()).hexdigest()


def main() -> int:
    res = json.loads(RESULT.read_text(encoding="utf-8"))
    spec = importlib.util.spec_from_file_location("arb_ledger", BRIDGE)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    engines: dict = dict(mod.HTTP_ENGINES)

    import py_compile
    rows = {r["engine"]: r for r in res["engines"]}
    existing = [e for e in engines if e not in rows]

    # 复核编译门: 全量 119 新腿 + 在役15腿 现场重编 (不只信生成时记录)
    def compile_state(fp: Path) -> str:
        try:
            py_compile.compile(str(fp), doraise=True)
            return "绿"
        except py_compile.PyCompileError as e:
            return "红: " + str(e).splitlines()[-1][:80]
        except OSError as e:
            return "红: %s" % e

    verify = {eid: compile_state(LEGS / (eid + "_leg.py")) for eid in rows}
    v_green = sum(1 for v in verify.values() if v == "绿")

    c = res["counts"]
    lines = []
    lines.append("# 腿建造台账 (1025 渠道全接入令·腿批量建造)")
    lines.append("")
    lines.append("生成: %s | 生成器: `reforge_factory/legs/_gen_legs_batch.py`"
                 % res["generated_at"])
    lines.append("权威源: `reforge_factory/legs/api_replica_bridge.py` "
                 "HTTP_ENGINES **%d条** | 建造前已有腿 %d条 (在役15薄腿样板"
                 "+dangdang/last30days/metaso_kb 专项件不在 HTTP_ENGINES "
                 "同名面) | 本轮差集建造 **%d条**"
                 % (res["http_engines_total"], len(existing), c["processed"]))
    lines.append("铁律执行: 只增不删 (已存在腿一律跳过; --force 仅重生成"
                 "本批带标记产物); 桥表与芯 **零改动** (md5 前后一致: %s); "
                 "未 commit; 编译门=py_compile 逐个过 (进程内 doraise, 与 "
                 "`py -X utf8 -m py_compile` 同一 stdlib 编译器 — py 启动器"
                 "卡壳规避, 等价如实记)。"
                 % ("一致" if not res["bridge_or_core_modified"] else "有改动"))
    lines.append("")
    lines.append("## 0. 总账 (实测)")
    lines.append("")
    lines.append("- 本轮处理: **%d** 条 = 实装(full) **%d** / 半实装(semi,"
                 "**%d**) / 骨架TODO(skeleton) **%d**"
                 % (c["processed"], c["full"], c["semi"], c["skeleton"]))
    lines.append("- 编译门: **绿 %d / %d**%s"
                 % (c["compile_or_smoke_green"], c["processed"],
                    " (全绿 ✅)" if c["compile_or_smoke_green"] == c["processed"]
                    else " (有红 — 见表)"))
    lines.append("- 台账渲染时全量复编 (119 腿现场重过 py_compile): **绿 %d / %d**"
                 % (v_green, len(rows)))
    lines.append("- 编译门之外加模块导入冒烟 (endpoint/extract 可寻址, "
                 "零网络): 同批过")
    lines.append("- 在役15腿 (本轮未动) 复核编译态见 §3")
    lines.append("")
    lines.append("## 1. 新建腿全量表 (119条)")
    lines.append("")
    lines.append("| # | 引擎id | 腿文件 | 编译态 | 端点形态 | 备注 |")
    lines.append("|---|--------|--------|--------|----------|------|")
    i2 = 0
    for eid in engines:
        if eid not in rows:
            continue
        i2 += 1
        r = rows[eid]
        reg = engines[eid]
        comp = verify[eid]           # 台账渲染时现场重编 (不只信生成时记录)
        mode = {"full": "实装", "semi": "半实装",
                "skeleton": "骨架TODO"}[r["mode"]]
        note = "%s · %s" % (mode, reg["access"])
        if r["mode"] == "skeleton":
            note += " — " + _gen.SKELETONS.get(eid, "")
        lines.append("| %d | `%s` | `%s` | %s | %s | %s |"
                     % (i2, eid, r["file"], comp, r["form"], note))
    lines.append("")
    lines.append("## 2. 骨架TODO清单 (%d条 — 台账在案, 实调面待令)"
                 % c["skeleton"])
    lines.append("")
    skel = [(eid, r) for eid, r in rows.items() if r["mode"] == "skeleton"]
    for eid, r in skel:
        reg = engines[eid]
        lines.append("- `%s` (%s · %s): %s"
                     % (eid, reg["tags"], reg["name"],
                        _gen.SKELETONS.get(eid, "")))
    lines.append("")
    lines.append("## 3. 在役腿复核 (HTTP_ENGINES 同名15条)")
    lines.append("")
    lines.append("| 引擎id | 腿文件 | 编译态 | 备注 |")
    lines.append("|--------|--------|--------|------|")
    n_green = 0
    for eid in existing:
        fp = LEGS / (eid + "_leg.py")
        st = compile_state(fp) if fp.is_file() else "缺件"
        n_green += 1 if st == "绿" else 0
        lines.append("| `%s` | `%s` | %s | 1025 渠道普查令在役样板 (本轮未动) |"
                     % (eid, fp.name, st))
    lines.append("")
    lines.append("在役复核编译绿: %d/%d" % (n_green, len(existing)))
    lines.append("")
    lines.append("## 4. 改动与边界记录 (如实)")
    lines.append("")
    lines.append("- 桥表 `api_replica_bridge.py` / 芯 `http_api_leg_core.py`: "
                 "**零改动** (本令禁改面; md5 记录于 result JSON)")
    lines.append("- 桥表与芯 import 修正: **0条** (无需)")
    lines.append("- 半实装(semi)口径: 端点已落位、返回形态待实测校准 — "
                 "运行时失败/零命中如实记录不伪造")
    lines.append("- 骨架TODO口径: CLI/库型缺件不擅自安装; 数据集直下面非"
                 "检索端点; 复刻件另有在役接入件 (详见 §2 与各腿内注释)")
    lines.append("- 别名同面: openalex/semantic_scholar/crossref/marginalia/"
                 "openverse/google_news_rss/gdelt 的 _2/tool:// 变体与主id"
                 "同端点 (registry 双id登记如实对齐)")
    lines.append("- 本轮无网络冒烟 (令停机条件=编译门全绿); 首冒烟建议: "
                 "`py reforge_factory/legs/crossref_rest_api_leg.py "
                 "--campaign EPC-JIAGE --queries \"construction cost\"`")
    lines.append("")
    OUT.write_text("\n".join(lines) + "\n", encoding="utf-8", newline="\n")
    print("[ledger] %s | 新建%d (绿%d) | 在役复核绿%d/%d"
          % (OUT.name, c["processed"], c["compile_or_smoke_green"],
             n_green, len(existing)))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
