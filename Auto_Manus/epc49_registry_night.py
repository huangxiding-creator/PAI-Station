# -*- coding: utf-8 -*-
"""EPC49 注册表纯HTTP子集夜扫 — 1003 全渠道令补位腿.

走 engineering-research.skill channels 注册表模块(每模块自带节流/文件帽),
串行+异常隔离; domain_blocklist.json 全渠道生效(用户令0923).
不含浏览器/账号重腿(那些走 opencli 夜腿与 ima/lark 收割器).
"""
import io
import json
import sys
import time
from pathlib import Path
from types import SimpleNamespace

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")

sys.path.insert(0, r"E:\AI-Station\Auto_Manus")
import epc49_topics as T  # noqa: E402
sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng\engineering-research.skill\scripts")

BATTLE = T.BATTLE
COMPANY = T.COMPANY
TWO = [d for d in BATTLE.iterdir() if d.name.startswith("02")][0]

CODE_VERSION = "v2"      # 不跑旧码铁律: 起跑必打横幅, 早验收 grep "[v2]"

# 黑名单闸 (conductor 同源数据, 出队级拒绝)
BLOCK = json.loads(
    (Path(r"E:\AI-Station\ResearchFactory-Eng\EPC100\data\domain_blocklist.json"))
    .read_text(encoding="utf-8"))
BLOCKED_DOMS = {b if isinstance(b, str) else b.get("domain", "")
                for b in (BLOCK if isinstance(BLOCK, list) else BLOCK.get("domains", []))}

# 纯HTTP子集 (夜窗 23:00 段; 每渠道内部自带帽+节流)
CHANNELS = [
    "bidding", "ggzy", "ccgp", "chinabidding_cn", "creditchina",
    "shixin", "em_news", "sasac", "patents", "standards",
    "tcec", "nea", "mohurd", "ndrc", "jzsc", "company_info",
    "cninfo",       # 二跑: 母公司 601669 口径
    "gov_sichuan_jst",
]


def main() -> int:
    print(f"[{CODE_VERSION}] 注册表夜腿启动 {time.strftime('%F %T')}",
          flush=True)
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("--only", default="",
                    help="逗号分隔渠道子集 (1004 夜班扩容: 03:37 重试班"
                         " 只跑 23:00 班的失败线, 不重扫全量)")
    ap.add_argument("--tag", default="1003",
                    help="结果 json 后缀 (默认 1003 兼容旧链)")
    args = ap.parse_args()
    only = {x.strip() for x in args.only.split(",") if x.strip()}
    from channels import get_channel
    kw_extra = {"cninfo": "中国电建 601669"}  # 母公司诉讼/公告口径
    results = {}
    for ch in (CHANNELS if not only else [c for c in CHANNELS
                                          if c in only]):
        dom = ch.split("_")[0]
        if any(dom in b or b in dom for b in BLOCKED_DOMS if b):
            print(f"[gate] {ch}: 域名命中黑名单, 跳过", flush=True)
            results[ch] = "blocked"
            continue
        out = TWO / f"_registry_{ch}"
        out.mkdir(parents=True, exist_ok=True)
        try:
            cfg = SimpleNamespace(domain_dir=BATTLE, research_target=COMPANY)
            c = get_channel(ch, cfg)
            kw = kw_extra.get(ch, COMPANY)
            r = c.collect([{"keywords": {ch: kw},
                            "dimension_name": ch,
                            "expected_channels": [ch]}], out)
            results[ch] = {"ok": r.success, "files": len(r.files_collected),
                           "err": r.error}
            print(f"[{ch}] ok={r.success} files={len(r.files_collected)} "
                  f"err={r.error}", flush=True)
        except Exception as e:  # noqa: BLE001
            results[ch] = {"ok": False, "err": f"{type(e).__name__}: {e}"}
            print(f"[{ch}] 异常 {type(e).__name__}: {e}", flush=True)
        time.sleep(5)  # 渠道间礼貌间隔
    (TWO / f"_registry_night_{args.tag}.json").write_text(
        json.dumps(results, ensure_ascii=False, indent=1), encoding="utf-8")
    print("[registry-night] 完成", flush=True)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
