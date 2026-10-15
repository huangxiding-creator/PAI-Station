# -*- coding: utf-8 -*-
"""density_gate 章级密度门单测 (T-012R / REQ-014.AC1, REQ-013 参考).

覆盖: 高冗余文本打回 / slop 堆砌打回 / 正常技术文本通过 / 阈值 json 热改 /
打回记录落账字段 / 四指标报告键齐 / slop 规则 ≥12 条 / 真章(黄金样板)集成冒烟.
"""
import json
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import density_gate as dg                                     # noqa: E402


# ---------------------------------------------------------------- 夹具文本
REP_SENT = "湖南省二〇二四年基建投资同比增长百分之八点五，其中EPC总承包模式渗透率持续提升。"
REDUNDANT_MD = "# 重复章\n\n" + REP_SENT * 50

SLOP_MD = "\n".join([
    "值得注意的是，湖南省的EPC市场正在快速发展。",
    "综上所述，投资策略应当聚焦区域龙头设计院。",
    "众所周知，中部的基建投资一直保持高位。",
    "不难发现，EPC模式的渗透率在逐年提升。",
    "由此可见，联合体投标成为主流趋势。",
    "总而言之，湖南省市场机会与风险并存。",
    "显而易见，本地化团队具备显著优势。",
    "毋庸置疑，数字化管理是未来方向。",
    "与此同时，供应链能力也为项目赋能。",
    "不难看出，融资渠道决定项目落地速度。",
    "毋宁说，这一打法沉淀为可复制的抓手。",
    "众所周知，人才梯队建设是长久之计。",
    "显而易见，风控体系为项目保驾护航。",
    "综上所述，湖南市场值得重点布局。",
    "值得注意的是，政策红利仍在持续释放。",
])

NORMAL_MD = "\n".join([
    "# 湖南EPC市场技术底账",
    "湖南省2024年固定资产投资同比增长8.5%，基础设施投资占比35%，EPC合同金额约4300亿元。",
    "设计院牵头的大型EPC项目中标率较传统DBB模式高出12个百分点，受益于设计施工一体化交付。",
    "水电八局2024年新签合同额突破580亿元，海外订单占比31%，集中在东南亚水电与光伏项目。",
    "长沙轨道交通6号线延长线采用PPP+EPC双模式招标，施工周期压缩至42个月，较概算节约7.8%。",
    "常德市洞庭湖生态治理一期工程总投资96亿元，包含堤防加固、泵站改造与智慧水务三个标段。",
    "湖南省装配式建筑新开工面积占比达41%，预制混凝土构件产能利用率78%，价格较现浇溢价5%。",
    "中联重科智能塔吊在EPC工地的渗透率达23%，设备联网率91%，故障响应时间缩短至4小时。",
    "岳阳乙烯项目裂解装置采用固定总价合同，业主预留7%不可预见费，实际结算核减率3.2%。",
    "株洲轨道交通产业链本地配套率达67%，牵引系统与制动系统国产化率均超过92%。",
    "郴州锂电产业园一期EPC总承包由湖南建投集团中标，金额38.6亿元，工期要求540天。",
    "衡阳特高压换流站土建标段采用装配式围墙，减少现场湿作业83%，工期缩短26天。",
    "湘潭大学城污水管网改造项目运用CCTV检测机器人复核，发现隐蔽缺陷点214处。",
    "益阳南县高标准农田建设投资强度达每亩4200元，节水灌溉覆盖率提升至85%。",
    "永州涔天河水库灌区工程概算调整幅度4.1%，调概程序历经三次评审方获省发改委批复。",
    "怀化芷江机场改扩建项目航站楼钢结构吊装误差控制在3毫米内，采用BIM预拼装技术。",
    "娄底钢铁渣综合利用项目吨渣处理电耗降至38千瓦时，金属回收率提高6个百分点。",
    "张家界景区索道更换工程在冬季停运窗口期内完成，单日最大吊装重量达46吨。",
    "湘西州农村公路提质改造采用县域打包EPC，标段数量从17个压缩至4个，管理费率降2.3%。",
    "邵阳犬木塘水库工程灌区骨干渠系贯通，可灌溉农田86万亩，年增产粮食约9万吨。",
    "湖南工商大学数据中心PUE从1.62降至1.31，冷通道封闭改造投资回收期2.8年。",
])

BLUEBOOK_HUNAN = Path(
    r"E:\AI-Station\_proposals\flagship-paid-report-1007\bluebook\vol3\3-1-hunan.md")


# ---------------------------------------------------------------- 指标层
def test_metrics_report_keys():
    m = dg.metrics(NORMAL_MD)
    for key in ("cjk_chars", "redundancy_ratio", "new_ngram_rate",
                "slop_hits", "slop_density_per_kchar"):
        assert key in m, f"四指标报告缺 {key}"
    assert 0.0 <= m["redundancy_ratio"] <= 1.0
    assert 0.0 <= m["new_ngram_rate"] <= 1.0


def test_slop_patterns_at_least_12():
    assert len(dg.SLOP_PATTERNS) >= 12
    assert any(name == "赋能" for name, _ in dg.SLOP_PATTERNS)
    assert any(name == "抓手" for name, _ in dg.SLOP_PATTERNS)


