.class public final Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1$onComplete$lister$1;
.super Ljava/lang/Object;
.source "OfflineRecgManger.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1;->onComplete()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0019\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0002*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0008\u0010\u0006\u001a\u00020\u0003H\u0016\u00a8\u0006\u0007"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1$onComplete$lister$1",
        "Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;",
        "onComplete",
        "",
        "filePath",
        "",
        "onFail",
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

.field final synthetic $isResumed:Lkotlin/jvm/internal/Ref$BooleanRef;

.field final synthetic $it:Lkotlinx/coroutines/CancellableContinuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlinx/coroutines/CancellableContinuation<",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>(Lkotlin/jvm/internal/Ref$BooleanRef;Lkotlinx/coroutines/CancellableContinuation;Ljava/lang/String;)V
    .locals 0
    .param p1, "$isResumed"    # Lkotlin/jvm/internal/Ref$BooleanRef;
    .param p2, "$it"    # Lkotlinx/coroutines/CancellableContinuation;
    .param p3, "$filePath"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/internal/Ref$BooleanRef;",
            "Lkotlinx/coroutines/CancellableContinuation<",
            "-",
            "Ljava/lang/Boolean;",
            ">;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1$onComplete$lister$1;->$isResumed:Lkotlin/jvm/internal/Ref$BooleanRef;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1$onComplete$lister$1;->$it:Lkotlinx/coroutines/CancellableContinuation;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1$onComplete$lister$1;->$filePath:Ljava/lang/String;

    .line 261
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCancel()V
    .locals 0

    .line 261
    invoke-static {p0}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener$DefaultImpls;->onCancel(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;)V

    return-void
.end method

.method public onComplete(Ljava/lang/String;)V
    .locals 3
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 263
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " sendFile onComplete  "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "OfflineRecgManger"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 264
    invoke-static {p1}, Lcom/blankj/utilcode/util/FileUtils;->delete(Ljava/lang/String;)Z

    .line 265
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1$onComplete$lister$1;->$isResumed:Lkotlin/jvm/internal/Ref$BooleanRef;

    iget-boolean v0, v0, Lkotlin/jvm/internal/Ref$BooleanRef;->element:Z

    if-nez v0, :cond_0

    .line 266
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1$onComplete$lister$1;->$isResumed:Lkotlin/jvm/internal/Ref$BooleanRef;

    const/4 v1, 0x1

    iput-boolean v1, v0, Lkotlin/jvm/internal/Ref$BooleanRef;->element:Z

    .line 267
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1$onComplete$lister$1;->$it:Lkotlinx/coroutines/CancellableContinuation;

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Lkotlinx/coroutines/CancellableContinuation;->resume(Ljava/lang/Object;Lkotlin/jvm/functions/Function1;)V

    .line 269
    :cond_0
    return-void
.end method

.method public onFail()V
    .locals 4

    .line 272
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1$onComplete$lister$1;->$filePath:Ljava/lang/String;

    invoke-static {v0}, Lcom/blankj/utilcode/util/FileUtils;->delete(Ljava/lang/String;)Z

    .line 273
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " sendFile onFail "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1$onComplete$lister$1;->$filePath:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "OfflineRecgManger"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 274
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1$onComplete$lister$1;->$it:Lkotlinx/coroutines/CancellableContinuation;

    const/4 v1, 0x0

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Lkotlinx/coroutines/CancellableContinuation;->resume(Ljava/lang/Object;Lkotlin/jvm/functions/Function1;)V

    .line 275
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1$onComplete$lister$1;->$isResumed:Lkotlin/jvm/internal/Ref$BooleanRef;

    iget-boolean v0, v0, Lkotlin/jvm/internal/Ref$BooleanRef;->element:Z

    if-nez v0, :cond_0

    .line 276
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1$onComplete$lister$1;->$isResumed:Lkotlin/jvm/internal/Ref$BooleanRef;

    const/4 v3, 0x1

    iput-boolean v3, v0, Lkotlin/jvm/internal/Ref$BooleanRef;->element:Z

    .line 277
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1$onComplete$lister$1;->$it:Lkotlinx/coroutines/CancellableContinuation;

    invoke-interface {v0, v1, v2}, Lkotlinx/coroutines/CancellableContinuation;->resume(Ljava/lang/Object;Lkotlin/jvm/functions/Function1;)V

    .line 279
    :cond_0
    return-void
.end method

.method public onProgressChanged(F)V
    .locals 0
    .param p1, "progress"    # F

    .line 261
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener$DefaultImpls;->onProgressChanged(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;F)V

    return-void
.end method

.method public onProgressChanged(FJJ)V
    .locals 0
    .param p1, "progress"    # F
    .param p2, "transferredBytes"    # J
    .param p4, "totalBytes"    # J

    .line 261
    invoke-static/range {p0 .. p5}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener$DefaultImpls;->onProgressChanged(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;FJJ)V

    return-void
.end method

.method public onStart()V
    .locals 0

    .line 261
    invoke-static {p0}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener$DefaultImpls;->onStart(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;)V

    return-void
.end method
