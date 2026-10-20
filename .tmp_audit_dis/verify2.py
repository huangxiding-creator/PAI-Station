# -*- coding: utf-8 -*-
"""Round 2: adds arity checks for CALL/CALL_KW/BUILD_*/etc, normalizes code-object
consts, drops __firstlineno__ (rebuilt file has different physical lines)."""
import dis, re, types

PY  = r"E:/AI-Station/逆向工程/IMA下载助手/src_rebuilt/core/auth.py"
DUMP= r"E:/AI-Station/逆向工程/IMA下载助手/dump/core_auth.dis.txt"

src = open(PY, encoding='utf-8').read()
top = compile(src, "core\auth.py", "exec")

codes={}
def walk(co):
    codes[co.co_qualname]=co
    for c in co.co_consts:
        if isinstance(c, types.CodeType): walk(c)
walk(top)

JUMPY={"RESUME","CONTAINS_OP","IS_OP","FOR_ITER","END_FOR","POP_JUMP_IF_TRUE","POP_JUMP_IF_FALSE",
"POP_JUMP_IF_NONE","POP_JUMP_IF_NOT_NONE","JUMP_FORWARD","JUMP_BACKWARD","JUMP_BACKWARD_NO_INTERRUPT",
"SEND","JUMP_IF_FALSE_OR_POP","JUMP_IF_TRUE_OR_POP","CHECK_EXC_MATCH","CHECK_EG_MATCH",
"LOAD_ASSERTION_ERROR","BINARY_SLICE"}
NAMEY={"LOAD_GLOBAL","LOAD_NAME","LOAD_ATTR","LOAD_FAST","STORE_FAST","LOAD_DEREF","STORE_DEREF",
"LOAD_FROM_DICT_OR_GLOBALS","DELETE_FAST","MAKE_CELL","SET_FUNCTION_ATTRIBUTE","LOAD_FAST_LOAD_FAST",
"STORE_FAST_STORE_FAST","LOAD_FAST_AND_CLEAR","STORE_FAST_LOAD_FAST","IMPORT_NAME","IMPORT_FROM",
"LOAD_SUPER_ATTR","LOAD_LOCALS"}
COUNTY={"CALL","CALL_KW","BUILD_TUPLE","BUILD_LIST","BUILD_MAP","BUILD_STRING","BUILD_CONST_KEY_MAP",
"BUILD_SET","UNPACK_SEQUENCE","LIST_APPEND","SET_ADD","MAP_ADD","SWAP","COPY","RERAISE",
"CALL_FUNCTION_EX","DICT_MERGE","DICT_UPDATE","LOAD_FAST_AND_CLEAR"}

def norm_const(r):
    m=re.match(r"<code object (\S+) at 0x[0-9A-Fa-f]+, file .*?, line \d+>", r)
    return f"<code {m.group(1)}>" if m else r

def dis_tokens(co):
    out=[]
    for i in dis.get_instructions(co):
        op=i.opname; ar=i.argrepr or ""
        if op in JUMPY: t=op
        elif op in COUNTY: t=f"{op}#{i.arg}"
        elif op in NAMEY: t=op+" "+ar
        else:
            t=(op+" "+ar).strip()
        if op=="LOAD_CONST": t="LOAD_CONST "+norm_const(ar)
        out.append(t)
    # drop __firstlineno__ const+store pairs
    res=[];i=0
    while i<len(out):
        if i+1<len(out) and out[i].startswith("LOAD_CONST ") and out[i+1]=="STORE_NAME __firstlineno__":
            i+=2; continue
        res.append(out[i]); i+=1
    return res

line_re=re.compile(r"^\s*(?:(\d+|--)\s+)?(?:L\d+\s*:\s*)?([A-Z][A-Z_0-9]*)\s*(?:(-?\d+)\s*)?(?:\((.*)\))?\s*$")
def parse_dump():
    funcs={};cur=None
    for raw in open(DUMP,encoding='utf-8'):
        st=raw.strip()
        if not st: continue
        if st.startswith("=====") or st.startswith("ExceptionTable") or re.match(r"^L\d+ to ",st): continue
        m=re.match(r"^#+\s+CODE\s+(.*?)\s+args=",st)
        if m: cur=m.group(1);funcs[cur]=[];continue
        if cur is None: continue
        mm=line_re.match(raw.rstrip("\n"))
        if not mm: continue
        _,op,num,arg=mm.groups()
        if op in JUMPY: t=op
        elif op in COUNTY: t=f"{op}#{num}"
        elif op in NAMEY and arg is not None: t=op+" "+arg
        else: t=(op+" "+(arg or "")).strip() if arg is not None else op
        if op=="LOAD_CONST" and arg is not None: t="LOAD_CONST "+norm_const(arg)
        funcs[cur].append(t)
    # drop firstlineno pairs
    for k in funcs:
        res=[];i=0;L=funcs[k]
        while i<len(L):
            if i+1<len(L) and L[i].startswith("LOAD_CONST ") and L[i+1]=="STORE_NAME __firstlineno__":
                i+=2;continue
            res.append(L[i]);i+=1
        funcs[k]=res
    return funcs

dump=parse_dump(); ok=0; fails=[]
for qn,dt in dump.items():
    co=codes.get(qn)
    if co is None: fails.append((qn,"MISSING")); continue
    st=dis_tokens(co)
    if st==dt: ok+=1; continue
    n=min(len(st),len(dt));i=0
    while i<n and st[i]==dt[i]: i+=1
    fails.append((qn,f"tok {i}: src={st[max(0,i-2):i+5]} | dump={dt[max(0,i-2):i+5]} (len {len(st)}/{len(dt)})"))
print(f"total {len(dump)}, exact {ok}")
for q,m in fails: print("###",q,"->",m)