# ---------------------------------------------------------------- 判定层
def test_redundant_text_rejected():
    v = dg.chapter_verdict(REDUNDANT_MD, "精编", reject_log=False)
    assert v["verdict"] == "reject"
    rules = [f["rule"] for f in v["failed"]]
    assert "redundancy_ratio_max" in rules
    assert v["metrics"]["redundancy_ratio"] > 0.65


def test_slop_text_rejected():
    v = dg.chapter_verdict(SLOP_MD, "精编", reject_log=False)
    assert v["verdict"] == "reject"
    rules = [f["rule"] for f in v["failed"]]
    assert "slop_density_per_kchar_max" in rules
    assert v["metrics"]["slop_hits"] >= 12


def test_normal_technical_text_passes():
    v = dg.chapter_verdict(NORMAL_MD, "精编", reject_log=False)
    assert v["verdict"] == "pass", v["failed"]
    # REQ-013: 章字数带降为参考值 (不参与判定, 仅随报告携带)
    ref = v["char_count_reference"]
    assert ref["floor_per_type"] == 3000 and "参考" in ref["note"]


def test_thresholds_json_hot_reload(tmp_path):
    """阈值 json 现读无缓存 → 改 tmp 副本即时生效 (热改)."""
    table = json.loads(dg.DEFAULT_THRESHOLDS_PATH.read_text(encoding="utf-8"))
    loose = dict(table["thresholds"]["精编"])
    loose.update(redundancy_ratio_max=1.0, new_ngram_rate_min=0.0,
                 slop_density_per_kchar_max=1e9)
    table["thresholds"]["精编"] = loose
    p = tmp_path / "density_thresholds.json"
    p.write_text(json.dumps(table, ensure_ascii=False), encoding="utf-8")

    before = dg.chapter_verdict(REDUNDANT_MD, "精编",
                                reject_log=False)
    assert before["verdict"] == "reject"
    after = dg.chapter_verdict(REDUNDANT_MD, "精编",
                               thresholds_path=p, reject_log=False)
    assert after["verdict"] == "pass", after["failed"]


# ---------------------------------------------------------------- 落账层
def test_reject_record_appended(tmp_path):
    log = tmp_path / "density_rejects.jsonl"
    v = dg.chapter_verdict(SLOP_MD, "融合", source_file="demo/slop.md",
                           reject_log=log)
    assert v["verdict"] == "reject"
    lines = log.read_text(encoding="utf-8").strip().splitlines()
    assert len(lines) == 1
    rec = json.loads(lines[0])
    assert rec["file"] == "demo/slop.md"
    assert rec["chapter"] == "融合"
    assert set(("metrics", "verdict", "ts")) <= set(rec)
    assert rec["verdict"]["verdict"] == "reject"


def test_pass_does_not_write_reject_log(tmp_path):
    log = tmp_path / "density_rejects.jsonl"
    v = dg.chapter_verdict(NORMAL_MD, "精编", reject_log=log)
    assert v["verdict"] == "pass"
    assert not log.exists()


# ---------------------------------------------------------------- 真章集成
@pytest.mark.skipif(not BLUEBOOK_HUNAN.exists(), reason="蓝皮书真章不在本机")
def test_bluebook_golden_chapter_smoke():
    """黄金样板章 3-1-hunan.md (只读): 指标确定性锚 + 判定与当前阈值表自洽.

    1015 标定后意图更新: 临时基线时代 hunan 全过; P95 分位数标定后 hunan
    落精编 slop 尾部 (0.2966 > P95 0.22) 属设计内 — 本测不再断言必过,
    改锚两件: ①三指标历史值逐位复现 (gzip/ngram/slop 确定性); ②verdict
    与当前阈值表逐规则自洽 (任何重标定下都应成立, 防判定器与表脱钩)."""
    text = BLUEBOOK_HUNAN.read_text(encoding="utf-8")
    v = dg.chapter_verdict(text, "精编", reject_log=False)
    m = v["metrics"]
    assert m["cjk_chars"] == 6742                    # 确定性锚 (历史值)
    assert m["redundancy_ratio"] == 0.117
    assert m["new_ngram_rate"] == 0.7334
    assert m["slop_density_per_kchar"] == 0.2966
    # 判定-阈值自洽: 逐规则核对 failed 集与表一致
    th = v["thresholds_used"]
    expect_fail = []
    for mk, rk, op in (("redundancy_ratio", "redundancy_ratio_max", "max"),
                       ("new_ngram_rate", "new_ngram_rate_min", "min"),
                       ("slop_density_per_kchar", "slop_density_per_kchar_max", "max")):
        lim = th.get(rk)
        if lim is None:
            continue
        if (op == "max" and m[mk] > lim) or (op == "min" and m[mk] < lim):
            expect_fail.append(rk)
    got_fail = sorted(f["rule"] for f in v["failed"])
    assert got_fail == sorted(expect_fail)
    assert v["verdict"] == ("pass" if not expect_fail else "reject")
