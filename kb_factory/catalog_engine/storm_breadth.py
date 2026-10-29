# -*- coding: utf-8 -*-
"""STORM 多视角广度腿（v2.7 #13，巨人 stanford-oval/storm MIT——纯规则复刻）。

方法论蓝本：STORM（斯坦福 Oval）写长文前的核心洞察是「先多视角、再定提纲」——
单路检索只能看到主流视角的目录骨架，让多个角色（视角）各自独立提问检索后取
并集，才能补齐单路盲区（工程库的运维检修/涉水枢纽、财务库的审计内控等）。
本实现把 STORM 的 LLM 角色扮演 + 互联网检索 全部替换为纯规则等价物：
  LLM 视角发现 → 行业视角库 PERSPECTIVES（每行业 5-8 视角，视角=子主题关键词组）
  独立检索     → 各视角用自己的关键词组独立查本地种子/词表池（seeds/*.json +
                 taxonomy 内置 CLC/SIX/术语词表），零网络零 LLM
  提纲合并     → 编辑距离/包含关系判重合并（同义组必并）+ 两段式精修
                 （第一段按视角归并，第二段按中图法 A-Z 序重排）

入口：
  breadth_expand(domain, keywords)  多视角广度扩展 → 增强 L2 组清单 + 覆盖对比 metrics
  blend_topics(spec, base, n, st)   增强组并入既有 L2 骨架（组数/编号零漂移，只换名）
接线（engine._build_blueprint_taxonomy）：depth=pro/flagship 自动启用；
standard/None 不进本模块任何分支（零漂移）。确定性纪律：无随机源、无时钟、
无网络，同输入必同输出。
"""
from __future__ import annotations

import json
import re
from functools import lru_cache
from pathlib import Path

from . import taxonomy

__all__ = ["PERSPECTIVES", "breadth_expand", "blend_topics", "dedup_names", "same_group"]

_SEEDS_DIR = Path(__file__).resolve().parents[1] / "seeds"  # kb_factory/seeds
_MAX_NAME = 30        # 组名长度上限（与 lint.MAX_NAME_CHARS 同口径）
_DRAFT_CAP = 16       # 每视角草案组上限（防词表噪声灌顶，确定性截断）
_POOL_NAME_MAX = 12   # 池命中的组名素材长度上限（超长书名/课程名不做组名）
_USER_POOL_CAP = 3    # 需求词池命中每视角限量（防各视角草案被同一批域词灌同）

# ── 行业视角库 ─────────────────────────────────────────────────────────────
# 每行业 5-8 视角，视角=子主题关键词组（关键词既是触发词，也是检索词，
# 也是 L2 草案组名候选；行业内两两不交 → 多视角并集严格大于任意单路，
# 广度增益可量化）。clc_hint=视角学科归属（组名级中图法命中优先于 hint）。

