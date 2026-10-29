# -*- coding: utf-8 -*-
# keyword extraction over decrypted WeChat 4.x message dbs
import sys, os, re, json, sqlite3, hashlib, time
from collections import Counter, defaultdict

dec = sys.argv[1]
out_jsonl = os.path.join(dec, 'hits.jsonl')

def resolve(name):
    """accept both flat name and '<sub>__<name>' (v7c decrypt layout)"""
    p = os.path.join(dec, name)
    if os.path.exists(p):
        return p
    try:
        for f in os.listdir(dec):
            if f.endswith('__' + name):
                return os.path.join(dec, f)
    except OSError:
        pass
    return p
KW = re.compile(r'EPC|出海|海外|境外|国际工程|对外承包|一带一路|海外市场|海外项目|海外电力|国际电力|FIDIC|索赔|超概算|工程亏|总承包亏损|银皮书|黄皮书|红皮书|'
    r'印尼|越南|沙特|阿联酋|迪拜|巴基斯坦|哈萨克|土耳其|孟加拉|肯尼亚|巴西|菲律宾|中亚|东南亚|中东|非洲|老挝|尼泊尔|乌兹别克|吉尔吉斯|塔吉克|蒙古|马来西亚|泰国|印尼雅万|海外投标|国际招标|海外中标', re.I)
TALK_MD5 = {}

def q(con, sql, args=()):
    return con.execute(sql, args).fetchall()

def to_text(blob):
    return blob if isinstance(blob, str) else ''

import wx4_pipeline as P  # reuse to_text/zstd

def main():
    # 1. contact map
    cmap = {}
    try:
        con = sqlite3.connect(resolve('contact.db'))
        tabs = [r[0] for r in q(con, "SELECT name FROM sqlite_master WHERE type='table'")]
        print('contact tables:', tabs[:20], flush=True)
        for t in tabs:
            cols = [c[1] for c in q(con, f'PRAGMA table_info("{t}")')]
            if any('username' == c.lower() for c in cols):
                nn = next((c for c in cols if c.lower() in ('nickname','nick_name')), None)
                rk = next((c for c in cols if c.lower() in ('remark','remark_name')), None)
                try:
                    for r in q(con, f'SELECT username, {nn or "username"}, {rk or "username"} FROM "{t}"'):
                        u, n, m = r
                        if not u: continue
                        has_name = bool((nn and n) or (rk and m))
                        if has_name or u not in cmap:
                            cmap[u] = (m or n or u, n or u)
                except Exception as e:
                    print('contact table err', t, e, flush=True)
        con.close()
    except Exception as e:
        print('contact.db err', e, flush=True)
    print('contacts:', len(cmap), flush=True)
    for u in list(cmap): TALK_MD5[hashlib.md5(u.encode()).hexdigest()] = u

    # 2. session usernames (for chatroom display + hit scope)
    sess_users = set()
    try:
        con = sqlite3.connect(resolve('session.db'))
        tabs = [r[0] for r in q(con, "SELECT name FROM sqlite_master WHERE type='table'")]
        for t in tabs:
            cols = [c[1].lower() for c in q(con, f'PRAGMA table_info("{t}")')]
            if 'username' in cols:
                for r in q(con, f'SELECT username FROM "{t}"'):
                    if r[0]: sess_users.add(r[0])
        con.close()
    except Exception as e:
        print('session err', e, flush=True)
    print('session users:', len(sess_users), flush=True)

    hits = []; stats = Counter(); talker_hits = Counter(); rows_total = 0
    # 0. pre-pass: Name2Id (rowid -> user_name) from every message db; feeds TALK_MD5
    N2I = {}
    for dbname in ('message_0.db', 'message_1.db', 'message_2.db', 'biz_message_0.db'):
        p = resolve(dbname)
        if not os.path.exists(p): continue
        try:
            con0 = sqlite3.connect(p)
            for rid, un in con0.execute('SELECT rowid, user_name FROM Name2Id'):
                if un: N2I[(dbname, rid)] = un
            con0.close()
        except Exception as e:
            print('Name2Id err', dbname, e, flush=True)
    for un in set(N2I.values()):
        TALK_MD5[hashlib.md5(un.encode()).hexdigest()] = un
    print('Name2Id entries:', len(N2I), 'distinct users:', len(set(N2I.values())), flush=True)
    fh = open(out_jsonl, 'w', encoding='utf-8')
    for dbname in ('message_0.db', 'message_1.db', 'message_2.db', 'biz_message_0.db'):
        path = resolve(dbname)
        if not os.path.exists(path): continue
        con = sqlite3.connect(path)
        tabs = [r[0] for r in q(con, "SELECT name FROM sqlite_master WHERE type='table'")]
        # Name2Id (this db, rowid-keyed)
        n2i = {}
        for rid, un in con.execute('SELECT rowid, user_name FROM Name2Id'):
            if un: n2i[rid] = un
        msg_tabs = [t for t in tabs if t.startswith('Msg_')]
        print(f'{dbname}: {len(msg_tabs)} Msg tables, Name2Id={len(n2i)}', flush=True)
        for t in msg_tabs:
            sufx = t[4:]
            talker = TALK_MD5.get(sufx, sufx)
            disp = cmap.get(talker, (talker, talker))[0]
            try:
                cur = con.execute(f'SELECT local_id, local_type, status, create_time, sort_seq, real_sender_id, message_content, compress_content FROM "{t}"')
            except Exception as e:
                print('  skip', t, e, flush=True); continue
            while True:
                rows = cur.fetchmany(4096)
                if not rows: break
                for lid, ltype, status, ct, ss, sender_id, mc, cc in rows:
                    rows_total += 1
                    txt = P.to_text(mc) if mc else (P.to_text(cc) if cc else '')
                    if not txt or len(txt) > 300000: continue
                    m = KW.search(txt)
                    if not m: continue
                    kws = sorted(set(KW.findall(txt)))
                    if isinstance(sender_id, int):
                        sender = n2i.get(sender_id, str(sender_id))
                    else:
                        sender = n2i.get(sender_id, sender_id)
                    sdisp = cmap.get(sender, (sender, sender))[0] if isinstance(sender, str) else str(sender)
                    talker_hits[f'{disp}|{talker}'] += 1
                    stats[dbname] += 1
                    fh.write(json.dumps({
                        'ts': ct, 'db': dbname, 'talker': talker, 'talker_display': disp,
                        'sender': sdisp, 'type': ltype, 'kw': kws,
                        'text': txt[:4000]
                    }, ensure_ascii=False) + '\n')
        con.close()
    fh.close()
    print('rows scanned:', rows_total, flush=True)
    print('hits per db:', dict(stats), flush=True)
    print('TOP talkers by hits:', flush=True)
    for k, v in talker_hits.most_common(40):
        print(f'  {v:6d}  {k}', flush=True)

if __name__ == '__main__':
    main()
