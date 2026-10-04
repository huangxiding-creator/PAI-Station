# -*- coding: utf-8 -*-
"""Arc K 扩容生成器: dedup_result.json candidates → sites.py 追加块.

分类规则 (显式映射表 + 默认规则), 版权灰区 (转载/搬运下载站) 保守归
piracy_suspect (禁触登记), 影子图书馆同。审计证据随 note 保留。
"""
import json
import re
from pathlib import Path
from urllib.parse import urlparse

HERE = Path(__file__).resolve().parent

# host/path → (cat, bulk, wave, extra_note)
# 显式覆盖表 (未列出的按默认规则: github→open_repo/github_zip, 其余→portal)
MAP = {
    # -- 古典文献/公版 (classics-libraries) --
    "ctext.org": ("public_domain", "none", 0, "先秦两汉万级全文; 学术首选"),
    "gj.zdic.net": ("public_domain", "none", 0, "汉典旗下古籍频道, 公版原典"),
    "guoxue.com": ("portal", "none", 0, "十三经/古诗文老牌站, 阿里盾滑块门槛"),
    "zh.wikisource.org": ("public_domain", "api", 2, "公版原典全文; API 可批量"),
    "en.wikisource.org": ("public_domain", "api", 2, "英文公版文献全文+扫描校对双轨"),
    "zh.wikibooks.org": ("public_domain", "none", 0, "维基教科书中文, 教学读本"),
    "wikisource.org": ("public_domain", "none", 0, "维基文库多语入口"),
    "www.wikibooks.org": ("public_domain", "none", 0, "维基教科书多语入口"),
    "dl.ndl.go.jp": ("official", "none", 0, "日本国立国会图书馆, 和刻本汉籍丰富"),
    "toyo-bunko.repo.nii.ac.jp": ("official", "none", 0,
                                  "东洋文库=日本最大亚洲研究图书馆, 贵重汉籍影像"),
    "rmda.kulib.kyoto-u.ac.jp": ("official", "none", 0, "京大贵重资料(明刊本汉籍)高清公开"),
    "runeberg.org": ("public_domain", "none", 0, "北欧数字图书馆 1992 年起, 350 万页"),
    "www.zeno.org": ("public_domain", "none", 0, "德语全文库, 文学 700+ 作者"),
    "www.perseus.tufts.edu": ("public_domain", "none", 0, "希腊拉丁古典学术级全文, 古典学金标准"),
    "www.thelatinlibrary.com": ("public_domain", "none", 0, "拉丁古典全文集, 无门槛"),
    "www.aozora.gr.jp": ("public_domain", "catalog", 2, "青空文库, 日本公版文学"),
    # -- 出版社/机构官方免费层 (official-free-tiers) --
    "www.oreilly.com": ("official", "none", 0, "O'Reilly Open Books ~70 种免费整书"),
    "www.freetechbooks.com": ("official", "none", 0, "出版方授权免费 CS 书目录 1244 册"),
    "bookboon.com": ("official", "none", 0, "Freemium 教材; 改版期 404 间歇"),
    "nap.nationalacademies.org": ("official", "none", 0,
                                  "美国国家院出版, 万余报告免费(PDF 需免费账号)"),
    "www.oecd-ilibrary.org": ("official", "none", 0, "OECD 旗舰报告在线免费"),
    "www.elibrary.imf.org": ("official", "none", 0,
                             "IMF 官方: 21000+ 出版物全免费回溯 1946"),
    "www.openedition.org": ("official", "none", 0, "人文社科 HTML 全免费, PDF 限机构"),
    "openbookpublishers.com": ("official", "none", 0,
                               "剑桥非营利 OA 出版社, 300+ 种免费全格式"),
    "www.metmuseum.org": ("official", "none", 0, "大都会 MetPublications 1700+ 种免费"),
    "www.getty.edu": ("official", "none", 0, "Getty 300+ 艺术史 PDF 免费"),
    "www.biodiversitylibrary.org": ("official", "none", 0,
                                    "BHL 博物馆联盟, 20 万标题/6 千万页"),
    "librivox.org": ("public_domain", "none", 0, "公版有声书志愿总库 (有声书补角)"),
    "imslp.org": ("public_domain", "none", 0, "Petrucci 公版乐谱总库 (乐谱补角)"),
    # -- 学术 OA (academic-oa) --
    "www.doabooks.org": ("official", "none", 0, "DOAB 10.9 万 OA 书目录"),
    "www.oapen.org": ("official", "none", 0, "OAPEN OA 图书库+聚合"),
    "www.openresearchlibrary.org": ("official", "none", 0, "ORL OA 图书聚合阅读"),
    "open.umn.edu": ("official", "none", 0, "Open Textbook Library 明大教材评审库"),
    "www.oercommons.org": ("official", "none", 0, "OER Commons 教育资源聚合"),
    "www.ck12.org": ("official", "none", 0, "CK-12 FlexBook 官方免费教材"),
    "pressbooks.directory": ("official", "none", 0, "Pressbooks 全网目录"),
    "collection.bccampus.ca": ("official", "none", 0, "BCcampus 开放教育 BC 省"),
    "www.springeropen.com": ("official", "none", 0, "SpringerOpen OA 书"),
    "about.muse.jhu.edu": ("official", "none", 0, "Project MUSE OA 书子集"),
    "direct.mit.edu": ("official", "none", 0, "MIT Press Direct 开放图书"),
    "www.cornellpress.cornell.edu": ("official", "none", 0, "Cornell Open 开放书"),
    "www.openstax.org": ("official", "none", 0, "莱斯大学官方免费教材"),
    "libretexts.org": ("official", "none", 0, "加州州立系开放教材平台"),
    "www.ncbi.nlm.nih.gov": ("official", "none", 0, "NCBI Bookshelf 生医官方书架"),
    "unesdoc.unesco.org": ("official", "none", 0, "UNESDOC 官方文档库"),
    "openknowledge.worldbank.org": ("official", "none", 0, "世行公开知识库"),
    "op.europa.eu": ("official", "none", 0, "欧盟出版局"),
    "www.loc.gov": ("official", "none", 0, "美国国会图书馆 WDL 世界数字图书馆"),
    "gallica.bnf.fr": ("official", "none", 0, "法国国家图书馆 Gallica"),
    "www.europeana.eu": ("official", "none", 0, "Europeana 欧洲聚合"),
    "dp.la": ("official", "none", 0, "DPLA 美国数字公共图书馆"),
    "www.hathitrust.org": ("official", "none", 0, "HathiTrust 数字图书馆(公版全开)"),
    "read.nlc.cn": ("official", "none", 0, "国图中华古籍资源库"),
    "www.shidianguji.com": ("official", "none", 0, "识典古籍(字节+北大合作)"),
    "cadal.edu.cn": ("official", "none", 0, "CADAL 大学数字图书馆合作计划"),
    "www.cbeta.org": ("public_domain", "api", 2, "中华电子佛典 CBETA, API 现成"),
    "books.google.com": ("aggregator", "none", 0, "Google Books 索引+预览"),
    "www.jstor.org": ("login_required", "none", 0, "开放子集需免费账号"),
    # -- gap-fill 增量映射 (官网免费层遗漏站) --
    "openlibrary.org": ("public_domain", "none", 0,
                        "IA 旗下 3M 书目/240 万可借; 公版直接读"),
    "archive.org": ("public_domain", "none", 0,
                    "Internet Archive 本体, 千万级文本"),
    "musopen.org": ("public_domain", "none", 0, "公版乐谱/音乐 (类型补角)"),
    "csrc.nist.gov": ("official", "none", 0, "NIST 出版物官方库"),
    "openstd.samr.gov.cn": ("official", "none", 0,
                            "国家标准全文公开系统(市监总局, 在线阅读免费)"),
    "www.ncpssd.cn": ("official", "none", 0,
                      "国家哲学社会科学文献中心(免费期刊/图书)"),
    "freecomputerbooks.com": ("portal", "none", 0, "免费 CS 书外链目录"),
    # -- 中文发现/聚合 --
    "www.dashengpan.com": ("aggregator", "none", 0, "网盘搜索(与 pansou 同语义)"),
    "www.shukui.net": ("aggregator", "none", 0, "书葵网盘搜索"),
    "search.chongbuluo.com": ("aggregator", "none", 0, "虫部落快搜聚合"),
    "taolink.cc": ("aggregator", "none", 0, "淘链客教材/学术资源聚合"),
    "shu.baozangdh.com": ("portal", "none", 0, "电子书宝藏导航"),
    "bookfere.com": ("portal", "none", 0, "书伴: Kindle 资讯+免费书导航"),
    "www.guoxuedashi.net": ("portal", "none", 0, "国学大师网(部分付费)"),
    "www.wenshuoge.com": ("portal", "none", 0, "文硕阁公版书"),
    # -- 书源生态 (发现面) --
    "shuyuan.miaogongzi.net": ("portal", "none", 0, "公子书源在线导入站"),
    "yuedu.miaogongzi.net": ("portal", "none", 0, "喵公子阅读书源"),
    "legado.aoaostar.com": ("portal", "none", 0, "星辰书源在线订阅页"),
    "yuedu.xiu2.xyz": ("portal", "none", 0, "XIU2 书源分享站"),
    "shuyuan.yiove.com": ("portal", "none", 0, "Yiove 书源仓库"),
    # -- 版权灰区 (转载/搬运下载) → 盗版嫌疑禁触 --
    "www.banshujiang.cn": ("piracy_suspect", "none", 0, "IT 书搬运下载(版权灰区)"),
    "salttiger.com": ("piracy_suspect", "none", 0, "IT 英文书搬运+网盘(版权灰区)"),
    "www.kgbook.com": ("piracy_suspect", "none", 0, "苦瓜书盘(版权灰区)"),
    "mox.moe": ("piracy_suspect", "none", 0, "漫画 epub(灰色)"),
    # -- 影子图书馆/马甲 (审计实锤) → 禁触 --
    "annas-archive.org": ("piracy_suspect", "none", 0, "影子图书馆聚合"),
    "annas-archive.se": ("piracy_suspect", "none", 0, "同站镜像域"),
    "libgen.is": ("piracy_suspect", "none", 0, "LibGen 主域"),
    "z-library.sk": ("piracy_suspect", "none", 0, "Z-Library 轮换域"),
    "pdfdrive.com": ("piracy_suspect", "none", 0, "PDF 聚合(版权灰区重)"),
    "sobooks.net": ("piracy_suspect", "none", 0, "sobooks.cc 换域马甲(审计实锤)"),
    "zxcsme.com": ("piracy_suspect", "none", 0, "知轩藏书 ME 版=zxcs.info 马甲"),
}
# github.com 路径 → (cat, bulk, wave, extra)
GH_MAP = {
    "hehonghui/awesome-english-ebooks": ("open_repo", "github_zip", 0,
                                         "37k星; 经济学人等英语杂志每周发布, 文件实体在库"),
    "dariubs/gobooks": ("open_repo", "github_zip", 0, "Go 语言书单"),
    "jobbole/awesome-programming-books": ("open_repo", "github_zip", 0,
                                          "经典编程书单(2021 后停更)"),
    "xiu2/yuedu": ("open_repo", "github_zip", 0, "12k星阅读3.0书源仓库"),
    "aoaostar/legado": ("open_repo", "github_zip", 0, "星辰书源自用库+在线服务"),
    "wx-chevalier/awesome-books-notes": ("open_repo", "github_zip", 0,
                                         "千余本编程书 PDF+笔记(拼写已修正)"),
    "tickmao/novel": ("open_repo", "github_zip", 0, "小说书源合集"),
    "ssnangua/colortxt": ("open_repo", "github_zip", 0, "彩读书源"),
    "zgq-inc/source": ("open_repo", "github_zip", 0, "源整合"),
    "zqzess/mywebstorage": ("open_repo", "github_zip", 0, "网盘资源索引备份"),
    "liufuyou/read": ("open_repo", "github_zip", 0, "书源合集"),
    "jiwangyihao/source-j-legado": ("open_repo", "github_zip", 0, "轻小说源"),
    "zwolken/light-novel-yuedu-source": ("open_repo", "github_zip", 0, "轻小说源"),
    "shidahuilang/shuyuan-bak": ("open_repo", "github_zip", 0, "书源备份自动更新"),
    "luoyacheng/yuedu": ("open_repo", "github_zip", 0, "源和规则"),
    "chinese-poetry/chinese-poetry": ("open_repo", "github_zip", 0,
                                      "唐诗5.5万+宋诗26万+宋词2.1万 JSON 结构化语料"),
    "harborlibrary": ("piracy_suspect", "none", 0,
                      "Z-Library 备份集 org(禁触; host=github 不入 blocklist)"),
}


