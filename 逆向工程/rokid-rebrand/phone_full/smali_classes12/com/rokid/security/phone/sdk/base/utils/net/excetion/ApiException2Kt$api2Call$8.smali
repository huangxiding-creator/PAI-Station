.class final Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$8;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "ApiException2.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function3;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt;->api2Call(Lkotlin/jvm/functions/Function0;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/coroutines/jvm/internal/SuspendLambda;",
        "Lkotlin/jvm/functions/Function3<",
        "Lkotlinx/coroutines/flow/FlowCollector<",
        "-",
        "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
        "TT;>;>;",
        "Ljava/lang/Throwable;",
        "Lkotlin/coroutines/Continuation<",
        "-",
        "Lkotlin/Unit;",
        ">;",
        "Ljava/lang/Object;",
        ">;"
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nApiException2.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ApiException2.kt\ncom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$8\n+ 2 IResult.kt\ncom/rokid/security/phone/sdk/base/data/callback/IResult$Companion\n*L\n1#1,322:1\n93#2:323\n*S KotlinDebug\n*F\n+ 1 ApiException2.kt\ncom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$8\n*L\n139#1:323\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0016\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0003\u0010\u0000\u001a\u00020\u0001\"\u0004\u0008\u0000\u0010\u0002*\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u0002H\u00020\u00040\u00032\u0006\u0010\u0005\u001a\u00020\u0006H\u008a@"
    }
    d2 = {
        "<anonymous>",
        "",
        "T",
        "Lkotlinx/coroutines/flow/FlowCollector;",
        "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;",
        "exception",
        ""
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
    c = "com.rokid.security.phone.sdk.base.utils.net.excetion.ApiException2Kt$api2Call$8"
    f = "ApiException2.kt"
    i = {}
    l = {}
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $res:Lkotlin/jvm/internal/Ref$ObjectRef;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "TT;>;>;"
        }
    .end annotation
.end field

.field final synthetic $result:Lkotlin/jvm/internal/Ref$ObjectRef;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "TT;>;>;"
        }
    .end annotation
.end field

.field synthetic L$0:Ljava/lang/Object;

.field label:I


# direct methods
.method constructor <init>(Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "TT;>;>;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "TT;>;>;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$8;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$8;->$res:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$8;->$result:Lkotlin/jvm/internal/Ref$ObjectRef;

    const/4 v0, 0x3

    invoke-direct {p0, v0, p3}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/flow/FlowCollector;

    check-cast p2, Ljava/lang/Throwable;

    check-cast p3, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$8;->invoke(Lkotlinx/coroutines/flow/FlowCollector;Ljava/lang/Throwable;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invoke(Lkotlinx/coroutines/flow/FlowCollector;Ljava/lang/Throwable;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlinx/coroutines/flow/FlowCollector<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "TT;>;>;",
            "Ljava/lang/Throwable;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$8;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$8;->$res:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$8;->$result:Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v0, v1, v2, p3}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$8;-><init>(Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/coroutines/Continuation;)V

    iput-object p2, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$8;->L$0:Ljava/lang/Object;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$8;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 9

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 133
    iget v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$8;->label:I

    packed-switch v0, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v0, p0

    .local v0, "this":Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$8;
    .local p1, "$result":Ljava/lang/Object;
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$8;->L$0:Ljava/lang/Object;

    check-cast v1, Ljava/lang/Throwable;

    .line 134
    .local v1, "exception":Ljava/lang/Throwable;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "request error: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    const-string v3, "ApiCaller"

    invoke-static {v3, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 135
    iget-object v2, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$8;->$res:Lkotlin/jvm/internal/Ref$ObjectRef;

    sget-object v3, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2;->Companion:Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2$Companion;

    invoke-virtual {v3, v1}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2$Companion;->build(Ljava/lang/Throwable;)Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2;

    move-result-object v3

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2;->toResponse()Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;

    move-result-object v3

    iput-object v3, v2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 136
    .end local v1    # "exception":Ljava/lang/Throwable;
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$8;->$res:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v1, v1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v1, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;->getCode()Ljava/lang/Integer;

    move-result-object v1

    if-nez v1, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    const/16 v2, 0x2712

    if-eq v1, v2, :cond_2

    :goto_0
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$8;->$res:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v1, v1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v1, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;->getCode()Ljava/lang/Integer;

    move-result-object v1

    if-nez v1, :cond_1

    goto :goto_1

    :cond_1
    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    .line 139
    :cond_2
    :goto_1
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$8;->$result:Lkotlin/jvm/internal/Ref$ObjectRef;

    sget-object v2, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->Companion:Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;

    new-instance v2, Lcom/rokid/security/phone/sdk/base/data/callback/IException;

    iget-object v3, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$8;->$res:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v3, v3, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v3, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;->getCode()Ljava/lang/Integer;

    move-result-object v3

    if-eqz v3, :cond_3

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    goto :goto_2

    :cond_3
    const/4 v3, -0x1

    :goto_2
    move v4, v3

    iget-object v3, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$8;->$res:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v3, v3, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v3, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;->getMsg()Ljava/lang/String;

    move-result-object v5

    const/4 v7, 0x4

    const/4 v8, 0x0

    const/4 v6, 0x0

    move-object v3, v2

    invoke-direct/range {v3 .. v8}, Lcom/rokid/security/phone/sdk/base/data/callback/IException;-><init>(ILjava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .local v2, "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    const/4 v3, 0x0

    .line 323
    .local v3, "$i$f$failure":I
    invoke-static {v2}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultKt;->createFailure(Lcom/rokid/security/phone/sdk/base/data/callback/IException;)Ljava/lang/Object;

    move-result-object v4

    invoke-static {v4}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 139
    .end local v2    # "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    .end local v3    # "$i$f$failure":I
    iput-object v2, v1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 140
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