PERSPECTIVES = {
    "law": {
        "name": "法律律所",
        "aliases": ["律师", "律所", "法律", "法务", "诉讼", "仲裁", "合规", "司法",
                    "民法典", "公司法", "法律实务"],
        "perspectives": [
            {"name": "诉讼仲裁", "clc_hint": "D",
             "keywords": ["民事诉讼", "商事仲裁", "行政争议", "刑事辩护", "庭审实务",
                          "证据规则", "强制执行", "调解和解"]},
            {"name": "合规风控", "clc_hint": "D",
             "keywords": ["企业合规", "监管处罚", "反垄断", "数据合规", "反商业贿赂",
                          "内控体系", "出口管制"]},
            {"name": "尽职调查", "clc_hint": "D",
             "keywords": ["尽职调查", "交易核查", "法律意见书", "交割文件", "目标公司审查"]},
            {"name": "知识产权", "clc_hint": "D",
             "keywords": ["专利实务", "商标注册", "著作权保护", "商业秘密", "知识产权许可",
                          "侵权判定"]},
            {"name": "劳动人事", "clc_hint": "D",
             "keywords": ["劳动合同", "劳动争议", "社保公积金", "工伤赔偿", "竞业限制",
                          "员工关系", "裁员安置"]},
            {"name": "公司商事", "clc_hint": "D",
             "keywords": ["公司治理", "股权架构", "并购重组", "投融资法律", "破产重整",
                          "股东纠纷", "章程设计"]},
            {"name": "涉外法律", "clc_hint": "D",
             "keywords": ["涉外仲裁", "跨境投资", "贸易合规", "域外送达", "外国法查明"]},
        ],
    },
    "engineering": {
        "name": "工程建设",
        "aliases": ["工程", "施工", "建筑", "水利", "水电", "水库", "大坝", "市政", "公路",
                    "铁路", "桥梁", "隧道", "EPC", "总承包", "监理", "勘察", "造价", "工地",
                    "防洪", "灌溉", "施工组织"],
        "perspectives": [
            {"name": "勘察设计", "clc_hint": "P",
             "keywords": ["工程勘察", "测绘勘测", "地质勘察", "工程设计", "枢纽布置",
                          "施工图设计", "水文计算"]},
            {"name": "施工技术", "clc_hint": "T",
             "keywords": ["施工组织设计", "基坑工程", "混凝土浇筑", "灌浆施工",
                          "土石方开挖", "隧道掘进", "施工导流"]},
            {"name": "质量验收", "clc_hint": "T",
             "keywords": ["质量验收", "单元工程验收", "分部分项验收", "竣工验收",
                          "质量检测", "实体质量", "缺陷处理"]},
            {"name": "安全环保", "clc_hint": "X",
             "keywords": ["施工安全", "安全防护", "度汛安全", "环境保护", "水土保持",
                          "文明施工", "职业健康"]},
            {"name": "运维检修", "clc_hint": "T",
             "keywords": ["运行维护", "检修维护", "大坝安全监测", "机电设备检修",
                          "闸门启闭机", "养护修理", "安全鉴定"]},
            {"name": "招投标合同", "clc_hint": "D",
             "keywords": ["招标投标", "工程合同", "总承包合同", "索赔变更", "计量支付",
                          "分包管理", "履约保函"]},
            {"name": "造价资金", "clc_hint": "F",
             "keywords": ["工程造价", "工程量清单", "概预算", "定额计价", "竣工结算",
                          "资金计划", "成本控制"]},
            {"name": "水利水电枢纽", "clc_hint": "P",
             "keywords": ["水利水电枢纽", "水库调度", "防洪调度", "灌溉排水", "水电站运行",
                          "河道整治", "水资源论证"]},
        ],
    },
    "finance": {
        "name": "财务会计",
        "aliases": ["财务", "会计", "税务", "审计", "预算", "出纳", "报表", "报销", "资金管理"],
        "perspectives": [
            {"name": "会计核算", "clc_hint": "F",
             "keywords": ["会计准则", "账务处理", "财务报表", "会计科目", "收入确认",
                          "往来核销", "合并报表"]},
            {"name": "税务管理", "clc_hint": "F",
             "keywords": ["增值税", "企业所得税", "个人所得税", "税收优惠", "发票管理",
                          "税务筹划", "汇算清缴"]},
            {"name": "资金预算", "clc_hint": "F",
             "keywords": ["全面预算", "资金计划", "现金流管理", "融资安排", "银行授信",
                          "应收应付"]},
            {"name": "审计内控", "clc_hint": "F",
             "keywords": ["内部审计", "外部审计", "内控制度", "舞弊调查", "审计整改",
                          "风险清单"]},
            {"name": "财务分析", "clc_hint": "F",
             "keywords": ["财务分析", "经营分析", "成本分析", "指标看板", "盈利预测",
                          "财务模型"]},
            {"name": "成本管理", "clc_hint": "F",
             "keywords": ["成本核算", "标准成本", "成本控制", "费用报销", "降本增效",
                          "成本分摊"]},
            {"name": "融资投资", "clc_hint": "F",
             "keywords": ["股权融资", "债权融资", "投资项目评价", "并购估值", "投后管理",
                          "财务尽职调查"]},
        ],
    },
    "medical": {
        "name": "医疗卫生",
        "aliases": ["医院", "医疗", "临床", "护理", "药学", "医师", "护士", "卫生", "诊疗",
                    "病历", "康复"],
        "perspectives": [
            {"name": "临床诊疗", "clc_hint": "R",
             "keywords": ["临床诊疗", "诊疗规范", "临床路径", "疑难病例", "多学科会诊",
                          "处方管理"]},
            {"name": "护理康复", "clc_hint": "R",
             "keywords": ["护理常规", "基础护理", "专科护理", "康复训练", "安宁疗护",
                          "护理文书"]},
            {"name": "药事管理", "clc_hint": "R",
             "keywords": ["药事管理", "合理用药", "药品调剂", "药物警戒", "抗菌药物",
                          "药品储存"]},
            {"name": "公共卫生", "clc_hint": "R",
             "keywords": ["疾病预防", "传染病防控", "健康体检", "疫苗接种", "慢病管理",
                          "健康教育"]},
            {"name": "医保支付", "clc_hint": "R",
             "keywords": ["医保政策", "医保结算", "DRG付费", "病案首页", "医保稽核",
                          "异地就医"]},
            {"name": "医院运营", "clc_hint": "R",
             "keywords": ["医院管理", "医疗质量", "院感防控", "绩效考核", "科室运营",
                          "医疗设备管理"]},
            {"name": "医患关系", "clc_hint": "R",
             "keywords": ["医患沟通", "医疗纠纷", "知情同意", "投诉处理", "医疗责任险",
                          "不良事件上报"]},
        ],
    },
    "education": {
        "name": "教育教学",
        "aliases": ["教育", "教学", "备课", "教案", "课程", "教师", "教研", "学校", "学生",
                    "中考", "高考", "义务教育"],
        "perspectives": [
            {"name": "课程教学", "clc_hint": "G",
             "keywords": ["课程标准", "教学设计", "课堂教学", "单元教学", "跨学科主题学习",
                          "作业设计"]},
            {"name": "备课教案", "clc_hint": "G",
             "keywords": ["备课资料", "教案模板", "学案设计", "课件制作", "例题精讲",
                          "实验演示"]},
            {"name": "学生发展", "clc_hint": "G",
             "keywords": ["学情分析", "培优补差", "心理健康辅导", "生涯规划", "班级管理",
                          "家校沟通"]},
            {"name": "考试评价", "clc_hint": "G",
             "keywords": ["命题研究", "考试评价", "成绩分析", "综合素质评价", "错题归因",
                          "作业批改"]},
            {"name": "教育技术", "clc_hint": "G",
             "keywords": ["教育数字化", "智慧课堂", "在线教学", "AI辅助教学", "微课制作",
                          "电子白板"]},
            {"name": "教研科研", "clc_hint": "G",
             "keywords": ["校本教研", "课题研究", "论文写作", "听评课", "集体备课",
                          "教学成果"]},
            {"name": "教师发展", "clc_hint": "G",
             "keywords": ["教师培训", "名师工作室", "青年教师培养", "师德师风",
                          "教学基本功", "班主任工作"]},
        ],
    },
    "safety": {
        "name": "安全环保EHS",
        "aliases": ["EHS", "安全生产", "安全标准化", "职业健康", "环境保护", "环保",
                    "应急管理", "消防", "危化品", "隐患排查"],
        "perspectives": [
            {"name": "风险辨识", "clc_hint": "X",
             "keywords": ["危险源辨识", "风险评估", "双重预防机制", "重大危险源",
                          "作业安全分析"]},
            {"name": "隐患排查", "clc_hint": "X",
             "keywords": ["隐患排查治理", "安全检查表", "专项检查", "整改闭环", "违章治理"]},
            {"name": "职业健康", "clc_hint": "X",
             "keywords": ["职业病防治", "劳动防护用品", "职业危害检测", "健康监护",
                          "职业病诊断"]},
            {"name": "环境保护", "clc_hint": "X",
             "keywords": ["排污许可", "环境监测", "固废管理", "环保设施", "清洁生产"]},
            {"name": "应急救援", "clc_hint": "X",
             "keywords": ["应急预案", "应急演练", "应急处置", "消防救援", "事故调查"]},
            {"name": "安全培训", "clc_hint": "X",
             "keywords": ["三级安全教育", "特种作业", "班前会", "安全文化建设",
                          "安全培训教材"]},
        ],
    },
    "ecommerce": {
        "name": "跨境电商",
        "aliases": ["跨境", "电商", "外贸", "选品", "亚马逊", "Shopify", "独立站", "海外仓"],
        "perspectives": [
            {"name": "选品开发", "clc_hint": "F",
             "keywords": ["选品策略", "产品开发", "市场调研", "供应链寻源", "样品测试"]},
            {"name": "平台运营", "clc_hint": "F",
             "keywords": ["平台运营", "Listing优化", "广告投放", "店铺绩效", "账号安全"]},
            {"name": "跨境物流", "clc_hint": "U",
             "keywords": ["跨境物流", "海外仓", "头程运输", "清关派送", "物流成本"]},
            {"name": "海关合规", "clc_hint": "D",
             "keywords": ["海关合规", "出口退税", "商品归类", "原产地规则", "贸易术语"]},
            {"name": "海外营销", "clc_hint": "F",
             "keywords": ["海外营销", "社媒推广", "网红合作", "邮件营销", "品牌出海"]},
            {"name": "客服售后", "clc_hint": "F",
             "keywords": ["跨境客服", "售后处理", "退换货", "差评管理", "多语言客服"]},
        ],
    },
    "research": {
        "name": "科研管理",
        "aliases": ["科研", "课题", "基金", "文献", "学术", "实验室", "课题组", "科研诚信"],
        "perspectives": [
            {"name": "选题立项", "clc_hint": "N",
             "keywords": ["选题论证", "项目申报", "开题报告", "立项评审", "科研计划"]},
            {"name": "文献综述", "clc_hint": "G",
             "keywords": ["文献检索", "文献管理", "综述写作", "引文规范", "数据库使用"]},
            {"name": "实验方法", "clc_hint": "N",
             "keywords": ["实验设计", "实验记录", "仪器操作", "试剂管理", "生物安全"]},
            {"name": "数据分析", "clc_hint": "O",
             "keywords": ["数据分析", "统计方法", "作图规范", "数据管理", "可重复研究"]},
            {"name": "学术写作", "clc_hint": "H",
             "keywords": ["论文写作", "投稿指南", "同行评审", "学位论文", "学术英语"]},
            {"name": "基金申报", "clc_hint": "N",
             "keywords": ["基金申报", "国家自然科学基金", "标书撰写", "经费管理", "结题验收"]},
            {"name": "科研诚信", "clc_hint": "N",
             "keywords": ["学术不端", "署名规范", "数据共享", "伦理审查", "利益冲突"]},
        ],
    },
    "projectmgmt": {
        "name": "项目管理",
        "aliases": ["项目管理", "P6", "Primavera", "进度计划", "项目经理", "项目管理知识体系"],
        "perspectives": [
            {"name": "进度计划", "clc_hint": "C",
             "keywords": ["进度计划", "网络计划", "关键路径", "进度纠偏", "P6应用"]},
            {"name": "成本控制", "clc_hint": "C",
             "keywords": ["挣值分析", "费用偏差", "成本基线", "资金曲线", "成本预警"]},
            {"name": "质量管理", "clc_hint": "C",
             "keywords": ["质量策划", "质量保证", "质量控制", "质量审核", "持续改进"]},
            {"name": "合同索赔", "clc_hint": "D",
             "keywords": ["索赔管理", "变更管理", "争议解决", "合同评审", "合同台账"]},
            {"name": "风险管理", "clc_hint": "C",
             "keywords": ["风险识别", "风险应对", "风险登记册", "定量分析", "风险监控"]},
            {"name": "干系人沟通", "clc_hint": "C",
             "keywords": ["干系人管理", "沟通计划", "会议管理", "报告体系", "冲突协调"]},
        ],
    },
    # 通用兜底：无行业命中时的 6 视角（保证任何域都有多视角并集 > 单路）
    "generic": {
        "name": "通用",
        "aliases": [],
        "perspectives": [
            {"name": "政策法规", "clc_hint": "D",
             "keywords": ["政策法规", "法律法规", "监管动态", "政策解读", "实施细则"]},
            {"name": "技术标准", "clc_hint": "T",
             "keywords": ["技术标准", "标准规范", "行业标准", "国际标准", "标准解读"]},
            {"name": "操作实务", "clc_hint": "T",
             "keywords": ["操作实务", "作业指导", "工作流程", "操作规程", "实务指引"]},
            {"name": "案例研究", "clc_hint": "Z",
             "keywords": ["案例研究", "典型案例", "案例分析", "事故复盘", "经验总结"]},
            {"name": "工具模板", "clc_hint": "Z",
             "keywords": ["工具模板", "表单模板", "文书范本", "检查清单", "计算工具"]},
            {"name": "培训学习", "clc_hint": "G",
             "keywords": ["培训学习", "培训教材", "学习路径", "考核题库", "入门导读"]},
        ],
    },
}


