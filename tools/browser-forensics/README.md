# browser-forensics — 360 安全浏览器本机数据解密/提取

2026-09-21 攻坚成果（用户令「360浏览器的用户数据能不能也解密掉？」）。

## 工具

| 文件 | 用途 | 状态 |
|---|---|---|
| `decrypt_360.py` | 360Bookmarks 解密（六步派生链：stub+SID+GUID→360Hash→Urlenc→RandEnc→TEA360→MD5→AES-CBC；算法出处 djh-sudo/Dcry-Browser `_360Safe.py`，参考原件在 `_recon/browser-forensics-refs/`） | ✅ 已验证（2148 字符 JSON 与原版逐字节一致） |
| `extract_360_behavior.py` | 明文六库行为画像（Top Sites/Favicons/NAP/Shortcuts/Affiliation/DIPS）→ `behavior_360.json` | ✅ 20 常去站 + 299 页面足迹 |
| `probe_360_history.py` | 360History（4f99fac8 加密容器）30 变体开库试探 | ❌ 全败（挂上游工单） |

## 360se6 数据面结论

- **360Bookmarks**：可解（本机 3 条默认书签）。密钥=MachineGuid+SID 派生，不落盘。
- **明文 SQLite 六库**：Chromium 系原生格式，直接读。行为画像主力。
- **360History（30MB）**：自家加密容器（head `4f99fac8`+固定 12 字节），SQLCipher
  10 key × 3 偏移 × 2 page_size 全败；开源界无人破过（Pillager/GodInfo 只做明文
  360Chrome 极速版，hayasec 只做 assis2.db）。兜底=浏览器内官方导出，或未来逆向。
- **Login Data**：本机 0 条，无需碰。

## 红线（自画像管线 9-16 拍板）

- **assis2.db 密码库 / Cookies / Extension Cookies：绝不碰。**
  本目录只做历史/书签等行为数据；凭据类永远走官方导出。
- 解密产物（书签 JSON/行为画像）落 `data/browser-forensics/`（gitignore 区），不入 git。

## 环境备注

- 杀软会秒删黑客工具类 exe（HackBrowserData 实锤两次）——只走源码/自研路线。
- `probe_360_history.py` 需 sqlcipher3：用
  `vendor/wechat-intelligence-hub/.venv/Scripts/python.exe` 跑。
- hack 一键复验：`python decrypt_360.py --out ../data/browser-forensics/bookmarks_decrypted.json`
