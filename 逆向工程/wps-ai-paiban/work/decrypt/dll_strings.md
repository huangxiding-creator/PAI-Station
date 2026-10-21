# kwpsaitypeset.dll 模板加载与解密字串情报（纯静态）

- 目标: `C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28802\office6\addons\kwpsaitypeset\kwpsaitypeset.dll`
- 样本: 4,582,904 bytes, PE32 x86 (machine=0x14c), image_base=0x10000000
- 方法: rg -a -b -o + Python(stdlib) 零执行静态提取。未加载、未运行 DLL。
- 结论 verdict: **partial**（算法原语+全流程线索齐备；密钥为运行时注入，DLL 内无嵌入密钥）

## 0. PE 布局（偏移→节换算基准）

| 节 | raw 范围(文件偏移) | RVA |
|---|---|---|
| .text | 0x00000400–0x0030C200 | 0x1000 |
| .rdata | 0x0030C200–0x003FA800 | 0x30D000 |
| .data | 0x003FA800–0x0040C400 | 0x3FC000 |
| .rsrc | 0x0040C400–0x0040CC00 | 0x414000 |
| .reloc | 0x0040CC00–0x00459C00 | 0x415000 |

导出表仅 4 项（插件契约，非 AES）: ord1 `GetExtensionJsApiObj` rva=0xC140, ord2 `initPlugin` 0xC150, ord3 `start` 0xC160, ord4 `stop` 0xC350。
导入 24 个 DLL：Qt5CoreKso/Qt5GuiKso/Qt5WidgetsKso/Qt5NetworkKso、krt/kso/ksolite/kshell/kbase/kprometheus/kdownload/wpscore、KERNEL32/MSVCP140/VCRUNTIME140/crt-*。**无 BCrypt/CryptAPI/openssl 导入 → AES 为自研静态链接代码（KAesEncrypt），非系统库。**

## 1. 关键词命中偏移表（122 处，去噪后）

| 词 | 命中 | 关键偏移（文件偏移, 十进制） | 判定 |
|---|---|---|---|
| aes | 2 | 4069515, 4069593 | **KAesEncrypt 加/解密符号（日志内嵌 __FUNCDNAME__），代码在体内** |
| QCryptographicHash | 1 | 4129850 | 静态链接 kso_qt Qt 的 hash 静态方法符号 |
| Base64 | 5 | 4131802, 4151832 (fromBase64×2 重载), 4135370 (toBase64), 3274436 (imageBase64 日志) | Qt 字节串编解码原语 |
| b64 | 5 | 4246057(.rsrc manifest 撞词), 4230296/4228900/4203153/4202597(lambda RTTI 哈希撞 b64 字符) | 全部为撞词，非密钥 |
| Decode | 1 | 3453924 "Decode failed." (cppjieba 分词库日志) | 无关 |
| template | 70 | 见 §3 集群 | 模板体系字串 |
| publictemplates | 3 | 3443352, 3443420, 3269508 | **API 端点** |
| customtemplates | 1 | 3220236 | 资源路径 `/customtemplates/` |
| presettemplates | 2 | 3220780, 3220832 | 资源路径 `/presettemplates/` |
| nationalstandard | 2 | 3220812 (ASCII), 4180816 (UTF-16) | **样式预设名（"National standard GB7713" 学位论文国标），非加密** |
| desc_base | 2 | 3269525, 3270281 | **端点族 `/desc_base_template`（按描述生成模板）** |
| KFormat | 29 | 4236499–4242428 等 | RTTI：KFormatAdjust/KAdminPolicyFormatAdjust/KBidFormatAdjust/KContractFormatAdjust/KFormatAtomicMoldingOpBase → 排版格式调整类，非加密 |
| xor/XOR/QAESEncryption | 0 | — | 无 |

## 2. 解密原语铁证（AES-CBC，符号级）

.rdata 4069514 / 4069592（RVA 0x3E268B / 0x3E26D9，VA 0x103E268B / 0x103E26D9）：

