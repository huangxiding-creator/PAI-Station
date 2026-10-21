# 按论文排版

## 阅读 `references/tools/search-template-guide.md` 按照规则检索模板

- 如果用户未指定任何模板，则使用细分品类的识别结果作为关键词，特别是返回的`school/college`
- 如果用户想使用的模板与细分品类结果冲突时，`ask_user`澄清后，使用澄清结果作为关键词
- 如果上述信息无法确定使用哪个模板，则通过如下`ask_user`来澄清
```
ask_user({
  "type": "select",
  "question": "请选择论文模板，或在「其他」中填写学校/机构名称",
  "options": ["国家标准 GBT7713"],
  "multiple": false
})
```
### 用户选{国家标准 GBT7713}，就检索`国家标准 GBT7713`进行排版
### 用户在[其他]中填写了信息，理解意图是否为学校名称信息，是则基于学校名称检索，否则理解意图重新路由

## 基于模板检索的结果，分为如下情况

### 检索出多个候选模板，则给出选项

```
ask_user({
  "type": "select",
  "question": "找到多个匹配模板，请选择",
  "options": ["{模板名1}", "{模板名2}", ...],
  "multiple": false
})
```

### 检索出的模板为空，则给出选项

```
ask_user({
  "type": "select",
  "question": "请选择论文模板，或在「其他」中填写学校名称",
  "options": ["国家标准 GBT7713", "提供范文/格式规范文档"],
  "multiple": false
})
```
#### 用户选{国家标准 GBT7713}，就检索国家标准 GBT7713进行排版，走(mode=template)
#### 用户选范文或格式说明，就重新路由
#### 用户在[其他]中填写了信息，理解意图是否为学校名称信息，是则基于学校名称检索，否则理解意图重新路由

## 6. 使用`wps_toolcall_fmt`执行排版：
- `ai_typeset(mode=template、doc_type=SmartLayoutThesis, template_name=模板名)`
