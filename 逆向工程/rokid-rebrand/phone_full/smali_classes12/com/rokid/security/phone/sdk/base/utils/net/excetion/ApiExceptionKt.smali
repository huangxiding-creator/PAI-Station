.class public final Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt;
.super Ljava/lang/Object;
.source "ApiException.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nApiException.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ApiException.kt\ncom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt\n+ 2 IResult.kt\ncom/rokid/security/phone/sdk/base/data/callback/IResult$Companion\n*L\n1#1,283:1\n93#2:284\n*S KotlinDebug\n*F\n+ 1 ApiException.kt\ncom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt\n*L\n131#1:284\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\\\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0006\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u001a:\u0010\u0002\u001a\u0008\u0012\u0004\u0012\u0002H\u00040\u0003\"\u0004\u0008\u0000\u0010\u00042\u0018\u0010\u0005\u001a\u0014\u0012\u0010\u0012\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u0002H\u00040\u00080\u00070\u0006H\u0086@\u00f8\u0001\u0000\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010\t\u001a\u0089\u0001\u0010\u0002\u001a\u00020\n\"\u0004\u0008\u0000\u0010\u00042\u0018\u0010\u0005\u001a\u0014\u0012\u0010\u0012\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u0002H\u00040\u00080\u00070\u00062<\u0008\u0002\u0010\u000b\u001a6\u0012\u0015\u0012\u0013\u0018\u00010\u0001\u00a2\u0006\u000c\u0008\r\u0012\u0008\u0008\u000e\u0012\u0004\u0008\u0008(\u000f\u0012\u0015\u0012\u0013\u0018\u00010\u0010\u00a2\u0006\u000c\u0008\r\u0012\u0008\u0008\u000e\u0012\u0004\u0008\u0008(\u0011\u0012\u0004\u0012\u00020\n0\u000c2\u0018\u0010\u0012\u001a\u0014\u0012\n\u0012\u0008\u0012\u0004\u0012\u0002H\u00040\u0008\u0012\u0004\u0012\u00020\n0\u0013H\u0086@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010\u0014\u001a\u008f\u0001\u0010\u0002\u001a\u00020\n\"\u0004\u0008\u0000\u0010\u00042\"\u0010\u0015\u001a\u001e\u0008\u0001\u0012\u0010\u0012\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u0002H\u00040\u00080\u0016\u0012\u0006\u0012\u0004\u0018\u00010\u00170\u00132<\u0008\u0002\u0010\u000b\u001a6\u0012\u0015\u0012\u0013\u0018\u00010\u0001\u00a2\u0006\u000c\u0008\r\u0012\u0008\u0008\u000e\u0012\u0004\u0008\u0008(\u000f\u0012\u0015\u0012\u0013\u0018\u00010\u0010\u00a2\u0006\u000c\u0008\r\u0012\u0008\u0008\u000e\u0012\u0004\u0008\u0008(\u0011\u0012\u0004\u0012\u00020\n0\u000c2\u0014\u0010\u0012\u001a\u0010\u0012\u0006\u0012\u0004\u0018\u0001H\u0004\u0012\u0004\u0012\u00020\n0\u0013H\u0086@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010\u0018\u001a\u00bb\u0001\u0010\u0019\u001a\u00020\n\"\u0004\u0008\u0000\u0010\u001a\"\u0004\u0008\u0001\u0010\u001b2\u0018\u0010\u001c\u001a\u0014\u0012\u0010\u0012\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u0002H\u001a0\u00080\u00070\u00062\u0018\u0010\u001d\u001a\u0014\u0012\u0010\u0012\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u0002H\u001b0\u00080\u00070\u00062<\u0008\u0002\u0010\u000b\u001a6\u0012\u0015\u0012\u0013\u0018\u00010\u0001\u00a2\u0006\u000c\u0008\r\u0012\u0008\u0008\u000e\u0012\u0004\u0008\u0008(\u000f\u0012\u0015\u0012\u0013\u0018\u00010\u0010\u00a2\u0006\u000c\u0008\r\u0012\u0008\u0008\u000e\u0012\u0004\u0008\u0008(\u0011\u0012\u0004\u0012\u00020\n0\u000c2*\u0010\u0012\u001a&\u0012\u001c\u0012\u001a\u0012\n\u0012\u0008\u0012\u0004\u0012\u0002H\u001a0\u0008\u0012\n\u0012\u0008\u0012\u0004\u0012\u0002H\u001b0\u00080\u001e\u0012\u0004\u0012\u00020\n0\u0013H\u0086@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010\u001f\u001a\u00e7\u0001\u0010 \u001a\u00020\n\"\u0004\u0008\u0000\u0010\u001a\"\u0004\u0008\u0001\u0010\u001b\"\u0004\u0008\u0002\u0010!2\u0018\u0010\u001c\u001a\u0014\u0012\u0010\u0012\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u0002H\u001a0\u00080\u00070\u00062\u0018\u0010\u001d\u001a\u0014\u0012\u0010\u0012\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u0002H\u001b0\u00080\u00070\u00062\u0018\u0010\"\u001a\u0014\u0012\u0010\u0012\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u0002H!0\u00080\u00070\u00062<\u0008\u0002\u0010\u000b\u001a6\u0012\u0015\u0012\u0013\u0018\u00010\u0001\u00a2\u0006\u000c\u0008\r\u0012\u0008\u0008\u000e\u0012\u0004\u0008\u0008(\u000f\u0012\u0015\u0012\u0013\u0018\u00010\u0010\u00a2\u0006\u000c\u0008\r\u0012\u0008\u0008\u000e\u0012\u0004\u0008\u0008(\u0011\u0012\u0004\u0012\u00020\n0\u000c26\u0010\u0012\u001a2\u0012(\u0012&\u0012\n\u0012\u0008\u0012\u0004\u0012\u0002H\u001a0\u0008\u0012\n\u0012\u0008\u0012\u0004\u0012\u0002H\u001b0\u0008\u0012\n\u0012\u0008\u0012\u0004\u0012\u0002H!0\u00080#\u0012\u0004\u0012\u00020\n0\u0013H\u0086@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010$\"\u000e\u0010\u0000\u001a\u00020\u0001X\u0086T\u00a2\u0006\u0002\n\u0000\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006%"
    }
    d2 = {
        "SUCCESS",
        "",
        "apiCall",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResult;",
        "T",
        "flow",
        "Lkotlin/Function0;",
        "Lkotlinx/coroutines/flow/Flow;",
        "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse;",
        "(Lkotlin/jvm/functions/Function0;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "",
        "fail",
        "Lkotlin/Function2;",
        "Lkotlin/ParameterName;",
        "name",
        "errorCode",
        "",
        "errorMessage",
        "success",
        "Lkotlin/Function1;",
        "(Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function2;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "call",
        "Lkotlin/coroutines/Continuation;",
        "",
        "(Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function2;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "apiCall2",
        "T1",
        "T2",
        "flow1",
        "flow2",
        "Lkotlin/Pair;",
        "(Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function2;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "apiCall3",
        "T3",
        "flow3",
        "Lkotlin/Triple;",
        "(Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function2;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "base-utils_release"
    }
    k = 0x2
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final SUCCESS:I = 0x1


