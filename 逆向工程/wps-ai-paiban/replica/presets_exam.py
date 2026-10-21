"""
WPS 试卷排版规范 → 复刻件预设（理科/文科标准卷，A3 双栏试卷版式）。
蓝本（全部取值机械换算自原始规范，无人工数值）：
  E:/AI-Station/逆向工程/wps-ai-paiban/evidence/wps-doc-aitypeset/references/exam/specs/standard-science.json
  E:/AI-Station/逆向工程/wps-ai-paiban/evidence/wps-doc-aitypeset/references/exam/specs/standard-arts.json
  E:/AI-Station/逆向工程/wps-ai-paiban/evidence/wps-doc-aitypeset/references/exam/pageSettings.md（page.size=A3、margins、双栏 columns）
宿主 schema：E:/AI-Station/逆向工程/wps-ai-paiban/replica/aipaiban.py 的 PRESET_OFFICIAL（label, sectPr:{pgSz,pgMar}, rules:[{tag,pPr,rPr}], header_footer）。

单位换算（OOXML 原始值 → 宿主约定）：
  sz 半磅 ÷2 → 磅 number：21→10.5、24→12、32→16、36→18；
  spacing.line：lineRule=auto 时 ÷240 → 倍数（360→1.5x）；非 auto 按 twips→pt；
  spacing.before/after：twips ÷20 → pt（240→12pt、120→6pt；蓝本未给=0pt）；
  ind.leftChars/hangingChars/firstLineChars：÷100 → Nch（150→1.5ch、200→2ch）；
  页面 mm→pt（297→841.9pt、420→1190.6pt）；页边距 lengthWithUnit(cm) → Ncm 字符串。

tag 映射（只复用宿主现有 tag，不发明新 tag）：
  metadata.examName→doc_title（卷名）；volume.title→catalog_h1（卷级）；
  section.title→catalog_h2（大题）；material.heading→catalog_h3（材料标题）；
  question.title→main_text（题干；材料正文/选项/小题按任务约定同落 main_text）。

取舍与差异（如实备案）：
  tabs、firstParagraph、color、wordStyleName、resetFormat 不在宿主 schema，未移植；
  理科 question.firstParagraph 悬挂缩进(150)并入 main_text 的 ind（left=1.5ch + hanging=1.5ch）；
  文科 section.title 独有 spacing before=240/after=120（→12pt/6pt）；文科 question.title 仅 tabs 无缩进，故文科 main_text 无 ind；
  材料 materialFont=楷体，受 材料→main_text 的 tag 约束并入 main_text（宋体）；
  pageSettings.md 的 header=1.5cm、footer=1.75cm、gutter=0、双栏 count=2/栏距1.27cm：宿主 sectPr 仅 pgSz/pgMar，未入 schema，特此备案；
  页码：蓝本为「第X页/共N页」式，宿主 pageNumber 仅支持 arabic，按官方预设同款页脚居中。
"""

