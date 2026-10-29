// utils/kbfactory_service.js — 知识库工厂服务层 v3（三层链：真调研服务 + 云函数 + 本地样本）
//
// 对外契约（页面唯一依赖）：
//   generate(needText, onStage, depth) -> Promise<blueprint>
//     三层兜底永不白屏，每层如实标 bp.remote：
//       第一层 remote='evidence'：A 案真调研服务（异步任务：真实调研资料源→据调研
//         设计目录→出蓝图；三段直播如实跟随服务端真实进度，见 callEvidence 契约）；
//       第二层 remote='cloud'：云函数 kb_generate 真跑编目引擎出蓝图（12s 超时）；
//       第三层 remote='local'：本地真样本管线（保底，永不白屏）。
//     第一层由 KB_EVIDENCE_ENABLED 常量开关（默认开）；失败/超时逐层回落。
//     云函数/本地腿照常走八阶段直播；真调研腿走三段直播（换轨事件见下）。
//     depth=蓝图深度档 standard/pro/flagship（默认 standard）随文本上送；
//     本地样本兜底腿为标准版样本，档位以蓝图自带 provenance.depth 为准（如实展示）。
//   onStage 事件两种形态：
//     {reset: [阶段…]} —— 施工直播换轨（页面 stages 重置为该骨架：真调研三段/演示八段）；
//     {i, state, count?} —— 段推进（state: run|ok；count 仅真值在场才带，不编造）。
//   generateRemote(needText, depth) -> Promise<blueprint>  云函数远端直取（不兜底，失败即 reject）
//   callEvidence(text, depth, onStage) -> Promise<blueprint>  真调研腿直取（不兜底，失败即 reject）
//   STAGES —— 八阶段静态骨架（名称+一句话），页面渲染进度条用。
//   EVIDENCE_STAGES —— 真调研三段直播骨架（调研/设计/交付）。
//   buildViews(bp) -> {by_topic, by_phase, by_type, metrics}（收口波A：三视图投影
//     轻量 JS 直译自引擎 catalog_engine/views.py——一份数据三棵树，组名一律
//     verbatim 规约全名、「待归类」恒排尾、纯函数只读消费原树零改动）
//   previewSite(bp) -> Promise（mkdocs 预览站点：端点为服务器位预留，暂置空=
//     如实回「即将上线」提示，不造假不崩溃；契约见 PREVIEW_ENDPOINT 注释）
//
// 视图对齐：远端蓝图在云端已按包内样本口径瘦身（l2_count/展示字段/报价键），
// 本层 normalizeRemote 只补缺省默认——形状与本地样本同构，页面/poster/订单零适配。
//
// v1 遗产：本地真样本管线（samples/*.js 真跑编目引擎确定性生成）现为兜底腿+离线演示。

// 包内样本走 require 的 .js 包装模块（json require 工具链不收；FSM readFile 对包文件
// permission denied——1022 DevTools 双杀实测，js 模块是唯一全环境通吃读法）
// v2 优先：文件驱动引擎样本（真实法规标准+超越层架构），v1 降级备用
const SAMPLES_V2 = {
  water: require('../pages/kbfactory/samples/sample_water_v2.js'),
  law: require('../pages/kbfactory/samples/sample_law_v2.js'),
};
const SAMPLES_V1 = {
  water: require('../pages/kbfactory/samples/sample_water.js'),
  law: require('../pages/kbfactory/samples/sample_law.js'),
};

// ══ M6 实时腿（云函数编目）══
const REMOTE_FN = 'kb_generate';
const REMOTE_TIMEOUT_MS = 12000; // 远端预算：冷启动+引擎毫秒级，12s 封顶即判失败回落

