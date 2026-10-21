# -*- coding: utf-8 -*-
"""KB-FACTORY 样本生成器（W4）——真跑 kb_factory/catalog_engine 产出小程序演示样本。

确定性：同输入必同输出（引擎本身确定性）；本脚本无随机源、无时钟。
产物：pages/kbfactory/samples/sample_water.json · sample_law.json（每份 ≤200KB，
超出自动逐档收紧「每主题组保留条目数」并落截断注明，统计/报价恒为全量真值）。

槽位瘦身纪律：演示样本只保留页面展示字段（name/tier/ext/size/icon/src/perm 标签），
徽章枚举 → 展示文案在此层完成（green_free→🟢公开资料 等），原始 15 字段垫片与
索引卡不进样本——样本是给 UI 看的视图数据，全量蓝图由引擎按需再生。
"""
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]          # 仓库根（tools/→zongbao-ai/→微信小程序/→ROOT）
sys.path.insert(0, str(ROOT / "kb_factory"))        # 编目引擎入 path（同 tests 的接线方式）

from catalog_engine import build_blueprint, ENGINE_VERSION  # noqa: E402

OUT_DIR = Path(__file__).resolve().parents[1] / "pages" / "kbfactory" / "samples"
MAX_BYTES = 200 * 1024
KEEPS = (3, 2, 1)  # 每主题组保留条目数（超 200KB 逐档收紧，1 仍超才报错）

# 两域真需求（与 kb_factory/catalog_engine/tests/test_engine.py 的 water/law 样例逐字一致）
NEEDS = {
    "water": {"domain": "水利EPC工程", "keywords": ["水利水电", "EPC总承包", "施工组织设计", "工程监理", "工程造价"],
              "intent": "施工与项目管理", "size_hint": "large"},
    "law": {"domain": "律师事务所知识库", "keywords": ["民法典", "诉讼", "合规", "尽职调查", "劳动争议"],
            "intent": "诉讼与合规", "size_hint": "medium"},
}

# 徽章 → 展示对（emoji + 中文标签）：文案层禁渠道名，原始枚举不进 UI
BADGE_DISPLAY = {"green_free": ("🟢", "公开资料"), "wenku_vip": ("🟡", "会员资料"),
                 "ima_public": ("🔵", "共享资料"), "gb_free": ("🏛️", "官方标准"),
                 "self_owned": ("🟢", "自有资料")}
PERM_DISPLAY = {"green": "可自由使用", "yellow": "会员可用", "red": "单独审批"}


def fmt_size(kb: int) -> str:
    return f"{kb / 1024:.1f}MB" if kb >= 1024 else f"{kb}KB"


def slim_slot(s: dict) -> dict:
    icon, src = BADGE_DISPLAY[s["badge"]]
    return {"name": s["name"], "tier": s["tier"], "ext": s["ext"], "size": fmt_size(s["size_kb"]),
            "icon": icon, "src": src, "perm": PERM_DISPLAY[s["perm"]]}


def to_sample(bp: dict, keep: int) -> dict:
    """蓝图 → 演示样本：保全树形/统计/报价/溯源，槽位瘦身 + 每组截断到 keep。"""
    kept = 0
    l1_out = []
    for l1 in bp["tree"]["l1"]:
        l2_out = []
        for l2 in l1["l2"]:
            pool = l2.get("files") or (l2["split_dirs"][0]["files"] if l2.get("split_dirs") else [])
            files = [slim_slot(s) for s in pool[:keep]]
            kept += len(files)
            l2_out.append({"code": l2["code"], "name": l2["name"], "path": l2["path"],
                           "file_count": l2["file_count"], "files": files})
        l1_out.append({"code": l1["code"], "dir": l1["dir"], "name": l1["name"], "theme": l1["theme"],
                       "l2_count": len(l1["l2"]), "l2": l2_out})
    tree = {"mode": bp["tree"]["mode"], "root": bp["tree"]["root"], "l1": l1_out}
    # 报价视图化：值原样保留，仅键名适配 UI（import_add），原始引擎键不进包内样本
    q = dict(bp["quote"])
    q["import_add"] = q.pop("ima_add")
    return {"domain": bp["domain"], "need": bp["need"], "tree": tree, "ratio": bp["ratio"],
            "stats": bp["stats"], "quote": q, "provenance": bp["provenance"],
            "_sample": {"engine_version": ENGINE_VERSION, "demo": True, "truncated": True,
                        "kept_per_group": keep, "kept_files": kept, "files_total": bp["stats"]["files"],
                        "note": "演示样本：每主题组仅保留前 %d 个条目并精简为展示字段；"
                                "统计与报价为引擎全量真值，完整蓝图由编目引擎按需再生" % keep}}


def main() -> int:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    for key, need in NEEDS.items():
        bp = build_blueprint(need)  # 真跑编目引擎（非手拼）
        for keep in KEEPS:
            sample = to_sample(bp, keep)
            text = json.dumps(sample, ensure_ascii=False, separators=(",", ":"))
            if len(text.encode("utf-8")) <= MAX_BYTES:
                break
        else:
            print(f"[FAIL] {key} 即便每组只留 1 条仍超 200KB")
            return 1
        out = OUT_DIR / f"sample_{key}.json"
        out.write_text(text, encoding="utf-8")
        st = sample["stats"]
        print(f"[OK] {out.name}: {len(text.encode('utf-8')) / 1024:.0f}KB · keep={keep}/组 · "
              f"files={st['files']} gb={st['gb']} total=¥{sample['quote']['total']} "
              f"l1={st['l1_count']} l2={st['l2_count']} dirs={st['dir_count']}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
