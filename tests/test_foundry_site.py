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