def host_of(u):
    h = (urlparse(u if "//" in u else "https://" + u).hostname or "").lower()
    return h[4:] if h.startswith("www.") else h


def _norm_map(m):
    """MAP 键归一: 统一剥 www 前缀 (键表混写根因)。"""
    out = {}
    for k, v in m.items():
        out[k[4:] if k.startswith("www.") else k] = v
    return out


MAP = _norm_map(MAP)


def path_of(u):
    return urlparse(u if "//" in u else "https://" + u).path.strip("/")


def sid_from(url, used):
    h = host_of(url).replace("www.", "").replace(".", "_").replace("-", "_")
    p = path_of(url).lower().strip("/")
    if host_of(url).endswith(("github.com",)):
        p = p.replace("/", "_").replace("-", "_")
        sid = re.sub(r"[^a-z0-9_]", "", (h.split("_")[0] + "_" + p))[:40]
    else:
        sid = re.sub(r"[^a-z0-9_]", "", h)[:40]
    base, i = sid, 2
    while sid in used:
        sid = f"{base}{i}"
        i += 1
    used.add(sid)
    return sid


def main():
    d = json.loads((HERE / "dedup_result.json").read_text(encoding="utf-8"))
    used = {s["id"] for s in _existing_ids()}
    lines = ["    # ---- research1004: Arc K 全网扫荡扩容 (super-skill 9角度+补扫2角度) ----"]
    cats = {}
    for c in d["candidates"] + d["piracy_suspect"]:
        url = c["url"]
        h, p = host_of(url), path_of(url)
        if h.endswith(("github.com",)) or h == "github.com":
            key = p.lower()
            cat, bulk, wave, extra = GH_MAP.get(
                key, ("open_repo", "github_zip", 0, ""))
        else:
            cat, bulk, wave, extra = MAP.get(h, ("portal", "none", 0, ""))
        name = c["name"].strip().replace('"', "'")[:30]
        note = (c.get("note") or "").strip().replace('"', "'")[:80]
        if extra:
            note = f"{extra}; {note}" if note else extra
        lang = (c.get("lang") or "mixed").split("/")[0][:8]
        sid = sid_from(url, used)
        lines.append(
            f'    _s("{sid}", "{name}", "{url}",\n'
            f'       "{cat}", "{lang}", "research1004", bulk="{bulk}", '
            f'wave={wave}, note="{note}"),')
        cats[cat] = cats.get(cat, 0) + 1
    unmapped = [c["url"] for c in d["candidates"]
                if host_of(c["url"]) not in MAP
                and "github.com" not in c["url"]]
    (HERE / "arc_k_block.py.txt").write_text(
        "\n".join(lines) + "\n", encoding="utf-8")
    print("entries:", len(lines) - 1, "cats:", cats)
    print("UNMAPPED (默认portal):", unmapped)


def _existing_ids():
    import sys
    sys.path.insert(0, str(Path(__file__).resolve().parents[3] /
                           "ResearchFactory-Eng" / "EPC100" / "collectors"))
    from ebook_library import sites as S
    return S.SITES


if __name__ == "__main__":
    main()