# ── 同义组判重（编辑距离 / 包含关系）─────────────────────────────────────

_PUNCT_RE = re.compile(r"[\s《》〈〉「」『』（）()【】\[\]、，。：:；;·—\-]+")


def _norm_name(s: str) -> str:
    return _PUNCT_RE.sub("", s or "")


def _levenshtein(a: str, b: str) -> int:
    """编辑距离（两行 DP；组名 ≤30 字，开销可忽略，零第三方依赖）。"""
    if a == b:
        return 0
    if not a or not b:
        return len(a) or len(b)
    prev = list(range(len(b) + 1))
    for i, ca in enumerate(a, 1):
        cur = [i]
        for j, cb in enumerate(b, 1):
            cur.append(min(prev[j] + 1, cur[j - 1] + 1, prev[j - 1] + (ca != cb)))
        prev = cur
    return prev[-1]


def same_group(a: str, b: str) -> bool:
    """同义组判定：规范化后 精确同串 / 包含关系（双向，双方≥2字）/
    编辑距离近邻（≤4字容差1，≥5字容差2）。纯规则，无 embedding。"""
    a, b = _norm_name(a), _norm_name(b)
    if not a or not b:
        return False
    if a == b:
        return True
    if len(a) >= 2 and len(b) >= 2 and (a in b or b in a):
        return True  # 包含关系：「质量验收」含于「质量验收管理」
    limit = 1 if max(len(a), len(b)) <= 4 else 2
    return abs(len(a) - len(b)) <= limit and _levenshtein(a, b) <= limit


