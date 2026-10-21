// release_upload.js — miniprogram-ci 机器人上传（发布链①：部署后跑）
// 用法: node tools/release_upload.js [版本号] [描述]
// 凭据: ../data/secrets/private.wxfdb55b184756e89e.key（运行时读，零入仓）
const path = require('path');
const ci = require('miniprogram-ci');

const APPID = 'wxfdb55b184756e89e';
const PROJECT_PATH = path.resolve(__dirname, '..');           // zongbao-ai 根（project.config.json 所在）
const KEY_PATH = path.resolve(__dirname, '..', '..', '..', 'data', 'secrets', `private.${APPID}.key`);
const VERSION = process.argv[2] || '1.0.0';
const DESC = process.argv[3] || '知识库工厂KB-FACTORY v1：蓝图页+支付+下单（W1-W10全量）';

(async () => {
  const project = new ci.Project({
    appid: APPID,
    type: 'miniProgram',
    projectPath: PROJECT_PATH,
    privateKeyPath: KEY_PATH,
    ignores: ['node_modules/**/*', 'tools/**/*', 'v095-audit/**/*'],
  });
  const result = await ci.upload({
    project,
    version: VERSION,
    desc: DESC,
    setting: { es6: true, es7: true, minify: true, autoPrefixWXSS: true },
    onProgressUpdate: () => {},
  });
  console.log('[upload] OK', JSON.stringify(result && result.subPackageInfo ? result.subPackageInfo : result));
})().catch((e) => { console.error('[upload] FAIL:', e && e.message); process.exit(1); });
