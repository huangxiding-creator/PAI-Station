// Merge all channel dockets -> _merged.json + _INVENTORY.md (dedup by url, count per channel).
import { readFileSync, writeFileSync, readdirSync, statSync } from 'node:fs';
import path from 'node:path';

const ROOT = 'E:/AI-Station/_proposals/weapp-forge/RESEARCH_DOCKET';
const byUrl = new Map();
const channels = {};

function norm(u) {
  return String(u || '').replace(/[#?].*$/, '').replace(/\/+$/, '').toLowerCase().replace('http://', 'https://').replace('www.', '');
}

for (const dir of readdirSync(ROOT)) {
  const d = path.join(ROOT, dir);
  if (!statSync(d).isDirectory()) continue;
  for (const f of readdirSync(d)) {
    if (!f.endsWith('.json') || f.startsWith('_merged') || f.startsWith('_checkpoint')) continue;
    let j;
    try { j = JSON.parse(readFileSync(path.join(d, f), 'utf8')); } catch { continue; }
    const docs = Array.isArray(j) ? j : j.docs || [];
    for (const doc of docs) {
      const key = norm(doc.url) || norm(doc.title);
      if (!key || key === 'nan') continue;
      if (byUrl.has(key)) {
        const ex = byUrl.get(key);
        ex.channels = [...new Set((ex.channels || [ex.channel]).concat(doc.channel || dir))];
        continue;
      }
      byUrl.set(key, { ...doc, channels: [doc.channel || dir] });
    }
    channels[dir + '/' + f] = docs.length;
  }
}

const all = [...byUrl.values()];
const now = new Date().toISOString();
const perChannel = {};
for (const d of all) for (const c of d.channels || []) perChannel[c] = (perChannel[c] || 0) + 1;

writeFileSync(path.join(ROOT, '_merged.json'), JSON.stringify({ generated_at: now, total_unique: all.length, per_channel: perChannel, docs: all }, null, 1));

const sortStars = (a, b) => (b.signals?.stars || 0) - (a.signals?.stars || 0);
const md = [
  `# RESEARCH INVENTORY — merged (${all.length} unique items, ${new Date().toISOString().slice(0, 10)})`,
  '',
  `Per channel: ${Object.entries(perChannel).map(([k, v]) => `${k}=${v}`).join(' · ')}`,
  '',
  '| # | title | type | ch | stars | url | summary |',
  '|---|---|---|---|---|---|---|',
  ...all.slice().sort(sortStars).map((d, i) =>
    `| ${i + 1} | ${String(d.title || '').slice(0, 50).replace(/[|\n]/g, ' ')} | ${d.doc_type || '-'} | ${(d.channels || []).join(',') || d.channel} | ${d.signals?.stars ?? '-'} | ${d.url} | ${String(d.content || '').replace(/[|\n]/g, ' ').slice(0, 100)} |`),
].join('\n');
writeFileSync(path.join(ROOT, '_INVENTORY.md'), md);
console.log(JSON.stringify({ total_unique: all.length, per_channel: perChannel }, null, 1));
