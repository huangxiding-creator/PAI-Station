.class public final Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1$1;
.super Ljava/lang/Object;
.source "GAIChatServiceImpl.kt"

# interfaces
.implements Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
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
        "com/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1$1",
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


# direct methods
.method constructor <init>(Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;)V
    .locals 0
    .param p1, "$question"    # Lkotlin/jvm/internal/Ref$ObjectRef;
    .param p2, "$imageUrl"    # Lkotlin/jvm/internal/Ref$ObjectRef;
    .param p3, "$questionId"    # Lkotlin/jvm/internal/Ref$ObjectRef;
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
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1$1;->$question:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p2, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1$1;->$imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p3, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1$1;->$questionId:Lkotlin/jvm/internal/Ref$ObjectRef;

    .line 245
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClosed()V
    .locals 9

    .line 273
    invoke-static {}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onClosed"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 274
    sget-object v2, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;

    .line 275
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1$1;->$question:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v0, v0, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    move-object v3, v0

    check-cast v3, Ljava/lang/String;

    .line 276
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1$1;->$imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v0, v0, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    move-object v4, v0

    check-cast v4, Ljava/lang/String;

    .line 277
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1$1;->$questionId:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v0, v0, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    move-object v5, v0

    check-cast v5, Ljava/lang/String;

    .line 278
    nop

    .line 279
    nop

    .line 280
    invoke-static {}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->access$getQuestionSessionIds$p()Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1$1;->$questionId:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v1, v1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    invoke-virtual {v0, v1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    move-object v8, v0

    check-cast v8, Ljava/lang/String;

    .line 274
    const/4 v6, 0x0

    const/4 v7, 0x1

    invoke-static/range {v2 .. v8}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->access$sendChatContent(Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;ZLjava/lang/String;)V

    .line 282
    return-void
.end method

.method public onComplete()V
    .locals 9

    .line 256
    invoke-static {}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onComplete"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 257
    sget-object v2, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;

    .line 258
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1$1;->$question:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v0, v0, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    move-object v3, v0

    check-cast v3, Ljava/lang/String;

    .line 259
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1$1;->$imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v0, v0, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    move-object v4, v0

    check-cast v4, Ljava/lang/String;

    .line 260
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1$1;->$questionId:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v0, v0, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    move-object v5, v0

    check-cast v5, Ljava/lang/String;

    .line 261
    nop

    .line 262
    nop

    .line 263
    invoke-static {}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->access$getQuestionSessionIds$p()Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1$1;->$questionId:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v1, v1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    invoke-virtual {v0, v1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    move-object v8, v0

    check-cast v8, Ljava/lang/String;

    .line 257
    const/4 v6, 0x0

    const/4 v7, 0x1

    invoke-static/range {v2 .. v8}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->access$sendChatContent(Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;ZLjava/lang/String;)V

    .line 265
    return-void
.end method

.method public onConnected()V
    .locals 2

    .line 247
    invoke-static {}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onConnected"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 248
    return-void
.end method

.method public onError(Ljava/lang/Throwable;)V
    .locals 2
    .param p1, "t"    # Ljava/lang/Throwable;

    const-string/jumbo v0, "t"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 268
    invoke-static {}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onError"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 269
    sget-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1$1;->$questionId:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v1, v1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v1, Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->access$sendError(Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;Ljava/lang/String;)V

    .line 270
    return-void
.end method

.method public onMessage(Ljava/lang/String;)V
    .locals 4
    .param p1, "data"    # Ljava/lang/String;

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 251
    sget-object v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1$1;->$question:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v1, v1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v1, Ljava/lang/String;

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1$1;->$imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v2, v2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v2, Ljava/lang/String;

    iget-object v3, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1$1;->$questionId:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v3, v3, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v3, Ljava/lang/String;

    invoke-static {v0, v1, v2, v3, p1}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->access$handleAiMessage(Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 253
    return-void
.end method
