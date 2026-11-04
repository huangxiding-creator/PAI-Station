.class final Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "GAIChatServiceImpl.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->toAiChat(Lcom/rokid/security/sdk/base/common/AiChatExtra;Z)V
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
    c = "com.rokid.security.sdk.ability.aichat.GAIChatServiceImpl$toAiChat$1"
    f = "GAIChatServiceImpl.kt"
    i = {}
    l = {
        0xe7
    }
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $aiChatParam:Lkotlin/jvm/internal/Ref$ObjectRef;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Lcom/rokid/security/sdk/ability/param/AiChatParam;",
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

.field label:I


# direct methods
.method constructor <init>(Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lcom/rokid/security/sdk/base/common/AiChatExtra;ZLkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Lcom/rokid/security/sdk/ability/param/AiChatParam;",
            ">;",
            "Lcom/rokid/security/sdk/base/common/AiChatExtra;",
            "Z",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;->$questionId:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p2, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;->$aiChatParam:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p3, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;->$extra:Lcom/rokid/security/sdk/base/common/AiChatExtra;

    iput-boolean p4, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;->$isCustom:Z

    iput-object p5, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;->$question:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p6, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;->$imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p7}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 9
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

    new-instance v8, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;->$questionId:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;->$aiChatParam:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v3, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;->$extra:Lcom/rokid/security/sdk/base/common/AiChatExtra;

    iget-boolean v4, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;->$isCustom:Z

    iget-object v5, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;->$question:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v6, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;->$imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;

    move-object v0, v8

    move-object v7, p2

    invoke-direct/range {v0 .. v7}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;-><init>(Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lcom/rokid/security/sdk/base/common/AiChatExtra;ZLkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/coroutines/Continuation;)V

    check-cast v8, Lkotlin/coroutines/Continuation;

    return-object v8
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 8

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 230
    iget v1, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;->label:I

    packed-switch v1, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    move-object v0, p0

    .local v0, "this":Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;
    .local p1, "$result":Ljava/lang/Object;
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v1, v0

    move-object v0, p1

    goto :goto_0

    .end local v0    # "this":Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_1
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v1, p0

    .line 231
    .local v1, "this":Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;
    .restart local p1    # "$result":Ljava/lang/Object;
    sget-object v2, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    move-object v3, v1

    check-cast v3, Lkotlin/coroutines/Continuation;

    const/4 v4, 0x1

    iput v4, v1, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;->label:I

    const-wide/16 v4, 0x3a98

    invoke-virtual {v2, v4, v5, v3}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->awaitAuthReady(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v2

    if-ne v2, v0, :cond_0

    .line 230
    return-object v0

    .line 231
    :cond_0
    move-object v0, p1

    move-object p1, v2

    .end local p1    # "$result":Ljava/lang/Object;
    .local v0, "$result":Ljava/lang/Object;
    :goto_0
    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    if-nez p1, :cond_1

    .line 232
    invoke-static {}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object p1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ai chat blocked: auth not ready state="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->getAuthState()Lkotlinx/coroutines/flow/MutableStateFlow;

    move-result-object v3

    invoke-interface {v3}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {p1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 233
    sget-object p1, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;

    iget-object v2, v1, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;->$questionId:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v2, v2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v2, Ljava/lang/String;

    invoke-static {p1, v2}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->access$sendError(Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;Ljava/lang/String;)V

    .line 234
    sget-object p1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object p1

    .line 236
    :cond_1
    new-instance p1, Lcom/google/gson/Gson;

    invoke-direct {p1}, Lcom/google/gson/Gson;-><init>()V

    iget-object v2, v1, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;->$aiChatParam:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v2, v2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    invoke-virtual {p1, v2}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    .line 237
    .local p1, "param":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;

    iget-object v3, v1, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;->$extra:Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getChatStreamVersion()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->access$resolveChatStreamVersion(Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 238
    .local v2, "streamVersion":Ljava/lang/String;
    iget-boolean v3, v1, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;->$isCustom:Z

    if-eqz v3, :cond_2

    .line 239
    sget-object v3, Lcom/rokid/security/sdk/ability/net/UrlConfig;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UrlConfig;

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/net/UrlConfig;->getGuiodeAichat()Ljava/lang/String;

    move-result-object v3

    goto :goto_1

    .line 241
    :cond_2
    sget-object v3, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;

    invoke-static {v3, v2}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->access$resolveChatStreamUrl(Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 238
    :goto_1
    nop

    .line 244
    .local v3, "url":Ljava/lang/String;
    invoke-static {}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v6, "toAiChat streamVersion="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " requested="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .end local v2    # "streamVersion":Ljava/lang/String;
    iget-object v5, v1, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;->$extra:Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-virtual {v5}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getChatStreamVersion()Ljava/lang/String;

    move-result-object v5

    if-nez v5, :cond_3

    const-string v5, ""

    :cond_3
    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v4, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 245
    sget-object v2, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->getMOkHttpSSEClient()Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    move-result-object v2

    .end local v3    # "url":Ljava/lang/String;
    .end local p1    # "param":Ljava/lang/String;
    if-eqz v2, :cond_4

    const-string v4, "param"

    invoke-static {p1, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v4, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1$1;

    iget-object v5, v1, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;->$question:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v6, v1, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;->$imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v7, v1, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1;->$questionId:Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v4, v5, v6, v7}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toAiChat$1$1;-><init>(Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;)V

    check-cast v4, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;

    .line 283
    nop

    .line 245
    const/4 v5, 0x2

    invoke-virtual {v2, v3, p1, v4, v5}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->getAiChat(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;I)V

    .line 285
    :cond_4
    sget-object p1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object p1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
