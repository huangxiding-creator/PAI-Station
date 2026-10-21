# 格式要求排版（品类识别 + 分流）

## 品类识别

1. 调用 `wps_toolcall_fmt("get_doc_type", "{}")`（失败可重试一次），获取品类结果（接口定义见 `wps-toolcall-fmt.md` get_doc_type 一节）
2. 若用户已指定品类方向，将识别结果与用户意图比对；冲突 → `ask_user` 澄清
3. 按返回值分流（取值见 `wps-toolcall-fmt.md` get_doc_type 一节）：
   - `SmartLayoutOfficial` / `SmartLayoutThesis` / `SmartLayoutContract` / `SmartLayoutBid` → 加载 `references/path-tradition-spec-rule.md` 执行
   - `SmartLayoutGen`（含工具失败且用户未指定品类）→ 加载 `references/path-strict-rule.md` 执行

**注意**如果用户上传了附件，除非流程指定需要读取附件内容，否则无需尝试(排版工具会自行读取附件内容进行解析)