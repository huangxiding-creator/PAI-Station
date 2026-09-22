# -*- coding: utf-8 -*-
"""会话探针 — 摸清 Manus 会话页的消息流/规划过程/文件列表的 API+DOM 形态.

逆向剖析第一步: 不猜测选择器, 实测采集路径. 产出:
  probe_api_urls.txt   会话页加载时的全部 API 调用 (URL 样本)
  probe_dom_sample.md  页面 DOM 文本样本 (前 3000 字)
  probe_api_bodies/    命中的关键 API 响应体样本 (前 5 个)
用法: python session_probe.py [账号序号] [会话序号]  (默认 1 1)
"""
import sys
import time
import json
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import manus_lib as lib

OUT = Path("probe_out")
OUT.mkdir(exist_ok=True)


def main():
    idx = int(sys.argv[1]) if len(sys.argv) > 1 else 1
    sess_idx = int(sys.argv[2]) if len(sys.argv) > 2 else 1
    accounts = lib.load_accounts("账号列表 - 调试.txt")
    email, password = accounts[idx - 1]
    print(f"[probe] 账号#{idx}: {email}", flush=True)

    page = lib.make_page()
    sessions = lib.login(page, email, password)
    if sessions is None:
        print("[probe] 登录失败", flush=True)
        return 3
    if not sessions:
        print("[probe] 该账号无会话", flush=True)
        return 3
    sess = sessions[sess_idx - 1]
    uid = sess.get("uid")
    title = str(sess.get("title", ""))[:50]
    print(f"[probe] 目标会话#{sess_idx}: {uid} {title}", flush=True)

    # 全量监听 (api.manus.im) + 进会话页
    page.listen.start("api.manus.im")
    page.get(f"https://manus.im/app/{uid}")
    time.sleep(8)

    urls = []
    bodies = []
    deadline = time.time() + 20
    while time.time() < deadline:
        try:
            packet = page.listen.wait(timeout=2)
        except Exception:
            continue
        if not packet or packet.is_failed:
            continue
        url = packet.url.split("?")[0]
        if url not in [u for u, _ in bodies]:
            urls.append(url)
            try:
                body = packet.response.body
            except Exception:
                body = None
            bodies.append((url, body))
    page.listen.stop()

    (OUT / "probe_api_urls.txt").write_text(
        "\n".join(urls), encoding="utf-8")
    print(f"[probe] 捕获 {len(urls)} 个 api.manus.im 端点:", flush=True)
    for u in urls:
        print("   ", u, flush=True)

    # 关键响应体样本落盘 (会话消息/任务相关优先)
    keywords = ("session", "message", "task", "event", "chat", "plan", "file")
    saved = 0
    for url, body in bodies:
        if saved >= 8:
            break
        if not any(k in url.lower() for k in keywords):
            continue
        if body is None:
            continue
        text = body if isinstance(body, str) else json.dumps(
            body, ensure_ascii=False)
        name = url.split("/")[-1][:40].replace("/", "_") or "root"
        (OUT / f"probe_api_bodies_{saved}_{name}.json").write_text(
            text[:200000], encoding="utf-8")
        print(f"[probe] 落盘样本 {saved}: {url} len={len(text)}", flush=True)
        saved += 1

    # DOM 文本样本
    dom = page.ele("tag:body")
    text = (dom.text or "") if dom else ""
    (OUT / "probe_dom_sample.md").write_text(text[:5000], encoding="utf-8")
    print(f"[probe] DOM 文本样本 {len(text)} 字符落盘", flush=True)
    page.get_screenshot(path=str(OUT / "probe_session.png"))
    print("[probe] 完成", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