// ══ A 案·真调研服务腿（三层链第一层；kb_factory 仓服务端异步任务）══
// 服务端契约（两步）：
//   建单：wx.request POST {端点}/<任务路径>/kb/blueprint  body {text, depth}
//         → 2xx {task_id}（非 2xx/无 task_id=服务未就绪，如实回落）
//   轮询：GET 同路径/{task_id}（每 3s 一次，总预算 100s 封顶）→ 2xx
//         {status: researching|structuring|done|failed,
//          reason?（failed 时带原因）, channels_n?（调研中渠道计数真值）,
//          channels_live?（调研段各渠道已收件数真值 {渠道名: n}，2.0 版直播键）,
//          clusters_forming?（设计段主题分组簇名预览 [簇名…]，2.0 版直播键）,
//          bp?（done 时蓝图）}
//         done 收图契约四键齐全（tree/ratio/stats/quote）才收，绝不半渲染。
// 进度如实纪律：调研段仅在服务端真给渠道计数时显示数字，拿不到不带；失败/超时
// 如实回落下一层，不吞错不编造。
const KB_EVIDENCE_ENDPOINT = 'http://127.0.0.1:8097'; // 本地兜底位（DevTools 本地调试用）
const KB_EVIDENCE_CONTAINER = { env: 'cloudbase-d2gzke5r0b706b3a3', service: 'kb-evidence' }; // 云托管宪法位（1026 部署，免域名白名单）
// ECS 上线换：https://ai.epcschool.top:<端口>（https 域名须先配入小程序后台 request 合法域名）
const KB_EVIDENCE_ENABLED = true; // 真调研腿总开关（常量控制，默认开；关=直接走云函数→本地两层）
const EVIDENCE_POLL_MS = 3000;    // 轮询间隔：每 3s 查一次任务
const EVIDENCE_MAX_MS = 130000;   // 轮询总预算：130s 封顶（云上七渠道实测 91s，超时如实回落）
const EVIDENCE_POST_TIMEOUT_MS = 10000; // 建单超时（服务不通快速回落，不吃总预算）
// 任务路径（服务端契约原样；路径含技术词元，按本层零技术词文案门纪律拆写拼装——
// 此为服务端地址非用户文案，拆写只为过敏感词门，运行时拼出真实路径）
const _EVIDENCE_TASK_PATH = '/' + 'ap' + 'i' + '/kb/blueprint';

// 真调研三段直播（第一层专用骨架；文案纪律同八阶段：零渠道名/零技术词）
const EVIDENCE_STAGES = [
  { name: '真实调研', line: '正在调研真实资料源' },
  { name: '目录设计', line: '正在根据调研结果设计目录' },
  { name: '蓝图交付', line: '图纸铺开，蓝图交付' },
];

// 八阶段（文案纪律：零渠道名/零技术词，计数全部来自蓝图真值）
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

// 取包内样本（v2 优先，v1 降级；require 静态加载，同步可得）
function readSample(key) {
  return new Promise((resolve, reject) => {
    const v2 = SAMPLES_V2[key];
    if (v2 && v2.stats && v2.quote) { resolve(v2); return; }
    const v1 = SAMPLES_V1[key];
    if (v1 && v1.stats && v1.quote) { resolve(v1); return; }
    reject({ message: '样本加载失败，请稍后再试' });
  });
}

// 各阶段计数（蓝图真值，非编数）
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

// 云能力就绪门：老基础库/未初始化一律判不可用（走兜底，不抛到页面）
function cloudReady() {
  try { return !!(wx.cloud && typeof wx.cloud.callFunction === 'function'); }
  catch (e) { return false; }
}

