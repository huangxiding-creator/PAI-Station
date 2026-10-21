# 工具：wps_toolcall_fmt

> **本文档定位**：`wps_toolcall_fmt` **通用**工具说明（品类查询、`ai_typeset`、模板搜索等）。

## 1、函数签名

```
wps_toolcall_fmt(opString, paramString)
```
| 参数          | 约束                                   |
| ------------- | --------------------------------------|
| `opString`    | 字符串，**必须**为 §2 操作类型一览|
| `paramString` | 必须是**合法 JSON** 字符串，即使无参也须传 `"{}"`，必须对paramString进行**Json格式校验**      |

**注意:** 必须注意特殊字符在string中加转义，如"->\"; '->\'; ``->\\  等等。 中文汉字不用进行`Unicode 转义序列`,中文字符必须直接以原字面量书写（如 "黑体" 而非 "\u9ed1\u4f53"。

## 2、操作类型一览

| opString          | 功能                  | paramString           | 
| ----------------- |---------------------|------------------------|
| `get_doc_type`    | 查询文档品类（通用/四品类）      | `"{}"`          |
| `get_doc_type_v2` | 查询当前文档细分品类          | `"{}"`          |
| `doc_can_typeset` | 判断当前文档是否适合排版        | `"{}"`        |
| `ai_typeset`      | 执行排版             | JSON 字符串，见 §4.3 |
| `search_template` | 搜索模板             | JSON 字符串，见 §4.4 |

## 3、doc_type 品类枚举

`doc_can_typeset` 与 `ai_typeset` 的 `doc_type` 参数**仅允许**下表品类值，或者为空`""`；**禁止**传入 `get_doc_type_v2` 返回的 `stage1` / `docType` 原值。


| 品类值                   | 含义   |
| --------------------- | ---- |
| `SmartLayoutOfficial` | 公文   |
| `SmartLayoutThesis`   | 论文   |
| `SmartLayoutContract` | 合同   |
| `SmartLayoutBid`      | 标书   |
| `SmartLayoutExam`     | 试卷   |

## 4、操作详解

### 4.1 get_doc_type

- **业务用途**：查询当前文档所属**粗粒度品类**（四品类或通用）。接口是**幂等只读**操作，失败可重试一次。
- **与 `get_doc_type_v2` 的区别**：本接口返回单个 `categoryId` 字符串；`get_doc_type_v2` 返回含 `stage1` / `docType` 的细分 JSON。两者 `paramString` 均无业务入参，差异仅在 `opString`。
- **paramString**：无参，传 `"{}"`
- **返回值**：成功时前缀为 `wps_toolcall_fmt success:`，其后为 **categoryId 字符串**（非 JSON）；失败时 `failed:`；异常时 `exception:`。

| 返回值 | 含义 |
| --- | --- |
| `SmartLayoutOfficial` | 公文 |
| `SmartLayoutThesis` | 论文 |
| `SmartLayoutContract` | 合同 |
| `SmartLayoutBid` | 标书 |
| `SmartLayoutGen` | 通用 |

- **调用示例**：
```
wps_toolcall_fmt("get_doc_type", "{}")
```

- **返回示例**（成功，公文）：
```
wps_toolcall_fmt success:SmartLayoutOfficial
```

### 4.2 get_doc_type_v2

- **业务用途** : 查询当前文档所属的细分品类，方便后续按照品类划分排版。接口是**幂等只读**操作，接口失败可重试一次。
- **paramString** 字段：无参，传 `"{}"`。
- **返回值**：成功时前缀为 `wps_toolcall_fmt success:`，其后为 JSON 字符串；失败时 `failed:`；异常时 `exception:`。


| 字段        | 必须  | 类型     | 说明   |
| --------- | --- | ------ | ---- |
| `stage1`  | 是   | string | 一级分类 |
| `docType` | 是   | string | 二级分类 |
| `college` | 否   | string | 补充说明 |
| `school`  | 否   | string | 补充说明 |


- **返回示例**：

