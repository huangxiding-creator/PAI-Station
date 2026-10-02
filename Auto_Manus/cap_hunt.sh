#!/bin/bash
# 选图循环 v2: 刷新验证码直到出现可解题(干净图), 最多 N 轮
# 判据: ddddocr det>=3框 且 分类命中>=2/4 目标字
cd /e/AI-Station/Auto_Manus
BB=C:/Users/91216/AppData/Roaming/npm/node_modules/bb-browser/dist/cli.js
export BB_BROWSER_CDP_URL=http://localhost:19826
PY=C:/Users/91216/AppData/Local/Programs/Python/Python311/python.exe
ROUNDS=${1:-6}

save_img () {  # 两步: meta + 原始src (已验证通路)
  node $BB eval "(function(){const img=document.querySelector('img.back-img');let h=0;for(let j=0;j<img.src.length;j+=997)h=(h*31+img.src.charCodeAt(j))>>>0;return JSON.stringify({h:h,len:img.src.length,t:(document.body.innerText.match(/请依次点击【[^】]*】/)||[''])[0]})})()" --json 2>/dev/null | grep -o '"result": ".*' | head -1 > cap_now.meta.raw
  node $BB eval "document.querySelector('img.back-img').src" --json 2>/dev/null | node -e "
const chunks=[]; process.stdin.on('data',d=>chunks.push(d)); process.stdin.on('end',()=>{
  const s=chunks.join(''); const m=s.match(/\"result\": ?\"([^\"]*)\"/);
  if(!m){process.exit(1)}
  const src=JSON.parse('\"'+m[1]+'\"');
  require('fs').writeFileSync('cap_now.b64', src.split(',',2)[1]);
});" || return 1
  [ -s cap_now.b64 ] || return 1
  return 0
}

for i in $(seq 1 $ROUNDS); do
  node $BB eval "document.querySelector('.verify-refresh').click(); 'ok'" --json >/dev/null 2>&1
  sleep 3
  save_img || { echo "round $i: no img"; continue; }
  RES=$(PYTHONIOENCODING=utf-8 $PY -c "
from PIL import Image
import io, base64, json, re
from pathlib import Path
raw = Path('cap_now.b64').read_text().strip()
img = Image.open(io.BytesIO(base64.b64decode(raw))).convert('RGB')
img.save('cap_now.jpg')
mraw = Path('cap_now.meta.raw').read_text(encoding='utf-8', errors='replace')
mt = re.search(r'\\\\\"t\\\\\":\\\\\"([^\\\\]*)', mraw) or re.search(r'\"t\":\"([^\"]*)', mraw)
tstr = mt.group(1) if mt else ''
targets = [c for c in re.sub(r'[^,【】]*【|】.*','',tstr).split(',') if c.strip()]
import ddddocr
det = ddddocr.DdddOcr(det=True, show_ad=False)
cls = ddddocr.DdddOcr(show_ad=False)
boxes = det.detection(Path('cap_now.jpg').read_bytes())
hits = 0; found = []
for x1,y1,x2,y2 in boxes:
    c = img.crop((max(0,x1-2),max(0,y1-2),min(img.width,x2+2),min(img.height,y2+2)))
    c = c.resize((c.width*4,c.height*4), Image.LANCZOS)
    b=io.BytesIO(); c.save(b,format='PNG')
    r = cls.classification(b.getvalue())
    isHit = any(r in t or t in r for t in targets)
    hits += 1 if isHit else 0
    found.append({'ch':r,'cx':(x1+x2)//2,'cy':(y1+y2)//2,'hit':isHit})
print(json.dumps({'n':len(boxes),'hits':hits,'targets':''.join(targets),'found':found}, ensure_ascii=False))
" 2>/dev/null)
  echo "round $i: $RES"
  echo "$RES" | node -e "const c=[];process.stdin.on('data',d=>c.push(d));process.stdin.on('end',()=>{try{const o=JSON.parse(c.join(''));process.exit(o.hits>=2&&o.n>=3?0:1)}catch(e){process.exit(1)}})" \
    && { echo "TAKE_THIS_IMAGE"; break; }
done
echo "HUNT_DONE"
