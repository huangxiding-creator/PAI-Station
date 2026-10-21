# 试卷排版专属工具

> **本文档定位**：仅在试卷排版流程（`path-exam-rule.md`）中使用的 `wps_toolcall_fmt` 操作。
> 函数签名与调用规范同 [wps-toolcall-fmt.md](./wps-toolcall-fmt.md)。

## 操作一览

| opString | 功能 | paramString |
|----------|------|-------------|
| `ensure_aitypeset_panel` | 触发AI排版前端面板加载 | `"{}"` |
| `is_exam_service_ready` | 查询试卷排版服务是否就绪 | `"{}"` |

## 操作详解

### ensure_aitypeset_panel

- **业务用途**: 确保AI排版前端面板（`kwebwpsdoccomposing`）已加载。触发面板加载（异步）。接口是**幂等**操作。
- **paramString** 字段：无参，传 `"{}"`
- **返回值**：
  - `wps_toolcall_fmt success: panel_loading_triggered` — 已触发面板加载
  - `wps_toolcall_fmt failed: kcopilotentrylite not found` — 插件入口不可用

- **调用示例**：

```
wps_toolcall_fmt("ensure_aitypeset_panel", "{}")
```

### is_exam_service_ready

- **业务用途**: 查询试卷排版前端 JS 服务是否已注册就绪。接口是**幂等只读**操作，可重试。
- **paramString** 字段：无参，传 `"{}"`
- **返回值**：
  - `wps_toolcall_fmt success: ready` — 服务就绪，可以调用 `ai_typeset`
  - `wps_toolcall_fmt failed: not_ready` — 服务未就绪，建议等待后重试

- **调用示例**：

```
wps_toolcall_fmt("is_exam_service_ready", "{}")
```

