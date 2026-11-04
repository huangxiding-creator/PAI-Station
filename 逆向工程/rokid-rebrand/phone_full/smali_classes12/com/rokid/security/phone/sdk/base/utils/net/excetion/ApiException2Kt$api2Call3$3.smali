.class final Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call3$3;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "ApiException2.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function3;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt;->api2Call3(Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function2;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
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
        "Lkotlin/Triple<",
        "+",
        "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
        "TT1;>;+",
        "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
        "TT2;>;+",
        "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
        "TT3;>;>;>;",
        "Ljava/lang/Throwable;",
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
        "\u0000\u001c\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0003\u0010\u0000\u001a\u00020\u0001\"\u0004\u0008\u0000\u0010\u0002\"\u0004\u0008\u0001\u0010\u0003\"\u0004\u0008\u0002\u0010\u0004*,\u0012(\u0012&\u0012\n\u0012\u0008\u0012\u0004\u0012\u0002H\u00020\u0007\u0012\n\u0012\u0008\u0012\u0004\u0012\u0002H\u00030\u0007\u0012\n\u0012\u0008\u0012\u0004\u0012\u0002H\u00040\u00070\u00060\u00052\u0006\u0010\u0008\u001a\u00020\tH\u008a@"
    }
    d2 = {
        "<anonymous>",
        "",
        "T1",
        "T2",
        "T3",
        "Lkotlinx/coroutines/flow/FlowCollector;",
        "Lkotlin/Triple;",
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
    c = "com.rokid.security.phone.sdk.base.utils.net.excetion.ApiException2Kt$api2Call3$3"
    f = "ApiException2.kt"
    i = {}
    l = {}
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $fail:Lkotlin/jvm/functions/Function2;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function2<",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $res:Lkotlin/jvm/internal/Ref$ObjectRef;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "TT1;>;>;"
        }
    .end annotation
.end field

.field synthetic L$0:Ljava/lang/Object;

.field label:I


# direct methods
.method constructor <init>(Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "TT1;>;>;",
            "Lkotlin/jvm/functions/Function2<",
            "-",
            "Ljava/lang/Integer;",
            "-",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call3$3;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call3$3;->$res:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call3$3;->$fail:Lkotlin/jvm/functions/Function2;

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

    invoke-virtual {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call3$3;->invoke(Lkotlinx/coroutines/flow/FlowCollector;Ljava/lang/Throwable;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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
            "Lkotlin/Triple<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "TT1;>;",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "TT2;>;",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "TT3;>;>;>;",
            "Ljava/lang/Throwable;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call3$3;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call3$3;->$res:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call3$3;->$fail:Lkotlin/jvm/functions/Function2;

    invoke-direct {v0, v1, v2, p3}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call3$3;-><init>(Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)V

    iput-object p2, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call3$3;->L$0:Ljava/lang/Object;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call3$3;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 5

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 251
    iget v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call3$3;->label:I

    packed-switch v0, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v0, p0

    .local v0, "this":Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call3$3;
    .local p1, "$result":Ljava/lang/Object;
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call3$3;->L$0:Ljava/lang/Object;

    check-cast v1, Ljava/lang/Throwable;

    .line 252
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

    .line 253
    iget-object v2, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call3$3;->$res:Lkotlin/jvm/internal/Ref$ObjectRef;

    sget-object v3, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2;->Companion:Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2$Companion;

    invoke-virtual {v3, v1}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2$Companion;->build(Ljava/lang/Throwable;)Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2;

    move-result-object v3

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2;->toResponse()Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;

    move-result-object v3

    iput-object v3, v2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 254
    iget-object v2, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call3$3;->$fail:Lkotlin/jvm/functions/Function2;

    iget-object v3, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call3$3;->$res:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v3, v3, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v3, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;->getCode()Ljava/lang/Integer;

    move-result-object v3

    iget-object v4, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call3$3;->$res:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v4, v4, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v4, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;->getMsg()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v2, v3, v4}, Lkotlin/jvm/functions/Function2;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 255
    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v2

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
