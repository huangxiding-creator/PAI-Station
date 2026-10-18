import automator from 'miniprogram-automator';
const mp = await automator.connect({ wsEndpoint: 'ws://127.0.0.1:9420' });
await mp.screenshot({ path: 'E:\AI-Station\WeAppForge\work\pay_probe_shot.png' });
const rd = await (await mp.currentPage()).data();
console.log('page:', JSON.stringify({ buying: rd.buying, popOpen: rd.popOpen, unlocked: rd.d && rd.d.unlocked }));
await mp.disconnect();
