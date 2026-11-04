.class final Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "AppMarketRequest.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest;->getAppListConfig(Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;)V
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
    c = "com.rokid.security.phone.sdk.server.market.AppMarketRequest$getAppListConfig$1"
    f = "AppMarketRequest.kt"
    i = {}
    l = {
        0x15,
        0x1a,
        0x20
    }
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $onFailure:Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function1<",
            "Ljava/lang/Throwable;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $onSuccess:Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function1<",
            "Lcom/rokid/security/sdk/base/common/market/AppData;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field label:I


# direct methods
.method constructor <init>(Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/sdk/base/common/market/AppData;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/Throwable;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;->$onSuccess:Lkotlin/jvm/functions/Function1;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;->$onFailure:Lkotlin/jvm/functions/Function1;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p3}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 3
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

    new-instance v0, Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;->$onSuccess:Lkotlin/jvm/functions/Function1;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;->$onFailure:Lkotlin/jvm/functions/Function1;

    invoke-direct {v0, v1, v2, p2}, Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;-><init>(Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 7

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 20
    iget v1, p0, Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;->label:I

    packed-switch v1, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    move-object v0, p0

    .local v0, "this":Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;
    .local p1, "$result":Ljava/lang/Object;
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto/16 :goto_3

    .end local v0    # "this":Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_1
    move-object v0, p0

    .restart local v0    # "this":Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;
    .restart local p1    # "$result":Ljava/lang/Object;
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto :goto_1

    .end local v0    # "this":Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_2
    move-object v1, p0

    .local v1, "this":Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;
    .restart local p1    # "$result":Ljava/lang/Object;
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v2, p1

    check-cast v2, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->unbox-impl()Ljava/lang/Object;

    move-result-object v2

    goto :goto_0

    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_3
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v1, p0

    .line 21
    .restart local v1    # "this":Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;
    .restart local p1    # "$result":Ljava/lang/Object;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1$ret$1;->INSTANCE:Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1$ret$1;

    check-cast v2, Lkotlin/jvm/functions/Function0;

    move-object v3, v1

    check-cast v3, Lkotlin/coroutines/Continuation;

    const/4 v4, 0x1

    iput v4, v1, Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;->label:I

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt;->api2Call(Lkotlin/jvm/functions/Function0;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v2

    if-ne v2, v0, :cond_0

    .line 20
    return-object v0

    .line 21
    :cond_0
    :goto_0
    nop

    .line 25
    .local v2, "ret":Ljava/lang/Object;
    invoke-static {v2}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->isSuccess-impl(Ljava/lang/Object;)Z

    move-result v3

    const/4 v4, 0x0

    if-eqz v3, :cond_2

    .line 26
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v3

    check-cast v3, Lkotlin/coroutines/CoroutineContext;

    new-instance v5, Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1$1;

    iget-object v6, v1, Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;->$onSuccess:Lkotlin/jvm/functions/Function1;

    invoke-direct {v5, v6, v2, v4}, Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1$1;-><init>(Lkotlin/jvm/functions/Function1;Ljava/lang/Object;Lkotlin/coroutines/Continuation;)V

    check-cast v5, Lkotlin/jvm/functions/Function2;

    move-object v4, v1

    check-cast v4, Lkotlin/coroutines/Continuation;

    const/4 v6, 0x2

    iput v6, v1, Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;->label:I

    invoke-static {v3, v5, v4}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v2

    .end local v2    # "ret":Ljava/lang/Object;
    if-ne v2, v0, :cond_1

    .line 20
    return-object v0

    .line 26
    :cond_1
    move-object v0, v1

    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;
    .restart local v0    # "this":Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;
    :goto_1
    goto :goto_4

    .line 31
    .end local v0    # "this":Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;
    .restart local v1    # "this":Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;
    .restart local v2    # "ret":Ljava/lang/Object;
    :cond_2
    new-instance v3, Ljava/lang/IllegalStateException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v6, "\u83b7\u53d6\u5e94\u7528\u5e02\u573a\u5217\u8868\u914d\u7f6e\u5931\u8d25\uff1a"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-static {v2}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->exceptionOrNull-impl(Ljava/lang/Object;)Lcom/rokid/security/phone/sdk/base/data/callback/IException;

    move-result-object v2

    .end local v2    # "ret":Ljava/lang/Object;
    if-eqz v2, :cond_3

    goto :goto_2

    :cond_3
    const-string/jumbo v2, "\u672a\u77e5\u9519\u8bef"

    :goto_2
    check-cast v2, Ljava/io/Serializable;

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v3, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .line 30
    move-object v2, v3

    .line 32
    .local v2, "exception":Ljava/lang/IllegalStateException;
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v3

    check-cast v3, Lkotlin/coroutines/CoroutineContext;

    new-instance v5, Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1$2;

    iget-object v6, v1, Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;->$onFailure:Lkotlin/jvm/functions/Function1;

    invoke-direct {v5, v6, v2, v4}, Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1$2;-><init>(Lkotlin/jvm/functions/Function1;Ljava/lang/IllegalStateException;Lkotlin/coroutines/Continuation;)V

    check-cast v5, Lkotlin/jvm/functions/Function2;

    move-object v4, v1

    check-cast v4, Lkotlin/coroutines/Continuation;

    const/4 v6, 0x3

    iput v6, v1, Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;->label:I

    invoke-static {v3, v5, v4}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v2

    .end local v2    # "exception":Ljava/lang/IllegalStateException;
    if-ne v2, v0, :cond_4

    .line 20
    return-object v0

    .line 32
    :cond_4
    move-object v0, v1

    .line 36
    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;
    .restart local v0    # "this":Lcom/rokid/security/phone/sdk/server/market/AppMarketRequest$getAppListConfig$1;
    :goto_3
    nop

    :goto_4
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
