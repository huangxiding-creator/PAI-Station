.class final Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "ResponseCallAdapter.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter;->adapt(Lretrofit2/Call;)Lkotlinx/coroutines/flow/Flow;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/coroutines/jvm/internal/SuspendLambda;",
        "Lkotlin/jvm/functions/Function2<",
        "Lkotlinx/coroutines/flow/FlowCollector<",
        "-",
        "Lretrofit2/Response<",
        "TT;>;>;",
        "Lkotlin/coroutines/Continuation<",
        "-",
        "Lkotlin/Unit;",
        ">;",
        "Ljava/lang/Object;",
        ">;"
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nResponseCallAdapter.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ResponseCallAdapter.kt\ncom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1\n+ 2 CancellableContinuation.kt\nkotlinx/coroutines/CancellableContinuationKt\n*L\n1#1,124:1\n314#2,11:125\n*S KotlinDebug\n*F\n+ 1 ResponseCallAdapter.kt\ncom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1\n*L\n28#1:125,11\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0010\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\u0010\u0000\u001a\u00020\u0001\"\u0004\u0008\u0000\u0010\u0002*\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u0002H\u00020\u00040\u0003H\u008a@"
    }
    d2 = {
        "<anonymous>",
        "",
        "T",
        "Lkotlinx/coroutines/flow/FlowCollector;",
        "Lretrofit2/Response;"
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
    c = "com.rokid.security.phone.sdk.base.utils.net.adapter.ResponseCallAdapter$adapt$1"
    f = "ResponseCallAdapter.kt"
    i = {}
    l = {
        0x7d,
        0x1b
    }
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $call:Lretrofit2/Call;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lretrofit2/Call<",
            "TT;>;"
        }
    .end annotation
.end field

.field private synthetic L$0:Ljava/lang/Object;

.field L$1:Ljava/lang/Object;

.field label:I


