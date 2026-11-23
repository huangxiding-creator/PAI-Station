// e2e_kbflagship_1123.js — 超级总包知识库上架实测（1123《100×总案》C3/C5/C6 铁律门）
// 断言：①zhiku 动态区块渲染（45 库树+统计+更新流）②旗舰 SKU 详情（¥9,800+交付卡）
// ③知识库市场列表含 5 新 SKU ④免费蓝图入口可达
const automator = require('miniprogram-automator');
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
const fs = require('fs');

const RESULTS = { checks: [], pass: 0, fail: 0 };
function check(name, cond, detail) {
  const ok = !!cond;
  RESULTS.checks.push({ name, ok, detail: String(detail || '').slice(0, 160) });
  ok ? RESULTS.pass++ : RESULTS.fail++;
  console.log(`${ok ? '✓' : '✗'} ${name}${detail ? ' — ' + String(detail).slice(0, 120) : ''}`);
}

(async () => {
  const mp = await automator.connect({ wsEndpoint: 'ws://127.0.0.1:9420' });
  await sleep(2500);
  for (let i = 0; i < 20; i++) {
    let stack = [];
    try { stack = await mp.pageStack(); } catch (e) {}
    if (stack.length) break;
    await sleep(3000);
  }

  // ① zhiku 动态区块
  let zhiku = null;
  for (let i = 0; i < 4; i++) {
    try { zhiku = await mp.switchTab('/pages/zhiku/zhiku'); } catch (e) { await sleep(2000); continue; }
    await sleep(1500);
    if (zhiku && typeof zhiku.$ === 'function') break;
  }
  check('zhiku 页打开', zhiku && typeof zhiku.$ === 'function', zhiku && zhiku.path);
  await sleep(3000); // 等 loadKbLive 异步回来

  const liveCard = await zhiku.$('.zk-live-grid').catch(() => null);
  check('超级总包知识库动态区块渲染', !!liveCard, liveCard ? 'zk-live-grid found' : 'missing');
  const libs = await zhiku.data('kbLibs').catch(() => null);
  check('45 库树数据到位', Array.isArray(libs) && libs.length >= 40, `libs=${libs && libs.length}`);
  const stats = await zhiku.data('kbLiveStats').catch(() => null);
  check('统计带渲染', Array.isArray(stats) && stats.length >= 3, JSON.stringify(stats || []).slice(0, 100));
  const feed = await zhiku.data('kbFeed').catch(() => null);
  check('最近更新流渲染', Array.isArray(feed) && feed.length >= 1, `feed=${feed && feed.length}`);
  const ver = await zhiku.data('kbVer').catch(() => '');
  check('版本号', !!ver, `ver=${ver}`);

  // ② 知识库市场（含 5 新 SKU）
  const market = await zhiku.data('kbMarket').catch(() => null);
  const skus = (market || []).map((r) => r.sku);
  check('KB 市场含旗舰', skus.includes('KB-SUPER-FLAGSHIP'), `skus=${skus.join(',')}`);
  check('KB 市场含 4 标准包', ['KB-STD-12', 'KB-STD-11', 'KB-STD-22', 'KB-STD-13'].every((s) => skus.includes(s)), `${skus.length} KB SKUs`);

  // ③ 旗舰详情页（¥9,800 + KB 交付卡）
  let rp = null;
  for (let i = 0; i < 3; i++) {
    try { rp = await mp.navigateTo('/pages/report/report?sku=KB-SUPER-FLAGSHIP'); break; }
    catch (e) { await sleep(2000); }
  }
  await sleep(4000);
  check('旗舰详情页打开', rp && typeof rp.$ === 'function', rp && rp.path);
  const title = await rp.data('d.title').catch(() => null);
  check('旗舰标题渲染', String(title || '').includes('旗舰全库'), String(title).slice(0, 50));
  const price = await rp.data('d.price_label').catch(() => null);
  check('定价 ¥9,800/年', String(price).indexOf('9,800') >= 0, `price_label=${price}`);
  const isKb = await rp.data('isKb').catch(() => null);
  check('KB 交付卡分支激活', isKb === true, `isKb=${isKb}`);
  const share = await rp.data('d.baidu_share.url').catch(() => null);
  check('网盘交付链就绪', String(share || '').indexOf('pan.baidu.com') >= 0, String(share).slice(0, 50));
  const sample = await rp.data('d.sample_file').catch(() => null);
  check('免费蓝图挂接', sample === 'super_kb_blueprint.md', `sample=${sample}`);

  // ④ 标准包详情抽检（12 库）
  let rp12 = null;
  try { rp12 = await mp.navigateTo('/pages/report/report?sku=KB-STD-12'); } catch (e) {}
  await sleep(3000);
  const p12 = await rp12.data('d.price_label').catch(() => null);
  check('标准包 12 库 ¥599', String(p12).indexOf('599') >= 0, `price=${p12}`);

  fs.writeFileSync(__dirname + '/e2e_kbflagship_result.json', JSON.stringify(RESULTS, null, 1));
  console.log(`\n== 结果: pass ${RESULTS.pass} / fail ${RESULTS.fail} ==`);
  await mp.disconnect();
  process.exit(RESULTS.fail === 0 ? 0 : 1);
})().catch((e) => { console.error('FATAL', e); process.exit(2); });
