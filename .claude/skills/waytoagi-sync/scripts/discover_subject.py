#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""发现用户秘塔知识库列表，定位「工程大脑」subject id + 根 cfid。

只读探测：先试常见列表端点（GET 无副作用），全 404 再走页内钩子抓
真实请求（技能配方：不盲猜写端点，读端点试错可接受）。
"""
import json
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from upload_metaso import MetasoClient  # noqa: E402

CANDIDATES = (
    "/api/knowledge/list",
    "/api/subject/list",
    "/api/user/subjects",
    "/api/knowledge/subjects",
    "/api/library/list",
)

HOOK = """
window.__reqs = [];
(function(){
  const _f = window.fetch;
  window.fetch = function(input, init){
    try {
      const url = typeof input === 'string' ? input : (input && input.url) || '';
      window.__reqs.push({url: String(url)});
    } catch(e) {}
    return _f.apply(this, arguments);
  };
})();
"""


def try_list_apis(tab):
    js = """
    return (async () => {
        const out = [];
        for (const u of %s) {
            try {
                const meta = document.querySelector('meta[id="meta-token"]');
                const token = meta ? meta.content : '';
                const resp = await fetch(u, {credentials: 'include',
                                             headers: {'token': token}});
                const txt = await resp.text();
                out.push({u: u, status: resp.status, body: txt.slice(0, 400)});
            } catch(e) { out.push({u: u, status: 0, body: e.message}); }
        }
        return JSON.stringify(out);
    })();
    """ % json.dumps(list(CANDIDATES))
    try:
        return json.loads(tab.run_js(js, timeout=60) or "[]")
    except Exception as exc:
        print(f"[probe] 页内调用异常: {exc}")
        return []


def main():
    cli = MetasoClient()
    cli.ensure_browser()
    if not cli.ensure_login():
        return 1
    tab = cli.tab
    tab.get("https://metaso.cn")
    time.sleep(3)

    print("== 只读端点试探 ==")
    hits = try_list_apis(tab)
    for h in hits:
        print(f"  {h['status']} {h['u']} :: {h['body'][:160]}")
    ok = [h for h in hits if h["status"] == 200 and '"errCode":0' in h["body"].replace(" ", "")]
    if ok:
        print("\n命中列表端点，完整响应在下方重打：")
        for h in ok:
            print(h["body"])
        return 0

    print("\n== 端点全空，改走 UI 钩子：开知识库管理页抓请求 ==")
    tab.get("https://metaso.cn")
    time.sleep(2)
    tab.run_js(HOOK)
    # 知识库入口：常见为顶部导航「知识库」或首页左侧
    for label in ("知识库", "我的知识库", "专题"):
        btn = tab.ele(f"text={label}", timeout=3)
        if btn:
            try:
                btn.click()
                time.sleep(4)
                print(f"已点击「{label}」")
                break
            except Exception:
                continue
    reqs = tab.run_js("return JSON.stringify(window.__reqs||[])") or "[]"
    print("捕获请求：")
    for r in json.loads(reqs):
        print(" ", r["url"][:160])
    return 0


if __name__ == "__main__":
    sys.exit(main())
