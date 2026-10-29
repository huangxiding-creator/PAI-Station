// evidence_leg_smoke.js — A 案三层兜底服务腿冒烟（node 直跑；wx 桩环境，零真网络）
// 覆盖：真调研腿三段直播事件序/渠道计数真值才显示/腿标 evidence·cloud·local/
//       四键不齐全拒收/失败带原因回落/100s 总预算超时回落/三层兜底永不白屏/
//       2.0 版实时直播副文案（段0 渠道名 n 件滚动 + 段1 正在形成 N 个主题分组）
// 运行：node tools/evidence_leg_smoke.js（于 zongbao-ai 根目录）
const path = require('path');

// ── 桩环境（先置后 require：服务层仅在函数体内触 wx/setTimeout）──
const realSetTimeout = setTimeout;
global.setTimeout = (fn, ms) => realSetTimeout(fn, Math.min(ms, 5)); // 提速：定时节奏压到 5ms
const realNow = Date.now.bind(Date);
let _now = realNow();
Date.now = () => _now; // 可拨时钟：超时用例手动快进（不动真系统时间）

// 服务端桩剧本（每用例独立装填）
let postReply = null;   // POST /kb/blueprint 建单回执
let pollScript = [];    // GET 轮询逐次回执（耗尽=一直 researching，供超时用例拨钟）
const baseRequest = (opts) => {
  realSetTimeout(() => {
    // GET 轮询带任务号尾段，POST 建单不带——以此分流
    if (String(opts.url || '').indexOf('/kb/blueprint/T1') >= 0) {
      const d = (pollScript.length ? pollScript.shift() : { status: 'researching' });
      return opts.success && opts.success({ statusCode: 200, data: d });
    }
    if (!postReply) return opts.fail && opts.fail({ errMsg: 'request:fail stub' });
    return opts.success && opts.success(postReply);
  }, 1);
};
global.wx = { request: baseRequest };
function installCloud(result) {
  if (result === null) { delete global.wx.cloud; return; }
  global.wx.cloud = {
    callFunction(o) {
      realSetTimeout(() => {
        if (!result.ok) return o.fail && o.fail({ errMsg: 'cloud:fail stub' });
        o.success && o.success({ result: result.bp });
      }, 1);
    },
  };
}

const svc = require(path.resolve(__dirname, '..', 'utils', 'kbfactory_service.js'));

// 最小齐备蓝图（四键契约齐全；pool>0 时带 provenance.evidence_tree 真值记账）
function makeBp(files, pool) {
  const bp = {
    domain: '冒烟测试库', need: { keywords: ['测试'] },
    tree: { mode: 'evidence_tree', root: '冒烟测试库', l1: [] },
    ratio: { core: 60, field: 30, guide: 10 },
    stats: { files: files, gb: 0.2, l1_count: 3, l2_count: 17, dir_count: 17 },
    quote: { base: 29, per_gb: 2, md_factor: 1.5, total: 30, import_add: 19 },
  };
  if (pool > 0) bp.provenance = { evidence_tree: { pool_size: pool } };
  return bp;
}

const results = [];
function rec(name, ok, detail) {
  results.push(ok);
  console.log((ok ? '[PASS] ' : '[FAIL] ') + name + (detail ? ' · ' + detail : ''));
}
function resetStub() {
  postReply = null; pollScript = []; installCloud(null);
  global.wx.request = baseRequest; // 还原（超时用例包过的拨钟层复原）
}

async function runCase(name, script, check) {
  resetStub();
  script();
  const events = [];
  const p = svc.generate('给水利工程公司建EPC知识库', (st) => events.push(st), 'standard');
  let bp = null, err = null;
  try { bp = await p; } catch (e) { err = e; }
  try { check(bp, err, events); } catch (e) { rec(name, false, '断言异常: ' + e.message); }
}

