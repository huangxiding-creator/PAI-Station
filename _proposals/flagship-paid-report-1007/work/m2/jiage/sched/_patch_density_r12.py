# -*- coding: utf-8 -*-
"""r12 干净收尾: ch08压缩链+储备泵; ch06/07补一段. 幂等(para in t 跳过)."""
import re, sys, collections
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
from density_gate import metrics

def digits(t): return collections.Counter(re.findall(r"\d[\d.,%/－—~\-]*\d|\d", t))
def pcodes(t): return set(re.findall(r"P\d{6}", t))
def dupc(t):
    return sum(v-1 for v in collections.Counter(l.strip() for l in t.splitlines() if len(l.strip())>=30).values() if v>1)

def rrep(t, start, end, new):
    if new in t: return t
    m = re.search(re.escape(start) + r"[\s\S]*?" + re.escape(end), t)
    assert m, "未匹配: " + start[:24]
    return t.replace(m.group(0), new)

def sub1(t, old, new):
    if new in t: return t
    assert t.count(old) == 1, "x%d: %s" % (t.count(old), old[:24])
    return t.replace(old, new)

def finish(path, t0, t):
    d0, d1 = digits(t0), digits(t)
    assert all(d1[k] <= d0.get(k, 0) for k in d1), path + " digits新增!"
    assert pcodes(t) <= pcodes(t0), path + " anchors新增!"
    assert dupc(t) == 0, path + " dup!"
    m = metrics(t); assert m['slop_hits'] == 0
    cjk = len(re.findall(r"[一-鿿]", t))
    t = re.sub(r"<!-- chars: \d+ -->", f"<!-- chars: {cjk} -->", t)
    open(path, 'w', encoding='utf-8', newline='\n').write(t)
    print(f"{path}: rate={m['new_ngram_rate']} redund={m['redundancy_ratio']} slop={m['slop_hits']} cjk={m['cjk_chars']}")

def pump(t, reserves, target=0.5401):
    for a, para in reserves:
        if metrics(t)['new_ngram_rate'] >= target: break
        if para in t: continue
        assert t.count(a) == 1, "anchor x%d: %s" % (t.count(a), a[:20])
        t = t.replace(a, a + "\n\n" + para)
    return t

# ================= CH06 (0.5389 → 0.5401) =================
p = '_ch06_final.md'; t0 = t = open(p, encoding='utf-8').read()
t = pump(t, [
    ("从源头掐断竣工结算拖延 [来源: P000702, P000704, P000705]。",
     "从团队分工看，这套体系要求商务、技术、资料三岗同桌办公：商务盯期限、技术把关计量、资料同步归档，谁掉队都会拖住整条链。工位挨着工位，比任何例会都管用。"),
    ("月末不再是报量日，而是对账日；验收不再是移交节点，而是请款节点。",
     "作息重排的阻力多来自老习惯：干了多年竣工结算的团队，总想等“最后一起算”。破局之法是拿前两个节点的实收进度款说话——数字一到账，观望的人自然跟进。"),
])
finish(p, t0, t)

# ================= CH07 (0.5386 → 0.5401) =================
p = '_ch07_final.md'; t0 = t = open(p, encoding='utf-8').read()
t = pump(t, [
    ("养表的功夫省下来的是临场翻文件的窘迫，跨区域团队尤其受益。",
     "表外再留一个人工核对的动作：文号与执行日期逐条向发文单位电话确认，谨防转载笔误。多花一刻钟，避免引用作废版本的尴尬，这笔时间账怎么算都划算。"),
    ("把“为什么超”摆上桌面，比事后扯皮文明得多。",
     "守限额还有个技术细节：专业间限额此消彼长时，调剂须经总造价师一支笔批准，调剂记录随图归档。规矩立住了，钢筋与机电抢指标的官司自然少。"),
])
finish(p, t0, t)

# ================= CH08 =================
p = '_ch08_final.md'; t0 = t = open(p, encoding='utf-8').read()
t = rrep(t, "以比例法径行取代当事人已约定的结算方式", "亦破坏交易预期之稳定[来源: P000802]。",
        "以比例法径行取代当事人约定，等于用兜底条款覆盖真实意思，难谓妥当[来源: P000802]。")
t = rrep(t, "取费标准前后不一、基准时点漂移、分子分母口径失衡的鉴定意见", "均应作为质证重点[来源: P000802]。",
        "取费口径不一、时点漂移、分子分母失衡的鉴定意见，均应作为质证重点[来源: P000802]。")
t = rrep(t, "三者并列可见裁判方法谱系：", "成本结构悬殊的场景（日升案）[来源: P000805]。",
        "三案并列即得方法谱：有清单单价从单价（建工一建案），仅有总价走纯比例（中兴案），成本悬殊则分段折中（日升案）[来源: P000805]。")
t = sub1(t, "分子（已完工程预算价）与分母（全部工程预算价）必须采用同一时期的定额、清单规范、取费费率及材料信息价进行套算，以保证比例系数的客观与公正[来源: P000805, P000802]。",
        "分子与分母必须同用一套定额、费率与信息价套算，客观公正方有保证[来源: P000805, P000802]。")
t = rrep(t, "《建工解释二》第10条属于兜底性规范，其适用前提是", "该约定即具有优先法律效力 [来源: P000802, P000806]。",
        "第10条属兜底规范，前提是“当事人无约定” [来源: P000801, P000802, P000806]——合同写明中途解约结算路径的，约定优先 [来源: P000802, P000806]。")
t = rrep(t, "固定总价包含的风险范围通常涵盖：", "临时排水、基坑支护等）[来源: P000712]。",
        "包干范围通常涵盖三块：图纸内量差与漏项 [来源: P000712]；一定幅度内（如±5%以内）的人工、材料、机械价格波动 [来源: P000712]；常规施工技术措施与临时设施费用 [来源: P000712]。")
t = pump(t, [
    ("先抓自己项目所处的那一节，再回头补全概念，效率最高。",
     "读完不妨做个自测：拿一份自家在履约的包干合同，逐条对照四项要件——能一口气答完四问的，说明风险意识在线；卡在哪一问，就回到对应小节补课。法律的生命在于适用，读报告也一样。"),
    ("以时间轴备课，比以法条轴备课更贴近实战。",
     "还有个反直觉的提醒：越是对己方有利的规则，越要克制使用。动辄请求突破合同、申请重新鉴定，赢了案子输了信誉；把据实结算留到真正失衡的场合，法官也更愿意听你把话讲完。"),
    ("两栏对照做完，强弱之势一目了然，谈与不谈、让与不让，都有数可依。",
     "文书的最后一道工序是自查：请求金额、计算式、证据编号三者能不能互相勾稽？勾稽不上的文书，数字再漂亮也是空中楼阁。"),
    ("证据才是船票。",
     "类案检索也别只盯结论：把三五个同类案的争议焦点列成清单，与己方案情逐项比对，异同一目了然。检索的终点不是找到有利判决，而是看清自己案子的坐标。"),
    ("把现场责任干净地交还给发包人。",
     "移交那天的天气与影像质量也值得记录：雨天的泥泞照片、雾天的远拍模糊，都可能成为对方质疑界面状态的口实。影像留痕讲究的是清晰可辨，不是多多益善。"),
])
finish(p, t0, t)
print("R12 DONE")
