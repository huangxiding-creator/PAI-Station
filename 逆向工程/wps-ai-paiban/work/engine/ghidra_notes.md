# kwpsaitypeset.dll Ghidra 级取证笔记（WI-002 / WI-003）

- 目标: C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28802\office6\addons\kwpsaitypeset\kwpsaitypeset.dll
- SHA256: 1dd661eddeb0acbbb2eab31d2973a4f71d95ececb711f0d753e64ea57520ab50
- 提供方: REA MCP -> Ghidra 12.1.4 headless（x86 PE, image base 0x10000000, 34691 函数, 7748 字符串; PDB kwpsaitypeset.pdb GUID 9851c346-7ab5-4fbd-9114-285ab9bdd781 未加载, 函数名为 FUN_ 前缀）
- 运行库: kso_qt = QT5COREKSO.DLL; 加密 = KSOLITE.DLL; 插件管理 = KPluginManager
- 段: .text 0x10001000-0x1030ce00 / .rdata 0x1030d000-0x103fb600 / .data 0x103fc000-0x10413964

---

## WI-002 模板容器加密（结论: AES-128-CBC, 硬编码混淆密钥; 无 TEA/XOR/自实现算法）

### 密钥来源 FUN_10013020 (0x10013020) — 两个 16 字节密钥的静态混淆派生

Ghidra 伪代码摘录（载荷字符串含转义）:

    void FUN_10013020(void)
    {
      builtin_strncpy(local_28, "@i}\x18\x11:\x12\x11@N\x04@Tho%", 0x11);
      uVar1 = 0;
      do {
        local_28[uVar1] = (char)((((local_28[uVar1] + -0x6c) * 0x13) % 0x7f + 0x7f) % 0x7f);
        uVar1 = uVar1 + 1;
      } while (uVar1 < 0x10);
      local_28[0x11] = 1;
      kso_qt::QByteArray::QByteArray(in_ECX, local_28, -1);        // key1
      builtin_strncpy(local_3c, "o,\x12\x04i\x12}@}\x11%N,h|\x11", 0x11);
      // ... 同一变换 ...
      kso_qt::QByteArray::QByteArray(in_ECX + 4, local_3c, -1);    // key2
    }

去混淆变换: b[i] = ((b[i] - 0x6c) * 0x13) mod 0x7f（负数补 0x7f 归一）。py -3 实算:

- key1 = 5FE71BD15A854390（16 字节 ASCII; hex 35464537314244313541383534333930）— AES key
- key2 = 96D8FDE5E10A6321（16 字节 ASCII; hex 39364438464445354531304136333231）— AES IV / 第二密钥

### AES 包装器 FUN_1010aa10（body 0x1010aa10-0x1010aaa7, 152 字节）

    QByteArray * FUN_1010aa10(QByteArray *param_1, QByteArray *param_2, QByteArray *param_3)
    {
      if (*(int *)(*(int *)param_2 + 4) == 0) { QByteArray::QByteArray(param_1); return param_1; }
      QString::QString((QString *)&param_2);
      KAesEncrypt::aesEncryptCBCMode(param_3, param_3 + 4, pQVar1, (QString *)&param_2);
      QString::toUtf8((QString *)&param_2);   // 输出(QString 文本)转 utf8 字节
      return param_1;
    }

调用点汇编 0x1010aa5d: CALL dword ptr [0x1030dc4c]。被调者经 analyze_function 确证为
KSOLITE.DLL::KAesEncrypt::aesEncryptCBCMode（按序号导入, ordinal 0x187）。
同库还导入 aesDecryptCBCMode（ordinal 0x188, 导入名表 0x103e26d8）, 解密腿同在 KSOLITE.DLL。
签名还原: aesEncryptCBCMode(QByteArray key, QByteArray iv, QByteArray data, QString& out);
aesDecryptCBCMode(QByteArray data, QByteArray key, QString const&, QByteArray& out)。

### 容器处理宿主 FUN_1001c260（0x1001c260-0x1001d88d, 5678 字节）— AI 排版模板/样式集下载应用入口