(async () => {
  // ── 用例1：真调研腿全绿（三段直播事件序+渠道计数真值+腿标 evidence）──
  await runCase('用例1 真调研腿全绿', () => {
    postReply = { statusCode: 200, data: { task_id: 'T1' } };
    pollScript = [
      { status: 'researching', channels_n: 5 },
      { status: 'researching' },              // 拿不到渠道计数→不带数字（不编造）
      { status: 'structuring' },
      { status: 'done', bp: makeBp(87, 168) },
    ];
  }, (bp, err, ev) => {
    if (!bp) return rec('用例1', false, '未出图: ' + (err && err.message));
    const resets = ev.filter((e) => e.reset);
    const seq = ev.filter((e) => e.i !== undefined)
      .map((e) => e.i + e.state + (e.count !== undefined ? '#' + e.count : ''));
    rec('用例1a 换轨=真调研三段骨架（调研/设计/交付）',
        resets.length === 1 && resets[0].reset.length === 3
        && resets[0].reset[0].line === '正在调研真实资料源'
        && resets[0].reset[1].line === '正在根据调研结果设计目录',
        resets[0].reset.map((s) => s.name).join('/'));
    rec('用例1b 渠道计数只认真值5·后无计数不重复不编造',
        seq[0] === '0run#5 个渠道' && seq.indexOf('0run') < 0, seq[0]);
    rec('用例1c 三段收口序逐事件核对',
        seq.join('|') === '0run#5 个渠道|0ok|1run|1ok|2run#87 份文件|2ok', seq.join('|'));
    rec('用例1d 腿标=evidence+真调研账原样透传',
        bp.remote === 'evidence' && bp.provenance && bp.provenance.evidence_tree
        && bp.provenance.evidence_tree.pool_size === 168, 'remote=' + bp.remote);
  });

  // ── 用例2：服务 503 未就绪 → 云函数缺席 → 本地样本（两层回落，永不白屏）──
  await runCase('用例2 服务未就绪→云缺席→本地样本', () => {
    postReply = { statusCode: 503, data: {} };
  }, (bp, err, ev) => {
    if (!bp) return rec('用例2', false, '未出图: ' + (err && err.message));
    const resets = ev.filter((e) => e.reset);
    const runs = ev.filter((e) => e.state === 'run');
    rec('用例2 换轨两次（三段→八段）+八段全走+腿标 local',
        resets.length === 2 && resets[1].reset.length === 8 && runs.length === 8
        && bp.remote === 'local', 'remote=' + bp.remote + ' resets=' + resets.length);
  });

  // ── 用例3：真调研 done 但四键不齐 → 云函数出图（cloud 腿标）──
  await runCase('用例3 真调研结果不完整→云函数腿', () => {
    const bad = makeBp(50, 10); delete bad.quote; // 缺报价键=契约不齐
    postReply = { statusCode: 200, data: { task_id: 'T1' } };
    pollScript = [{ status: 'done', bp: bad }];
    installCloud({ ok: true, bp: makeBp(42, 0) });
  }, (bp, err) => {
    if (!bp) return rec('用例3', false, '未出图: ' + (err && err.message));
    rec('用例3 拒收不完整真调研结果+回落云函数出图',
        bp.remote === 'cloud' && bp.stats.files === 42, 'remote=' + bp.remote);
  });

  // ── 用例4：任务 failed 带原因 → 云函数也失败 → 本地样本（第三层保底）──
  await runCase('用例4 任务failed带原因→云失败→本地保底', () => {
    postReply = { statusCode: 200, data: { task_id: 'T1' } };
    pollScript = [{ status: 'failed', reason: '冒烟注入: 渠道全断' }];
    installCloud({ ok: false });
  }, (bp, err) => {
    if (!bp) return rec('用例4', false, '未出图: ' + (err && err.message));
    rec('用例4 失败如实回落两层到底（local 保底永不白屏）',
        bp.remote === 'local', 'remote=' + bp.remote);
  });

  // ── 用例5：一直 researching + 拨钟快进 → 100s 总预算超时 → 云函数腿收图 ──
  await runCase('用例5 轮询挂死→100s 封顶超时回落', () => {
    postReply = { statusCode: 200, data: { task_id: 'T1' } };
    pollScript = []; // 剧本耗尽=一直 researching
    global.wx.request = (opts) => { // 每次请求前拨钟 +60s（两次即破 100s 预算）
      _now += 60000;
      return baseRequest(opts);
    };
    installCloud({ ok: true, bp: makeBp(30, 0) });
  }, (bp, err) => {
    if (!bp) return rec('用例5', false, '未出图: ' + (err && err.message));
    rec('用例5 超时封顶如实回落（不停等不假绿）', bp.remote === 'cloud', 'remote=' + bp.remote);
  });

  // ── 用例6：端点常量静态契约（本地实测位）──
  rec('用例6 端点常量=本地实测位 127.0.0.1:8097',
      svc.KB_EVIDENCE_ENDPOINT === 'http://127.0.0.1:8097', svc.KB_EVIDENCE_ENDPOINT);

  // ── 用例7：2.0 版实时直播副文案（段0 渠道滚动 + 段1 分组预览；真值才显示）──
  await runCase('用例7 直播副文案真值', () => {
    postReply = { statusCode: 200, data: { task_id: 'T1' } };
    pollScript = [
      { status: 'researching', channels_live: { wenku: 12, djyanbao: 7 } },
      { status: 'researching', channels_live: { wenku: 20, djyanbao: 7 } },
      { status: 'structuring', clusters_forming: ['水利水电工程', 'EPC总承包', '综合资料'] },
      { status: 'done', bp: makeBp(87, 168) },
    ];
  }, (bp, err, ev) => {
    if (!bp) return rec('用例7', false, '未出图: ' + (err && err.message));
    const seq = ev.filter((e) => e.i !== undefined)
      .map((e) => e.i + e.state + (e.count !== undefined ? '#' + e.count : ''));
    rec('用例7a 段0 渠道副文案滚动（逐渠道名 n 件·两次轮询各进一位）',
        seq[0] === '0run#wenku 12 件' && seq[1] === '0run#djyanbao 7 件',
        seq[0] + ' | ' + seq[1]);
    rec('用例7b 段1 分组预览副文案（正在形成 3 个主题分组=列表长度真值）',
        seq.indexOf('1run#正在形成 3 个主题分组') >= 0, seq.join('|'));
  });

  const fails = results.filter((x) => !x).length;
  console.log(fails ? ('FAILED (' + fails + '/' + results.length + ')')
    : ('ALL PASS (' + results.length + '/' + results.length + ') · 三层兜底冒烟绿'));
  process.exit(fails ? 1 : 0);
})();
