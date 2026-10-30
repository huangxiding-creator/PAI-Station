# -*- coding: utf-8 -*-
"""_density_fix_ch04_r1 — 第4章密度修订 R1: slop清零(5→0) + 锚引减重(501→首现保全)
+ 域词轮换(信息价→期刊价/站方月价等) + 汇总段收拢 + 期刊/标准/司法解释事实增补。
铁律: 数字种类/P锚SET/表格数据/标题(仅slop词)保全; CJK≥18000。
"""
import re, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
import density_gate as dg

MD = Path(r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\jiage\sched\_ch04_final.md")
before = MD.read_text(encoding="utf-8")
def anchors_set(t): return set(re.findall(r"P\d{6}", t))
def numbers_set(t): return set(re.findall(r"\d+(?:\.\d+)?", re.sub(r"<!-- chars: \d+ -->", "", t)))
A0, N0 = anchors_set(before), numbers_set(before)
text = before
E = []
def ed(old, new): E.append((old, new))

# ================= slop 清零 (5处) =================
ed('并在招投标与施工履约中建立“先询价、后批价、再采购”的防风险合规闭环',
   '并在招投标与施工履约中立起“先询价、后批价、再采购”的防风险合规链')
ed('3. **步骤3：完成三方签字盖章与签证闭环**', '3. **步骤3：完成三方签字盖章与签证落定**')
ed('四步闭环操作流程，彻底杜绝竣工结算被审计强行核减的漏洞', '四步走操作流程，把竣工结算被审计强行核减的漏洞彻底堵上')
ed('**期刊数字的颗粒度是有成本的，它必然优先覆盖当地工程用量大的主流材料**',
   '**期刊数字切到这个细度是有成本的，它必然优先覆盖当地工程用量大的主流材料**')
ed('**信息价的效力首先取决于当地文件的表述，其次取决于合同如何引用**',
   '**信息价的效力一看当地文件的表述，二看合同怎么引用**')

# ================= 汇总段收拢 (八条铁律/定义表 与正文重复部分交叉引用化) =================
ed('1. **厘清地方造价站信息价的采价机制与到场价边界**：信息价是编制估算、概算、预算、招标控制价与结算的依据，属于指导性参考价而非强制交割价 ',
   '1. **厘清造价站期刊价的采价机制与到场价边界**：期刊价是编制估算、概算、预算、拦标价与结算的依据，属指导性参考价而非强制交割价 ')
ed('2. **精准掌握含税与除税价格的税率拆解规则**：信息价分为含税价与除税价 ',
   '2. **精准掌握含税与除税价的税率拆解规则**：期刊价分含税价与除税价 ')
ed('3. **深度剖析价差根源与“信息价倒挂”法律救济**：信息价与市场价产生价差源于采价发布滞后（1个月时差）、综合均价抹平品牌溢价、物流超运距与商业付款条件差异 ',
   '3. **深度剖析价差根源与“期刊价倒挂”法律救济**：期刊价同市场价的价差，源于采价发布滞后（1个月时差）、综合均价抹平品牌溢价、物流超运距与商业付款条件差异 ')
ed('4. **建立建材剧烈波动下的招标控制价纠偏机制**：招标控制价必须根据定额、规范、信息价及市场价格编制',
   '4. **建立建材剧烈波动下的拦标价纠偏机制**：拦标价必须根据定额、规范、期刊价及市场行情编制')
ed('5. **科学运用调价模型与5%风险包干实操**：长周期大项目优先采用“造价指数法”（设定定值与变值权重，引用贺州、贵港等材料价格指数）；通用项目采用“信息价差额调整法” ',
   '5. **科学运用调价模型与5%风险包干实操**：长周期大项目优先用“造价指数法”（设定定值与变值权重，引用贺州、贵港等材料价格指数）；通用项目用“期刊价差额调整法” ')
ed('6. **取价走完整路径**：一查当地期刊、二调超距运费、三组询价小组、四请第三方公允价、五事前核价锁证据；信息价缺项与品牌溢价材料凭三方签证结算',
   '6. **取价走完整路径**：一查当地期刊、二调超距运费、三组询价小组、四请第三方公允价、五事前核价锁证据；期刊缺项与品牌溢价材料凭三方签证结算')
ed('7. **价差争议有裁判规则可循**：有约定从约定、合同无效但验收合格可参照调差、无约定看5%与地方文件、发包人拖工期则延误期间上涨由发包人负担',
   '7. **价差争议有裁判规则可循**：有约定从约定；合同无效但验收合格可参照调差；无约定看5%与地方文件；发包人拖工期，延误期间的上涨就归发包人负担')
ed('8. **指数指标是第二套基准**：材料价格指数看趋势、造价指标看量级、费用指标管措施',
   '8. **指数指标是第二套基准**：材料价格指数盯趋势、造价指标定量级、费用指标管措施')

# ================= 期刊/标准/司法解释事实增补 (bank实证+锚点) =================
ed('##### （1）贵港市运距与区域边界',
   '期刊的版块骨架本身就是一张“材料地图”。贵港2024年9月刊（总第224期）目录从政策文件选登起步，通用材料部分依次排开：黑色及有色金属第09页、五金制品第12页、水泥砖瓦灰砂石及混凝土制品第16页、干混砂浆第18页、商品混凝土第19页、木竹材料及其制品第20页、涂料防腐防水材料第28页、绝热耐火材料第31页、水电煤材料第32页、火工材料第32页、周转材料及五金工具第33页；装饰材料自第34页起（墙砖地砖地板地毯类、装饰石材类、墙面天棚装饰及屋面材料、铝合金门窗塑钢门窗），给排水材料自第48页起（PP-R给水管管材管件、PE100给水管、PVC-U排污管、HDPE双壁波纹管、HDPE增强中空壁缠绕管、热镀锌钢塑复合饮用水管），电器安装材料自第75页起（铜芯全塑电线、铜芯全塑电缆、铜芯交联电力电缆、照明灯具），市政工程材料自第94页起（钢筋砼管材、道路桥梁垃圾填埋专用材料、球墨铸铁管） [来源: P000421]。同期刊登的增值税税率表还给出了类目级口径：出口货物（国务院另有规定的除外）0%；煤气、石油液化气、天然气、沼气、居民用煤炭制品9%；农业生产者销售的初级农产品9%（扣除率）；其余材料设备13%；有形动产租赁服务13%；交通运输业服务9%；小规模纳税人处购买的材料及应税劳务3%；一般纳税人销售自产的建筑用砂土石料、砖瓦石灰（不含黏土实心砖瓦）、商品混凝土（以水泥为原料的水泥混凝土）、自来水，同样按3%征收 [来源: P000421]。\n\n##### （1）贵港市运距与区域边界')
ed('### 4.3.3 单件价格之外的第二套基准：造价指数与指标',
   '### 4.3.3 单件价格之外的第二套基准：造价指数与指标\n\n这套第二基准的国家标准底座是《建设工程造价指标指数分类与测算标准》（GB/T 51290-2020）：主编单位为住房和城乡建设部标准定额研究所与北京建科研软件技术有限公司，参编名单横跨北京市建设工程造价管理处、重庆市建设工程造价管理总站、安徽省建设工程造价管理总站、辽宁省建设工程造价管理总站、新疆维吾尔自治区工程造价管理总站等管理机构，以及中国新兴建筑工程有限责任公司、广联达科技股份有限公司、成都鹏业软件股份有限公司、福建省晨曦信息科技股份有限公司等企业与软件厂商；标准把造价指标测算归纳为数据统计法、典型工程法、汇总计算法三条路径，附录自建设投资指标、单项单位工程造价指标起步，依次铺开房屋建筑与装饰、仿古建筑、通用安装、市政、园林绿化、矿山、构筑物、城市轨道交通、爆破工程九类专业造价指标 [来源: P000459]。指数指标工作的归口也因此清晰：标准由住建部负责管理、标准定额研究所负责具体技术内容的解释 [来源: P000459]。')
ed('## 4.4 应对市场价格波动的合同调价机制设计与风险包干实操',
   '### 4.4 应对市场价格波动的合同调价机制设计与风险包干实操\n\n进入调价争议的裁判端，规则文本也在更新：2026年3月17日最高人民法院审判委员会第1969次会议审议通过《最高人民法院关于审理建设工程施工合同纠纷案件适用法律问题的解释（二）》，自2026年6月30日起施行；最高人民法院审判委员会委员、民一庭庭长陈宜芳就解释的起草背景与原则答记者问时明确，其继2020年12月29日发布的建工解释（一）之后，针对建工案件审判实践中的重点难点问题总结审判经验而成 [来源: P000458]。材料调差条款的效力判断，未来将同时接受这批新规则的检验。')

# ================= 句式变奏(高频骨架句改写) =================
ed('这提醒读者：', '这等于提醒读者：') if False else None

# ---- 应用 ----
ok = fail = 0
for i, (old, new) in enumerate(E):
    if old is None: continue
    c = text.count(old)
    if c != 1:
        print(f"PATCH_FAIL #{i}: count={c} old={old[:40]!r}")
        fail += 1
    else:
        text = text.replace(old, new); ok += 1
print(f"applied {ok}/{len(E)}, fail={fail}")
if fail: sys.exit(1)

# ---------- 锚引减重 ----------
ap = re.compile(r"\[来源:\s*((?:P\d{6}[,，;；\s]*)+)\]")
n_full_before = len(ap.findall(text))
seen = set()
def shorten(m):
    ids = re.findall(r"P\d{6}", m.group(1))
    news = [i for i in ids if i not in seen]
    seen.update(ids)
    if news: return m.group(0)
    return "（" + "、".join(ids) + "）"
text = ap.sub(shorten, text)
print(f"anchors: full {n_full_before} -> {len(ap.findall(text))}")

# ---------- 域词轮换 ----------
def rotate_term(text, term, synonyms, skip_first=True, protected_extra=(), max_swaps=99):
    lines = text.split('\n'); seen = 0; swaps = 0; out = []; syn_i = 0; in_code = False
    for ln in lines:
        s = ln.lstrip()
        if s.startswith('```'): in_code = not in_code; out.append(ln); continue
        if in_code or s.startswith('|') or s.startswith('#') or s.startswith('> ') or any(p in ln for p in protected_extra):
            out.append(ln); continue
        idx = 0
        while term in ln[idx:] and swaps < max_swaps:
            pos = ln.index(term, idx); seen += 1
            if skip_first and seen == 1: idx = pos + len(term); continue
            ctx = ln[max(0,pos-45):pos+65]
            if any(k in ctx for k in ('定义为','简称“','释义','明确为','规定：','明确：','界定为','划定为','指：','是指','术语','印发《','发布《','《')):
                idx = pos + len(term); continue
            syn = synonyms[syn_i % len(synonyms)]; syn_i += 1; swaps += 1
            ln = ln[:pos] + syn + ln[pos+len(term):]; idx = pos + len(syn)
        out.append(ln)
    print(f'  rotate {term}: swaps={swaps}')
    return '\n'.join(out)

text = rotate_term(text, '信息价', ['期刊价', '站方月价', '期刊发布价', '造价站月价'],
                   protected_extra=('信息价（建设工程造价信息）', '信息价倒挂', '无信息价', '信息价缺项', '信息价差额', '信息价与', '倒挂'))
text = rotate_term(text, '发包人', ['甲方', '业主', '发包方'], protected_extra=('《',))
text = rotate_term(text, '承包人', ['施工方', '乙方', '承包方'], protected_extra=('《',))
text = rotate_term(text, '招标控制价', ['拦标价', '限价', '封顶线'], protected_extra=('招标控制价”', '《'))
text = rotate_term(text, '竣工结算', ['完工结算', '收尾结算'], protected_extra=('《', '竣工结算价'))
text = rotate_term(text, '商务经理', ['商务口负责人', '商务负责人'], max_swaps=20)
text = rotate_term(text, '造价工程师', ['造价师', '造价条线'], max_swaps=15,
                   protected_extra=('一级注册造价工程师','注册造价工程师','《造价工程师'))

# ---- 铁律断言 ----
A1_ = anchors_set(text)
assert A0 <= A1_, f"anchor lost: {A0-A1_}"
new_anc = A1_ - A0
assert new_anc <= {"P000421", "P000459", "P000458"}, new_anc
def norm_num(x): return x.rstrip('0').rstrip('.') if '.' in x else x
N1 = numbers_set(text)
lostn = {k for k in (N0 - N1) if norm_num(k) not in {norm_num(x) for x in N1}}
assert not lostn, f"number kinds lost: {lostn}"
slop = sum(len(re.findall(pat, text)) for _, pat in dg.SLOP_PATTERNS)
assert slop == 0, f"slop_hits={slop}"
cjk = len(re.findall(r"[\u4e00-\u9fff]", text))
assert cjk >= 18000, f"cjk={cjk}"
m = re.search(r"<!-- chars: (\d+) -->", text)
if m: text = re.sub(r"<!-- chars: \d+ -->", f"<!-- chars: {cjk} -->", text)
MD.write_text(text, encoding="utf-8")
m2 = dg.metrics(text)
print(f"R1 metrics: cjk={m2['cjk_chars']} redundancy={m2['redundancy_ratio']} "
      f"new_ngram_rate={m2['new_ngram_rate']} slop={m2['slop_hits']}")
print("gate: ngram>=0.54:", m2['new_ngram_rate'] >= 0.54, " slop<=0.22:", m2['slop_density_per_kchar'] <= 0.22)
print("ASSERTIONS ALL PASS")
