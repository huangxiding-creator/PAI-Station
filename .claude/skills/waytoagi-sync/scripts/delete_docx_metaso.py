#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""清理秘塔上的 docx（2026-09-12 用户批准，政策改为仅 md）。

方法：遍历根目录 + 全部章节夹（state/metaso-dirs.json），列出条目，
删除所有 fileName 以 .docx 结尾的文件。接口（UI 抓包实测）：
  POST /api/file/trash  body {"ids":[id,...]}   cookie 认证（无 token header）
  列表 GET /api/knowledge/{sid}/search?parentId=...  字段 data.content，带 meta-token

安全边界：
  - 只删 .docx 后缀条目（章节夹/根目录的文件夹名均不以 .docx 结尾）
  - 批量 20 个/次，间隔 1s；失败逐个重试；每步打印明细
"""
import json
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from upload_metaso import MetasoClient, SUBJECT_ID, TARGET_CFID, STATE, DIRS, log


def make_client():
    cli = MetasoClient()
    cli.ensure_browser()
    if not cli.ensure_login():
        sys.exit(1)
    cli.tab.get(f"https://metaso.cn/subject-v2/{SUBJECT_ID}/manage?cfid={TARGET_CFID}")
    time.sleep(3)
    return cli


def list_dir(cli, parent_id):
    all_items = []
    for page in range(10):
        js = f"""
        return (async () => {{
            try {{
                const meta = document.querySelector('meta[id="meta-token"]');
                const token = meta ? meta.content : '';
                const resp = await fetch('/api/knowledge/{SUBJECT_ID}/search?s=&parentId={parent_id}' +
                    '&pageSize=200&pageIndex={page}&sort=updateTime&sortDirection=desc',
                    {{credentials: 'include', headers: {{'token': token}}}});
                const data = await resp.json();
                const d = data.data || data;
                return JSON.stringify(d.content || d.list || []);
            }} catch(e) {{ return '[]'; }}
        }})();
        """
        batch = json.loads(cli.tab.run_js(js, timeout=30) or "[]")
        all_items.extend(batch)
        if len(batch) < 200:
            break
        time.sleep(0.5)
    return all_items


def trash(cli, ids):
    ids_js = json.dumps(ids)
    js = f"""
    return (async () => {{
        try {{
            const resp = await fetch('/api/file/trash', {{
                method: 'POST', credentials: 'include',
                headers: {{'Content-Type': 'application/json'}},
                body: JSON.stringify({{ids: {ids_js}}})
            }});
            const txt = await resp.text();
            return resp.status + '||' + txt.slice(0, 200);
        }} catch(e) {{ return '0||' + e.message; }}
    }})();
    """
    return str(cli.tab.run_js(js, timeout=60))


def main():
    cli = make_client()
    dirs = json.loads(DIRS.read_text(encoding="utf-8")) if DIRS.exists() else {}
    scopes = {"<根目录>": TARGET_CFID}
    scopes.update(dirs)

    total_deleted = 0
    report = []
    for name, cfid in scopes.items():
        items = list_dir(cli, cfid)
        docx = [it for it in items if str(it.get("fileName") or "").endswith(".docx")]
        others = len(items) - len(docx)
        print(f"\n📂 {name}: {len(items)} 条，其中 docx {len(docx)}（其余 {others} 保留）")
        if not docx:
            continue
        ids = [str(it["id"]) for it in docx]
        # 批量删，失败降级逐个
        remaining = ids
        for batch_start in range(0, len(remaining), 20):
            chunk = remaining[batch_start:batch_start + 20]
            res = trash(cli, chunk)
            status, _, body = res.partition("||")
            if status == "200" and '"errCode":0' in body.replace(" ", ""):
                total_deleted += len(chunk)
                print(f"   🗑 批量删 {len(chunk)} ✓")
            else:
                for one in chunk:
                    r2 = trash(cli, [one])
                    s2, _, b2 = r2.partition("||")
                    if s2 == "200" and '"errCode":0' in b2.replace(" ", ""):
                        total_deleted += 1
                    else:
                        print(f"   ✗ 单删失败 {one}: {r2[:100]}")
                    time.sleep(0.6)
            time.sleep(1.0)
        # 复核
        left = [it for it in list_dir(cli, cfid)
                if str(it.get("fileName") or "").endswith(".docx")]
        report.append((name, len(docx), len(left)))
        print(f"   复核剩余 docx: {len(left)}")
        time.sleep(0.8)

    print(f"\n🏁 共删除 {total_deleted} 个 docx")
    (STATE / "metaso-docx-cleanup.json").write_text(
        json.dumps([{"scope": n, "docx": d, "left": l} for n, d, l in report],
                   ensure_ascii=False, indent=1), encoding="utf-8")
    print("报告: state/metaso-docx-cleanup.json")


if __name__ == "__main__":
    main()