PRESET_EXAM_SCIENCE = {'label': '试卷标准卷 理科（A3）', 'sectPr': {'pgSz': {'w': '841.9pt', 'h': '1190.6pt', 'orient': 'portrait'}, 'pgMar': {'top': '2.54cm', 'bottom': '2.54cm', 'left': '3.17cm', 'right': '3.17cm'}}, 'rules': [{'tag': 'doc_title', 'pPr': {'jc': 'center', 'spacing': {'before': '0pt', 'after': '0pt', 'line': '1.5x'}}, 'rPr': {'sz': 16, 'b': True, 'rFonts': {'eastAsia': '黑体', 'ascii': 'Times New Roman', 'hAnsi': 'Times New Roman'}}}, {'tag': 'catalog_h1', 'pPr': {'jc': 'center', 'spacing': {'before': '0pt', 'after': '0pt', 'line': '1.5x'}, 'outlineLvl': 1, 'keepNext': True}, 'rPr': {'sz': 16, 'rFonts': {'eastAsia': '黑体', 'ascii': 'Times New Roman', 'hAnsi': 'Times New Roman'}}}, {'tag': 'catalog_h2', 'pPr': {'jc': 'left', 'spacing': {'before': '0pt', 'after': '0pt', 'line': '1.5x'}, 'outlineLvl': 2, 'keepNext': True}, 'rPr': {'sz': 10.5, 'rFonts': {'eastAsia': '黑体', 'ascii': 'Times New Roman', 'hAnsi': 'Times New Roman'}}}, {'tag': 'catalog_h3', 'pPr': {'jc': 'center', 'spacing': {'before': '0pt', 'after': '0pt', 'line': '1.5x'}, 'outlineLvl': 3, 'keepNext': True}, 'rPr': {'sz': 10.5, 'b': True, 'rFonts': {'eastAsia': '楷体', 'ascii': 'Times New Roman', 'hAnsi': 'Times New Roman'}}}, {'tag': 'main_text', 'pPr': {'jc': 'left', 'spacing': {'before': '0pt', 'after': '0pt', 'line': '1.5x'}, 'ind': {'left': '1.5ch', 'hanging': '1.5ch'}, 'outlineLvl': 10}, 'rPr': {'sz': 10.5, 'rFonts': {'eastAsia': '宋体', 'ascii': 'Times New Roman', 'hAnsi': 'Times New Roman'}}}], 'header_footer': {'footers': {'default': {'mode': 'set', 'pageNumber': {'show': True, 'format': 'arabic', 'align': 'center'}}}}}

PRESET_EXAM_ARTS = {'label': '试卷标准卷 文科（A3）', 'sectPr': {'pgSz': {'w': '841.9pt', 'h': '1190.6pt', 'orient': 'portrait'}, 'pgMar': {'top': '2.54cm', 'bottom': '2.54cm', 'left': '3.17cm', 'right': '3.17cm'}}, 'rules': [{'tag': 'doc_title', 'pPr': {'jc': 'center', 'spacing': {'before': '0pt', 'after': '0pt', 'line': '1.5x'}}, 'rPr': {'sz': 18, 'b': True, 'rFonts': {'eastAsia': '黑体', 'ascii': 'Times New Roman', 'hAnsi': 'Times New Roman'}}}, {'tag': 'catalog_h1', 'pPr': {'jc': 'center', 'spacing': {'before': '0pt', 'after': '0pt', 'line': '1.5x'}, 'outlineLvl': 1, 'keepNext': True}, 'rPr': {'sz': 18, 'rFonts': {'eastAsia': '黑体', 'ascii': 'Times New Roman', 'hAnsi': 'Times New Roman'}}}, {'tag': 'catalog_h2', 'pPr': {'jc': 'left', 'spacing': {'before': '12pt', 'after': '6pt', 'line': '1.5x'}, 'outlineLvl': 2, 'keepNext': True}, 'rPr': {'sz': 10.5, 'rFonts': {'eastAsia': '黑体', 'ascii': 'Times New Roman', 'hAnsi': 'Times New Roman'}}}, {'tag': 'catalog_h3', 'pPr': {'jc': 'center', 'spacing': {'before': '0pt', 'after': '0pt', 'line': '1.5x'}, 'outlineLvl': 3, 'keepNext': True}, 'rPr': {'sz': 10.5, 'b': True, 'rFonts': {'eastAsia': '楷体', 'ascii': 'Times New Roman', 'hAnsi': 'Times New Roman'}}}, {'tag': 'main_text', 'pPr': {'jc': 'left', 'spacing': {'before': '0pt', 'after': '0pt', 'line': '1.5x'}, 'outlineLvl': 10}, 'rPr': {'sz': 10.5, 'rFonts': {'eastAsia': '宋体', 'ascii': 'Times New Roman', 'hAnsi': 'Times New Roman'}}}], 'header_footer': {'footers': {'default': {'mode': 'set', 'pageNumber': {'show': True, 'format': 'arabic', 'align': 'center'}}}}}