# direct methods
.method public static final apiCall(Lkotlin/jvm/functions/Function0;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 11
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lkotlin/jvm/functions/Function0<",
            "+",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse<",
            "TT;>;>;>;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "+TT;>;>;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    instance-of v0, p1, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$7;

    if-eqz v0, :cond_0

    move-object v0, p1

    check-cast v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$7;

    iget v1, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$7;->label:I

    const/high16 v2, -0x80000000

    and-int/2addr v1, v2

    if-eqz v1, :cond_0

    iget p1, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$7;->label:I

    sub-int/2addr p1, v2

    iput p1, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$7;->label:I

    goto :goto_0

    :cond_0
    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$7;

    invoke-direct {v0, p1}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$7;-><init>(Lkotlin/coroutines/Continuation;)V

    :goto_0
    move-object p1, v0

    .local p1, "$continuation":Lkotlin/coroutines/Continuation;
    iget-object v0, p1, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$7;->result:Ljava/lang/Object;

    .local v0, "$result":Ljava/lang/Object;
    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v1

    .line 127
    iget v2, p1, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$7;->label:I

    packed-switch v2, :pswitch_data_0

    .end local v0    # "$result":Ljava/lang/Object;
    .end local p1    # "$continuation":Lkotlin/coroutines/Continuation;
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    .restart local v0    # "$result":Ljava/lang/Object;
    .restart local p1    # "$continuation":Lkotlin/coroutines/Continuation;
    :pswitch_0
    iget-object p0, p1, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$7;->L$0:Ljava/lang/Object;

    check-cast p0, Lkotlin/jvm/internal/Ref$ObjectRef;

    .local p0, "result":Lkotlin/jvm/internal/Ref$ObjectRef;
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto :goto_1

    .end local p0    # "result":Lkotlin/jvm/internal/Ref$ObjectRef;
    :pswitch_1
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    .line 130
    .local p0, "flow":Lkotlin/jvm/functions/Function0;
    new-instance v2, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v2}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    .line 131
    .local v2, "res":Lkotlin/jvm/internal/Ref$ObjectRef;
    new-instance v3, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v3}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    .local v3, "result":Lkotlin/jvm/internal/Ref$ObjectRef;
    sget-object v4, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->Companion:Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;

    new-instance v4, Lcom/rokid/security/phone/sdk/base/data/callback/IException;

    const/4 v9, 0x4

    const/4 v10, 0x0

    const/4 v6, -0x1

    const-string v7, "UnKnow"

    const/4 v8, 0x0

    move-object v5, v4

    invoke-direct/range {v5 .. v10}, Lcom/rokid/security/phone/sdk/base/data/callback/IException;-><init>(ILjava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .local v4, "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    const/4 v5, 0x0

    .line 284
    .local v5, "$i$f$failure":I
    invoke-static {v4}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultKt;->createFailure(Lcom/rokid/security/phone/sdk/base/data/callback/IException;)Ljava/lang/Object;

    move-result-object v6

    invoke-static {v6}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    .line 131
    .end local v4    # "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    .end local v5    # "$i$f$failure":I
    iput-object v4, v3, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 132
    invoke-interface {p0}, Lkotlin/jvm/functions/Function0;->invoke()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lkotlinx/coroutines/flow/Flow;

    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v5

    check-cast v5, Lkotlin/coroutines/CoroutineContext;

    invoke-static {v4, v5}, Lkotlinx/coroutines/flow/FlowKt;->flowOn(Lkotlinx/coroutines/flow/Flow;Lkotlin/coroutines/CoroutineContext;)Lkotlinx/coroutines/flow/Flow;

    move-result-object p0

    .line 133
    .end local p0    # "flow":Lkotlin/jvm/functions/Function0;
    new-instance v4, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$8;

    const/4 v5, 0x0

    invoke-direct {v4, v2, v3, v5}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$8;-><init>(Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/coroutines/Continuation;)V

    check-cast v4, Lkotlin/jvm/functions/Function3;

    invoke-static {p0, v4}, Lkotlinx/coroutines/flow/FlowKt;->catch(Lkotlinx/coroutines/flow/Flow;Lkotlin/jvm/functions/Function3;)Lkotlinx/coroutines/flow/Flow;

    move-result-object p0

    .line 140
    .end local v2    # "res":Lkotlin/jvm/internal/Ref$ObjectRef;
    new-instance v2, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$9;

    invoke-direct {v2, v5}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$9;-><init>(Lkotlin/coroutines/Continuation;)V

    check-cast v2, Lkotlin/jvm/functions/Function2;

    invoke-static {p0, v2}, Lkotlinx/coroutines/flow/FlowKt;->onStart(Lkotlinx/coroutines/flow/Flow;Lkotlin/jvm/functions/Function2;)Lkotlinx/coroutines/flow/Flow;

    move-result-object p0

    .line 142
    new-instance v2, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$10;

    invoke-direct {v2, v5}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$10;-><init>(Lkotlin/coroutines/Continuation;)V

    check-cast v2, Lkotlin/jvm/functions/Function3;

    invoke-static {p0, v2}, Lkotlinx/coroutines/flow/FlowKt;->onCompletion(Lkotlinx/coroutines/flow/Flow;Lkotlin/jvm/functions/Function3;)Lkotlinx/coroutines/flow/Flow;

    move-result-object p0

    .line 144
    new-instance v2, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$11;

    invoke-direct {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$11;-><init>(Lkotlin/jvm/internal/Ref$ObjectRef;)V

    check-cast v2, Lkotlinx/coroutines/flow/FlowCollector;

    iput-object v3, p1, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$7;->L$0:Ljava/lang/Object;

    const/4 v4, 0x1

    iput v4, p1, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$7;->label:I

    invoke-interface {p0, v2, p1}, Lkotlinx/coroutines/flow/Flow;->collect(Lkotlinx/coroutines/flow/FlowCollector;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p0

    if-ne p0, v1, :cond_1

    .line 127
    return-object v1

    .line 144
    :cond_1
    move-object p0, v3

    .line 159
    .end local v3    # "result":Lkotlin/jvm/internal/Ref$ObjectRef;
    .local p0, "result":Lkotlin/jvm/internal/Ref$ObjectRef;
    :goto_1
    iget-object v1, p0, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    return-object v1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public static final apiCall(Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function2;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 4
    .param p0, "flow"    # Lkotlin/jvm/functions/Function0;
    .param p1, "fail"    # Lkotlin/jvm/functions/Function2;
    .param p2, "success"    # Lkotlin/jvm/functions/Function1;
    .param p3, "$completion"    # Lkotlin/coroutines/Continuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lkotlin/jvm/functions/Function0<",
            "+",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse<",
            "TT;>;>;>;",
            "Lkotlin/jvm/functions/Function2<",
            "-",
            "Ljava/lang/Integer;",
            "-",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse<",
            "TT;>;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 104
    new-instance v0, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v0}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    .line 105
    .local v0, "res":Lkotlin/jvm/internal/Ref$ObjectRef;
    invoke-interface {p0}, Lkotlin/jvm/functions/Function0;->invoke()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lkotlinx/coroutines/flow/Flow;

    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v2

    check-cast v2, Lkotlin/coroutines/CoroutineContext;

    invoke-static {v1, v2}, Lkotlinx/coroutines/flow/FlowKt;->flowOn(Lkotlinx/coroutines/flow/Flow;Lkotlin/coroutines/CoroutineContext;)Lkotlinx/coroutines/flow/Flow;

    move-result-object v1

    .line 106
    new-instance v2, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$3;

    const/4 v3, 0x0

    invoke-direct {v2, v0, p1, v3}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$3;-><init>(Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)V

    check-cast v2, Lkotlin/jvm/functions/Function3;

    invoke-static {v1, v2}, Lkotlinx/coroutines/flow/FlowKt;->catch(Lkotlinx/coroutines/flow/Flow;Lkotlin/jvm/functions/Function3;)Lkotlinx/coroutines/flow/Flow;

    move-result-object v1

    .line 110
    new-instance v2, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$4;

    invoke-direct {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$4;-><init>(Lkotlin/coroutines/Continuation;)V

    check-cast v2, Lkotlin/jvm/functions/Function2;

    invoke-static {v1, v2}, Lkotlinx/coroutines/flow/FlowKt;->onStart(Lkotlinx/coroutines/flow/Flow;Lkotlin/jvm/functions/Function2;)Lkotlinx/coroutines/flow/Flow;

    move-result-object v1

    .line 112
    new-instance v2, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$5;

    invoke-direct {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$5;-><init>(Lkotlin/coroutines/Continuation;)V

    check-cast v2, Lkotlin/jvm/functions/Function3;

    invoke-static {v1, v2}, Lkotlinx/coroutines/flow/FlowKt;->onCompletion(Lkotlinx/coroutines/flow/Flow;Lkotlin/jvm/functions/Function3;)Lkotlinx/coroutines/flow/Flow;

    move-result-object v1

    .line 114
    new-instance v2, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$6;

    invoke-direct {v2, p2, p1}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$6;-><init>(Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function2;)V

    check-cast v2, Lkotlinx/coroutines/flow/FlowCollector;

    invoke-interface {v1, v2, p3}, Lkotlinx/coroutines/flow/Flow;->collect(Lkotlinx/coroutines/flow/FlowCollector;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v2

    if-ne v1, v2, :cond_0

    return-object v1

    :cond_0
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .line 121
    return-object v1
.end method

.method public static final apiCall(Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function2;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse<",
            "TT;>;>;+",
            "Ljava/lang/Object;",
            ">;",
            "Lkotlin/jvm/functions/Function2<",
            "-",
            "Ljava/lang/Integer;",
            "-",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/jvm/functions/Function1<",
            "-TT;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    instance-of v0, p3, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$12;

    if-eqz v0, :cond_0

    move-object v0, p3

    check-cast v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$12;

    iget v1, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$12;->label:I

    const/high16 v2, -0x80000000

    and-int/2addr v1, v2

    if-eqz v1, :cond_0

    iget p3, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$12;->label:I

    sub-int/2addr p3, v2

    iput p3, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$12;->label:I

    goto :goto_0

    :cond_0
    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$12;

    invoke-direct {v0, p3}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$12;-><init>(Lkotlin/coroutines/Continuation;)V

    :goto_0
    move-object p3, v0

    .local p3, "$continuation":Lkotlin/coroutines/Continuation;
    iget-object v0, p3, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$12;->result:Ljava/lang/Object;

    .local v0, "$result":Ljava/lang/Object;
    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v1

    .line 236
    iget v2, p3, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$12;->label:I

    const/4 v3, 0x1

    packed-switch v2, :pswitch_data_0

    .end local v0    # "$result":Ljava/lang/Object;
    .end local p3    # "$continuation":Lkotlin/coroutines/Continuation;
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    .restart local v0    # "$result":Ljava/lang/Object;
    .restart local p3    # "$continuation":Lkotlin/coroutines/Continuation;
    :pswitch_0
    iget-object p0, p3, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$12;->L$1:Ljava/lang/Object;

    check-cast p0, Lkotlin/jvm/functions/Function1;

    .local p0, "success":Lkotlin/jvm/functions/Function1;
    iget-object p1, p3, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$12;->L$0:Ljava/lang/Object;

    check-cast p1, Lkotlin/jvm/functions/Function2;

    .local p1, "fail":Lkotlin/jvm/functions/Function2;
    :try_start_0
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-object v2, v0

    goto :goto_1

    .line 244
    :catchall_0
    move-exception p2

    goto :goto_2

    .line 236
    .end local p0    # "success":Lkotlin/jvm/functions/Function1;
    .end local p1    # "fail":Lkotlin/jvm/functions/Function2;
    :pswitch_1
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    .line 242
    .local p0, "call":Lkotlin/jvm/functions/Function1;
    .restart local p1    # "fail":Lkotlin/jvm/functions/Function2;
    .local p2, "success":Lkotlin/jvm/functions/Function1;
    nop

    .line 243
    :try_start_1
    iput-object p1, p3, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$12;->L$0:Ljava/lang/Object;

    iput-object p2, p3, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$12;->L$1:Ljava/lang/Object;

    iput v3, p3, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$12;->label:I

    invoke-interface {p0, p3}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .end local p0    # "call":Lkotlin/jvm/functions/Function1;
    if-ne v2, v1, :cond_1

    .line 236
    return-object v1

    .line 243
    :cond_1
    move-object p0, p2

    .end local p2    # "success":Lkotlin/jvm/functions/Function1;
    .local p0, "success":Lkotlin/jvm/functions/Function1;
    :goto_1
    :try_start_2
    check-cast v2, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-object p2, v2

    .local p2, "result":Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse;
    goto :goto_3

    .line 244
    .end local p0    # "success":Lkotlin/jvm/functions/Function1;
    .local p2, "success":Lkotlin/jvm/functions/Function1;
    :catchall_1
    move-exception p0

    move-object v8, p2

    move-object p2, p0

    move-object p0, v8

    .line 245
    .restart local p0    # "success":Lkotlin/jvm/functions/Function1;
    .local p2, "e":Ljava/lang/Throwable;
    :goto_2
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "request error: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "ApiCaller"

    invoke-static {v2, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 246
    sget-object v1, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException;->Companion:Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException$Companion;

    invoke-virtual {v1, p2}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException$Companion;->build(Ljava/lang/Throwable;)Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException;

    move-result-object v1

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException;->toResponse()Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse;

    move-result-object v1

    move-object p2, v1

    .line 249
    .local p2, "result":Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse;
    :goto_3
    invoke-virtual {p2}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse;->getCode()Ljava/lang/Integer;

    move-result-object v1

    .line 250
    if-nez v1, :cond_2

    goto :goto_4

    :cond_2
    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    if-ne v1, v3, :cond_4

    .line 251
    .end local p1    # "fail":Lkotlin/jvm/functions/Function2;
    if-eqz p0, :cond_3

    invoke-virtual {p2}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse;->getData()Ljava/lang/Object;

    move-result-object p1

    invoke-interface {p0, p1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    nop

    .line 259
    .end local p0    # "success":Lkotlin/jvm/functions/Function1;
    :cond_3
    sget-object p0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object p0

    .line 255
    .restart local p1    # "fail":Lkotlin/jvm/functions/Function2;
    :cond_4
    :goto_4
    if-eqz p1, :cond_5

    invoke-virtual {p2}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse;->getCode()Ljava/lang/Integer;

    move-result-object p0

    invoke-virtual {p2}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse;->getMsg()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p1, p0, v1}, Lkotlin/jvm/functions/Function2;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    nop

    .line 256
    .end local p1    # "fail":Lkotlin/jvm/functions/Function2;
    :cond_5
    new-instance p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException;

    invoke-virtual {p2}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse;->getCode()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {p2}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse;->getMsg()Ljava/lang/String;

    move-result-object v4

    const/4 v6, 0x4

    const/4 v7, 0x0

    const/4 v5, 0x0

    move-object v2, p0

    invoke-direct/range {v2 .. v7}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException;-><init>(Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    throw p0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public static synthetic apiCall$default(Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function2;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;ILjava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 99
    and-int/lit8 p4, p4, 0x2

    if-eqz p4, :cond_0

    .line 101
    sget-object p1, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$2;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$2;

    check-cast p1, Lkotlin/jvm/functions/Function2;

    .line 99
    :cond_0
    invoke-static {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt;->apiCall(Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function2;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic apiCall$default(Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function2;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;ILjava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 236
    and-int/lit8 p4, p4, 0x2

    if-eqz p4, :cond_0

    .line 238
    sget-object p1, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$13;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall$13;

    check-cast p1, Lkotlin/jvm/functions/Function2;

    .line 236
    :cond_0
    invoke-static {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt;->apiCall(Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function2;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method public static final apiCall2(Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function2;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T1:",
            "Ljava/lang/Object;",
            "T2:",
            "Ljava/lang/Object;",
            ">(",
            "Lkotlin/jvm/functions/Function0<",
            "+",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse<",
            "TT1;>;>;>;",
            "Lkotlin/jvm/functions/Function0<",
            "+",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse<",
            "TT2;>;>;>;",
            "Lkotlin/jvm/functions/Function2<",
            "-",
            "Ljava/lang/Integer;",
            "-",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lkotlin/Pair<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse<",
            "TT1;>;",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse<",
            "TT2;>;>;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    instance-of v0, p4, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$1;

    if-eqz v0, :cond_0

    move-object v0, p4

    check-cast v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$1;

    iget v1, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$1;->label:I

    const/high16 v2, -0x80000000

    and-int/2addr v1, v2

    if-eqz v1, :cond_0

    iget p4, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$1;->label:I

    sub-int/2addr p4, v2

    iput p4, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$1;->label:I

    goto :goto_0

    :cond_0
    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$1;

    invoke-direct {v0, p4}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$1;-><init>(Lkotlin/coroutines/Continuation;)V

    :goto_0
    move-object p4, v0

    .local p4, "$continuation":Lkotlin/coroutines/Continuation;
    iget-object v0, p4, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$1;->result:Ljava/lang/Object;

    .local v0, "$result":Ljava/lang/Object;
    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v1

    .line 166
    iget v2, p4, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$1;->label:I

    packed-switch v2, :pswitch_data_0

    .end local v0    # "$result":Ljava/lang/Object;
    .end local p4    # "$continuation":Lkotlin/coroutines/Continuation;
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    .restart local v0    # "$result":Ljava/lang/Object;
    .restart local p4    # "$continuation":Lkotlin/coroutines/Continuation;
    :pswitch_0
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto/16 :goto_2

    :pswitch_1
    iget-object p0, p4, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$1;->L$2:Ljava/lang/Object;

    check-cast p0, Lkotlin/jvm/internal/Ref$ObjectRef;

    .local p0, "res":Lkotlin/jvm/internal/Ref$ObjectRef;
    iget-object p1, p4, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$1;->L$1:Ljava/lang/Object;

    check-cast p1, Lkotlin/jvm/functions/Function1;

    .local p1, "success":Lkotlin/jvm/functions/Function1;
    iget-object p2, p4, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$1;->L$0:Ljava/lang/Object;

    check-cast p2, Lkotlin/jvm/functions/Function2;

    .local p2, "fail":Lkotlin/jvm/functions/Function2;
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v2, p0

    move-object p0, v0

    goto :goto_1

    .end local p0    # "res":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local p1    # "success":Lkotlin/jvm/functions/Function1;
    .end local p2    # "fail":Lkotlin/jvm/functions/Function2;
    :pswitch_2
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    .line 172
    .local p0, "flow1":Lkotlin/jvm/functions/Function0;
    .local p1, "flow2":Lkotlin/jvm/functions/Function0;
    .restart local p2    # "fail":Lkotlin/jvm/functions/Function2;
    .local p3, "success":Lkotlin/jvm/functions/Function1;
    new-instance v2, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v2}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    .line 174
    .local v2, "res":Lkotlin/jvm/internal/Ref$ObjectRef;
    sget-object v3, Lcom/rokid/security/phone/sdk/base/utils/net/utils/FlowUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/net/utils/FlowUtils;

    invoke-interface {p0}, Lkotlin/jvm/functions/Function0;->invoke()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lkotlinx/coroutines/flow/Flow;

    invoke-interface {p1}, Lkotlin/jvm/functions/Function0;->invoke()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lkotlinx/coroutines/flow/Flow;

    iput-object p2, p4, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$1;->L$0:Ljava/lang/Object;

    iput-object p3, p4, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$1;->L$1:Ljava/lang/Object;

    iput-object v2, p4, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$1;->L$2:Ljava/lang/Object;

    const/4 v6, 0x1

    iput v6, p4, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$1;->label:I

    invoke-virtual {v3, v4, v5, p4}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/FlowUtils;->combineResults(Lkotlinx/coroutines/flow/Flow;Lkotlinx/coroutines/flow/Flow;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p0

    .end local p0    # "flow1":Lkotlin/jvm/functions/Function0;
    .end local p1    # "flow2":Lkotlin/jvm/functions/Function0;
    if-ne p0, v1, :cond_1

    .line 166
    return-object v1

    .line 174
    :cond_1
    move-object p1, p3

    .line 166
    .end local p3    # "success":Lkotlin/jvm/functions/Function1;
    .local p1, "success":Lkotlin/jvm/functions/Function1;
    :goto_1
    check-cast p0, Lkotlinx/coroutines/flow/Flow;

    .line 175
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object p3

    check-cast p3, Lkotlin/coroutines/CoroutineContext;

    invoke-static {p0, p3}, Lkotlinx/coroutines/flow/FlowKt;->flowOn(Lkotlinx/coroutines/flow/Flow;Lkotlin/coroutines/CoroutineContext;)Lkotlinx/coroutines/flow/Flow;

    move-result-object p0

    .line 176
    new-instance p3, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$3;

    const/4 v3, 0x0

    invoke-direct {p3, v2, p2, v3}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$3;-><init>(Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)V

    check-cast p3, Lkotlin/jvm/functions/Function3;

    invoke-static {p0, p3}, Lkotlinx/coroutines/flow/FlowKt;->catch(Lkotlinx/coroutines/flow/Flow;Lkotlin/jvm/functions/Function3;)Lkotlinx/coroutines/flow/Flow;

    move-result-object p0

    .line 180
    .end local v2    # "res":Lkotlin/jvm/internal/Ref$ObjectRef;
    new-instance p3, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$4;

    invoke-direct {p3, v3}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$4;-><init>(Lkotlin/coroutines/Continuation;)V

    check-cast p3, Lkotlin/jvm/functions/Function2;

    invoke-static {p0, p3}, Lkotlinx/coroutines/flow/FlowKt;->onStart(Lkotlinx/coroutines/flow/Flow;Lkotlin/jvm/functions/Function2;)Lkotlinx/coroutines/flow/Flow;

    move-result-object p0

    .line 182
    new-instance p3, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$5;

    invoke-direct {p3, v3}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$5;-><init>(Lkotlin/coroutines/Continuation;)V

    check-cast p3, Lkotlin/jvm/functions/Function3;

    invoke-static {p0, p3}, Lkotlinx/coroutines/flow/FlowKt;->onCompletion(Lkotlinx/coroutines/flow/Flow;Lkotlin/jvm/functions/Function3;)Lkotlinx/coroutines/flow/Flow;

    move-result-object p0

    .line 184
    new-instance p3, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$6;

    invoke-direct {p3, p1, p2}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$6;-><init>(Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function2;)V

    check-cast p3, Lkotlinx/coroutines/flow/FlowCollector;

    iput-object v3, p4, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$1;->L$0:Ljava/lang/Object;

    iput-object v3, p4, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$1;->L$1:Ljava/lang/Object;

    iput-object v3, p4, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$1;->L$2:Ljava/lang/Object;

    const/4 v2, 0x2

    iput v2, p4, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$1;->label:I

    invoke-interface {p0, p3, p4}, Lkotlinx/coroutines/flow/Flow;->collect(Lkotlinx/coroutines/flow/FlowCollector;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p0

    .end local p1    # "success":Lkotlin/jvm/functions/Function1;
    .end local p2    # "fail":Lkotlin/jvm/functions/Function2;
    if-ne p0, v1, :cond_2

    .line 166
    return-object v1

    .line 195
    :cond_2
    :goto_2
    sget-object p0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object p0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public static synthetic apiCall2$default(Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function2;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;ILjava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 166
    and-int/lit8 p5, p5, 0x4

    if-eqz p5, :cond_0

    .line 169
    sget-object p2, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$2;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall2$2;

    check-cast p2, Lkotlin/jvm/functions/Function2;

    .line 166
    :cond_0
    invoke-static {p0, p1, p2, p3, p4}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt;->apiCall2(Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function2;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method public static final apiCall3(Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function2;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T1:",
            "Ljava/lang/Object;",
            "T2:",
            "Ljava/lang/Object;",
            "T3:",
            "Ljava/lang/Object;",
            ">(",
            "Lkotlin/jvm/functions/Function0<",
            "+",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse<",
            "TT1;>;>;>;",
            "Lkotlin/jvm/functions/Function0<",
            "+",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse<",
            "TT2;>;>;>;",
            "Lkotlin/jvm/functions/Function0<",
            "+",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse<",
            "TT3;>;>;>;",
            "Lkotlin/jvm/functions/Function2<",
            "-",
            "Ljava/lang/Integer;",
            "-",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lkotlin/Triple<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse<",
            "TT1;>;",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse<",
            "TT2;>;",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse<",
            "TT3;>;>;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    instance-of v0, p5, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$1;

    if-eqz v0, :cond_0

    move-object v0, p5

    check-cast v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$1;

    iget v1, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$1;->label:I

    const/high16 v2, -0x80000000

    and-int/2addr v1, v2

    if-eqz v1, :cond_0

    iget p5, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$1;->label:I

    sub-int/2addr p5, v2

    iput p5, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$1;->label:I

    goto :goto_0

    :cond_0
    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$1;

    invoke-direct {v0, p5}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$1;-><init>(Lkotlin/coroutines/Continuation;)V

    :goto_0
    move-object p5, v0

    .local p5, "$continuation":Lkotlin/coroutines/Continuation;
    iget-object v0, p5, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$1;->result:Ljava/lang/Object;

    .local v0, "$result":Ljava/lang/Object;
    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v1

    .line 201
    iget v2, p5, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$1;->label:I

    packed-switch v2, :pswitch_data_0

    .end local v0    # "$result":Ljava/lang/Object;
    .end local p5    # "$continuation":Lkotlin/coroutines/Continuation;
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    .restart local v0    # "$result":Ljava/lang/Object;
    .restart local p5    # "$continuation":Lkotlin/coroutines/Continuation;
    :pswitch_0
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto/16 :goto_2

    :pswitch_1
    iget-object p0, p5, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$1;->L$2:Ljava/lang/Object;

    check-cast p0, Lkotlin/jvm/internal/Ref$ObjectRef;

    .local p0, "res":Lkotlin/jvm/internal/Ref$ObjectRef;
    iget-object p1, p5, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$1;->L$1:Ljava/lang/Object;

    check-cast p1, Lkotlin/jvm/functions/Function1;

    .local p1, "success":Lkotlin/jvm/functions/Function1;
    iget-object p2, p5, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$1;->L$0:Ljava/lang/Object;

    check-cast p2, Lkotlin/jvm/functions/Function2;

    .local p2, "fail":Lkotlin/jvm/functions/Function2;
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v2, p0

    move-object p0, v0

    goto :goto_1

    .end local p0    # "res":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local p1    # "success":Lkotlin/jvm/functions/Function1;
    .end local p2    # "fail":Lkotlin/jvm/functions/Function2;
    :pswitch_2
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    .line 208
    .local p0, "flow1":Lkotlin/jvm/functions/Function0;
    .local p1, "flow2":Lkotlin/jvm/functions/Function0;
    .local p2, "flow3":Lkotlin/jvm/functions/Function0;
    .local p3, "fail":Lkotlin/jvm/functions/Function2;
    .local p4, "success":Lkotlin/jvm/functions/Function1;
    new-instance v2, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v2}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    .line 210
    .local v2, "res":Lkotlin/jvm/internal/Ref$ObjectRef;
    sget-object v3, Lcom/rokid/security/phone/sdk/base/utils/net/utils/FlowUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/net/utils/FlowUtils;

    invoke-interface {p0}, Lkotlin/jvm/functions/Function0;->invoke()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lkotlinx/coroutines/flow/Flow;

    invoke-interface {p1}, Lkotlin/jvm/functions/Function0;->invoke()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lkotlinx/coroutines/flow/Flow;

    invoke-interface {p2}, Lkotlin/jvm/functions/Function0;->invoke()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lkotlinx/coroutines/flow/Flow;

    iput-object p3, p5, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$1;->L$0:Ljava/lang/Object;

    iput-object p4, p5, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$1;->L$1:Ljava/lang/Object;

    iput-object v2, p5, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$1;->L$2:Ljava/lang/Object;

    const/4 v7, 0x1

    iput v7, p5, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$1;->label:I

    invoke-virtual {v3, v4, v5, v6, p5}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/FlowUtils;->combineResults(Lkotlinx/coroutines/flow/Flow;Lkotlinx/coroutines/flow/Flow;Lkotlinx/coroutines/flow/Flow;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p0

    .end local p0    # "flow1":Lkotlin/jvm/functions/Function0;
    .end local p1    # "flow2":Lkotlin/jvm/functions/Function0;
    .end local p2    # "flow3":Lkotlin/jvm/functions/Function0;
    if-ne p0, v1, :cond_1

    .line 201
    return-object v1

    .line 210
    :cond_1
    move-object p2, p3

    move-object p1, p4

    .line 201
    .end local p3    # "fail":Lkotlin/jvm/functions/Function2;
    .end local p4    # "success":Lkotlin/jvm/functions/Function1;
    .local p1, "success":Lkotlin/jvm/functions/Function1;
    .local p2, "fail":Lkotlin/jvm/functions/Function2;
    :goto_1
    check-cast p0, Lkotlinx/coroutines/flow/Flow;

    .line 211
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object p3

    check-cast p3, Lkotlin/coroutines/CoroutineContext;

    invoke-static {p0, p3}, Lkotlinx/coroutines/flow/FlowKt;->flowOn(Lkotlinx/coroutines/flow/Flow;Lkotlin/coroutines/CoroutineContext;)Lkotlinx/coroutines/flow/Flow;

    move-result-object p0

    .line 212
    new-instance p3, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$3;

    const/4 p4, 0x0

    invoke-direct {p3, v2, p2, p4}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$3;-><init>(Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)V

    check-cast p3, Lkotlin/jvm/functions/Function3;

    invoke-static {p0, p3}, Lkotlinx/coroutines/flow/FlowKt;->catch(Lkotlinx/coroutines/flow/Flow;Lkotlin/jvm/functions/Function3;)Lkotlinx/coroutines/flow/Flow;

    move-result-object p0

    .line 216
    .end local v2    # "res":Lkotlin/jvm/internal/Ref$ObjectRef;
    new-instance p3, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$4;

    invoke-direct {p3, p4}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$4;-><init>(Lkotlin/coroutines/Continuation;)V

    check-cast p3, Lkotlin/jvm/functions/Function2;

    invoke-static {p0, p3}, Lkotlinx/coroutines/flow/FlowKt;->onStart(Lkotlinx/coroutines/flow/Flow;Lkotlin/jvm/functions/Function2;)Lkotlinx/coroutines/flow/Flow;

    move-result-object p0

    .line 218
    new-instance p3, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$5;

    invoke-direct {p3, p4}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$5;-><init>(Lkotlin/coroutines/Continuation;)V

    check-cast p3, Lkotlin/jvm/functions/Function3;

    invoke-static {p0, p3}, Lkotlinx/coroutines/flow/FlowKt;->onCompletion(Lkotlinx/coroutines/flow/Flow;Lkotlin/jvm/functions/Function3;)Lkotlinx/coroutines/flow/Flow;

    move-result-object p0

    .line 220
    new-instance p3, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$6;

    invoke-direct {p3, p1, p2}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$6;-><init>(Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function2;)V

    check-cast p3, Lkotlinx/coroutines/flow/FlowCollector;

    iput-object p4, p5, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$1;->L$0:Ljava/lang/Object;

    iput-object p4, p5, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$1;->L$1:Ljava/lang/Object;

    iput-object p4, p5, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$1;->L$2:Ljava/lang/Object;

    const/4 p4, 0x2

    iput p4, p5, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$1;->label:I

    invoke-interface {p0, p3, p5}, Lkotlinx/coroutines/flow/Flow;->collect(Lkotlinx/coroutines/flow/FlowCollector;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p0

    .end local p1    # "success":Lkotlin/jvm/functions/Function1;
    .end local p2    # "fail":Lkotlin/jvm/functions/Function2;
    if-ne p0, v1, :cond_2

    .line 201
    return-object v1

    .line 233
    :cond_2
    :goto_2
    sget-object p0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object p0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public static synthetic apiCall3$default(Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function2;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;ILjava/lang/Object;)Ljava/lang/Object;
    .locals 6

    .line 201
    and-int/lit8 p6, p6, 0x8

    if-eqz p6, :cond_0

    .line 205
    sget-object p3, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$2;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt$apiCall3$2;

    check-cast p3, Lkotlin/jvm/functions/Function2;

    move-object v3, p3

    goto :goto_0

    .line 201
    :cond_0
    move-object v3, p3

    :goto_0
    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v4, p4

    move-object v5, p5

    invoke-static/range {v0 .. v5}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiExceptionKt;->apiCall3(Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function2;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method