def _dedup(items: list) -> tuple:
    """顺序去重（保首现）：返回 (保留序, 合并次数)。"""
    kept: list = []
    for x in items:
        if not any(same_group(x, y) for y in kept):
            kept.append(x)
    return kept, len(items) - len(kept)


def dedup_names(names: list) -> list:
    """同义组合并公开口（供测试与外部复用）。"""
    return _dedup(list(names))[0]


# ── 本地种子/词表池（零网络）──────────────────────────────────────────────

def _shared_run(a: str, b: str, n: int = 3) -> bool:
    """是否共享长度≥n 的连续子串（中文短语级重合，如「水利水电」）。"""
    if len(a) < n or len(b) < n:
        return False
    shorter, longer = (a, b) if len(a) <= len(b) else (b, a)
    return any(shorter[i: i + n] in longer for i in range(len(shorter) - n + 1))


def _hits(term: str, name: str) -> bool:
    """检索命中：包含关系（双方≥2字）或共享≥3字连串。"""
    if len(term) >= 2 and len(name) >= 2 and (term in name or name in term):
        return True
    return _shared_run(term, name, 3)


@lru_cache(maxsize=1)
def _pool() -> tuple:
    """本地词池：seeds 顶层 *.json 的全部 L2 组名 + taxonomy 内置词表
    （CLC 22 类主题组 / 工程六域 49 分组 / 扩容术语库）。
    只扫顶层 *.json——gb/、thuocl/ 等子目录由各自产线自治，不掺读；
    坏档/半写档（并发产线）宽容跳过。"""
    names: list = []
    seen: set = set()

    def add(n):
        n = (n or "").strip()
        if n and n not in seen:
            seen.add(n)
            names.append(n)

    if _SEEDS_DIR.is_dir():
        for p in sorted(_SEEDS_DIR.glob("*.json")):
            try:
                data = json.loads(p.read_text(encoding="utf-8"))
            except (OSError, ValueError):
                continue
            tree = data.get("tree") if isinstance(data, dict) else None
            for l1 in (tree or {}).get("l1") or []:
                if not isinstance(l1, dict):
                    continue
                for l2 in l1.get("l2") or []:
                    if isinstance(l2, dict):
                        add(l2.get("name"))
    for c in taxonomy.CLC_22:
        for t in c["topics"]:
            add(t)
    for v in taxonomy.SIX_DOMAINS:
        for g in v["groups"]:
            add(g)
    for t in taxonomy.EXPANSION_TERM_BANK:
        add(t)
    return tuple(names)


