.class public final Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1;
.super Ljava/lang/Object;
.source "OfflineRecgManger.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->downloadLibBin(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;Ljava/lang/String;Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\'\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\t\n\u0002\u0008\u0003*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0008\u0010\u0002\u001a\u00020\u0003H\u0016J\u0014\u0010\u0004\u001a\u00020\u00032\n\u0010\u0005\u001a\u00060\u0006j\u0002`\u0007H\u0016J\u0018\u0010\u0008\u001a\u00020\u00032\u0006\u0010\t\u001a\u00020\n2\u0006\u0010\u000b\u001a\u00020\nH\u0016J\u0008\u0010\u000c\u001a\u00020\u0003H\u0016\u00a8\u0006\r"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1",
        "Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;",
        "onComplete",
        "",
        "onError",
        "e",
        "Ljava/lang/Exception;",
        "Lkotlin/Exception;",
        "onProgress",
        "bytesRead",
        "",
        "contentLength",
        "onStart",
        "sdk-server_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field final synthetic $filePath:Ljava/lang/String;

.field final synthetic $it:Lkotlinx/coroutines/CancellableContinuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlinx/coroutines/CancellableContinuation<",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $libInfo:Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;

.field final synthetic $sceneId:Ljava/lang/String;

.field final synthetic $sn:Ljava/lang/String;


# direct methods
.method constructor <init>(Lkotlinx/coroutines/CancellableContinuation;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "$it"    # Lkotlinx/coroutines/CancellableContinuation;
    .param p2, "$filePath"    # Ljava/lang/String;
    .param p3, "$libInfo"    # Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;
    .param p4, "$sn"    # Ljava/lang/String;
    .param p5, "$sceneId"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlinx/coroutines/CancellableContinuation<",
            "-",
            "Ljava/lang/Boolean;",
            ">;",
            "Ljava/lang/String;",
            "Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1;->$it:Lkotlinx/coroutines/CancellableContinuation;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1;->$filePath:Ljava/lang/String;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1;->$libInfo:Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;

    iput-object p4, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1;->$sn:Ljava/lang/String;

    iput-object p5, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1;->$sceneId:Ljava/lang/String;

    .line 236
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onComplete()V
    .locals 10

    .line 248
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " downloadLibBin onComplete "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1;->$filePath:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "OfflineRecgManger"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 249
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1;->$filePath:Ljava/lang/String;

    invoke-static {v0}, Lcom/blankj/utilcode/util/FileUtils;->getFileMD5ToString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 251
    .local v0, "fileMd5":Ljava/lang/String;
    nop

    .line 252
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, " getFileMD5 fileMd5 = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "fileMd5"

    invoke-static {v0, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sget-object v3, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v3}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v3

    const-string/jumbo v4, "this as java.lang.String).toLowerCase(Locale.ROOT)"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " binMd5 = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1;->$libInfo:Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;->getBinMd5()Ljava/lang/String;

    move-result-object v3

    sget-object v5, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v3, v5}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    .line 250
    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 254
    move-object v2, v0

    check-cast v2, Ljava/lang/CharSequence;

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    const/4 v3, 0x0

    if-lez v2, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    move v2, v3

    :goto_0
    if-eqz v2, :cond_1

    .line 255
    sget-object v2, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v2, Ljava/lang/CharSequence;

    .line 256
    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1;->$libInfo:Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;

    invoke-virtual {v5}, Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;->getBinMd5()Ljava/lang/String;

    move-result-object v5

    sget-object v6, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v5, v6}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v5, Ljava/lang/CharSequence;

    .line 254
    invoke-static {v2, v5}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 260
    new-instance v1, Lkotlin/jvm/internal/Ref$BooleanRef;

    invoke-direct {v1}, Lkotlin/jvm/internal/Ref$BooleanRef;-><init>()V

    .line 261
    .local v1, "isResumed":Lkotlin/jvm/internal/Ref$BooleanRef;
    new-instance v2, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1$onComplete$lister$1;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1;->$it:Lkotlinx/coroutines/CancellableContinuation;

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1;->$filePath:Ljava/lang/String;

    invoke-direct {v2, v1, v3, v4}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1$onComplete$lister$1;-><init>(Lkotlin/jvm/internal/Ref$BooleanRef;Lkotlinx/coroutines/CancellableContinuation;Ljava/lang/String;)V

    .line 281
    .local v2, "lister":Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1$onComplete$lister$1;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->getBtFileOperater()Lcom/rokid/security/phone/sdk/api/msg/api/IFileOperate;

    move-result-object v3

    .line 282
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "feature/"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1;->$sn:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const/16 v5, 0x2f

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v6, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1;->$sceneId:Ljava/lang/String;

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-instance v5, Ljava/io/File;

    iget-object v6, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1;->$filePath:Ljava/lang/String;

    invoke-direct {v5, v6}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    move-object v6, v2

    check-cast v6, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    new-instance v7, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1$onComplete$1;

    iget-object v8, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1;->$filePath:Ljava/lang/String;

    iget-object v9, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1;->$it:Lkotlinx/coroutines/CancellableContinuation;

    invoke-direct {v7, v8, v1, v9}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1$onComplete$1;-><init>(Ljava/lang/String;Lkotlin/jvm/internal/Ref$BooleanRef;Lkotlinx/coroutines/CancellableContinuation;)V

    check-cast v7, Lkotlin/jvm/functions/Function1;

    invoke-interface {v3, v4, v5, v6, v7}, Lcom/rokid/security/phone/sdk/api/msg/api/IFileOperate;->sendFile(Ljava/lang/String;Ljava/io/File;Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;)V

    .line 299
    .end local v1    # "isResumed":Lkotlin/jvm/internal/Ref$BooleanRef;
    .end local v2    # "lister":Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1$onComplete$lister$1;
    return-void

    .line 295
    :cond_1
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1;->$it:Lkotlinx/coroutines/CancellableContinuation;

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    const/4 v4, 0x0

    invoke-interface {v2, v3, v4}, Lkotlinx/coroutines/CancellableContinuation;->resume(Ljava/lang/Object;Lkotlin/jvm/functions/Function1;)V

    .line 296
    const-string v2, " sendFile fileMd5 \u4e0d\u4e00\u81f4"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 297
    return-void
.end method

.method public onError(Ljava/lang/Exception;)V
    .locals 3
    .param p1, "e"    # Ljava/lang/Exception;

    const-string v0, "e"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 242
    const-string v0, " downloadLibBin onStart"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "OfflineRecgManger"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 243
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1;->$it:Lkotlinx/coroutines/CancellableContinuation;

    const/4 v1, 0x0

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Lkotlinx/coroutines/CancellableContinuation;->resume(Ljava/lang/Object;Lkotlin/jvm/functions/Function1;)V

    .line 244
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1;->$filePath:Ljava/lang/String;

    invoke-static {v0}, Lcom/blankj/utilcode/util/FileUtils;->delete(Ljava/lang/String;)Z

    .line 245
    return-void
.end method

.method public onProgress(JJ)V
    .locals 0
    .param p1, "bytesRead"    # J
    .param p3, "contentLength"    # J

    .line 303
    return-void
.end method

.method public onStart()V
    .locals 2

    .line 238
    const-string v0, " downloadLibBin onStart"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "OfflineRecgManger"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 239
    return-void
.end method