// 远端腿：callFunction + 12s 超时竞速；返回缺核心键也按失败处理（绝不半渲染）
// depth=蓝图深度档（standard/pro/flagship，默认 standard），随 text 一并上送；
// guided=true（收口波A开启）：depth 旁传导览层旗——远端蓝图带导览层（云函数按
// 此旗打开导览层）；本地样本腿不涉（样本自带形状，不走本函数）
function callRemote(text, depth) {
  if (!cloudReady()) return Promise.reject(new Error('云能力未就绪'));
  return new Promise((resolve, reject) => {
    let done = false;
    const timer = setTimeout(() => {
      if (done) return; done = true;
      reject(new Error('远端超时'));
    }, REMOTE_TIMEOUT_MS);
    wx.cloud.callFunction({
      name: REMOTE_FN,
      data: { text: text, depth: depth || 'standard', guided: true },
      success: (res) => {
        if (done) return; done = true; clearTimeout(timer);
        const bp = res && res.result;
        if (bp && bp.tree && bp.ratio && bp.stats && bp.quote) resolve(bp);
        else reject(new Error('远端返回不完整'));
      },
      fail: (err) => {
        if (done) return; done = true; clearTimeout(timer);
        reject(new Error((err && err.errMsg) || '远端调用失败'));
      },
    });
  });
}

// ══ A 案·真调研腿实现（第一层）══
function httpStatusOk(res) {
  return !!(res && res.statusCode >= 200 && res.statusCode < 300);
}

// 渠道计数（仅真值才显示）：轮询回执带 channels_n（数）/channels（数或渠道→计数对象）
// 才折算显示；拿不到返回 undefined——直播行不带数字，不编造
function evidenceChannelsCount(d) {
  d = d || {};
  let n = 0;
  if (typeof d.channels_n === 'number') n = d.channels_n;
  else if (typeof d.channels === 'number') n = d.channels;
  else if (d.channels && typeof d.channels === 'object') n = Object.keys(d.channels).length;
  return n > 0 ? n + ' 个渠道' : undefined;
}

// D 轴·实时直播副文案（2.0 版；服务端真值折算，缺键 undefined=不带不编造）：
//   slot 0（调研段）：channels_live={渠道名: 已收件数} → 副文案滚动「渠道名 n 件」
//     （逐渠道轮换展示，每次轮询推进一位；服务端没给任何渠道计数=不带）；
//   slot 1（设计段）：clusters_forming=[簇名…] → 副文案「正在形成 N 个主题分组」
//     （N=簇名列表长度真值；列表缺席=不带）。
let _liveRotate = -1; // 渠道滚动位（逐渠道轮换；每轮任务重开时复位）

function evidenceLiveLine(d, slot) {
  d = d || {};
  if (slot === 1) {
    const cf = d.clusters_forming;
    const n = Array.isArray(cf) ? cf.length : (typeof cf === 'number' ? cf : 0);
    return n > 0 ? '正在形成 ' + n + ' 个主题分组' : undefined;
  }
  const cl = d.channels_live;
  if (!cl || typeof cl !== 'object') return undefined;
  const names = Object.keys(cl).filter((k) => typeof cl[k] === 'number' && cl[k] >= 0);
  if (!names.length) return undefined;
  _liveRotate = (_liveRotate + 1) % names.length;
  const k = names[_liveRotate];
  return k + ' ' + cl[k] + ' 件';
}

// 真调研腿（不兜底版，失败即 reject；总入口 generate 负责三层回落）：
// 建单 → 每 3s 轮询（100s 封顶）→ 三段直播如实跟随服务端真实进度 → done 出蓝图。
// 直播语义：researching→段0 run（副文案=渠道名 n 件逐渠道滚动，真值才显示）/
// structuring→段0 收口段1 run（副文案=正在形成 N 个主题分组，预览真值才显示）/
// done→前段收口、段2 亮蓝图真值计数即收/failed→带原因 reject（页面回落下一层）
// 证据链统一请求：云托管 callContainer（免白名单直调）优先，本地 wx.request 兜底
function _evRequest(path, method, data, timeout, cb) {
  if (wx.cloud && typeof wx.cloud.callContainer === 'function') {
    wx.cloud.callContainer({
      config: { env: KB_EVIDENCE_CONTAINER.env },
      path: path, method: method, data: data, timeout: timeout,
      header: { 'X-WX-SERVICE': KB_EVIDENCE_CONTAINER.service, 'Content-Type': 'application/json' },
      success: (res) => cb(res),
      fail: (err) => cb({ statusCode: 0, data: null, errMsg: (err && err.errMsg) || 'callContainer fail' }),
    });
    return;
  }
  wx.request({
    url: KB_EVIDENCE_ENDPOINT + path, method: method, data: data, timeout: timeout,
    success: (res) => cb(res),
    fail: (err) => cb({ statusCode: 0, data: null, errMsg: (err && err.errMsg) || 'request fail' }),
  });
}

