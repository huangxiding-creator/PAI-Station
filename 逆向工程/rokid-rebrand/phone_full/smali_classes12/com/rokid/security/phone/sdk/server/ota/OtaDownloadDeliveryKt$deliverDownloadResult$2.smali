.class final Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "OtaDownloadDelivery.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt;->deliverDownloadResult(Lkotlinx/coroutines/CoroutineDispatcher;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;ILjava/lang/Long;Ljava/lang/Long;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
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
        "Ljava/lang/Throwable;",
        ">;",
        "Ljava/lang/Object;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\n\n\u0000\n\u0002\u0010\u0003\n\u0002\u0018\u0002\u0010\u0000\u001a\u0004\u0018\u00010\u0001*\u00020\u0002H\u008a@"
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
    c = "com.rokid.security.phone.sdk.server.ota.OtaDownloadDeliveryKt$deliverDownloadResult$2"
    f = "OtaDownloadDelivery.kt"
    i = {}
    l = {}
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $downloaded:Ljava/lang/Long;

.field final synthetic $listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

.field final synthetic $status:I

.field final synthetic $total:Ljava/lang/Long;

.field private synthetic L$0:Ljava/lang/Object;

.field label:I


# direct methods
.method constructor <init>(ILjava/lang/Long;Ljava/lang/Long;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/lang/Long;",
            "Ljava/lang/Long;",
            "Lcom/rokid/security/phone/sdk/api/base/DownloadListener;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;",
            ">;)V"
        }
    .end annotation

    iput p1, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;->$status:I

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;->$downloaded:Ljava/lang/Long;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;->$total:Ljava/lang/Long;

    iput-object p4, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;->$listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p5}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 7
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

    new-instance v6, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;

    iget v1, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;->$status:I

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;->$downloaded:Ljava/lang/Long;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;->$total:Ljava/lang/Long;

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;->$listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    move-object v0, v6

    move-object v5, p2

    invoke-direct/range {v0 .. v5}, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;-><init>(ILjava/lang/Long;Ljava/lang/Long;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;Lkotlin/coroutines/Continuation;)V

    iput-object p1, v6, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;->L$0:Ljava/lang/Object;

    check-cast v6, Lkotlin/coroutines/Continuation;

    return-object v6
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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
            "Ljava/lang/Throwable;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 11

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 27
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;->label:I

    packed-switch v0, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v0, p0

    .local v0, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;
    .local p1, "$result":Ljava/lang/Object;
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;->L$0:Ljava/lang/Object;

    check-cast v1, Lkotlinx/coroutines/CoroutineScope;

    .line 28
    .local v1, "$this$withContext":Lkotlinx/coroutines/CoroutineScope;
    new-instance v2, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v2}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    .line 29
    .local v2, "callbackFailure":Lkotlin/jvm/internal/Ref$ObjectRef;
    iget v3, v0, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;->$status:I

    const/4 v4, 0x1

    if-ne v3, v4, :cond_0

    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;->$downloaded:Ljava/lang/Long;

    if-eqz v3, :cond_0

    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;->$total:Ljava/lang/Long;

    if-eqz v3, :cond_0

    .line 30
    iget-object v4, v0, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;->$listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;->$downloaded:Ljava/lang/Long;

    iget-object v5, v0, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;->$total:Ljava/lang/Long;

    :try_start_0
    sget-object v6, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    const/4 v10, 0x0

    .line 31
    .local v10, "$i$a$-runCatching-OtaDownloadDeliveryKt$deliverDownloadResult$2$1":I
    invoke-virtual {v3}, Ljava/lang/Long;->longValue()J

    move-result-wide v6

    invoke-virtual {v5}, Ljava/lang/Long;->longValue()J

    move-result-wide v8

    const/16 v5, 0x64

    invoke-interface/range {v4 .. v9}, Lcom/rokid/security/phone/sdk/api/base/DownloadListener;->onProgress(IJJ)V

    .line 32
    nop

    .end local v10    # "$i$a$-runCatching-OtaDownloadDeliveryKt$deliverDownloadResult$2$1":I
    sget-object v3, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .line 30
    invoke-static {v3}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v3

    sget-object v4, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v3}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v3

    invoke-static {v3}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    .line 32
    :goto_0
    invoke-static {v3}, Lkotlin/Result;->exceptionOrNull-impl(Ljava/lang/Object;)Ljava/lang/Throwable;

    move-result-object v3

    if-eqz v3, :cond_0

    .local v3, "it":Ljava/lang/Throwable;
    const/4 v4, 0x0

    .line 33
    .local v4, "$i$a$-onFailure-OtaDownloadDeliveryKt$deliverDownloadResult$2$2":I
    iput-object v3, v2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 34
    nop

    .line 32
    .end local v3    # "it":Ljava/lang/Throwable;
    .end local v4    # "$i$a$-onFailure-OtaDownloadDeliveryKt$deliverDownloadResult$2$2":I
    nop

    .line 36
    :cond_0
    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;->$listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    iget v4, v0, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt$deliverDownloadResult$2;->$status:I

    .end local v1    # "$this$withContext":Lkotlinx/coroutines/CoroutineScope;
    :try_start_1
    sget-object v1, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    const/4 v1, 0x0

    .line 37
    .local v1, "$i$a$-runCatching-OtaDownloadDeliveryKt$deliverDownloadResult$2$3":I
    invoke-interface {v3, v4}, Lcom/rokid/security/phone/sdk/api/base/DownloadListener;->onResult(I)V

    .line 38
    nop

    .end local v1    # "$i$a$-runCatching-OtaDownloadDeliveryKt$deliverDownloadResult$2$3":I
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .line 36
    invoke-static {v1}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_1

    :catchall_1
    move-exception v1

    sget-object v3, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v1}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 38
    :goto_1
    invoke-static {v1}, Lkotlin/Result;->exceptionOrNull-impl(Ljava/lang/Object;)Ljava/lang/Throwable;

    move-result-object v1

    if-eqz v1, :cond_2

    .local v1, "it":Ljava/lang/Throwable;
    const/4 v3, 0x0

    .line 39
    .local v3, "$i$a$-onFailure-OtaDownloadDeliveryKt$deliverDownloadResult$2$4":I
    iget-object v4, v2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    if-nez v4, :cond_1

    iput-object v1, v2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 40
    .end local v1    # "it":Ljava/lang/Throwable;
    :cond_1
    nop

    .line 38
    .end local v3    # "$i$a$-onFailure-OtaDownloadDeliveryKt$deliverDownloadResult$2$4":I
    nop

    .line 41
    :cond_2
    iget-object v1, v2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    return-object v1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