# ── 行业匹配与各视角独立检索 ──────────────────────────────────────────────

def _pick_industry(domain: str, keywords: list) -> tuple:
    """域级强别名打分选行业（域 3 分 / 关键词 2 分；同分先声明者胜）。
    零分 → generic 兜底。返回 (行业键, 行业配置)。"""
    kw_text = "".join(keywords)
    best_key, best_score = None, 0
    for key, ind in PERSPECTIVES.items():
        s = sum((3 if a in domain else 0) + (2 if a in kw_text else 0)
                for a in ind["aliases"])
        if s > best_score:
            best_key, best_score = key, s
    if best_key is None:
        return "generic", PERSPECTIVES["generic"]
    return best_key, PERSPECTIVES[best_key]


def _perspective_drafts(industry: dict, domain: str, keywords: list,
                        pool_names: tuple) -> dict:
    """各视角独立触发检索 → L2 草案组 {视角名: [组名,...]}。

    候选序（视角特异性优先，防需求词池命中灌顶挤掉视角素材）：
      ① 视角关键词组(+视角名) 命中的本地种子/词表池名（≤_POOL_NAME_MAX 字，
         超长的书名/课程名不做组名素材）；
      ② 视角子主题词本身即草案组（保底，任何池缺失视角仍有产出）；
      ③ 需求词(域+关键词) 命中的池名 ≤_USER_POOL_CAP 个（域上下文，
         各视角共享、跨视角去重时并掉）；
      ④ 检索过薄(<3)时 关键词×术语库 确定性合成兜底。
    每视角截断 _DRAFT_CAP。"""
    user_terms = [t for t in [domain] + list(keywords) if t]
    drafts = {}
    for p in industry["perspectives"]:
        cands: list = []
        seen: set = set()

        def add(name):
            n = (name or "").strip()
            if n and n not in seen and len(n) <= _MAX_NAME:
                seen.add(n)
                cands.append(n)

        own = list(p["keywords"]) + [p["name"]]
        for name in pool_names:  # ① 视角词 × 本地池
            if len(name) <= _POOL_NAME_MAX and any(_hits(t, name) for t in own):
                add(name)
        for kw in own:  # ② 视角自身子主题词
            add(kw)
        user_hits = [n for n in pool_names if len(n) <= _POOL_NAME_MAX
                     and any(_hits(t, n) for t in user_terms)]
        for name in user_hits[:_USER_POOL_CAP]:  # ③ 需求词池命中（限量）
            add(name)
        if len(cands) < 3:  # ④ 合成兜底
            for kw in p["keywords"][:2]:
                for term in taxonomy.EXPANSION_TERM_BANK[:2]:
                    add(f"{kw}{term}")
        drafts[p["name"]] = cands[:_DRAFT_CAP]
    return drafts