```json
{
  "stage1": "continuing_education",
  "docType": "adult_education",
  "college": "继续教育学院",
  "school": "xxx学校"
}
```
| 字段                   | 用途                                               |
| -------------------- | ------------------------------------------------ |
| `stage1` / `docType` | 推断最接近的 `SmartLayout*` 品类枚举；提取模板搜索关键词（公文文种、论文类型等） |
| `school` / `college` | 论文类：有则**优先**作模板搜索的 `--keywords`                  |


 `official_document` 等公文语义 → `SmartLayoutOfficial`

 学位/课程/学术/继续教育等论文语义 → `SmartLayoutThesis`

 合同语义 → `SmartLayoutContract`；

 标书/投标语义 → `SmartLayoutBid`

 其余品类（商务、工作、通用文书等）**不匹配**以上四枚举时，**禁止**使用 `mode=category`；走路径 Z 美化排版（见 `references/path-beauty-rule.md`）

- **调用示例**：

```
wps_toolcall_fmt("get_doc_type_v2", "{}")
```

### 4.3 ai_typeset

- **业务用途**: 开始排版，每次调用会重新生成排版。若接口失败，除非流程中指定了重试流程，否则不要重试。
- **paramString** 字段：


| 字段                    | 必须       | 类型     | 说明                                                                |
| --------------------- | -------- | ------ | ----------------------------------------------------------------------- |
| `mode`                | 是        | string | 排版类型，**仅** `category` / `template` / `rule` 三种                          |
| `doc_type`            | 视 `mode` | string | mode 为 `category` 或 `template` 时必填，见 §doc_type 品类枚举；`mode=rule` 时传 `""` |
| `template_name`       | 视 `mode` | string | mode 为 `template` 时必填                                                   |
| `rule_file`           | 视 `mode` | string | 规范文档**本地绝对路径**                                                          |
| `rule_string`         | 视 `mode` | string | 自定义格式要求字符串原文，勿删减用户自定义格式要求                                               |
| `rule_mode`           | 否        | string | 仅 `mode=rule`：`auto` / `model_essay` |
| `is_manage_aigcstate` | 是        | bool   | **始终为 `false`**                                                         |


**各 mode 必填约束**：


| mode       | 含义    | 必填字段                                                |
| ---------- | ----- | --------------------------------------------------- |
| `category` | 按品类排版 | `doc_type`且非空                                       |
| `template` | 按模板排版 | `doc_type`（须为四枚举之一；推断不清楚时传 `""`）+ `template_name` |
| `rule`     | 按规范排版 | 默认（`rule_mode` 缺省/`auto`）：`rule_file` 与 `rule_string` 至少一项非空；`rule_mode=model_essay`：须 `mode=rule` 且 `rule_file` 非空 |


**调用示例**：

按品类：

```
wps_toolcall_fmt("ai_typeset", '{"mode":"category","doc_type":"SmartLayoutOfficial","template_name":"","rule_file":"","rule_string":"","is_manage_aigcstate":false}')
```

按模板：

```
wps_toolcall_fmt("ai_typeset", '{"mode":"template","doc_type":"SmartLayoutThesis","template_name":"中国地质大学（武汉）_本科_全院系","rule_file":"","rule_string":"","is_manage_aigcstate":false}')
```

按规范：

```
wps_toolcall_fmt("ai_typeset", '{"mode":"rule","doc_type":"","template_name":"","rule_file":"<规范文档绝对路径>","rule_string":"正文宋体小四","rule_mode":"auto","is_manage_aigcstate":false}')
```

按范文附件（强制范文排版）：

```
wps_toolcall_fmt("ai_typeset", '{"mode":"rule","doc_type":"","template_name":"","rule_file":"<范文绝对路径>","rule_string":"","rule_mode":"model_essay","is_manage_aigcstate":false}')
```

### 4.4 search_template

- **业务用途**: 搜索排版模板
- **paramString** 字段：

| 参数名称 | 类型 | 是否必须 | 字段说明 | 备注 |
| --- | --- | --- | --- | --- |
| `keywords` | []string | 是 | 搜索关键词数组 | 按模板名称匹配，最多 10 个 |
| `template_kind` | int | 是 | 模板类型 | `4`：公文；`5`：论文 |
| `limit` | int | 否 | 单页返回数量 | |
| `offset` | int | 否 | 分页偏移量 | |

