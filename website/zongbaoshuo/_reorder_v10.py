# -*- coding: utf-8 -*-
"""v10: 产品 section 物理重排为价值阶梯序 + 注释编号同步"""
import io, sys, re
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')

P = "E:/AI-Station/website/zongbaoshuo/index.html"
html = open(P, encoding="utf-8").read()

# 目标顺序（价值阶梯）
ORDER = ["leopard", "brain", "zhiku", "factory", "aipo", "station", "glasses", "robot"]
# 重排后的注释编号与名称
LABEL = {
    "leopard":  "01 工程豹",
    "brain":    "02 工程大脑",
    "zhiku":    "03 总包智库",
    "factory":  "04 研究工厂",
    "aipo":     "05 自媒永动机",
    "station":  "06 AI工作站",
    "glasses":  "07 安全AI眼镜（反色重点段）",
    "robot":    "08 顾问机器人",
}

blocks = {}
for sid in ORDER:
    # 块起点 = 前置注释行首；终点 = </section> 后换行
    m = re.search(r'(<!-- ================= [^\n]*================= -->\n<section class="product" id="%s">.*?</section>\n)' % sid, html, re.S)
    if not m:
        print("FAIL: block not found:", sid); sys.exit(1)
    blocks[sid] = m.group(1)

# 校验 8 块互不重叠且都唯一
pos = [html.find(blocks[s]) for s in ORDER]
if -1 in pos:
    print("FAIL: find error"); sys.exit(1)

# 重组：把从第一块起点到最后一块终点的区间整体替换为新序
lo = min(pos)
hi = max(pos + [html.find(blocks[s]) + len(blocks[s]) for s in ORDER])
span = html[lo:hi]
# 确认区间内没有区间外内容（8 块必须连续相邻）
rest = span
for s in ORDER:
    rest = rest.replace(blocks[s], "", 1)
if rest.strip():
    print("FAIL: span contains extra content:", repr(rest[:120])); sys.exit(1)

new_span = "".join(
    blocks[s].replace(
        re.search(r'<!-- ================= ([^\n]*) ================= -->', blocks[s]).group(1),
        LABEL[s], 1)
    for s in ORDER
)
html2 = html[:lo] + new_span + html[hi:]

open(P, "w", encoding="utf-8", newline="").write(html2)

# 自验
order_found = re.findall(r'<section class="product" id="(\w+)">', html2)
prod_seq = [s for s in order_found if s in ORDER]
print("SECTION ORDER NOW:", prod_seq)
print("TARGET           :", ORDER)
print("MATCH:", prod_seq == ORDER)
print("SIZE:", len(html2), "chars")
