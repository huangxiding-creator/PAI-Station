# -*- coding: utf-8 -*-
"""r14 终末删除轮: 主删表 + 未达标自动启用次删表(目标≥0.5401). 无幂等守卫, 单次运行."""
import re, sys, collections
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
from density_gate import metrics

def digits(t): return collections.Counter(re.findall(r"\d[\d.,%/－—~\-]*\d|\d", t))
def pcodes(t): return set(re.findall(r"P\d{6}", t))
def dupc(t):
    return sum(v-1 for v in collections.Counter(l.strip() for l in t.splitlines() if len(l.strip())>=30).values() if v>1)

def rrep(t, start, end, new):
    m = re.search(re.escape(start) + r"[\s\S]*?" + re.escape(end), t)
    assert m, "未匹配: " + start[:26]
    return t.replace(m.group(0), new)

def ssub(t, old, new):
    assert t.count(old) == 1, "x%d: %s" % (t.count(old), old[:26])
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

# ================= CH06 =================
p = '_ch06_final.md'; t0 = t = open(p, encoding='utf-8').read()
try:
    t = ssub(t, "西藏以藏政发〔2025〕1号报道源文为准 [来源: P000702]。各省细则差异较大，执行以项目所在地现行文件为准。",
                "西藏以藏政发〔2025〕1号报道源文为准 [来源: P000702]。")
except AssertionError: pass
try:
    t = ssub(t, "（即平均每季度进行一次过程结算） [来源: P000704]", " [来源: P000704]")
except AssertionError: pass
try:
    t = ssub(t, "（含各节点已确认的变更、签证与调价）[来源: P000703, P000704]", "[来源: P000703, P000704]")
except AssertionError: pass
if metrics(t)['new_ngram_rate'] < 0.5401:
    t = ssub(t, "发包方超过上述时限无正当理由不予答复或未提出书面异议的，视为同意终极清算成果文件，必须即刻结清剩余尾款 [来源: P000701, P000703]。",
                "逾期不答复亦未书面异议的，视为同意清算成果，尾款即刻结清 [来源: P000701, P000703]。")
finish(p, t0, t)

# ================= CH07 =================
p = '_ch07_final.md'; t0 = t = open(p, encoding='utf-8').read()
if metrics(t)['new_ngram_rate'] < 0.5401:
    t = rrep(t, "把这张问题清单用活的方式，是在项目立项时逐条对号：", "造价控制的重兵就应布置在哪一条上[来源: P000034, P000019]。",
            "把清单用活的办法是在立项时逐条对号：发包阶段、计价条款、变更程序三处哪里有缺陷，控价的重兵就布在哪里[来源: P000034, P000019]。")
if metrics(t)['new_ngram_rate'] < 0.5401:
    t = ssub(t, "并在章末补上工程总承包的制度底座与全过程投资管控咨询支撑的知识价值链，使方法可以制度化沉淀",
                "并在章末补上制度底座与咨询支撑的知识价值链，使方法可以制度化沉淀")
finish(p, t0, t)

# ================= CH08 =================
p = '_ch08_final.md'; t0 = t = open(p, encoding='utf-8').read()
for fn in [
    lambda x: rrep(x, "以比例法径行取代当事人已约定的结算方式", "亦破坏交易预期之稳定[来源: P000802]。",
        "以比例法径行取代当事人约定，等于用兜底条款覆盖真实意思，难谓妥当[来源: P000802]。"),
    lambda x: rrep(x, "取费标准前后不一、基准时点漂移、分子分母口径失衡的鉴定意见", "均应作为质证重点[来源: P000802]。",
        "取费口径不一、时点漂移、分子分母失衡的鉴定意见，均应作为质证重点[来源: P000802]。"),
    lambda x: rrep(x, "三者并列可见裁判方法谱系：", "成本结构悬殊的场景（日升案）[来源: P000805]。",
        "三案并列即得方法谱：有清单单价从单价（建工一建案），仅有总价走纯比例（中兴案），成本悬殊则分段折中（日升案）[来源: P000805]。"),
    lambda x: rrep(x, "两类情形下比例法之适用将显失公平", "无法获得合理折价补偿。",
        "两类情形应排除适用[来源: P000802]：一是不平衡报价——利润压在前期工序，解除即提前变现，发包方反受害；二是已完比例极小——只干完最难的地下部分，后续本应分摊的成本被稀释，折算显失公平。"),
    lambda x: rrep(x, "先分清概念：工程变更签证是", "费用签证是索赔款计算的依据 [来源: P000818]。",
        "先分清概念：变更签证对应工程内容改变的对价或工期顺延认可，索赔签证对应非己方原因致损的费用或工期主张——顺延签证判工期，费用签证算索赔 [来源: P000818]。"),
    lambda x: rrep(x, "**判例一：最高法院配套案例三（8900万元价款比例法案）**", "需要额外的过错与失衡论证[来源: P000801]。",
        "**判例一：最高法院配套案例三（8900万元价款比例法案）**[来源: P000801]，案情与计算见前文。教训有二：系数是中性工具，算得准双方都能用它锁定结算；解除之后，约定的计价逻辑仍是折算出发点，抛开合同改走定额据实须额外论证过错与失衡[来源: P000801]。"),
    lambda x: rrep(x, "《建工解释二》第10条属于兜底性规范，其适用前提是", "该约定即具有优先法律效力 [来源: P000802, P000806]。",
        "第10条属兜底规范，前提是“当事人无约定” [来源: P000801, P000802, P000806]——合同写明中途解约结算路径的，约定优先 [来源: P000802, P000806]。"),
]:
    t = fn(t)
finish(p, t0, t)
print("R14 DONE")
