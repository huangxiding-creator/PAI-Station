// 总包千问 · miniprogram-ci 上传/预览
// 用法: node tools/upload.js            → 上传开发版
//       node tools/upload.js --preview  → 生成预览二维码 (preview.png)
//       node tools/upload.js --preview-only / --upload-only
const path = require('path');
const fs = require('fs');
const ci = require('miniprogram-ci');

const ROOT = path.resolve(__dirname, '..');
const KEY = String.raw`E:\AI-Station\微信小程序\private.wxd096fc6994ef6f48.key`;

async function main() {
  const args = process.argv.slice(2);
  const opt = (name, fallback) => {
    const i = args.indexOf(name);
    return i >= 0 && args[i + 1] ? args[i + 1] : fallback;
  };
  const APPID = opt('--appid', 'wxd096fc6994ef6f48');
  const KEY = opt('--key', String.raw`E:\AI-Station\微信小程序\private.wxd096fc6994ef6f48.key`);
  const ROBOT = Number(opt('--robot', '1'));
  const wantPreview = args.includes('--preview') || args.includes('--preview-only');
  const wantUpload = !args.includes('--preview-only');

  if (!fs.existsSync(KEY)) {
    console.error(`[err] 上传密钥缺失: ${KEY}`);
    process.exit(1);
  }

  const project = new ci.Project({
    appid: APPID,
    type: 'miniProgram',
    projectPath: ROOT,
    privateKeyPath: KEY,
    ignores: ['node_modules/**/*', 'tools/**/*', 'package.json', 'package-lock.json', '_attic/**/*'],
  });

  const setting = { es6: true, es7: true, minify: true, autoPrefixWXSS: true };

  if (wantUpload) {
    const version = require(path.join(ROOT, 'package.json')).version;
    const res = await ci.upload({
      project,
      version,
      robot: ROBOT,
      desc: opt('--desc', '总包说科技 v1.1 · 顶部标题统一/删首页眼镜图/产品详情点击引导'),
      setting,
      onProgressUpdate: () => {},
    });
    console.log('[upload ok]', JSON.stringify(res));
  }

  if (wantPreview) {
    const res = await ci.preview({
      project,
      desc: '总包千问 预览',
      setting,
      qrcodeFormat: 'image',
      qrcodeOutputDest: path.join(ROOT, 'preview.png'),
      pagePath: 'pages/index/index',
      onProgressUpdate: () => {},
    });
    console.log('[preview ok]', JSON.stringify(res));
  }
}

main().catch((err) => {
  console.error('[fail]', err && err.message ? err.message : err);
  if (err && err.stack) console.error('[stack]', err.stack);
  process.exit(1);
});
