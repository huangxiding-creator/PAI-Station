export const meta = {
  name: 'hzs-minutes-gen',
  description: '黄藏寺会议纪要多代理生成流水线：并行抽取→十五律起草→六路对抗审查→修复定稿JSON',
  whenToUse: '基于会议录音转写与AI摘要生成哈主任零修改标准的黄藏寺专题会纪要初稿（配套技能 hzs-minutes）',
  phases: [
    { title: 'Extract', detail: '每个源文件一个抽取代理：决定事项/实体/节点/ASR错译' },
    { title: 'Draft', detail: '按哈主任十五律起草条款内容JSON' },
    { title: 'Verify', detail: '五路规则对抗审查（隐名语气/金额选择/行动主体/实体台账/结构标点）' },
    { title: 'Fix', detail: '合并违规修复，产出终稿JSON' },
  ],
}

const SKILL = 'e:/AI-Station/.claude/skills/hzs-minutes/SKILL.md'
const RULES = 'e:/AI-Station/.claude/skills/hzs-minutes/references/style-rules.md'
const PY = 'E:/AI-Station/.venv/Scripts/python.exe'

const EXTRACT_SCHEMA = {
  type: 'object',
  properties: {
    source: { type: 'string' },
    decisions: { type: 'array', items: { type: 'string' } },
    entities: { type: 'array', items: { type: 'object', properties: { name: { type: 'string' }, note: { type: 'string' } }, required: ['name', 'note'] } },
    nodes: { type: 'array', items: { type: 'string' } },
    asr_fixes: { type: 'array', items: { type: 'object', properties: { wrong: { type: 'string' }, right: { type: 'string' } }, required: ['wrong', 'right'] } },
  },
  required: ['source', 'decisions', 'entities', 'nodes', 'asr_fixes'],
}

const DRAFT_SCHEMA = {
  type: 'object',
  properties: {
    topic: { type: 'string' },
    date: { type: 'string' },
    place: { type: 'string' },
    host: { type: 'string' },
    attendees: { type: 'string' },
    opening: { type: 'string' },
    items: { type: 'array', items: { type: 'string' } },
    placeholders: { type: 'array', items: { type: 'string' } },
    this_page_no_text: { type: 'boolean' },
  },
  required: ['topic', 'date', 'place', 'host', 'attendees', 'opening', 'items', 'placeholders', 'this_page_no_text'],
}

const VIOL_SCHEMA = {
  type: 'object',
  properties: {
    violations: {
      type: 'array',
      items: {
        type: 'object',
        properties: { rule: { type: 'string' }, issue: { type: 'string' }, fix: { type: 'string' } },
        required: ['rule', 'issue', 'fix'],
      },
    },
  },
  required: ['violations'],
}

const ASR_HINT = '常见ASR错译：而能/王能/华廉颇/安乐一局=安能一局；王菲/王慧/王辉=王飞；毛杆/毛索=锚杆/锚索；拖灌浆=超灌浆；班级会=专题会；简单效=剪断销类部件；开Y=大开挖；钢骨架/钢桁架=钢拱架。只记录有把握的更正。'

// ── Phase 1: Extract（barrier 合理：起草需要全部源的事实合并） ──
phase('Extract')
const sources = []
for (const t of (args.transcripts || [])) sources.push({ path: t, kind: '录音转写全文' })
for (const s of (args.summaries || [])) sources.push({ path: s, kind: 'AI摘要' })
log(`抽取 ${sources.length} 个源文件`)

const extracts = (await parallel(sources.map((s, i) => () => agent(
  `你是黄藏寺EPC项目会议材料的抽取代理。源文件（${s.kind}）：${s.path}\n` +
  (s.path.endsWith('.md')
    ? `直接用 Read 工具读取该 md 文件全文。`
    : `该文件是 docx，用 Bash 执行：${PY} -X utf8 -c "import sys;from docx import Document;print('\\n'.join(p.text for p in Document(sys.argv[1]).paragraphs if p.text.strip()))" "${s.path}"`) +
  `\n通读后结构化抽取（宁缺毋滥，只抽有会议决定/行动意义的）：\n` +
  `1. decisions：会上形成的决定事项、领导要求、行动安排（每条一句，含责任方与时间节点若有）。\n` +
  `2. entities：出现的关键实体（单位/部门/人名/构筑物/机组/高程），note 写其在会中的角色。\n` +
  `3. nodes：明确的时间节点（本周内/10月底前/明年汛前/每周调度等）。\n` +
  `4. asr_fixes：ASR错译更正。${ASR_HINT}`,
  { label: `extract:${sources[i].kind}:${i + 1}`, phase: 'Extract', schema: EXTRACT_SCHEMA }
)))).filter(Boolean)

log(`抽取完成 ${extracts.length}/${sources.length}，起草中`)

