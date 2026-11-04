.class public final Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toProductRec$1$1;
.super Ljava/lang/Object;
.source "GAIChatServiceImpl.kt"

# interfaces
.implements Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toProductRec$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
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
        "com/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toProductRec$1$1",
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


# direct methods
.method constructor <init>()V
    .locals 0

    .line 355
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClosed()V
    .locals 3

    .line 376
    invoke-static {}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onClosed"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 377
    sget-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->access$sendChatContent(Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;Lcom/rokid/security/sdk/base/common/aichat/AiContent;Z)V

    .line 378
    return-void
.end method

.method public onComplete()V
    .locals 3

    .line 366
    invoke-static {}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onComplete"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 367
    sget-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->access$sendChatContent(Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;Lcom/rokid/security/sdk/base/common/aichat/AiContent;Z)V

    .line 368
    return-void
.end method

.method public onConnected()V
    .locals 2

    .line 357
    invoke-static {}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onConnected"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 358
    return-void
.end method

.method public onError(Ljava/lang/Throwable;)V
    .locals 3
    .param p1, "t"    # Ljava/lang/Throwable;

    const-string/jumbo v0, "t"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 371
    invoke-static {}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onError"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 372
    sget-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-static {v0, v1, v2, v1}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->sendError$default(Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;Ljava/lang/String;ILjava/lang/Object;)V

    .line 373
    return-void
.end method

.method public onMessage(Ljava/lang/String;)V
    .locals 3
    .param p1, "data"    # Ljava/lang/String;

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 361
    invoke-static {}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->access$getTAG$p()Ljava/lang/String;

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

    .line 362
    sget-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;

    invoke-static {v0, p1}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->access$handleAiMessage(Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;Ljava/lang/String;)V

    .line 363
    return-void
.end method
