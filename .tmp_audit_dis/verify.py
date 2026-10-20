# -*- coding: utf-8 -*-
"""Static audit: compile rebuilt auth.py (no execution of it) and diff per-function
instruction streams against dump/core_auth.dis.txt (CPython 3.13 dis-style text)."""
import dis, re, sys, io, types

PY  = r"E:/AI-Station/逆向工程/IMA下载助手/src_rebuilt/core/auth.py"
DUMP= r"E:/AI-Station/逆向工程/IMA下载助手/dump/core_auth.dis.txt"

src = open(PY, encoding='utf-8').read()
top = compile(src, "core\auth.py", "exec")  # static only, never exec'd

# collect nested code objects by qualname
codes = {}
def walk(co):
    codes[co.co_qualname] = co
    for c in co.co_consts:
        if isinstance(c, types.CodeType):
            walk(c)
walk(top)

JUMPY = {"RESUME","CALL_KW","CONTAINS_OP","IS_OP","FOR_ITER","END_FOR","POP_JUMP_IF_TRUE",
"POP_JUMP_IF_FALSE","POP_JUMP_IF_NONE","POP_JUMP_IF_NOT_NONE","JUMP_FORWARD","JUMP_BACKWARD",
"JUMP_BACKWARD_NO_INTERRUPT","SEND","JUMP_IF_FALSE_OR_POP","JUMP_IF_TRUE_OR_POP",
"CHECK_EXC_MATCH","CHECK_EG_MATCH","LOAD_ASSERTION_ERROR","BINARY_SLICE"}
NAMEY = {"LOAD_GLOBAL","LOAD_NAME","LOAD_ATTR","LOAD_FAST","STORE_FAST","LOAD_DEREF","STORE_DEREF",
"LOAD_FROM_DICT_OR_GLOBALS","DELETE_FAST","MAKE_CELL","SET_FUNCTION_ATTRIBUTE",
"LOAD_FAST_LOAD_FAST","STORE_FAST_STORE_FAST","LOAD_FAST_AND_CLEAR","STORE_FAST_LOAD_FAST",
"IMPORT_NAME","IMPORT_FROM","LOAD_SUPER_ATTR","LOAD_LOCALS"}

def dis_tokens(co):
    out=[]
    for i in dis.get_instructions(co):
        op=i.opname; ar=i.argrepr or ""
        if op in JUMPY: out.append(op)                      # layout/argrepr variance -> name only
        elif op in NAMEY: out.append(op+" "+ar)
        else: out.append((op+" "+ar).strip())
    return out

line_re = re.compile(r"^\s*(?:(\d+|--)\s+)?(?:L\d+\s*:\s*)?([A-Z][A-Z_0-9]*)\s*(?:(-?\d+)\s*)?(?:\((.*)\))?\s*$")

def parse_dump():
    funcs={}; cur=None
    for raw in open(DUMP, encoding='utf-8'):
        s=raw.rstrip("\n")
        st=s.strip()
        if not st: continue
        if st.startswith("=====") or st.startswith("ExceptionTable") or re.match(r"^L\d+ to ", st): continue
        m=re.match(r"^#+\s+CODE\s+(.*?)\s+args=", st)
        if m: cur=m.group(1); funcs[cur]=[]; continue
        if cur is None: continue
        # strip line-number col and label col already handled in regex
        mm=line_re.match(s)
        if not mm: continue
        _,op,num,arg = mm.groups()
        if op in ("PUSH_NULL","NOP","PRECALL","CACHE"): pass
        if op in JUMPY:
            tok=op
        elif op in NAMEY and arg is not None:
            tok=op+" "+arg
        else:
            tok=(op+" "+(arg or "")).strip() if arg is not None else op
        funcs[cur].append(tok)
    return funcs

dump = parse_dump()
bad=[]
report=[]
for qname, dtoks in dump.items():
    co = codes.get(qname)
    if co is None:
        bad.append((qname,"MISSING in rebuilt")); continue
    stoks = dis_tokens(co)
    # compare as token streams
    if stoks == dtoks:
        report.append((qname, "MATCH", len(stoks)))
        continue
    # find first divergence
    n=min(len(stoks),len(dtoks)); i=0
    while i<n and stoks[i]==dtoks[i]: i+=1
    lo=max(0,i-3); hi=i+6
    bad.append((qname, f"DIFF at tok {i}: src={stoks[lo:hi]} dump={dtoks[lo:hi]} (lens {len(stoks)} vs {len(dtoks)})"))
    report.append((qname, "DIFF", len(stoks)))

ok=0
for q,r,_l in report:
    if r=="MATCH": ok+=1
print(f"functions compared: {len(report)}, exact stream match: {ok}")
for q,msg,_ in report:
    if msg!="MATCH": print("  [DIFF]", q)
for q,msg in bad:
    if "DIFF" in msg or "MISSING" in msg:
        print("###", q, "->", msg)
