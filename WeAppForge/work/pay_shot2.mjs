import automator from 'miniprogram-automator';
import fs from 'node:fs';
const mp = await automator.connect({ wsEndpoint: 'ws://127.0.0.1:9420' });
try {
  const r = await mp.screenshot();
  if (r && r.base64) { fs.writeFileSync('pay_probe_shot.png', Buffer.from(r.base64, 'base64')); console.log('saved b64', r.base64.length); }
  else console.log('ret:', JSON.stringify(r).slice(0, 200));
} catch (e) { console.log('ERR:', e.message); }
await mp.disconnect();
