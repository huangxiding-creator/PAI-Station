// 0.9.26 海报直存相册测试：report 页生成海报 → sheet 弹出 → 直存方法实测
const automator = require('miniprogram-automator');
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
(async () => {
  const mini = await automator.connect({ wsEndpoint: 'ws://localhost:9420' });
  console.log('[1] connected');
  const page = await mini.reLaunch('/pages/report/report?sku=JSFDD-2026');
  await sleep(5000);
  // 生成海报（真引擎）
  await page.callMethod('onPoster');
  await sleep(8000);
  const st1 = await page.data();
  console.log('[2] poster generated: posterBusy=', st1.posterBusy, '| path exists:', !!st1._posterPath || 'data外');
  // 弹出 sheet 了吗（qw-pop 组件态）
  const pop = await page.$('#qwpop');
  console.log('[3] qw-pop mounted:', !!pop);
  const popData = pop ? await pop.data() : null;
  console.log('[4] qw-pop state: show=', popData && popData.show, '| mode=', popData && popData.mode);
  // 直接调 _savePosterAlbum（DevTools 模拟器 album 授权默认允许）
  const r = await page.callMethod('_savePosterAlbum', (st1._posterPath || wx_path));
  console.log('[5] _savePosterAlbum called (async toast)');
  await sleep(3000);
  await mini.screenshot({ path: 'E:/AI-Station/WeAppForge/_v0926_poster_save.png' });
  console.log('[6] POSTER-TEST done');
  await mini.disconnect(); process.exit(0);
})().catch((e) => { console.error('ERR', e.message); process.exit(1); });
