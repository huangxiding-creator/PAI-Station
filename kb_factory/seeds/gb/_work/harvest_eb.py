# -*- coding: utf-8 -*-
"""GB 免费件收割 v3：换源 eBiaozhun 免登录链（gb-standard skill 配方）.
上轮 std-samr 链 native_unavailable 全灭(manifest 在案), 本轮按 std 检索词走
ebiaozhun: search.html?q=关键词 -> /std/{hash}.html(pid+金币价) ->
/matrix/order/paystatus?type=doc&pid= -> code=1 即 0 币免登录直链 PDF.
纪律: 节流>=2.2s 单线程; 只收 0 币件, 付费件如实记账不绕; 连续5件不可下=链灭停手.
网络: 站点 Cloudflare 前置, 直连超时, 走本机 7893 出口(1024实测~50%成功率, 每请求重试3次).
幂等: 已在 manifest 记 ok 的 code 跳过, 可断点续跑."""
import io, json, os, re, sys, time

try:
    if sys.stdout.encoding and sys.stdout.encoding.lower() != 'utf-8':
        sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
except Exception:
    pass
import requests

BASE = 'https://www.ebiaozhun.com'
UA = ('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
      ' (KHTML, like Gecko) Chrome/126.0 Safari/537.36')
PROX = {'http': 'http://127.0.0.1:7893', 'https': 'http://127.0.0.1:7893'}
GB_DIR = r'E:\AI-Station\kb_factory\seeds\gb'
RAW = os.path.join(GB_DIR, '_raw')
KEYWORDS = ['水利水电', '混凝土', '堤防', '灌溉', '市政', '水电站', '工程验收', '水利工程测量']
MAX_PDF = 50                 # 任务目标上限 50 件
DEADLINE_MIN = 11            # 本进程收割相位时限(分钟), 断点续跑可再来一轮
MIN_PDF_BYTES = 100_000      # 上游配方验真线: <100KB 疑似错误壳

os.makedirs(RAW, exist_ok=True)
MAN = os.path.join(RAW, 'manifest.jsonl')
s = requests.Session()
s.headers.update({'User-Agent': UA})
s.proxies.update(PROX)

def ev(*a):
    print('EV', *a, flush=True)

def log(**kw):
    """manifest 追加审计: 每件一行 {action, code, result, ts}."""
    kw['ts'] = time.strftime('%H:%M:%S')
    with open(MAN, 'a', encoding='utf-8') as f:
        f.write(json.dumps(kw, ensure_ascii=False) + '\n')

def nap():
    time.sleep(2.2)          # 铁律节流: >=2.2s

def rget(url, tries=3, **kw):
    """带重试的 GET(7893 出口 ~50% 成功率, 重试是网络层自愈不是加压)."""
    kw.setdefault('timeout', 30)
    last = None
    for i in range(tries):
        try:
            return s.get(url, **kw)
        except Exception as e:                             # noqa: BLE001
            last = e
            time.sleep(2.2)
    raise last

def norm_code(t):
    """标题 -> 标准号 'GB(/T)? NNNN-YYYY' (非 GB 前缀返回 None)."""
    m = re.search(r'(GB(?:/T)?)\s*(\d{3,6}(?:\.\d+)?)\s*[-—.]\s*(\d{4})', t)
    if not m:
        return None
    return '%s %s-%s' % (m.group(1), m.group(2), m.group(3))

# ---------- 相位A: 关键词检索, 建 0 币候选池 ----------
def phase_search():
    cand, seen = [], set()
    for kw in KEYWORDS:
        try:
            r = rget(BASE + '/search.html', params={'q': kw})
            pairs = re.findall(r'<a[^>]+href="/std/([0-9a-f]+)\.html"[^>]*>(.*?)</a>',
                               r.text, re.DOTALL)
            hit = 0
            for h, txt in pairs:
                title = re.sub(r'<[^>]+>', '', txt).strip()
                code = norm_code(title)
                if not code or code in seen:
                    continue
                seen.add(code)
                strong = code.startswith('GB ')            # 强制性 GB 优先
                year = int(code[-4:])
                cand.append({'kw': kw, 'hash': h, 'code': code, 'title': title[:80],
                             'strong': strong, 'year': year})
                hit += 1
            ev('search', kw, 'links', len(pairs), 'gb_new', hit, 'cum', len(cand))
        except Exception as e:                             # noqa: BLE001
            ev('search_err', kw, type(e).__name__, str(e)[:60])
        nap()
    cand.sort(key=lambda x: (not x['strong'], -x['year']))  # 强制性优先, 新版优先
    return cand

