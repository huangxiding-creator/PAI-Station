.class final Lcom/rokid/security/phone/sdk/server/feature/BusinessEngineServiceImpl$getLauncherConfig$1$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "BusinessEngineServiceImpl.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/feature/BusinessEngineServiceImpl$getLauncherConfig$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
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
    value = "SMAP\nBusinessEngineServiceImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 BusinessEngineServiceImpl.kt\ncom/rokid/security/phone/sdk/server/feature/BusinessEngineServiceImpl$getLauncherConfig$1$1\n+ 2 IResult.kt\ncom/rokid/security/phone/sdk/base/data/callback/IResult\n*L\n1#1,64:1\n42#2,4:65\n*S KotlinDebug\n*F\n+ 1 BusinessEngineServiceImpl.kt\ncom/rokid/security/phone/sdk/server/feature/BusinessEngineServiceImpl$getLauncherConfig$1$1\n*L\n31#1:65,4\n*E\n"
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
    c = "com.rokid.security.phone.sdk.server.feature.BusinessEngineServiceImpl$getLauncherConfig$1$1"
    f = "BusinessEngineServiceImpl.kt"
    i = {}
    l = {}
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $onSuccess:Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function1<",
            "Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherRootBean;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $ret:Ljava/lang/Object;

.field label:I


# direct methods
.method constructor <init>(Lkotlin/jvm/functions/Function1;Ljava/lang/Object;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherRootBean;",
            "Lkotlin/Unit;",
            ">;",
            "Ljava/lang/Object;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/feature/BusinessEngineServiceImpl$getLauncherConfig$1$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/feature/BusinessEngineServiceImpl$getLauncherConfig$1$1;->$onSuccess:Lkotlin/jvm/functions/Function1;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/feature/BusinessEngineServiceImpl$getLauncherConfig$1$1;->$ret:Ljava/lang/Object;

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

    new-instance v0, Lcom/rokid/security/phone/sdk/server/feature/BusinessEngineServiceImpl$getLauncherConfig$1$1;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/feature/BusinessEngineServiceImpl$getLauncherConfig$1$1;->$onSuccess:Lkotlin/jvm/functions/Function1;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/feature/BusinessEngineServiceImpl$getLauncherConfig$1$1;->$ret:Ljava/lang/Object;

    invoke-direct {v0, v1, v2, p2}, Lcom/rokid/security/phone/sdk/server/feature/BusinessEngineServiceImpl$getLauncherConfig$1$1;-><init>(Lkotlin/jvm/functions/Function1;Ljava/lang/Object;Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/feature/BusinessEngineServiceImpl$getLauncherConfig$1$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/feature/BusinessEngineServiceImpl$getLauncherConfig$1$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/feature/BusinessEngineServiceImpl$getLauncherConfig$1$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/feature/BusinessEngineServiceImpl$getLauncherConfig$1$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 5

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 30
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/feature/BusinessEngineServiceImpl$getLauncherConfig$1$1;->label:I

    packed-switch v0, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v0, p0

    .line 31
    .local v0, "this":Lcom/rokid/security/phone/sdk/server/feature/BusinessEngineServiceImpl$getLauncherConfig$1$1;
    .local p1, "$result":Ljava/lang/Object;
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/feature/BusinessEngineServiceImpl$getLauncherConfig$1$1;->$onSuccess:Lkotlin/jvm/functions/Function1;

    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/feature/BusinessEngineServiceImpl$getLauncherConfig$1$1;->$ret:Ljava/lang/Object;

    .local v2, "arg0$iv":Ljava/lang/Object;
    const/4 v3, 0x0

    .line 65
    .local v3, "$i$f$getOrNull-impl":I
    nop

    .line 66
    invoke-static {v2}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->isFailure-impl(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    const/4 v4, 0x0

    move-object v2, v4

    goto :goto_0

    .line 67
    :cond_0
    nop

    .line 68
    .end local v2    # "arg0$iv":Ljava/lang/Object;
    :goto_0
    nop

    .line 31
    .end local v3    # "$i$f$getOrNull-impl":I
    invoke-interface {v1, v2}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 32
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