```
?aesEncryptCBCMode@KAesEncrypt@@SA_NABVQByteArray@kso_qt@@00AAVQString@3@@Z
?aesDecryptCBCMode@KAesEncrypt@@SA_NABVQByteArray@kso_qt@@0ABVQString@3@AAV23@@Z
```

反修饰（MSVC）：
- `static bool KAesEncrypt::aesEncryptCBCMode(const kso_qt::QByteArray&, const kso_qt::QByteArray&, const kso_qt::QByteArray&, kso_qt::QString&)` → (数据, key, iv) 三入 + 出参 QString（疑 base64/hex 文本）
- `static bool KAesEncrypt::aesDecryptCBCMode(const kso_qt::QByteArray&, const kso_qt::QByteArray&, const kso_qt::QString&, kso_qt::QByteArray&)` → (数据, key, iv或参数串) 入 + 明文 QByteArray 出

要点：
1. 这些修饰名是日志宏内嵌 `__FUNCDNAME__` 产物（同簇伴随 `void __thiscall KDescMultiToTemplateAction::onStart(void)` 等明文函数名），证明 **KAesEncrypt 代码体静态链接在本 DLL 内**，可被反编译定位。
2. 同簇邻居：`KDomainMgr::parseKeyFromCookie`（cookie→key 解析，4069446）、`KDcInfoCDetail::getHdid/getHdid3`（硬件设备号，4069676/4069728）、`JsonHelper::convertStringToQJson`（4069780）→ 该通用工具库簇里 key 来源线索：cookie 与设备号。
3. KAesEncrypt 属 WPS 公共库（邻居还有 KDrawHelper 等），其他 WPS 模块 DLL 应同样内嵌，可交叉验证。

## 3. 密钥通道：mk_key（运行时注入，非嵌入）

- `setMkKey` @3216488 — JS 桥 API 方法名（宿主 JS 层调用来下发密钥）
- `mk_key` @3217744 — JSON 字段名
- `mk_key is empty` @3217752 — 空密钥报错日志
- 同区 JS API 面：getPresetTemplateList / httpRequest / copilotCallV5 / triggerTypesetWithCustomTemplate / triggerTypesetWithPresetTemplate / triggerTypesetWithSystemTemplate / triggerTypesetWithModelEssay / gxhTriggerTypesetWithFormatInfo / triggerDirectTypeset …

结论：**AES key 不在 DLL 内**，由宿主（JS/账号态/cookie）经 setMkKey 运行时注入。

## 4. 候选密钥表（138 条 16/24/32 高熵串全部排雷）

- 138 条命中全部为普通标识符/QMetaObject 串/RTTI 名（queryAllFunction、template_version、kwpsaitypeset_H1…Hc 等），详见 key_candidates.txt。
- 32 位 hex 串集群 @4196244–4198596 等约 60 条 = MSVC lambda RTTI 哈希 `.?AV<lambda_<md5>>@@`，非密钥。
- base64 密钥形态（22/31/43 字符带 padding）全文搜索 **0 命中**。
- `0123456789ABCDEF` @3465392 = 十六进制编码表。
- `AUTOAIPBHZFFKG2736` @3213876（18 字符，夹在 SmartLayout* 模式名与 custom_template 之间）= 渠道/产品模式代码，长度不符且语义明确，非密钥。
- `template_sha256` @3217204、`integritycheckvalue` @3218408 = 完整性校验字段名（QCryptographicHash::hash 在体内），非密钥本体。

## 5. 模板加载与解密流程推断（证据链）

模板清单 schema（.rdata 3216080–3217300 JSON 键集群）：
`use_http/api_path/api_method`（网络开关）→ `template_list / private_template_list / system_template_list`（@3266080/3266104）→ 条目字段 `template_id / module_id / template_version / template_name / template_description / template_file_path / file_data / encrypted / encrypt / external_encrypt_doc / template_sha256 / integritycheckvalue / stylesheet / wps_styleset_preset_item / wps_styleset_docer_item`。伴随 `certificate check failed` @3217952、`wps_certificate_checkresult` @3265940。

