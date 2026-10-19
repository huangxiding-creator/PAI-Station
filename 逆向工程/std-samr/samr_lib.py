# -*- coding: utf-8 -*-
"""
std.samr.gov.cn / openstd.samr.gov.cn 国标全文公开系统 客户端库
==============================================================
逆向结论 (2026-10-19, 全链实测):
1) 检索: GET https://std.samr.gov.cn/gb/search/gbQueryPage
   ?searchText=&ics=<中文全称>&state=G_STATE:"现行"&ISSUE_DATE=&pageNumber=&pageSize=
   - 免登录免Cookie, JSON 返回, pageSize 最大实测 500, 全库 79826 件
   - state 多值: G_STATE:"现行",G_STATE:"废止" (数组 toString)
   - ISSUE_DATE: -1/-3/-6/-12/-24/-36 (月)
   - ICS 40 个一级类目, 参数=类目全文如 "43.道路车辆工程"
2) 详情: GET /gb/search/gbDetailed?id=<ID> -> 页面内硬编码 hcno (openstd 阅读器ID)
3) 阅读器: openstd.samr.gov.cn
   - 先 GET /bzgk/std/newGbInfo?hcno= (拿 JSESSIONID)
   - 再 GET /bzgk/std/showGb?type=online&hcno= (必须带 newGbInfo 的 Referer, 否则弹回)
   - 静态HTML含全部页div: <div id=N class=page style="width:Wpx;height:Hpx" bg="TOKEN">
     内含 span 拼图: class=pdfImg-{L}-{T} => 目标位 (L*10%, T*10%)
     style=background-position:{-X}px {-Y}px => 源图内位置 (瓦片 232x328)
   - 分块大图: GET /bzgk/std/viewGbImg?fileName=TOKEN
     !!反爬闸门: 必须带头 "Cache-Alive: chunked" 否则 302->静态直链返回0字节
     返回整块 webp (2320 宽, 高度=行数*328), 每块覆盖约4-5页
4) 重组: 按 span 映射把瓦片贴回页画布 -> 每页 PNG -> 合成 PDF
5) 原生PDF: showGb?type=download -> viewGb?hcno= (多数标准无下载按钮, 预览即全量)

铁律: 数字零造假 —— 一切计数/成败以实际落盘为准。
"""
import json
import os
import random
import re
import time
from io import BytesIO

import requests

BASE_STD = "https://std.samr.gov.cn"
BASE_OPEN = "https://openstd.samr.gov.cn"

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36")

# 40 个 ICS 一级类目 (从 gbQuery 页面左栏提取)
ICS_CATEGORIES = [
    "01.综合、术语学、标准化、文献", "03.社会学、服务、公司（企业）的组织和管理、行政、运输",
    "07.数学、自然科学", "11.医药卫生技术", "13.环保、保健和安全",
    "17.计量学和测量、物理现象", "19.试验", "21.机械系统和通用件",
    "23.流体系统和通用件", "25.机械制造", "27.能源和热传导工程", "29.电气工程",
    "31.电子学", "35.信息技术、办公机械", "37.成像技术", "39.精密机械、珠宝",
    "43.道路车辆工程", "45.铁路工程", "47.造船和海上构筑物", "49.航空器和航天器工程",
    "53.材料储运设备", "55.货物的包装和调运", "59.纺织和皮革技术", "61.服装工业",
    "65.农业", "67.食品技术", "71.化工技术", "73.采矿和矿产品",
    "75.石油及相关技术", "77.冶金", "79.木材技术", "81.玻璃和陶瓷工业",
    "83.橡胶和塑料工业", "85.造纸技术", "87.涂料和颜料工业", "91.建筑材料和建筑物",
    "93.土木工程", "95.军事工程", "97.服务业、娱乐、体育", "99.(无标题)",
]


class SamrError(Exception):
    pass


