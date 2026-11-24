# -*- coding: utf-8 -*-
"""Verify evidence snippets exist verbatim in the bundles and are <=400 chars."""
import io
import sys

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
B = "E:/AI-Station/逆向工程/shipinhao-reverse/work/bundles/"

CHECKS = [
    ("404.3c829d34.js", 'super({baseURL:i||t||"/cgi-bin/mmfinderassistant-bin"'),
    ("404.3c829d34.js", '{name:"uploadParams",path:"/helper/helper_upload_params"}'),
    ("404.3c829d34.js", 'async getUploadParams(){return await this.post({url:this.getApiUrl("uploadParams")})}'),
    ("index.b1f5e380.js", 'async getUploadParams(){if(N.authParams)return N.authParams;let e=await a.ZP.postService.getUploadParams();return e&&e.data&&(N.setAuthParams(e.data),this.uploadParams=e.data,this.uploadParams.normalFile=20310,this.fakeUin=e.data.uin),e}'),
    ("index.b1f5e380.js", 'N.setHost(i.envInfo.cdnHost)'),
    ("chunk-common.ec025662.js", 'key:"getUploadHeader",value:function(e){var t=e.file,n=e.uuid,r=e.md5,o=e.cdnFileType,i=this.authParams,a="apptype=".concat(i.appType,"&filetype=").concat(i[o],"&weixinnum=").concat(i.uin,"&filekey=").concat(encodeURIComponent(t.name),"&filesize=").concat(t.size,"&taskid=").concat(n,"&scene=").concat(i.scene||0);'),
    ("chunk-common.ec025662.js", '.concat(encodeURIComponent(t.name),"&filesize=").concat(t.size,"&taskid=").concat(n,"&scene=").concat(i.scene||0);return i.disKey&&void 0!==i.disTime&&i.ext&&(a+="&dis_k=".concat(i.disKey,"&dis_t=").concat(i.disTime,"&ext=").concat(i.ext)),{Authorization:i.authKey,"X-Arguments":a,"Content-MD5":r||"null"}}'),
    ("chunk-common.ec025662.js", 'key:"uploadChunkUrl",value:function(e,t){var n,r,o,i=arguments.length>2&&void 0!==arguments[2]?arguments[2]:h.c.Normal,a=(this.useBackUpHost?null==(n=d.b.envInfo)?void 0:n.spareCdnHostList:null==(r=d.b.envInfo)?void 0:r.cdnHostList)||[]'),
    ("chunk-common.ec025662.js", 's=(null==a?void 0:a.length)?a[Math.floor(Math.random()*a.length)]:null==(o=d.b.envInfo)?void 0:o.cdnHost;return"//".concat(s||this.HOST,"/uploadpartdfs?PartNumber=").concat(e,"&UploadID=").concat(t,"&QuickUpload=").concat(i)}'),
    ("chunk-common.ec025662.js", '{key:"uploadChunk",value:function(e){var t=this;if(!(null==e?void 0:e.chunk))return Promise.reject(Error("chunk is empty"));var n=e.chunk,r=e.file,o=e.uuid,i=e.uploadProgressCallBack,a=this.authParams,s=this.uploadChunkUrl(e.chunkIndex+1,e.uploadId,e.quickUpload?h.c.Quick:h.c.Normal),u=this.getUploadHeader(e);'),
    ("chunk-common.ec025662.js", 'v={timeout:121e3,timeoutErrorMessage:"response timeout",cancelToken:p.token,headers:Object.assign({},u,{"Content-Type":"application/octet-stream"}),onUploadProgress:function(e){i&&i(Object.assign({delta:e.loaded-m})),m=e.loaded}};c.a.put(s,n,v)'),
    ("chunk-common.ec025662.js", 'T(this,"HOST","https://finderpre.video.qq.com"),T(this,"tIdList",[])'),
    ("chunk-common.ec025662.js", '{key:"setHost",value:function(e){this.HOST="//".concat(e)}}'),
    ("chunk-common.ec025662.js", 'key:"uploadCompleteUrl",value:function(e){return"".concat(this.HOST,"/completepartuploaddfs?UploadID=").concat(e)}},{key:"confirmChunkUrl",value:function(e,t){return"".concat(this.HOST,"/applyuploaddfs?UploadID=").concat(e,"&PartNumberMarker=").concat(t)}}'),
    ("chunk-common.ec025662.js", 'singleUploadUrl",get:function(){return"".concat(this.HOST,"/simpleuploaddfs")}},{key:"getUploadIdUrl",get:function(){return"".concat(this.HOST,"/applyuploaddfs")}}]),e}();T(E,"ReplaceHost","https://finder.video.qq.com")'),
    ("chunk-common.ec025662.js", 'T(this,"singleFileSize",0xa00000),T(this,"cdnFileType",void 0),T(this,"chunkSize",1024*(Number(localStorage.getItem(p.b))||8)*1024),T(this,"ConcurrentLimit",Number(localStorage.getItem(p.a))||4),T(this,"ReuseInfoLimit",5)'),
    ("chunk-common.ec025662.js", 'T(this,"uploadTaskIdExpiredTimeout",858e5)'),
    ("chunk-common.ec025662.js", 'key:"getUploadId",value:function(e,t){return c.a.put(this.getUploadIdUrl,e,{headers:t})}'),
    ("chunk-common.ec025662.js", 'getUploadId({BlockSum:this.chunkCount,BlockPartLength:Array(this.chunkCount).fill(1).map(function(e,t){var n=(t+1)*a.chunkSize;return n>a.file.size?a.file.size:n})},t)'),
    ("chunk-common.ec025662.js", 'throw new l.LogicError("Error_No_UploadId;".concat(this.uuid,";").concat(JSON.stringify(n)),"upload");case 9:e.next=16;break;'),
    ("chunk-common.ec025662.js", 'case 16:this.uploadTaskId=n.data.UploadID,this.uploadTaskIdTimeStamp=Date.now();case 18:case"end":return e.stop()'),
    ("chunk-common.ec025662.js", 'var p=(null==(i=o.data)?void 0:i["X-Errno"])===0;if(!b&&!(null==o||null==(a=o.data)?void 0:a.TransFlag)||!b&&!p)throw new l.LogicError(o,"upload");return(p&&(n.uploadChunkRecord[y].success=!0),(null==(s=o.data)?void 0:s.TransFlag)&&(n.transFlag=null==(u=o.data)?void 0:u.TransFlag)'),
    ("chunk-common.ec025662.js", 'n.partInfo[r]={PartNumber:r+1,ETag:null==(d=o.data)?void 0:d.ETag}'),
    ("687.d60c19be.js", 'H=class e extends x{constructor(e,t,r={}){super(e,r),this.scene=t,this.name="LogicError"}'),
    ("chunk-common.ec025662.js", 'y=n.addUploadRecord({index:r,reqTime:Date.now(),resTime:0,cost:0,success:!1}),b=n.shouldUseQuickChunkUpload(r);'),
    ("chunk-common.ec025662.js", 'key:"fileUploadedInfo",get:function(){return{fileUploadedInfoKey:this.fileUploadedInfoKey,isUsedQuickUpload:this.isUsedQuickUpload,uploadChunkRecord:this.uploadChunkRecord,uuid:this.uuid,uploadTaskId:this.uploadTaskId,uploadTaskIdTimeStamp:this.uploadTaskIdTimeStamp,transFlag:this.transFlag,partInfo:this.partInfo,uploadSuccessResp:this.uploadSuccessResp}}'),
    ("chunk-common.ec025662.js", 'key:"fileUploadedInfoKey",get:function(){return"".concat(this.file.name,":").concat(this.file.lastModified,":").concat(this.file.size,":").concat(this.file.type,":").concat(this.md5)}'),
    ("chunk-common.ec025662.js", 'key:"addUploadRecord",value:function(e){var t=this.uploadChunkRecord.findIndex(function(t){return t.index===e.index});return t>-1?(this.uploadChunkRecord[t]=e,t):(this.uploadChunkRecord.push(e),this.uploadChunkRecord.length-1)}'),
    ("chunk-common.ec025662.js", 'key:"uploadedInfoStorageKeyByUin",get:function(){var e=L.getUserUin();return"".concat(p.s,"_").concat(e)}}'),
    ("chunk-common.ec025662.js", '_="AssistantUploadBackUpFlag",w="AssistantDebugUploadChunkSize",S="AssistantDebugUploadChunkConcurrentLimit",x="AssistantUploadedInfoStorageKey"'),
    ("chunk-common.ec025662.js", 'localStorage.setItem(this.uploadedInfoStorageKeyByUin,JSON.stringify(t))'),
    ("chunk-common.ec025662.js", 'key:"shouldUseQuickChunkUpload",value:function(e){return!(0===e||e>this.chunkCount-this.ConcurrentLimit)}}'),
    ("chunk-common.ec025662.js", 'this.isBigFile?Array(this.ConcurrentLimit).fill(1).forEach(function(e,n){0===n?t.loadChunk():t.loadNextChunk()}):this.loadChunk()'),
    ("chunk-common.ec025662.js", 'key:"loadNextChunk",value:function(){this.curChunkIndex=this.curChunkIndex+1,this.curChunkIndex<this.chunkCount&&!this.break&&this.loadChunk()}'),
    ("chunk-common.ec025662.js", 'function(e){e[e.Quick=1]="Quick",e[e.Normal=2]="Normal",e[e.Slow=3]="Slow",e[e.BackUp=4]="BackUp"}(i||(i={})),function(e){e[e.None=1]="None",e[e.Expired=2]="Expired",e[e.ReuseByChunks=3]="ReuseByChunks",e[e.ReuseByConfirm=4]="ReuseByConfirm",e[e.ReuseByUrl=5]="ReuseByUrl"}(a||(a={}))'),
    ("chunk-common.ec025662.js", 'function(e){e[e.Confirm=0]="Confirm",e[e.Quick=1]="Quick",e[e.Normal=2]="Normal"}(c||(c={}))'),
    ("chunk-common.ec025662.js", 'n.reloadChunkTime+=1,n.uploadQueue.push(i()),e.next=24;break;case 12:if(n.strategy!==h.f.Quick){e.next=23;break}if(n.isBigFile){e.next=16;break}return u(),e.abrupt("return");case 16:c("UploadVideoByLevel2"),n.strategy=h.f.Normal,n.reloadChunkTime=0,n.curChunkIndex=n.uploadedSuccessIndex,n.loadNextChunk()'),
    ("chunk-common.ec025662.js", 'n.strategy!==h.f.Normal||L.useBackUpHost?u():(c("UploadVideoByLevel4"),n.endUpload(),n.partInfo=[],n.strategy=h.f.BackUp,L.toggleToBackUpHost(),n.reloadChunkTime=0,n.startUpload(n.uploadEventHandlerCb,!0))'),
    ("chunk-common.ec025662.js", 'key:"confirmChunks",value:function(e){var t=this.getUploadHeader(e);return c.a.put(this.confirmChunkUrl(e.uploadId,e.PartNumberMarker||""),{},{headers:t})}'),
    ("chunk-common.ec025662.js", 'key:"finishUpload",value:function(e){var t=this.getUploadHeader(e);return c.a.post(this.uploadCompleteUrl(e.uploadId),{TransFlag:e.transFlag,PartInfo:e.partInfo.filter(Boolean).sort(function(e,t){return e.PartNumber-t.PartNumber})},{headers:t})}'),
    ("chunk-common.ec025662.js", 'L.confirmChunks({file:y.file,uuid:y.uuid,uploadId:y.uploadTaskId,cdnFileType:y.cdnFileType,transFlag:y.transFlag,partInfo:y.partInfo,PartNumberMarker:s})'),
    ("chunk-common.ec025662.js", 'throw new l.LogicError("confirm upload fail: ".concat(JSON.stringify(i.data),";").concat(i.status),"upload");case 5:if(u=null==i||null==(n=i.data)?void 0:n.ListPartsResult,(r=a).push.apply(r,m(u.Part||[])),(null==u?void 0:u.IsTruncated)!=="true"){e.next=11;break}return s=u.NextPartNumberMarker,e.next=11,c()'),
    ("chunk-common.ec025662.js", 'y.partInfo[t]={PartNumber:t+1,ETag:e.ETag}'),
    ("chunk-common.ec025662.js", 'p.data.httpsUrl=p.data.DownloadURL.replace("http://wxapp.tc.qq.com",E.ReplaceHost),this.uploadSuccessResp={data:null==p?void 0:p.data},this.updateSuccessResult()'),
    ("chunk-common.ec025662.js", 'var c=function(e,t){if(e){"object"===a(e)?Object.assign(s,e):s[e]=t;var n=o.f;s.envInfo&&s.envInfo.uploadVersion&&(n=i.uploadService),s.uploadParams&&n.setAuthParams(s.uploadParams),s.cdnHost&&n.setHost(s.cdnHost)}};t.b=s'),
    ("chunk-common.ec025662.js", 'r=hF.a.video,n.isImage&&(r=hF.a.picture),o=new(fd.b.envInfo.uploadVersion?hV.default:hF.d)(n,{cdnFileType:r})'),
    ("chunk-common.ec025662.js", 'key:"setHost",value:function(e){this.HOST=e,this.URL="//".concat(this.HOST,"/snsuploadbig")}'),
    ("chunk-common.ec025662.js", 'd.append("ver","1"),d.append("seq","".concat(Math.random()+Date.now())),d.append("weixinnum","".concat(f.uin)),d.append("apptype","".concat(f.appType)),d.append("filetype","".concat(f[u])),d.append("authkey","".concat(f.authKey)),d.append("hasthumb","0"),d.append("filekey","".concat(o.name)),d.append("totalsize","".concat(o.size))'),
    ("chunk-common.ec025662.js", 'd.append("fileuuid","".concat(i)),d.append("rangestart","".concat(s)),d.append("rangeend","".concat(a)),d.append("blockmd5","".concat(c)),d.append("filedata",r),d.append("forcetranscode","0")'),
    ("chunk-common.ec025662.js", 'l.a.post(n.URL,d,{timeout:3e4,timeoutErrorMessage:"response timeout",cancelToken:c.token}).then(function(n){s=!0;var r=n.data;r.uploadfinish&&(r.httpsUrl=r.fileurl.replace("http://wxapp.tc.qq.com",e.ReplaceHost)),t(n)})'),
    ("chunk-common.ec025662.js", 'retcode,n=[-5202163,-5202156,-5202157],o="retCode: ".concat(t,";status: ").concat(e.response.status,";").concat(a,";serverip:").concat(e.response.data.serverip);if(n.includes(t))return void r({needReload:!0,bitmapstart:e.response.data.bitmapstart,errMsg:o,response:e.response})'),
    ("chunk-common.ec025662.js", 'g(this,"chunkSize",524288),g(this,"singlePackLimit",3)'),
    ("chunk-common.ec025662.js", 'x.uploadChunk({chunk:o,file:e.file,cdnFileType:e.cdnFileType,chunkStart:t,chunkEnd:n-1,uuid:e.uuid,md5:u})'),
    ("chunk-common.ec025662.js", 'YN(this,"HOST","finderpre.video.qq.com"),YN(this,"tIdList",[])'),
    ("chunk-common.ec025662.js", 'return"https://".concat(a||this.HOST.replace(/^https?:\\/\\//,""),"/uploadpartdfs?PartNumber=").concat(e,"&UploadID=").concat(t)}'),
    ("chunk-common.ec025662.js", 'YO.a.put(s,n,{headers:c,cancelToken:f.token,onUploadProgress:function(e){if(i){var t=e.loaded-h;h=e.loaded,i(Object.assign(e,{delta:t}))}}})'),
    ("chunk-common.ec025662.js", 'YO.a.get(this.confirmChunkUrl(e.uploadId,e.PartNumberMarker||""),{headers:t})'),
    ("chunk-common.ec025662.js", 'var t=this.getUploadHeader({file:e.file,cdnFileType:e.cdnFileType,uuid:e.uuid}),n={PartInfo:e.partInfo};e.transFlag&&(n.TransFlag=e.transFlag);var r=+!!e.originalUrl,o=YA(YA({},t),{},{"X-Arguments":"".concat(t["X-Arguments"],"&originalurl=").concat(r)});return YO.a.post(this.uploadCompleteUrl(e.uploadId),n,{headers:o})'),
    ("chunk-common.ec025662.js", 'YN(this,"chunkSize",8388608),YN(this,"cdnFileType",wK.a.video)'),
    ("chunk-common.ec025662.js", 'key:"loadNextChunk",value:function(){for(var e=this.strategy===wK.f.Quick?4:1;this.uploadQueue.length<e&&this.curChunkIndex<this.chunkCount&&!this.break;){var t=this.loadChunk();this.uploadQueue.push(t),this.curChunkIndex++}}}'),
    ("chunk-common.ec025662.js", 'this.uploadService.getUploadId({BlockSum:this.chunkCount,BlockPartLength:this.calculateBlockPartLengths()},n)'),
    ("chunk-common.ec025662.js", 'this.uploadTaskId=r.data.UploadID,this.reuseUploadType=r.data.ReuseUploadType||wK.d.None'),
    ("chunk-common.ec025662.js", 'n.data.httpsUrl=n.data.DownloadURL.replace("http://wxapp.tc.qq.com",YU.ReplaceHost)'),
    ("chunk-common.ec025662.js", 'function(e){e.video="videoFileType",e.picture="pictureFileType",e.thumb="thumbFileType",e.pag="pagFileType",e.zip="zipType",e.normal="normalFile"}(r||(r={}))'),
    ("chunk-common.ec025662.js", 'function(e){e[e.videoFileType=0]="videoFileType",e[e.pictureFileType=1]="pictureFileType",e[e.thumbFileType=2]="thumbFileType",e[e.pagFileType=3]="pagFileType",e[e.zipType=4]="zipType"}(s||(s={}))'),
    ("chunk-common.ec025662.js", 't.name="finder_video_img.jpeg";var r=new P(t,{cdnFileType:n});r.startUpload(function(t,n){t===h.e.success?e(n.data):t===h.e.fail&&i(n||new l.LogicError("upload img fail","upload"))})'),
    ("chunk-common.ec025662.js", 'n=w.b.envInfo.uploadVersion?g.uploadImgByCanvas:b.e'),
    ("chunk-common.ec025662.js", 'r=fd.b.envInfo.uploadVersion?hV.uploadImgByCanvas:hF.e,e.next=6,r(t,me.n.quality,hV.CdnFileType.picture)'),
    ("chunk-common.ec025662.js", 's(i,me.m.width,me.m.height,me.m.quality,hF.a.picture);case 23:return u=e.sent,e.next=26,s(i,me.q.width,me.q.height,me.q.quality,hF.a.thumb);'),
    ("chunk-common.ec025662.js", 's=fd.b.envInfo.uploadVersion?hV.compressAndUpload:hF.c'),
    ("chunk-common.ec025662.js", 'new hV.default(e,{cdnFileType:hF.a.picture}).startUpload'),
    ("chunk-common.ec025662.js", 'key:"uploadSingleFile",value:function(e,t){var n=new FormData;return n.append("file",e),c.a.put(this.singleUploadUrl,n,{timeout:3e4,timeoutErrorMessage:"response timeout",headers:t})}'),
    ("chunk-common.ec025662.js", 'r.isUndefined(e.withCredentials)||(b.withCredentials=!!e.withCredentials)'),
    ("chunk-common.ec025662.js", 'version:"0.22.0"'),
    ("chunk-common.ec025662.js", 'prototype.end=function(e){var t,n,r=this._buff'),
    ("chunk-common.ec025662.js", 'return this._finish(i,o),n=u(this._hash),e&&(n=h(n)),this.reset(),n}'),
    ("chunk-common.ec025662.js", 'function u(e){var t;for(t=0;t<e.length;t+=1)e[t]=c(e[t]);return e.join("")}'),
    ("chunk-common.ec025662.js", 'key:"getMd5",value:function(){var e=this;this.getMd5Task=new Promise(function(t,n){var r=new FileReader,o=5242880,a=5242880>e.file.size?e.file.size:o,s=e.blobSlice(0,a);'),
    ("chunk-common.ec025662.js", 'this.uuid=Object(a.a)(),this.break=!1'),
    ("chunk-common.ec025662.js", 'case 17:i===h.d.ReuseByChunks?this.chunkUpload():i===h.d.ReuseByUrl?this.handleComplete(!1):i===h.d.ReuseByConfirm&&this.handleComplete();case 18:case"end":return e.stop()}'),
    ("chunk-common.ec025662.js", 'return t?Date.now()-Number(t.uploadTaskIdTimeStamp)>this.uploadTaskIdExpiredTimeout||17228736e5>Number(t.uploadTaskIdTimeStamp)?h.d.Expired:t:h.d.None'),
    ("chunk-common.ec025662.js", '1277:function(e,t,n){}'),
]

cache = {}
bad = 0
for fn, snip in CHECKS:
    if fn not in cache:
        cache[fn] = open(B + fn, encoding="utf-8", errors="replace").read()
    d = cache[fn]
    i = d.find(snip)
    ok = i >= 0 and len(snip) <= 400
    if not ok:
        bad += 1
    print("%s | len=%d | @%s | %s" % ("OK " if ok else "BAD", len(snip), i if i >= 0 else "NOTFOUND", snip[:60]))
print("bad:", bad, "of", len(CHECKS))
