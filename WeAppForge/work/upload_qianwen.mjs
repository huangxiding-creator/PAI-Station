// 总包AI顾问 上传器 —— 真身 = projects/zongbao-ai（0929 由 biaoxun 更名，老名永久退役）
// 用法: NODE_OPTIONS="--require E:/AI-Station/WeAppForge/work/localstorage-shim.cjs" node work/upload_qianwen.mjs [version] [desc]
// Node25 坑: corecompiler 子进程 localStorage.getItem 崩 → 必须带上面的 NODE_OPTIONS shim（exit 0 假成功实锤）
//
// 0929 教训级铁律（「页面不存在」复发根因）：
//   同一 robot 再上传会替换该机器人名下的开发版本记录；体验版钉着该记录时即被顶掉，
//   钉位悬空 → 全部入口按线上版 1.0.7 老页面表解析 → 扫码「页面不存在」。
//   故：robot 1..30 轮转（被钉记录永不因后续上传被顶）+ 上传后自动跑体验版健康探针。
import ci from 'miniprogram-ci';
import fs from 'node:fs';
import { execSync } from 'node:child_process';

const version = process.argv[2] || '0.2.7';
const desc = process.argv[3] || '真身修正: 0.2.7';

// ── robot 轮转：cursor 文件记录上次用过的 robot，本次取下一个（1..30 循环）──
const CURSOR = 'work/robot_cursor.txt';
let last = 1;
try { last = parseInt(fs.readFileSync(CURSOR, 'utf-8').trim(), 10) || 1; } catch {}
const robot = (last % 30) + 1;
fs.writeFileSync(CURSOR, String(robot));
fs.appendFileSync('work/robot_registry.jsonl',
  JSON.stringify({ time: new Date().toISOString(), version, desc, robot }) + '\n');

const project = new ci.Project({
  appid: 'wx5cee1574ce45819b',
  type: 'miniProgram',
  projectPath: 'projects/zongbao-ai',
  privateKeyPath: 'E:/AI-Station/data/secrets/private.wx5cee1574ce45819b.key',
  ignores: ['node_modules/**/*'],
});

const result = await ci.upload({
  project,
  version,
  desc,
  robot,
  setting: { es6: true, es7: true, minify: true, autoPrefixWXSS: true },
  onProgressUpdate: () => {},
});

console.log('UPLOAD_OK', JSON.stringify({
  version,
  robot,
  subPackageInfo: result.subPackageInfo,
  pluginInfo: result.pluginInfo,
}));

// ── 上传后健康探针：钉位悬空（BROKEN）→ 立刻可见并给出用户唯一修复动作，杜绝静默劣化 ──
try {
  const out = execSync('python work/trial_health_probe.py', {
    encoding: 'utf-8',
    env: { ...process.env, PYTHONIOENCODING: 'utf-8' },
    stdio: ['ignore', 'pipe', 'pipe'],
  });
  const line = (out.match(/SUMMARY: \S+/) || ['SUMMARY: ?'])[0];
  console.log('TRIAL_HEALTH_AFTER_UPLOAD:', line);
  if (line.includes('BROKEN')) {
    console.log('>>> 需用户一步：版本管理 → 本次上传的开发版本 → 「选为体验版」（无API可代办）');
  }
} catch (e) {
  console.log('TRIAL_HEALTH_PROBE_ERROR(不影响上传):', String(e.message).slice(0, 200));
}