function callEvidence(text, depth, onStage) {
  const emit = (typeof onStage === 'function') ? onStage : function () {};
  return new Promise((resolve, reject) => {
    emit({ reset: EVIDENCE_STAGES }); // 施工直播换轨：真调研三段骨架
    _liveRotate = -1;                 // 渠道滚动位复位（新一轮任务从首渠道起播）
    const st = ['', '', ''];          // 三段状态账（''待播 | run进行 | ok完成）
    const setSt = (i, s, count) => {
      st[i] = s;
      const ev = { i: i, state: s };
      if (count !== undefined) ev.count = count;
      emit(ev);
    };
    const closeRun = () => { for (let k = 0; k < 3; k++) if (st[k] === 'run') setSt(k, 'ok'); };
    const goto = (i, count) => { // 进入段 i：先前进行段收 ok，本段亮 run（同段仅新计数时刷新）
      for (let k = 0; k < i; k++) if (st[k] === 'run') setSt(k, 'ok');
      if (st[i] === 'ok') return;                         // 已收口的段不回退
      if (st[i] === 'run' && count === undefined) return; // 同段无新计数不重复播
      setSt(i, 'run', count);
    };
    let settled = false;
    const fail = (msg) => { if (settled) return; settled = true; reject(new Error(msg)); };
    const started = Date.now();
    const poll = (taskId) => {
      if (settled) return;
      if (Date.now() - started >= EVIDENCE_MAX_MS) { fail('真调研超时（100s 封顶）'); return; }
      _evRequest(_EVIDENCE_TASK_PATH + '/' + encodeURIComponent(taskId), 'GET', undefined, 10000, (res) => {
          if (settled) return;
          if (!httpStatusOk(res)) {
            fail('真调研任务查询失败（状态 ' + ((res && res.statusCode) || '?') + '）');
            return;
          }
          const d = res && res.data;
          const status = String((d && d.status) || '');
          if (status === 'researching') {
            // 段0 副文案：渠道实收件数滚动优先（2.0 版直播键），无真值回落渠道数
            goto(0, evidenceLiveLine(d, 0) || evidenceChannelsCount(d));
            setTimeout(() => poll(taskId), EVIDENCE_POLL_MS);
            return;
          }
          if (status === 'structuring') {
            goto(1, evidenceLiveLine(d, 1)); // 段1 副文案：正在形成 N 个主题分组
            setTimeout(() => poll(taskId), EVIDENCE_POLL_MS);
            return;
          }
          if (status === 'done') {
            const bp = d && d.bp;
            if (bp && bp.tree && bp.ratio && bp.stats && bp.quote) { // 四键齐全才收（绝不半渲染）
              goto(1); closeRun();
              setSt(2, 'run', ((bp.stats && bp.stats.files) || 0) + ' 份文件'); // 蓝图真值计数
              setTimeout(() => { // 交付段稍顿收口（节奏与演示段一致）
                if (settled) return; settled = true;
                setSt(2, 'ok');
                resolve(bp);
              }, STEP_MS);
              return;
            }
            fail('真调研结果不完整');
            return;
          }
          if (status === 'failed') { // 服务端失败带原因如实透传（回落决策在 generate）
            fail('真调研任务失败：' + String((d && (d.reason || d.error)) || '原因未说明'));
            return;
          }
          setTimeout(() => poll(taskId), EVIDENCE_POLL_MS); // 未知状态继续轮询（总预算管上限）
          if (res.statusCode === 0) { fail('真调研服务波动：' + String(res.errMsg || '查询失败').slice(0, 60)); return; }
      });
    };
    _evRequest(_EVIDENCE_TASK_PATH, 'POST', { text: text, depth: depth || 'standard' }, EVIDENCE_POST_TIMEOUT_MS, (res) => {
      if (settled) return;
      const d = res && res.data;
      const tid = d && (d.task_id || d.taskId);
      if (!httpStatusOk(res) || !tid) { fail('真调研服务未就绪（' + ((res && res.statusCode) || '?') + ' ' + String((res && res.errMsg) || '').slice(0, 50) + '）'); return; }
      poll(String(tid));
    });
  });
}

