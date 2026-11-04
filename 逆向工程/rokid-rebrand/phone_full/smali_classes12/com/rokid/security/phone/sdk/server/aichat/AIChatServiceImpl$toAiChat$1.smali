.class final Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "AIChatServiceImpl.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->toAiChat(Lcom/rokid/security/sdk/base/common/AiChatExtra;Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/coroutines/jvm/internal/SuspendLambda;",
        "Lkotlin/jvm/functions/Function2<",
        "Lkotlinx/coroutines/CoroutineScope;",
        "Lkotlin/coroutines/Continuation<",
        "-",
        "Lkotlin/Unit;",
        ">;",
        "Ljava/lang/Object;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\n\n\u0000\n\u0002\u0010\u0002\n\u0002\u0018\u0002\u0010\u0000\u001a\u00020\u0001*\u00020\u0002H\u008a@"
    }
    d2 = {
        "<anonymous>",
        "",
        "Lkotlinx/coroutines/CoroutineScope;"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation

.annotation runtime Lkotlin/coroutines/jvm/internal/DebugMetadata;
    c = "com.rokid.security.phone.sdk.server.aichat.AIChatServiceImpl$toAiChat$1"
    f = "AIChatServiceImpl.kt"
    i = {}
    l = {}
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $aiChatParam:Lkotlin/jvm/internal/Ref$ObjectRef;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Lcom/rokid/security/phone/sdk/server/aichat/data/AiChatParam;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $extra:Lcom/rokid/security/sdk/base/common/AiChatExtra;

.field final synthetic $imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $isCustom:Z

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

.field label:I


# direct methods
.method constructor <init>(Lkotlin/jvm/internal/Ref$ObjectRef;Lcom/rokid/security/sdk/base/common/AiChatExtra;ZLkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Ljava/util/concurrent/atomic/AtomicBoolean;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Lcom/rokid/security/phone/sdk/server/aichat/data/AiChatParam;",
            ">;",
            "Lcom/rokid/security/sdk/base/common/AiChatExtra;",
            "Z",
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
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->$aiChatParam:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->$extra:Lcom/rokid/security/sdk/base/common/AiChatExtra;

    iput-boolean p3, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->$isCustom:Z

    iput-object p4, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->$question:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p5, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->$imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p6, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->$questionId:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p7, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->$terminalHandled:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p8}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method

.method public static final synthetic access$invokeSuspend$finishChatOnce(Ljava/util/concurrent/atomic/AtomicBoolean;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Ljava/lang/String;)V
    .locals 0

    invoke-static {p0, p1, p2, p3, p4}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->invokeSuspend$finishChatOnce(Ljava/util/concurrent/atomic/AtomicBoolean;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Ljava/lang/String;)V

    return-void
.end method

.method private static final invokeSuspend$finishChatOnce(Ljava/util/concurrent/atomic/AtomicBoolean;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Ljava/lang/String;)V
    .locals 8
    .param p0, "terminalHandled"    # Ljava/util/concurrent/atomic/AtomicBoolean;
    .param p1, "questionId"    # Lkotlin/jvm/internal/Ref$ObjectRef;
    .param p2, "question"    # Lkotlin/jvm/internal/Ref$ObjectRef;
    .param p3, "imageUrl"    # Lkotlin/jvm/internal/Ref$ObjectRef;
    .param p4, "source"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/concurrent/atomic/AtomicBoolean;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 451
    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-virtual {p0, v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-nez v0, :cond_0

    .line 452
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ignore duplicate terminal callback source="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " questionId="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v2, Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 453
    return-void

    .line 455
    :cond_0
    sget-object v2, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;

    .line 456
    iget-object v0, p2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    move-object v3, v0

    check-cast v3, Ljava/lang/String;

    .line 457
    iget-object v0, p3, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    move-object v4, v0

    check-cast v4, Ljava/lang/String;

    .line 458
    iget-object v0, p1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    move-object v5, v0

    check-cast v5, Ljava/lang/String;

    .line 459
    nop

    .line 460
    nop

    .line 455
    const/4 v6, 0x0

    const/4 v7, 0x1

    invoke-static/range {v2 .. v7}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->access$sendChatContent(Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;Z)V

    .line 462
    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            "Lkotlin/coroutines/Continuation<",
            "*>;)",
            "Lkotlin/coroutines/Continuation<",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation

    new-instance v9, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->$aiChatParam:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->$extra:Lcom/rokid/security/sdk/base/common/AiChatExtra;

    iget-boolean v3, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->$isCustom:Z

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->$question:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->$imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v6, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->$questionId:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v7, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->$terminalHandled:Ljava/util/concurrent/atomic/AtomicBoolean;

    move-object v0, v9

    move-object v8, p2

    invoke-direct/range {v0 .. v8}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;-><init>(Lkotlin/jvm/internal/Ref$ObjectRef;Lcom/rokid/security/sdk/base/common/AiChatExtra;ZLkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Ljava/util/concurrent/atomic/AtomicBoolean;Lkotlin/coroutines/Continuation;)V

    check-cast v9, Lkotlin/coroutines/Continuation;

    return-object v9
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlinx/coroutines/CoroutineScope;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 10

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 449
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->label:I

    packed-switch v0, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v0, p0

    .line 464
    .local v0, "this":Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;
    .local p1, "$result":Ljava/lang/Object;
    new-instance v1, Lcom/google/gson/Gson;

    invoke-direct {v1}, Lcom/google/gson/Gson;-><init>()V

    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->$aiChatParam:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v2, v2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    .line 465
    .local v5, "param":Ljava/lang/String;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;

    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->$extra:Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getChatStreamVersion()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->access$resolveRequestedChatStreamVersion(Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 466
    .local v1, "streamVersion":Ljava/lang/String;
    iget-boolean v2, v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->$isCustom:Z

    if-eqz v2, :cond_0

    .line 467
    sget-object v2, Lcom/rokid/security/sdk/ability/net/UrlConfig;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UrlConfig;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/net/UrlConfig;->getGuiodeAichat()Ljava/lang/String;

    move-result-object v2

    move-object v4, v2

    goto :goto_0

    .line 469
    :cond_0
    sget-object v2, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;

    invoke-static {v2, v1}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->access$resolveChatStreamUrl(Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    move-object v4, v2

    .line 466
    :goto_0
    nop

    .line 471
    .local v4, "url":Ljava/lang/String;
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v6, "toAiChat streamVersion="

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, " requested="

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .end local v1    # "streamVersion":Ljava/lang/String;
    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->$extra:Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getChatStreamVersion()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    const-string v3, ""

    :cond_1
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 472
    sget-object v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->getMOkHttpSSEClient()Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    move-result-object v3

    .end local v4    # "url":Ljava/lang/String;
    .end local v5    # "param":Ljava/lang/String;
    if-eqz v3, :cond_2

    const-string v1, "param"

    invoke-static {v5, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1$1;

    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->$question:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v6, v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->$imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v7, v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->$questionId:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v8, v0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1;->$terminalHandled:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v1, v2, v6, v7, v8}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$toAiChat$1$1;-><init>(Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Ljava/util/concurrent/atomic/AtomicBoolean;)V

    move-object v6, v1

    check-cast v6, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;

    const/16 v8, 0x8

    const/4 v9, 0x0

    const/4 v7, 0x0

    invoke-static/range {v3 .. v9}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->getAiChat$default(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;IILjava/lang/Object;)V

    .line 498
    :cond_2
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
