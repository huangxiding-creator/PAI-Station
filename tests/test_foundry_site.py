# M7.4 静态站点（GitHub Pages）+ 公众号宣传文（提案 M7 §5.1/§5.4）
import json

from paistation.foundry.promo import render_promo_article
from paistation.foundry.site import build_site


def _plan_fixture():
    sections = []
    for i in range(1, 6):  # 5 节：试读 20% = 1 节全文
        sections.append({
            "title": f"1.{i} 节题{i}", "framework": "SCQA",
            "components": ["key_points", "wbs", "case"],
            "content": f"【关键点】第{i}节内容。标准化SOP；流程化泳道；数据化看板；知识化沉淀。",
            "degraded": False, "degrade_note": ""})
    return {"title": "试点 FDE 方案", "slug": "pilot-fde", "score": 82, "passed": True,
            "failures": [], "corpus_note": "语料说明：本版为降级语料。",
            "chapters": [{"title": "第1章 诊断", "framework": "OODA 循环",
                          "sections": sections}]}


def _write_plan(tmp_path, plan):
    slug_dir = tmp_path / "plans" / plan["slug"]
    slug_dir.mkdir(parents=True)
    (slug_dir / "plan.json").write_text(
        json.dumps(plan, ensure_ascii=False), encoding="utf-8")


class TestBuildSite:
    def test_site_files_created(self, tmp_path):
        _write_plan(tmp_path, _plan_fixture())
        out = build_site(str(tmp_path / "plans"), str(tmp_path / "docs"),
                         catalog={"pilot-fde": {"price": 298, "tagline": "试点旗舰"}})
        assert (tmp_path / "docs" / "index.html").exists()
        page = tmp_path / "docs" / "plans" / "pilot-fde.html"
        assert page.exists()
        assert out["plans"][0]["slug"] == "pilot-fde"

    def test_index_lists_plans(self, tmp_path):
        _write_plan(tmp_path, _plan_fixture())
        build_site(str(tmp_path / "plans"), str(tmp_path / "docs"))
        html = (tmp_path / "docs" / "index.html").read_text(encoding="utf-8")
        assert "试点 FDE 方案" in html and "82" in html

    def test_plan_page_free_preview_and_paywall(self, tmp_path):
        _write_plan(tmp_path, _plan_fixture())
        build_site(str(tmp_path / "plans"), str(tmp_path / "docs"))
        html = (tmp_path / "docs" / "plans" / "pilot-fde.html").read_text(
            encoding="utf-8")
        assert "第1节内容" in html          # 第一节全文（试读 20%）
        assert "第4节内容" not in html      # 后续节不外泄
        assert "购买后解锁" in html
        assert "购买引导" in html or "购买" in html
        assert "反馈" in html and "返钱" in html  # 反馈入口明示返钱规则
        assert "三级" in html or "目录" in html

    def test_corpus_note_shown_honestly(self, tmp_path):
        _write_plan(tmp_path, _plan_fixture())
        build_site(str(tmp_path / "plans"), str(tmp_path / "docs"))
        html = (tmp_path / "docs" / "plans" / "pilot-fde.html").read_text(
            encoding="utf-8")
        assert "语料说明" in html  # 降级如实标注，不假完成

    def test_catalog_price_on_page(self, tmp_path):
        _write_plan(tmp_path, _plan_fixture())
        build_site(str(tmp_path / "plans"), str(tmp_path / "docs"),
                   catalog={"pilot-fde": {"price": 298}})
        html = (tmp_path / "docs" / "plans" / "pilot-fde.html").read_text(
            encoding="utf-8")
        assert "298" in html