流程（全量伪代码见 enc_FUN_1001c260_pseudo.c, 32,860 字符已全文核读）:

1. FUN_1000e470 反复读 QVariantMap 参数: file_path / file_data(base64 字符串) / encrypted 与 external_encrypt_doc(布尔标志) / openPosition; 默认映射 {"wps_styleset_preset_item":"stylesheet", "wps_styleset_docer_item":"stylesheet"}。
2. encrypted | external_encrypt_doc 标志腿:
   - file_path 存在: QFile::open(ReadOnly) -> readAll() -> FUN_1010aa10(bytes, keys) -> 输出字节 local_5c
   - 否则用 file_data: QString::toUtf8 -> QByteArray::fromBase64 -> FUN_1010aa10(b64decode(file_data), keys) -> local_5c
   - 未加密腿直接 readAll / fromBase64 原样进 local_5c（该分支布尔极性被反编译器搅进析构位掩码, 见保留意见）
3. QCryptographicHash::hash(local_5c) -> toHex -> local_dc（内容寻址哈希）
4. 落盘: FUN_100f2be0("custom") + QChar + hex -> QDir::toNativeSeparators -> QFile open(WriteOnly=2) -> write(local_5c) -> close
5. 应用: FUN_100acf50("ai_typesetting") 检查 -> FUN_100bdee0 打开文件 -> QVariantMap{open_position, request_source, function_code, ai_request_info, external_category, category_id} -> FUN_10073920(..., "wps_ai", trickId=QUuid, isPostAuthClient) 异步排版; FUN_1006a7c0()==2 时走 "WPS_layout_typeDoc_again" / "template_apply_repeat" 埋点。

【保留意见】Ghidra 把 FUN_1010aa10 被调者绑定为 aesEncryptCBCMode; 但从数据流看（产物直接写盘并作为文档打开）该腿功能上是解封装; 解密腿 aesDecryptCBCMode(ordinal 0x188) 同为本 DLL 导入, 推测由镜像函数 FUN_1010aab0 或读取侧调用（未逐字节核对 IAT 槽位, 未反编译 FUN_1010aab0）。算法与密钥结论不受影响: AES-128-CBC + 硬编码 key1/key2, base64 外壳, 无独立容器头解析（无 magic/length 字段分支）。

### 预置/自定义模板路径构造（非加密, 备查）

- FUN_10027c70（0x10027c70-0x10027efc）: krt::pluginconfig::getPluginResourcePath("kwpsaitypeset") + "/mui/"(0x103130fc) + krt::i18n::language()（krt::kcmc::support("WPSAISeparateEntryPaper") 时强制 "en_US"） + "/presettemplates/"(0x1031332c; 另有 /presettemplates/thesis_logo/ 0x10313360) + FUN_10025440(枚举->子目录) -> QDir::toNativeSeparators
- FUN_10026b80（0x10026b80-0x10026dd8）: 同前缀 + "/customtemplates/"(0x1031310c), QFileInfo::exists 存在才返回路径
- RTTI 类名: KListCustomTemplatesAction / KDownloadCustomTemplatesAction（0x103fcabc / 0x103fcae8）; checkCustomTemplateSaved（0x10315218）

---

## WI-003 oplist_exec / ai_typeset 工具分发器（四层链路, 全伪代码已存档）

### 第 1 层 顶层 op 执行器 FUN_100d7220（0x100d7220-0x100d90cc, 7853 字节; 全文 disp_FUN_100d7220_pseudo.c 50,889 字符已全文核读）

- 入参 paramString(JSON 文本); FUN_1000e470 三次取 QVariant(+0x10).toString（opString/paramString 等）; FUN_100dbf50 门; QObject::setProperty("isCurrentPostAuth", true)
- opString: trimmed -> toLower -> 逐串 operator== 分发:

| opString | handler | 备注 |
|---|---|---|
| 多个短 op（字面量被反编译器折叠, 见存档全文） | FUN_100d5510 / FUN_100d4410 / FUN_100d5200 / FUN_100d4b80 / FUN_100d4690 / FUN_100d56f0 / FUN_100d49a0 | SmartLayoutThesis/SmartLayoutGen; doc_type 键; apply 布尔 -> FUN_100bf810 返回 "apply ok." / FUN_100bf140 返回 "abandon ok." |
| open_typeset_session | 组 {"recog_result":<识别JSON>, "skip_ui":true} -> FUN_100dded0 -> 结果以 "wps_toolcall_fmt success" 为前缀 -> 解析回包 "sessionId" 存 this+0x1c | |
| oplist_exec | 通用腿 FUN_100dded0（"wps_toolcall_fmt success"）后, op 为 oplist_exec 时 FUN_100d6150(controller, paramString) | |
| is_exam_service_ready | FUN_100bac50 + 事件 "event.examPaper.startTypeset" -> "ready" / "not_ready" | |
| ensure_aitypeset_panel | KPluginManager::getPluginInstanceObject("kcopilotentrylite") + plugin_name="kwebwpsdoccomposing" + entry + silent=true -> QMetaObject::invokeMethod(obj, "triggerCopilot", Queued, ..., "QWidget*", "QString", "const QVariantMap&") -> "panel_loading_triggered" | |
| ai_typeset（及空 op 默认腿） | paramString JSON 键: detect(默认) / doc_type / template_name / rule_file / rule_string / rule_mode("auto"=DAT_10323238, "modelEssay", "model_essay") / format_spec -> 回调 FUN_100d94c0 挂接 -> FUN_100d40b0(detect, doc_type, template_name); 失败串: invalid_params / Failed to parse paramString / paramString is empty / doc_element_recog_failed / failed_to_parse_recog_result | |
| report_cowork_typeset_decision | 键 request_id / sessionId(+回退键) -> FUN_100c81e0 | |

- FUN_100d6150（oplist_exec 后处理）: paramString JSON "beauty_mode" -> 归一 full|full_beautify => "full", incremental|incremental_beautify => "incremental" -> FUN_100aba10(&mode)

### 第 2 层 wps_toolcall_fmt 会话桥 FUN_100dded0（0x100dded0 起）

- 签名 (out, KxView*, opString, paramString); paramString -> QJsonDocument::fromJson -> QJsonObject
- 会话生命周期特判: begin_typeset_write（需活动 UI 会话, 错误串 "atomic typeset session not active, call begin_typeset_write first"） / finalize_typeset_session / close_typeset_session（决策挂起: "user decision pending, call wait_decision before close", 回包 pendingDecision:true） / doc_preprocess / open_typeset_session
- 文档句柄: 控制器腿 FUN_1009d740() -> FUN_100b9e10(); 无控制器腿 KxView::coreView(param_2) -> 虚表 +0x74（槽 29）直接虚调用 — 不经 wpsmain 导出、不经 COM
- 其余一切 op -> FUN_10191bb0(doc, opString, ctx, outJson, outErr)

### 第 3 层 真分发器 FUN_10191bb0（0x10191bb0-0x10191f56, 935 字节）— 注册表 map

- opString trimmed -> toLower; 特判空串 -> FUN_1020d660; "open_typeset_session"（字符串引用点 0x10191c52）与 "oplist_exec"（0x10191d6e）亦在此函数体内特判
- 懒加载全局注册表 DAT_104131b8: operator_new(0x18) 自链表头 + 标志 0x101 -> FUN_10192160() 填充 -> _atexit(LAB_1030b230) 回收
- 查表（红黑树式 operator< 走链）命中: piVar1 = 节点+0x14（handler 对象指针）-> (**(code **)(*piVar1 + 8))(session, ctx, out) — handler 虚表槽 +8 即 exec
- 未命中: QString::arg(DAT_104002f0, QChar(0x20), op) 写错误串（unknown op 模板）

### 第 4 层 注册器 FUN_10192160 — 16 个原子 op 类（vftable-only 4 字节对象, 经 FUN_10192540 入表）

