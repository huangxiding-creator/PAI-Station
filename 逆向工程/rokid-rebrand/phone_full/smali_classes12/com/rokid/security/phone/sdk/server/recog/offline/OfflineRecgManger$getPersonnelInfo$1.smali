.class final Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelInfo$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "OfflineRecgManger.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->getPersonnelInfo(Ljava/lang/String;)V
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

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nOfflineRecgManger.kt\nKotlin\n*S Kotlin\n*F\n+ 1 OfflineRecgManger.kt\ncom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelInfo$1\n+ 2 IResult.kt\ncom/rokid/security/phone/sdk/base/data/callback/IResult\n*L\n1#1,361:1\n42#2,4:362\n*S KotlinDebug\n*F\n+ 1 OfflineRecgManger.kt\ncom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelInfo$1\n*L\n312#1:362,4\n*E\n"
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
    c = "com.rokid.security.phone.sdk.server.recog.offline.OfflineRecgManger$getPersonnelInfo$1"
    f = "OfflineRecgManger.kt"
    i = {}
    l = {
        0x136
    }
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $personnelId:Ljava/lang/String;

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
            "Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelInfo$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelInfo$1;->$personnelId:Ljava/lang/String;

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

    new-instance v0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelInfo$1;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelInfo$1;->$personnelId:Ljava/lang/String;

    invoke-direct {v0, v1, p2}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelInfo$1;-><init>(Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelInfo$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelInfo$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelInfo$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelInfo$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 9

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 309
    iget v1, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelInfo$1;->label:I

    const/4 v2, 0x1

    packed-switch v1, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    move-object v0, p0

    .local v0, "this":Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelInfo$1;
    .local p1, "$result":Ljava/lang/Object;
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v1, p1

    check-cast v1, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->unbox-impl()Ljava/lang/Object;

    move-result-object v1

    goto :goto_0

    .end local v0    # "this":Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelInfo$1;
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_1
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v1, p0

    .line 310
    .local v1, "this":Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelInfo$1;
    .restart local p1    # "$result":Ljava/lang/Object;
    new-instance v3, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelInfo$1$ret$1;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelInfo$1;->$personnelId:Ljava/lang/String;

    invoke-direct {v3, v4}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelInfo$1$ret$1;-><init>(Ljava/lang/String;)V

    check-cast v3, Lkotlin/jvm/functions/Function0;

    move-object v4, v1

    check-cast v4, Lkotlin/coroutines/Continuation;

    iput v2, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelInfo$1;->label:I

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt;->api2Call(Lkotlin/jvm/functions/Function0;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v3

    if-ne v3, v0, :cond_0

    .line 309
    return-object v0

    .line 310
    :cond_0
    move-object v0, v1

    move-object v1, v3

    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelInfo$1;
    .restart local v0    # "this":Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelInfo$1;
    :goto_0
    nop

    .line 311
    .local v1, "ret":Ljava/lang/Object;
    invoke-static {v1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->isSuccess-impl(Ljava/lang/Object;)Z

    move-result v3

    const/4 v4, 0x2

    const/4 v5, 0x0

    const-string v6, "OfflineRecgManger"

    const/4 v7, 0x0

    if-eqz v3, :cond_3

    .line 312
    const/4 v3, 0x0

    .line 362
    .local v3, "$i$f$getOrNull-impl":I
    nop

    .line 363
    invoke-static {v1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->isFailure-impl(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_1

    move-object v1, v7

    goto :goto_1

    .line 364
    :cond_1
    nop

    .line 365
    .end local v1    # "ret":Ljava/lang/Object;
    :goto_1
    nop

    .line 312
    .end local v3    # "$i$f$getOrNull-impl":I
    check-cast v1, Lcom/rokid/security/sdk/base/common/outside/PersonnelInfo;

    .line 313
    .local v1, "data":Lcom/rokid/security/sdk/base/common/outside/PersonnelInfo;
    if-eqz v1, :cond_2

    .line 314
    sget-object v3, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;

    invoke-static {v3, v2, v1}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->access$sendRequestPersonInfoResponse(Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;ZLcom/rokid/security/sdk/base/common/outside/PersonnelInfo;)V

    goto :goto_3

    .line 316
    :cond_2
    sget-object v2, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;

    invoke-static {v2, v5, v7, v4, v7}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->sendRequestPersonInfoResponse$default(Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;ZLcom/rokid/security/sdk/base/common/outside/PersonnelInfo;ILjava/lang/Object;)V

    .line 317
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getPersonnelInfo Fail - data = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const/16 v3, 0x20

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    .end local v1    # "data":Lcom/rokid/security/sdk/base/common/outside/PersonnelInfo;
    invoke-static {v6, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_3

    .line 321
    .local v1, "ret":Ljava/lang/Object;
    :cond_3
    nop

    .line 322
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getPersonnelInfo Fail - error message = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->exceptionOrNull-impl(Ljava/lang/Object;)Lcom/rokid/security/phone/sdk/base/data/callback/IException;

    move-result-object v1

    .end local v1    # "ret":Ljava/lang/Object;
    if-eqz v1, :cond_4

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/base/data/callback/IException;->getMessage()Ljava/lang/String;

    move-result-object v1

    goto :goto_2

    :cond_4
    move-object v1, v7

    :goto_2
    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    .line 320
    invoke-static {v6, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 324
    sget-object v1, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;

    invoke-static {v1, v5, v7, v4, v7}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->sendRequestPersonInfoResponse$default(Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;ZLcom/rokid/security/sdk/base/common/outside/PersonnelInfo;ILjava/lang/Object;)V

    .line 326
    :goto_3
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