# ── 中图法归类（第二段精修的排序轴）──────────────────────────────────────

def _clc_classify(name: str):
    """组名 → 中图法类（按 CLC_22 canonical 序 A→Z 首个命中：别名包含
    优先，主题组互含次之）；未命中返回 None。"""
    n = _norm_name(name)
    if len(n) < 2:
        return None
    for c in taxonomy.CLC_22:
        for a in c["aliases"]:
            if len(a) >= 2 and a in n:
                return c
        for t in c["topics"]:
            if (t in n or n in t) and len(t) >= 2:
                return c
    return None


def _clc_by_code(code: str):
    for c in taxonomy.CLC_22:
        if c["code"] == code:
            return c
    return None


# ── 主入口：多视角广度扩展 ────────────────────────────────────────────────

def breadth_expand(domain: str, keywords) -> dict:
    """STORM 多视角广度扩展（纯规则：零 LLM、零网络，只查本地种子/词表）。

    管线：选行业 → 各视角独立检索 L2 草案 → 合并去重（同义组必并）→
    两段式精修（第一段按视角归并；第二段按中图法 A-Z 序重排，未命中殿后）。

    返回：
        industry / industry_name / perspectives（视角名清单）
        groups:   [{"name", "perspective", "clc", "clc_name"}]（中图法序）
        by_perspective: 第一段结果 [{perspective, groups:[名]}]
        metrics:  覆盖对比量化（union_groups > single_path_groups 为
                  STORM 广度增益断言口径，含 dedup_merges / seed 基线）
    """
    domain = (domain or "").strip()
    kws = [k.strip() for k in (keywords or []) if isinstance(k, str) and k.strip()]
    ind_key, industry = _pick_industry(domain, kws)
    pool_names = _pool()
    drafts = _perspective_drafts(industry, domain, kws, pool_names)

    # 每视角组内先去重；单路基准①=最强单视角的组数
    per_p = {name: _dedup(cands)[0] for name, cands in drafts.items()}
    single_path = max((len(v) for v in per_p.values()), default=0)
    # 单路基准②=仅按需求词直检本地池（现行单路 L2 选组口径）
    seed_only = _dedup([n for n in pool_names
                        if any(_hits(t, n) for t in ([domain] + kws))])[0]

    # 合并去重（跨视角，保首现视角）：flat 顺序=视角声明序 → 视角内草案序
    flat, origin = [], {}
    for p in industry["perspectives"]:
        for n in per_p[p["name"]]:
            if n not in origin:
                origin[n] = (len(flat), p["name"])
                flat.append(n)
    kept, merges = _dedup(flat)

    # 组装：视角归着 + 中图法归类（组名级命中 > 视角 clc_hint）
    hints = {p["name"]: p.get("clc_hint") for p in industry["perspectives"]}
    groups = []
    for name in kept:
        persp = origin[name][1]
        clc = _clc_classify(name) or _clc_by_code(hints.get(persp) or "")
        groups.append({"name": name, "perspective": persp,
                       "clc": clc["code"] if clc else None,
                       "clc_name": clc["name"] if clc else None})

    # 两段式精修·第一段：按视角归并（视角声明序）
    by_perspective = [{"perspective": p["name"],
                       "groups": [g["name"] for g in groups
                                  if g["perspective"] == p["name"]]}
                      for p in industry["perspectives"]]
    # 两段式精修·第二段：按中图法 A-Z 序重排（同类稳定保持 flat 序；未命中殿后）
    order = {c["code"]: i for i, c in enumerate(taxonomy.CLC_22)}
    groups.sort(key=lambda g: (order.get(g["clc"], len(order)) if g["clc"]
                               else len(order) + 1, origin[g["name"]][0]))

    metrics = {"industry": ind_key,
               "perspectives_used": len(industry["perspectives"]),
               "single_path_groups": single_path,
               "seed_only_groups": len(seed_only),
               "union_groups": len(groups),
               "breadth_gain": len(groups) - single_path,
               "dedup_merges": merges,
               "seed_pool_size": len(pool_names)}
    return {"industry": ind_key, "industry_name": industry["name"],
            "perspectives": [p["name"] for p in industry["perspectives"]],
            "groups": groups, "by_perspective": by_perspective, "metrics": metrics}