- **返回值**：

| 参数名称 | 类型 | 字段说明 | 备注 |
| --- | --- | --- | --- |
| `template_list` | []object | 匹配的模板列表 | |
| `template_list[].template_id` | string | 模板 ID | 可作为排版接口 `theme_params.theme_id` 传入，`theme_origin` 设为 `system` |
| `template_list[].template_name` | string | 模板名称 | 如 `中国地质大学（武汉）_本科_全院系` |
| `template_list[].template_describe` | string | 模板描述 | |
| `template_list[].template_kind` | int | 模板类型 | 同请求参数 `template_kind` |
| `template_list[].template_label` | int | 模板标签 | |
| `template_list[].template_sha256` | string | 模板文件哈希 | |
| `template_list[].logo_ks3_url` | string | 模板 Logo 图片 URL | 带签名的临时链接 |
| `template_list[].logo_sha256` | string | Logo 图片哈希 | |
| `template_list[].update_time` | int | 更新时间戳 | 毫秒级或秒级 |
| `total` | int | 匹配总数 | |



- **返回示例**：

成功时输出 JSON：

```json
{
  "code": 0,
  "msg": "success",
  "data": {
    "template_list": [
      {
        "template_id": "967806947656990720",
        "template_name": "中国石油大学（北京）_博士_全院系",
        "template_describe": "中国石油大学（北京）",
        "template_kind": 5,
        "template_label": 0,
        "template_sha256": "01fd72aa6dc8f0c26ed19a1a8c0459e7185b76b0a6107e495458407654cbe06d",
        "logo_ks3_url": "https://...",
        "logo_sha256": "46a2132022ade584cebe51109e62eb50efadb3ccd132cf23950dfb0f8440edc9",
        "update_time": 1705546177
      },
      {
        "template_id": "967806948172890112",
        "template_name": "中国石油大学（北京）_硕士_全院系",
        "template_describe": "中国石油大学（北京）",
        "template_kind": 5,
        "template_label": 0,
        "template_sha256": "27fc7a8737349bb78e053ae4107cb382fc3dfe60ef8b06545561ce4ad400744a",
        "logo_ks3_url": "https://...",
        "logo_sha256": "46a2132022ade584cebe51109e62eb50efadb3ccd132cf23950dfb0f8440edc9",
        "update_time": 1705546177
      }
    ],
    "total": 2
  },
  "more": null
}
```

失败时输出 JSON：

```json
{
  "success": false,
  "error": "错误信息",
  "failed_step": "search_template",
  "request_id": "请求ID"
}
```
- **调用示例**：

```
wps_toolcall_fmt("search_template", '{"keywords":["关键词1","关键词2"],"template_kind":<4|5>,"limit":10,"offset":0}')
```

## 5、错误格式示例
`opString` 必须严格匹配 §2 操作类型一览中的枚举值。`paramString` 必须为合法 JSON 字符串，**必须**进行**Json合法性校验**(特别关注特殊字符加上**转义**)。
```
wps_toolcall_fmt("wps_toolcall_fmt", "ai_typeset")    //错误, wps_toolcall_fmt不是合法opString，paramString 不是 JSON

wps_toolcall_fmt("ai_typeset", '{"mode=category" && "doc_type"="SmartLayoutContract",...}')  //错误，paramString不是合法Json

wps_toolcall_fmt("ai_typeset", '{"mode":"category","doc_type":"continuing_education",...}')  //错误，误用 get_doc_type_v2 返回的 stage1 / docType 原值

wps_toolcall_fmt("ai_typeset", '{"mode":"template","doc_type":"Official",...}')  //错误, 误用短名或自行臆造值；Official不是合法doc_type枚举值，须用 `SmartLayoutOfficial` 等枚举全名

wps_toolcall_fmt("ai_typeset", '{"mode":"rule","doc_type":"","template_name":"","rule_file":"","rule_string":"标注"关键词"字样，黑体加粗五号字","is_manage_aigcstate":false}')  //错误, rule_string中"关键词"的引号在字符串中没加\转义
```