// ── Phase 2: Draft ──
phase('Draft')
const draft = await agent(
  `你是黄藏寺会议纪要起草代理，目标是一次性写出哈佳主任零修改的纪要初稿。\n` +
  `第一步：用 Read 读取两份规范：${SKILL} 和 ${RULES}（哈主任十五律+句式库+台账，全部遵守）。\n` +
  `第二步：基于以下抽取事实起草（会议日期：${args.meetingDate}；会议名称：${args.meetingName}）。\n\n` +
  `抽取事实JSON：\n${JSON.stringify(extracts, null, 1)}\n\n` +
  `起草要求：\n` +
  `- 8-15条、总字数1200-1800；每条=主题句+主体+动作+节点；核心条用"一是/二是/三是"总分结构内嵌同段。\n` +
  `- 参建单位从台账取实名（安能一局/先河/水电十一局/青海省电网…），取代泛称；台账无据的泛称保留。\n` +
  `- 零个人意见具名、零金额、零口语、零推测；已闭环事项不进纪要。\n` +
  `- 一把手增量用显式占位并在 placeholders 列出：战略定位句（同时按范式生成候选句写进条内并标[待确认：战略定位句]）、瓶颈工序判断、方位存疑。\n` +
  `- attendees：按材料+台账最佳推断（两字名空格对齐、（线上）标注、整理人黄细丁殿后、不写"等"），无把握的名字列入 placeholders。\n` +
  `- place 默认 211会议室；topic 用系列名不加括号；opening 用三拍导语句式。\n` +
  `- this_page_no_text 默认 true。`,
  { label: 'draft:十五律起草', phase: 'Draft', schema: DRAFT_SCHEMA }
)
if (!draft) throw new Error('起草代理失败')
log(`起草完成：${draft.items.length} 条 / ${draft.items.join('').length} 字，进入对抗审查`)

// ── Phase 3: Verify（barrier 合理：修复需要全部违规合并去重） ──
phase('Verify')
const draftJson = JSON.stringify(draft, null, 1)
const CHECKS = [
  { key: '隐名语气', rule: 'R1隐名律+R7去口语去推测+R8语气律：逐条找个人意见具名（哈佳强调/齐三红指出等）、口语词（窝在/握在/不行就）、推测句（可能/或许）、对抗性措辞（约谈/不得/一律），对抗性该软化未软化处' },
  { key: '金额选择', rule: 'R2无金额律+R12选择律：逐条找金额数字（万元/元）、内部监督细节（报量核查/成本对比）、另文办理事项、监测布点细节、次要工作面、已闭环事项（已复工/已解决的）混入' },
  { key: '行动主体', rule: 'R4行动律+R5主体精确律+R14技术变更范式：每条是否主体+动作+节点齐备；无主语的补主体；技术方案变更类是否套用"试验→旁站验证→专题研究决策→按程序上报"定式（若写成替代方案/费用/报领导决策即违规）' },
  { key: '实体台账', rule: 'R6实体精确律+R13台账+R15方位律：逐个专名核对（青海省电网非国网、委托书非委托函、座谈非约谈、安能一局、自钻式、细砂、锁脚锚杆、钢拱架、大开挖、天津电科院）；泛称"施工单位"在台账有实名时应替换；高程完成情况是否落到构筑物+段别、方位无据未占位' },
  { key: '结构标点', rule: 'R3合并律+R10格式律+R11符号标点律：条数(8-15)字数(1200-1800)；总分条是否同段内嵌；符号缩写(#、<、%)；标点误用；attendees格式（两字名空格/线上标注/无"等"/黄细丁殿后）；导语三拍；topic无括号扩展' },
]
const violations = (await parallel(CHECKS.map(c => () => agent(
  `你是对抗审查代理，任务是设法证明以下纪要草稿违反了规则。规则组：${c.rule}\n` +
  `先用 Read 读取规范全文：${RULES}\n再审查草稿：\n${draftJson}\n` +
  `只报告确凿违规（每条给 rule/issue/fix，fix 必须是可直接执行的改法）；无违规返回空数组。`,
  { label: `verify:${c.key}`, phase: 'Verify', schema: VIOL_SCHEMA }
)))).filter(Boolean).flatMap(v => v.violations || [])
log(`审查发现 ${violations.length} 处违规，修复中`)

// ── Phase 4: Fix ──
phase('Fix')
let final = draft
if (violations.length > 0) {
  final = await agent(
    `你是纪要修复代理。基于违规清单修复以下草稿，规则以 ${RULES} 为准。\n` +
    `草稿JSON：\n${draftJson}\n\n违规清单：\n${JSON.stringify(violations, null, 1)}\n\n` +
    `逐条应用 fix；有冲突的违规以更严的规则为准；不引入新违规；保持 schema 不变；placeholders 列表随之更新。返回修复后的完整JSON。`,
    { label: 'fix:合并修复', phase: 'Fix', schema: DRAFT_SCHEMA }
  )
  if (!final) { final = draft; log('修复代理失败，回退草稿') }
}

return {
  final,
  stats: {
    sources: sources.length,
    extracts: extracts.length,
    draft_items: draft.items.length,
    draft_chars: draft.items.join('').length,
    final_items: final.items.length,
    final_chars: final.items.join('').length,
    violations_found: violations.length,
    violations: violations.map(v => `[${v.rule}] ${v.issue}`),
  },
}
