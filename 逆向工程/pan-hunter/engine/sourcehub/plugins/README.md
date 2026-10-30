# 本地凭据插件契约（W2 · 法务原则#3「凭据零托管」的引擎侧正面件）

> 定位：黄盘（百度/123/…）「免登发现层」之外的**可选交付通道**。
> 默认**全关**；`ph.py` 启动**不加载任何凭据**（import 零副作用：不读凭据、不起进程、不联网）。

## 契约（五条）

1. **开关唯一源**：`plugins/config.json` 的 `enabled` 列表（默认 `[]`）。改配置=用户显式动作。
2. **凭据永不入仓**：凭据是用户本地自供文件（各插件 `status().cred_file` 给约定路径）；
   本框架只做**存在性检查**（`Path.exists()`），从不读内容、从不打印、从不复制。
3. **只本地执行**：插件通过 `subprocess` 调用本地 CLI（如 bdn.py），零上传零遥测；
   输出一律经 `_mask()` 打码（≥28 位字母数字串全部 `<MASKED>`）。
4. **doctor 只显示态**：`ph.py doctor` 展示 插件名/是否启用/凭据文件是否在位/说明——
   不自动执行插件、不触发任何网络动作。
5. **红盘不设插件**：微云/沃盘等三级红盘无插件位；黄盘插件也仅限「用户自有账号通道」，
   不做限速破解/账号池/向下载收费（法务原则#1，PanDownload 刑事案为界）。

## 在役/预留插件

| 插件 | 盘 | 状态 | 说明 |
|---|---|---|---|
| `baidu_bdn` | 百度 | 在役（默认关） | 包装 `E:\AI-Station\逆向工程\baidu-netdisk\replica\bdn.py`；凭据 `E:\AI-Station\data\secrets\bdn_credentials.json` 用户自供 |
| `pan123` | 123 | **预留位**（不实现登录） | W1 实证直链=5112 免费层墙；用户自供官方开放平台凭据后另期实现 |

## 用法

```
python ph.py doctor                # 插件态（enabled? 凭据在位?）
# 启用（用户显式动作）：编辑 engine/sourcehub/plugins/config.json → {"enabled": ["baidu_bdn"]}
# 代码侧（显式调用才跑）：
#   from plugins import _REGISTRY
#   out = _REGISTRY["baidu_bdn"]().run(["doctor"])   # → {"returncode":0, "masked_output":...}
```
