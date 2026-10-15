# -*- coding: utf-8 -*-
"""harvest_djyanbao — 洞见研报渠道收割腿 (BID26 四面优先 · C 轴 djyanbao 渠道).

链路: DrissionPage 有头浏览器(离屏) → 密码登录(凭据读 01 账号授权/洞见研报
密码登录账号.txt, 永不打印) → report/search 检索 → 卡片双重相关门 → 详情页
取摘要+正文可读部分 → 落 data/harvest/djyanbao/<cid>/*.md + records.jsonl.
只产文件, 绝不写 ammo_pool (不 import, 不 ingest).

纪律:
  1. 双重相关门: 标题/卡片文本命中检索面词 ∧ 命中域词
     (招标|投标|评标|工程|EPC|采购|承包|造价|FIDIC|BIM|供应链), 缺一不入;
  2. 类型门: 剔除机构调研/财报/公告/招股类卡片 (SKIP_TYPE);
  3. 每件 >300 字且非 SERP 形(详情页摘要/正文), 否则如实 skip;
  4. 串行 + 3s 礼貌间隔; 登录失败/验证码 = 立即收兵报 blocker 不死磕;
  5. engine=djyanbao:vip (渠道 id 子串命中), cred=research.

⚠ BLOCKED-2026-10-15 实测: djyanbao 官网全面改版(V2.1.0, Tailwind 风格,
不再用 Element-UI 弹窗) — ①登录框 placeholder 改为「请输入手机号」(本脚本
已适配子串匹配); ②登录按钮实为「立即登录」且不在任何 dialog/modal 容器内
(本脚本已改为全页精确文本点击, 验证 click 已触发); ③密码填+点后仍无会话
(header 仍挂「登录 / 注册」, cookie 空) — 服务端拒登(密码失效或风控), 非
按钮/验证码问题(页面上 capt 类节点实为营销轮播箭头); ④匿名搜索返回
「研报加载失败」(列表 API 需登录); ⑤01 账号授权/洞见研报cookie.txt 仅含
统计 cookie 无会话 token。⇒ 当日收割 0 件, 如实报 blocker。恢复路径:
用户交互式跑 --login-wait 300 用 APP 扫码 (会话入持久 profile 后本脚本
复跑即通), 或凭据失效则更新 01 账号授权/洞见研报密码登录账号.txt。

用法: py -3.11 reforge_factory/harvest_djyanbao.py --campaign EPC-BID26
        [--per-query 3] [--max-total 12] [--login-wait 45] [--dry]
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from pathlib import Path
from urllib.parse import quote

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REPO = Path(__file__).resolve().parents[1]
CRED_FILE = (REPO / "ResearchFactory-Eng" / "01 账号授权"
             / "洞见研报密码登录账号.txt")          # 指定凭据源, 只读不打印
RUNNER_DIR = (REPO / "ResearchFactory-Eng" / "engineering-research.skill"
              / "scripts")                          # 复用 runner 的 BASE_URL/过滤词
sys.path.insert(0, str(RUNNER_DIR))
import djyanbao_drission as dj                      # noqa: E402
from DrissionPage import ChromiumOptions, ChromiumPage  # noqa: E402

BASE_URL = "https://www.djyanbao.com/report/search?sort=publish_at&order=DESC"
PROFILE = REPO / "data" / "harvest" / "_djyanbao_profile"
LOCAL_PORT = 9533                                    # 避开 9222 免打扰口
SKIP_TYPE_KEYWORDS = dj.SKIP_TYPE_KEYWORDS
DOMAIN_RE = re.compile(r"招标|投标|评标|工程|EPC|采购|承包|造价|FIDIC|BIM|供应链")

# (检索词, 目标 EEI) — 四面优先, 域词兜底挂 Q1-E1
PLAN: list[tuple[str, str]] = [
    ("FIDIC", "Q23-E1"),
    ("国际工程", "Q24-E1"),
    ("对外承包工程", "Q24-E1"),
    ("电子招投标", "Q19-E1"),
    ("BIM", "Q19-E1"),
    ("评标", "Q21-E1"),
    ("招标代理", "Q25-E1"),
    ("公共资源交易", "Q26-E1"),
    ("供应链 采购", "Q25-E1"),
    ("工程总承包", "Q1-E1"),
    ("招投标", "Q1-E1"),
]


def read_creds() -> tuple[str, str] | None:
    """从指定文件读 (账号, 密码); 文件缺失/解析失败返回 None, 永不打印值."""
    try:
        raw = CRED_FILE.read_text(encoding="utf-8", errors="replace")
    except OSError:
        return None
    m_phone = re.search(r"账\s*号[:：]\s*(1\d{10})", raw)
    m_pwd = re.search(r"密\s*码[:：]\s*(\S+)", raw)
    if not (m_phone and m_pwd):
        return None
    return m_phone.group(1), m_pwd.group(1)


def create_page(download_dir: Path) -> ChromiumPage:
    """离屏有头 Chromium + 持久 profile (登录态复用) + 独立调试口."""
    co = ChromiumOptions()
    co.set_download_path(str(download_dir))
    co.set_pref("download.prompt_for_download", False)
    co.headless(False)                               # djyanbao 需可见渲染
    co.set_argument("--window-position=-32000,0")    # 离屏=真渲染不打扰用户
    co.set_argument("--window-size=1280,900")
    co.set_argument("--disable-blink-features=AutomationControlled")
    co.set_argument("--ignore-certificate-errors")
    co.set_user_data_path(str(PROFILE))
    co.set_local_port(LOCAL_PORT)
    return ChromiumPage(co)


def is_logged_in(page) -> bool:
    """改版后健壮判定: 头部无「登录 / 注册」∨ 出现「退出」."""
    try:
        head = (page.ele("tag:body").text or "")[:300]
    except Exception:
        return False
    return ("登录 / 注册" not in head) or ("退出" in head)


def password_login(page, phone: str, pwd: str) -> bool:
    """改版适配版密码登录: placeholder 子串匹配 + 勾选协议 + 弹窗内点登录."""
    try:
        page.get("https://www.djyanbao.com/index", timeout=25)
        time.sleep(3)
        page.ele("text:登录", timeout=6).click()
        time.sleep(2)
        try:                                          # 有密码 tab 则切
            page.ele("text:密码登录", timeout=3).click()
            time.sleep(1)
        except Exception:
            pass
        rc = page.run_js('''
            var vis = Array.from(document.querySelectorAll('input')).filter(
                function(i) { return i.offsetParent !== null && i.type !== 'checkbox'; });
            var p = null, w = null;
            for (var inp of vis) {
                var ph = inp.getAttribute('placeholder') || '';
                if (ph.indexOf('手机号') >= 0 || ph.indexOf('手机号码') >= 0) p = inp;
                if (ph.indexOf('密码') >= 0) w = inp;
            }
            if (!p || !w) return 'FAIL:inputs';
            p.focus(); p.value = arguments[0];
            p.dispatchEvent(new Event('input', {bubbles: true}));
            w.focus(); w.value = arguments[1];
            w.dispatchEvent(new Event('input', {bubbles: true}));
            var n = 0;
            document.querySelectorAll('.el-checkbox,[class*=checkbox],input[type=checkbox]')
                .forEach(function(c) {
                    if (c.offsetParent !== null) {
                        var inp = c.matches('input') ? c : c.querySelector('input');
                        if (inp && !inp.checked) { c.click(); n++; }
                    }
                });
            return 'OK:ticked=' + n;''', phone, pwd)
        if "FAIL" in str(rc):
            print(f"[djyanbao] 登录框定位失败: {rc}")
            return False
        page.run_js('''
            var btns = document.querySelectorAll('button');
            for (var b of btns) {                   // 改版后按钮全页直挂, 无 dialog 容器
                var t = (b.textContent || '').trim();
                if ((t === '立即登录' || t === '登录' || t === '登 录')
                        && b.offsetParent !== null) { b.click(); return 'clicked:' + t; }
            }
            var els = document.querySelectorAll('span,a,div');
            for (var el of els) {                   // 兜底: 旧版 dialog 内登录钮
                var t2 = (el.textContent || '').trim();
                if ((t2 === '登录' || t2 === '登 录') && el.offsetParent !== null
                        && (el.closest('.el-dialog') || el.closest('[class*=dialog]')
                            || el.closest('[class*=modal]'))) { el.click(); return; }
            }''')
        time.sleep(8)
        page.get("https://www.djyanbao.com/index", timeout=15)
        time.sleep(3)
        return is_logged_in(page)
    except Exception as e:
        print(f"[djyanbao] 密码登录异常: {str(e)[:80]}")
        return False


def ensure_login(page, login_wait: int) -> bool:
    """密码优先, 回退扫码 (交互式运行时用户可用 APP 扫码)."""
    if is_logged_in(page):
        print("[djyanbao] 已登录 (profile 会话复用)")
        return True
    creds = read_creds()
    if creds and password_login(page, *creds):
        print("[djyanbao] 密码登录成功")
        return True
    print(f"[djyanbao] 密码登录未成会话; 请用「洞见研报」APP 扫码 "
          f"(等待 {login_wait}s, 非交互运行请 Ctrl-C)...")
    deadline = time.time() + login_wait
    while time.time() < deadline:
        time.sleep(5)
        if is_logged_in(page):
            print("[djyanbao] 扫码登录成功")
            return True
    return False


def face_hit(query: str, text: str) -> bool:
    """面词门: 文本命中检索词任一 ≥2 字子词 (djyanbao 按 query 召回的兜底)."""
    toks = [t for t in re.split(r"[\s/]+", query) if len(t) >= 2]
    return any(t in text for t in toks) if toks else False


def search_cards(page, query: str) -> list:
    """检索页取原始卡片 (类型门+双重门在 harvest 循环里做)."""
    page.get(f"{BASE_URL}&q={quote(query)}")
    try:
        page.ele("text:下载", timeout=15)
    except Exception:
        pass                                          # 渲染慢/无结果, 下行如实报
    time.sleep(2)
    body = page.ele("tag:body").text or ""
    if "研报加载失败" in body[:400]:
        print(f"  [djyanbao] '{query}' 列表 API 拒载 (需登录/风控)")
        return []
    try:
        return page.eles('xpath://div[contains(@class,"report-list")]/div',
                         timeout=5)
    except Exception:
        return []


def card_detail_url(card) -> str:
    """从卡片取详情链接 (href 含 detail/infoid/report)."""
    try:
        for a in card.eles("tag:a"):
            h = a.link_href or ""
            if any(k in h for k in ("detail", "infoid")) or h.rstrip("/").endswith(
                    ("/report", "djyanbao.com/report")):
                return h
    except Exception:
        pass
    return ""


def scrape_detail(page, url: str) -> dict:
    """详情页: 标题(h1) + 摘要/正文可读部分 (body 文本去导航噪声)."""
    page.get(url)
    time.sleep(3)
    title = ""
    try:
        h1 = page.ele("tag:h1", timeout=3)
        title = (h1.text or "").strip() if h1 else ""
    except Exception:
        pass
    body = ""
    try:
        body = (page.ele("tag:body").text or "").strip()
    except Exception:
        pass
    # 去首尾导航/页脚噪声: 取「简介/摘要/报告」标记后的主体段
    m = re.search(r"(简介|摘要|报告信息|正文)", body)
    if m and m.start() < len(body) // 3:
        body = body[m.start():]
    for tail in ("扫码添加客服", "商务合作、企业采购", "© 20", "隐私政策"):
        i = body.find(tail)
        if i > 300:
            body = body[:i]
            break
    return {"title": title, "text": body.strip(), "url": url}


def run(cid: str, per_query: int = 3, max_total: int = 12,
        login_wait: int = 45, dry: bool = False) -> int:
    out_dir = REPO / "data" / "harvest" / "djyanbao" / cid
    out_dir.mkdir(parents=True, exist_ok=True)
    page = create_page(out_dir)
    records: list[dict] = []
    stats = {"queries": 0, "cards": 0, "skip_type": 0, "skip_gate": 0,
             "skip_short": 0, "skip_nolink": 0, "saved": 0}
    seen_titles: set[str] = set()
    try:
        page.get(BASE_URL, timeout=30)
        time.sleep(2)
        if not ensure_login(page, login_wait):
            print("[djyanbao] BLOCKER: 登录未成会话 (改版后密码流被风控/"
                  "验证码挡下, 扫码超时) — 按纪律收兵, 0 件")
            return 1
        for q, eei in PLAN:
            if stats["saved"] >= max_total:
                break
            stats["queries"] += 1
            cards = search_cards(page, q)
            stats["cards"] += len(cards)
            got = 0
            for card in cards:
                if got >= per_query or stats["saved"] >= max_total:
                    break
                try:
                    text = card.text or ""
                except Exception:
                    continue
                if not (20 < len(text) < 5000):
                    continue
                title = text.split("\n")[0][:60]
                if any(kw in text for kw in SKIP_TYPE_KEYWORDS):
                    stats["skip_type"] += 1
                    continue
                if not (face_hit(q, title + text) and DOMAIN_RE.search(title + text)):
                    stats["skip_gate"] += 1
                    continue
                if title[:30] in seen_titles:
                    continue
                url = card_detail_url(card)
                if not url:
                    stats["skip_nolink"] += 1
                    continue
                seen_titles.add(title[:30])
                det = scrape_detail(page, url)
                body = det["text"]
                if len(body) < 300:                   # 摘要+正文可读部分门槛
                    stats["skip_short"] += 1
                    continue
                fname = re.sub(r"[^\w一-鿿-]+", "_",
                               det["title"] or title)[:50] + ".md"
                fp = out_dir / fname
                md = (f"# {det['title'] or title}\n\n"
                      f"> 来源: 洞见研报 ({url})\n"
                      f"> engine: djyanbao:vip | tree: {eei} | cred: research"
                      f" | harvested: {time.strftime('%Y-%m-%d')}\n\n"
                      f"## 检索命中\n\n关键词「{q}」命中卡片: "
                      f"{text[:200].replace(chr(10), ' ')}\n\n"
                      f"## 详情页可读内容\n\n{body}\n")
                if dry:
                    print(f"  [dry] {eei} {fname[:52]} ({len(body)}字)")
                else:
                    fp.write_text(md, encoding="utf-8")
                    records.append({"file": str(fp), "url": url,
                                    "engine": "djyanbao:vip",
                                    "tree": eei, "cred": "research"})
                stats["saved"] += 1
                got += 1
                time.sleep(3)                         # 反检测礼貌间隔
            print(f"[djyanbao] '{q}' → 卡片 {len(cards)} | 累计 saved "
                  f"{stats['saved']}")
        if not dry and records:
            (out_dir / "records.jsonl").write_text(
                "\n".join(json.dumps(r, ensure_ascii=False) for r in records),
                encoding="utf-8")
        print(f"[djyanbao] {'DRY' if dry else 'APPLY'}: 查询 {stats['queries']} "
              f"| 卡片 {stats['cards']} | 类型跳 {stats['skip_type']} | "
              f"域门跳 {stats['skip_gate']} | 短文跳 {stats['skip_short']} | "
              f"无链跳 {stats['skip_nolink']} | 落件 {stats['saved']}")
        return 0 if (stats["saved"] > 0 or dry) else 1
    finally:
        try:
            page.quit()
        except Exception:
            pass


def main() -> int:
    ap = argparse.ArgumentParser(description="洞见研报收割腿 (C djyanbao 渠道)")
    ap.add_argument("--campaign", default="EPC-BID26")
    ap.add_argument("--per-query", type=int, default=3)
    ap.add_argument("--max-total", type=int, default=12)
    ap.add_argument("--login-wait", type=int, default=45)
    ap.add_argument("--dry", action="store_true")
    ns = ap.parse_args()
    return run(ns.campaign, ns.per_query, ns.max_total, ns.login_wait, ns.dry)


if __name__ == "__main__":
    sys.exit(main())
