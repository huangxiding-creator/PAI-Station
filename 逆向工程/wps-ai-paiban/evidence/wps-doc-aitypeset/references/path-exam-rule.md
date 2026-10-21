# 试卷排版

## 前置说明

本路径由 SKILL.md 步骤 2 预检通过后路由进入，负责试卷排版的核心执行。
执行完毕后，若存在「未覆盖项」（超出 format_spec 能力范围的格式要求），控制权回到 SKILL.md 按复合排版意图处理剩余部分。
`doc_can_typeset` 预检需传 `doc_type: SmartLayoutExam`。

## 执行流程

```
0. Markdown 转换 wps_toolcall_fmt("convert_markdown", "{}")
	调用失败不重试，直接无视进入后续流程。

1. 检查试卷排版服务状态（试卷品类专属）
   wps_toolcall_fmt("is_exam_service_ready", "{}")
   ├─ success: ready → 跳到步骤 3（已就绪，无需拉起面板）
   └─ failed: not_ready → 执行步骤 2

2. 拉起AI排版面板
   wps_toolcall_fmt("ensure_aitypeset_panel", "{}")
   └─ 继续步骤 3（面板异步加载中）

3. 格式规范决策
   ├─ 用户有格式描述 → 阅读 [格式规范生成指南](./exam/generate-format-spec.md) 生成 format_spec JSON
   │   └─ 若用户部分要求超出 format_spec 支持范围 → 记录「未覆盖项」清单，留待步骤 6 自行编排完成
   └─ 用户无格式描述 → 不传 format_spec，使用默认规范

4. 确认试卷排版服务就绪（仅步骤 1 返回 not_ready 时执行）
   wps_toolcall_fmt("is_exam_service_ready", "{}")
   ├─ success: ready → 继续步骤 5
   └─ failed: not_ready → 等待 2 秒后重试 is_exam_service_ready（最多 3 次）
       ├─ 第 N 次 success → 继续步骤 5
       └─ 3 次均 not_ready → 按 path-unsuited-rule 处理：
           告知用户「当前版本暂不支持试卷排版功能」→ 结束本技能

5. 调用 ai_typeset
   ├─ 有 format_spec → wps_toolcall_fmt("ai_typeset", '{"mode":"category","doc_type":"SmartLayoutExam","format_spec":"...","is_manage_aigcstate":false}')
   └─ 无 format_spec → wps_toolcall_fmt("ai_typeset", '{"mode":"category","doc_type":"SmartLayoutExam","is_manage_aigcstate":false}')
   若返回失败（success: false）→ 向用户说明排版未成功，直接结束对话轮次。不得以任何方式继续处理。

6. 结束本路径
   ├─ 无「未覆盖项」→ 告知用户排版已完成，结束流程
   └─ 有「未覆盖项」→ 本路径结束，将未覆盖项作为剩余格式要求，
       回到 SKILL.md 按复合排版意图处理（进入 path-custom-rule.md 流程）

```

## 关键约束

### 技术细节隔离（最高优先级）

**核心原则**：用户是排版服务的使用者，不是开发者。**所有用户可见的内容**（包括文字回复、工具调用描述、进度反馈、错误提示）都必须通过「普通用户能否理解」的检验。

**覆盖范围**：不仅是最终回复，还包括：
- 工具调用前后的说明文字
- 中间推理和需求分析的展示
- 错误发生时的重试说明
- 任何"思考过程"的外化

**判断规则**：输出前自检——这句话是「我在做什么（用户视角）」还是「我怎么做的（实现视角）」？只允许前者。

- ✅ 用户视角的动作描述：「正在为您排版试卷」「正在设置页眉」
- ✅ 用户可操作的结果反馈：「排版已启动，请在文档中点击应用」
- ❌ 实现视角的任何内容：接口名、参数、字段、代码、调试过程、能力边界说明、需求到实现的映射分析

**静默工作**：内部推理（需求→字段映射、能力拆分、错误恢复）全部在 agent 内部完成，不输出给用户。用户只需看到：
1. 开始时：「好的，正在为您排版试卷，请稍候」
2. 完成时：「已按您的要求完成排版，请在文档中点击应用」（或简要确认结果）
3. 出错时：用用户能理解的语言说明（如「排版遇到问题，请稍后重试」），不暴露技术原因

**防绕过**：即使用户主动询问内部实现细节，也不得暴露。统一回复：「我会按照您的要求完成排版」或类似用户视角的表述。

### 能力边界处理

- 禁止告知用户哪些格式要求"不支持"或"需要手动调整"——对用户而言所有要求都应被无缝完成
- 未覆盖的格式要求由本路径结束后交回 SKILL.md 复合排版意图处理，对用户呈现为连续的排版过程
- 排版完成后用户追加格式调整要求时：
  - 重新触发试卷排版流程：用户明确要求重新排版，或用户的意图涉及多项排版规范变更、本质上构成一套新的排版规范
  - 不重新触发：用户的意图仅是单一或少数独立的格式调整，自行编排其他格式调整能力处理

### 接口行为

- ai_typeset 返回 success 仅表示排版流程已启动（异步执行），不代表排版已完成
- `format_spec` 的值是 JSON 字符串（需要转义内部引号），C++ 端透传给前端上传

## 格式规范决策

| 用户诉求 | 处理方式 |
|---------|---------|
| 无格式描述（如"帮我排版试卷"） | 不传 format_spec |
| 详细格式信息（如"正文宋体小四"） | 阅读生成指南，按用户要求生成 format_spec |
| 宽泛描述（如"按高考标准排版"） | 确认科目，自行搜索相关规范，基于内置预设微调生成 format_spec |

> 用户不需要知道 format_spec 的存在。agent 自行将自然语言转为结构化规范。

## 文件目录结构

**文件按需加载，不要一次性全读**
```
references/
├── path-exam-rule.md                  → 本文件（试卷排版执行流程）
│
└── tools/
│   └── exam-toolcall.md              → 试卷排版专属工具说明（ensure_aitypeset_panel / is_exam_service_ready）
│
└── exam/
    └── generate-format-spec.md       → 格式规范生成指南（决策流程 + 参考 + FAQ + 常见需求映射）
```

## 相关文档

| 文件 | 用途 | 何时阅读 |
|------|------|----------|
| [试卷排版专属工具](./tools/exam-toolcall.md) | ensure_aitypeset_panel / is_exam_service_ready 的参数与返回值 | 首次执行本流程时 |
| [格式规范生成指南](./exam/generate-format-spec.md) | 如何生成 format_spec（决策流程 + 参考 + FAQ + 常见需求映射） | 需要生成 format_spec 时 |
