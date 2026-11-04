.class public final Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1$1;
.super Ljava/lang/Object;
.source "HgIdentificationServiceImpl.kt"

# interfaces
.implements Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000!\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u0003\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0008\u0010\u0002\u001a\u00020\u0003H\u0016J\u0008\u0010\u0004\u001a\u00020\u0003H\u0016J\u0008\u0010\u0005\u001a\u00020\u0003H\u0016J\u0010\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0007\u001a\u00020\u0008H\u0016J\u0010\u0010\t\u001a\u00020\u00032\u0006\u0010\n\u001a\u00020\u000bH\u0016\u00a8\u0006\u000c"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1$1",
        "Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;",
        "onClosed",
        "",
        "onComplete",
        "onConnected",
        "onError",
        "t",
        "",
        "onMessage",
        "data",
        "",
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
.field final synthetic $imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $isModify:Lkotlin/jvm/internal/Ref$BooleanRef;

.field final synthetic $requestQuestionId:Ljava/lang/String;

.field final synthetic $terminalHandled:Ljava/util/concurrent/atomic/AtomicBoolean;


# direct methods
.method constructor <init>(Ljava/lang/String;Lkotlin/jvm/internal/Ref$BooleanRef;Ljava/util/concurrent/atomic/AtomicBoolean;Lkotlin/jvm/internal/Ref$ObjectRef;)V
    .locals 0
    .param p1, "$requestQuestionId"    # Ljava/lang/String;
    .param p2, "$isModify"    # Lkotlin/jvm/internal/Ref$BooleanRef;
    .param p3, "$terminalHandled"    # Ljava/util/concurrent/atomic/AtomicBoolean;
    .param p4, "$imageUrl"    # Lkotlin/jvm/internal/Ref$ObjectRef;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lkotlin/jvm/internal/Ref$BooleanRef;",
            "Ljava/util/concurrent/atomic/AtomicBoolean;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1$1;->$requestQuestionId:Ljava/lang/String;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1$1;->$isModify:Lkotlin/jvm/internal/Ref$BooleanRef;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1$1;->$terminalHandled:Ljava/util/concurrent/atomic/AtomicBoolean;

    iput-object p4, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1$1;->$imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;

    .line 449
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClosed()V
    .locals 5

    .line 473
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onClosed"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 474
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1$1;->$terminalHandled:Ljava/util/concurrent/atomic/AtomicBoolean;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1$1;->$requestQuestionId:Ljava/lang/String;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1$1;->$imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1$1;->$isModify:Lkotlin/jvm/internal/Ref$BooleanRef;

    const-string v4, "closed"

    invoke-static {v0, v1, v2, v3, v4}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->access$invokeSuspend$finishIdentificationOnce(Ljava/util/concurrent/atomic/AtomicBoolean;Ljava/lang/String;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$BooleanRef;Ljava/lang/String;)V

    .line 475
    return-void
.end method

.method public onComplete()V
    .locals 5

    .line 463
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onComplete"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 464
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1$1;->$terminalHandled:Ljava/util/concurrent/atomic/AtomicBoolean;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1$1;->$requestQuestionId:Ljava/lang/String;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1$1;->$imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1$1;->$isModify:Lkotlin/jvm/internal/Ref$BooleanRef;

    const-string v4, "complete"

    invoke-static {v0, v1, v2, v3, v4}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->access$invokeSuspend$finishIdentificationOnce(Ljava/util/concurrent/atomic/AtomicBoolean;Ljava/lang/String;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$BooleanRef;Ljava/lang/String;)V

    .line 465
    return-void
.end method

.method public onConnected()V
    .locals 2

    .line 451
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onConnected"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 452
    return-void
.end method

.method public onError(Ljava/lang/Throwable;)V
    .locals 3
    .param p1, "t"    # Ljava/lang/Throwable;

    const-string/jumbo v0, "t"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 468
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onError"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 469
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1$1;->$terminalHandled:Ljava/util/concurrent/atomic/AtomicBoolean;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1$1;->$requestQuestionId:Ljava/lang/String;

    const-string/jumbo v2, "transport_error"

    invoke-static {v0, v1, v2}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->access$invokeSuspend$failIdentificationOnce(Ljava/util/concurrent/atomic/AtomicBoolean;Ljava/lang/String;Ljava/lang/String;)V

    .line 470
    return-void
.end method

.method public onMessage(Ljava/lang/String;)V
    .locals 3
    .param p1, "data"    # Ljava/lang/String;

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 455
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onMessage"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 456
    sget-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1$1;->$requestQuestionId:Ljava/lang/String;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1$1;->$isModify:Lkotlin/jvm/internal/Ref$BooleanRef;

    iget-boolean v2, v2, Lkotlin/jvm/internal/Ref$BooleanRef;->element:Z

    invoke-static {v0, v1, p1, v2}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->access$handleAiMessage(Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 457
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1$1;->$terminalHandled:Ljava/util/concurrent/atomic/AtomicBoolean;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1$1;->$requestQuestionId:Ljava/lang/String;

    const-string v2, "backend_error"

    invoke-static {v0, v1, v2}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->access$invokeSuspend$failIdentificationOnce(Ljava/util/concurrent/atomic/AtomicBoolean;Ljava/lang/String;Ljava/lang/String;)V

    .line 460
    :cond_0
    return-void
.end method