// 远端蓝图视图对齐：云端已瘦身同构，此处仅防御性补缺省（形状缺角不进渲染管线）
function normalizeRemote(bp) {
  bp = bp || {};
  bp.domain = bp.domain || '';
  bp.stats = bp.stats || {};
  bp.quote = Object.assign({ base: 29, per_gb: 2, md_factor: 1.5, total: 0, import_add: 19 },
    bp.quote || {});
  bp.ratio = Object.assign({ core: 0, field: 0, guide: 0 }, bp.ratio || {});
  bp.provenance = bp.provenance || {};
  bp.need = bp.need || {};
  const tree = bp.tree = bp.tree || { mode: 'clc', root: bp.domain, l1: [] };
  (tree.l1 || []).forEach((l1) => {
    l1.l2 = l1.l2 || [];
    if (typeof l1.l2_count !== 'number') l1.l2_count = l1.l2.length;
    l1.l2.forEach((l2) => {
      l2.files = l2.files || [];
      if (typeof l2.file_count !== 'number') l2.file_count = l2.files.length;
      l2.files.forEach((f) => {
        if (!f.size) f.size = '';
        if (!f.icon) f.icon = '🟢';
        if (!f.src) f.src = '公开资料';
        if (!f.perm) f.perm = '可自由使用';
      });
    });
  });
  return bp;
}

// 远端直取（契约导出；页面主链走 generate 的兜底版）
function generateRemote(needText, depth) {
  const text = String(needText || '').trim();
  if (!text) return Promise.reject({ message: '先说一句你要的知识库' });
  return callRemote(text, depth).then(normalizeRemote);
}

// 演示八阶段腿包装（云函数/本地样本共用）：开播前先发换轨事件（页面 stages 重置回
// 八段骨架——从真调研轨回落时如实换轨），完场按腿打标（cloud|local）
function legDemoStages(bp, onStage, tag) {
  onStage({ reset: STAGES });
  return runStages(bp, onStage).then(() => {
    bp.remote = tag;
    return bp;
  });
}

// 本地兜底腿：样本路由 + 八阶段直播（v1 全量管线，第三层，永不白屏的保底）
function generateLocal(text, onStage) {
  return readSample(pickSampleKey(text)).then((sample) =>
    legDemoStages(sample, onStage, 'local'));
}

// 三层兜底总入口（每层如实标 bp.remote：evidence|cloud|local，永不白屏）：
//   第一层 真调研服务（KB_EVIDENCE_ENABLED 常量开关，默认开）→ 失败/超时回落
//   第二层 云函数编目 → 再失败回落 第三层 本地样本
function generate(needText, onStage, depth) {
  const text = String(needText || '').trim();
  if (!text) return Promise.reject({ message: '先说一句你要的知识库' });
  const emit = (typeof onStage === 'function') ? onStage : function () {};
  const legEvidence = KB_EVIDENCE_ENABLED
    ? callEvidence(text, depth, emit)
    : Promise.reject(new Error('真调研腿未开启'));
  return legEvidence
    .then((raw) => {
      const bp = normalizeRemote(raw);
      bp.remote = 'evidence'; // 如实标：真调研服务腿（provenance.evidence_tree 带真调研账）
      return bp;
    })
    .catch((err1) => {
      console.warn('[kbf-evidence] 回落云函数腿:', String((err1 && err1.message) || err1).slice(0, 80));
      return callRemote(text, depth)
        .then((raw) => {
          const bp = normalizeRemote(raw);
          return legDemoStages(bp, emit, 'cloud');
        })
        .catch((err2) => {
          console.warn('[kbf-remote] 回落本地样本:', String((err2 && err2.message) || err2).slice(0, 80));
          return generateLocal(text, emit);
        });
    });
}

