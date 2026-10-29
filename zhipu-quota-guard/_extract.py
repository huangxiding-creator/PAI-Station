import re,html,sys,io
sys.stdout=io.TextIOWrapper(sys.stdout.buffer,encoding='utf-8',errors='replace')
raw=open(sys.argv[1],encoding='utf-8',errors='ignore').read()
raw=re.sub(r'<script.*?</script>','',raw,flags=re.S)
raw=re.sub(r'<style.*?</style>','',raw,flags=re.S)
txt=re.sub(r'<[^>]+>',' ',raw)
txt=html.unescape(txt)
txt=re.sub(r'\s+',' ',txt)
seen=set()
for kw in sys.argv[2:]:
    for m in re.finditer(re.escape(kw),txt):
        s=max(0,m.start()-150); e=min(len(txt),m.end()+250)
        seg=txt[s:e].strip()
        key=seg[:80]
        if key in seen: continue
        seen.add(key)
        print('KW[%s] ...%s...'%(kw,seg)); print('---')
