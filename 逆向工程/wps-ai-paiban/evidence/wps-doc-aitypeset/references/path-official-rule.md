# 按公文排版

## 阅读 `references/tools/search-template-guide.md` 按照规则检索模板

- 如果用户未指定任何模板，则使用细分品类的识别结果作为关键词
- 如果用户指定的模板与细分品类结果冲突时，`ask_user`澄清后，使用澄清结果作为关键词
- 如果上述信息无法确定使用哪个模板，则通过如下`ask_user`来澄清
```
ask_user({
  "type": "select",
  "question": "公文排版需先确定文种，请选择常用文种，或在「其他」中填写",
  "options": ["公文主体", "通知", "纪要", "信函", "命令"],
  "multiple": false
})
```
### 用户在[其他]中填写了信息，理解意图是否为公文品种，是则基于用户输入的文种进行检索排版，否则理解意图重新路由

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
  "question": "提供范文或格式说明，或在「其他」中说明格式要求",
  "options": ["提供范文/格式规范文档"],
  "multiple": false
})
```
#### 用户选范文或格式说明，就重新路由
#### 用户在[其他]中填写了信息，理解意图是否为公文品种，是则基于用户输入的文种进行检索排版，否则理解意图重新路由

## 使用`wps_toolcall_fmt`执行排版：
- `ai_typeset(mode=template, doc_type=SmartLayoutOfficial, template_name=模板名)`
