.class public final Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1$1;
.super Ljava/lang/Object;
.source "AIChatServiceImpl.kt"

# interfaces
.implements Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
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
        "com/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1$1",
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

.field final synthetic $question:Lkotlin/jvm/internal/Ref$ObjectRef;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $questionId:Lkotlin/jvm/internal/Ref$ObjectRef;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $terminalHandled:Ljava/util/concurrent/atomic/AtomicBoolean;


# direct methods
.method constructor <init>(Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Ljava/util/concurrent/atomic/AtomicBoolean;)V
    .locals 0
    .param p1, "$question"    # Lkotlin/jvm/internal/Ref$ObjectRef;
    .param p2, "$imageUrl"    # Lkotlin/jvm/internal/Ref$ObjectRef;
    .param p3, "$questionId"    # Lkotlin/jvm/internal/Ref$ObjectRef;
    .param p4, "$terminalHandled"    # Ljava/util/concurrent/atomic/AtomicBoolean;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/concurrent/atomic/AtomicBoolean;",
            ")V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1$1;->$question:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1$1;->$imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1$1;->$questionId:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p4, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1$1;->$terminalHandled:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 472
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClosed()V
    .locals 5

    .line 493
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onClosed"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 494
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1$1;->$terminalHandled:Ljava/util/concurrent/atomic/AtomicBoolean;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1$1;->$questionId:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1$1;->$question:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1$1;->$imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;

    const-string v4, "closed"

    invoke-static {v0, v1, v2, v3, v4}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->access$invokeSuspend$finishChatOnce(Ljava/util/concurrent/atomic/AtomicBoolean;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Ljava/lang/String;)V

    .line 495
    return-void
.end method

.method public onComplete()V
    .locals 5

    .line 483
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onComplete"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 484
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1$1;->$terminalHandled:Ljava/util/concurrent/atomic/AtomicBoolean;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1$1;->$questionId:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1$1;->$question:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1$1;->$imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;

    const-string v4, "complete"

    invoke-static {v0, v1, v2, v3, v4}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->access$invokeSuspend$finishChatOnce(Ljava/util/concurrent/atomic/AtomicBoolean;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Ljava/lang/String;)V

    .line 485
    return-void
.end method

.method public onConnected()V
    .locals 2

    .line 474
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onConnected"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 475
    return-void
.end method

.method public onError(Ljava/lang/Throwable;)V
    .locals 2
    .param p1, "t"    # Ljava/lang/Throwable;

    const-string/jumbo v0, "t"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 488
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onError"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 489
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->access$sendError(Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;)V

    .line 490
    return-void
.end method

.method public onMessage(Ljava/lang/String;)V
    .locals 4
    .param p1, "data"    # Ljava/lang/String;

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 478
    sget-object v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1$1;->$question:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v1, v1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v1, Ljava/lang/String;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1$1;->$imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v2, v2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v2, Ljava/lang/String;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1$1;->$questionId:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v3, v3, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v3, Ljava/lang/String;

    invoke-static {v0, v1, v2, v3, p1}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->access$handleAiMessage(Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 480
    return-void
.end method
