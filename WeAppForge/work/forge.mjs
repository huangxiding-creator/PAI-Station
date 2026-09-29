// work/forge.mjs — WeAppForge 统一小程序工具链入口
// 融合：miniprogram-ci 上传/预览 + WXML 闸门 + 多项目注册表 + 企微交付
// 用法：
//   node work/forge.mjs list
//   node work/forge.mjs lint <proj>
//   node work/forge.mjs upload <proj> <version> <desc...>     # 闸门不过=拒传
//   node work/forge.mjs preview <proj> [qr.png]               # 预览二维码
//   node work/forge.mjs deliver <proj> <version> <desc...>    # lint→upload→preview→推企微
import { readFileSync, writeFileSync, existsSync } from 'node:fs';
import { execFileSync } from 'node:child_process';
import { createRequire } from 'node:module';

const require_ = createRequire(import.meta.url);
const ROOT = new URL('..', import.meta.url).pathname.replace(/^\/([A-Za-z]:)/, '$1');
const REG = JSON.parse(readFileSync(new URL('../data/projects.json', import.meta.url), 'utf8'));

// Node ≥22 兼容：miniprogram-ci 探测 global.localStorage 会 TypeError，遮蔽之
try { Object.defineProperty(globalThis, 'localStorage', { get: () => undefined, configurable: true }) } catch {}
process.env.NODE_OPTIONS = '--no-experimental-webstorage'; // 传播给编译子进程
const ci = require_('miniprogram-ci');

function proj(name) {
  const p = REG.projects[name];
  if (!p) { console.error(`未知项目 "${name}"。已注册: ${Object.keys(REG.projects).join(', ')}`); process.exit(2); }
  return p;
}

function lint(projectPath) {
  try {
    execFileSync(process.execPath, ['work/wxml_lint.mjs', projectPath], { cwd: ROOT, stdio: 'inherit' });
    return true;
  } catch { return false; }
}

function buildProject(p) {
  const key = readFileSync(p.privateKeyPath, 'utf8');
  return new ci.Project({
    appid: p.appid, type: 'miniProgram',
    projectPath: new URL('../' + p.projectPath.replace(/^\//, ''), import.meta.url).pathname.replace(/^\/([A-Za-z]:)/, '$1'),
    privateKey: key, ignores: ['node_modules/**/*'],
  });
}

function pushWecom(pngPath, displayName) {
  try {
    execFileSync('python', ['tools/send_wecom_file.py', pngPath, displayName], { cwd: 'E:/AI-Station', stdio: 'inherit' });
    return true;
  } catch (e) { console.error('企微推送失败:', e.message); return false; }
}

const [cmd, ...args] = process.argv.slice(2);
if (cmd === 'list') {
  for (const [k, v] of Object.entries(REG.projects)) {
    console.log(`${k === REG.current ? '▶' : ' '} ${k.padEnd(9)} ${v.name.padEnd(5)} ${v.appid}  ${v.projectPath}`);
  }
  process.exit(0);
}
if (!cmd || !args.length) { console.error('用法见文件头注释'); process.exit(2); }
const p = proj(args[0]);

if (cmd === 'lint') {
  process.exit(lint(p.projectPath) ? 0 : 1);
}

if (cmd === 'upload' || cmd === 'deliver') {
  if (!lint(p.projectPath)) { console.error('⛔ WXML 闸门拦截，取消上传'); process.exit(1); }
  const version = args[1] ?? '0.0.1';
  const desc = args.slice(2).join(' ') || `${p.name} ${version}`;
  const t0 = Date.now();
  const result = await ci.upload({
    project: buildProject(p), version, desc,
    setting: { es6: true, es7: true, minify: true, autoPrefixWXSS: true },
    onProgressUpdate: () => {},
  });
  console.log(`✓ 上传 PASS ${p.name} v${version} (${((Date.now() - t0) / 1000).toFixed(1)}s)`);
}

if (cmd === 'preview' || cmd === 'deliver') {
  const qr = args[1]?.endsWith('.png') ? args[1] : `work/${args[0]}_preview_qr.png`;
  await ci.preview({
    project: buildProject(p), desc: `${p.name} preview`,
    setting: { es6: true, es7: true, autoPrefixWXSS: true },
    qrcodeFormat: 'image', qrcodeOutputDest: qr, onProgressUpdate: () => {},
  });
  console.log(`✓ 预览二维码 → ${qr}`);
  if (cmd === 'deliver' && existsSync(qr)) {
    pushWecom(join(ROOT, qr), `${p.name}_体验二维码.png`);
  }
}

function join(...ps) { return ps.join('/').replace(/\/+/g, '/'); }
