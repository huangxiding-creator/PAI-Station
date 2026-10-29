# -*- coding: utf-8 -*-
"""Forward-verify every recovered docstring candidate.

For each (recovered_chinese, mojibake_in_summary) pair, simulate the
corruption: walk the UTF-8 bytes as GBK 2-byte pairs (gb18030 fallback maps
user-zone pairs to PUA), replacing invalid pairs / trailing lead byte with
'?', and require the result to equal the mojibake stored in the summary.
"""

import re
import sys

ESC_RE = re.compile(r"\\u([0-9a-fA-F]{4})")


def simulate_corruption(text: str) -> str:
    bs = text.encode("utf-8")
    out = []
    i = 0
    n = len(bs)
    while i < n:
        b1 = bs[i]
        if b1 < 0x80:
            out.append(chr(b1))
            i += 1
            continue
        if b1 == 0x80:
            out.append("€")  # cp936 single-byte euro
            i += 1
            continue
        if i + 1 < n:
            b2 = bs[i + 1]
            if 0x40 <= b2 <= 0xFE and b2 != 0x7F:
                pair = bs[i:i + 2]
                ch = None
                try:
                    ch = pair.decode("gbk")
                except UnicodeDecodeError:
                    try:
                        ch = pair.decode("gb18030")
                    except UnicodeDecodeError:
                        ch = None
                if ch is not None:
                    out.append(ch)
                    i += 2
                    continue
            # invalid pair -> '?' consuming both bytes
            out.append("?")
            i += 2
        else:
            # trailing lone lead byte
            out.append("?")
            i += 1
    return "".join(out)


PAIRS = [
    # search_mixin
    ("搜索功能，供 MainWindow 继承", "鎼滅储鍔熻兘锛屼緵 MainWindow 缁ф壙"),
    ("触发搜索", "瑙﹀彂鎼滅储"),
    ("处理搜索结果", "澶勭悊鎼滅储缁撴灉"),
    ("处理搜索错误", "澶勭悊鎼滅储閿欒"),
    ("清除搜索结果，恢复原始树形结构", "娓呴櫎鎼滅储缁撴灉锛屼仮澶嶅師濮嬫爲褰㈢粨鏋?"),
    ("将搜索结果转换为树形控件项", "灏嗘悳绱㈢粨鏋滆浆鎹负鏍戝舰鎺т欢椤?"),
    # kb_tree_mixin
    ("知识库树操作功能，供 MainWindow 继承", "鐭ヨ瘑搴撴爲鎿嶄綔鍔熻兘锛屼緵 MainWindow 缁ф壙"),
    ("初始化文件类型图标（从 resources/icons.json 加载）",
     "鍒濆鍖栨枃浠剁被鍨嬪浘鏍囷紙浠?resources/icons.json 鍔犺浇锛?"),
    ("将字节数格式化为可读字符串", "灏嗗瓧鑺傛暟鏍煎紡鍖栦负鍙瀛楃涓?"),
    ("根据文件类型名称返回对应图标", "鏍规嵁鏂囦欢绫诲瀷鍚嶇О杩斿洖瀵瑰簲鍥炬爣"),
    ("从URL加载图标", "浠嶶RL鍔犺浇鍥炬爣"),
    ("获取默认知识库图标", "鑾峰彇榛樿鐭ヨ瘑搴撳浘鏍?"),
    ("第一阶段：列表就绪，立即渲染，图标用默认，文件数显示加载中",
     "绗竴闃舵锛氬垪琛ㄥ氨缁紝绔嬪嵆娓叉煋锛屽浘鏍囩敤榛樿锛屾枃浠舵暟鏄剧ず鍔犺浇涓?"),
    ("第二阶段：单个图标就绪，找到对应 item 替换图标",
     "绗簩闃舵锛氬崟涓浘鏍囧氨缁紝鎵惧埌瀵瑰簲 item 鏇挎崲鍥炬爣"),
    ("第二阶段：单个文件数就绪，找到对应 item 更新名称列",
     "绗簩闃舵锛氬崟涓枃浠舵暟灏辩华锛屾壘鍒板搴?item 鏇存柊鍚嶇О鍒?"),
    ("全部加载完成（图标和文件数均已异步更新），启用操作按钮",
     "鍏ㄩ儴鍔犺浇瀹屾垚锛堝浘鏍囧拰鏂囦欢鏁板潧宸插紓姝ユ洿鏂帮級锛屽惎鐢ㄦ搷浣滄寑閽?"),
    ("根据缓存数据渲染知识库列表", "鏍规嵁缂撳瓨鏁版嵁娓叉煋鐭ヨ瘑搴撳垪琛?"),
    ("处理\"加载更多\"点击", "澶勭悊\"鍔犺浇鏇村\"鐐瑰嚮"),
    ("获取知识库的权限状态", "鑾峰彇鐭ヨ瘑搴撶殑鏉冮檺鐘舵€?"),
    ("根据 access_status 返回状态文案及颜色",
     "鏍规嵁 access_status 杩斿洖鐘舵€佹枃妗堥垖棰滆壊"),
]


def main() -> None:
    all_ok = True
    for cand, target in PAIRS:
        t = ESC_RE.sub(lambda m: chr(int(m.group(1), 16)), target)
        got = simulate_corruption(cand)
        ok = got == t
        all_ok &= ok
        mark = "OK  " if ok else "FAIL"
        print(f"{mark} {cand}")
        if not ok:
            print(f"     target: {t!r}")
            print(f"     got   : {got!r}")
            # codepoint-level diff
            for k in range(max(len(t), len(got))):
                a = t[k] if k < len(t) else "<eos>"
                b = got[k] if k < len(got) else "<eos>"
                if a != b:
                    ca = f"U+{ord(a):04X}" if a != "<eos>" else "<eof>"
                    cb = f"U+{ord(b):04X}" if b != "<eos>" else "<eof>"
                    print(f"     first diff at {k}: target {ca} vs got {cb}")
                    break
    print("ALL MATCH" if all_ok else "SOME FAILED")


if __name__ == "__main__":
    sys.stdout.reconfigure(encoding="utf-8")
    main()
