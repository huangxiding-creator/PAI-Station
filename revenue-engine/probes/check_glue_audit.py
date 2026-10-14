# -*- coding: utf-8 -*-
"""REQ-024 P6 gate: glue line-count gate (<=300 code lines) + dependency license audit.
Re-run anytime: py -I revenue-engine/probes/check_glue_audit.py
Counting rule: physical lines of production glue files, excluding blanks and #-comment
lines. Tests/probes/docs/config are NOT glue and are not counted."""
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
BUDGET = 300

GLUE_FILES = [
    '私域运营/zbops/zbops/radar/lead_transformer.py',   # <=200 incl dedup/alert/attribution append
    '私域运营/zbops/zbops/radar/service_8440.py',        # 8440 entry + enqueue
    '私域运营/zbops/zbops/radar/followup.py',            # 48h reminder (reuse-first, else counted)
    '私域运营/zbops/zbops/radar/audit_log.py',          # audit bus (reuse-first, else counted)
]
GLUE_GLOBS = ['revenue-engine/deploy/langbot-plugins/**/*.py']  # global-daily-20 plugin ~50

REQUIRED_COMPONENTS = ['LangBot', 'WeChatPadPro', 'EspoCRM', 'CowAgent',
                       'acg-faka', 'wechatpay', 'digest', 'AGPL', 'MIT', 'Apache']

def code_lines(f: Path) -> int:
    n = 0
    for ln in f.read_text(encoding='utf-8', errors='replace').splitlines():
        t = ln.strip()
        if t and not t.startswith('#'):
            n += 1
    return n

def main():
    ok = True
    total = 0
    rows = []
    for rel in GLUE_FILES:
        f = ROOT / rel
        n = code_lines(f) if f.is_file() else 0
        rows.append((rel, n, 'missing' if not f.is_file() else 'ok'))
        total += n
    for g in GLUE_GLOBS:
        for f in sorted((ROOT / g.split('/')[0]).glob('/'.join(g.split('/')[1:]))):
            n = code_lines(f)
            rows.append((str(f.relative_to(ROOT)), n, 'ok'))
            total += n
    for rel, n, st in rows:
        print('%5d  %-8s %s' % (n, st, rel))
    print('GLUE_TOTAL: %d/%d' % (total, BUDGET))
    if total > BUDGET:
        print('FAIL glue budget exceeded'); ok = False
    audit = ROOT / '.super-skill/glue_audit.md'
    if not audit.is_file():
        print('FAIL .super-skill/glue_audit.md missing'); ok = False
    else:
        s = audit.read_text(encoding='utf-8')
        for c in REQUIRED_COMPONENTS:
            if c not in s:
                print('FAIL license audit missing component:', c); ok = False
        m = [ln for ln in s.splitlines() if ln.startswith('GLUE_TOTAL:')]
        if not m:
            print('FAIL audit file has no GLUE_TOTAL: line'); ok = False
        else:
            claimed = int(m[-1].split()[1].split('/')[0])
            if claimed != total:
                print('FAIL audit snapshot stale: claims %d, actual %d (update .super-skill/glue_audit.md)' % (claimed, total)); ok = False
    print('PASS' if ok else 'FAIL', 'REQ-024 glue+license gate')
    sys.exit(0 if ok else 1)

if __name__ == '__main__':
    main()