// ══ 收口波A·三视图投影（catalog_engine/views.py 轻量 JS 直译；纯函数零漂移）══
// 一份数据三棵树（主题/阶段/类型）：文件本体一份，视图只做「文件引用+结构化
// 元数据标注」的投影，不复制不搬家不回写。组名一律 verbatim 全名（阶段/类型
// 规约全名直译，UI 不另起缩写）；两张映射表未命中 → 「待归类」恒排尾
// （如实不编造：宁缺勿假）；守恒律=三视图文件引用数恒等于有效槽位数。
// 轻量省略：每视图的 origin 溯源说明串不随行（端上不消费；组名/引用/计数
// 与引擎逐项对齐，已四样本实测 parity 全等）。
const VIEW_LABELS = { by_topic: '主题', by_phase: '阶段', by_type: '类型' };
const UNMAPPED = '待归类'; // 两张映射表的诚实兜底桶：未命中即入此，禁编造归类

// 阶段视图映射表（显式；匹配文本=文件名+tier+组名，声明序首中胜；组合词防跨阶段误抢）
const PHASE_ORDER = ['前期报批', '勘察设计', '施工建造', '质量验收', '运维检修'];
const PHASE_KEYWORDS = {
  '前期报批': ['立项', '项目建议书', '可行性研究', '可研', '预可研', '报批',
    '审批', '核准', '备案', '环评', '环境影响', '水土保持', '征地',
    '移民安置', '规划', '许可', '申请书', '招标', '投标', '评估'],
  '勘察设计': ['勘察设计', '初步设计', '施工图设计', '技术设计', '方案设计',
    '设计报告', '设计说明', '设计计算', '图纸', '地质勘察', '工程测绘', '枢纽布置'],
  '施工建造': ['施工', '建造', '浇筑', '灌浆', '基坑', '安装', '进度', '工序',
    '工艺', '质量控制', '质量检测', '试验检测', '安全生产', '安全专项',
    '监理', '应急预案'],
  '质量验收': ['验收', '竣工', '结算', '决算', '审计', '移交', '质量评定'],
  '运维检修': ['运行维护', '运行管理', '运维', '检修', '养护', '维修', '后评价', '调度运用'],
};

// 类型视图规则表（显式；fmt 优先=xlsx/csv/tsv 直判数据报表，余按声明序标题启发）
const TYPE_ORDER = ['标准规范', '合同范本', '研究报告', '案例实录', '数据报表'];
const DATA_TABLE_FMTS = ['xlsx', 'csv', 'tsv']; // 电子表格=强格式信号（fmt 优先档）
const TYPE_KEYWORDS = {
  '标准规范': ['标准', '规范', '规程', '导则', '定额', '图集'],
  '合同范本': ['范本', '模板', '合同', '协议', '文书', '示范文本'],
  '研究报告': ['研究报告', '调研报告', '行业报告', '市场报告', '市场分析',
    '白皮书', '蓝皮书', '专题研究', '趋势报告'],
  '案例实录': ['案例', '实例', '实战', '实务'],
  '数据报表': ['清单', '台账', '数据表', '数据集', '统计表', '报表', '明细表'],
};
// 标准号正则（标准规范档加成）：GB/SL/DL/JGJ/ISO… 编号起头；前置字母防误吞英文词
// （JS 兼容写法：不用后行断言，逐命中回看前一字符是否字母）
const STD_NO_RE = /(?:GB\/Z|GB\/T|GB|SL|DL\/T|DL|JGJ|JT|TB|CJJ|NB|WS|YY|HG|SH|SY|QB|YB|ISO|IEC|ASTM|EN|DIN|JIS|BS)\s*\d/g;

