# -*- coding: utf-8 -*-
"""B2 行业话术命名（轴③）测试——INDUSTRY_TALK 四域话术表 + humanize 纯函数。

判据对应（任务书四项逐条在案）：
  ① 映射命中：四域全键精确命中（一条不漏）+ 任务书给定三例（堤防 防洪/砼/
     尽调）逐字复刻；
  ② 未命中原样：无关名/兜底簇名/空名/None 域/域解析不出/跨域键/两字泛词
     包含不触发——一律原样返回（零造假不硬翻）；
  ③ 四域各抽验：每域精确 + 包含（键长≥3 最长优先）+ 自由文本域解析三类；
  ④ 幂等：humanize(humanize(n, d), d) == humanize(n, d)——值域不动点兜底，
     全键+全值+包含/透传样例逐一核。

表体例体检（人工高质量表自身也要过门）：每域 30-50 条、键值非空、键≠值、
值∩键=∅（防值二次命中键破坏幂等）。
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))  # kb_factory/ 入 sys.path

from catalog_engine import industry_lexicon as il              # noqa: E402

DOMAINS = ("水利", "工程", "律所", "财务")


# ── 表体例体检 ────────────────────────────────────────────────────────────

def test_table_shape_four_domains_30_to_50():
    """四域齐备、每域 30-50 条、键值非空字符串、键≠值、值∩键=∅。"""
    assert set(il.INDUSTRY_TALK) == set(DOMAINS)
    for dom in DOMAINS:
        table = il.INDUSTRY_TALK[dom]
        assert 30 <= len(table) <= 50, f"{dom} 实测 {len(table)} 条，不在 30-50"
        for k, v in table.items():
            assert isinstance(k, str) and k.strip(), f"{dom} 空键"
            assert isinstance(v, str) and v.strip(), f"{dom}/{k} 空值"
            assert k != v, f"{dom} 自映射: {k}"
        assert not (set(table.values()) & set(table)), \
            f"{dom} 值撞键（值二次命中键会破坏幂等）"


# ── ① 映射命中 ───────────────────────────────────────────────────────────

def test_given_examples_verbatim():
    """任务书给定三例逐字复刻（点睛件验收锚，不许改写措辞）。"""
    assert il.humanize("堤防 防洪", "水利") == "堤防与河道整治"
    assert il.humanize("砼", "水利") == "混凝土工程实务"
    assert il.humanize("尽调", "律所") == "尽职调查实务"


def test_exact_hit_every_key_every_domain():
    """映射命中：四域全键精确命中。"""
    for dom in DOMAINS:
        for k, v in il.INDUSTRY_TALK[dom].items():
            got = il.humanize(k, dom)
            assert got == v, f"{dom}/{k}: 期望 {v}，实得 {got}"


# ── ② 未命中原样 ─────────────────────────────────────────────────────────

def test_passthrough_when_no_mapping():
    """未命中原样：无关名/兜底簇名/空名/None/域解析不出/跨域键/泛词包含。"""
    assert il.humanize("量子纠缠科普读物", "水利") == "量子纠缠科普读物"
    assert il.humanize("综合资料", "工程") == "综合资料"       # 兜底簇名禁改写
    assert il.humanize("办公室绿植养护手册", "水利") == "办公室绿植养护手册"
    assert il.humanize("", "水利") == ""
    assert il.humanize("防洪", None) == "防洪"                 # None 域 → 原样
    assert il.humanize("防洪", "美食烹饪") == "防洪"            # 域解析不出 → 原样
    assert il.humanize("诉讼", "财务") == "诉讼"                # 键在律所不在财务（域隔离）
    # 两字泛词只吃精确命中：包含不触发（防泛词吞改长主题名）
    assert il.humanize("防汛物资储备调度", "水利") == "防汛物资储备调度"


# ── ③ 四域各抽验 ─────────────────────────────────────────────────────────

def test_sampling_water_domain():
    """水利抽验：精确 + 包含（表序优先）+ 自由文本域解析。"""
    assert il.humanize("水利水电", "水利") == "水利水电工程建设实务"
    # 等长键（水利水电/水利工程 各 4 字）取先入表者——表序即人工优先级
    assert il.humanize("水利水电工程", "水利") == "水利水电工程建设实务"
    assert il.humanize("水库移民安置规划", "水利") == "水库移民安置规划与后期扶持"
    assert il.humanize("水土保持方案", "水利") == "水土保持方案编制与设施验收"
    assert il.humanize("砼", "水利水电施工知识库") == "混凝土工程实务"  # 别名域解析


def test_sampling_engineering_domain():
    """工程抽验：EPC 精确 + 造价/隐蔽工程包含 + epc 别名域解析。"""
    assert il.humanize("EPC", "工程") == "EPC工程总承包项目实务"
    assert il.humanize("工程造价", "工程") == "工程造价计价与控制实务"
    assert il.humanize("隐蔽工程验收记录", "工程") == "隐蔽工程验收与影像留证实务"
    assert il.humanize("清单", "EPC工程公司知识库") == "工程量清单编制与计价实务"


def test_sampling_law_domain():
    """律所抽验：全称键 + 包含 + 律所别名域解析。"""
    assert il.humanize("尽职调查", "律所") == "尽职调查实务"
    assert il.humanize("劳动争议纠纷处理", "律所") == "劳动争议仲裁与诉讼应对实务"
    assert il.humanize("个人信息保护", "律所") == "个人信息保护与跨境传输实务"
    assert il.humanize("尽调", "律师事务所知识库") == "尽职调查实务"


def test_sampling_finance_domain():
    """财务抽验：税项精确 + 包含 + 会计别名域解析。"""
    assert il.humanize("增值税", "财务") == "增值税实务与发票管理"
    assert il.humanize("所得税汇算", "财务") == "企业所得税汇算清缴实务"
    assert il.humanize("股权激励方案", "财务") == "股权激励计划与财税处理实务"
    assert il.humanize("内控", "会计师事务所知识库") == "内部控制体系建设与评价实务"


def test_domain_resolution_order():
    """域解析序：水利殿前工程殿后——「水利EPC工程」归水利不归工程。"""
    assert il.resolve_domain("水利EPC工程") == "水利"
    assert il.resolve_domain("工程实务知识库") == "工程"
    assert il.resolve_domain("律师事务所知识库") == "律所"
    assert il.resolve_domain("会计师事务所") == "财务"
    assert il.resolve_domain("民间剪纸纹样库") is None          # 域外如实解析不出
    # 落到水利 → 只用水利表（「清单」是工程表键 → 原样，域隔离不串桌）
    assert il.humanize("清单", "水利EPC工程") == "清单"


# ── ④ 幂等 ───────────────────────────────────────────────────────────────

def test_idempotent_all():
    """幂等：全键+全值+包含/透传样例，二次施用不再变化（值域不动点兜底）。"""
    samples = {
        "水利": ["水利水电工程", "水库移民安置规划", "混凝土工程实务",
                 "综合资料", "防汛物资储备调度"],
        "工程": ["工程造价审计", "隐蔽工程验收记录", "EPC工程总承包项目实务",
                 "基坑降水方案"],
        "律所": ["尽职调查清单", "劳动争议仲裁", "尽职调查实务", "婚姻家事调解"],
        "财务": ["所得税汇算清缴", "股权激励方案", "尽职调查实务", "预算执行分析"],
    }
    for dom in DOMAINS:
        names = (list(il.INDUSTRY_TALK[dom]) + list(il.INDUSTRY_TALK[dom].values())
                 + samples[dom])
        for n in names:
            once = il.humanize(n, dom)
            twice = il.humanize(once, dom)
            assert twice == once, f"{dom}/{n} 不幂等: 一次={once} 二次={twice}"


if __name__ == "__main__":
    fns = [test_table_shape_four_domains_30_to_50, test_given_examples_verbatim,
           test_exact_hit_every_key_every_domain, test_passthrough_when_no_mapping,
           test_sampling_water_domain, test_sampling_engineering_domain,
           test_sampling_law_domain, test_sampling_finance_domain,
           test_domain_resolution_order, test_idempotent_all]
    for fn in fns:
        fn()
        print(f"  PASS {fn.__name__}")
    print("ALL PASS")