class SamrClient:
    def __init__(self, delay=(0.4, 1.0), timeout=30, retries=3, cookie_file=None):
        self.s = requests.Session()
        self.s.headers.update({
            "User-Agent": UA,
            "Accept-Language": "zh-CN,zh;q=0.9",
        })
        self.delay = delay
        self.timeout = timeout
        self.retries = retries
        self.cookie_file = cookie_file
        if cookie_file and os.path.exists(cookie_file):
            try:
                self.s.cookies.update(requests.utils.cookiejar_from_dict(json.load(open(cookie_file, encoding="utf-8"))))
            except Exception:
                pass
        self._warmed = False

    # ---------- 基础 ----------
    def _nap(self):
        time.sleep(random.uniform(*self.delay))

    def _get(self, url, **kw):
        last = None
        for i in range(self.retries):
            try:
                r = self.s.get(url, timeout=self.timeout, **kw)
                if r.status_code == 200:
                    return r
                last = SamrError(f"HTTP {r.status_code} for {url[:90]}")
            except requests.RequestException as e:
                last = SamrError(f"net err {e}")
            time.sleep(1.5 * (i + 1))
        raise last

    def _save_cookies(self):
        if self.cookie_file:
            try:
                json.dump(requests.utils.dict_from_cookiejar(self.s.cookies), open(self.cookie_file, "w", encoding="utf-8"))
            except Exception:
                pass

    # ---------- 检索 ----------
    def search(self, text="", ics="", states=None, issue_date="", page=1, page_size=500):
        """单页检索; states: list 如 ['现行'] 或 ('现行','废止')"""
        st = ",".join(f'G_STATE:"{x}"' for x in (states or []))
        params = {
            "searchText": text, "ics": ics, "state": st,
            "ISSUE_DATE": issue_date, "pageNumber": page, "pageSize": page_size,
        }
        r = self._get(f"{BASE_STD}/gb/search/gbQueryPage", params=params,
                      headers={"Referer": f"{BASE_STD}/gb/gbQuery"})
        self._nap()
        try:
            d = r.json()
        except ValueError:
            raise SamrError("non-JSON from gbQueryPage: " + r.text[:120])
        if not isinstance(d, dict) or "rows" not in d:
            raise SamrError("unexpected gbQueryPage payload: " + str(d)[:120])
        return d

    def search_all(self, text="", ics="", states=None, issue_date="", page_size=500, on_page=None):
        """全量翻页迭代器, yield row(dict)"""
        page = 1
        while True:
            d = self.search(text, ics, states, issue_date, page, page_size)
            rows = d.get("rows") or []
            for row in rows:
                yield self._clean_row(row)
            if on_page:
                on_page(page, d.get("total", 0), len(rows))
            if page * page_size >= int(d.get("total") or 0) or not rows:
                return
            page += 1

    @staticmethod
    def _clean_row(row):
        r = dict(row)
        v = re.sub(r"</?sacinfo>", "", str(r.get("C_C_NAME", ""))).strip()
        r["C_C_NAME"] = re.sub(r"\s+", " ", v)
        return r

    def industry(self, ics, states=("现行",), issue_date=""):
        """某 ICS 行业类的全量标准清单 (list)"""
        return list(self.search_all(text="", ics=ics, states=states, issue_date=issue_date))

    @staticmethod
    def resolve_ics(query):
        """'43' / '道路' / 全名 -> 规范类目名; 多义时抛错列出候选"""
        q = str(query).strip()
        full = q if q.endswith(("工程", "文献", "术", "学", "业", "输", "验", "品", "动", "筑", "议")) and "." in q else None
        if full in ICS_CATEGORIES:
            return full
        hits = [c for c in ICS_CATEGORIES if c.split(".", 1)[0] == q or q in c]
        if len(hits) == 1:
            return hits[0]
        if not hits:
            raise SamrError(f"ICS 类目未找到: {query}; 可用: " + "; ".join(ICS_CATEGORIES))
        raise SamrError(f"ICS 类目歧义({len(hits)}个): " + "; ".join(hits))

    # ---------- 详情 ----------
    def detail(self, std_id):
        """std.samr 详情页 -> 字段+hcno"""
        r = self._get(f"{BASE_STD}/gb/search/gbDetailed", params={"id": std_id},
                      headers={"Referer": f"{BASE_STD}/gb/gbQuery"})
        html = r.text
        self._nap()
        out = {"id": std_id}
        for k, v in re.findall(r'<dt class="basicInfo-item name">\s*([^<]+?)\s*</dt>\s*<dd class="basicInfo-item value"[^>]*>\s*(.*?)\s*</dd>', html, re.S):
            out[k.strip()] = re.sub(r"\s+", " ", re.sub(r"<[^>]+>", "", v)).strip()
        m = re.search(r"newGbInfo\?hcno=([0-9A-F]{32})", html)
        out["hcno"] = m.group(1) if m else None
        out["read_url"] = f"{BASE_OPEN}/bzgk/std/newGbInfo?hcno={out['hcno']}" if out["hcno"] else None
        return out

    # ---------- 阅读器收割 ----------
    def _warm(self, hcno):
        """newGbInfo -> showGb 会话链 (Referer 闸门)"""
        if self._warmed:
            return
        info = f"{BASE_OPEN}/bzgk/std/newGbInfo?hcno={hcno}"
        self._get(info, headers={"Referer": info})
        self._nap()
        self._warmed = True
        self._save_cookies()

    def fetch_reader(self, hcno):
        """阅读器静态 HTML (含全部 token 与拼图映射)"""
        self._warm(hcno)
        url = f"{BASE_OPEN}/bzgk/std/showGb?type=online&hcno={hcno}&request_locale=zh_CN"
        r = self._get(url, headers={"Referer": f"{BASE_OPEN}/bzgk/std/newGbInfo?hcno={hcno}"})
        self._nap()
        if "viewerContainer" not in r.text or 'class="page"' not in r.text:
            raise SamrError("reader html invalid (可能无全文或被拦): " + r.text[:100])
        return r.text

    @staticmethod
    def parse_reader(html):
        """-> dict: pages=[{id,w,h,token,spans:[(L,T,sx,sy)]...}], tile=(tw,th), tokens=[...]"""
        tile_x = set(); tile_y = set()
        pages = []
        parts = re.split(r'(?=<div id="\d+" class="page")', html)
        for p in parts:
            m = re.match(r'<div id="(\d+)" class="page"([^>]*)>', p)
            if not m:
                continue
            attrs = m.group(2)
            st = dict(re.findall(r'(width|height):\s*([\d.]+)px', attrs))
            bg = re.search(r'bg="([^"]*)"', attrs)
            spans = []
            for sm in re.finditer(r'class="pdfImg-(\d+)-(\d+)"\s+style="background-position:\s*(-?\d+)px\s+(-?\d+)px', p):
                L, T, sx, sy = int(sm.group(1)), int(sm.group(2)), int(sm.group(3)), int(sm.group(4))
                spans.append((L, T, abs(sx), abs(sy)))
                tile_x.add(abs(int(sx))); tile_y.add(abs(int(sy)))
            pages.append({
                "id": int(m.group(1)),
                "w": int(float(st.get("width", 2315))),
                "h": int(float(st.get("height", 3274))),
                "token": bg.group(1) if bg else None,
                "spans": spans,
            })
        # 瓦片步长推导: x/y 偏移集合的相邻差最小值 (典型 232/328)
        def step(vals):
            vs = sorted(v for v in vals if v > 0)
            return vs[0] if vs else 232
        tokens = []
        for pg in pages:
            if pg["token"] and pg["token"] not in tokens:
                tokens.append(pg["token"])
        return {"pages": pages, "tile": (step(tile_x), step(tile_y)), "tokens": tokens}

    def fetch_chunk(self, token, tile_w=232):
        """下载分块大图 -> PIL.Image; 反爬头 Cache-Alive: chunked 是闸门"""
        url = f"{BASE_OPEN}/bzgk/std/viewGbImg?fileName={token}"
        headers = {
            "Referer": f"{BASE_OPEN}/bzgk/std/showGb",
            "Cache-Alive": "chunked",
            "Accept": "image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8",
        }
        r = self.s.get(url, timeout=120, headers=headers, allow_redirects=True)
        self._nap()
        if r.status_code != 200 or len(r.content) < 100:
            raise SamrError(f"chunk fetch failed HTTP {r.status_code} len={len(r.content)} token={token[:24]}")
        from PIL import Image
        try:
            return Image.open(BytesIO(r.content))
        except Exception as e:
            raise SamrError(f"chunk decode failed ({e}); size={len(r.content)}")
        finally:
            self._save_cookies()

    @staticmethod
    def reassemble(parsed, chunk_imgs, progress=None):
        """-> list[(page_id, PIL.Image)]; 空白页跳过"""
        from PIL import Image
        tw, th = parsed["tile"]
        # token -> chunk 按高度容纳+唯一精确匹配
        used, assign = set(), {}
        for t in parsed["tokens"]:
            spans_pages = [p for p in parsed["pages"] if p["token"] == t and p["spans"]]
            if not spans_pages:
                assign[t] = None
                continue
            need = max(max(s[3] for s in p["spans"]) + th for p in spans_pages)
            cands = [im for im in chunk_imgs if im.size[1] >= need and id(im) not in used]
            exact = [im for im in cands if im.size[1] == need]
            pick = exact[0] if exact else (cands[0] if cands else None)
            if pick is not None:
                assign[t] = pick
                used.add(id(pick))
        out = []
        for p in parsed["pages"]:
            if not p["spans"]:
                continue
            src = assign.get(p["token"])
            if src is None:
                continue
            canvas = Image.new("RGB", (p["w"], p["h"]), "white")
            cw, ch = p["w"] / 10, p["h"] / 10
            for L, T, sx, sy in p["spans"]:
                tile = src.crop((sx, sy, min(sx + tw, src.size[0]), min(sy + th, src.size[1])))
                if abs(tile.size[0] - cw) > 2 or abs(tile.size[1] - ch) > 2:
                    tile = tile.resize((int(round(cw)), int(round(ch))))
                canvas.paste(tile, (int(L * cw), int(T * ch)))
            out.append((p["id"], canvas))
            if progress:
                progress(p["id"])
        return out

    def harvest(self, hcno, out_dir, want_pdf=True, keep_pages=False, progress=None):
        """整本收割 -> PDF 路径; 返回 dict 汇总 (落盘事实)"""
        from PIL import Image
        os.makedirs(out_dir, exist_ok=True)
        html = self.fetch_reader(hcno)
        parsed = self.parse_reader(html)
        if not parsed["pages"]:
            raise SamrError("reader has no pages")
        chunks = [self.fetch_chunk(t) for t in parsed["tokens"]]
        pages = self.reassemble(parsed, chunks, progress=progress)
        if not pages:
            raise SamrError("no reassembled pages (chunks missing?)")
        pages_dir = os.path.join(out_dir, "pages")
        if keep_pages or not want_pdf:
            os.makedirs(pages_dir, exist_ok=True)
            for pid, im in pages:
                im.save(os.path.join(pages_dir, f"page_{pid:02d}.png"))
        result = {"hcno": hcno, "n_pages_html": len(parsed["pages"]),
                  "n_chunks": len(chunks), "n_pages_built": len(pages), "pdf": None}
        if want_pdf:
            pdf_path = os.path.join(out_dir, f"std_{hcno}.pdf")
            ims = [im for _, im in pages]
            ims[0].save(pdf_path, save_all=True, append_images=ims[1:], resolution=150.0, quality=82)
            result["pdf"] = pdf_path
            result["pdf_bytes"] = os.path.getsize(pdf_path)
        return result

    # ---------- 原生 PDF (机会通道) ----------
    def try_native_pdf(self, hcno):
        """有下载按钮时走 viewGb; 失败返回 None (不抛)"""
        try:
            self._warm(hcno)
            url = f"{BASE_OPEN}/bzgk/std/viewGb?hcno={hcno}"
            r = self.s.get(url, timeout=120, headers={
                "Referer": f"{BASE_OPEN}/bzgk/std/showGb?type=download&hcno={hcno}",
            }, allow_redirects=True)
            self._nap()
            if r.status_code == 200 and r.content[:4] == b"%PDF":
                return r.content
        except Exception:
            pass
        return None
