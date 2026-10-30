# -*- coding: utf-8 -*-
# slim-v2 构建：HEAD 树 - {乐奇/corpus 整目录 + 二进制扩展名 + >20MB}，单批 update-index
import subprocess, os, json, sys

ROOT = r'E:\AI-Station'
env = dict(os.environ, GIT_INDEX_FILE=os.path.join(ROOT, '.git', 'slim-index'),
           GIT_CONFIG_PARAMETERS="'core.quotepath=false'")

def g(*args, input=None, check=True):
    r = subprocess.run(['git', *args], cwd=ROOT, env=env, input=input, capture_output=True)
    if check and r.returncode != 0:
        raise RuntimeError(f"{args}: {r.stderr.decode('utf-8','ignore')[:300]}")
    return r.stdout

BIN_EXT = {'.rar','.7z','.zip','.exe','.dll','.pak','.iso','.msi','.whl','.bin','.onnx',
           '.pt','.pth','.gguf','.mp4','.webm','.avi','.mkv'}
HEAVY_DIRS = ('乐奇AI眼镜/', 'corpus/')

out = g('ls-tree','-r','-l','-z','HEAD').decode('utf-8','surrogateescape')
drop = []
for entry in out.split('\0'):
    if not entry.strip(): continue
    meta, _, path = entry.partition('\t')
    parts = meta.split()
    if len(parts) < 4: continue
    try: size = int(parts[3])
    except: continue
    ext = os.path.splitext(path)[1].lower()
    if size > 20*1024*1024 or path.startswith(HEAVY_DIRS) or ext in BIN_EXT:
        drop.append(path)
print(f'剔除清单: {len(drop)} 个', flush=True)

g('read-tree', 'HEAD')
payload = ('\0'.join(drop) + '\0').encode('utf-8', 'surrogateescape')
g('update-index','--force-remove','-z','--stdin', input=payload)
tree = g('write-tree').decode()
print('slim-v2 tree:', tree, flush=True)

msg = ("chore(slim-unblock-v2): 主仓深度瘦身——整仓剔除 乐奇AI眼镜/(7.2G资产库)+corpus/(1.1G语料)"
       "+全仓二进制扩展名(rar/exe/dll/pak/视频等)+>20MB单件\n"
       "资产全部留盘+百度网盘AI-Station-archive归档; 代码/文档/生产状态全保留; "
       "旧史与远端锚82445d9e不动快进\n\n"
       "Co-Authored-By: Claude Code <noreply@anthropic.com>")
C = subprocess.run(['git','commit-tree', tree, '-p','82445d9e1600cb3ead1dd43ee78a5c6afb064112','-m', msg],
                   cwd=ROOT, env=env, capture_output=True, text=True).stdout.strip()
print('slim-v2 commit:', C, flush=True)
open(os.path.join(ROOT,'tools','_repo_backup_tmp','_slim_commit.txt'),'w').write(C)
json.dump(drop, open(os.path.join(ROOT,'tools','_repo_backup_tmp','_big_paths.json'),'w',
           encoding='utf-8', errors='surrogateescape'), ensure_ascii=False, indent=0)
print('DONE', flush=True)
