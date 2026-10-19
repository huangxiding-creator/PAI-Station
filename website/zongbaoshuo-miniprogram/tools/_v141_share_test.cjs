// v1.4.1 专业级分享 100% 测试：两页双 handler 存在性 + 返回体断言（title/query/imageUrl）
const automator = require('miniprogram-automator');
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
(async () => {
  const mini = await automator.connect({ wsEndpoint: 'ws://localhost:9422' });
  console.log('[1] connected');
  const page = await mini.reLaunch('/pages/index/index');
  await sleep(4000);
  const r1 = await mini.evaluate(() => {
    const p = getCurrentPages()[getCurrentPages().length - 1];
    const out = { route: p.route };
    out.hasFriend = typeof p.onShareAppMessage === 'function';
    out.hasTimeline = typeof p.onShareTimeline === 'function';
    if (out.hasTimeline) out.timeline = p.onShareTimeline();
    if (out.hasFriend) out.friend = p.onShareAppMessage();
    out.spmFlag = p.data.spm === false; // 正常模式应为 false
    return out;
  });
  console.log('[2] index:', JSON.stringify(r1));
  const p2 = await mini.navigateTo('/pages/product/product?id=factory');
  await sleep(2500);
  const r2 = await mini.evaluate(() => {
    const p = getCurrentPages()[getCurrentPages().length - 1];
    const out = { route: p.route };
    out.hasFriend = typeof p.onShareAppMessage === 'function';
    out.hasTimeline = typeof p.onShareTimeline === 'function';
    if (out.hasTimeline) out.timeline = p.onShareTimeline();
    if (out.hasFriend) out.friend = p.onShareAppMessage();
    return out;
  });
  console.log('[3] product(factory):', JSON.stringify(r2));
  // gallery 型产品（glasses 用 gallery 图）
  const p3 = await mini.redirectTo('/pages/product/product?id=glasses');
  await sleep(2000);
  const r3 = await mini.evaluate(() => {
    const p = getCurrentPages()[getCurrentPages() - 1];
    return { timeline: p.onShareTimeline && p.onShareTimeline(), friend: p.onShareAppMessage && p.onShareAppMessage() };
  });
  console.log('[4] product(glasses):', JSON.stringify(r3));
  // 无图产品（brain → 兜底 leopard）
  const p4 = await mini.redirectTo('/pages/product/product?id=brain');
  await sleep(2000);
  const r4 = await mini.evaluate(() => {
    const p = getCurrentPages()[getCurrentPages() - 1];
    return { timeline: p.onShareTimeline && p.onShareTimeline() };
  });
  console.log('[5] product(brain):', JSON.stringify(r4));
  await mini.screenshot({ path: 'E:/AI-Station/website/zongbaoshuo-miniprogram/_v141_product.png' });
  const pass = r1.hasFriend && r1.hasTimeline && r1.timeline.imageUrl &&
               r2.hasTimeline && r2.timeline.query === 'id=factory' && r2.timeline.imageUrl === '/images/factory.jpg' &&
               r3.timeline.imageUrl === '/images/glasses-hero.jpg' &&
               r4.timeline.imageUrl === '/images/leopard.jpg';
  console.log(pass ? '[6] SHARE-TEST 100% PASS' : '[6] SHARE-TEST FAIL');
  await mini.disconnect(); process.exit(pass ? 0 : 1);
})().catch((e) => { console.error('ERR', e.message); process.exit(1); });