KFormatAtomicBatchSetSpanStyleOp(0), KFormatAtomicBatchSetParagraphIndentOp(1), KFormatAtomicBatchApplyParagraphStyleOp(2), KFormatAtomicBatchSetParagraphPropsOp(3), KFormatAtomicImportElementStylesOp(4), KFormatAtomicCleanupEmptyParagraphsOp(5), KFormatAtomicTrimParagraphLeadingCharsOp(6), KFormatAtomicBatchSetSpacingOp(7), KFormatAtomicBatchPageBreakBeforeOp(8), KFormatAtomicSetupPageSetupOp(9), KFormatAtomicSetupHeaderFooterOp(10), KFormatAtomicInsertTableOfContentsOp(11), KFormatAtomicUpdateTableOfContentsOp(12), KFormatAtomicSetupTocStylesOp(13), KFormatAtomicDeleteTableOfContentsOp(14), KFormatAtomicSetupTableStyleOp(15)

### op 允许清单门 FUN_100de960（0x100de960-0x100df00b, 1708 字节; 全文 reg_FUN_100de960_pseudo.c 27,247 字符已全文核读）

opString toLower 后与 22 个串逐一比对返回 1/0: begin_typeset_write, doc_preprocess, open_typeset_session, close_typeset_session, finalize_typeset_session, oplist_exec, batch_set_span_style, batch_set_paragraph_indent, batch_apply_paragraph_style, batch_set_paragraph_props, import_element_styles, cleanup_empty_paragraphs, trim_paragraph_leading_chars, batch_set_spacing, batch_page_break_before, setup_page_setup, setup_header_footer, insert_table_of_contents, update_table_of_contents, setup_toc_styles, delete_table_of_contents, setup_table_style（比对链位掩码 local_1c 0x400001 -> 0xffc0ffff 编码各 op 允许的会话状态）。

### paramString JSON 调用链结论

- 解析: kso_qt QJsonDocument::fromJson / QJsonObject::value::toString（纯 Qt, 无自研 JSON）
- 执行: 全部在本 DLL 内或经 Kx core 虚表（KxView::coreView -> vtable+0x74）/ KPluginManager 插件对象（QMetaObject::invokeMethod triggerCopilot）/ KSOLITE.DLL（KAesEncrypt）/ QT5COREKSO.DLL（kso_qt）
- 未发现 wpsmain.dll 导出调用; 未发现 COM/IDispatch 用法

---

## 关键地址速查

| 地址 | 含义 |
|---|---|
| 0x103238d4 / 0x10323914 / 0x1031e388 | open_typeset_session / oplist_exec / ai_typeset 字符串 |
| 0x1031332c / 0x1031310c / 0x103130fc | /presettemplates/ / /customtemplates/ / /mui/ |
| 0x10312424 / 0x10312430 | encrypted / external_encrypt_doc |
| 0x103e268a / 0x103e26d8 | 导入名 KAesEncrypt::aesEncryptCBCMode / aesDecryptCBCMode（KSOLITE.DLL, 序号 0x187/0x188） |
| 0x100d7220 | 顶层 op 执行器 |
| 0x100d6150 | oplist_exec 后处理（beauty_mode） |
| 0x100dded0 | wps_toolcall_fmt 会话桥 |
| 0x10191bb0 / 0x10192160 / DAT_104131b8 | 注册表分发器 / 注册器 / 注册表全局 |
| 0x100de960 | op 允许清单门 |
| 0x1001c260 / 0x1010aa10 / 0x10013020 | 加密容器宿主 / AES 包装器 / 密钥派生 |
| 0x10027c70 / 0x10026b80 | presettemplates / customtemplates 路径构造 |

## 存档文件（本目录 E:\AI-Station\逆向工程\wps-ai-paiban\work\engine\）

- ghidra_notes.md — 本笔记
- disp_FUN_100d7220_pseudo.c — 顶层分发器全量伪代码（50,889 字符, 已 100% 核读）
- reg_FUN_100de960_pseudo.c — 允许清单门全量伪代码（27,247 字符, 已 100% 核读）
- enc_FUN_1001c260_pseudo.c — 加密容器宿主全量伪代码（32,860 字符, 已 100% 核读）

注: 时间盒内 Ghidra 全程可用, 未触发 strings_full.txt 降级导出。中途一次并行 REA 调用导致会话退休, 重开 open_binary 后继续, 无数据丢失。