# direct methods
.method constructor <init>(Lretrofit2/Call;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lretrofit2/Call<",
            "TT;>;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;->$call:Lretrofit2/Call;

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

    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;->$call:Lretrofit2/Call;

    invoke-direct {v0, v1, p2}, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;-><init>(Lretrofit2/Call;Lkotlin/coroutines/Continuation;)V

    iput-object p1, v0, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;->L$0:Ljava/lang/Object;

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/flow/FlowCollector;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;->invoke(Lkotlinx/coroutines/flow/FlowCollector;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invoke(Lkotlinx/coroutines/flow/FlowCollector;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlinx/coroutines/flow/FlowCollector<",
            "-",
            "Lretrofit2/Response<",
            "TT;>;>;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 12

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 26
    iget v1, p0, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;->label:I

    packed-switch v1, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    move-object v0, p0

    .local v0, "this":Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;
    .local p1, "$result":Ljava/lang/Object;
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto/16 :goto_1

    .end local v0    # "this":Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_1
    move-object v1, p0

    .local v1, "this":Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;
    .restart local p1    # "$result":Ljava/lang/Object;
    const/4 v2, 0x0

    .local v2, "$i$f$suspendCancellableCoroutine":I
    iget-object v3, v1, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;->L$1:Ljava/lang/Object;

    check-cast v3, Lkotlinx/coroutines/flow/FlowCollector;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;->L$0:Ljava/lang/Object;

    check-cast v4, Lretrofit2/Call;

    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move v4, v2

    move-object v2, v1

    move-object v1, p1

    goto :goto_0

    .end local v1    # "this":Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;
    .end local v2    # "$i$f$suspendCancellableCoroutine":I
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_2
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v1, p0

    .restart local v1    # "this":Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;
    .restart local p1    # "$result":Ljava/lang/Object;
    iget-object v2, v1, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;->L$0:Ljava/lang/Object;

    move-object v3, v2

    check-cast v3, Lkotlinx/coroutines/flow/FlowCollector;

    .line 27
    .local v3, "$this$flow":Lkotlinx/coroutines/flow/FlowCollector;
    nop

    .line 28
    .end local v3    # "$this$flow":Lkotlinx/coroutines/flow/FlowCollector;
    iget-object v2, v1, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;->$call:Lretrofit2/Call;

    const/4 v4, 0x0

    .line 125
    .local v4, "$i$f$suspendCancellableCoroutine":I
    iput-object v2, v1, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;->L$0:Ljava/lang/Object;

    iput-object v3, v1, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;->L$1:Ljava/lang/Object;

    const/4 v5, 0x1

    iput v5, v1, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;->label:I

    move-object v6, v1

    check-cast v6, Lkotlin/coroutines/Continuation;

    .local v6, "uCont$iv":Lkotlin/coroutines/Continuation;
    const/4 v7, 0x0

    .line 126
    .local v7, "$i$a$-suspendCoroutineUninterceptedOrReturn-CancellableContinuationKt$suspendCancellableCoroutine$2$iv":I
    new-instance v8, Lkotlinx/coroutines/CancellableContinuationImpl;

    invoke-static {v6}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->intercepted(Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v9

    invoke-direct {v8, v9, v5}, Lkotlinx/coroutines/CancellableContinuationImpl;-><init>(Lkotlin/coroutines/Continuation;I)V

    move-object v5, v8

    .line 132
    .local v5, "cancellable$iv":Lkotlinx/coroutines/CancellableContinuationImpl;
    invoke-virtual {v5}, Lkotlinx/coroutines/CancellableContinuationImpl;->initCancellability()V

    .line 133
    move-object v8, v5

    check-cast v8, Lkotlinx/coroutines/CancellableContinuation;

    .local v8, "continuation":Lkotlinx/coroutines/CancellableContinuation;
    const/4 v9, 0x0

    .line 29
    .local v9, "$i$a$-suspendCancellableCoroutine-ResponseCallAdapter$adapt$1$1":I
    new-instance v10, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1$1$1;

    invoke-direct {v10, v8}, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1$1$1;-><init>(Lkotlinx/coroutines/CancellableContinuation;)V

    check-cast v10, Lretrofit2/Callback;

    invoke-interface {v2, v10}, Lretrofit2/Call;->enqueue(Lretrofit2/Callback;)V

    .line 38
    new-instance v10, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1$1$2;

    invoke-direct {v10, v2}, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1$1$2;-><init>(Lretrofit2/Call;)V

    check-cast v10, Lkotlin/jvm/functions/Function1;

    invoke-interface {v8, v10}, Lkotlinx/coroutines/CancellableContinuation;->invokeOnCancellation(Lkotlin/jvm/functions/Function1;)V

    .line 39
    nop

    .line 133
    .end local v8    # "continuation":Lkotlinx/coroutines/CancellableContinuation;
    .end local v9    # "$i$a$-suspendCancellableCoroutine-ResponseCallAdapter$adapt$1$1":I
    nop

    .line 134
    invoke-virtual {v5}, Lkotlinx/coroutines/CancellableContinuationImpl;->getResult()Ljava/lang/Object;

    move-result-object v2

    .line 125
    .end local v5    # "cancellable$iv":Lkotlinx/coroutines/CancellableContinuationImpl;
    .end local v6    # "uCont$iv":Lkotlin/coroutines/Continuation;
    .end local v7    # "$i$a$-suspendCoroutineUninterceptedOrReturn-CancellableContinuationKt$suspendCancellableCoroutine$2$iv":I
    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v5

    if-ne v2, v5, :cond_0

    move-object v5, v1

    check-cast v5, Lkotlin/coroutines/Continuation;

    invoke-static {v5}, Lkotlin/coroutines/jvm/internal/DebugProbesKt;->probeCoroutineSuspended(Lkotlin/coroutines/Continuation;)V

    :cond_0
    if-ne v2, v0, :cond_1

    .line 26
    return-object v0

    .line 125
    :cond_1
    move-object v11, v1

    move-object v1, p1

    move-object p1, v2

    move-object v2, v11

    .line 135
    .end local p1    # "$result":Ljava/lang/Object;
    .local v1, "$result":Ljava/lang/Object;
    .local v2, "this":Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;
    :goto_0
    nop

    .end local v4    # "$i$f$suspendCancellableCoroutine":I
    move-object v4, v2

    check-cast v4, Lkotlin/coroutines/Continuation;

    .line 27
    const/4 v5, 0x0

    iput-object v5, v2, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;->L$0:Ljava/lang/Object;

    iput-object v5, v2, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;->L$1:Ljava/lang/Object;

    const/4 v5, 0x2

    iput v5, v2, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;->label:I

    invoke-interface {v3, p1, v4}, Lkotlinx/coroutines/flow/FlowCollector;->emit(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p1

    if-ne p1, v0, :cond_2

    .line 26
    return-object v0

    .line 27
    :cond_2
    move-object p1, v1

    move-object v0, v2

    .line 41
    .end local v1    # "$result":Ljava/lang/Object;
    .end local v2    # "this":Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;
    .restart local v0    # "this":Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter$adapt$1;
    .restart local p1    # "$result":Ljava/lang/Object;
    :goto_1
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