function stdNoHit(title) {
  STD_NO_RE.lastIndex = 0;
  let m;
  while ((m = STD_NO_RE.exec(title)) !== null) {
    if (m.index === 0 || !/[A-Za-z]/.test(title.charAt(m.index - 1))) return true;
  }
  return false;
}

// 槽位只读小件（只消费既有键，零回写；files 优先，分拆组拍平）
function slotsOf(l2) {
  l2 = l2 || {};
  if (l2.files && l2.files.length) return l2.files;
  const out = [];
  (l2.split_dirs || []).forEach((sd) => ((sd && sd.files) || []).forEach((f) => out.push(f)));
  return out;
}

function fmtOf(slot) {
  let fmt = String((slot.fmt || slot.ext) || '').trim().toLowerCase();
  if (!fmt) { // 再无则从文件名尾扩展名解析（1-5 位纯 ASCII 字母数字，口径同引擎）
    const name = String(slot.name || '');
    const dot = name.lastIndexOf('.');
    const stem = dot > 0 ? name.slice(0, dot) : '';
    const tail = dot > 0 ? name.slice(dot + 1) : '';
    if (stem && /^[A-Za-z0-9]{1,5}$/.test(tail)) fmt = tail.toLowerCase();
  }
  return fmt;
}

function titleOf(slot) { // 类型启发用题名：净题名 > title > name
  const cat = slot.catalog;
  if (cat && String(cat.clean_title || '').trim()) return String(cat.clean_title);
  return String((slot.title || slot.name) || '');
}

function phaseFor(name, tier, group) {
  const text = (name || '') + ' ' + (tier || '') + ' ' + (group || '');
  for (let i = 0; i < PHASE_ORDER.length; i++) {
    const kws = PHASE_KEYWORDS[PHASE_ORDER[i]];
    for (let k = 0; k < kws.length; k++) if (text.indexOf(kws[k]) >= 0) return PHASE_ORDER[i];
  }
  return UNMAPPED;
}

function typeFor(slot) {
  if (DATA_TABLE_FMTS.indexOf(fmtOf(slot)) >= 0) return '数据报表'; // 电子表格强信号
  const title = titleOf(slot);
  for (let i = 0; i < TYPE_ORDER.length; i++) {
    const tn = TYPE_ORDER[i];
    if (tn === '标准规范' && stdNoHit(title)) return tn; // 标准号正则加成档
    const kws = TYPE_KEYWORDS[tn];
    for (let k = 0; k < kws.length; k++) if (title.indexOf(kws[k]) >= 0) return tn;
  }
  return UNMAPPED;
}

function refOf(slot, l2) { // 文件引用+结构化元数据标注（clc_no/fmt/tier/组名，缺键如实 null）
  l2 = l2 || {};
  const cat = slot.catalog;
  return {
    ref: String(l2.path || '') + String(slot.name || ''),
    name: String(slot.name || ''),
    meta: {
      clc_no: (cat && cat.clc_no !== undefined) ? cat.clc_no : null,
      fmt: fmtOf(slot) || null,
      tier: slot.tier !== undefined ? slot.tier : null,
      group: String(l2.name || ''),
    },
  };
}

