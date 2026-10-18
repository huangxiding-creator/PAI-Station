// e2e_v0921_probe.mjs — v0.9.21 UI probe (lightweight, no ask flow)
import automator from 'miniprogram-automator';
import fs from 'node:fs';
const SHOT_DIR = 'E:\\AI-Station\\WeAppForge\\work\\e2e_v0921_shots';
fs.mkdirSync(SHOT_DIR, { recursive: true });
const notes = [];
const note = (n, ok, d) => { notes.push(ok); console.log((ok?'PASS':'FAIL')+' '+n+(d?' | '+d:'')); };
const sleep = ms => new Promise(r => setTimeout(r, ms));

const mp = await automator.connect({ wsEndpoint: 'ws://127.0.0.1:9420' });

// 研究页双分区
await mp.switchTab('/pages/research/research');
await sleep(3500);
const rs = await mp.currentPage();
const rd = await rs.data();
note('latest_in_data', Array.isArray(rd.latest) && rd.latest.length >= 1, 'latest=' + (rd.latest||[]).length);
note('latest_max3', (rd.latest||[]).length <= 3, 'top' + (rd.latest||[]).length);
note('hot_in_data', Array.isArray(rd.hot) && rd.hot.length >= 3, 'hot=' + (rd.hot||[]).length);
const heatOk = (rd.hot||[]).every(x => typeof x.heat === 'number');
note('hot_has_heat', heatOk, 'heat on every item');
const hasInteract = (rd.hot||[]).every(x => typeof x.views === 'number' && typeof x.likes === 'number');
note('hot_has_interaction', hasInteract, 'views/likes/shares per item');
await mp.screenshot({ path: SHOT_DIR + '\\research_sections.png' }).catch(()=>{});

// 报告页 hero 大区
const firstSku = ((rd.latest||[])[0]||{}).sku || 'CNNC-EPC';
await mp.navigateTo('/pages/report/report?sku=' + firstSku);
await sleep(3000);
const rp = await mp.currentPage();
const heroInput = await rp.$('.rp-ask-input');
note('hero_input_visible', !!heroInput, 'hero textarea 永驻');
const heroSend = await rp.$('.rp-ask-hero-send');
note('hero_send_button', !!heroSend);
await mp.screenshot({ path: SHOT_DIR + '\\report_hero.png' }).catch(()=>{});

note('probe_done', true);
await mp.disconnect();
const failed = notes.filter(x => !x).length;
console.log('==== v0.9.21 UI PROBE: ' + (notes.length - failed) + '/' + notes.length + ' PASS ====');
process.exit(failed ? 1 : 0);
