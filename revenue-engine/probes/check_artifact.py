# -*- coding: utf-8 -*-
"""Report/artifact DoD checker (P6-defined markers). Usage: py -I check_artifact.py <key>
Workers: your report must contain the markers below (see SPEC). Exits 0 only when done."""
import re, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]

SPEC = {
    'survival': [
        ('revenue-engine/reports/survival/survival_report.md',
         ['VERDICT: PASS|VERDICT: FAIL', 'D14', '在线率', '进群']),
    ],
    'order_paid': [
        ('revenue-engine/reports/order-gate/payment_proof.md',
         ['ORDER_RESULT: DELIVERED|ORDER_RESULT: FAILED', '498']),
    ],
    'order_gate': [
        ('revenue-engine/reports/order-gate/order_gate_report.md',
         ['ORDER_RESULT: DELIVERED|ORDER_RESULT: FAILED', '498', '交付|ADR']),
    ],
    'merchant_adr': [
        ('revenue-engine/docs/adr/ADR-005-payment-paths.md',
         ['CONCLUSION: V3|CONCLUSION: PERSONAL_QR|CONCLUSION: DEFERRED', '依据']),
    ],
    'collab_doc': [
        ('revenue-engine/docs/collaboration.md',
         ['问答分工', '去重', '风控', '10 ?分钟']),
    ],
    'scoring_doc': [
        ('revenue-engine/docs/scoring.md',
         ['省份', '行业', '规模', '时间窗', '70', '50', '调参']),
    ],
    'group_assets': [
        ('revenue-engine/reports/group-assets/group_assets_audit.md',
         ['AUDIT_DONE', '群主']),
    ],
    'membership_adr': [
        ('revenue-engine/docs/adr/ADR-002-membership.md',
         ['DECISION:', 'meedu']),
    ],
    'qa_sampling': [
        ('revenue-engine/reports/qa-audit/qa_sampling_report.md',
         ['OUTCOME: PASS', '出处']),
    ],
    'plugin_fallback': [
        ('revenue-engine/docs/adr/ADR-007-plugin-fallback.md', ['DRILL:', 'B ?栈']),
        ('revenue-engine/reports/drills/plugin-fallback.md', ['DRILL:']),
    ],
    'rl_matrix': [
        ('revenue-engine/reviews/rate-limit-matrix.md',
         ['AUDIT:CLEAN', 'CowAgent', '同停']),
    ],
    'incident_drill': [
        ('revenue-engine/runbooks/incident-response.md',
         ['DRILL:', '30 ?分钟', '分级']),
        ('revenue-engine/reports/drills/incident-drill.md',
         ['DRILL:', '时间戳']),
    ],
    'attribution_report': [
        ('revenue-engine/reports/attribution/first_report.md',
         ['ORDERS: ', '转化率', '源消息']),
    ],
    'daily_report': [
        ('revenue-engine/reports/daily/latest.md',
         ['DAILY: OK', '五轴', '收入']),
    ],
    'soak_zero': [
        ('revenue-engine/reports/soak/soak_72h.md',
         ['HUMAN_INTERVENTIONS: 0']),
    ],
    'soak_downtime': [
        ('revenue-engine/reports/soak/soak_72h.md',
         ['DOWNTIME:', 'HUMAN_INTERVENTIONS: 0']),
    ],
}

EXTRA = {
    'qa_sampling': lambda s: (lambda m: bool(m) and int(m.group(1)) >= 20 and int(m.group(2)) >= 80)(
        re.search(r'OUTCOME: PASS n=(\d+) rate=(\d+)', s)),
    'attribution_report': lambda s: (lambda m: bool(m) and int(m.group(1)) >= 3)(
        re.search(r'ORDERS: (\d+)', s)),
}

def main():
    key = sys.argv[1] if len(sys.argv) > 1 else ''
    if key not in SPEC:
        print('FAIL unknown key:', key); print('keys:', ' '.join(SPEC)); sys.exit(2)
    ok = True
    for rel, markers in SPEC[key]:
        f = ROOT / rel
        if not f.is_file():
            print('FAIL missing file:', rel); ok = False; continue
        s = f.read_text(encoding='utf-8')
        for m in markers:
            if not re.search(m, s):
                print('FAIL %s: marker /%s/ not found' % (rel, m)); ok = False
        fn = EXTRA.get(key)
        if fn and not fn(s):
            print('FAIL %s: numeric gate (n/rate or orders) not met' % rel); ok = False
    print(('PASS' if ok else 'FAIL'), key)
    sys.exit(0 if ok else 1)

if __name__ == '__main__':
    main()
