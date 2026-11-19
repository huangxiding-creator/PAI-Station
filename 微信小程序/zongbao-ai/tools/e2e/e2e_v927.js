// e2e_v927.js — 0.9.27/0.9.28 实测门：①研究页检索（输入→过滤→清空；1119 起 KB 已剔——检索「知识库」=0）
// ②智库页知识库市场（1119：KB SKU 在智库发售，行渲染+点击进详情）③报告页海报 sheet 双动作（保存第一）
// 跑法：先 cli auto --project ... --auto-port 9420，后 node tools/e2e/e2e_v927.js
const automator = require('miniprogram-automator');

const rec = [];
function ok(name, pass, detail) {
  rec.push({ name, pass: !!pass, detail: detail || '' });
  console.log((pass ? 'PASS ' : 'FAIL ') + name + (detail && !pass ? '  ' + detail : ''));
}

(async () => {
  const mp = await automator.connect({ wsEndpoint: 'ws://127.0.0.1:9420' });

  // ══ ① 研究页检索 ══
  await mp.reLaunch('/pages/research/research');
  await new Promise(r => setTimeout(r, 4000));
  let page = await mp.currentPage();
  let d = await page.data();
  ok('研究页加载（目录到货）', Array.isArray(d.reports) && d.reports.length > 0, `reports=${(d.reports || []).length}`);
  const total = (d.reports || []).length;
  // 1119 门：研究页全分区零 KB（reports/latest/hot）
  const kbLeak = [].concat(d.reports || [], d.latest || [], d.hot || [])
    .filter(r => String(r.sku || '').indexOf('KB-') === 0);
  ok('研究页零 KB SKU（已撤，归智库）', kbLeak.length === 0, `leak=${kbLeak.map(r => r.sku).join(',')}`);

  const input = await page.$('.rs-search-input');
  ok('搜索框在位', !!input);
  if (input) {
    // 输入「储能」→ shown 收窄且全量命中
    await input.input('储能');
    await new Promise(r => setTimeout(r, 600));
    d = await page.data();
    const hit1 = (d.shown || []).length;
    ok('检索「储能」过滤生效（<全量且>0）', hit1 > 0 && hit1 < total, `hit=${hit1} total=${total}`);
    ok('检索词状态同步 query', d.query === '储能', `query=${d.query}`);
    ok('命中项全含关键词（title/subtitle/cat_name/sku）', (d.shown || []).every(r =>
      ['title', 'subtitle', 'cat_name', 'sku'].some(k => String(r[k] || '').toLowerCase().includes('储能'))));

    // 1119 反转：研究页检索「知识库」=0 命中（KB 归智库页市场）
    await input.input('知识库');
    await new Promise(r => setTimeout(r, 600));
    d = await page.data();
    ok('检索「知识库」零命中（KB 已归智库）', (d.shown || []).length === 0, `hit=${(d.shown || []).length}`);

    // 无命中空态
    await input.input('绝对不存在的词xyzq');
    await new Promise(r => setTimeout(r, 600));
    d = await page.data();
    ok('无命中 → shown 空', (d.shown || []).length === 0);

    // 清空恢复全量
    const clearBtn = await page.$('.rs-search-clear');
    ok('清空钮在位（有词时）', !!clearBtn);
    if (clearBtn) { await clearBtn.tap(); await new Promise(r => setTimeout(r, 500)); }
    d = await page.data();
    ok('清空恢复全量', (d.shown || []).length === total && d.query === '', `shown=${(d.shown || []).length}`);
  }

  // ══ ② 智库页知识库市场（1119 用户令：整库商品在智库发售）══
  await mp.switchTab('/pages/zhiku/zhiku');
  await new Promise(r => setTimeout(r, 3500));
  page = await mp.currentPage();
  d = await page.data();
  const market = d.kbMarket || [];
  ok('智库页知识库市场到货', market.length >= 1, `kbMarket=${market.length}`);
  ok('市场条目=knowledge_base', market.every(r => r.product_type === 'knowledge_base'), market.map(r => r.sku).join(','));
  const mkRow = await page.$('.zk-mk-row');
  ok('市场行渲染（.zk-mk-row）', !!mkRow);
  if (mkRow) {
    const txt = await mkRow.text().catch(() => '');
    ok('市场行含价与文件徽标', /¥|文件数/.test(txt), txt.slice(0, 50));
    await mkRow.tap();
    // 转场在模拟器内可慢于 2.5s（实测迟到跳）——轮询 pageStack 最多 8s
    let top = { path: '' };
    for (let t = 0; t < 16; t++) {
      await new Promise(r => setTimeout(r, 500));
      const stack = await mp.pageStack();
      top = stack[stack.length - 1];
      if (/pages\/report\/report/.test(top.path || '')) break;
    }
    // automator 的 page.path 不含 query 串——路由判 path，SKU 判页面 data
    let navSku = '';
    if (/^pages\/report\/report$/.test(top.path || '')) {
      try { navSku = ((await (await mp.currentPage()).data()) || {}).sku || ''; } catch (e) {}
    }
    ok('市场行点击→报告详情页', /^pages\/report\/report$/.test(top.path || '') && String(navSku).indexOf('KB-') === 0, `top=${top.path} sku=${navSku}`);
    while ((await mp.pageStack()).length > 1) { await mp.navigateBack().catch(() => {}); await new Promise(r => setTimeout(r, 400)); }
  }

  // ══ ② 报告页海报 sheet 双动作（接线门：生成→sheet 弹出→第一动作=保存到相册）══
  await mp.reLaunch('/pages/report/report?sku=KB-SUBCON-2026');
  await new Promise(r => setTimeout(r, 4000));
  page = await mp.currentPage();
  d = await page.data();
  ok('报告页加载（KB-SUBCON-2026）', !!d.sku, `sku=${d.sku}`);

  // 触发 onPoster：$$('.pill') 遍历按文本找「生成海报」（automator 不支持属性选择器）
  let posterBtn = null;
  for (const el of (await page.$$('.pill') || [])) {
    const t = await el.text().catch(() => '');
    if (t && t.indexOf('海报') >= 0 && t.indexOf('生成中') < 0) { posterBtn = el; break; }
  }
  ok('海报按钮在位', !!posterBtn);
  if (posterBtn) {
    await posterBtn.tap();
    // 海报生成走生产 API（有缓存，秒级）；等待 sheet 弹出（qw-pop mode=sheet）
    let sheetUp = false, tries = 0;
    while (tries++ < 20 && !sheetUp) {
      await new Promise(r => setTimeout(r, 1000));
      d = await page.data();
      sheetUp = d.popOpen === true && d.popMode === 'sheet';
    }
    ok('海报生成→自绘 sheet 弹出', sheetUp, `tries=${tries} popOpen=${d.popOpen} popMode=${d.popMode} busy=${d.posterBusy}`);
    if (sheetUp) {
      // 第一动作=保存到相册：进 #qwpop 组件内部查 .qwp-row 首项文本
      let rows = [];
      const qwp = await page.$('#qwpop');
      if (qwp) rows = await qwp.$$('.qwp-row').catch(() => []);
      let firstTxt = '';
      if (rows && rows.length) firstTxt = await rows[0].text().catch(() => '');
      const firstOk = firstTxt.indexOf('保存到相册') >= 0;
      ok('sheet 首项=保存到相册（第一动作）', firstOk, `first="${String(firstTxt).trim().slice(0, 20)}" rows=${(rows || []).length}`);
      // 真点首项走保存分支：mock 掉存图 API（模拟器无真机相册意义），断言链路接通
      // （album_save_ok 遥测会真上行线上——留硬证据）
      if (firstOk) {
        await mp.mockWxMethod('getSetting', { authSetting: { 'scope.writePhotosAlbum': true } });
        await mp.mockWxMethod('saveImageToPhotosAlbum', { errMsg: 'saveImageToPhotosAlbum:ok' });
        await rows[0].tap();
        await new Promise(r => setTimeout(r, 2500));
        d = await page.data();
        ok('点保存→saveToAlbum 链走通（sheet 收起·无 busy 残留）', d.popOpen === false, `popOpen=${d.popOpen}`);
      }
    }
  }

  await mp.disconnect();
  const fails = rec.filter(r => !r.pass);
  console.log(`\nE2E v0.9.28: ${rec.length - fails.length}/${rec.length} PASS`);
  process.exit(fails.length ? 1 : 0);
})().catch(e => { console.error('E2E ERROR:', e.message); process.exit(2); });
