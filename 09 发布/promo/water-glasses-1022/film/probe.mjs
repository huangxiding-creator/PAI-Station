// 探针：seek 后检查 HUD 元素的计算样式与几何
import {chromium} from 'playwright';
import {serve} from './server.mjs';
const {server, url} = await serve();
const browser = await chromium.launch({headless: true, args: ['--use-angle=swiftshader', '--enable-unsafe-swiftshader']});
try {
  const page = await browser.newPage({viewport: {width: 1080, height: 1920}});
  page.on('pageerror', e => console.log('PAGEERROR:', e.message));
  await page.goto(url, {waitUntil: 'networkidle'});
  await page.evaluate(() => window.__filmReady);
  await page.evaluate(t => window.seek(t), 14.5);
  const info = await page.evaluate(() => {
    const g = document.querySelector('section[data-shot="scan"] .js-cross');
    const r = g.getBoundingClientRect();
    return {
      styleOpacity: g.style.opacity, csOpacity: getComputedStyle(g).opacity,
      transform: g.style.transform, rect: {x: r.x, y: r.y, w: r.width, h: r.height},
      attrOpacity: g.getAttribute('opacity'),
    };
  });
  console.log(JSON.stringify(info, null, 1));
} finally { await browser.close(); await new Promise(r => server.close(r)); }
