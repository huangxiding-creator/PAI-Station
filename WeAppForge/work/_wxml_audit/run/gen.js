/*v0.5vv_20200413_syb_scopedata*/window.__wcc_version__='v0.5vv_20200413_syb_scopedata';window.__wcc_version_info__={"customComponents":true,"fixZeroRpx":true,"propValueDeepCopy":false};
var $gwxc
var $gaic={}
$gwx=function(path,global){
if(typeof global === 'undefined') global={};if(typeof __WXML_GLOBAL__ === 'undefined') {__WXML_GLOBAL__={};
}__WXML_GLOBAL__.modules = __WXML_GLOBAL__.modules || {};
function _(a,b){if(typeof(b)!='undefined')a.children.push(b);}
function _v(k){if(typeof(k)!='undefined')return {tag:'virtual','wxKey':k,children:[]};return {tag:'virtual',children:[]};}
function _n(tag){$gwxc++;if($gwxc>=16000){throw 'Dom limit exceeded, please check if there\'s any mistake you\'ve made.'};return {tag:'wx-'+tag,attr:{},children:[],n:[],raw:{},generics:{}}}
function _p(a,b){b&&a.properities.push(b);}
function _s(scope,env,key){return typeof(scope[key])!='undefined'?scope[key]:env[key]}
function _wp(m){console.warn("WXMLRT_$gwx:"+m)}
function _wl(tname,prefix){_wp(prefix+':-1:-1:-1: Template `' + tname + '` is being called recursively, will be stop.')}
$gwn=console.warn;
$gwl=console.log;
function $gwh()
{
function x()
{
}
x.prototype = 
{
hn: function( obj, all )
{
if( typeof(obj) == 'object' )
{
var cnt=0;
var any1=false,any2=false;
for(var x in obj)
{
any1=any1|x==='__value__';
any2=any2|x==='__wxspec__';
cnt++;
if(cnt>2)break;
}
return cnt == 2 && any1 && any2 && ( all || obj.__wxspec__ !== 'm' || this.hn(obj.__value__) === 'h' ) ? "h" : "n";
}
return "n";
},
nh: function( obj, special )
{
return { __value__: obj, __wxspec__: special ? special : true }
},
rv: function( obj )
{
return this.hn(obj,true)==='n'?obj:this.rv(obj.__value__);
},
hm: function( obj )
{
if( typeof(obj) == 'object' )
{
var cnt=0;
var any1=false,any2=false;
for(var x in obj)
{
any1=any1|x==='__value__';
any2=any2|x==='__wxspec__';
cnt++;
if(cnt>2)break;
}
return cnt == 2 && any1 && any2 && (obj.__wxspec__ === 'm' || this.hm(obj.__value__) );
}
return false;
}
}
return new x;
}
wh=$gwh();
function $gstack(s){
var tmp=s.split('\n '+' '+' '+' ');
for(var i=0;i<tmp.length;++i){
if(0==i) continue;
if(")"===tmp[i][tmp[i].length-1])
tmp[i]=tmp[i].replace(/\s\(.*\)$/,"");
else
tmp[i]="at anonymous function";
}
return tmp.join('\n '+' '+' '+' ');
}
function $gwrt( should_pass_type_info )
{
function ArithmeticEv( ops, e, s, g, o )
{
var _f = false;
var rop = ops[0][1];
var _a,_b,_c,_d, _aa, _bb;
switch( rop )
{
case '?:':
_a = rev( ops[1], e, s, g, o, _f );
_c = should_pass_type_info && ( wh.hn(_a) === 'h' );
_d = wh.rv( _a ) ? rev( ops[2], e, s, g, o, _f ) : rev( ops[3], e, s, g, o, _f );
_d = _c && wh.hn( _d ) === 'n' ? wh.nh( _d, 'c' ) : _d;
return _d;
break;
case '&&':
_a = rev( ops[1], e, s, g, o, _f );
_c = should_pass_type_info && ( wh.hn(_a) === 'h' );
_d = wh.rv( _a ) ? rev( ops[2], e, s, g, o, _f ) : wh.rv( _a );
_d = _c && wh.hn( _d ) === 'n' ? wh.nh( _d, 'c' ) : _d;
return _d;
break;
case '||':
_a = rev( ops[1], e, s, g, o, _f );
_c = should_pass_type_info && ( wh.hn(_a) === 'h' );
_d = wh.rv( _a ) ? wh.rv(_a) : rev( ops[2], e, s, g, o, _f );
_d = _c && wh.hn( _d ) === 'n' ? wh.nh( _d, 'c' ) : _d;
return _d;
break;
case '+':
case '*':
case '/':
case '%':
case '|':
case '^':
case '&':
case '===':
case '==':
case '!=':
case '!==':
case '>=':
case '<=':
case '>':
case '<':
case '<<':
case '>>':
_a = rev( ops[1], e, s, g, o, _f );
_b = rev( ops[2], e, s, g, o, _f );
_c = should_pass_type_info && (wh.hn( _a ) === 'h' || wh.hn( _b ) === 'h');
switch( rop )
{
case '+':
_d = wh.rv( _a ) + wh.rv( _b );
break;
case '*':
_d = wh.rv( _a ) * wh.rv( _b );
break;
case '/':
_d = wh.rv( _a ) / wh.rv( _b );
break;
case '%':
_d = wh.rv( _a ) % wh.rv( _b );
break;
case '|':
_d = wh.rv( _a ) | wh.rv( _b );
break;
case '^':
_d = wh.rv( _a ) ^ wh.rv( _b );
break;
case '&':
_d = wh.rv( _a ) & wh.rv( _b );
break;
case '===':
_d = wh.rv( _a ) === wh.rv( _b );
break;
case '==':
_d = wh.rv( _a ) == wh.rv( _b );
break;
case '!=':
_d = wh.rv( _a ) != wh.rv( _b );
break;
case '!==':
_d = wh.rv( _a ) !== wh.rv( _b );
break;
case '>=':
_d = wh.rv( _a ) >= wh.rv( _b );
break;
case '<=':
_d = wh.rv( _a ) <= wh.rv( _b );
break;
case '>':
_d = wh.rv( _a ) > wh.rv( _b );
break;
case '<':
_d = wh.rv( _a ) < wh.rv( _b );
break;
case '<<':
_d = wh.rv( _a ) << wh.rv( _b );
break;
case '>>':
_d = wh.rv( _a ) >> wh.rv( _b );
break;
default:
break;
}
return _c ? wh.nh( _d, "c" ) : _d;
break;
case '-':
_a = ops.length === 3 ? rev( ops[1], e, s, g, o, _f ) : 0;
_b = ops.length === 3 ? rev( ops[2], e, s, g, o, _f ) : rev( ops[1], e, s, g, o, _f );
_c = should_pass_type_info && (wh.hn( _a ) === 'h' || wh.hn( _b ) === 'h');
_d = _c ? wh.rv( _a ) - wh.rv( _b ) : _a - _b;
return _c ? wh.nh( _d, "c" ) : _d;
break;
case '!':
_a = rev( ops[1], e, s, g, o, _f );
_c = should_pass_type_info && (wh.hn( _a ) == 'h');
_d = !wh.rv(_a);
return _c ? wh.nh( _d, "c" ) : _d;
case '~':
_a = rev( ops[1], e, s, g, o, _f );
_c = should_pass_type_info && (wh.hn( _a ) == 'h');
_d = ~wh.rv(_a);
return _c ? wh.nh( _d, "c" ) : _d;
default:
$gwn('unrecognized op' + rop );
}
}
function rev( ops, e, s, g, o, newap )
{
var op = ops[0];
var _f = false;
if ( typeof newap !== "undefined" ) o.ap = newap;
if( typeof(op)==='object' )
{
var vop=op[0];
var _a, _aa, _b, _bb, _c, _d, _s, _e, _ta, _tb, _td;
switch(vop)
{
case 2:
return ArithmeticEv(ops,e,s,g,o);
break;
case 4: 
return rev( ops[1], e, s, g, o, _f );
break;
case 5: 
switch( ops.length )
{
case 2: 
_a = rev( ops[1],e,s,g,o,_f );
return should_pass_type_info?[_a]:[wh.rv(_a)];
return [_a];
break;
case 1: 
return [];
break;
default:
_a = rev( ops[1],e,s,g,o,_f );
_b = rev( ops[2],e,s,g,o,_f );
_a.push( 
should_pass_type_info ?
_b :
wh.rv( _b )
);
return _a;
break;
}
break;
case 6:
_a = rev(ops[1],e,s,g,o);
var ap = o.ap;
_ta = wh.hn(_a)==='h';
_aa = _ta ? wh.rv(_a) : _a;
o.is_affected |= _ta;
if( should_pass_type_info )
{
if( _aa===null || typeof(_aa) === 'undefined' )
{
return _ta ? wh.nh(undefined, 'e') : undefined;
}
_b = rev(ops[2],e,s,g,o,_f);
_tb = wh.hn(_b) === 'h';
_bb = _tb ? wh.rv(_b) : _b;
o.ap = ap;
o.is_affected |= _tb;
if( _bb===null || typeof(_bb) === 'undefined' || 
_bb === "__proto__" || _bb === "prototype" || _bb === "caller" ) 
{
return (_ta || _tb) ? wh.nh(undefined, 'e') : undefined;
}
_d = _aa[_bb];
if ( typeof _d === 'function' && !ap ) _d = undefined;
_td = wh.hn(_d)==='h';
o.is_affected |= _td;
return (_ta || _tb) ? (_td ? _d : wh.nh(_d, 'e')) : _d;
}
else
{
if( _aa===null || typeof(_aa) === 'undefined' )
{
return undefined;
}
_b = rev(ops[2],e,s,g,o,_f);
_tb = wh.hn(_b) === 'h';
_bb = _tb ? wh.rv(_b) : _b;
o.ap = ap;
o.is_affected |= _tb;
if( _bb===null || typeof(_bb) === 'undefined' || 
_bb === "__proto__" || _bb === "prototype" || _bb === "caller" ) 
{
return undefined;
}
_d = _aa[_bb];
if ( typeof _d === 'function' && !ap ) _d = undefined;
_td = wh.hn(_d)==='h';
o.is_affected |= _td;
return _td ? wh.rv(_d) : _d;
}
case 7: 
switch(ops[1][0])
{
case 11:
o.is_affected |= wh.hn(g)==='h';
return g;
case 3:
_s = wh.rv( s );
_e = wh.rv( e );
_b = ops[1][1];
if (g && g.f && g.f.hasOwnProperty(_b) )
{
_a = g.f;
o.ap = true;
}
else
{
_a = _s && _s.hasOwnProperty(_b) ? 
s : (_e && _e.hasOwnProperty(_b) ? e : undefined );
}
if( should_pass_type_info )
{
if( _a )
{
_ta = wh.hn(_a) === 'h';
_aa = _ta ? wh.rv( _a ) : _a;
_d = _aa[_b];
_td = wh.hn(_d) === 'h';
o.is_affected |= _ta || _td;
_d = _ta && !_td ? wh.nh(_d,'e') : _d;
return _d;
}
}
else
{
if( _a )
{
_ta = wh.hn(_a) === 'h';
_aa = _ta ? wh.rv( _a ) : _a;
_d = _aa[_b];
_td = wh.hn(_d) === 'h';
o.is_affected |= _ta || _td;
return wh.rv(_d);
}
}
return undefined;
}
break;
case 8: 
_a = {};
_a[ops[1]] = rev(ops[2],e,s,g,o,_f);
return _a;
break;
case 9: 
_a = rev(ops[1],e,s,g,o,_f);
_b = rev(ops[2],e,s,g,o,_f);
function merge( _a, _b, _ow )
{
var ka, _bbk;
_ta = wh.hn(_a)==='h';
_tb = wh.hn(_b)==='h';
_aa = wh.rv(_a);
_bb = wh.rv(_b);
for(var k in _bb)
{
if ( _ow || !_aa.hasOwnProperty(k) )
{
_aa[k] = should_pass_type_info ? (_tb ? wh.nh(_bb[k],'e') : _bb[k]) : wh.rv(_bb[k]);
}
}
return _a;
}
var _c = _a
var _ow = true
if ( typeof(ops[1][0]) === "object" && ops[1][0][0] === 10 ) {
_a = _b
_b = _c
_ow = false
}
if ( typeof(ops[1][0]) === "object" && ops[1][0][0] === 10 ) {
var _r = {}
return merge( merge( _r, _a, _ow ), _b, _ow );
}
else
return merge( _a, _b, _ow );
break;
case 10:
_a = rev(ops[1],e,s,g,o,_f);
_a = should_pass_type_info ? _a : wh.rv( _a );
return _a ;
break;
case 12:
var _r;
_a = rev(ops[1],e,s,g,o);
if ( !o.ap )
{
return should_pass_type_info && wh.hn(_a)==='h' ? wh.nh( _r, 'f' ) : _r;
}
var ap = o.ap;
_b = rev(ops[2],e,s,g,o,_f);
o.ap = ap;
_ta = wh.hn(_a)==='h';
_tb = _ca(_b);
_aa = wh.rv(_a);	
_bb = wh.rv(_b); snap_bb=$gdc(_bb,"nv_");
try{
_r = typeof _aa === "function" ? $gdc(_aa.apply(null, snap_bb)) : undefined;
} catch (e){
e.message = e.message.replace(/nv_/g,"");
e.stack = e.stack.substring(0,e.stack.indexOf("\n", e.stack.lastIndexOf("at nv_")));
e.stack = e.stack.replace(/\snv_/g," "); 
e.stack = $gstack(e.stack);	
if(g.debugInfo)
{
e.stack += "\n "+" "+" "+" at "+g.debugInfo[0]+":"+g.debugInfo[1]+":"+g.debugInfo[2];
console.error(e);
}
_r = undefined;
}
return should_pass_type_info && (_tb || _ta) ? wh.nh( _r, 'f' ) : _r;
}
}
else
{
if( op === 3 || op === 1) return ops[1];
else if( op === 11 ) 
{
var _a='';
for( var i = 1 ; i < ops.length ; i++ )
{
var xp = wh.rv(rev(ops[i],e,s,g,o,_f));
_a += typeof(xp) === 'undefined' ? '' : xp;
}
return _a;
}
}
}
function wrapper( ops, e, s, g, o, newap )
{
if( ops[0] == '11182016' )
{
g.debugInfo = ops[2];
return rev( ops[1], e, s, g, o, newap );
}
else
{
g.debugInfo = null;
return rev( ops, e, s, g, o, newap );
}
}
return wrapper;
}
gra=$gwrt(true); 
grb=$gwrt(false); 
function TestTest( expr, ops, e,s,g, expect_a, expect_b, expect_affected )
{
{
var o = {is_affected:false};
var a = gra( ops, e,s,g, o );
if( JSON.stringify(a) != JSON.stringify( expect_a )
|| o.is_affected != expect_affected )
{
console.warn( "A. " + expr + " get result " + JSON.stringify(a) + ", " + o.is_affected + ", but " + JSON.stringify( expect_a ) + ", " + expect_affected + " is expected" );
}
}
{
var o = {is_affected:false};
var a = grb( ops, e,s,g, o );
if( JSON.stringify(a) != JSON.stringify( expect_b )
|| o.is_affected != expect_affected )
{
console.warn( "B. " + expr + " get result " + JSON.stringify(a) + ", " + o.is_affected + ", but " + JSON.stringify( expect_b ) + ", " + expect_affected + " is expected" );
}
}
}

function wfor( to_iter, func, env, _s, global, father, itemname, indexname, keyname )
{
var _n = wh.hn( to_iter ) === 'n'; 
var scope = wh.rv( _s ); 
var has_old_item = scope.hasOwnProperty(itemname);
var has_old_index = scope.hasOwnProperty(indexname);
var old_item = scope[itemname];
var old_index = scope[indexname];
var full = Object.prototype.toString.call(wh.rv(to_iter));
var type = full[8]; 
if( type === 'N' && full[10] === 'l' ) type = 'X'; 
var _y;
if( _n )
{
if( type === 'A' ) 
{
var r_iter_item;
for( var i = 0 ; i < to_iter.length ; i++ )
{
scope[itemname] = to_iter[i];
scope[indexname] = _n ? i : wh.nh(i, 'h');
r_iter_item = wh.rv(to_iter[i]);
var key = keyname && r_iter_item ? (keyname==="*this" ? r_iter_item : wh.rv(r_iter_item[keyname])) : undefined;
_y = _v(key);
_(father,_y);
func( env, scope, _y, global );
}
}
else if( type === 'O' ) 
{
var i = 0;
var r_iter_item;
for( var k in to_iter )
{
scope[itemname] = to_iter[k];
scope[indexname] = _n ? k : wh.nh(k, 'h');
r_iter_item = wh.rv(to_iter[k]);
var key = keyname && r_iter_item ? (keyname==="*this" ? r_iter_item : wh.rv(r_iter_item[keyname])) : undefined;
_y = _v(key);
_(father,_y);
func( env,scope,_y,global );
i++;
}
}
else if( type === 'S' ) 
{
for( var i = 0 ; i < to_iter.length ; i++ )
{
scope[itemname] = to_iter[i];
scope[indexname] = _n ? i : wh.nh(i, 'h');
_y = _v( to_iter[i] + i );
_(father,_y);
func( env,scope,_y,global );
}
}
else if( type === 'N' ) 
{
for( var i = 0 ; i < to_iter ; i++ )
{
scope[itemname] = i;
scope[indexname] = _n ? i : wh.nh(i, 'h');
_y = _v( i );
_(father,_y);
func(env,scope,_y,global);
}
}
else
{
}
}
else
{
var r_to_iter = wh.rv(to_iter);
var r_iter_item, iter_item;
if( type === 'A' ) 
{
for( var i = 0 ; i < r_to_iter.length ; i++ )
{
iter_item = r_to_iter[i];
iter_item = wh.hn(iter_item)==='n' ? wh.nh(iter_item,'h') : iter_item;
r_iter_item = wh.rv( iter_item );
scope[itemname] = iter_item
scope[indexname] = _n ? i : wh.nh(i, 'h');
var key = keyname && r_iter_item ? (keyname==="*this" ? r_iter_item : wh.rv(r_iter_item[keyname])) : undefined;
_y = _v(key);
_(father,_y);
func( env, scope, _y, global );
}
}
else if( type === 'O' ) 
{
var i=0;
for( var k in r_to_iter )
{
iter_item = r_to_iter[k];
iter_item = wh.hn(iter_item)==='n'? wh.nh(iter_item,'h') : iter_item;
r_iter_item = wh.rv( iter_item );
scope[itemname] = iter_item;
scope[indexname] = _n ? k : wh.nh(k, 'h');
var key = keyname && r_iter_item ? (keyname==="*this" ? r_iter_item : wh.rv(r_iter_item[keyname])) : undefined;
_y=_v(key);
_(father,_y);
func( env, scope, _y, global );
i++
}
}
else if( type === 'S' ) 
{
for( var i = 0 ; i < r_to_iter.length ; i++ )
{
iter_item = wh.nh(r_to_iter[i],'h');
scope[itemname] = iter_item;
scope[indexname] = _n ? i : wh.nh(i, 'h');
_y = _v( to_iter[i] + i );
_(father,_y);
func( env, scope, _y, global );
}
}
else if( type === 'N' ) 
{
for( var i = 0 ; i < r_to_iter ; i++ )
{
iter_item = wh.nh(i,'h');
scope[itemname] = iter_item;
scope[indexname]= _n ? i : wh.nh(i,'h');
_y = _v( i );
_(father,_y);
func(env,scope,_y,global);
}
}
else
{
}
}
if(has_old_item)
{
scope[itemname]=old_item;
}
else
{
delete scope[itemname];
}
if(has_old_index)
{
scope[indexname]=old_index;
}
else
{
delete scope[indexname];
}
}

function _ca(o)
{ 
if ( wh.hn(o) == 'h' ) return true;
if ( typeof o !== "object" ) return false;
for(var i in o){ 
if ( o.hasOwnProperty(i) ){
if (_ca(o[i])) return true;
}
}
return false;
}
function _da( node, attrname, opindex, raw, o )
{
var isaffected = false;
var value = $gdc( raw, "", 2 );
if ( o.ap && value && value.constructor===Function ) 
{
attrname = "$wxs:" + attrname; 
node.attr["$gdc"] = $gdc;
}
if ( o.is_affected || _ca(raw) ) 
{
node.n.push( attrname );
node.raw[attrname] = raw;
}
node.attr[attrname] = value;
}
function _r( node, attrname, opindex, env, scope, global ) 
{
global.opindex=opindex;
var o = {}, _env;
var a = grb( z[opindex], env, scope, global, o );
_da( node, attrname, opindex, a, o );
}
function _rz( z, node, attrname, opindex, env, scope, global ) 
{
global.opindex=opindex;
var o = {}, _env;
var a = grb( z[opindex], env, scope, global, o );
_da( node, attrname, opindex, a, o );
}
function _o( opindex, env, scope, global )
{
global.opindex=opindex;
var nothing = {};
var r = grb( z[opindex], env, scope, global, nothing );
return (r&&r.constructor===Function) ? undefined : r;
}
function _oz( z, opindex, env, scope, global )
{
global.opindex=opindex;
var nothing = {};
var r = grb( z[opindex], env, scope, global, nothing );
return (r&&r.constructor===Function) ? undefined : r;
}
function _1( opindex, env, scope, global, o )
{
var o = o || {};
global.opindex=opindex;
return gra( z[opindex], env, scope, global, o );
}
function _1z( z, opindex, env, scope, global, o )
{
var o = o || {};
global.opindex=opindex;
return gra( z[opindex], env, scope, global, o );
}
function _2( opindex, func, env, scope, global, father, itemname, indexname, keyname )
{
var o = {};
var to_iter = _1( opindex, env, scope, global );
wfor( to_iter, func, env, scope, global, father, itemname, indexname, keyname );
}
function _2z( z, opindex, func, env, scope, global, father, itemname, indexname, keyname )
{
var o = {};
var to_iter = _1z( z, opindex, env, scope, global );
wfor( to_iter, func, env, scope, global, father, itemname, indexname, keyname );
}


function _m(tag,attrs,generics,env,scope,global)
{
var tmp=_n(tag);
var base=0;
for(var i = 0 ; i < attrs.length ; i+=2 )
{
if(base+attrs[i+1]<0)
{
tmp.attr[attrs[i]]=true;
}
else
{
_r(tmp,attrs[i],base+attrs[i+1],env,scope,global);
if(base===0)base=attrs[i+1];
}
}
for(var i=0;i<generics.length;i+=2)
{
if(base+generics[i+1]<0)
{
tmp.generics[generics[i]]="";
}
else
{
var $t=grb(z[base+generics[i+1]],env,scope,global);
if ($t!="") $t="wx-"+$t;
tmp.generics[generics[i]]=$t;
if(base===0)base=generics[i+1];
}
}
return tmp;
}
function _mz(z,tag,attrs,generics,env,scope,global)
{
var tmp=_n(tag);
var base=0;
for(var i = 0 ; i < attrs.length ; i+=2 )
{
if(base+attrs[i+1]<0)
{
tmp.attr[attrs[i]]=true;
}
else
{
_rz(z, tmp,attrs[i],base+attrs[i+1],env,scope,global);
if(base===0)base=attrs[i+1];
}
}
for(var i=0;i<generics.length;i+=2)
{
if(base+generics[i+1]<0)
{
tmp.generics[generics[i]]="";
}
else
{
var $t=grb(z[base+generics[i+1]],env,scope,global);
if ($t!="") $t="wx-"+$t;
tmp.generics[generics[i]]=$t;
if(base===0)base=generics[i+1];
}
}
return tmp;
}

var nf_init=function(){
if(typeof __WXML_GLOBAL__==="undefined"||undefined===__WXML_GLOBAL__.wxs_nf_init){
nf_init_Object();nf_init_Function();nf_init_Array();nf_init_String();nf_init_Boolean();nf_init_Number();nf_init_Math();nf_init_Date();nf_init_RegExp();
}
if(typeof __WXML_GLOBAL__!=="undefined") __WXML_GLOBAL__.wxs_nf_init=true;
};
var nf_init_Object=function(){
Object.defineProperty(Object.prototype,"nv_constructor",{writable:true,value:"Object"})
Object.defineProperty(Object.prototype,"nv_toString",{writable:true,value:function(){return "[object Object]"}})
}
var nf_init_Function=function(){
Object.defineProperty(Function.prototype,"nv_constructor",{writable:true,value:"Function"})
Object.defineProperty(Function.prototype,"nv_length",{get:function(){return this.length;},set:function(){}});
Object.defineProperty(Function.prototype,"nv_toString",{writable:true,value:function(){return "[function Function]"}})
}
var nf_init_Array=function(){
Object.defineProperty(Array.prototype,"nv_toString",{writable:true,value:function(){return this.nv_join();}})
Object.defineProperty(Array.prototype,"nv_join",{writable:true,value:function(s){
s=undefined==s?',':s;
var r="";
for(var i=0;i<this.length;++i){
if(0!=i) r+=s;
if(null==this[i]||undefined==this[i]) r+='';	
else if(typeof this[i]=='function') r+=this[i].nv_toString();
else if(typeof this[i]=='object'&&this[i].nv_constructor==="Array") r+=this[i].nv_join();
else r+=this[i].toString();
}
return r;
}})
Object.defineProperty(Array.prototype,"nv_constructor",{writable:true,value:"Array"})
Object.defineProperty(Array.prototype,"nv_concat",{writable:true,value:Array.prototype.concat})
Object.defineProperty(Array.prototype,"nv_pop",{writable:true,value:Array.prototype.pop})
Object.defineProperty(Array.prototype,"nv_push",{writable:true,value:Array.prototype.push})
Object.defineProperty(Array.prototype,"nv_reverse",{writable:true,value:Array.prototype.reverse})
Object.defineProperty(Array.prototype,"nv_shift",{writable:true,value:Array.prototype.shift})
Object.defineProperty(Array.prototype,"nv_slice",{writable:true,value:Array.prototype.slice})
Object.defineProperty(Array.prototype,"nv_sort",{writable:true,value:Array.prototype.sort})
Object.defineProperty(Array.prototype,"nv_splice",{writable:true,value:Array.prototype.splice})
Object.defineProperty(Array.prototype,"nv_unshift",{writable:true,value:Array.prototype.unshift})
Object.defineProperty(Array.prototype,"nv_indexOf",{writable:true,value:Array.prototype.indexOf})
Object.defineProperty(Array.prototype,"nv_lastIndexOf",{writable:true,value:Array.prototype.lastIndexOf})
Object.defineProperty(Array.prototype,"nv_every",{writable:true,value:Array.prototype.every})
Object.defineProperty(Array.prototype,"nv_some",{writable:true,value:Array.prototype.some})
Object.defineProperty(Array.prototype,"nv_forEach",{writable:true,value:Array.prototype.forEach})
Object.defineProperty(Array.prototype,"nv_map",{writable:true,value:Array.prototype.map})
Object.defineProperty(Array.prototype,"nv_filter",{writable:true,value:Array.prototype.filter})
Object.defineProperty(Array.prototype,"nv_reduce",{writable:true,value:Array.prototype.reduce})
Object.defineProperty(Array.prototype,"nv_reduceRight",{writable:true,value:Array.prototype.reduceRight})
Object.defineProperty(Array.prototype,"nv_length",{get:function(){return this.length;},set:function(value){this.length=value;}});
}
var nf_init_String=function(){
Object.defineProperty(String.prototype,"nv_constructor",{writable:true,value:"String"})
Object.defineProperty(String.prototype,"nv_toString",{writable:true,value:String.prototype.toString})
Object.defineProperty(String.prototype,"nv_valueOf",{writable:true,value:String.prototype.valueOf})
Object.defineProperty(String.prototype,"nv_charAt",{writable:true,value:String.prototype.charAt})
Object.defineProperty(String.prototype,"nv_charCodeAt",{writable:true,value:String.prototype.charCodeAt})
Object.defineProperty(String.prototype,"nv_concat",{writable:true,value:String.prototype.concat})
Object.defineProperty(String.prototype,"nv_indexOf",{writable:true,value:String.prototype.indexOf})
Object.defineProperty(String.prototype,"nv_lastIndexOf",{writable:true,value:String.prototype.lastIndexOf})
Object.defineProperty(String.prototype,"nv_localeCompare",{writable:true,value:String.prototype.localeCompare})
Object.defineProperty(String.prototype,"nv_match",{writable:true,value:String.prototype.match})
Object.defineProperty(String.prototype,"nv_replace",{writable:true,value:String.prototype.replace})
Object.defineProperty(String.prototype,"nv_search",{writable:true,value:String.prototype.search})
Object.defineProperty(String.prototype,"nv_slice",{writable:true,value:String.prototype.slice})
Object.defineProperty(String.prototype,"nv_split",{writable:true,value:String.prototype.split})
Object.defineProperty(String.prototype,"nv_substring",{writable:true,value:String.prototype.substring})
Object.defineProperty(String.prototype,"nv_toLowerCase",{writable:true,value:String.prototype.toLowerCase})
Object.defineProperty(String.prototype,"nv_toLocaleLowerCase",{writable:true,value:String.prototype.toLocaleLowerCase})
Object.defineProperty(String.prototype,"nv_toUpperCase",{writable:true,value:String.prototype.toUpperCase})
Object.defineProperty(String.prototype,"nv_toLocaleUpperCase",{writable:true,value:String.prototype.toLocaleUpperCase})
Object.defineProperty(String.prototype,"nv_trim",{writable:true,value:String.prototype.trim})
Object.defineProperty(String.prototype,"nv_length",{get:function(){return this.length;},set:function(value){this.length=value;}});
}
var nf_init_Boolean=function(){
Object.defineProperty(Boolean.prototype,"nv_constructor",{writable:true,value:"Boolean"})
Object.defineProperty(Boolean.prototype,"nv_toString",{writable:true,value:Boolean.prototype.toString})
Object.defineProperty(Boolean.prototype,"nv_valueOf",{writable:true,value:Boolean.prototype.valueOf})
}
var nf_init_Number=function(){
Object.defineProperty(Number,"nv_MAX_VALUE",{writable:false,value:Number.MAX_VALUE})
Object.defineProperty(Number,"nv_MIN_VALUE",{writable:false,value:Number.MIN_VALUE})
Object.defineProperty(Number,"nv_NEGATIVE_INFINITY",{writable:false,value:Number.NEGATIVE_INFINITY})
Object.defineProperty(Number,"nv_POSITIVE_INFINITY",{writable:false,value:Number.POSITIVE_INFINITY})
Object.defineProperty(Number.prototype,"nv_constructor",{writable:true,value:"Number"})
Object.defineProperty(Number.prototype,"nv_toString",{writable:true,value:Number.prototype.toString})
Object.defineProperty(Number.prototype,"nv_toLocaleString",{writable:true,value:Number.prototype.toLocaleString})
Object.defineProperty(Number.prototype,"nv_valueOf",{writable:true,value:Number.prototype.valueOf})
Object.defineProperty(Number.prototype,"nv_toFixed",{writable:true,value:Number.prototype.toFixed})
Object.defineProperty(Number.prototype,"nv_toExponential",{writable:true,value:Number.prototype.toExponential})
Object.defineProperty(Number.prototype,"nv_toPrecision",{writable:true,value:Number.prototype.toPrecision})
}
var nf_init_Math=function(){
Object.defineProperty(Math,"nv_E",{writable:false,value:Math.E})
Object.defineProperty(Math,"nv_LN10",{writable:false,value:Math.LN10})
Object.defineProperty(Math,"nv_LN2",{writable:false,value:Math.LN2})
Object.defineProperty(Math,"nv_LOG2E",{writable:false,value:Math.LOG2E})
Object.defineProperty(Math,"nv_LOG10E",{writable:false,value:Math.LOG10E})
Object.defineProperty(Math,"nv_PI",{writable:false,value:Math.PI})
Object.defineProperty(Math,"nv_SQRT1_2",{writable:false,value:Math.SQRT1_2})
Object.defineProperty(Math,"nv_SQRT2",{writable:false,value:Math.SQRT2})
Object.defineProperty(Math,"nv_abs",{writable:false,value:Math.abs})
Object.defineProperty(Math,"nv_acos",{writable:false,value:Math.acos})
Object.defineProperty(Math,"nv_asin",{writable:false,value:Math.asin})
Object.defineProperty(Math,"nv_atan",{writable:false,value:Math.atan})
Object.defineProperty(Math,"nv_atan2",{writable:false,value:Math.atan2})
Object.defineProperty(Math,"nv_ceil",{writable:false,value:Math.ceil})
Object.defineProperty(Math,"nv_cos",{writable:false,value:Math.cos})
Object.defineProperty(Math,"nv_exp",{writable:false,value:Math.exp})
Object.defineProperty(Math,"nv_floor",{writable:false,value:Math.floor})
Object.defineProperty(Math,"nv_log",{writable:false,value:Math.log})
Object.defineProperty(Math,"nv_max",{writable:false,value:Math.max})
Object.defineProperty(Math,"nv_min",{writable:false,value:Math.min})
Object.defineProperty(Math,"nv_pow",{writable:false,value:Math.pow})
Object.defineProperty(Math,"nv_random",{writable:false,value:Math.random})
Object.defineProperty(Math,"nv_round",{writable:false,value:Math.round})
Object.defineProperty(Math,"nv_sin",{writable:false,value:Math.sin})
Object.defineProperty(Math,"nv_sqrt",{writable:false,value:Math.sqrt})
Object.defineProperty(Math,"nv_tan",{writable:false,value:Math.tan})
}
var nf_init_Date=function(){
Object.defineProperty(Date.prototype,"nv_constructor",{writable:true,value:"Date"})
Object.defineProperty(Date,"nv_parse",{writable:true,value:Date.parse})
Object.defineProperty(Date,"nv_UTC",{writable:true,value:Date.UTC})
Object.defineProperty(Date,"nv_now",{writable:true,value:Date.now})
Object.defineProperty(Date.prototype,"nv_toString",{writable:true,value:Date.prototype.toString})
Object.defineProperty(Date.prototype,"nv_toDateString",{writable:true,value:Date.prototype.toDateString})
Object.defineProperty(Date.prototype,"nv_toTimeString",{writable:true,value:Date.prototype.toTimeString})
Object.defineProperty(Date.prototype,"nv_toLocaleString",{writable:true,value:Date.prototype.toLocaleString})
Object.defineProperty(Date.prototype,"nv_toLocaleDateString",{writable:true,value:Date.prototype.toLocaleDateString})
Object.defineProperty(Date.prototype,"nv_toLocaleTimeString",{writable:true,value:Date.prototype.toLocaleTimeString})
Object.defineProperty(Date.prototype,"nv_valueOf",{writable:true,value:Date.prototype.valueOf})
Object.defineProperty(Date.prototype,"nv_getTime",{writable:true,value:Date.prototype.getTime})
Object.defineProperty(Date.prototype,"nv_getFullYear",{writable:true,value:Date.prototype.getFullYear})
Object.defineProperty(Date.prototype,"nv_getUTCFullYear",{writable:true,value:Date.prototype.getUTCFullYear})
Object.defineProperty(Date.prototype,"nv_getMonth",{writable:true,value:Date.prototype.getMonth})
Object.defineProperty(Date.prototype,"nv_getUTCMonth",{writable:true,value:Date.prototype.getUTCMonth})
Object.defineProperty(Date.prototype,"nv_getDate",{writable:true,value:Date.prototype.getDate})
Object.defineProperty(Date.prototype,"nv_getUTCDate",{writable:true,value:Date.prototype.getUTCDate})
Object.defineProperty(Date.prototype,"nv_getDay",{writable:true,value:Date.prototype.getDay})
Object.defineProperty(Date.prototype,"nv_getUTCDay",{writable:true,value:Date.prototype.getUTCDay})
Object.defineProperty(Date.prototype,"nv_getHours",{writable:true,value:Date.prototype.getHours})
Object.defineProperty(Date.prototype,"nv_getUTCHours",{writable:true,value:Date.prototype.getUTCHours})
Object.defineProperty(Date.prototype,"nv_getMinutes",{writable:true,value:Date.prototype.getMinutes})
Object.defineProperty(Date.prototype,"nv_getUTCMinutes",{writable:true,value:Date.prototype.getUTCMinutes})
Object.defineProperty(Date.prototype,"nv_getSeconds",{writable:true,value:Date.prototype.getSeconds})
Object.defineProperty(Date.prototype,"nv_getUTCSeconds",{writable:true,value:Date.prototype.getUTCSeconds})
Object.defineProperty(Date.prototype,"nv_getMilliseconds",{writable:true,value:Date.prototype.getMilliseconds})
Object.defineProperty(Date.prototype,"nv_getUTCMilliseconds",{writable:true,value:Date.prototype.getUTCMilliseconds})
Object.defineProperty(Date.prototype,"nv_getTimezoneOffset",{writable:true,value:Date.prototype.getTimezoneOffset})
Object.defineProperty(Date.prototype,"nv_setTime",{writable:true,value:Date.prototype.setTime})
Object.defineProperty(Date.prototype,"nv_setMilliseconds",{writable:true,value:Date.prototype.setMilliseconds})
Object.defineProperty(Date.prototype,"nv_setUTCMilliseconds",{writable:true,value:Date.prototype.setUTCMilliseconds})
Object.defineProperty(Date.prototype,"nv_setSeconds",{writable:true,value:Date.prototype.setSeconds})
Object.defineProperty(Date.prototype,"nv_setUTCSeconds",{writable:true,value:Date.prototype.setUTCSeconds})
Object.defineProperty(Date.prototype,"nv_setMinutes",{writable:true,value:Date.prototype.setMinutes})
Object.defineProperty(Date.prototype,"nv_setUTCMinutes",{writable:true,value:Date.prototype.setUTCMinutes})
Object.defineProperty(Date.prototype,"nv_setHours",{writable:true,value:Date.prototype.setHours})
Object.defineProperty(Date.prototype,"nv_setUTCHours",{writable:true,value:Date.prototype.setUTCHours})
Object.defineProperty(Date.prototype,"nv_setDate",{writable:true,value:Date.prototype.setDate})
Object.defineProperty(Date.prototype,"nv_setUTCDate",{writable:true,value:Date.prototype.setUTCDate})
Object.defineProperty(Date.prototype,"nv_setMonth",{writable:true,value:Date.prototype.setMonth})
Object.defineProperty(Date.prototype,"nv_setUTCMonth",{writable:true,value:Date.prototype.setUTCMonth})
Object.defineProperty(Date.prototype,"nv_setFullYear",{writable:true,value:Date.prototype.setFullYear})
Object.defineProperty(Date.prototype,"nv_setUTCFullYear",{writable:true,value:Date.prototype.setUTCFullYear})
Object.defineProperty(Date.prototype,"nv_toUTCString",{writable:true,value:Date.prototype.toUTCString})
Object.defineProperty(Date.prototype,"nv_toISOString",{writable:true,value:Date.prototype.toISOString})
Object.defineProperty(Date.prototype,"nv_toJSON",{writable:true,value:Date.prototype.toJSON})
}
var nf_init_RegExp=function(){
Object.defineProperty(RegExp.prototype,"nv_constructor",{writable:true,value:"RegExp"})
Object.defineProperty(RegExp.prototype,"nv_exec",{writable:true,value:RegExp.prototype.exec})
Object.defineProperty(RegExp.prototype,"nv_test",{writable:true,value:RegExp.prototype.test})
Object.defineProperty(RegExp.prototype,"nv_toString",{writable:true,value:RegExp.prototype.toString})
Object.defineProperty(RegExp.prototype,"nv_source",{get:function(){return this.source;},set:function(){}});
Object.defineProperty(RegExp.prototype,"nv_global",{get:function(){return this.global;},set:function(){}});
Object.defineProperty(RegExp.prototype,"nv_ignoreCase",{get:function(){return this.ignoreCase;},set:function(){}});
Object.defineProperty(RegExp.prototype,"nv_multiline",{get:function(){return this.multiline;},set:function(){}});
Object.defineProperty(RegExp.prototype,"nv_lastIndex",{get:function(){return this.lastIndex;},set:function(v){this.lastIndex=v;}});
}
nf_init();
var nv_getDate=function(){var args=Array.prototype.slice.call(arguments);args.unshift(Date);return new(Function.prototype.bind.apply(Date, args));}
var nv_getRegExp=function(){var args=Array.prototype.slice.call(arguments);args.unshift(RegExp);return new(Function.prototype.bind.apply(RegExp, args));}
var nv_console={}
nv_console.nv_log=function(){var res="WXSRT:";for(var i=0;i<arguments.length;++i)res+=arguments[i]+" ";console.log(res);}
var nv_parseInt = parseInt, nv_parseFloat = parseFloat, nv_isNaN = isNaN, nv_isFinite = isFinite, nv_decodeURI = decodeURI, nv_decodeURIComponent = decodeURIComponent, nv_encodeURI = encodeURI, nv_encodeURIComponent = encodeURIComponent;
function $gdc(o,p,r) {
o=wh.rv(o);
if(o===null||o===undefined) return o;
if(o.constructor===String||o.constructor===Boolean||o.constructor===Number) return o;
if(o.constructor===Object){
var copy={};
for(var k in o)
if(o.hasOwnProperty(k))
if(undefined===p) copy[k.substring(3)]=$gdc(o[k],p,r);
else copy[p+k]=$gdc(o[k],p,r);
return copy;
}
if(o.constructor===Array){
var copy=[];
for(var i=0;i<o.length;i++) copy.push($gdc(o[i],p,r));
return copy;
}
if(o.constructor===Date){
var copy=new Date();
copy.setTime(o.getTime());
return copy;
}
if(o.constructor===RegExp){
var f="";
if(o.global) f+="g";
if(o.ignoreCase) f+="i";
if(o.multiline) f+="m";
return (new RegExp(o.source,f));
}
if(r&&o.constructor===Function){
if ( r == 1 ) return $gdc(o(),undefined, 2);
if ( r == 2 ) return o;
}
return null;
}
var nv_JSON={}
nv_JSON.nv_stringify=function(o){
JSON.stringify(o);
return JSON.stringify($gdc(o));
}
nv_JSON.nv_parse=function(o){
if(o===undefined) return undefined;
var t=JSON.parse(o);
return $gdc(t,'nv_');
}

function _af(p, a, r, c){
p.extraAttr = {"t_action": a, "t_rawid": r };
if ( typeof(c) != 'undefined' ) p.extraAttr.t_cid = c;
}

function _gv( )
{if( typeof( window.__webview_engine_version__) == 'undefined' ) return 0.0;
return window.__webview_engine_version__;}
function _ai(i,p,e,me,r,c){var x=_grp(p,e,me);if(x)i.push(x);else{i.push('');_wp(me+':import:'+r+':'+c+': Path `'+p+'` not found from `'+me+'`.')}}
function _grp(p,e,me){if(p[0]!='/'){var mepart=me.split('/');mepart.pop();var ppart=p.split('/');for(var i=0;i<ppart.length;i++){if( ppart[i]=='..')mepart.pop();else if(!ppart[i]||ppart[i]=='.')continue;else mepart.push(ppart[i]);}p=mepart.join('/');}if(me[0]=='.'&&p[0]=='/')p='.'+p;if(e[p])return p;if(e[p+'.wxml'])return p+'.wxml';}
function _gd(p,c,e,d){if(!c)return;if(d[p][c])return d[p][c];for(var x=e[p].i.length-1;x>=0;x--){if(e[p].i[x]&&d[e[p].i[x]][c])return d[e[p].i[x]][c]};for(var x=e[p].ti.length-1;x>=0;x--){var q=_grp(e[p].ti[x],e,p);if(q&&d[q][c])return d[q][c]}var ii=_gapi(e,p);for(var x=0;x<ii.length;x++){if(ii[x]&&d[ii[x]][c])return d[ii[x]][c]}for(var k=e[p].j.length-1;k>=0;k--)if(e[p].j[k]){for(var q=e[e[p].j[k]].ti.length-1;q>=0;q--){var pp=_grp(e[e[p].j[k]].ti[q],e,p);if(pp&&d[pp][c]){return d[pp][c]}}}}
function _gapi(e,p){if(!p)return [];if($gaic[p]){return $gaic[p]};var ret=[],q=[],h=0,t=0,put={},visited={};q.push(p);visited[p]=true;t++;while(h<t){var a=q[h++];for(var i=0;i<e[a].ic.length;i++){var nd=e[a].ic[i];var np=_grp(nd,e,a);if(np&&!visited[np]){visited[np]=true;q.push(np);t++;}}for(var i=0;a!=p&&i<e[a].ti.length;i++){var ni=e[a].ti[i];var nm=_grp(ni,e,a);if(nm&&!put[nm]){put[nm]=true;ret.push(nm);}}}$gaic[p]=ret;return ret;}
var $ixc={};function _ic(p,ent,me,e,s,r,gg){var x=_grp(p,ent,me);ent[me].j.push(x);if(x){if($ixc[x]){_wp('-1:include:-1:-1: `'+p+'` is being included in a loop, will be stop.');return;}$ixc[x]=true;try{ent[x].f(e,s,r,gg)}catch(e){}$ixc[x]=false;}else{_wp(me+':include:-1:-1: Included path `'+p+'` not found from `'+me+'`.')}}
function _w(tn,f,line,c){_wp(f+':template:'+line+':'+c+': Template `'+tn+'` not found.');}function _ev(dom){var changed=false;delete dom.properities;delete dom.n;if(dom.children){do{changed=false;var newch = [];for(var i=0;i<dom.children.length;i++){var ch=dom.children[i];if( ch.tag=='virtual'){changed=true;for(var j=0;ch.children&&j<ch.children.length;j++){newch.push(ch.children[j]);}}else { newch.push(ch); } } dom.children = newch; }while(changed);for(var i=0;i<dom.children.length;i++){_ev(dom.children[i]);}} return dom; }
function _tsd( root )
{
if( root.tag == "wx-wx-scope" ) 
{
root.tag = "virtual";
root.wxCkey = "11";
root['wxScopeData'] = root.attr['wx:scope-data'];
delete root.n;
delete root.raw;
delete root.generics;
delete root.attr;
}
for( var i = 0 ; root.children && i < root.children.length ; i++ )
{
_tsd( root.children[i] );
}
return root;
}

var e_={}
if(typeof(global.entrys)==='undefined')global.entrys={};e_=global.entrys;
var d_={}
if(typeof(global.defines)==='undefined')global.defines={};d_=global.defines;
var f_={}
if(typeof(global.modules)==='undefined')global.modules={};f_=global.modules || {};
var p_={}
var cs
__WXML_GLOBAL__.ops_cached = __WXML_GLOBAL__.ops_cached || {}
__WXML_GLOBAL__.ops_set = __WXML_GLOBAL__.ops_set || {};
__WXML_GLOBAL__.ops_init = __WXML_GLOBAL__.ops_init || {};
var z=__WXML_GLOBAL__.ops_set.$gwx || [];
function gz$gwx_1(){
if( __WXML_GLOBAL__.ops_cached.$gwx_1)return __WXML_GLOBAL__.ops_cached.$gwx_1
__WXML_GLOBAL__.ops_cached.$gwx_1=[];
(function(z){var a=11;function Z(ops){z.push(ops)}
Z([[7],[3,'themeStyle']])
Z([[7],[3,'d']])
Z([a,[3,'page '],[[2,'?:'],[[2,'||'],[[6],[[7],[3,'d']],[3,'unlocked']],[[2,'&&'],[[6],[[7],[3,'d']],[3,'sellable']],[[7],[3,'paySupported']]]],[1,'page-has-bar'],[1,'']]])
Z([3,'hero bp-grid ticks'])
Z([a,[3,'height: '],[[6],[[7],[3,'nav']],[3,'statusBarHeight']],[3,'px;']])
Z([3,'rp-nav'])
Z([a,z[4][1],[[6],[[7],[3,'nav']],[3,'navHeight']],[3,'px']])
Z([3,'goBack'])
Z([3,'rp-back'])
Z([3,'‹ 返回'])
Z([3,'hero-inner'])
Z([3,'hero-kicker'])
Z([a,[[6],[[7],[3,'d']],[3,'cat_name']],[3,' · REPORT']])
Z([3,'rp-title'])
Z([a,[[6],[[7],[3,'d']],[3,'title']]])
Z([3,'hero-sub'])
Z([a,[[6],[[7],[3,'d']],[3,'subtitle']]])
Z([3,'hero-dwg mono'])
Z([a,[3,'SKU '],[[6],[[7],[3,'d']],[3,'sku']]])
Z([3,'dim-rule'])
Z([[6],[[7],[3,'d']],[3,'words_wan']])
Z([3,'dim-cap'])
Z([a,[[6],[[7],[3,'d']],[3,'words_wan']],[3,'万字']])
Z([3,'card ticks rise'])
Z([3,'rp-price-row'])
Z([a,[3,'rp-price '],[[2,'?:'],[[6],[[7],[3,'d']],[3,'unlocked']],[1,'rp-price-owned'],[1,'']]])
Z([a,[[2,'?:'],[[6],[[7],[3,'d']],[3,'unlocked']],[1,'已解锁 · 永久阅读'],[[2,'?:'],[[6],[[7],[3,'d']],[3,'sellable']],[[6],[[7],[3,'d']],[3,'price_label']],[1,'整理中 · 暂未开售']]]])
Z([3,'rp-badges'])
Z([[6],[[7],[3,'d']],[3,'badges']])
Z([3,'k'])
Z([3,'rs-badge'])
Z([a,[[6],[[7],[3,'item']],[3,'k']],[[2,'?:'],[[6],[[7],[3,'item']],[3,'v']],[[2,'+'],[1,' '],[[6],[[7],[3,'item']],[3,'v']]],[1,'']]])
Z([[6],[[7],[3,'d']],[3,'unlocked']])
Z([3,'openPdf'])
Z([3,'btn-primary rp-act'])
Z([[7],[3,'opening']])
Z([3,'btn-hover'])
Z([a,[[2,'?:'],[[7],[3,'opening']],[1,'打开中…'],[1,'打开 PDF 全文']]])
Z([[2,'&&'],[[6],[[7],[3,'d']],[3,'sellable']],[[7],[3,'paySupported']]])
Z([3,'buy'])
Z(z[34])
Z([[7],[3,'buying']])
Z(z[36])
Z([a,[[2,'?:'],[[7],[3,'buying']],[1,'拉起支付…'],[[2,'+'],[[6],[[7],[3,'d']],[3,'price_label']],[1,' · 购买解锁']]]])
Z([[6],[[7],[3,'d']],[3,'sellable']])
Z([3,'rp-ios-note muted'])
Z([3,'iOS 暂不支持应用内购买，请在安卓设备上购买后阅读'])
Z(z[45])
Z([3,'本报告 PDF 整理中，开放购买前可先试读'])
Z([3,'muted rp-note'])
Z([3,'一次解锁 · 永久阅读 · PDF 全文阅读与下载保存 · 内容由研究团队基于公开资料与 AI 辅助研究方法产出'])
Z([[2,'||'],[[6],[[7],[3,'d']],[3,'intro_lede']],[[6],[[7],[3,'d']],[3,'intro']]])
Z(z[23])
Z([3,'kicker kicker-on-paper rp-kicker'])
Z([3,'ABOUT · 报告简介'])
Z([[6],[[7],[3,'d']],[3,'intro_lede']])
Z([3,'rp-lede'])
Z([a,[[6],[[7],[3,'d']],[3,'intro_lede']]])
Z([[6],[[7],[3,'d']],[3,'intro']])
Z([3,'rp-intro'])
Z([a,[[6],[[7],[3,'d']],[3,'intro']]])
Z([[6],[[7],[3,'d']],[3,'audience']])
Z(z[23])
Z(z[53])
Z([3,'FOR · 适用人群'])
Z(z[59])
Z([a,[[6],[[7],[3,'d']],[3,'audience']]])
Z([[6],[[6],[[7],[3,'d']],[3,'chapters']],[3,'length']])
Z(z[23])
Z(z[53])
Z([3,'CHAPTERS · 章节目录'])
Z([3,'mono rp-ch-n'])
Z([a,[[6],[[6],[[7],[3,'d']],[3,'chapters']],[3,'length']]])
Z([[6],[[7],[3,'d']],[3,'chapters']])
Z([3,'id'])
Z([3,'rp-ch'])
Z([3,'rp-ch-t'])
Z([3,'mono rp-ch-id'])
Z([a,[[6],[[7],[3,'item']],[3,'id']]])
Z([a,[[6],[[7],[3,'item']],[3,'title']]])
Z([[6],[[7],[3,'item']],[3,'desc']])
Z([3,'muted rp-ch-d'])
Z([a,[[6],[[7],[3,'item']],[3,'desc']]])
Z([[6],[[7],[3,'sampleBlocks']],[3,'length']])
Z(z[23])
Z(z[53])
Z([a,[[2,'||'],[[6],[[7],[3,'d']],[3,'sample_label']],[1,'试读']],[3,' · FREE']])
Z([a,[3,'rp-sample '],[[2,'?:'],[[7],[3,'sampleOpen']],[1,''],[1,'rp-sample-fold']]])
Z([3,'b'])
Z([[7],[3,'sampleBlocks']])
Z([3,'index'])
Z([[2,'==='],[[6],[[7],[3,'b']],[3,'t']],[1,'h1']])
Z([3,'md-h1'])
Z([[8],'segs',[[6],[[7],[3,'b']],[3,'inl']]])
Z([3,'inl'])
Z([[2,'==='],[[6],[[7],[3,'b']],[3,'t']],[1,'h2']])
Z([3,'md-h2'])
Z([3,'h2-bar'])
Z([3,'md-h2-text'])
Z(z[93])
Z(z[94])
Z([[2,'==='],[[6],[[7],[3,'b']],[3,'t']],[1,'h3']])
Z([3,'md-h3'])
Z(z[93])
Z(z[94])
Z([[2,'==='],[[6],[[7],[3,'b']],[3,'t']],[1,'p']])
Z([3,'md-p'])
Z(z[93])
Z(z[94])
Z([[2,'==='],[[6],[[7],[3,'b']],[3,'t']],[1,'quote']])
Z([3,'md-quote'])
Z(z[93])
Z(z[94])
Z([[2,'==='],[[6],[[7],[3,'b']],[3,'t']],[1,'hr']])
Z([3,'md-hr'])
Z([[2,'==='],[[6],[[7],[3,'b']],[3,'t']],[1,'code']])
Z([3,'md-code-wrap'])
Z([3,'md-code-scroll'])
Z([1,false])
Z([3,'md-code'])
Z([a,[[6],[[7],[3,'b']],[3,'text']]])
Z([[2,'==='],[[6],[[7],[3,'b']],[3,'t']],[1,'ul']])
Z([3,'md-list'])
Z([3,'li'])
Z([[6],[[7],[3,'b']],[3,'items']])
Z(z[90])
Z([3,'md-li'])
Z([3,'li-dot'])
Z([3,'li-text'])
Z([[8],'segs',[[7],[3,'li']]])
Z(z[94])
Z([[2,'==='],[[6],[[7],[3,'b']],[3,'t']],[1,'ol']])
Z(z[122])
Z([3,'liIdx'])
Z(z[123])
Z(z[124])
Z(z[90])
Z(z[126])
Z([3,'li-num mono'])
Z([a,[[6],[[6],[[7],[3,'b']],[3,'nums']],[[7],[3,'liIdx']]]])
Z(z[128])
Z(z[129])
Z(z[94])
Z([[2,'==='],[[6],[[7],[3,'b']],[3,'t']],[1,'table']])
Z([3,'md-tbl-scroll'])
Z(z[118])
Z([3,'md-tbl'])
Z([3,'md-tr md-tr-head'])
Z([3,'cell'])
Z([[6],[[7],[3,'b']],[3,'head']])
Z(z[90])
Z([3,'md-th'])
Z([[8],'segs',[[7],[3,'cell']]])
Z(z[94])
Z([3,'row'])
Z([[6],[[7],[3,'b']],[3,'rows']])
Z(z[90])
Z([3,'md-tr'])
Z(z[148])
Z([[7],[3,'row']])
Z(z[90])
Z([3,'md-td'])
Z(z[152])
Z(z[94])
Z([3,'toggleSample'])
Z([3,'rp-sample-more'])
Z([a,[[2,'?:'],[[7],[3,'sampleOpen']],[1,'收起试读 ▴'],[1,'展开试读 ▾']]])
Z([[2,'&&'],[[2,'&&'],[[2,'&&'],[[7],[3,'sampleOpen']],[[6],[[7],[3,'d']],[3,'sellable']]],[[2,'!'],[[6],[[7],[3,'d']],[3,'unlocked']]]],[[7],[3,'paySupported']]])
Z(z[39])
Z([3,'rp-cta'])
Z([3,'rp-cta-hover'])
Z([3,'rp-cta-t'])
Z([3,'试读到此 · 付费解锁全量阅读与下载'])
Z([3,'rp-cta-arrow'])
Z([3,'›'])
Z([3,'safe-bottom'])
Z([[2,'&&'],[[7],[3,'d']],[[2,'||'],[[6],[[7],[3,'d']],[3,'unlocked']],[[2,'&&'],[[6],[[7],[3,'d']],[3,'sellable']],[[7],[3,'paySupported']]]]])
Z([3,'rp-bar'])
Z([[2,'!'],[[6],[[7],[3,'d']],[3,'unlocked']]])
Z([3,'rp-bar-info'])
Z([3,'rp-bar-price'])
Z([a,[[6],[[7],[3,'d']],[3,'price_label']]])
Z([3,'rp-bar-sub muted'])
Z([3,'一次解锁 · 永久阅读'])
Z(z[32])
Z(z[179])
Z(z[180])
Z([3,'已解锁'])
Z(z[182])
Z([3,'全量阅读 · 可下载保存'])
Z(z[32])
Z(z[33])
Z([3,'btn-primary rp-bar-btn'])
Z(z[35])
Z(z[36])
Z([a,z[37][1]])
Z(z[39])
Z(z[192])
Z(z[41])
Z(z[36])
Z([a,[[2,'?:'],[[7],[3,'buying']],[1,'拉起支付…'],[1,'购买解锁']]])
Z([3,'page'])
Z([3,'card ticks rp-state'])
Z([[7],[3,'loading']])
Z([3,'muted'])
Z([3,'报告加载中…'])
Z([3,'rp-skel'])
Z([3,'rp-skel-l w60'])
Z([3,'rp-skel-l'])
Z([3,'rp-skel-l w40'])
Z([3,'rp-state-t'])
Z([a,[[2,'||'],[[7],[3,'errMsg']],[1,'报告不存在']]])
Z(z[7])
Z(z[34])
Z(z[36])
Z([3,'返回目录'])
Z(z[94])
Z([3,'s'])
Z([[7],[3,'segs']])
Z(z[90])
Z([[2,'==='],[[6],[[7],[3,'s']],[3,'k']],[1,'b']])
Z([3,'in-b'])
Z([a,[[6],[[7],[3,'s']],[3,'v']]])
Z([[2,'==='],[[6],[[7],[3,'s']],[3,'k']],[1,'i']])
Z([3,'in-i'])
Z([a,z[222][1]])
Z([[2,'==='],[[6],[[7],[3,'s']],[3,'k']],[1,'c']])
Z([3,'in-c'])
Z([a,z[222][1]])
Z([[2,'==='],[[6],[[7],[3,'s']],[3,'k']],[1,'l']])
Z([3,'in-l'])
Z([a,z[222][1]])
Z([a,z[222][1]])
})(__WXML_GLOBAL__.ops_cached.$gwx_1);return __WXML_GLOBAL__.ops_cached.$gwx_1
}
__WXML_GLOBAL__.ops_set.$gwx=z;
__WXML_GLOBAL__.ops_init.$gwx=true;
var nv_require=function(){var nnm={};var nom={};return function(n){if(n[0]==='p'&&n[1]==='_'&&f_[n.slice(2)])return f_[n.slice(2)];return function(){if(!nnm[n]) return undefined;try{if(!nom[n])nom[n]=nnm[n]();return nom[n];}catch(e){e.message=e.message.replace(/nv_/g,'');var tmp = e.stack.substring(0,e.stack.lastIndexOf(n));e.stack = tmp.substring(0,tmp.lastIndexOf('\n'));e.stack = e.stack.replace(/\snv_/g,' ');e.stack = $gstack(e.stack);e.stack += '\n    at ' + n.substring(2);console.error(e);}
}}}()
var x=['pages/report/report.wxml'];d_[x[0]]={}
d_[x[0]]["inl"]=function(e,s,r,gg){
var z=gz$gwx_1()
var b=x[0]+':inl'
r.wxVkey=b
gg.f=$gdc(f_["pages/report/report.wxml"],"",1)
if(p_[b]){_wl(b,x[0]);return}
p_[b]=true
try{
var oB=_v()
_(r,oB)
cs.push("pages/report/report.wxml:block:191:4")
var xC=function(fE,oD,cF,gg){
cs.push("pages/report/report.wxml:block:191:4")
var oH=_v()
_(cF,oH)
if(_oz(z,220,fE,oD,gg)){oH.wxVkey=1
cs.push("pages/report/report.wxml:text:192:6")
cs.push("pages/report/report.wxml:text:192:6")
var cI=_mz(z,'text',['userSelect',-1,'class',221],[],fE,oD,gg)
var oJ=_oz(z,222,fE,oD,gg)
_(cI,oJ)
cs.pop()
_(oH,cI)
cs.pop()
}
else if(_oz(z,223,fE,oD,gg)){oH.wxVkey=2
cs.push("pages/report/report.wxml:text:193:6")
cs.push("pages/report/report.wxml:text:193:6")
var lK=_mz(z,'text',['userSelect',-1,'class',224],[],fE,oD,gg)
var aL=_oz(z,225,fE,oD,gg)
_(lK,aL)
cs.pop()
_(oH,lK)
cs.pop()
}
else if(_oz(z,226,fE,oD,gg)){oH.wxVkey=3
cs.push("pages/report/report.wxml:text:194:6")
cs.push("pages/report/report.wxml:text:194:6")
var tM=_mz(z,'text',['userSelect',-1,'class',227],[],fE,oD,gg)
var eN=_oz(z,228,fE,oD,gg)
_(tM,eN)
cs.pop()
_(oH,tM)
cs.pop()
}
else if(_oz(z,229,fE,oD,gg)){oH.wxVkey=4
cs.push("pages/report/report.wxml:text:195:6")
cs.push("pages/report/report.wxml:text:195:6")
var bO=_mz(z,'text',['userSelect',-1,'class',230],[],fE,oD,gg)
var oP=_oz(z,231,fE,oD,gg)
_(bO,oP)
cs.pop()
_(oH,bO)
cs.pop()
}
else{oH.wxVkey=5
cs.push("pages/report/report.wxml:block:196:6")
cs.push("pages/report/report.wxml:text:196:21")
var xQ=_n('text')
xQ.attr['userSelect']=true
var oR=_oz(z,232,fE,oD,gg)
_(xQ,oR)
cs.pop()
_(oH,xQ)
cs.pop()
}
oH.wxXCkey=1
cs.pop()
return cF
}
oB.wxXCkey=2
_2z(z,218,xC,e,s,gg,oB,'s','index','index')
cs.pop()
}catch(err){
p_[b]=false
throw err
}
p_[b]=false
return r
}
var m0=function(e,s,r,gg){
var z=gz$gwx_1()
cs.push("pages/report/report.wxml:page-meta:1:1")
var oD=_n('page-meta')
_rz(z,oD,'pageStyle',0,e,s,gg)
cs.pop()
_(r,oD)
var oB=_v()
_(r,oB)
if(_oz(z,1,e,s,gg)){oB.wxVkey=1
cs.push("pages/report/report.wxml:view:2:2")
cs.push("pages/report/report.wxml:view:2:2")
var fE=_n('view')
_rz(z,fE,'class',2,e,s,gg)
cs.push("pages/report/report.wxml:view:5:4")
var oJ=_n('view')
_rz(z,oJ,'class',3,e,s,gg)
cs.push("pages/report/report.wxml:view:6:6")
var lK=_n('view')
_rz(z,lK,'style',4,e,s,gg)
cs.pop()
_(oJ,lK)
cs.push("pages/report/report.wxml:view:7:6")
var aL=_mz(z,'view',['class',5,'style',1],[],e,s,gg)
cs.push("pages/report/report.wxml:view:8:8")
var tM=_mz(z,'view',['bindtap',7,'class',1],[],e,s,gg)
var eN=_oz(z,9,e,s,gg)
_(tM,eN)
cs.pop()
_(aL,tM)
cs.pop()
_(oJ,aL)
cs.push("pages/report/report.wxml:view:11:6")
var bO=_n('view')
_rz(z,bO,'class',10,e,s,gg)
cs.push("pages/report/report.wxml:view:12:8")
var oP=_n('view')
_rz(z,oP,'class',11,e,s,gg)
var xQ=_oz(z,12,e,s,gg)
_(oP,xQ)
cs.pop()
_(bO,oP)
cs.push("pages/report/report.wxml:view:13:8")
var oR=_n('view')
_rz(z,oR,'class',13,e,s,gg)
var fS=_oz(z,14,e,s,gg)
_(oR,fS)
cs.pop()
_(bO,oR)
cs.push("pages/report/report.wxml:view:14:8")
var cT=_n('view')
_rz(z,cT,'class',15,e,s,gg)
var hU=_oz(z,16,e,s,gg)
_(cT,hU)
cs.pop()
_(bO,cT)
cs.push("pages/report/report.wxml:view:16:8")
var oV=_n('view')
_rz(z,oV,'class',17,e,s,gg)
var oX=_oz(z,18,e,s,gg)
_(oV,oX)
cs.push("pages/report/report.wxml:view:16:49")
var lY=_n('view')
_rz(z,lY,'class',19,e,s,gg)
cs.pop()
_(oV,lY)
var cW=_v()
_(oV,cW)
if(_oz(z,20,e,s,gg)){cW.wxVkey=1
cs.push("pages/report/report.wxml:text:16:79")
cs.push("pages/report/report.wxml:text:16:79")
var aZ=_n('text')
_rz(z,aZ,'class',21,e,s,gg)
var t1=_oz(z,22,e,s,gg)
_(aZ,t1)
cs.pop()
_(cW,aZ)
cs.pop()
}
cW.wxXCkey=1
cs.pop()
_(bO,oV)
cs.pop()
_(oJ,bO)
cs.pop()
_(fE,oJ)
cs.push("pages/report/report.wxml:view:21:4")
var e2=_n('view')
_rz(z,e2,'class',23,e,s,gg)
cs.push("pages/report/report.wxml:view:22:6")
var o4=_n('view')
_rz(z,o4,'class',24,e,s,gg)
cs.push("pages/report/report.wxml:view:23:8")
var x5=_n('view')
_rz(z,x5,'class',25,e,s,gg)
var o6=_oz(z,26,e,s,gg)
_(x5,o6)
cs.pop()
_(o4,x5)
cs.push("pages/report/report.wxml:view:24:8")
var f7=_n('view')
_rz(z,f7,'class',27,e,s,gg)
var c8=_v()
_(f7,c8)
cs.push("pages/report/report.wxml:text:25:10")
var h9=function(cAB,o0,oBB,gg){
cs.push("pages/report/report.wxml:text:25:10")
var aDB=_n('text')
_rz(z,aDB,'class',30,cAB,o0,gg)
var tEB=_oz(z,31,cAB,o0,gg)
_(aDB,tEB)
cs.pop()
_(oBB,aDB)
return oBB
}
c8.wxXCkey=2
_2z(z,28,h9,e,s,gg,c8,'item','index','k')
cs.pop()
cs.pop()
_(o4,f7)
cs.pop()
_(e2,o4)
var b3=_v()
_(e2,b3)
if(_oz(z,32,e,s,gg)){b3.wxVkey=1
cs.push("pages/report/report.wxml:button:30:6")
cs.push("pages/report/report.wxml:button:30:6")
var eFB=_mz(z,'button',['bindtap',33,'class',1,'disabled',2,'hoverClass',3],[],e,s,gg)
var bGB=_oz(z,37,e,s,gg)
_(eFB,bGB)
cs.pop()
_(b3,eFB)
cs.pop()
}
else if(_oz(z,38,e,s,gg)){b3.wxVkey=2
cs.push("pages/report/report.wxml:button:37:6")
cs.push("pages/report/report.wxml:button:37:6")
var oHB=_mz(z,'button',['bindtap',39,'class',1,'disabled',2,'hoverClass',3],[],e,s,gg)
var xIB=_oz(z,43,e,s,gg)
_(oHB,xIB)
cs.pop()
_(b3,oHB)
cs.pop()
}
else if(_oz(z,44,e,s,gg)){b3.wxVkey=3
cs.push("pages/report/report.wxml:view:44:6")
cs.push("pages/report/report.wxml:view:44:6")
var oJB=_n('view')
_rz(z,oJB,'class',45,e,s,gg)
var fKB=_oz(z,46,e,s,gg)
_(oJB,fKB)
cs.pop()
_(b3,oJB)
cs.pop()
}
else{b3.wxVkey=4
cs.push("pages/report/report.wxml:view:45:6")
cs.push("pages/report/report.wxml:view:45:6")
var cLB=_n('view')
_rz(z,cLB,'class',47,e,s,gg)
var hMB=_oz(z,48,e,s,gg)
_(cLB,hMB)
cs.pop()
_(b3,cLB)
cs.pop()
}
cs.push("pages/report/report.wxml:view:47:6")
var oNB=_n('view')
_rz(z,oNB,'class',49,e,s,gg)
var cOB=_oz(z,50,e,s,gg)
_(oNB,cOB)
cs.pop()
_(e2,oNB)
b3.wxXCkey=1
cs.pop()
_(fE,e2)
var cF=_v()
_(fE,cF)
if(_oz(z,51,e,s,gg)){cF.wxVkey=1
cs.push("pages/report/report.wxml:view:51:4")
cs.push("pages/report/report.wxml:view:51:4")
var oPB=_n('view')
_rz(z,oPB,'class',52,e,s,gg)
cs.push("pages/report/report.wxml:view:52:6")
var tSB=_n('view')
_rz(z,tSB,'class',53,e,s,gg)
var eTB=_oz(z,54,e,s,gg)
_(tSB,eTB)
cs.pop()
_(oPB,tSB)
var lQB=_v()
_(oPB,lQB)
if(_oz(z,55,e,s,gg)){lQB.wxVkey=1
cs.push("pages/report/report.wxml:view:53:6")
cs.push("pages/report/report.wxml:view:53:6")
var bUB=_n('view')
_rz(z,bUB,'class',56,e,s,gg)
var oVB=_oz(z,57,e,s,gg)
_(bUB,oVB)
cs.pop()
_(lQB,bUB)
cs.pop()
}
var aRB=_v()
_(oPB,aRB)
if(_oz(z,58,e,s,gg)){aRB.wxVkey=1
cs.push("pages/report/report.wxml:view:54:6")
cs.push("pages/report/report.wxml:view:54:6")
var xWB=_n('view')
_rz(z,xWB,'class',59,e,s,gg)
var oXB=_oz(z,60,e,s,gg)
_(xWB,oXB)
cs.pop()
_(aRB,xWB)
cs.pop()
}
lQB.wxXCkey=1
aRB.wxXCkey=1
cs.pop()
_(cF,oPB)
cs.pop()
}
var hG=_v()
_(fE,hG)
if(_oz(z,61,e,s,gg)){hG.wxVkey=1
cs.push("pages/report/report.wxml:view:58:4")
cs.push("pages/report/report.wxml:view:58:4")
var fYB=_n('view')
_rz(z,fYB,'class',62,e,s,gg)
cs.push("pages/report/report.wxml:view:59:6")
var cZB=_n('view')
_rz(z,cZB,'class',63,e,s,gg)
var h1B=_oz(z,64,e,s,gg)
_(cZB,h1B)
cs.pop()
_(fYB,cZB)
cs.push("pages/report/report.wxml:view:60:6")
var o2B=_n('view')
_rz(z,o2B,'class',65,e,s,gg)
var c3B=_oz(z,66,e,s,gg)
_(o2B,c3B)
cs.pop()
_(fYB,o2B)
cs.pop()
_(hG,fYB)
cs.pop()
}
var oH=_v()
_(fE,oH)
if(_oz(z,67,e,s,gg)){oH.wxVkey=1
cs.push("pages/report/report.wxml:view:64:4")
cs.push("pages/report/report.wxml:view:64:4")
var o4B=_n('view')
_rz(z,o4B,'class',68,e,s,gg)
cs.push("pages/report/report.wxml:view:65:6")
var l5B=_n('view')
_rz(z,l5B,'class',69,e,s,gg)
var a6B=_oz(z,70,e,s,gg)
_(l5B,a6B)
cs.push("pages/report/report.wxml:text:65:77")
var t7B=_n('text')
_rz(z,t7B,'class',71,e,s,gg)
var e8B=_oz(z,72,e,s,gg)
_(t7B,e8B)
cs.pop()
_(l5B,t7B)
cs.pop()
_(o4B,l5B)
var b9B=_v()
_(o4B,b9B)
cs.push("pages/report/report.wxml:view:66:6")
var o0B=function(oBC,xAC,fCC,gg){
cs.push("pages/report/report.wxml:view:66:6")
var hEC=_n('view')
_rz(z,hEC,'class',75,oBC,xAC,gg)
cs.push("pages/report/report.wxml:view:67:8")
var cGC=_n('view')
_rz(z,cGC,'class',76,oBC,xAC,gg)
cs.push("pages/report/report.wxml:text:67:30")
var oHC=_n('text')
_rz(z,oHC,'class',77,oBC,xAC,gg)
var lIC=_oz(z,78,oBC,xAC,gg)
_(oHC,lIC)
cs.pop()
_(cGC,oHC)
var aJC=_oz(z,79,oBC,xAC,gg)
_(cGC,aJC)
cs.pop()
_(hEC,cGC)
var oFC=_v()
_(hEC,oFC)
if(_oz(z,80,oBC,xAC,gg)){oFC.wxVkey=1
cs.push("pages/report/report.wxml:view:68:8")
cs.push("pages/report/report.wxml:view:68:8")
var tKC=_n('view')
_rz(z,tKC,'class',81,oBC,xAC,gg)
var eLC=_oz(z,82,oBC,xAC,gg)
_(tKC,eLC)
cs.pop()
_(oFC,tKC)
cs.pop()
}
oFC.wxXCkey=1
cs.pop()
_(fCC,hEC)
return fCC
}
b9B.wxXCkey=2
_2z(z,73,o0B,e,s,gg,b9B,'item','index','id')
cs.pop()
cs.pop()
_(oH,o4B)
cs.pop()
}
var cI=_v()
_(fE,cI)
if(_oz(z,83,e,s,gg)){cI.wxVkey=1
cs.push("pages/report/report.wxml:view:73:4")
cs.push("pages/report/report.wxml:view:73:4")
var bMC=_n('view')
_rz(z,bMC,'class',84,e,s,gg)
cs.push("pages/report/report.wxml:view:74:6")
var xOC=_n('view')
_rz(z,xOC,'class',85,e,s,gg)
var oPC=_oz(z,86,e,s,gg)
_(xOC,oPC)
cs.pop()
_(bMC,xOC)
cs.push("pages/report/report.wxml:view:75:6")
var fQC=_n('view')
_rz(z,fQC,'class',87,e,s,gg)
var cRC=_v()
_(fQC,cRC)
cs.push("pages/report/report.wxml:block:76:8")
var hSC=function(cUC,oTC,oVC,gg){
cs.push("pages/report/report.wxml:block:76:8")
var aXC=_v()
_(oVC,aXC)
if(_oz(z,91,cUC,oTC,gg)){aXC.wxVkey=1
cs.push("pages/report/report.wxml:view:78:10")
cs.push("pages/report/report.wxml:view:78:10")
var tYC=_n('view')
_rz(z,tYC,'class',92,cUC,oTC,gg)
cs.push("pages/report/report.wxml:text:79:12")
var eZC=_n('text')
eZC.attr['userSelect']=true
var b1C=_v()
_(eZC,b1C)
cs.push("pages/report/report.wxml:template:79:30")
var o2C=_oz(z,94,cUC,oTC,gg)
var x3C=_gd(x[0],o2C,e_,d_)
if(x3C){
var o4C=_1z(z,93,cUC,oTC,gg) || {}
var cur_globalf=gg.f
b1C.wxXCkey=3
x3C(o4C,o4C,b1C,gg)
gg.f=cur_globalf
}
else _w(o2C,x[0],79,42)
cs.pop()
cs.pop()
_(tYC,eZC)
cs.pop()
_(aXC,tYC)
cs.pop()
}
else if(_oz(z,95,cUC,oTC,gg)){aXC.wxVkey=2
cs.push("pages/report/report.wxml:view:81:10")
cs.push("pages/report/report.wxml:view:81:10")
var f5C=_n('view')
_rz(z,f5C,'class',96,cUC,oTC,gg)
cs.push("pages/report/report.wxml:view:82:12")
var c6C=_n('view')
_rz(z,c6C,'class',97,cUC,oTC,gg)
cs.pop()
_(f5C,c6C)
cs.push("pages/report/report.wxml:text:83:12")
var h7C=_mz(z,'text',['userSelect',-1,'class',98],[],cUC,oTC,gg)
var o8C=_v()
_(h7C,o8C)
cs.push("pages/report/report.wxml:template:83:49")
var c9C=_oz(z,100,cUC,oTC,gg)
var o0C=_gd(x[0],c9C,e_,d_)
if(o0C){
var lAD=_1z(z,99,cUC,oTC,gg) || {}
var cur_globalf=gg.f
o8C.wxXCkey=3
o0C(lAD,lAD,o8C,gg)
gg.f=cur_globalf
}
else _w(c9C,x[0],83,61)
cs.pop()
cs.pop()
_(f5C,h7C)
cs.pop()
_(aXC,f5C)
cs.pop()
}
else if(_oz(z,101,cUC,oTC,gg)){aXC.wxVkey=3
cs.push("pages/report/report.wxml:view:85:10")
cs.push("pages/report/report.wxml:view:85:10")
var aBD=_n('view')
_rz(z,aBD,'class',102,cUC,oTC,gg)
cs.push("pages/report/report.wxml:text:86:12")
var tCD=_n('text')
tCD.attr['userSelect']=true
var eDD=_v()
_(tCD,eDD)
cs.push("pages/report/report.wxml:template:86:30")
var bED=_oz(z,104,cUC,oTC,gg)
var oFD=_gd(x[0],bED,e_,d_)
if(oFD){
var xGD=_1z(z,103,cUC,oTC,gg) || {}
var cur_globalf=gg.f
eDD.wxXCkey=3
oFD(xGD,xGD,eDD,gg)
gg.f=cur_globalf
}
else _w(bED,x[0],86,42)
cs.pop()
cs.pop()
_(aBD,tCD)
cs.pop()
_(aXC,aBD)
cs.pop()
}
else if(_oz(z,105,cUC,oTC,gg)){aXC.wxVkey=4
cs.push("pages/report/report.wxml:view:89:10")
cs.push("pages/report/report.wxml:view:89:10")
var oHD=_n('view')
_rz(z,oHD,'class',106,cUC,oTC,gg)
cs.push("pages/report/report.wxml:text:90:12")
var fID=_n('text')
fID.attr['userSelect']=true
var cJD=_v()
_(fID,cJD)
cs.push("pages/report/report.wxml:template:90:30")
var hKD=_oz(z,108,cUC,oTC,gg)
var oLD=_gd(x[0],hKD,e_,d_)
if(oLD){
var cMD=_1z(z,107,cUC,oTC,gg) || {}
var cur_globalf=gg.f
cJD.wxXCkey=3
oLD(cMD,cMD,cJD,gg)
gg.f=cur_globalf
}
else _w(hKD,x[0],90,42)
cs.pop()
cs.pop()
_(oHD,fID)
cs.pop()
_(aXC,oHD)
cs.pop()
}
else if(_oz(z,109,cUC,oTC,gg)){aXC.wxVkey=5
cs.push("pages/report/report.wxml:view:93:10")
cs.push("pages/report/report.wxml:view:93:10")
var oND=_n('view')
_rz(z,oND,'class',110,cUC,oTC,gg)
cs.push("pages/report/report.wxml:text:94:12")
var lOD=_n('text')
lOD.attr['userSelect']=true
var aPD=_v()
_(lOD,aPD)
cs.push("pages/report/report.wxml:template:94:30")
var tQD=_oz(z,112,cUC,oTC,gg)
var eRD=_gd(x[0],tQD,e_,d_)
if(eRD){
var bSD=_1z(z,111,cUC,oTC,gg) || {}
var cur_globalf=gg.f
aPD.wxXCkey=3
eRD(bSD,bSD,aPD,gg)
gg.f=cur_globalf
}
else _w(tQD,x[0],94,42)
cs.pop()
cs.pop()
_(oND,lOD)
cs.pop()
_(aXC,oND)
cs.pop()
}
else if(_oz(z,113,cUC,oTC,gg)){aXC.wxVkey=6
cs.push("pages/report/report.wxml:view:97:10")
cs.push("pages/report/report.wxml:view:97:10")
var oTD=_n('view')
_rz(z,oTD,'class',114,cUC,oTC,gg)
cs.pop()
_(aXC,oTD)
cs.pop()
}
else if(_oz(z,115,cUC,oTC,gg)){aXC.wxVkey=7
cs.push("pages/report/report.wxml:view:99:10")
cs.push("pages/report/report.wxml:view:99:10")
var xUD=_n('view')
_rz(z,xUD,'class',116,cUC,oTC,gg)
cs.push("pages/report/report.wxml:scroll-view:100:12")
var oVD=_mz(z,'scroll-view',['enhanced',-1,'scrollX',-1,'class',117,'showScrollbar',1],[],cUC,oTC,gg)
cs.push("pages/report/report.wxml:text:101:14")
var fWD=_mz(z,'text',['userSelect',-1,'class',119],[],cUC,oTC,gg)
var cXD=_oz(z,120,cUC,oTC,gg)
_(fWD,cXD)
cs.pop()
_(oVD,fWD)
cs.pop()
_(xUD,oVD)
cs.pop()
_(aXC,xUD)
cs.pop()
}
else if(_oz(z,121,cUC,oTC,gg)){aXC.wxVkey=8
cs.push("pages/report/report.wxml:view:105:10")
cs.push("pages/report/report.wxml:view:105:10")
var hYD=_n('view')
_rz(z,hYD,'class',122,cUC,oTC,gg)
var oZD=_v()
_(hYD,oZD)
cs.push("pages/report/report.wxml:view:106:12")
var c1D=function(l3D,o2D,a4D,gg){
cs.push("pages/report/report.wxml:view:106:12")
var e6D=_n('view')
_rz(z,e6D,'class',126,l3D,o2D,gg)
cs.push("pages/report/report.wxml:view:107:14")
var b7D=_n('view')
_rz(z,b7D,'class',127,l3D,o2D,gg)
cs.pop()
_(e6D,b7D)
cs.push("pages/report/report.wxml:text:108:14")
var o8D=_mz(z,'text',['userSelect',-1,'class',128],[],l3D,o2D,gg)
var x9D=_v()
_(o8D,x9D)
cs.push("pages/report/report.wxml:template:108:48")
var o0D=_oz(z,130,l3D,o2D,gg)
var fAE=_gd(x[0],o0D,e_,d_)
if(fAE){
var cBE=_1z(z,129,l3D,o2D,gg) || {}
var cur_globalf=gg.f
x9D.wxXCkey=3
fAE(cBE,cBE,x9D,gg)
gg.f=cur_globalf
}
else _w(o0D,x[0],108,60)
cs.pop()
cs.pop()
_(e6D,o8D)
cs.pop()
_(a4D,e6D)
return a4D
}
oZD.wxXCkey=2
_2z(z,124,c1D,cUC,oTC,gg,oZD,'li','index','index')
cs.pop()
cs.pop()
_(aXC,hYD)
cs.pop()
}
else if(_oz(z,131,cUC,oTC,gg)){aXC.wxVkey=9
cs.push("pages/report/report.wxml:view:112:10")
cs.push("pages/report/report.wxml:view:112:10")
var hCE=_n('view')
_rz(z,hCE,'class',132,cUC,oTC,gg)
var oDE=_v()
_(hCE,oDE)
cs.push("pages/report/report.wxml:view:113:12")
var cEE=function(lGE,oFE,aHE,gg){
cs.push("pages/report/report.wxml:view:113:12")
var eJE=_n('view')
_rz(z,eJE,'class',137,lGE,oFE,gg)
cs.push("pages/report/report.wxml:view:114:14")
var bKE=_n('view')
_rz(z,bKE,'class',138,lGE,oFE,gg)
var oLE=_oz(z,139,lGE,oFE,gg)
_(bKE,oLE)
cs.pop()
_(eJE,bKE)
cs.push("pages/report/report.wxml:text:115:14")
var xME=_mz(z,'text',['userSelect',-1,'class',140],[],lGE,oFE,gg)
var oNE=_v()
_(xME,oNE)
cs.push("pages/report/report.wxml:template:115:48")
var fOE=_oz(z,142,lGE,oFE,gg)
var cPE=_gd(x[0],fOE,e_,d_)
if(cPE){
var hQE=_1z(z,141,lGE,oFE,gg) || {}
var cur_globalf=gg.f
oNE.wxXCkey=3
cPE(hQE,hQE,oNE,gg)
gg.f=cur_globalf
}
else _w(fOE,x[0],115,60)
cs.pop()
cs.pop()
_(eJE,xME)
cs.pop()
_(aHE,eJE)
return aHE
}
oDE.wxXCkey=2
_2z(z,135,cEE,cUC,oTC,gg,oDE,'li','liIdx','index')
cs.pop()
cs.pop()
_(aXC,hCE)
cs.pop()
}
else if(_oz(z,143,cUC,oTC,gg)){aXC.wxVkey=10
cs.push("pages/report/report.wxml:scroll-view:119:10")
cs.push("pages/report/report.wxml:scroll-view:119:10")
var oRE=_mz(z,'scroll-view',['enhanced',-1,'scrollX',-1,'class',144,'showScrollbar',1],[],cUC,oTC,gg)
cs.push("pages/report/report.wxml:view:120:12")
var cSE=_n('view')
_rz(z,cSE,'class',146,cUC,oTC,gg)
cs.push("pages/report/report.wxml:view:121:14")
var oTE=_n('view')
_rz(z,oTE,'class',147,cUC,oTC,gg)
var lUE=_v()
_(oTE,lUE)
cs.push("pages/report/report.wxml:view:122:16")
var aVE=function(eXE,tWE,bYE,gg){
cs.push("pages/report/report.wxml:view:122:16")
var x1E=_n('view')
_rz(z,x1E,'class',151,eXE,tWE,gg)
cs.push("pages/report/report.wxml:text:123:18")
var o2E=_n('text')
o2E.attr['userSelect']=true
var f3E=_v()
_(o2E,f3E)
cs.push("pages/report/report.wxml:template:123:36")
var c4E=_oz(z,153,eXE,tWE,gg)
var h5E=_gd(x[0],c4E,e_,d_)
if(h5E){
var o6E=_1z(z,152,eXE,tWE,gg) || {}
var cur_globalf=gg.f
f3E.wxXCkey=3
h5E(o6E,o6E,f3E,gg)
gg.f=cur_globalf
}
else _w(c4E,x[0],123,48)
cs.pop()
cs.pop()
_(x1E,o2E)
cs.pop()
_(bYE,x1E)
return bYE
}
lUE.wxXCkey=2
_2z(z,149,aVE,cUC,oTC,gg,lUE,'cell','index','index')
cs.pop()
cs.pop()
_(cSE,oTE)
var c7E=_v()
_(cSE,c7E)
cs.push("pages/report/report.wxml:view:126:14")
var o8E=function(a0E,l9E,tAF,gg){
cs.push("pages/report/report.wxml:view:126:14")
var bCF=_n('view')
_rz(z,bCF,'class',157,a0E,l9E,gg)
var oDF=_v()
_(bCF,oDF)
cs.push("pages/report/report.wxml:view:127:16")
var xEF=function(fGF,oFF,cHF,gg){
cs.push("pages/report/report.wxml:view:127:16")
var oJF=_n('view')
_rz(z,oJF,'class',161,fGF,oFF,gg)
cs.push("pages/report/report.wxml:text:128:18")
var cKF=_n('text')
cKF.attr['userSelect']=true
var oLF=_v()
_(cKF,oLF)
cs.push("pages/report/report.wxml:template:128:36")
var lMF=_oz(z,163,fGF,oFF,gg)
var aNF=_gd(x[0],lMF,e_,d_)
if(aNF){
var tOF=_1z(z,162,fGF,oFF,gg) || {}
var cur_globalf=gg.f
oLF.wxXCkey=3
aNF(tOF,tOF,oLF,gg)
gg.f=cur_globalf
}
else _w(lMF,x[0],128,48)
cs.pop()
cs.pop()
_(oJF,cKF)
cs.pop()
_(cHF,oJF)
return cHF
}
oDF.wxXCkey=2
_2z(z,159,xEF,a0E,l9E,gg,oDF,'cell','index','index')
cs.pop()
cs.pop()
_(tAF,bCF)
return tAF
}
c7E.wxXCkey=2
_2z(z,155,o8E,cUC,oTC,gg,c7E,'row','index','index')
cs.pop()
cs.pop()
_(oRE,cSE)
cs.pop()
_(aXC,oRE)
cs.pop()
}
aXC.wxXCkey=1
cs.pop()
return oVC
}
cRC.wxXCkey=2
_2z(z,89,hSC,e,s,gg,cRC,'b','index','index')
cs.pop()
cs.pop()
_(bMC,fQC)
cs.push("pages/report/report.wxml:view:136:6")
var ePF=_mz(z,'view',['bindtap',164,'class',1],[],e,s,gg)
var bQF=_oz(z,166,e,s,gg)
_(ePF,bQF)
cs.pop()
_(bMC,ePF)
var oNC=_v()
_(bMC,oNC)
if(_oz(z,167,e,s,gg)){oNC.wxVkey=1
cs.push("pages/report/report.wxml:view:138:6")
cs.push("pages/report/report.wxml:view:138:6")
var oRF=_mz(z,'view',['bindtap',168,'class',1,'hoverClass',2],[],e,s,gg)
cs.push("pages/report/report.wxml:text:139:8")
var xSF=_n('text')
_rz(z,xSF,'class',171,e,s,gg)
var oTF=_oz(z,172,e,s,gg)
_(xSF,oTF)
cs.pop()
_(oRF,xSF)
cs.push("pages/report/report.wxml:text:140:8")
var fUF=_n('text')
_rz(z,fUF,'class',173,e,s,gg)
var cVF=_oz(z,174,e,s,gg)
_(fUF,cVF)
cs.pop()
_(oRF,fUF)
cs.pop()
_(oNC,oRF)
cs.pop()
}
oNC.wxXCkey=1
cs.pop()
_(cI,bMC)
cs.pop()
}
cs.push("pages/report/report.wxml:view:144:4")
var hWF=_n('view')
_rz(z,hWF,'class',175,e,s,gg)
cs.pop()
_(fE,hWF)
cF.wxXCkey=1
hG.wxXCkey=1
oH.wxXCkey=1
cI.wxXCkey=1
cs.pop()
_(oB,fE)
cs.pop()
}
var xC=_v()
_(r,xC)
if(_oz(z,176,e,s,gg)){xC.wxVkey=1
cs.push("pages/report/report.wxml:view:148:2")
cs.push("pages/report/report.wxml:view:148:2")
var oXF=_n('view')
_rz(z,oXF,'class',177,e,s,gg)
var cYF=_v()
_(oXF,cYF)
if(_oz(z,178,e,s,gg)){cYF.wxVkey=1
cs.push("pages/report/report.wxml:view:149:4")
cs.push("pages/report/report.wxml:view:149:4")
var a2F=_n('view')
_rz(z,a2F,'class',179,e,s,gg)
cs.push("pages/report/report.wxml:view:150:6")
var t3F=_n('view')
_rz(z,t3F,'class',180,e,s,gg)
var e4F=_oz(z,181,e,s,gg)
_(t3F,e4F)
cs.pop()
_(a2F,t3F)
cs.push("pages/report/report.wxml:view:151:6")
var b5F=_n('view')
_rz(z,b5F,'class',182,e,s,gg)
var o6F=_oz(z,183,e,s,gg)
_(b5F,o6F)
cs.pop()
_(a2F,b5F)
cs.pop()
_(cYF,a2F)
cs.pop()
}
var oZF=_v()
_(oXF,oZF)
if(_oz(z,184,e,s,gg)){oZF.wxVkey=1
cs.push("pages/report/report.wxml:view:153:4")
cs.push("pages/report/report.wxml:view:153:4")
var x7F=_n('view')
_rz(z,x7F,'class',185,e,s,gg)
cs.push("pages/report/report.wxml:view:154:6")
var o8F=_n('view')
_rz(z,o8F,'class',186,e,s,gg)
var f9F=_oz(z,187,e,s,gg)
_(o8F,f9F)
cs.pop()
_(x7F,o8F)
cs.push("pages/report/report.wxml:view:155:6")
var c0F=_n('view')
_rz(z,c0F,'class',188,e,s,gg)
var hAG=_oz(z,189,e,s,gg)
_(c0F,hAG)
cs.pop()
_(x7F,c0F)
cs.pop()
_(oZF,x7F)
cs.pop()
}
var l1F=_v()
_(oXF,l1F)
if(_oz(z,190,e,s,gg)){l1F.wxVkey=1
cs.push("pages/report/report.wxml:button:157:4")
cs.push("pages/report/report.wxml:button:157:4")
var oBG=_mz(z,'button',['bindtap',191,'class',1,'disabled',2,'hoverClass',3],[],e,s,gg)
var cCG=_oz(z,195,e,s,gg)
_(oBG,cCG)
cs.pop()
_(l1F,oBG)
cs.pop()
}
else{l1F.wxVkey=2
cs.push("pages/report/report.wxml:button:164:4")
cs.push("pages/report/report.wxml:button:164:4")
var oDG=_mz(z,'button',['bindtap',196,'class',1,'disabled',2,'hoverClass',3],[],e,s,gg)
var lEG=_oz(z,200,e,s,gg)
_(oDG,lEG)
cs.pop()
_(l1F,oDG)
cs.pop()
}
cYF.wxXCkey=1
oZF.wxXCkey=1
l1F.wxXCkey=1
cs.pop()
_(xC,oXF)
cs.pop()
}
else{xC.wxVkey=2
cs.push("pages/report/report.wxml:view:174:2")
cs.push("pages/report/report.wxml:view:174:2")
var aFG=_n('view')
_rz(z,aFG,'class',201,e,s,gg)
cs.push("pages/report/report.wxml:view:175:4")
var tGG=_n('view')
_rz(z,tGG,'class',202,e,s,gg)
var eHG=_v()
_(tGG,eHG)
if(_oz(z,203,e,s,gg)){eHG.wxVkey=1
cs.push("pages/report/report.wxml:view:176:6")
cs.push("pages/report/report.wxml:view:176:6")
var bIG=_n('view')
cs.push("pages/report/report.wxml:view:177:8")
var oJG=_n('view')
_rz(z,oJG,'class',204,e,s,gg)
var xKG=_oz(z,205,e,s,gg)
_(oJG,xKG)
cs.pop()
_(bIG,oJG)
cs.push("pages/report/report.wxml:view:178:8")
var oLG=_n('view')
_rz(z,oLG,'class',206,e,s,gg)
cs.push("pages/report/report.wxml:view:179:10")
var fMG=_n('view')
_rz(z,fMG,'class',207,e,s,gg)
cs.pop()
_(oLG,fMG)
cs.push("pages/report/report.wxml:view:179:45")
var cNG=_n('view')
_rz(z,cNG,'class',208,e,s,gg)
cs.pop()
_(oLG,cNG)
cs.push("pages/report/report.wxml:view:179:76")
var hOG=_n('view')
_rz(z,hOG,'class',209,e,s,gg)
cs.pop()
_(oLG,hOG)
cs.pop()
_(bIG,oLG)
cs.pop()
_(eHG,bIG)
cs.pop()
}
else{eHG.wxVkey=2
cs.push("pages/report/report.wxml:view:182:6")
cs.push("pages/report/report.wxml:view:182:6")
var oPG=_n('view')
cs.push("pages/report/report.wxml:view:183:8")
var cQG=_n('view')
_rz(z,cQG,'class',210,e,s,gg)
var oRG=_oz(z,211,e,s,gg)
_(cQG,oRG)
cs.pop()
_(oPG,cQG)
cs.push("pages/report/report.wxml:button:184:8")
var lSG=_mz(z,'button',['bindtap',212,'class',1,'hoverClass',2],[],e,s,gg)
var aTG=_oz(z,215,e,s,gg)
_(lSG,aTG)
cs.pop()
_(oPG,lSG)
cs.pop()
_(eHG,oPG)
cs.pop()
}
eHG.wxXCkey=1
cs.pop()
_(aFG,tGG)
cs.pop()
_(xC,aFG)
cs.pop()
}
oB.wxXCkey=1
xC.wxXCkey=1
return r
}
e_[x[0]]={f:m0,j:[],i:[],ti:[],ic:[]}
if(path&&e_[path]){
window.__wxml_comp_version__=0.02
return function(env,dd,global){$gwxc=0;var root={"tag":"wx-page"};root.children=[]
var main=e_[path].f
cs=[]
if (typeof global==="undefined")global={};global.f=$gdc(f_[path],"",1);
if(typeof(window.__webview_engine_version__)!='undefined'&&window.__webview_engine_version__+1e-6>=0.02+1e-6&&window.__mergeData__)
{
env=window.__mergeData__(env,dd);
}
try{
main(env,{},root,global);
_tsd(root)
if(typeof(window.__webview_engine_version__)=='undefined'|| window.__webview_engine_version__+1e-6<0.01+1e-6){return _ev(root);}
}catch(err){
console.log(cs, env);
console.log(err)
throw err
}
return root;
}
}
}

