# -*- coding: utf-8 -*-
"""viaim 耳机录音同步器：拉取全部录音+摘要+项目分类 → 落盘 AI-Station/data/viaim/"""
import subprocess, json, os, sys
from datetime import datetime

CLI = os.path.join(os.environ.get("LOCALAPPDATA", ""), "viaim-cli", "viaim-cli.exe")
OUT = r"E:\AI-Station\data\viaim"
os.makedirs(OUT, exist_ok=True)

def run(args):
    r = subprocess.run([CLI] + args, capture_output=True, text=True, timeout=60, encoding="utf-8", errors="replace")
    try:
        return json.loads(r.stdout)
    except (json.JSONDecodeError, TypeError):
        return {"ok": False, "error": {"message": r.stdout[:200] + r.stderr[:200]}}

def sync_all():
    # 1. 项目空间
    spaces_r = run(["space", "list"])
    spaces = spaces_r.get("data", {}).get("data", []) if spaces_r.get("ok") else []
    with open(os.path.join(OUT, "spaces.json"), "w", encoding="utf-8") as f:
        json.dump(spaces, f, ensure_ascii=False, indent=1)
    print(f"spaces: {len(spaces)}")

    # 2. 全部录音（分页拉取）
    all_records = []
    page_tag = None
    while True:
        args = ["record", "list", "--page-size", "200"]
        if page_tag:
            args += ["--page-tag", page_tag]
        r = run(args)
        if not r.get("ok"):
            print(f"record list failed: {r.get('error', {}).get('message', '?')}")
            break
        d = r.get("data", {})
        batch = d.get("data", [])
        all_records.extend(batch)
        page_tag = d.get("page_tag", "")
        if not page_tag or not batch:
            break
        print(f"  page: +{len(batch)} (total {len(all_records)})")

    # 3. 落盘
    with open(os.path.join(OUT, "records.jsonl"), "w", encoding="utf-8") as f:
        for rec in all_records:
            f.write(json.dumps(rec, ensure_ascii=False) + "\n")
    print(f"records: {len(all_records)} → records.jsonl")

    # 4. 按项目分组
    by_space = {}
    space_map = {s["category_id"]: s["name"] for s in spaces}
    for rec in all_records:
        for cat in rec.get("categories", []):
            name = space_map.get(cat["id"], cat.get("name", "未知"))
            by_space.setdefault(name, []).append(rec["record_id"])
    with open(os.path.join(OUT, "by_space.json"), "w", encoding="utf-8") as f:
        json.dump(by_space, f, ensure_ascii=False, indent=1)
    print(f"by_space: {len(by_space)} spaces")

    # 5. 生成摘要索引（标题+概要+时间+项目）
    with open(os.path.join(OUT, "index.md"), "w", encoding="utf-8") as f:
        f.write(f"# viaim 耳机录音索引（{datetime.now().strftime('%Y-%m-%d %H:%M')} 同步）\n\n")
        f.write(f"总计 {len(all_records)} 条\n\n")
        for name in sorted(by_space.keys()):
            recs = [r for r in all_records if any(c["id"] == k for c in r.get("categories", []) for k in [s["category_id"] for s in spaces if s["name"] == name])]
            f.write(f"## {name} ({len(by_space[name])} 条)\n\n")
            for rec in sorted(recs, key=lambda x: x.get("record_time", 0), reverse=True)[:20]:
                title = rec.get("title", "无标题")
                overview = rec.get("overview", "")[:80]
                ts = datetime.fromtimestamp(rec.get("record_time", 0) / 1000).strftime("%m-%d %H:%M")
                f.write(f"- **{title}** ({ts}) {overview}...\n")
            f.write("\n")
    print(f"index: → index.md")

    return len(all_records)

if __name__ == "__main__":
    n = sync_all()
    print(f"\n同步完成: {n} 条录音")
