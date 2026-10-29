# -*- coding: utf-8 -*-
# WeChat 4.x db decrypt + keyword extractor (SQLCipher v4 params per chatlog)
import sys, os, re, json, hmac, hashlib, struct, sqlite3, time
from Crypto.Cipher import AES
import zstandard as zstd

PAGE = 4096; SALT = 16; IV = 16; HSZ = 64; RESERVE = 80
DATA_END = PAGE - RESERVE + IV
HDR = b'SQLite format 3\x00'

def derive(key32, salt):
    enc = hashlib.pbkdf2_hmac('sha512', key32, salt, 256000, 32)
    mac_key = hashlib.pbkdf2_hmac('sha512', enc, bytes(b ^ 0x3a for b in salt), 2, 32)
    return enc, mac_key

def decrypt_db(src, dst, key32, log):
    salt = None; enc = mac = None
    t0 = time.time(); pages = 0; hmac_fail = 0
    with open(src, 'rb') as f, open(dst, 'wb') as o:
        first = f.read(PAGE)
        if first[:15] == HDR[:15]:
            log(f'  already plaintext: {src}'); return False
        salt = first[:SALT]; enc, mac_key = derive(key32, salt)
        # validate
        calc = hmac.new(mac_key, first[SALT:DATA_END] + struct.pack('<I', 1), hashlib.sha512).digest()
        if not hmac.compare_digest(calc, first[DATA_END:DATA_END+HSZ]):
            return False
        # page 0
        cipher = AES.new(enc, AES.MODE_CBC, first[PAGE-RESERVE:PAGE-RESERVE+IV])
        dec = cipher.decrypt(first[SALT:PAGE-RESERVE])
        o.write(HDR + dec + first[PAGE-RESERVE:PAGE]); pages = 1
        tail = f.read()
        for off in range(0, len(tail), PAGE):
            pb = tail[off:off+PAGE]
            if len(pb) < PAGE: pb = pb + b'\x00' * (PAGE - len(pb))
            if pb.count(0) == PAGE:
                o.write(pb); pages += 1; continue
            m = hmac.new(mac_key, pb[0:DATA_END] + struct.pack('<I', pages + 1), hashlib.sha512).digest()
            ok = hmac.compare_digest(m, pb[DATA_END:DATA_END+HSZ])
            if not ok: hmac_fail += 1
            iv = pb[PAGE-RESERVE:PAGE-RESERVE+IV]
            cipher = AES.new(enc, AES.MODE_CBC, iv)
            dec = cipher.decrypt(pb[0:PAGE-RESERVE])
            o.write(dec + pb[PAGE-RESERVE:PAGE]); pages += 1
    log(f'  {os.path.basename(src)}: {pages} pages, hmac_fail={hmac_fail}, {time.time()-t0:.1f}s')
    return True

ZMAGIC = b'\x28\xb5\x2f\xfd'
dctx = zstd.ZstdDecompressor()
def to_text(blob):
    if blob is None: return ''
    if isinstance(blob, str): return blob
    b = bytes(blob)
    if b.startswith(ZMAGIC):
        try: b = dctx.decompress(b)
        except Exception:
            try: b = dctx.stream_reader(__import__('io').BytesIO(b)).read()
            except Exception: return ''
    try: return b.decode('utf-8', 'replace')
    except Exception: return ''

def main():
    keyhex, src_root, out_dir = sys.argv[1], sys.argv[2], sys.argv[3]
    key32 = bytes.fromhex(keyhex)
    os.makedirs(out_dir, exist_ok=True)
    LOG = []
    log = lambda m: (LOG.append(m), print(m, flush=True))
    files = [
        ('contact/contact.db', 'contact.db'),
        ('session/session.db', 'session.db'),
        ('message/message_0.db', 'message_0.db'),
        ('message/message_1.db', 'message_1.db'),
        ('message/message_2.db', 'message_2.db'),
        ('message/biz_message_0.db', 'biz_message_0.db'),
    ]
    done = []
    for rel, name in files:
        s = os.path.join(src_root, rel); d = os.path.join(out_dir, name)
        if not os.path.exists(s): log(f'  skip missing {rel}'); continue
        try:
            ok = decrypt_db(s, d, key32, log)
            if ok: done.append(name)
        except Exception as e:
            log(f'  ERROR {rel}: {e!r}')
    # verify decryptability
    for name in done:
        try:
            con = sqlite3.connect(os.path.join(out_dir, name)); cur = con.cursor()
            n = cur.execute("SELECT count(*) FROM sqlite_master WHERE type='table'").fetchone()[0]
            log(f'  VERIFY {name}: {n} tables OK'); con.close()
        except Exception as e:
            log(f'  VERIFY-FAIL {name}: {e!r}')
    with open(os.path.join(out_dir, '_pipeline.log'), 'w', encoding='utf-8') as f:
        f.write('\n'.join(LOG))

if __name__ == '__main__':
    main()