class TestWereadStyle:
    """微信读书网页版形态：侧导航书城 + 封面卡网格 + 榜单 + 推荐值标签 +
    折叠目录 + 阅读器排版控制（字号/主题/夜间）+ 笔记成果页。"""

    def test_index_sidebar_nav(self, tmp_path):
        _write_plan(tmp_path, _plan_fixture())
        build_site(str(tmp_path / "plans"), str(tmp_path / "docs"))
        html = (tmp_path / "docs" / "index.html").read_text(encoding="utf-8")
        for nav in ("书城", "书架", "笔记"):
            assert nav in html, f"侧导航缺: {nav}"

    def test_index_cover_svg_and_ranking(self, tmp_path):
        _write_plan(tmp_path, _plan_fixture())
        build_site(str(tmp_path / "plans"), str(tmp_path / "docs"))
        html = (tmp_path / "docs" / "index.html").read_text(encoding="utf-8")
        assert "<svg" in html                    # 程序化封面（书封竖版）
        assert "试点 FDE 方案" in html           # 封面含书名
        assert "密度榜" in html                  # 榜单（真实分数排序）
        assert "No.1" in html or "第1名" in html  # 榜单名次

    def test_plan_page_recommend_percent_and_tag(self, tmp_path):
        _write_plan(tmp_path, _plan_fixture())   # fixture 82 分 → 好评如潮
        build_site(str(tmp_path / "plans"), str(tmp_path / "docs"))
        html = (tmp_path / "docs" / "plans" / "pilot-fde.html").read_text(
            encoding="utf-8")
        assert "推荐值" in html and "82%" in html  # 微信读书式评分表达
        assert "好评如潮" in html                   # 70-84 分档标签（真实映射）

    def test_cover_title_fits_vertical_height(self):
        """竖排书名不得溢出封面底（视觉验收实锤缺陷：12 字×15px 压住水印行）。"""
        from paistation.foundry.site import _cover_svg
        svg = _cover_svg("超长书名" * 6, 78, "x")   # 24 字 → 截 14 字防溢出
        assert "超长书名" * 3 in svg            # 前 12 字保留
        assert "超长书名" * 4 not in svg        # 16+ 字不出现（截断生效）
        short = _cover_svg("短名", 85, "y")
        assert 'font-size="13"' in short       # 短书名用满 13px
        edge = _cover_svg("工程总承包（EPC）行业 AI 转型 FDE 实施方案", 68, "epc")
        assert "行业 A" not in edge            # 末尾孤立西文回退到汉字边界

    def test_rating_tag_masterpiece_threshold(self):
        from paistation.foundry.site import rating_tag
        assert rating_tag(90) == "神作"
        assert rating_tag(85) == "神作"
        assert rating_tag(84) == "好评如潮"
        assert rating_tag(70) == "好评如潮"
        assert rating_tag(69) == "值得一读"
        assert rating_tag(60) == "值得一读"

    def test_plan_page_folded_toc(self, tmp_path):
        _write_plan(tmp_path, _plan_fixture())
        build_site(str(tmp_path / "plans"), str(tmp_path / "docs"))
        html = (tmp_path / "docs" / "plans" / "pilot-fde.html").read_text(
            encoding="utf-8")
        assert "<details" in html                # 章节折叠目录

    def test_plan_page_reader_controls(self, tmp_path):
        _write_plan(tmp_path, _plan_fixture())
        build_site(str(tmp_path / "plans"), str(tmp_path / "docs"))
        html = (tmp_path / "docs" / "plans" / "pilot-fde.html").read_text(
            encoding="utf-8")
        assert "字号" in html and "夜间" in html   # A+/A- 与夜间模式
        assert "localStorage" in html             # 阅读偏好本机记忆
        # A± 首点 bug 回归锚：内联字号为空时必须回退计算样式（否则 NaNpx 非法被忽略）
        assert "getComputedStyle(R).fontSize" in html

    def test_works_page_created(self, tmp_path):
        _write_plan(tmp_path, _plan_fixture())
        works = [{"type": "技能卡", "title": "混沌学园技能卡总览",
                  "desc": "13 张蒸馏卡", "content": "# 总览\n\n- 卡1"}]
        build_site(str(tmp_path / "plans"), str(tmp_path / "docs"), works=works)
        page = tmp_path / "docs" / "works.html"
        assert page.exists()
        html = page.read_text(encoding="utf-8")
        assert "技能卡" in html and "混沌学园技能卡总览" in html
        assert (tmp_path / "docs" / "works" / "w0.html").exists()  # 成果详情页



class TestPromo:
    def test_promo_article_structure(self):
        md = render_promo_article(_plan_fixture(), price=298)
        for must in ("推荐序", "为什么值得", "目录", "298", "第1章 诊断", "试读"):
            assert must in md, f"宣传文缺要素: {must}"

    def test_promo_hides_paid_content(self):
        md = render_promo_article(_plan_fixture(), price=298)
        assert "第4节内容" not in md  # 宣传文只给目录与试读，不泄正文

    def test_promo_corpus_note(self):
        md = render_promo_article(_plan_fixture(), price=298)
        assert "语料说明" in md

    def test_promo_preview_cuts_at_paragraph_boundary(self):
        """试读截断必须落在完整段落边界——不悬空半句/半个加粗符。"""
        plan = _plan_fixture()
        plan["chapters"][0]["sections"][0]["content"] = (
            "第一段完整内容END1。\n\n第二段完整内容END2。\n\n" + "丙" * 2000)
        md = render_promo_article(plan, price=298)
        assert "END2" in md          # 完整段落保留
        assert "丙" not in md        # 被截断的残段整段舍弃，不留悬空字符
