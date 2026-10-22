// utils/kbfactory_service.js — 知识库工厂服务层 v1（W4：本地真样本 + 八阶段施工直播）
//
// 对外契约（页面唯一依赖）：
//   generate(needText, onStage) -> Promise<blueprint>
//     onStage({i, state:'run'|'ok', count}) —— 八阶段逐段推进；resolve 蓝图样本
//     （{domain, need, tree, ratio, stats, quote, provenance, _sample}）。
//   STAGES —— 八阶段静态骨架（名称+一句话），页面渲染进度条用。
//
// v1 实现：读包内真样本（pages/kbfactory/samples/*.json，由 tools/gen_kbfactory_samples.py
// 真跑 kb_factory 编目引擎确定性生成），按样本真值算各阶段计数，定时器串行模拟推进
// （约 3.5s 走完，演示节奏）。样本路由：含 水利/水电/EPC/总承包 → 水利样本；
// 含 律师/法律/律所/诉讼/合规 → 律所样本；否则随机一份。
//
// ══ M6 预留：REMOTE_ADAPTER ══
// 后端编目接口接通后实现并打开 USE_REMOTE，页面与其余代码零改动：
//   const REMOTE_ADAPTER = {
//     generate(needText, onStage) {
//       // wx.request 上行 {need_text}，后端流式回阶段事件驱动 onStage，蓝图终值 resolve
//     },
//   };
//   const USE_REMOTE = true;

// 包内样本走 require 的 .js 包装模块（json require 工具链不收；FSM readFile 对包文件
// permission denied——1022 DevTools 双杀实测，js 模块是唯一全环境通吃读法）
const SAMPLES = {
  water: require('../pages/kbfactory/samples/sample_water.js'),
  law: require('../pages/kbfactory/samples/sample_law.js'),
};

const REMOTE_ADAPTER = null; // M6 接后端时注入（见上注），保持 null 即本地样本演示
const USE_REMOTE = false;

// 八阶段（文案纪律：零渠道名/零技术词，计数全部来自样本真值）
const STAGES = [
  { name: '需求解析', line: '听懂你的需要：主题、用途与规模' },
  { name: '编目检索', line: '在成熟分类体系里找同类书架' },
  { name: '权威分类匹配', line: '套用权威分类骨架，不另起炉灶' },
  { name: '九源扫描', line: '九处资料源头逐一探照，件件有来路' },
  { name: '扇出律整形', line: '目录撑开到刚好够用，不臃肿不空荡' },
  { name: '清单生成', line: '逐格填写文件清单与编号' },
  { name: '配比校准', line: '核心·领域·导读三档配平' },
  { name: '蓝图渲染', line: '图纸铺开，蓝图交付' },
];

const STEP_MS = 420; // 每阶段施工时长（演示节奏）
const GAP_MS = 90;   // 阶段间歇

function pickSampleKey(text) {
  if (/水利|水电|EPC|总承包/.test(text)) return 'water';
  if (/律师|法律|律所|诉讼|合规/.test(text)) return 'law';
  return Math.random() < 0.5 ? 'water' : 'law';
}

// 取包内样本（require 静态加载，同步可得；缺键收口成友好错误）
function readSample(key) {
  return new Promise((resolve, reject) => {
    const bp = SAMPLES[key];
    if (bp && bp.stats && bp.quote) resolve(bp);
    else reject({ message: '样本加载失败，请稍后再试' });
  });
}

// 各阶段计数（样本真值，非编数）
function stageCounts(bp) {
  const st = bp.stats || {};
  const seeds = (bp.provenance && bp.provenance.seed_taxonomy) || [];
  const r = bp.ratio || {};
  return [
    (((bp.need || {}).keywords) || []).length + ' 个关键要素',
    seeds.length + ' 套分类体系',
    (st.l1_count || 0) + ' 个一级大类',
    '9 处资料来源',
    (st.l2_count || 0) + ' 个主题组',
    (st.files || 0) + ' 份文件',
    (r.core || 0) + '/' + (r.field || 0) + '/' + (r.guide || 0),
    (st.dir_count || 0) + ' 个目录',
  ];
}

// 串行推进八阶段：start 时 onStage({i,state:'run',count})，到点 onStage({i,state:'ok'})
function runStages(bp, onStage) {
  const counts = stageCounts(bp);
  return new Promise((resolve) => {
    const step = (i) => {
      onStage({ i: i, state: 'run', count: counts[i] });
      setTimeout(() => {
        onStage({ i: i, state: 'ok' });
        if (i + 1 < STAGES.length) setTimeout(() => step(i + 1), GAP_MS);
        else resolve();
      }, STEP_MS);
    };
    step(0);
  });
}

function generate(needText, onStage) {
  const text = String(needText || '');
  if (USE_REMOTE && REMOTE_ADAPTER) return REMOTE_ADAPTER.generate(text, onStage);
  let bp = null;
  return readSample(pickSampleKey(text))
    .then((sample) => { bp = sample; return runStages(sample, onStage); })
    .then(() => bp);
}

module.exports = { generate, STAGES, _pickSampleKey: pickSampleKey, _stageCounts: stageCounts };
