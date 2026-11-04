.class final Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$7;
.super Lkotlin/coroutines/jvm/internal/ContinuationImpl;
.source "ApiException2.kt"


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
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Lkotlin/coroutines/jvm/internal/ContinuationImpl;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation

.annotation runtime Lkotlin/coroutines/jvm/internal/DebugMetadata;
    c = "com.rokid.security.phone.sdk.base.utils.net.excetion.ApiException2Kt"
    f = "ApiException2.kt"
    i = {
        0x0
    }
    l = {
        0x90
    }
    m = "api2Call"
    n = {
        "result"
    }
    s = {
        "L$0"
    }
.end annotation


# instance fields
.field L$0:Ljava/lang/Object;

.field label:I

.field synthetic result:Ljava/lang/Object;


# direct methods
.method constructor <init>(Lkotlin/coroutines/Continuation;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$7;",
            ">;)V"
        }
    .end annotation

    invoke-direct {p0, p1}, Lkotlin/coroutines/jvm/internal/ContinuationImpl;-><init>(Lkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$7;->result:Ljava/lang/Object;

    iget v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$7;->label:I

    const/high16 v1, -0x80000000

    or-int/2addr v0, v1

    iput v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt$api2Call$7;->label:I

    const/4 v0, 0x0

    move-object v1, p0

    check-cast v1, Lkotlin/coroutines/Continuation;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt;->api2Call(Lkotlin/jvm/functions/Function0;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v1

    if-ne v0, v1, :cond_0

    return-object v0

    :cond_0
    invoke-static {v0}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->box-impl(Ljava/lang/Object;)Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    move-result-object v0

    return-object v0
.end method
