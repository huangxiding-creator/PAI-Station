# -*- coding: utf-8 -*-
"""中图法层级访问层（v2.6 #3）——冷门领域中间层机械兜底，与六库 49 分组并存增强。

巨人肩膀：sheoguo/chinese-library-classification（MIT，pip 同名包 0.0.1，实测
data.json 共 45785 类号）。巨人公开类 Chineselibraryclassification 的
num2info/num2next 每调用都重新 json.load 整库（约 150ms/次且打印两行噪声），
故本层经巨人自家 utils.load_all_data 一次性载库后沿 next_level 链机械下钻
（与 num2next 同构：逐对 code+name、保持数据库原序），多级展开只花一次载库时间。

定位（并存增强，非替换）：
  - 现有六库 49 分组（taxonomy.SIX_DOMAINS / seeds 六域树）一律不动，本层不读 seeds；
  - 只交访问层：clc_expand(一级类号) → 机械生成中间层树，蓝图引擎对「冷门领域」
    匹配不上种子时可用它兜底（引擎接线留波2/后续，本任务不接线）；
  - 输出节点键族与 seeds 分组对齐（code/dir/path/name/theme/source + 子层键
    l2/l3，同 05_水利EPC工程.json 六域树；file_count/files 属引擎期键，访问层不造）；
  - 输出深度硬控≤三级（HARD_MAX_DEPTH=3，任何 max_depth 请求都被钳制）；
  - fail-soft：pip 包缺席/类号无效 → 一律返回 None，绝不抛异常。
"""
import contextlib
import io
from importlib.metadata import PackageNotFoundError, version as _pkg_version
from typing import Optional

try:  # 巨人包缺席时整层 fail-soft（返回 None），不阻断引擎与其余模块
    from chinese_library_classification.utils import load_all_data as _giant_load_all_data
except Exception:  # pragma: no cover - 环境缺包路径，由真缺席子进程测试实证
    _giant_load_all_data = None

_STATE = {"data": None, "error": None}  # 巨人数据库懒载缓存；error 记缺席/失败原因


def _pkg_tag() -> str:
    """巨人包版本溯源标签（查不到时 unknown，绝不抛）。"""
    try:
        return _pkg_version("chinese-library-classification")
    except PackageNotFoundError:
        return "unknown"


def _get_data():
    """懒载巨人数据库（一次 json.load，全场复用）；缺席/失败记 error 并返回 None。"""
    if _STATE["data"] is not None:
        return _STATE["data"]
    if _STATE["error"] is not None:
        return None
    if _giant_load_all_data is None:
        _STATE["error"] = "chinese-library-classification 未安装"
        return None
    try:
        with contextlib.redirect_stdout(io.StringIO()):  # 巨人载库固定打印两行，静默之
            _STATE["data"] = _giant_load_all_data()
    except Exception as exc:  # 数据文件损坏等环境异常同样 fail-soft
        _STATE["error"] = f"巨人数据库加载失败: {exc}"
        return None
    return _STATE["data"]


def reset() -> None:
    """清空懒载缓存（测试用：模拟包缺席/恢复真库后重建状态）。"""
    _STATE["data"] = None
    _STATE["error"] = None


class CLCLayer:
    """中图法层级访问层：一级类号 → 机械下钻中间层树（输出深度硬控≤三级）。"""

    HARD_MAX_DEPTH = 3  # 硬控：根(1)+中间两层(2/3)，任何请求不得越界

    def __init__(self, max_depth: int = HARD_MAX_DEPTH):
        self.max_depth = max_depth

    @property
    def available(self) -> bool:
        """巨人 pip 包在位且数据库可载（缺席=False，不抛）。"""
        return _get_data() is not None

    def expand(self, code: str, max_depth: Optional[int] = None) -> Optional[dict]:
        """机械下钻生成中间层树；包缺席/类号无效 → None（fail-soft，不抛）。

        返回 {"mode": "clc_expand", "root": "TV 水利工程", "l1": [组节点]}，
        组节点带 l2 子层、l2 带 l3 子层（深度钳制后到哪层就带到哪层，叶层不带子键）。
        """
        data = _get_data()
        if data is None or not code or not str(code).strip():
            return None
        code = str(code).strip().upper()
        root_info = data.get(code)
        if root_info is None:
            return None
        depth = max_depth if max_depth is not None else self.max_depth
        depth = max(min(depth, self.HARD_MAX_DEPTH), 1)  # 深度硬控：钳进 [1, 3]
        source = f"clc_layer(chinese-library-classification@{_pkg_tag()})"
        group = self._node(code, root_info, parent_path="", source=source)
        if depth >= 2:
            group["l2"] = self._drill(code, data, parent_path=code + "/",
                                      depth=2, cap=depth, source=source)
        return {"mode": "clc_expand", "root": f"{code} {root_info['name']}", "l1": [group]}

    @staticmethod
    def _node(code: str, info: dict, parent_path: str, source: str) -> dict:
        """单节点（键族与 seeds 分组对齐：code/dir/path/name/theme/source）。"""
        return {
            "code": code,
            "dir": code,
            "path": parent_path + code + "/",  # 同 seeds 路径拼接约定：父path+dir+"/"
            "name": info["name"],
            "theme": f"{info['name']}（{code}）：中图法第{info['level']}级",
            "source": source,
            "clc_level": info["level"],  # 中图法本身的级（非输出树深），溯源用
        }

    def _drill(self, code: str, data: dict, parent_path: str, depth: int,
               cap: int, source: str) -> list:
        """机械下钻一层：next_level 数据库原序逐对（与巨人 num2next 同构），到 cap 停。"""
        children = []
        for ch in data[code].get("next_level", []):
            info = data.get(ch)
            if info is None:
                continue  # 实测 45785 键零缺失，此处纯防御性兜底
            node = self._node(ch, info, parent_path=parent_path, source=source)
            if depth < cap:  # 未到硬控深度继续钻，子层键随层取名（l3/l4…）
                node[f"l{depth + 1}"] = self._drill(
                    ch, data, parent_path=parent_path + ch + "/",
                    depth=depth + 1, cap=cap, source=source)
            children.append(node)
        return children


_LAYER = CLCLayer()


def clc_expand(code: str, max_depth: Optional[int] = None) -> Optional[dict]:
    """蓝图引擎兜底入口：一级类号 → 中间层树（None=包缺席/类号无效，不崩）。

    例：clc_expand("TV") → {"mode": "clc_expand", "root": "TV 水利工程",
                            "l1": [{…, "l2": [{…, "l3": […]}]}]}
    """
    return _LAYER.expand(code, max_depth)
