# -*- coding: utf-8 -*-
"""pack.py —— kb_generate 云函数打包同步器。

把仓库 kb_factory/catalog_engine 子集（顶层 .py，不含 tests/__pycache__）+
包 __init__ 同步进本目录 kb_factory/，使云函数目录最小自含可部署
（tcb fn deploy 直接 zip 本目录即跑；引擎 stdlib only，零第三方依赖）。

纪律：只增不删（站清理铁律）——上游改名的旧文件会残留，部署前人工核对
kb_factory/MANIFEST.txt 与本输出清单即可。上游无删改时重复执行幂等。

【收口波B 包体决策（实测为凭，非手填）】
- 纯代码核心全进：purpose/views/cataloging/skos_export/dendron/storm_breadth/
  clc_layer 四词表 loader（thuocl_lex/fibo_lex/brick_lex/cilin_norm）——全部
  stdlib only（全目录 grep 无 yaml/requests/numpy 第三方 import，实核）。
- 重数据一律不进（留服务器侧）：seeds/ 词表与本体（thuocl 6.8M / fibo 76M /
  brick 2.6M / cilin 3.6M / taxonomy YAML 120K / 顶层六域种子 ~9.7M）——按
  云函数包体预算 ≤2MB（PKG_BUDGET）与首版纯引擎策略（无渠道）裁定。
- loader 缺数据 fail-soft（实核）：thuocl_lex 空目录 glob→空表；fibo/brick
  仅显式调用才读盘（引擎链零调用）；cilin_norm 默认关（KB_CILIN_NORM 缺省
  =关态直通不载数）；purpose.route_seeds 按磁盘实存跳过缺席 file 种子并记
  unavailable_skipped；storm_breadth 词池 is_dir() 判空回退 taxonomy 内置；
  clc_layer 巨人 pip 包缺席返 None 由 dendron 模板兜底。
- taxonomy_loader.py（仓库根，YAML 兼容层）不进包：import yaml=第三方依赖，
  违反云函数零依赖铁律；引擎未接线（收口波只留口），唯一消费方
  skos_export.from_taxonomy 为惰性导入且云函数路径不调用。
- 门禁注记：KB_TAXONOMY_GATE=1 需 seeds/taxonomy/check_taxonomy.py（未随包），
  云函数侧保持关——开启即 ImportError 如实崩（设计行为，禁静默放行）。

用法（本目录下）：py -3 pack.py
"""
import shutil
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
KB_ROOT = HERE.parents[1]                      # kb_factory/（cloudfn/kb_generate 的上两级）
SRC_CATALOG = KB_ROOT / "catalog_engine"
DST_PKG = HERE / "kb_factory"
DST_CATALOG = DST_PKG / "catalog_engine"

# 云函数运行时真正 import 的引擎面（catalog_engine/__init__.py 及其依赖闭包）
PY_FILES = ["__init__.py", "engine.py", "taxonomy.py", "blueprint.py", "metadata.py",
            "lint.py", "document_engine.py", "structure_miner.py", "doc_search.py",
            "evidence.py", "multistore.py", "schema_synth.py", "ascode.py",
            "corrector.py", "contract.py",
            # ── 收口波B 新增（纯代码，包体决策见模块 docstring）──
            "cataloging.py",        # 编目四件套（purpose 依赖：DIGEST_PLACEHOLDER）
            "purpose.py",           # ① purpose 前置+④ 结构 lint（KB_PURPOSE，惰性）
            "views.py",             # ⑥ 三视图统一出口（KB_VIEWS，惰性）
            "skos_export.py",       # ⑤ SKOS 导出（产物落盘侧挂，云函数默认关）
            "dendron.py",           # ② 冷门域模板兜底（KB_COLD_EXPAND 腿）
            "storm_breadth.py",     # v2.7 #13 STORM 多视角（depth=pro/flagship 自动）
            "clc_layer.py",         # ② 冷门域真实层（巨人 pip 包缺席 fail-soft）
            "thuocl_lex.py",        # 词表 loader（数据 seeds/thuocl 6.8M 不进包）
            "fibo_lex.py",          # 本体 loader（数据 seeds/fibo 76M 不进包）
            "brick_lex.py",         # 楼宇本体 loader（数据 seeds/brick 2.6M 不进包）
            "cilin_norm.py"]        # 词林归一（KB_CILIN_NORM 默认关；数据 3.6M 不进包）

PKG_BUDGET = 2 * 1024 * 1024        # 云函数包体预算 ≤2MB（收口波B 裁定口径）


def main() -> int:
    if not SRC_CATALOG.is_dir():
        print("[FAIL] 找不到仓库 catalog_engine:", SRC_CATALOG)
        return 1
    DST_PKG.mkdir(exist_ok=True)
    DST_CATALOG.mkdir(exist_ok=True)

    # 包 __init__（仓库根 kb_factory/__init__.py 仅 docstring，安全直拷）
    pkg_init = KB_ROOT / "__init__.py"
    shutil.copyfile(pkg_init, DST_PKG / "__init__.py")
    copied = ["kb_factory/__init__.py"]

    for name in PY_FILES:
        src = SRC_CATALOG / name
        if not src.is_file():  # 上游重构少了文件：如实报警不猜
            print(f"[WARN] 上游缺失 {name}（跳过）")
            continue
        shutil.copyfile(src, DST_CATALOG / name)
        copied.append(f"kb_factory/catalog_engine/{name}")

    # 全包实测体量（含只增不删可能残留的历史件；__pycache__ 非部署源不计入）
    pkg_total = sum(p.stat().st_size for p in DST_PKG.rglob("*")
                    if p.is_file() and "__pycache__" not in p.parts)
    manifest = ["source: " + str(KB_ROOT / "catalog_engine"),
                "files (%d):" % len(copied)] + ["  " + c for c in copied] + [
                "",
                "包体决策（收口波B，实测为凭）：",
                "  纯代码核心全进（含收口波 11 新模块，全 stdlib）。",
                "  重数据不进、留服务器侧：seeds/thuocl 6.8M · seeds/fibo 76M ·",
                "  seeds/brick 2.6M · seeds/cilin 3.6M · seeds/taxonomy YAML 120K ·",
                "  seeds/0*.json 六域种子 ~9.7M——loader 缺数据一律 fail-soft。",
                "  taxonomy_loader.py 不进包（import yaml=第三方，云函数零依赖铁律）。",
                "  KB_TAXONOMY_GATE 需 seeds 校验器未随包——云函数侧保持关。",
                "package: %d bytes (%.0fKB) / budget %dKB %s"
                % (pkg_total, pkg_total / 1024, PKG_BUDGET // 1024,
                   "OK" if pkg_total <= PKG_BUDGET else "OVER!")]
    (DST_PKG / "MANIFEST.txt").write_text("\n".join(manifest) + "\n", encoding="utf-8")
    total = sum((HERE / p).stat().st_size for p in copied)
    print(f"[OK] 同步 {len(copied)} 件 · 同步集 {total / 1024:.0f}KB · "
          f"全包实测 {pkg_total / 1024:.0f}KB（预算 {PKG_BUDGET // 1024}KB "
          f"{'OK' if pkg_total <= PKG_BUDGET else 'OVER!'}）→ {DST_PKG}")
    for c in copied:
        print("  " + c)
    return 0


if __name__ == "__main__":
    sys.exit(main())
