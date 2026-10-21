# -*- coding: utf-8 -*-
"""W7 冒烟样例生成器：自建 tmp 语料 + 迷你蓝图 + 假订单（全部落在 samples/smoke/）。

幂等：重复运行覆盖重建语料/蓝图/订单（不动 outbox/ledger）。
真实冒烟命令见 samples/smoke/README_smoke.md。
"""
import json
from pathlib import Path

SMOKE = Path(__file__).resolve().parent


def build() -> None:
    rep = SMOKE / "corpus" / "reports"
    kn = SMOKE / "corpus" / "knowledge"
    rep.mkdir(parents=True, exist_ok=True)
    kn.mkdir(parents=True, exist_ok=True)
    (rep / "中国水电市场研究报告2026.pdf").write_bytes(b"%PDF-1.4 W7 smoke fake report A\n" * 64)
    (rep / "水利水电EPC总承包实战指南.pdf").write_bytes(b"%PDF-1.4 W7 smoke fake report B\n" * 64)
    (kn / "重大事故隐患判定导则.md").write_text(
        "# 重大事故隐患判定导则（样例知识件）\n\n正文样例。\n", encoding="utf-8")
    (kn / "施工安全监督检查要点.md").write_text(
        "# 施工安全监督检查要点（样例知识件）\n\n正文样例。\n", encoding="utf-8")

    def slot(name, ext, title, badge, perm):
        return {"name": name, "path": "RB-06/01/", "tier": "core", "ext": ext,
                "title": title, "badge": badge, "perm": perm,
                "identifier": "SMOKE-" + name, "checksum_slot": None}

    bp = {
        "domain": "水利安全",
        "need": {"domain": "水利安全", "keywords": ["水利", "安全"],
                 "intent": "冒烟", "size_hint": "small"},
        "tree": {"mode": "smoke", "root": "水利安全知识库W7冒烟", "l1": [{
            "code": "RB", "dir": "RB-06", "path": "RB-06/", "name": "研报库",
            "theme": "研报库（RB）：自产研报 · 安全知识件", "source": "smoke",
            "l2": [
                {"code": "RB-06/01", "dir": "01", "path": "RB-06/01/", "name": "自产研报",
                 "theme": "自产研报：可本地直取的绿源", "file_count": 3, "files": [
                     slot("自产研报_core_001.pdf", "pdf", "中国水电市场研究报告2026",
                          "self_owned", "green"),
                     slot("自产研报_core_002.pdf", "pdf", "水利水电EPC总承包实战指南",
                          "green_free", "green"),
                     slot("自产研报_core_003.pdf", "pdf", "独家行业白皮书占位件",
                          "green_free", "green")]},
                {"code": "RB-06/02", "dir": "02", "path": "RB-06/02/", "name": "安全知识件",
                 "theme": "安全知识件：绿/ima/gb/黄混排", "file_count": 5, "files": [
                     slot("安全知识件_core_001.md", "md", "重大事故隐患判定导则",
                          "self_owned", "green"),
                     slot("安全知识件_core_002.md", "md", "施工安全监督检查要点",
                          "self_owned", "green"),
                     slot("安全知识件_core_003.md", "md", "六项机制实施指南要点",
                          "ima_public", "green"),
                     slot("安全知识件_core_004.pdf", "pdf", "GB防洪标准汇编占位件",
                          "gb_free", "green"),
                     slot("安全知识件_core_005.pdf", "pdf", "文库黄源资料占位件",
                          "wenku_vip", "yellow")]},
            ]}]},
        "stats": {"files": 8},
    }
    (SMOKE / "blueprint").mkdir(exist_ok=True)
    (SMOKE / "blueprint" / "mini_bp.json").write_text(
        json.dumps(bp, ensure_ascii=False, indent=1), encoding="utf-8")

    order = {"id": "SMOKE-1022-001", "need_text": "水利安全知识库（W7 冒烟样例）",
             "blueprint_ref": str((SMOKE / "blueprint" / "mini_bp.json").resolve()),
             "email": "buyer@example.com", "version_selection": "original",
             "price": "0.01", "paid_at": "2026-10-22T12:00:00", "status": "paid"}
    (SMOKE / "inbox").mkdir(exist_ok=True)
    (SMOKE / "inbox" / "SMOKE-1022-001.json").write_text(
        json.dumps(order, ensure_ascii=False, indent=1), encoding="utf-8")
    print("smoke fixtures ready:", SMOKE)


if __name__ == "__main__":
    build()
