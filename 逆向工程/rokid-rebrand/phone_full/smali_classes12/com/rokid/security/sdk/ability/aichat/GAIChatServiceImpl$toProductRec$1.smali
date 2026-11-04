.class final Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toProductRec$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "GAIChatServiceImpl.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->toProductRec(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
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
    c = "com.rokid.security.sdk.ability.aichat.GAIChatServiceImpl$toProductRec$1"
    f = "GAIChatServiceImpl.kt"
    i = {}
    l = {
        0x15e
    }
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $param:Ljava/lang/String;

.field label:I


# direct methods
.method constructor <init>(Ljava/lang/String;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toProductRec$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toProductRec$1;->$param:Ljava/lang/String;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p2}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 2
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

    new-instance v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toProductRec$1;

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toProductRec$1;->$param:Ljava/lang/String;

    invoke-direct {v0, v1, p2}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toProductRec$1;-><init>(Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toProductRec$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toProductRec$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toProductRec$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toProductRec$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 7

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 349
    iget v1, p0, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toProductRec$1;->label:I

    const/4 v2, 0x1

    packed-switch v1, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    move-object v0, p0

    .local v0, "this":Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toProductRec$1;
    .local p1, "$result":Ljava/lang/Object;
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v1, v0

    move-object v0, p1

    goto :goto_0

    .end local v0    # "this":Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toProductRec$1;
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_1
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v1, p0

    .line 350
    .local v1, "this":Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toProductRec$1;
    .restart local p1    # "$result":Ljava/lang/Object;
    sget-object v3, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    move-object v4, v1

    check-cast v4, Lkotlin/coroutines/Continuation;

    iput v2, v1, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toProductRec$1;->label:I

    const-wide/16 v5, 0x3a98

    invoke-virtual {v3, v5, v6, v4}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->awaitAuthReady(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v3

    if-ne v3, v0, :cond_0

    .line 349
    return-object v0

    .line 350
    :cond_0
    move-object v0, p1

    move-object p1, v3

    .end local p1    # "$result":Ljava/lang/Object;
    .local v0, "$result":Ljava/lang/Object;
    :goto_0
    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    if-nez p1, :cond_1

    .line 351
    invoke-static {}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object p1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "product recognition blocked: auth not ready state="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->getAuthState()Lkotlinx/coroutines/flow/MutableStateFlow;

    move-result-object v4

    invoke-interface {v4}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {p1, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 352
    sget-object p1, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;

    const/4 v3, 0x0

    invoke-static {p1, v3, v2, v3}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->sendError$default(Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;Ljava/lang/String;ILjava/lang/Object;)V

    .line 353
    sget-object p1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object p1

    .line 355
    :cond_1
    sget-object p1, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;

    invoke-virtual {p1}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl;->getMOkHttpSSEClient()Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    move-result-object p1

    if-eqz p1, :cond_2

    sget-object v2, Lcom/rokid/security/sdk/ability/net/UrlConfig;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UrlConfig;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/net/UrlConfig;->getProducatRecUrl()Ljava/lang/String;

    move-result-object v2

    iget-object v3, v1, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toProductRec$1;->$param:Ljava/lang/String;

    const-string v4, "param"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v4, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toProductRec$1$1;

    invoke-direct {v4}, Lcom/rokid/security/sdk/ability/aichat/GAIChatServiceImpl$toProductRec$1$1;-><init>()V

    check-cast v4, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;

    .line 379
    nop

    .line 355
    const/4 v5, 0x2

    invoke-virtual {p1, v2, v3, v4, v5}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->getAiChat(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;I)V

    .line 380
    :cond_2
    sget-object p1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object p1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
