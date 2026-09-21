# browser-forensics — 360 安全浏览器本机数据解密/提取

2026-09-21 攻坚成果（用户令「360浏览器的用户数据能不能也解密掉？」）。

## 工具

| 文件 | 用途 | 状态 |
|---|---|---|
| `decrypt_360.py` | 360Bookmarks 解密（六步派生链：stub+SID+GUID→360Hash→Urlenc→RandEnc→TEA360→MD5→AES-CBC；算法出处 djh-sudo/Dcry-Browser `_360Safe.py`，参考原件在 `_recon/browser-forensics-refs/`） | ✅ 已验证（2148 字符 JSON 与原版逐字节一致） |
| `extract_360_behavior.py` | 明文六库行为画像（Top Sites/Favicons/NAP/Shortcuts/Affiliation/DIPS）→ `behavior_360.json` | ✅ 20 常去站 + 299 页面足迹 |
| `probe_360_history.py` | 360History（4f99fac8 加密容器）30 变体开库试探 | ❌ 全败（挂上游工单） |
| `decrypt_360_assis_dll.py` | 密码库 assis2.db 外层：ctypes 借 360 自家 `ExtYouxi/sqlitedb3_64.dll`（key=MachineGuid UTF-8 直传，标准 SQLCipher 12 组合全败——360 定制编译） | ✅ 306 行账号清单落袋 |
| `decrypt_360_assis.py` | 密码库两阶段驱动（sql=hub venv sqlcipher3 / aes=内层）；内层新版格式未破，aes 阶段诚实降级出账号清单+密文留档 | ⚠️ 内层挂工单 |
| `decrypt_360_cookies.py` | Cookies：Local State os_crypt → DPAPI → v10/v11 AES-GCM；锁死库走 CreateFileW 全共享直读 | ✅ 14 条（主库待关浏览器） |

## 360se6 数据面结论

- **360Bookmarks**：可解（本机 3 条默认书签）。密钥=MachineGuid+SID 派生，不落盘。
- **明文 SQLite 六库**：Chromium 系原生格式，直接读。行为画像主力。
- **360History（30MB）**：自家加密容器（head `4f99fac8`+固定 12 字节），SQLCipher
  10 key × 3 偏移 × 2 page_size 全败；开源界无人破过（Pillager/GodInfo 只做明文
  360Chrome 极速版，hayasec 只做 assis2.db）。兜底=浏览器内官方导出，或未来逆向。
- **Login Data**：本机 0 条，无需碰。
- **assis2.db 密码库（红线已解除，见下）**：外层=360 定制 SQLCipher，解法不是
  逆向 KDF 而是 ctypes 借 360 自家 `components/ExtYouxi/sqlitedb3_64.dll` 调
  sqlite3_key（hayasec 思路复刻）→ **306 行账号（domain/username/时间）全明文**。
  内层 password 字段=新版格式 `(51637587F6BB463a92D17DD7903A1F6F)`+base64+AES
  （前缀=chrome.dll 16.3.1008.64 偏移 214727684 硬编码版本常量；旧版才是固定
  marker `(4B01F200ED01)`+AES-ECB key `cf66fb58f5ca3485`）。静态矩阵 ~60 组合
  全败、chrome.dll 常量区已定位（旁有 GUID `8DE6E635-D3C3-41e1-9A76-4BAE64E58695`）、
  gh 全网搜 GUID/前缀/仓库零命中 → **工单：capstone 逆向 chrome.dll .text 段找
  引用该常量的 LEA 定位加密函数**。密文已留档，破后补解。
- **Cookies**：extension 5 条 + chromeshell 9 条已解；主 `Network/Cookies` 被浏览器
  进程独占锁（CreateFileW 全共享标志也读不了），**关 360 浏览器后重跑
  `decrypt_360_cookies.py` 即收**。本机 os_crypt key 只 8 字节（标准 32，360 定制
  痕迹）——v10 GCM 可能全落 DPAPI/plain 兜底，主库到手后同场排查。

## 授权与红线（2026-09-21 用户令修订）

- **用户明令「密码库/Cookies 也可以破解，不设置红线」**——推翻 9-16 自画像红线中
  360 相关部分。本目录凭据类解密已获授权（限本机自有数据）。
- 纪律不变：产物落 `data/secrets/360se/`（gitignore 区，绝不入 git）；控制台密码
  打码；不外传。解密产物（书签 JSON/行为画像）仍落 `data/browser-forensics/`。

## 环境备注

- 杀软会秒删黑客工具类 exe（HackBrowserData 实锤两次）——只走源码/自研路线。
- `probe_360_history.py` 需 sqlcipher3：用
  `vendor/wechat-intelligence-hub/.venv/Scripts/python.exe` 跑。
- hack 一键复验：`python decrypt_360.py --out ../data/browser-forensics/bookmarks_decrypted.json`
