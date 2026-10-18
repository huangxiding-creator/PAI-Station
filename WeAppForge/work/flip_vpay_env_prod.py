# -*- coding: utf-8 -*-
"""flip_vpay_env_prod.py — 虚拟支付 env=1(沙箱) → env=0(现网) 翻转器（预备就位，暂不执行）。

改动面（三处同源零漂移）：
  1. 权威源 data/secrets/virtual_pay.secret 的 env 行（明文文件）
  2. 部署快照 data/state/qianwen_tcb_envparams.json 的 SECRET_FILES_B64 内
     virtual_pay.secret（双层 base64：包 JSON → 文件值再 base64）
  3. 执行链：node data/state/mn_client/update_envparams.js（manager-node 通道）

安全带：
  - 翻转前快照两文件字节级备份（.bak_env1）
  - 翻转后 roundtrip 断言：除 env 行外逐字节一致 + env=0
  - --check 只读模式：打印当前 env 不改任何文件
"""
import base64
import hashlib
import io
import json
import shutil
import sys

CANON = 'E:/AI-Station/data/secrets/virtual_pay.secret'
ENVP = 'E:/AI-Station/data/state/qianwen_tcb_envparams.json'


def flip(dry_run: bool) -> None:
    canon = io.open(CANON, encoding='utf-8').read()
    envp = json.loads(io.open(ENVP, encoding='utf-8').read())
    files = json.loads(base64.b64decode(envp['SECRET_FILES_B64']))
    packed = files.get('virtual_pay.secret')
    if packed is None:
        raise SystemExit('virtual_pay.secret missing in pack')
    inner = base64.b64decode(packed).decode('utf-8')

    def cur_env(text):
        for line in text.splitlines():
            if line.startswith('env='):
                return line.strip()
        return '(no env line)'

    print('canon  :', cur_env(canon), ' sha8=' + hashlib.sha256(canon.encode()).hexdigest()[:8])
    print('deploy :', cur_env(inner), ' sha8=' + hashlib.sha256(inner.encode()).hexdigest()[:8])
    if cur_env(canon) != cur_env(inner):
        raise SystemExit('canon/deploy drift — stop and reconcile first')

    if dry_run:
        print('CHECK-ONLY: no changes made')
        return

    if cur_env(canon) == 'env=0':
        print('already env=0, nothing to do')
        return

    def to_env0(text):
        return '\n'.join(
            ('env=0' if line.startswith('env=') else line)
            for line in text.splitlines()) + ('\n' if text.endswith('\n') else '')

    new_canon = to_env0(canon)
    new_inner = to_env0(inner)

    # roundtrip 断言：只动 env 行
    assert cur_env(new_canon) == 'env=0' and cur_env(new_inner) == 'env=0'
    old_pairs = [(l if not l.startswith('env=') else 'env=') for l in canon.splitlines()]
    new_pairs = [(l if not l.startswith('env=') else 'env=') for l in new_canon.splitlines()]
    assert old_pairs == new_pairs, 'non-env line drifted in canon'
    old_pairs = [(l if not l.startswith('env=') else 'env=') for l in inner.splitlines()]
    new_pairs = [(l if not l.startswith('env=') else 'env=') for l in new_inner.splitlines()]
    assert old_pairs == new_pairs, 'non-env line drifted in deploy pack'

    shutil.copyfile(CANON, CANON + '.bak_env1')
    shutil.copyfile(ENVP, ENVP + '.bak_env1')
    io.open(CANON, 'w', encoding='utf-8', newline='').write(new_canon)
    files['virtual_pay.secret'] = base64.b64encode(new_inner.encode()).decode()
    envp['SECRET_FILES_B64'] = base64.b64encode(
        json.dumps(files, ensure_ascii=False).encode()).decode()
    io.open(ENVP, 'w', encoding='utf-8', newline='').write(
        json.dumps(envp, ensure_ascii=False, indent=2))
    print('FLIPPED: env=1 -> env=0 in canon + deploy pack (backups .bak_env1)')
    print('NEXT: node data/state/mn_client/update_envparams.js')


if __name__ == '__main__':
    flip(dry_run='--check' in sys.argv)
