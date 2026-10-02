// Breadth sweep: GitHub topic/keyword discovery + npm registry harvest.
// Signals are measured, never fabricated. Output: _all.json + _all.md per channel dir.
import { execSync } from 'node:child_process';
import { writeFileSync, mkdirSync } from 'node:fs';
import path from 'node:path';

const ROOT = 'E:/AI-Station/_proposals/weapp-forge/RESEARCH_DOCKET';
const GH_QUERIES = [
  'topic:miniprogram',
  'topic:wechat-miniprogram',
  'topic:weapp',
  'topic:wxapp',
  'wechat miniprogram',
  'weixin miniprogram',
  '微信小程序',
  'miniprogram template',
  'weapp template',
  'miniprogram cli',
  'miniprogram generator',
  'wechat miniprogram ai',
  'miniprogram boilerplate',
  'miniprogram framework',
];
const NPM_QUERIES = ['miniprogram', 'weapp', 'wechat miniprogram', 'miniprogram ci'];

function ghSearch(q) {
  const url = `search/repositories?q=${encodeURIComponent(q)}&sort=stars&order=desc&per_page=30`;
  const out = execSync(`gh api ${JSON.stringify(url)}`, { encoding: 'utf8', maxBuffer: 32 * 1024 * 1024, timeout: 60000 });
  return JSON.parse(out).items || [];
}

async function npmSearch(q) {
  const res = await fetch(`https://registry.npmjs.org/-/v1/search?text=${encodeURIComponent(q)}&size=100`);
  if (!res.ok) throw new Error(`npm ${res.status}`);
  const j = await res.json();
  return (j.objects || []).map((o) => o.package);
}

const now = new Date().toISOString();
const degraded = [];

// ---- GitHub sweep ----
const ghMap = new Map();
for (const q of GH_QUERIES) {
  try {
    const items = ghSearch(q);
    for (const r of items) {
      const prev = ghMap.get(r.full_name);
      const tags = new Set((prev?.signals?.source_queries || []).concat([q]));
      ghMap.set(r.full_name, {
        channel: 'github',
        doc_type: 'repo',
        title: r.full_name,
        url: r.html_url,
        content: r.description || '',
        signals: {
          stars: r.stargazers_count,
          forks: r.forks_count,
          language: r.language || '',
          pushed_at: r.pushed_at,
          archived: !!r.archived,
          topics: (r.topics || []).slice(0, 8),
          source_queries: [...tags],
        },
        retrieved_at: now,
        credibility: 0.85,
      });
    }
    console.log(`[gh] "${q}" -> ${items.length}`);
  } catch (e) {
    degraded.push({ q, err: String(e).slice(0, 120) });
    console.log(`[gh] "${q}" FAILED: ${String(e).slice(0, 120)}`);
  }
}

const ghDir = path.join(ROOT, 'github');
mkdirSync(ghDir, { recursive: true });
const ghDocs = [...ghMap.values()].sort((a, b) => b.signals.stars - a.signals.stars);
writeFileSync(path.join(ghDir, '_sweep_all.json'), JSON.stringify({ channel: 'github', generated_at: now, docs: ghDocs, degraded }, null, 1));
const ghMd = [
  `# github sweep (${ghDocs.length} unique repos, ${GH_QUERIES.length} queries)`,
  '',
  '| repo | stars | lang | pushed | desc |',
  '|---|---|---|---|---|',
  ...ghDocs.map((d) => `| [${d.title}](${d.url}) | ${d.signals.stars} | ${d.signals.language || '-'} | ${(d.signals.pushed_at || '').slice(0, 10)} | ${(d.content || '').replace(/[|\n]/g, ' ').slice(0, 90)} |`),
].join('\n');
writeFileSync(path.join(ghDir, '_sweep_all.md'), ghMd);
console.log(`GITHUB unique repos: ${ghDocs.length} (degraded: ${degraded.length})`);

// ---- npm sweep ----
const npmMap = new Map();
const npmDegraded = [];
for (const q of NPM_QUERIES) {
  try {
    const pkgs = await npmSearch(q);
    for (const p of pkgs) {
      if (!npmMap.has(p.name)) {
        npmMap.set(p.name, {
          channel: 'npm_pypi',
          doc_type: 'package',
          title: p.name,
          url: p.links?.npm || `https://www.npmjs.com/package/${p.name}`,
          content: (p.description || '').slice(0, 200),
          signals: {
            version: p.version,
            publisher: p.publisher?.username || '',
            date: p.date,
            keywords: (p.keywords || []).slice(0, 8),
            source_queries: [q],
          },
          retrieved_at: now,
          credibility: 0.8,
        });
      } else {
        npmMap.get(p.name).signals.source_queries.push(q);
      }
    }
    console.log(`[npm] "${q}" -> ${pkgs.length}`);
  } catch (e) {
    npmDegraded.push({ q, err: String(e).slice(0, 120) });
    console.log(`[npm] "${q}" FAILED: ${String(e).slice(0, 120)}`);
  }
}
const npmDir = path.join(ROOT, 'npm_pypi');
mkdirSync(npmDir, { recursive: true });
const npmDocs = [...npmMap.values()];
writeFileSync(path.join(npmDir, '_sweep_all.json'), JSON.stringify({ channel: 'npm_pypi', generated_at: now, docs: npmDocs, degraded: npmDegraded }, null, 1));
const npmMd = [
  `# npm sweep (${npmDocs.length} unique packages)`,
  '',
  '| package | version | date | desc |',
  '|---|---|---|---|',
  ...npmDocs.map((d) => `| [${d.title}](${d.url}) | ${d.signals.version} | ${(d.signals.date || '').slice(0, 10)} | ${(d.content || '').replace(/[|\n]/g, ' ').slice(0, 80)} |`),
].join('\n');
writeFileSync(path.join(npmDir, '_sweep_all.md'), npmMd);
console.log(`NPM unique packages: ${npmDocs.length} (degraded: ${npmDegraded.length})`);
