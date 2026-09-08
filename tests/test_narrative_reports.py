"""R7 T20 人生工作年报 + 三模型画像 Word 报告 + T21 减法智能。"""
import os

from paistation.learn.narrative import annual_report
from paistation.learn.subtraction import declutter_info, stop_doing_list, time_flow_microscope
from paistation.soul.word_report import profile_word_report, save_docx

METRICS = {
    "kb_docs": 120, "skill_cards": 13, "jobs_done": 200,
    "immune_rules": 5, "fsrs_reviews": 60, "adopted": 25,
    "top_topics": ["投标文件", "周报", "PDCA"],
    "hard_moments": ["跨线程 bug 攻坚", "Sign V3 逆向"],
    "year": 2026,
}


# ---- T20 年报 ----

def test_annual_report_six_chapters():
    text = annual_report(METRICS)
    for ch in ("第一章", "第六章", "启程", "归来"):
        assert ch in text
    assert "Sign V3 逆向" in text  # 高光时刻入叙事
    assert "投标文件" in text


def test_annual_report_empty_year_honest():
    text = annual_report({"year": 2026})
    assert "第一章" in text
    assert "暂无" in text or "0" in text  # 空年份不编造


def test_annual_report_fixed_structure():
    """六章固定结构（英雄之旅）：章节标题稳定可预期。"""
    titles = [line for line in annual_report(METRICS).splitlines()
              if line.startswith("第")]
    assert len(titles) == 6


# ---- 三模型画像 Word 报告 ----

def test_profile_word_report_docx(tmp_path):
    """profile facts → docx（三模型视角：事实/行为/成长）。"""
    facts = [
        {"key": "职级", "value": "总工程师", "source": "名片"},
        {"key": "常用工具", "value": "Word/IDEA", "source": "感知"},
        {"key": "成长指数", "value": "UGI 72", "source": "growth"},
    ]
    path = os.path.join(tmp_path, "profile.docx")
    doc = profile_word_report(facts, title="三模型画像报告")
    save_docx(doc, path)
    assert os.path.getsize(path) > 5000  # 真实 docx 结构

    from docx import Document
    d = Document(path)
    heads = [p.text for p in d.paragraphs if p.style.name.startswith("Heading")]
    assert any("事实" in h for h in heads)
    assert any("成长" in h for h in heads)


def test_profile_word_report_empty_facts():
    doc = profile_word_report([], title="空画像")
    from docx.document import Document as DocCls
    assert isinstance(doc, DocCls)


# ---- T21 减法智能 ----

def test_time_flow_microscope_categories():
    flow = time_flow_microscope({"WINWORD.EXE": 120, "chrome.exe": 90,
                                 "idea64.exe": 60, "wechat.exe": 30})
    assert flow["deep_work_min"] == 180  # Word+IDEA
    assert flow["distraction_min"] == 120  # chrome+wechat
    assert flow["top_distraction"] == "chrome.exe"
    assert flow["focus_ratio"] == 60  # 180/300


def test_stop_doing_list_from_low_roi():
    items = stop_doing_list([
        {"task": "每日手抄待办", "times": 30, "auto_available": True},
        {"task": "季度战略评审", "times": 4, "auto_available": False},
    ])
    assert items == ["每日手抄待办"]  # 高频+可自动化 → 停；低频要务不停


def test_stop_doing_empty_input():
    assert stop_doing_list([]) == []


def test_declutter_info_zero_read_90d():
    to_cut = declutter_info([
        {"source": "三年前行业周报", "last_read_days": 365},
        {"source": "本月规范汇编", "last_read_days": 5},
        {"source": "旧项目存档", "last_read_days": 120},
    ])
    assert "三年前行业周报" in to_cut and "旧项目存档" in to_cut
    assert "本月规范汇编" not in to_cut


def test_zero_use_features_review():
    """90 天零用功能自动进入裁撤评审（产品自减）。"""
    from paistation.learn.subtraction import zero_use_features
    feats = [{"name": "技能市场", "days_since_use": 10},
             {"name": "剪贴板感知", "days_since_use": 95},
             {"name": "注意力账本", "days_since_use": 200}]
    review = zero_use_features(feats)
    assert [f["name"] for f in review] == ["剪贴板感知", "注意力账本"]
