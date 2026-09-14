#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""探测秘塔删除接口：列表拿一个 docx id → 试候选端点 → 复核消失。

只删一个目标 docx（本来就要清理的），cookie 认证（不带 token header，写接口红线）。
"""
import json
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from upload_metaso import MetasoClient, SUBJECT_ID, TARGET_CFID, STATE

cli = MetasoClient()
cli.ensure_browser()
if not cli.ensure_login():
    sys.exit(1)
tab = cli.tab
tab.get(f"https://metaso.cn/subject-v2/{SUBJECT_ID}/manage?cfid={TARGET_CFID}")
time.sleep(3)


def list_dir(parent_id):
    """列目录（翻页聚合）。字段：data.content（2026-09 改版，旧为 data.list）。"""
    all_items = []
    for page in range(10):  # 200×10=2000 上限
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
        batch = json.loads(tab.run_js(js, timeout=30) or "[]")
        all_items.extend(batch)
        if len(batch) < 200:
            break
        time.sleep(0.5)
    return all_items


# 章节「0. 从这里启程」里找一个 docx
CHAP_CFID = "2098612644141748224"
items = list_dir(CHAP_CFID)
print(f"章节夹内 {len(items)} 条")
docx = next((it for it in items if str(it.get("fileName") or "").endswith(".docx")), None)
if not docx:
    docx = next((it for it in list_dir(TARGET_CFID)
                 if str(it.get("fileName") or "").endswith(".docx")), None)
    print("章节夹无 docx，改用根目录样本")
if not docx:
    print("❌ 找不到任何 docx 样本")
    sys.exit(2)

fid = str(docx.get("id"))
fname = docx.get("fileName")
print(f"删除样本: {fname} id={fid}")
print("条目字段:", json.dumps({k: docx.get(k) for k in
                              ("id", "fileName", "type", "isDir", "fileType", "status")},
                             ensure_ascii=False))

candidates = [
    ("DELETE", f"/api/file/{fid}", ""),
    ("DELETE", f"/api/file/{fid}/delete", ""),
    ("POST", f"/api/file/{fid}/delete", ""),
    ("POST", "/api/file/delete", json.dumps({"ids": [fid]})),
    ("POST", "/api/file/batch_delete", json.dumps({"ids": [fid]})),
    ("DELETE", f"/api/knowledge/{SUBJECT_ID}/file/{fid}", ""),
]
for method, url, body in candidates:
    js = f"""
    return (async () => {{
        try {{
            const opt = {{method: '{method}', credentials: 'include'}};
            if ({json.dumps(body)} !== '') {{
                opt.headers = {{'Content-Type': 'application/json'}};
                opt.body = {json.dumps(body)};
            }}
            const resp = await fetch('{url}', opt);
            const txt = await resp.text();
            return '{method} ' + '{url.split("?")[0]}' + ' -> ' + resp.status + ' ' + txt.slice(0,150);
        }} catch(e) {{ return '{method} {url} ERR ' + e.message; }}
    }})();
    """
    out = str(tab.run_js(js, timeout=30))
    print(out)
    if " 200 " in out and '"errCode":0' in out.replace(" ", ""):
        print("✅ 命中删除端点！")
        break

time.sleep(2)
left = [it for it in list_dir(CHAP_CFID) if str(it.get("id")) == fid]
print(f"复核：条目{'仍存在 ✗' if left else '已消失 ✓'}")
(STATE / "metaso-delete-probe.json").write_text(
    json.dumps({"sample": fname, "id": fid, "result": out}, ensure_ascii=False),
    encoding="utf-8")