# ---------- 相位B: 逐件 detail->paystatus->(0币才)下载 ----------
def phase_harvest(cand):
    done_ok = set()
    if os.path.exists(MAN):
        for ln in open(MAN, encoding='utf-8'):
            try:
                d = json.loads(ln)
                if d.get('result') == 'ok' and d.get('code'):
                    done_ok.add(d['code'])
            except Exception:                              # noqa: BLE001
                pass
    got, nonfree_streak, tries = [], 0, 0
    t0 = time.time()
    for x in cand:
        if len(got) >= MAX_PDF or nonfree_streak >= 5 or tries >= 45:
            break
        if (time.time() - t0) > DEADLINE_MIN * 60:
            ev('deadline_hit', 'tries', tries, 'got', len(got)); break
        if x['code'] in done_ok:
            ev('skip_done', x['code']); continue
        tries += 1
        try:
            nap()
            det = rget(BASE + '/std/%s.html' % x['hash'])
            pid_m = re.search(r'var\s+pid\s*=\s*(\d+)\s*;', det.text)
            if not pid_m:
                nonfree_streak += 1
                log(action='download', code=x['code'], result='no_pid')
                ev('no_pid', x['code']); continue
            pid = pid_m.group(1)
            price_m = re.search(r'下载文档需要支付\s*<span[^>]*>(\d+)</span>\s*金币', det.text)
            price = price_m.group(1) if price_m else '?'
            nap()
            ps = rget(BASE + '/matrix/order/paystatus',
                      params={'type': 'doc', 'pid': pid},
                      headers={'Referer': BASE + '/std/%s.html' % x['hash'],
                               'X-Requested-With': 'XMLHttpRequest',
                               'Accept': 'application/json, text/javascript, */*; q=0.01'})
            try:
                d = ps.json()
            except ValueError:
                nonfree_streak += 1
                log(action='download', code=x['code'], result='paystatus_nonjson',
                    http=ps.status_code, price=price)
                ev('nonjson', x['code'], ps.status_code); continue
            if d.get('code') != 1:
                # 付费件如实记账, 不绕支付墙 (账号安全纪律)
                nonfree_streak += 1
                msg = str(d.get('msg', d))[:60]
                log(action='download', code=x['code'], result='paid', price=price,
                    detail=msg)
                ev('paid', x['code'], 'price', price); continue
            f0 = (d.get('data', {}).get('files') or [{}])[0]
            if not f0.get('url'):
                nonfree_streak += 1
                log(action='download', code=x['code'], result='no_file_url', price=price)
                ev('no_url', x['code']); continue
            url = f0['url']
            if url.startswith('/'):
                url = BASE + url
            nap()
            dl = rget(url, tries=2, headers={'Referer': BASE + '/'}, timeout=120)
            pdf = dl.content
            if pdf[:4] != b'%PDF':
                nonfree_streak += 1
                log(action='download', code=x['code'], result='not_pdf_head',
                    head=pdf[:8].decode('latin1'))
                ev('notpdf', x['code']); continue
            if len(pdf) < MIN_PDF_BYTES:
                nonfree_streak += 1
                log(action='download', code=x['code'], result='too_small',
                    bytes=len(pdf))
                ev('small', x['code'], len(pdf)); continue
            stem = re.sub(r'[^0-9A-Za-z]+', '_', x['code'])
            p = os.path.join(RAW, stem + '.pdf')
            with open(p, 'wb') as f:
                f.write(pdf)
            x.update(pid=pid, price=price, pdf=p, bytes=len(pdf),
                     eb_url=BASE + '/std/%s.html' % x['hash'])
            got.append(x)
            nonfree_streak = 0                              # 免费件命中, 连败清零
            log(action='download', code=x['code'], result='ok', kb=round(len(pdf) / 1024),
                n=len(got))
            ev('OK', x['code'], x['kw'], round(len(pdf) / 1024), 'KB', 'n=' + str(len(got)))
        except Exception as e:                              # noqa: BLE001
            nonfree_streak += 1
            log(action='error', code=x['code'], err='%s:%s' % (type(e).__name__, str(e)[:80]))
            ev('err', x['code'], type(e).__name__, str(e)[:60])
    ev('SUMMARY', 'cand=%d tries=%d got=%d streak=%d' % (len(cand), tries, len(got), nonfree_streak))
    return got, nonfree_streak

cand = phase_search()
# 续跑合并: 搜索腿灭时不清空遗产候选, 既有候选按 code 去重并入(1025续跑令)
_cand_path = os.path.join(RAW, '_eb_candidates.json')
try:
    _old = json.load(open(_cand_path, encoding='utf-8'))
except Exception:                                      # noqa: BLE001
    _old = []
_seen = {c['code'] for c in cand}
cand += [o for o in _old if o.get('code') and o['code'] not in _seen]
cand.sort(key=lambda x: (not x['strong'], -x['year']))
json.dump(cand, open(_cand_path, 'w', encoding='utf-8'),
          ensure_ascii=False, indent=1)
ev('CAND_DUMP', len(cand), 'legacy', len(_old))
got, streak = phase_harvest(cand)
# 与上轮 _harvest_result.json 兼容合并(字段按 make_seeds_eb 需要)
res_path = os.path.join(RAW, '_harvest_result.json')
old = []
if os.path.exists(res_path):
    try:
        old = json.load(open(res_path, encoding='utf-8'))
    except Exception:                                      # noqa: BLE001
        old = []
old_codes = {o.get('code') for o in old}
merged = old + [g for g in got if g['code'] not in old_codes]
json.dump(merged, open(res_path, 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
ev('HARVEST_EB DONE', 'got_this_run=%d total=%d dead_streak=%d' % (len(got), len(merged), streak))