# ── 接线件：增强组并入既有 L2 骨架 ────────────────────────────────────────

def _spec_match(spec: dict, g: dict) -> bool:
    """L1 规格与增强组的相关性：中图法规格（单字母 code）直接对 clc；
    否则组名与 spec 名互含（六域等非 CLC 规格走此路，通常零命中=骨架不动）。"""
    code = spec.get("code") or ""
    if g.get("clc") and len(code) == 1 and code == g["clc"]:
        return True
    n = spec.get("name") or ""
    return bool(n) and (n in g["name"] or g["name"] in n)


def blend_topics(spec: dict, base_topics: list, plan_l2: int, storm: dict | None) -> tuple:
    """把 breadth_expand 的增强组换入既有 L2 主题组清单（只换名，组数/编号零漂移）。

    规则（确定性）：k = min(相关组数, max(1, plan_l2//4))——头部保种子骨架
    base[:plan_l2-k]，尾部 k 位换入相关增强组（同义组判重跳过，不足回填原尾，
    长度恒= plan_l2）。返回 (主题组清单, 实际换入数)；storm=None/无相关组
    → (base, 0) 原样返回。
    """
    if not storm or not storm.get("groups"):
        return list(base_topics), 0
    relevant = [g["name"] for g in storm["groups"] if _spec_match(spec, g)]
    if not relevant:
        return list(base_topics), 0
    k = min(len(relevant), max(1, plan_l2 // 4))
    head = list(base_topics)[: plan_l2 - k]
    picks: list = []
    for name in relevant:
        if len(picks) >= k:
            break
        if any(same_group(name, x) for x in head + picks):
            continue  # 同义组必并：与骨架重复的增强组不二进
        picks.append(name)
    tail = list(base_topics)[plan_l2 - k:][: k - len(picks)]
    return head + picks + tail, len(picks)
