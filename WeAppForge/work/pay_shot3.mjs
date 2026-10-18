import automator from 'miniprogram-automator';
import fs from 'node:fs';
const mp = await automator.connect({ wsEndpoint: 'ws://127.0.0.1:9420' });
const r = await mp.screenshot();
fs.writeFileSync('pay_probe_shot.png', Buffer.from(r, 'base64'));
console.log('saved', r.length);
await mp.disconnect();
