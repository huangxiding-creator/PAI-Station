.class public final Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1$1;
.super Ljava/lang/Object;
.source "GHgIdentificationServiceImpl.kt"

# interfaces
.implements Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
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
        "com/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1$1",
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
        "sdk-common-ability_release"
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

.field final synthetic $questionId:Ljava/lang/String;

.field final synthetic $terminalHandled:Ljava/util/concurrent/atomic/AtomicBoolean;


# direct methods
.method constructor <init>(Ljava/lang/String;Ljava/util/concurrent/atomic/AtomicBoolean;Lkotlin/jvm/internal/Ref$ObjectRef;)V
    .locals 0
    .param p1, "$questionId"    # Ljava/lang/String;
    .param p2, "$terminalHandled"    # Ljava/util/concurrent/atomic/AtomicBoolean;
    .param p3, "$imageUrl"    # Lkotlin/jvm/internal/Ref$ObjectRef;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/concurrent/atomic/AtomicBoolean;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1$1;->$questionId:Ljava/lang/String;

    iput-object p2, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1$1;->$terminalHandled:Ljava/util/concurrent/atomic/AtomicBoolean;

    iput-object p3, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1$1;->$imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;

    .line 181
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClosed()V
    .locals 4

    .line 205
    invoke-static {}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onClosed"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 206
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1$1;->$terminalHandled:Ljava/util/concurrent/atomic/AtomicBoolean;

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1$1;->$questionId:Ljava/lang/String;

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1$1;->$imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;

    const-string v3, "closed"

    invoke-static {v0, v1, v2, v3}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->access$invokeSuspend$finishIdentificationOnce(Ljava/util/concurrent/atomic/AtomicBoolean;Ljava/lang/String;Lkotlin/jvm/internal/Ref$ObjectRef;Ljava/lang/String;)V

    .line 207
    return-void
.end method

.method public onComplete()V
    .locals 4

    .line 195
    invoke-static {}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onComplete"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 196
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1$1;->$terminalHandled:Ljava/util/concurrent/atomic/AtomicBoolean;

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1$1;->$questionId:Ljava/lang/String;

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1$1;->$imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;

    const-string v3, "complete"

    invoke-static {v0, v1, v2, v3}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->access$invokeSuspend$finishIdentificationOnce(Ljava/util/concurrent/atomic/AtomicBoolean;Ljava/lang/String;Lkotlin/jvm/internal/Ref$ObjectRef;Ljava/lang/String;)V

    .line 197
    return-void
.end method

.method public onConnected()V
    .locals 2

    .line 183
    invoke-static {}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onConnected"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 184
    return-void
.end method

.method public onError(Ljava/lang/Throwable;)V
    .locals 3
    .param p1, "t"    # Ljava/lang/Throwable;

    const-string/jumbo v0, "t"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 200
    invoke-static {}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onError"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 201
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1$1;->$terminalHandled:Ljava/util/concurrent/atomic/AtomicBoolean;

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1$1;->$questionId:Ljava/lang/String;

    const-string/jumbo v2, "transport_error"

    invoke-static {v0, v1, v2}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->access$invokeSuspend$failIdentificationOnce(Ljava/util/concurrent/atomic/AtomicBoolean;Ljava/lang/String;Ljava/lang/String;)V

    .line 202
    return-void
.end method

.method public onMessage(Ljava/lang/String;)V
    .locals 3
    .param p1, "data"    # Ljava/lang/String;

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 187
    invoke-static {}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->access$getTAG$p()Ljava/lang/String;

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

    .line 188
    sget-object v0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1$1;->$questionId:Ljava/lang/String;

    invoke-static {v0, v1, p1}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->access$handleAiMessage(Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 189
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1$1;->$terminalHandled:Ljava/util/concurrent/atomic/AtomicBoolean;

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1$1;->$questionId:Ljava/lang/String;

    const-string v2, "backend_error"

    invoke-static {v0, v1, v2}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->access$invokeSuspend$failIdentificationOnce(Ljava/util/concurrent/atomic/AtomicBoolean;Ljava/lang/String;Ljava/lang/String;)V

    .line 192
    :cond_0
    return-void
.end method