API 端点（全字面量）：
- `/templates/smarttypeseting/publictemplates/public_official_template` @3443352（公文模板全路径）
- `/publictemplates/public_official_template` @3443420（拼接基）
- `/publictemplates/desc_base_template` @3269508（KDescMultiToTemplateAction 入口）
- `/desc_base_template_` @3270280 + `.docx` @3270272（按 id 拼文件）
- `/office/v5/ai/generator/document/headline` @3266408

资源包路径体系：`/mui/<locale>/` + `/customtemplates/`(3220236) + `/presettemplates/`(3220780/3220832) + `/presettemplates/thesis_logo/`(3220832) + `/background/` `/thumbnail/` `/theme/` `/res/icons.data`；Qt 资源 `kwpsaitypeset.kuip` / `kwpsaitypeset_dark.kuip`（3214388/3214412）、`:/icons`。

样式 schema（3220964–3221164）：`style_name / font_name_CJK / font_name_ASCII / font_size / font_bold / font_italic / para_alignment / line_spacing / para_margin / para_indent / basestyle_name / font_strike_through / font_color / previewProperty / styleInfo`；预设名含 `nationalstandard`（国标 GB7713 学位论文）、`standard`、`cowork`。

个性化(gexinghua)调试管线（UTF-16 @4179876–4180404，`test_output/`）：`01_doc_json.json → 02_server_response.json → 03_doc_json_post.json → 04_template_styles.json → 05_style_name_mapping.json`，模板判定 JSON 模板 `{"first_type":"%1","second_type":"%2"}`、`{"current":"%1","recommend":"%2"}` → 文档→JSON→服务端→样式映射→套版 五段流。

流程推断（带证据）：
1. `initPlugin/start` 起 JS 桥（GetExtensionJsApiObj），宿主 JS 注入 `mk_key`（§3）；同库有 cookie/设备号取 key 通道（§2.2）。
2. `getPresetTemplateList`/清单拉取：`use_http+api_path` 直连端点，或走 `/mui/<locale>/presettemplates/` 资源包；下载经 kdownload.dll（KDownloadMgr/KDownloadTask::setUrl/setSavePath/setEnableSSL）。
3. 校验：`template_sha256`/`integritycheckvalue` 经 QCryptographicHash::hash（体内）+ `certificate check failed` 分支。
4. 解密：条目 `encrypted/encrypt/file_data` → `KAesEncrypt::aesDecryptCBCMode(data, key=mk_key, iv, out)`（AES-CBC，§2）→ 明文 .docx/样式 JSON；Base64 仅作传输编码（fromBase64/toBase64、图片 `data:image/png;base64,%1`、imageBase64）。
5. 套版：triggerTypesetWithTemplate* 系列 + KFormatAdjust/KBidFormatAdjust/KContractFormatAdjust 等格式调整类落版。

## 6. 下一步建议

1. REA/Ghidra：打开本 DLL，对字符串 VA 0x103E26D9（aesDecryptCBCMode 日志名）做 xref → 定位函数体，反编译提取 IV 构造与填充方式（是否 key=md5(mk_key) 之类派生）。
2. 运行时挂钩（需另行批准）：hook JS 桥 `setMkKey` 或 `KAesEncrypt::aesDecryptCBCMode` 第二参即可截获真实 mk_key/IV；或抓 `mk_key is empty` 日志路径反推注入源。
3. 追宿主：同 addons 目录 JS 包（调用 setMkKey 的一方）与 `KDomainMgr::parseKeyFromCookie`（公共库）是 key 分发链上游。
4. 交叉验证：KAesEncrypt 属公共库，可在其他 WPS DLL（ksolite/kshell 等）中找同名符号比对实现。

## 7. 产物清单（同目录 work/decrypt/）

hits_all.txt（122 命中全量）、ctx_windows.txt（逐命中±256B 可读串）、key_candidates.txt（138）、named_keys.txt（65）、crypto_markers.txt（19）、utf16_hits.txt（7）、sections.txt、exports.txt、imports.txt、region_dumps.txt（四大热区宽窗 ASCII+UTF16）、analyze_dll.py、dump_regions.py（stdlib 复现脚本）。