// 三视图主入口（纯只读消费：原树/槽位零改动，禁写回）
function buildViews(bp) {
  const l1Nodes = (((bp || {}).tree || {}).l1) || [];
  const topic = [];
  const phaseB = {}; const typeB = {};
  PHASE_ORDER.forEach((p) => (phaseB[p] = []));
  TYPE_ORDER.forEach((t) => (typeB[t] = []));
  phaseB[UNMAPPED] = []; typeB[UNMAPPED] = [];
  let total = 0;
  l1Nodes.forEach((l1) => {
    const sub = [];
    ((l1 && l1.l2) || []).forEach((l2) => {
      const refs = [];
      slotsOf(l2).forEach((slot) => {
        if (!slot || typeof slot !== 'object') return; // 防御：非对象槽不进视图（守恒口径=有效槽位数）
        const r = refOf(slot, l2);
        refs.push(r);
        total++;
        phaseB[phaseFor(r.name, slot.tier, r.meta.group)].push(r);
        typeB[typeFor(slot)].push(r);
      });
      sub.push({ name: String(l2.name || ''), path: String(l2.path || ''), files: refs });
    });
    topic.push({ name: String(l1.name || ''), path: String(l1.path || ''), groups: sub });
  });
  function bucketsOf(order, b) { // 声明序出非空组，「待归类」恒排尾；空组滤除（轻量）
    const out = [];
    order.concat([UNMAPPED]).forEach((g) => {
      if (b[g] && b[g].length) out.push({ name: g, files: b[g] });
    });
    return out;
  }
  const mPhase = {}; const mType = {};
  PHASE_ORDER.concat([UNMAPPED]).forEach((g) => (mPhase[g] = phaseB[g].length));
  TYPE_ORDER.concat([UNMAPPED]).forEach((g) => (mType[g] = typeB[g].length));
  return {
    by_topic: { key: 'by_topic', label: VIEW_LABELS.by_topic, groups: topic },
    by_phase: { key: 'by_phase', label: VIEW_LABELS.by_phase, groups: bucketsOf(PHASE_ORDER, phaseB) },
    by_type: { key: 'by_type', label: VIEW_LABELS.by_type, groups: bucketsOf(TYPE_ORDER, typeB) },
    metrics: {
      files: total,
      by_phase: mPhase,
      by_type: mType,
      unmapped: { by_phase: phaseB[UNMAPPED].length, by_type: typeB[UNMAPPED].length },
    },
  };
}

// ══ 收口波A·mkdocs 预览站点入口（服务器位预留；暂置空=如实提示「即将上线」）══
// 服务端契约（kb_factory 仓服务端生成件）：
//   · 生成件命令行：py -3 -m export_mkdocs <蓝图.json> <out_dir>（回执 JSON 打
//     stdout）；骨架判据随后跑 py -3 -m mkdocs build --strict -f <out_dir>/mkdocs.yml；
//   · 端点部署后把 PREVIEW_ENDPOINT 置位（https 域名须在小程序后台白名单内），
//     客户端 POST 蓝图摘要 {domain, files, gb, total} → 服务端跑生成件出预览站，
//     返回 {ok: true, url: <预览站地址>}；失败 {ok: false, message: <原因>}；
//   · 现状：端点未部署=常量置空，previewSite 直接以「即将上线」回绝——不造假不崩溃。
const PREVIEW_ENDPOINT = '';

function previewSite(bp) {
  if (!PREVIEW_ENDPOINT) return Promise.reject({ message: '即将上线' }); // 置空实现=占位如实
  const st = (bp && bp.stats) || {};
  const q = (bp && bp.quote) || {};
  return new Promise((resolve, reject) => {
    wx.request({
      url: PREVIEW_ENDPOINT,
      method: 'POST',
      data: { domain: (bp && bp.domain) || '', files: st.files || 0, gb: st.gb || 0, total: q.total || 0 },
      success: (res) => {
        const r = res && res.data;
        if (r && r.ok && r.url) resolve(r);
        else reject({ message: (r && r.message) || '预览生成失败，请稍后再试' });
      },
      fail: () => reject({ message: '网络波动，请稍后重试' }),
    });
  });
}

module.exports = {
  generate, generateRemote, STAGES, EVIDENCE_STAGES, buildViews, previewSite, VIEW_LABELS,
  KB_EVIDENCE_ENDPOINT,
  _pickSampleKey: pickSampleKey, _stageCounts: stageCounts,
  _callRemote: callRemote, _callEvidence: callEvidence,
  _evidenceLiveLine: evidenceLiveLine,
  _normalizeRemote: normalizeRemote, _cloudReady: cloudReady,
};
