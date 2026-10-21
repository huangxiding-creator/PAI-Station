# 四品类格式要求排版

> 仅四品类（`SmartLayoutOfficial` / `SmartLayoutThesis` / `SmartLayoutContract` / `SmartLayoutBid`），由 `path-custom-rule.md` 分流进入。`SmartLayoutGen` **禁止**执行本文件，走 `path-strict-rule.md`。

## 前置说明

- rule_string 是用户输入的格式要求，必须一字不落按照用户提出的格式要求排版，**严禁**任何增删改。
- 必须注意特殊字符在 string 中加转义，如 `"`→`\"`; `'`→`\'`; `` ` ``→`\\` 等。
- 直接传转义后的 rule_string，不要先写入本地文件再传 rule_file，接口会报错。

## 执行

使用 `wps_toolcall_fmt` 按顺序执行：

### 用户录入格式要求（rule_string）

- `ai_typeset(mode=rule, rule_string=<用户格式要求>)`
- `ai_typeset` 失败后，走：`references/tools/wps-toolcall-fmt.md` §4.3 **ai_typeset失败后流程**

### 上传格式规范附件（rule_file）

- **注意**无须读取附件文档内容。如果附件为wps云文档则需要先下载到本地，不能通过该路径下文件是否存在来判断云文档是否已下载到本地（因为本地文件可能为空，实际占用磁盘空间为0），所以wps云文档都无脑下载下来，然后使用下载下来的文档路径替换附件中的文档路径。
- `ai_typeset(mode=rule, rule_file=<附件绝对路径>, rule_mode=auto)`（`ai_typeset` 内部自动识别范文/格式规范，无需先调 `classify_desc_document`）
- 如果`ai_typeset` 失败**返回值**里的 `message` 为 `desc_parse_workflow_empty` 或 `desc_parse_empty_content` → 可以改参数，重试调用一次ai_typeset
     `wps_toolcall_fmt("ai_typeset", '{"mode":"rule","doc_type":"","template_name":"","rule_file":"<用户指定的规范文件>","rule_string":"","rule_mode":"model_essay","is_manage_aigcstate":false}')`
- 如果`ai_typeset` 失败**返回值**里的 `message` 为`rule_validation_failed` 并且附件为txt格式 & 内容不为空 → 可能是txt编码问题，可以尝试用不同编码读取txt内容，然后将内容以（rule_string）方式传入重试一次。
     
- 如果`ai_typeset` 重试后仍然失败 或者不满足重试条件，终止流程。